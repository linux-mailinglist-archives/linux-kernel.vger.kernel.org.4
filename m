Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFD7639975
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 07:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiK0Ggt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 01:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiK0Ggq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 01:36:46 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6781BDF8F;
        Sat, 26 Nov 2022 22:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669531004; x=1701067004;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j18kDwi3QaatD8jlibnN39tgtT/ATwnSdJDJnE/5veU=;
  b=naZw9Ge8a2oXQNfAxNoMJmaU0FD9BdKCnUilaErWD8gzDPdZz+hXn6Wg
   SnWsOAAB5fntDdqALlfT+xlEqcrqZBjC1imb+FdrYBqFHt6ou1sF5Bjr+
   sJ8UAxpJWfjGdHS7Mx/XjaLIDxFBOUziqg7hl6rohCpcS4jIDghM7W7Co
   qud3Wggktk5enO+FDhn7lHVneXlcvDz70oZ05q4e2YOY0rPPn5BtHy/2Q
   Blhr01Af8CSMosqL66pO26tFU4m1wI9xlp0BfzpzBjd4Wc/Obq2CtdxQv
   7uvtg3xgC0vTMO6QfBVknNgR1tYn0Gxkv4jo56Xiywi9GPMrHI8nvrbrQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="316473420"
X-IronPort-AV: E=Sophos;i="5.96,197,1665471600"; 
   d="scan'208";a="316473420"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 22:36:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="593550769"
X-IronPort-AV: E=Sophos;i="5.96,197,1665471600"; 
   d="scan'208";a="593550769"
Received: from liyi4-mobl1.ccr.corp.intel.com ([10.254.214.186])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 22:36:41 -0800
Message-ID: <876f3b51660b0e3e328c8f9d1ac3d4e14d749b0e.camel@intel.com>
Subject: Re: [RFC PATCH v4 0/2] cpuidle: teo: Introduce util-awareness
From:   Zhang Rui <rui.zhang@intel.com>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, yu.chen.surf@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        'Kajetan Puchalski' <kajetan.puchalski@arm.com>,
        rafael@kernel.org
Date:   Sun, 27 Nov 2022 14:36:39 +0800
In-Reply-To: <003d01d901e2$025853c0$0708fb40$@telus.net>
References: <20221102152808.2978590-1-kajetan.puchalski@arm.com>
         <Y3ttlCCezC+SvFDH@e126311.manchester.arm.com>
         <00a801d8ffba$6cd72a70$46857f50$@telus.net>
         <044424e924967a1c93649812b6e1670c8c37fce4.camel@intel.com>
         <003d01d901e2$025853c0$0708fb40$@telus.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-11-26 at 13:56 -0800, Doug Smythies wrote:
> On 2022.11.26 08:26 Rui wrote:
> > On Wed, 2022-11-23 at 20:08 -0800, Doug Smythies wrote:
> > > On 2022.11.21 04:23 Kajetan Puchalski wrote:
> > > > On Wed, Nov 02, 2022 at 03:28:06PM +0000, Kajetan Puchalski
> > > > wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > v3 -> v4:
> > > > > - remove the chunk of code skipping metrics updates when the
> > > > > CPU
> > > > > was utilized
> > > > > - include new test results and more benchmarks in the cover
> > > > > letter
> > > > 
> > > > [...]
> > > > 
> > > > It's been some time so I just wanted to bump this, what do you
> > > > think
> > > > about this v4? Doug has already tested it, resuls for his
> > > > machine
> > > > are
> > > > attached to the v3 thread.
> > > 
> > > Hi All,
> > > 
> > > I continued to test this and included the proposed ladder idle
> > > governor in my continued testing.
> > > (Which is why I added Rui as an addressee)
> > 
> > Hi, Doug,
> 
> Hi Rui,
> 
> > Really appreciated your testing data on this.
> > I have some dumb questions and I need your help so that I can
> > better
> > understand some of the graphs. :)
> > 
> > > However, I ran out of time. Here is what I have:
> > > 
> > > Kernel: 6.1-rc3 and with patch sets
> > > Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
> > > CPU scaling driver: intel_cpufreq
> > > HWP disabled.
> > > Unless otherwsie stated, performance CPU scaling govenor.
> > > 
> > > Legend:
> > > teo: the current teo idle governor
> > > util-v4: the RFC utilization teo patch set version 4.
> > > menu: the menu idle governor
> > > ladder-old: the current ladder idle governor
> > > ladder: the RFC ladder patchset.
> > > 
> > > Workflow: shell-intensive serialized workloads.
> > > Variable: PIDs per second.
> > > Note: Single threaded.
> > > Master reference: forced CPU affinity to 1 CPU.
> 
> This is the 1cpu on the graph.
> 
> > > Performance Results:
> > > http://smythies.com/~doug/linux/idle/teo-util/graphs/pids-perf.png
> > > Schedutil Results:
> > > http://smythies.com/~doug/linux/idle/teo-util/graphs/pids-su.png
> > 
> > what does 1cpu mean?
> 
> For shell-intensive serialized workflow or:
> 
> Dountil the list of tasks is finished:
>     Start the next task in the list of stuff to do (with a new PID).
>     Wait for it to finish
> Enduntil
> 
> We know it represents a challenge for CPU frequency scaling drivers,
> schedulers, and therefore idle drivers.
> 
> We also know that the best performance is achieved by overriding
> the scheduler and forcing CPU affinity. I use this "best" case as the
> master reference, using the label 1cpu on the graph.
>  
Got it.

> > > Workflow: sleeping ebizzy 128 threads.
> > > Variable: interval (uSecs).
> > > Performance Results:
> > > http://smythies.com/~doug/linux/idle/teo-util/graphs/ebizzy-128-perf.png
> > > Performance power and idle data:
> > > http://smythies.com/~doug/linux/idle/teo-util/ebizzy/perf/
> > 
> > for the "Idle state 0/1/2/3 was too deep" graphs, may I know how
> > you
> > assert that an idle state is too deep/shallow?
> 
> I get those stats directly from the kernel driver statistics. For
> example:
> 
> $ grep . /sys/devices/system/cpu/cpu4/cpuidle/state*/above
> /sys/devices/system/cpu/cpu4/cpuidle/state0/above:0
> /sys/devices/system/cpu/cpu4/cpuidle/state1/above:38085
> /sys/devices/system/cpu/cpu4/cpuidle/state2/above:7668
> /sys/devices/system/cpu/cpu4/cpuidle/state3/above:6823
> 
> $ grep . /sys/devices/system/cpu/cpu4/cpuidle/state*/below
> /sys/devices/system/cpu/cpu4/cpuidle/state0/below:72059
> /sys/devices/system/cpu/cpu4/cpuidle/state1/below:246573
> /sys/devices/system/cpu/cpu4/cpuidle/state2/below:7817
> /sys/devices/system/cpu/cpu4/cpuidle/state3/below:0
> 
> I keep track of the changes per sample interval and graph
> the sum for all CPUs as a percentage of the usage of
> that idle state.
> 
> Because I can never remember what "above" and "below"
> actually mean, I use the terms "was too shallow"
> and "was too deep".

I just checked the code. My understanding is that
"above" means the previous idle state residency is too short, and a
shallower state would have been a better match.
"below" means the previous idle state residency is too long, and a
deeper state would have been a better match.

So probably "above" means "should be shallower" or "was too deep", and
"below" means "should be deeper" or "was to shallow"?

thanks,
rui


