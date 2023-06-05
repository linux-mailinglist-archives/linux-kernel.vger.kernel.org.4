Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18A5722F63
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbjFETMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjFETMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:12:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5192EEA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:12:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 09C701F8B9;
        Mon,  5 Jun 2023 19:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685992322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k/WCeb6nQ9KnYTv4azU+8E6KcmlRyjHqGg+CEki5Q00=;
        b=UvomcUPdo5ACLYHzSd2Vkaw+IWnFDU0HgCvB5geKVcNq6kl0HXdy+bBIvAQprxmSkwqDlp
        LdO1qRrgp6/5sb+BUnPOkSinSZwmsybiyQPQwX0ajvu4I3mDqynJykc+1ljl79+YNYSk5x
        9+eMbNZveyNQRqFmXL1MGzyNlRAHnN0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBAAD139C8;
        Mon,  5 Jun 2023 19:12:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WXjwMoEzfmQzYwAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 05 Jun 2023 19:12:01 +0000
Date:   Mon, 5 Jun 2023 21:12:01 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 3/3] mm/vmstat: do not refresh stats for nohz_full CPUs
Message-ID: <ZH4zgZZ8CS+rx+MV@dhcp22.suse.cz>
References: <20230602185757.110910188@redhat.com>
 <20230602190115.545766386@redhat.com>
 <ZH2V/QxDrq7aq5fY@dhcp22.suse.cz>
 <ZH4CnJlpBMxEEwPW@tpad>
 <ZH4JEVGdICubP0Du@dhcp22.suse.cz>
 <ZH4mAbucXtK1PUON@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH4mAbucXtK1PUON@tpad>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-06-23 15:14:25, Marcelo Tosatti wrote:
> On Mon, Jun 05, 2023 at 06:10:57PM +0200, Michal Hocko wrote:
> > On Mon 05-06-23 12:43:24, Marcelo Tosatti wrote:
> > > On Mon, Jun 05, 2023 at 09:59:57AM +0200, Michal Hocko wrote:
> > > > On Fri 02-06-23 15:58:00, Marcelo Tosatti wrote:
> > > > > The interruption caused by queueing work on nohz_full CPUs 
> > > > > is undesirable for certain aplications.
> > > > 
> > > > This is not a proper changelog. I am not going to write a changelog for
> > > > you this time. Please explain why this is really needed and why this
> > > > approach is desired. 
> > > > E.g. why don't you prevent userspace from
> > > > refreshing stats if interference is not desirable.
> > > 
> > > Michal,
> > > 
> > > Can you please check if the following looks better, as
> > > a changelog? thanks
> > > 
> > > ---
> > > 
> > > schedule_work_on API uses the workqueue mechanism to
> > > queue a work item on a queue. A kernel thread, which
> > > runs on the target CPU, executes those work items.
> > > 
> > > Therefore, when using the schedule_work_on API,
> > > it is necessary for the kworker kernel thread to
> > > be scheduled in, for the work function to be executed.
> > > 
> > > Time sensitive applications such as SoftPLCs
> > > (https://tum-esi.github.io/publications-list/PDF/2022-ETFA-How_Real_Time_Are_Virtual_PLCs.pdf),
> > > have their response times affected by such interruptions.
> > > 
> > > The /proc/sys/vm/stat_refresh file was originally introduced by
> > > 
> > > commit 52b6f46bc163eef17ecba4cd552beeafe2b24453
> > > Author: Hugh Dickins <hughd@google.com>
> > > Date:   Thu May 19 17:12:50 2016 -0700
> > > 
> > >     mm: /proc/sys/vm/stat_refresh to force vmstat update
> > > 
> > >     Provide /proc/sys/vm/stat_refresh to force an immediate update of
> > >     per-cpu into global vmstats: useful to avoid a sleep(2) or whatever
> > >     before checking counts when testing.  Originally added to work around a
> > >     bug which left counts stranded indefinitely on a cpu going idle (an
> > >     inaccuracy magnified when small below-batch numbers represent "huge"
> > >     amounts of memory), but I believe that bug is now fixed: nonetheless,
> > >     this is still a useful knob.
> > 
> > No need to quote the full changelog.
> >  
> > > Other than the potential interruption to a time sensitive application,
> > > if using SCHED_FIFO or SCHED_RR priority on the isolated CPU, then
> > > system hangs can occur:
> > > 
> > > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=978688
> > 
> > Confused... This report says that accessing the file (i.e. to force the
> > refresh) can get stalled because high priority tasks will not allow
> > kworkers to run. No?
> 
> Yes.
> 
> > There is simply no way around that unless those kworkers inherit the
> > priority.
> 
> stalld is an attempt to workaround the situation by allowing the 
> lower priority processes to execute for a small amount of time
> (for example 20us every 1s). https://github.com/bristot/stalld:
> 
> "The stalld program (which stands for 'stall daemon') is a mechanism to
> prevent the starvation of operating system threads in a Linux system.
> The premise is to start up on a housekeeping cpu (one that is not used
> for real-application purposes) and to periodically monitor the state of
> each thread in the system, looking for a thread that has been on a run
> queue (i.e. ready to run) for a specifed length of time without being
> run. This condition is usually hit when the thread is on the same cpu
> as a high-priority cpu-intensive task and therefore is being given no
> opportunity to run.
>
> When a thread is judged to be starving, stalld changes that thread to
> use the SCHED_DEADLINE policy and gives the thread a small slice of time
> for that cpu (specified on the command line). The thread then runs and
> when that timeslice is used, the thread is then returned to its original
> scheduling policy and stalld then continues to monitor thread states."

But your task is not on rq. It is sleeping and waiting for completion so
I fail to see how this all is related. The problem is that the userspace
depends on kernel WQ to complete. There quite some operations that will
behave like that.
 
> Unfortunately, if you allow that, then the latency sensitive
> application might be interrupted for longer than acceptable
> (which is the case for a certain class of applications, for example
> SoftPLC inside a VM).

I am losing you again. You can either have top priority processes
running uninterrupted or or latency sensitive running with your SLAs.
Even if you apply this patch you cannot protect your sensitive
application from CPU top prio hogs. You either have your process
priorities configured properly or not. I really fail to follow your line
of arguments here.

> > It certainly is unfortunate that the call is not killable
> > but being stuck behind real time busy looping processes is nothing
> > really uncommong. One has to be really careful when using real time
> > priorities.
> 
> Yes.
> 
> > > To avoid the problems above, do not schedule the work to synchronize
> > > per-CPU mm counters on isolated CPUs. Given the possibility for
> > > breaking existing userspace applications, avoid changing
> > > behaviour of access to /proc/sys/vm/stat_refresh, such as
> > > returning errors to userspace.
> > 
> > You are changing the behavior. The preexisting behavior was to flush
> > everything. This is clearly changing that.
> 
> I meant that this patch does not cause read/write to the procfs file 
> to return errors.
> 
> I believe returning errors has a higher potential for regressions
> than not flushing per-CPU VM counters of isolated CPUs (which are
> bounded).

Silent change of behavior is even worse because you cannot really tell a
difference.

> > > > Also would it make some sense to reduce flushing to cpumask 
> > > > of the calling process? (certainly a daring thought but have
> > > > you even considered it?)
> > > 
> > > Fail to see the point here ?
> > 
> > I mean that, if you already want to change the semantic of the call then
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > it would likely be safer to change it in a more robust way and only
> > flush pcp vmstat caches that are in the process effective cpu mask. 
> 
> That would change behaviour for systems without isolated CPUs.

yes, see above.

> > This
> > way one can control which pcp caches to flush (e.g. those that are not
> > on isolated CPUs or contrary those that are isolated but you can afford 
> > to flush at the specific moment). See?
> 
> Yes, but not sure what to think of this idea. 

If you want to break something, at least make the change kinda more
generic than, magically single purpose (isolcpu/nohz in this case) oriented.

> > Now I am not saying this is the right way to go because there is still a
> > slim chance this will break userspace expectations. Therefore I have
> > asked why you simply do not stop any random application accessing
> > stat_refresh in the first place.
> 
> I think this is what should be done, but not on the current patchset.
> 
> https://lkml.iu.edu/hypermail/linux/kernel/2209.1/01263.html
> 
> Regarding housekeeping flags, it is usually the case that initialization might
> require code execution on interference blocked CPUs (for example MTRR
> initialization, resctrlfs initialization, MSR writes, ...). Therefore
> tagging the CPUs after system initialization is necessary, which
> is not possible with current housekeeping flags infrastructure.
> 
> >  These highly specialized setups with
> > isolated resources shouldn't run arbitrary crap, should that?
> 
> Problem is that its hard to control what people run on a system.
> 
> > What if I just start allocating memory and get the system close to OOM. 
> 
> Sure, or "poweroff".
> 
> > I am
> > pretty sure a small latency induced by the vmstat refreshes is the least
> > problem you will have.
> 
> If OOM codepath sends no IPI or queues work on isolated CPUs, then OOM
> should be fine.

You are missing a big picture I am afraid. IPIs is the least of a
problem in that case (just imagine all the indirect dependencies through
locking - get a lock, held by somebody requesting a memory).

> > So please step back and try to think whether this is actually fixing
> > anything real before trying to change a user visible interface.
> 
> It is fixing either a latency violation or a hang on a system where some user or
> piece of software happens to run "sysctl -a" (or read vmstat_refresh).

I believe we have established the "hang problem" as described above is
not fixable by this patch. And I still argue that you should simply not
allow abuse of the interface if you want to have any latency guarantees.
Same as with any other kernel activity where you can compete for
resources (directly or indirectly).
 
> If one is using CPU isolation, the latency violation has higher 
> priority than vmstat_refresh returning proper counters.

This is a strong claim without any actual argument other than you would
like to have it this way.

-- 
Michal Hocko
SUSE Labs
