Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F0F5EB495
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiIZWc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiIZWc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:32:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDD07DF40;
        Mon, 26 Sep 2022 15:32:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47F92B815D7;
        Mon, 26 Sep 2022 22:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21ECC433D6;
        Mon, 26 Sep 2022 22:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664231542;
        bh=T7SLRWDmmnzpwpUteyKe8Ct1GteIsuCvbcSj2qel69w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RBOwr+GY4AK6wWifiaD8Wso3iQLG1AnOgy+iz3gnIWY+BVGCU44wt17W66mZKMYZS
         jSaVqF3gXPSFJJUISqe3iLMxdn65ZOFn0TndQ+bsn/Rc3g9qS0dsoq4mzQ8b/kT5c6
         2dDikpt+6hnSfXpQ+Jwo4aDuB9+sKp/15DPZCfdttZ+t146yj+5Zh95k6UxpiaTMzN
         Pvhmbi4ZotH2J/ROyFgKISjc4RsuxJznBoahRnTW1ox7Vn4RtD6fVBTewNQM61L/b6
         3TBcpF+JLG8cvs0ErAWFtDL44Rg2znkePOCdXzkusuZqTAGP1+1psaLf8UL7I29kGi
         wtFsD25ONaaGA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 717FF5C05B1; Mon, 26 Sep 2022 15:32:22 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:32:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <20220926223222.GX4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220922220104.2446868-1-joel@joelfernandes.org>
 <20220922220104.2446868-2-joel@joelfernandes.org>
 <YzAX5kOwjrZzoed6@pc636>
 <YzCUDXn3htWbqM4f@google.com>
 <20220926174846.GQ4196@paulmck-ThinkPad-P17-Gen-1>
 <YzH+XAVSlHpuWYoD@pc636>
 <YzITXYGIqfRIebIH@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzITXYGIqfRIebIH@google.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 09:02:21PM +0000, Joel Fernandes wrote:
> On Mon, Sep 26, 2022 at 09:32:44PM +0200, Uladzislau Rezki wrote:
> [...]
> > > > > On my KVM machine the boot time is affected:
> > > > > 
> > > > > <snip>
> > > > > [    2.273406] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
> > > > > [   11.945283] e1000 0000:00:03.0 ens3: renamed from eth0
> > > > > [   22.165198] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
> > > > > [   22.165206] cdrom: Uniform CD-ROM driver Revision: 3.20
> > > > > [   32.406981] sr 1:0:0:0: Attached scsi CD-ROM sr0
> > > > > [  104.115418] process '/usr/bin/fstype' started with executable stack
> > > > > [  104.170142] EXT4-fs (sda1): mounted filesystem with ordered data mode. Quota mode: none.
> > > > > [  104.340125] systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
> > > > > [  104.340193] systemd[1]: Detected virtualization kvm.
> > > > > [  104.340196] systemd[1]: Detected architecture x86-64.
> > > > > [  104.359032] systemd[1]: Set hostname to <pc638>.
> > > > > [  105.740109] random: crng init done
> > > > > [  105.741267] systemd[1]: Reached target Remote File Systems.
> > > > > <snip>
> > > > > 
> > > > > 2 - 11 and second delay is between 32 - 104. So there are still users which must
> > > > > be waiting for "RCU" in a sync way.
> > > > 
> > > > I was wondering if you can compare boot logs and see which timestamp does the
> > > > slow down start from. That way, we can narrow down the callback. Also another
> > > > idea is, add "trace_event=rcu:rcu_callback,rcu:rcu_invoke_callback
> > > > ftrace_dump_on_oops" to the boot params, and then manually call
> > > > "tracing_off(); panic();" from the code at the first printk that seems off in
> > > > your comparison of good vs bad. For example, if "crng init done" timestamp is
> > > > off, put the "tracing_off(); panic();" there. Then grab the serial console
> > > > output to see what were the last callbacks that was queued/invoked.
> > > 
> > > We do seem to be in need of some way to quickly and easily locate the
> > > callback that needed to be _flush() due to a wakeup.
> > >
> > <snip>
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index aeea9731ef80..fe1146d97f1a 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -1771,7 +1771,7 @@ bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
> >  
> >         if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
> >                 rwork->wq = wq;
> > -               call_rcu(&rwork->rcu, rcu_work_rcufn);
> > +               call_rcu_flush(&rwork->rcu, rcu_work_rcufn);
> >                 return true;
> >         }
> >  
> > <snip>
> > 
> > ?
> > 
> > But it does not fully solve my boot-up issue. Will debug tomorrow further.
> 
> Ah, but at least its progress, thanks. Could you send me a patch to include
> in the next revision with details of this?
> 
> > > Might one more proactive approach be to use Coccinelle to locate such
> > > callback functions?  We might not want -all- callbacks that do wakeups
> > > to use call_rcu_flush(), but knowing which are which should speed up
> > > slow-boot debugging by quite a bit.
> > > 
> > > Or is there a better way to do this?
> > > 
> > I am not sure what Coccinelle is. If we had something automated that measures
> > a boot time and if needed does some profiling it would be good. Otherwise it
> > is a manual debugging mainly, IMHO.
> 
> Paul, What about using a default-off kernel CONFIG that splats on all lazy
> call_rcu() callbacks that do a wake up. We could use the trace hooks to do it
> in kernel I think. I can talk to Steve to get ideas on how to do that but I
> think it can be done purely from trace events (we might need a new
> trace_end_invoke_callback to fire after the callback is invoked). Thoughts?

Could you look for wakeups invoked between trace_rcu_batch_start() and
trace_rcu_batch_end() that are not from interrupt context?  This would
of course need to be associated with a task rather than a CPU.

Note that you would need to check for wakeups from interrupt handlers
even with the extra trace_end_invoke_callback().  The window where an
interrupt handler could do a wakeup would be reduced, but not eliminated.

							Thanx, Paul
