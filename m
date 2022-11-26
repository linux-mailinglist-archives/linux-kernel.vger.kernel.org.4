Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA08639736
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 17:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiKZQ0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 11:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiKZQ0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 11:26:16 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B721839F;
        Sat, 26 Nov 2022 08:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669479975; x=1701015975;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8eZeTKPBojGM/CITb75Nuk8R9r4m+vSm8NfrxaGyxgM=;
  b=ht4xHuge7X+xE+RXDW7nkGYvODudU3seTZZm9IkJTBEj5Wx/2kwlHDmq
   g5ERUE4YRNkj6gw3PKVEyRWJRKx8bVDYfIB/J5WlQpZY9m/UufMgAfOMc
   Umf3mc07MrcgXT6e1s9tqfWyTuoiPe2naKjbzo9V8S3NVj/W3J/2RDbrn
   DO7ej/T849/95CiRu10a/fBJyUvPYN/1qIJcg6oO+HMO9VzclGFRp9WFS
   QMo5HLv2myjukSJrjCnqNwi+qJAHCLzgu+Q7QPFiCC1KNzb4fuCK+u94O
   mYF0udGCsqmb7XU0X4gYjH4AHi41hFPLllQpjXGONRV/N4AACBRgAQPsL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="314641700"
X-IronPort-AV: E=Sophos;i="5.96,196,1665471600"; 
   d="scan'208";a="314641700"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 08:26:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="817386218"
X-IronPort-AV: E=Sophos;i="5.96,196,1665471600"; 
   d="scan'208";a="817386218"
Received: from liyi4-mobl1.ccr.corp.intel.com ([10.254.214.186])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 08:26:11 -0800
Message-ID: <044424e924967a1c93649812b6e1670c8c37fce4.camel@intel.com>
Subject: Re: [RFC PATCH v4 0/2] cpuidle: teo: Introduce util-awareness
From:   Zhang Rui <rui.zhang@intel.com>
To:     Doug Smythies <dsmythies@telus.net>,
        'Kajetan Puchalski' <kajetan.puchalski@arm.com>,
        rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, yu.chen.surf@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 27 Nov 2022 00:26:09 +0800
In-Reply-To: <00a801d8ffba$6cd72a70$46857f50$@telus.net>
References: <20221102152808.2978590-1-kajetan.puchalski@arm.com>
         <Y3ttlCCezC+SvFDH@e126311.manchester.arm.com>
         <00a801d8ffba$6cd72a70$46857f50$@telus.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-11-23 at 20:08 -0800, Doug Smythies wrote:
> On 2022.11.21 04:23 Kajetan Puchalski wrote:
> 
> > Hi Rafael,
> > 
> > On Wed, Nov 02, 2022 at 03:28:06PM +0000, Kajetan Puchalski wrote:
> > 
> > [...]
> > 
> > > v3 -> v4:
> > > - remove the chunk of code skipping metrics updates when the CPU
> > > was utilized
> > > - include new test results and more benchmarks in the cover
> > > letter
> > 
> > [...]
> > 
> > It's been some time so I just wanted to bump this, what do you
> > think
> > about this v4? Doug has already tested it, resuls for his machine
> > are
> > attached to the v3 thread.
> 
> Hi All,
> 
> I continued to test this and included the proposed ladder idle
> governor in my continued testing.
> (Which is why I added Rui as an addressee)

Hi, Doug,

Really appreciated your testing data on this.
I have some dumb questions and I need your help so that I can better
understand some of the graphs. :)

> However, I ran out of time. Here is what I have:
> 
> Kernel: 6.1-rc3 and with patch sets
> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
> CPU scaling driver: intel_cpufreq
> HWP disabled.
> Unless otherwsie stated, performance CPU scaling govenor.
> 
> Legend:
> teo: the current teo idle governor
> util-v4: the RFC utilization teo patch set version 4.
> menu: the menu idle governor
> ladder-old: the current ladder idle governor
> ladder: the RFC ladder patchset.
> 
> Workflow: shell-intensive serialized workloads.
> Variable: PIDs per second.
> Note: Single threaded.
> Master reference: forced CPU affinity to 1 CPU.
> Performance Results:
> http://smythies.com/~doug/linux/idle/teo-util/graphs/pids-perf.png
> Schedutil Results:
> http://smythies.com/~doug/linux/idle/teo-util/graphs/pids-su.png

what does 1cpu mean?

> 
> Workflow: sleeping ebizzy 128 threads.
> Variable: interval (uSecs).
> Performance Results:
> http://smythies.com/~doug/linux/idle/teo-util/graphs/ebizzy-128-perf.png
> Performance power and idle data:
> http://smythies.com/~doug/linux/idle/teo-util/ebizzy/perf/

for the "Idle state 0/1/2/3 was too deep" graphs, may I know how you
assert that an idle state is too deep/shallow?

thanks,
rui

