Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70308722EAD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 20:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbjFES2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 14:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbjFES2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 14:28:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC8BF1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 11:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685989673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pEDImlskmf4lUXu7kIuQV8p6jgfHeoxKzfgiGkdYXRM=;
        b=K+9q1LPCIUAU7vxb1zbw3DaWGgCSyTvonEvDice8xoUGAfFVoM3Ll4ghGT7F+lwrU7cL2K
        591v3lZSO4H/V+QDn9d8MLYo5cyQy2SNnM92bYzsINML0vNKA7ota4DfH3AGsLk0ssLBcV
        PZP1IUJS0vAO7YgA+ISSK7kn6bE7Nkk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-3mZOZ9PNOx2kCDcHBCB98w-1; Mon, 05 Jun 2023 14:27:48 -0400
X-MC-Unique: 3mZOZ9PNOx2kCDcHBCB98w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF30B85A5BE;
        Mon,  5 Jun 2023 18:27:47 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5727B7AE4;
        Mon,  5 Jun 2023 18:27:47 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 48D12400E71AD; Mon,  5 Jun 2023 15:14:25 -0300 (-03)
Date:   Mon, 5 Jun 2023 15:14:25 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 3/3] mm/vmstat: do not refresh stats for nohz_full CPUs
Message-ID: <ZH4mAbucXtK1PUON@tpad>
References: <20230602185757.110910188@redhat.com>
 <20230602190115.545766386@redhat.com>
 <ZH2V/QxDrq7aq5fY@dhcp22.suse.cz>
 <ZH4CnJlpBMxEEwPW@tpad>
 <ZH4JEVGdICubP0Du@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH4JEVGdICubP0Du@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 06:10:57PM +0200, Michal Hocko wrote:
> On Mon 05-06-23 12:43:24, Marcelo Tosatti wrote:
> > On Mon, Jun 05, 2023 at 09:59:57AM +0200, Michal Hocko wrote:
> > > On Fri 02-06-23 15:58:00, Marcelo Tosatti wrote:
> > > > The interruption caused by queueing work on nohz_full CPUs 
> > > > is undesirable for certain aplications.
> > > 
> > > This is not a proper changelog. I am not going to write a changelog for
> > > you this time. Please explain why this is really needed and why this
> > > approach is desired. 
> > > E.g. why don't you prevent userspace from
> > > refreshing stats if interference is not desirable.
> > 
> > Michal,
> > 
> > Can you please check if the following looks better, as
> > a changelog? thanks
> > 
> > ---
> > 
> > schedule_work_on API uses the workqueue mechanism to
> > queue a work item on a queue. A kernel thread, which
> > runs on the target CPU, executes those work items.
> > 
> > Therefore, when using the schedule_work_on API,
> > it is necessary for the kworker kernel thread to
> > be scheduled in, for the work function to be executed.
> > 
> > Time sensitive applications such as SoftPLCs
> > (https://tum-esi.github.io/publications-list/PDF/2022-ETFA-How_Real_Time_Are_Virtual_PLCs.pdf),
> > have their response times affected by such interruptions.
> > 
> > The /proc/sys/vm/stat_refresh file was originally introduced by
> > 
> > commit 52b6f46bc163eef17ecba4cd552beeafe2b24453
> > Author: Hugh Dickins <hughd@google.com>
> > Date:   Thu May 19 17:12:50 2016 -0700
> > 
> >     mm: /proc/sys/vm/stat_refresh to force vmstat update
> > 
> >     Provide /proc/sys/vm/stat_refresh to force an immediate update of
> >     per-cpu into global vmstats: useful to avoid a sleep(2) or whatever
> >     before checking counts when testing.  Originally added to work around a
> >     bug which left counts stranded indefinitely on a cpu going idle (an
> >     inaccuracy magnified when small below-batch numbers represent "huge"
> >     amounts of memory), but I believe that bug is now fixed: nonetheless,
> >     this is still a useful knob.
> 
> No need to quote the full changelog.
>  
> > Other than the potential interruption to a time sensitive application,
> > if using SCHED_FIFO or SCHED_RR priority on the isolated CPU, then
> > system hangs can occur:
> > 
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=978688
> 
> Confused... This report says that accessing the file (i.e. to force the
> refresh) can get stalled because high priority tasks will not allow
> kworkers to run. No?

Yes.

> There is simply no way around that unless those kworkers inherit the
> priority.

stalld is an attempt to workaround the situation by allowing the 
lower priority processes to execute for a small amount of time
(for example 20us every 1s). https://github.com/bristot/stalld:

"The stalld program (which stands for 'stall daemon') is a mechanism to
prevent the starvation of operating system threads in a Linux system.
The premise is to start up on a housekeeping cpu (one that is not used
for real-application purposes) and to periodically monitor the state of
each thread in the system, looking for a thread that has been on a run
queue (i.e. ready to run) for a specifed length of time without being
run. This condition is usually hit when the thread is on the same cpu
as a high-priority cpu-intensive task and therefore is being given no
opportunity to run.

When a thread is judged to be starving, stalld changes that thread to
use the SCHED_DEADLINE policy and gives the thread a small slice of time
for that cpu (specified on the command line). The thread then runs and
when that timeslice is used, the thread is then returned to its original
scheduling policy and stalld then continues to monitor thread states."

Unfortunately, if you allow that, then the latency sensitive
application might be interrupted for longer than acceptable
(which is the case for a certain class of applications, for example
SoftPLC inside a VM).

> It certainly is unfortunate that the call is not killable
> but being stuck behind real time busy looping processes is nothing
> really uncommong. One has to be really careful when using real time
> priorities.

Yes.

> > To avoid the problems above, do not schedule the work to synchronize
> > per-CPU mm counters on isolated CPUs. Given the possibility for
> > breaking existing userspace applications, avoid changing
> > behaviour of access to /proc/sys/vm/stat_refresh, such as
> > returning errors to userspace.
> 
> You are changing the behavior. The preexisting behavior was to flush
> everything. This is clearly changing that.

I meant that this patch does not cause read/write to the procfs file 
to return errors.

I believe returning errors has a higher potential for regressions
than not flushing per-CPU VM counters of isolated CPUs (which are
bounded).

> > ---
> > 
> > > Also would it make some sense to reduce flushing to cpumask 
> > > of the calling process? (certainly a daring thought but have
> > > you even considered it?)
> > 
> > Fail to see the point here ?
> 
> I mean that, if you already want to change the semantic of the call then
> it would likely be safer to change it in a more robust way and only
> flush pcp vmstat caches that are in the process effective cpu mask. 

That would change behaviour for systems without isolated CPUs.

> This
> way one can control which pcp caches to flush (e.g. those that are not
> on isolated CPUs or contrary those that are isolated but you can afford 
> to flush at the specific moment). See?

Yes, but not sure what to think of this idea. 

> Now I am not saying this is the right way to go because there is still a
> slim chance this will break userspace expectations. Therefore I have
> asked why you simply do not stop any random application accessing
> stat_refresh in the first place.

I think this is what should be done, but not on the current patchset.

https://lkml.iu.edu/hypermail/linux/kernel/2209.1/01263.html

Regarding housekeeping flags, it is usually the case that initialization might
require code execution on interference blocked CPUs (for example MTRR
initialization, resctrlfs initialization, MSR writes, ...). Therefore
tagging the CPUs after system initialization is necessary, which
is not possible with current housekeeping flags infrastructure.

>  These highly specialized setups with
> isolated resources shouldn't run arbitrary crap, should that?

Problem is that its hard to control what people run on a system.

> What if I just start allocating memory and get the system close to OOM. 

Sure, or "poweroff".

> I am
> pretty sure a small latency induced by the vmstat refreshes is the least
> problem you will have.

If OOM codepath sends no IPI or queues work on isolated CPUs, then OOM
should be fine.

> So please step back and try to think whether this is actually fixing
> anything real before trying to change a user visible interface.

It is fixing either a latency violation or a hang on a system where some user or
piece of software happens to run "sysctl -a" (or read vmstat_refresh).

If one is using CPU isolation, the latency violation has higher 
priority than vmstat_refresh returning proper counters.

