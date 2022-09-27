Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260285EB89E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiI0DWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 23:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiI0DVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 23:21:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF2F8E456;
        Mon, 26 Sep 2022 20:21:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7316CB80E6A;
        Tue, 27 Sep 2022 03:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC8EC433C1;
        Tue, 27 Sep 2022 03:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664248874;
        bh=6XYNFkrplRbFLyJSdMCjNb0UU7P4Ja24ceZlacew0jk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=n/8+PjPu86sp+SVo5LCCh2IVeNKQeO/9tAt8OHcVwOC4cmEhwWhqwFF7R0nxidO2j
         48amTzfBkta6FHVz6+K8TZMwMvg7KFOsnYDW0U+lZlCDRDukQWDn2+5lNWSnasV9hv
         LqW1163ScyXyNkI8L9FfJnaiK14H/7HBoptgz31DwxG5HegIi78Hn7+3hSjLnS12Ve
         EN33ahAOgLY91m3t8amAJPG9xDuKh50uvh3poRMSpqfXzRB0UaOnt9zsCj0CcGZqou
         oH4cpkgK3jFAKruwNJG4E9mgTtMfpRL/pqwBSkBc2KyBr4lqPJ+iEKyIrjK+6jXJGB
         DabsGft5FK3Xg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B55FA5C0B39; Mon, 26 Sep 2022 20:21:13 -0700 (PDT)
Date:   Mon, 26 Sep 2022 20:21:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, frederic@kernel.org,
        linux-kernel@vger.kernel.org, neeraj.iitr10@gmail.com,
        rcu@vger.kernel.org, rostedt@goodmis.org,
        rushikesh.s.kadam@intel.com
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <20220927032113.GG4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220926223222.GX4196@paulmck-ThinkPad-P17-Gen-1>
 <8344B0AB-608E-44DA-8FEE-3FE56EDF9172@joelfernandes.org>
 <20220926235944.GE4196@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YRpAjvmBPzRA-hRQpuaDuZUzfndLb3q+e3BUyWprg5wkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YRpAjvmBPzRA-hRQpuaDuZUzfndLb3q+e3BUyWprg5wkQ@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 08:03:43PM -0400, Joel Fernandes wrote:
> On Mon, Sep 26, 2022 at 7:59 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > On Mon, Sep 26, 2022 at 07:47:50PM -0400, Joel Fernandes wrote:
> > >
> > >
> > > > On Sep 26, 2022, at 6:32 PM, Paul E. McKenney <paulmck@kernel.org>
> > wrote:
> > > >
> > > > ﻿On Mon, Sep 26, 2022 at 09:02:21PM +0000, Joel Fernandes wrote:
> > > >> On Mon, Sep 26, 2022 at 09:32:44PM +0200, Uladzislau Rezki wrote:
> > > >> [...]
> > > >>>>>> On my KVM machine the boot time is affected:
> > > >>>>>>
> > > >>>>>> <snip>
> > > >>>>>> [    2.273406] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network
> > Connection
> > > >>>>>> [   11.945283] e1000 0000:00:03.0 ens3: renamed from eth0
> > > >>>>>> [   22.165198] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw
> > xa/form2 tray
> > > >>>>>> [   22.165206] cdrom: Uniform CD-ROM driver Revision: 3.20
> > > >>>>>> [   32.406981] sr 1:0:0:0: Attached scsi CD-ROM sr0
> > > >>>>>> [  104.115418] process '/usr/bin/fstype' started with executable
> > stack
> > > >>>>>> [  104.170142] EXT4-fs (sda1): mounted filesystem with ordered
> > data mode. Quota mode: none.
> > > >>>>>> [  104.340125] systemd[1]: systemd 241 running in system mode.
> > (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP
> > +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN
> > -PCRE2 default-hierarchy=hybrid)
> > > >>>>>> [  104.340193] systemd[1]: Detected virtualization kvm.
> > > >>>>>> [  104.340196] systemd[1]: Detected architecture x86-64.
> > > >>>>>> [  104.359032] systemd[1]: Set hostname to <pc638>.
> > > >>>>>> [  105.740109] random: crng init done
> > > >>>>>> [  105.741267] systemd[1]: Reached target Remote File Systems.
> > > >>>>>> <snip>
> > > >>>>>>
> > > >>>>>> 2 - 11 and second delay is between 32 - 104. So there are still
> > users which must
> > > >>>>>> be waiting for "RCU" in a sync way.
> > > >>>>>
> > > >>>>> I was wondering if you can compare boot logs and see which
> > timestamp does the
> > > >>>>> slow down start from. That way, we can narrow down the callback.
> > Also another
> > > >>>>> idea is, add "trace_event=rcu:rcu_callback,rcu:rcu_invoke_callback
> > > >>>>> ftrace_dump_on_oops" to the boot params, and then manually call
> > > >>>>> "tracing_off(); panic();" from the code at the first printk that
> > seems off in
> > > >>>>> your comparison of good vs bad. For example, if "crng init done"
> > timestamp is
> > > >>>>> off, put the "tracing_off(); panic();" there. Then grab the serial
> > console
> > > >>>>> output to see what were the last callbacks that was queued/invoked.
> > > >>>>
> > > >>>> We do seem to be in need of some way to quickly and easily locate
> > the
> > > >>>> callback that needed to be _flush() due to a wakeup.
> > > >>>>
> > > >>> <snip>
> > > >>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > > >>> index aeea9731ef80..fe1146d97f1a 100644
> > > >>> --- a/kernel/workqueue.c
> > > >>> +++ b/kernel/workqueue.c
> > > >>> @@ -1771,7 +1771,7 @@ bool queue_rcu_work(struct workqueue_struct
> > *wq, struct rcu_work *rwork)
> > > >>>
> > > >>>        if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT,
> > work_data_bits(work))) {
> > > >>>                rwork->wq = wq;
> > > >>> -               call_rcu(&rwork->rcu, rcu_work_rcufn);
> > > >>> +               call_rcu_flush(&rwork->rcu, rcu_work_rcufn);
> > > >>>                return true;
> > > >>>        }
> > > >>>
> > > >>> <snip>
> > > >>>
> > > >>> ?
> > > >>>
> > > >>> But it does not fully solve my boot-up issue. Will debug tomorrow
> > further.
> > > >>
> > > >> Ah, but at least its progress, thanks. Could you send me a patch to
> > include
> > > >> in the next revision with details of this?
> > > >>
> > > >>>> Might one more proactive approach be to use Coccinelle to locate
> > such
> > > >>>> callback functions?  We might not want -all- callbacks that do
> > wakeups
> > > >>>> to use call_rcu_flush(), but knowing which are which should speed up
> > > >>>> slow-boot debugging by quite a bit.
> > > >>>>
> > > >>>> Or is there a better way to do this?
> > > >>>>
> > > >>> I am not sure what Coccinelle is. If we had something automated that
> > measures
> > > >>> a boot time and if needed does some profiling it would be good.
> > Otherwise it
> > > >>> is a manual debugging mainly, IMHO.
> > > >>
> > > >> Paul, What about using a default-off kernel CONFIG that splats on all
> > lazy
> > > >> call_rcu() callbacks that do a wake up. We could use the trace hooks
> > to do it
> > > >> in kernel I think. I can talk to Steve to get ideas on how to do that
> > but I
> > > >> think it can be done purely from trace events (we might need a new
> > > >> trace_end_invoke_callback to fire after the callback is invoked).
> > Thoughts?
> > > >
> > > > Could you look for wakeups invoked between trace_rcu_batch_start() and
> > > > trace_rcu_batch_end() that are not from interrupt context?  This would
> > > > of course need to be associated with a task rather than a CPU.
> > >
> > > Yes this sounds good, but we also need to know if the callbacks are lazy
> > or not since wake-up is ok from a non lazy one. I think I’ll need a table
> > to track that at queuing time.
> >
> > Agreed.
> >
> > > > Note that you would need to check for wakeups from interrupt handlers
> > > > even with the extra trace_end_invoke_callback().  The window where an
> > > > interrupt handler could do a wakeup would be reduced, but not
> > eliminated.
> > >
> > > True! Since this is a  debugging option, can we not just disable
> > interrupts across callback invocation?
> >
> > Not without terminally annoying lockdep, at least for any RCU callbacks
> > doing things like spin_lock_bh().
> 
> The easy fix for that is adding “depends on !LOCKDEP” to the Kconfig ;-)
> just kidding. Hmm I think I can just look at the preempt flags and
> determine if wake up happened in hard Irq context, and ignore those
> instances.

Or instrument/trace a few carefully chosen context-tracking functions.

							Thanx, Paul
