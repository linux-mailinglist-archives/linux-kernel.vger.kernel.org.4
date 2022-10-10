Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1250F5FA021
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiJJOXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJJOXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:23:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DE5719A3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665411792; x=1696947792;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MvoKKnOaQzWJzaWake7goHRiYLp5TOmATllrxpn0vjY=;
  b=nqo8gpJq3Ptpb1tIAwepUU79dXY+FfQyxCkY7RPKP+0w4shjMLWC/GbP
   +pF4Vk20tuKU4LYvLO52EGI4ogRVO/cO1OgJT+LUGPcs4IeZMlD4KaYDd
   zqirdh5xoykFgPs05QBFnat2H3NuyzzYoE8fmsin0rCD7rsL31t+lBiLG
   1w+jKflqBdMjiMyKhS6XVsnYVaUooycx5hll4JlnI2mTJsjoCYAkDZush
   IQu7BfH9jmbrMXFO79u7myJdEJF6OK5RrFUFNtpwCRwkP7FPn/h9yipQm
   9zkXH1H9DtUFDCrlr3ojygMB4h5yiRAs83RgqHI8bTxXtlmxVqh9Rl1I6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="302974772"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="302974772"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 07:23:11 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="688805855"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="688805855"
Received: from smajuta-mobl.amr.corp.intel.com (HELO [10.209.115.62]) ([10.209.115.62])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 07:23:11 -0700
Message-ID: <aff10f33-b379-6872-f180-b38f6a0a669a@intel.com>
Date:   Mon, 10 Oct 2022 07:23:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/tsc: Extend the watchdog check exemption to 4S/8S
 machine
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        tim.c.chen@intel.com, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yu Liao <liaoyu15@huawei.com>
References: <20221009051209.393377-1-feng.tang@intel.com>
 <Y0LGLGW7RSlklKyl@hirez.programming.kicks-ass.net>
 <Y0N0ENurfliW315D@feng-clx>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y0N0ENurfliW315D@feng-clx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/22 18:23, Feng Tang wrote:
>>> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
>>> index cafacb2e58cc..b4ea79cb1d1a 100644
>>> --- a/arch/x86/kernel/tsc.c
>>> +++ b/arch/x86/kernel/tsc.c
>>> @@ -1217,7 +1217,7 @@ static void __init check_system_tsc_reliable(void)
>>>  	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
>>>  	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
>>>  	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
>>> -	    nr_online_nodes <= 2)
>>> +	    nr_online_nodes <= 8)
>> So you're saying all 8 socket systems since Broadwell (?) are TSC
>> sync'ed ?
> No, I didn't mean that. I haven't got chance to any 8 sockets
> machine, and I got a report last month that on one 8S machine,
> the TSC was judged 'unstable' by HPET as watchdog.

That's not a great check.  Think about numa=fake=4U, for instance.  Or a
single-socket system with persistent memory and high bandwidth memory.

Basically 'nr_online_nodes' is a software construct.  It's going to be
really hard to infer anything from it about what the _hardware_ is.
