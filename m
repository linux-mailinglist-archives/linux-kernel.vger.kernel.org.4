Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE786A81D7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjCBMCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCBMCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:02:42 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDAD1C581;
        Thu,  2 Mar 2023 04:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677758561; x=1709294561;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qRnn8N3qEnPLW3FCyY/dBp3w9m26bLe2i0v5nSystnw=;
  b=WT2jRfxVS4Kltsj2RtNTFAWzdt0AyxMS9EH55j7l35Zqv2ZqjzPHHibP
   hJGw74FXfFRuvwgjgz1udnOLFTjlS/k5n8hz8sEqU6GBfHHbdVS59TS+o
   H1aC5qy2O809FDvBb0AWHLP85zt99fuj4KC7B33kEs/6Tl/90PUII0ft0
   icUclxVMvU+1w/R5VaTX6RK+IkFw0h0PdCJfaSFphNeJuVdtLEfOgoZMO
   +FKztmJdSW15fPetAGyAeRDT4f6sG6G7/NoUei7CtutrnpcVWXcdw2EIL
   8XT/7rY28+S8axSz1NEIgceQS0M72UAgtugKXfzyiSAtg3jEXTaf319Um
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420963073"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="420963073"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 04:02:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="763979032"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="763979032"
Received: from pplank-mobl1.ger.corp.intel.com (HELO [10.251.217.71]) ([10.251.217.71])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 04:02:39 -0800
Message-ID: <189d0e91-3216-edd0-b9b6-d2df3bb9618d@linux.intel.com>
Date:   Thu, 2 Mar 2023 14:02:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] trace/hwlat: Do not restart per-cpu threads if they are
 already running
Content-Language: en-US
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230302113654.2984709-1-tero.kristo@linux.intel.com>
 <92700518-46e3-88af-9be1-db18767754f5@kernel.org>
From:   Tero Kristo <tero.kristo@linux.intel.com>
In-Reply-To: <92700518-46e3-88af-9be1-db18767754f5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/03/2023 13:49, Daniel Bristot de Oliveira wrote:
> Hi Tero,
>
> On 3/2/23 08:36, Tero Kristo wrote:
>> Check if the hwlatd thread for the cpu is already running, before
>> starting a new one. This avoids running multiple instances of the same
>> CPU thread on the system. Also, do not wipe the contents of the
>> per-cpu kthread data when starting the tracer, as this can completely
>> forget about already running instances and start new additional per-cpu
>> threads. Fixes issues where fiddling with either the mode of the hwlat
>> tracer or doing cpu-hotplugs messes up the internal book-keeping
>> resulting in stale hwlatd threads.
> Thanks for your patch.
>
> Would you mind explaining how do you hit the problem? that is, how can
> I reproduce the same problem you faced.

For example, this script snippet reproduces it for me every time:

#!/bin/sh
cd /sys/kernel/debug/tracing
echo 0 > tracing_on
echo hwlat > current_tracer
echo per-cpu > hwlat_detector/mode
echo 100000 > hwlat_detector/width
echo 200000 > hwlat_detector/window
echo 200 > tracing_thresh
echo 1 > tracing_on

Another case where something wonky happens is if you offline/online a 
large number of CPUs (which takes a lot of time), and you start/disable 
the hwlat tracer at the same time.

-Tero


>
> I tried reproducing it by dispatching the hwlat tracer in two instances,
> but the system already blocks me...
>
> [root@vm tracing]# echo hwlat > current_tracer
> [root@vm tracing]# cd instances/
> [root@vm instances]# mkdir hwlat_2
> [root@vm instances]# cd hwlat_2/
> [root@vm hwlat_2]# echo hwlat > current_tracer
> -bash: echo: write error: Device or resource busy
>
> [root@vm hwlat_2]# cd ../../
> [root@vm tracing]# echo nop > current_tracer
> [root@vm tracing]# cd instances/hwlat_2/
> [root@vm hwlat_2]# echo hwlat > current_tracer
> [root@vm hwlat_2]# cd ..
> [root@vm instances]# mkdir hwlat_1
> [root@vm instances]# cd hwlat_1/
> [root@vm hwlat_1]# echo hwlat > current_tracer
> -bash: echo: write error: Device or resource busy
> [root@vm hwlat_1]#
>
> Having a reproducer helps us to think better about the problem.
>
> -- Daniel
>
>> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
>> ---
>>   kernel/trace/trace_hwlat.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
>> index d440ddd5fd8b..c4945f8adc11 100644
>> --- a/kernel/trace/trace_hwlat.c
>> +++ b/kernel/trace/trace_hwlat.c
>> @@ -492,6 +492,10 @@ static int start_cpu_kthread(unsigned int cpu)
>>   {
>>   	struct task_struct *kthread;
>>   
>> +	/* Do not start a new hwlatd thread if it is already running */
>> +	if (per_cpu(hwlat_per_cpu_data, cpu).kthread)
>> +		return 0;
>> +
>>   	kthread = kthread_run_on_cpu(kthread_fn, NULL, cpu, "hwlatd/%u");
>>   	if (IS_ERR(kthread)) {
>>   		pr_err(BANNER "could not start sampling thread\n");
>> @@ -584,9 +588,6 @@ static int start_per_cpu_kthreads(struct trace_array *tr)
>>   	 */
>>   	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
>>   
>> -	for_each_online_cpu(cpu)
>> -		per_cpu(hwlat_per_cpu_data, cpu).kthread = NULL;
>> -
>>   	for_each_cpu(cpu, current_mask) {
>>   		retval = start_cpu_kthread(cpu);
>>   		if (retval)
