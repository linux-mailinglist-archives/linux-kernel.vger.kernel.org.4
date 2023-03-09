Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD7C6B3211
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 00:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCIXbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 18:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjCIXbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 18:31:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D08F98ED;
        Thu,  9 Mar 2023 15:31:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D1FB61D1D;
        Thu,  9 Mar 2023 23:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D67C433D2;
        Thu,  9 Mar 2023 23:31:01 +0000 (UTC)
Date:   Thu, 9 Mar 2023 18:31:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] trace/hwlat: Do not restart per-cpu threads if they are
 already running
Message-ID: <20230309183100.624e200f@gandalf.local.home>
In-Reply-To: <189d0e91-3216-edd0-b9b6-d2df3bb9618d@linux.intel.com>
References: <20230302113654.2984709-1-tero.kristo@linux.intel.com>
        <92700518-46e3-88af-9be1-db18767754f5@kernel.org>
        <189d0e91-3216-edd0-b9b6-d2df3bb9618d@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2023 14:02:37 +0200
Tero Kristo <tero.kristo@linux.intel.com> wrote:

> Hi,
> 
> On 02/03/2023 13:49, Daniel Bristot de Oliveira wrote:
> > Hi Tero,
> >
> > On 3/2/23 08:36, Tero Kristo wrote:  
> >> Check if the hwlatd thread for the cpu is already running, before
> >> starting a new one. This avoids running multiple instances of the same
> >> CPU thread on the system. Also, do not wipe the contents of the
> >> per-cpu kthread data when starting the tracer, as this can completely
> >> forget about already running instances and start new additional per-cpu
> >> threads. Fixes issues where fiddling with either the mode of the hwlat
> >> tracer or doing cpu-hotplugs messes up the internal book-keeping
> >> resulting in stale hwlatd threads.  
> > Thanks for your patch.
> >
> > Would you mind explaining how do you hit the problem? that is, how can
> > I reproduce the same problem you faced.  
> 
> For example, this script snippet reproduces it for me every time:
> 
> #!/bin/sh
> cd /sys/kernel/debug/tracing
> echo 0 > tracing_on
> echo hwlat > current_tracer
> echo per-cpu > hwlat_detector/mode
> echo 100000 > hwlat_detector/width
> echo 200000 > hwlat_detector/window
> echo 200 > tracing_thresh
> echo 1 > tracing_on

I did the above and saw this:

 # ps aux | grep hwlat
root        1410 36.2  0.0      0     0 ?        R    18:10   0:22 [hwlatd/0]
root        1411 36.7  0.0      0     0 ?        R    18:10   0:22 [hwlatd/1]
root        1412 36.4  0.0      0     0 ?        R    18:10   0:22 [hwlatd/2]
root        1413 36.7  0.0      0     0 ?        R    18:10   0:22 [hwlatd/3]
root        1414 36.7  0.0      0     0 ?        R    18:10   0:22 [hwlatd/4]
root        1415 36.5  0.0      0     0 ?        R    18:10   0:22 [hwlatd/5]
root        1417 36.4  0.0      0     0 ?        R    18:10   0:22 [hwlatd/6]
root        1418 36.6  0.0      0     0 ?        S    18:10   0:22 [hwlatd/7]
root        1426 33.1  0.0      0     0 ?        R    18:10   0:11 [hwlatd/0]
root        1427 33.1  0.0      0     0 ?        R    18:10   0:11 [hwlatd/1]
root        1428 32.9  0.0      0     0 ?        R    18:10   0:11 [hwlatd/2]
root        1429 32.9  0.0      0     0 ?        R    18:10   0:11 [hwlatd/3]
root        1430 32.8  0.0      0     0 ?        R    18:10   0:11 [hwlatd/4]
root        1431 33.2  0.0      0     0 ?        R    18:10   0:11 [hwlatd/5]
root        1432 33.2  0.0      0     0 ?        R    18:10   0:11 [hwlatd/6]
root        1433 33.2  0.0      0     0 ?        S    18:10   0:11 [hwlatd/7]
root        1521  0.0  0.0   6332  2048 pts/0    S+   18:22   0:00 grep hwlat

Which I'm guessing is bad (having two of each hwlatd/#).

> 
> Another case where something wonky happens is if you offline/online a 
> large number of CPUs (which takes a lot of time), and you start/disable 
> the hwlat tracer at the same time.
> 

After applying the patch and running the same commands,  I have this:

 # ps aux | grep hwlat
root         768 40.7  0.0      0     0 ?        S    18:23   0:10 [hwlatd/0]
root         769 39.7  0.0      0     0 ?        R    18:23   0:10 [hwlatd/1]
root         770 39.8  0.0      0     0 ?        R    18:23   0:10 [hwlatd/2]
root         771 39.4  0.0      0     0 ?        R    18:23   0:10 [hwlatd/3]
root         772 40.5  0.0      0     0 ?        S    18:23   0:10 [hwlatd/4]
root         773 40.5  0.0      0     0 ?        R    18:23   0:10 [hwlatd/5]
root         775 41.0  0.0      0     0 ?        S    18:23   0:10 [hwlatd/6]
root         776 41.3  0.0      0     0 ?        R    18:23   0:10 [hwlatd/7]
root         781  0.0  0.0   6332  2048 pts/0    S+   18:25   0:00 grep hwlat

Looks as if this does fix the issue.

> >> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
> >> index d440ddd5fd8b..c4945f8adc11 100644
> >> --- a/kernel/trace/trace_hwlat.c
> >> +++ b/kernel/trace/trace_hwlat.c
> >> @@ -492,6 +492,10 @@ static int start_cpu_kthread(unsigned int cpu)
> >>   {
> >>   	struct task_struct *kthread;
> >>   
> >> +	/* Do not start a new hwlatd thread if it is already running */
> >> +	if (per_cpu(hwlat_per_cpu_data, cpu).kthread)
> >> +		return 0;
> >> +
> >>   	kthread = kthread_run_on_cpu(kthread_fn, NULL, cpu, "hwlatd/%u");
> >>   	if (IS_ERR(kthread)) {
> >>   		pr_err(BANNER "could not start sampling thread\n");
> >> @@ -584,9 +588,6 @@ static int start_per_cpu_kthreads(struct trace_array *tr)
> >>   	 */
> >>   	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
> >>   
> >> -	for_each_online_cpu(cpu)
> >> -		per_cpu(hwlat_per_cpu_data, cpu).kthread = NULL;
> >> -

I believe this is two different bugs (the two hunks). This should be two
patches.

Please add the reproducer above to the commit log in a v2.

Thanks,

-- Steve


> >>   	for_each_cpu(cpu, current_mask) {
> >>   		retval = start_cpu_kthread(cpu);
> >>   		if (retval)  
