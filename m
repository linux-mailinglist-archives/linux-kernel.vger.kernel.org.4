Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951B95EB727
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 03:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiI0Bt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 21:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiI0BtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 21:49:24 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84325A7AB3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 18:49:23 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id l1so5412635qvu.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 18:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=F+L/Ikz7ZIS57E9qq2FM8kuT6LyTmfWIeby9ZoIpbkE=;
        b=STSc2fW+2lHKhOv+rsoG8eVoZdjgapXsQsatTCtuMjBK/KuRMCT+Eq0qxpsPhiqXRR
         /9ZZG9ixL19LTVaALwyd1/b/xbq1GGACAK31JrC5RYFR8uUmHCNfa65UaYxatHQ8Yv2H
         Ti9y5s5FLUqBK00fHlVxzadBfvKMmDBJpJKw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=F+L/Ikz7ZIS57E9qq2FM8kuT6LyTmfWIeby9ZoIpbkE=;
        b=35gPa63Qd6LexzT3GnC7FOS/DFI9uHunqjXEdrb/Fn7bKW9ZYvwS5Gajyd2MxFMrtE
         b/XrgVTfBJW35QkkFa2AXOjXoiu5VHtHMaAdaNfiEczT1ipzVgPRkdhNYuWYLSIZJLdP
         SeUeHU4Hm203de2VnzpIN7WODdksQDE6fXuTetE8gUjpL3ZEAwveL/vsTJjHZUqsYboM
         3Frl81RRspGV8nmbAaksjjqYkTIcc1hYVWvvFPqjjsKXcg8A9wm1B9UQcx+sp/ZvtHMF
         HeVmvXwZ1f+vEubLf2uGeLXaV8b44Tmxxto0I2LcCHouzFGcth5R2SFqBYIbm+hiDPyF
         9xWA==
X-Gm-Message-State: ACrzQf1JG74eKi9Tj+81qwA8efDPk5gu/YIPUVXHuFXbQxjXZ6WRODRT
        /hU1QDclmqYq3aV7aYH0JdYU5Z4wfPQjXg==
X-Google-Smtp-Source: AMsMyM7H/+akRxXNmgLBVNTUSCEeNlGH1DX4c183hY3X1KqUIu943+wFR7HxBaLBkyzUZTYhczsjiA==
X-Received: by 2002:a0c:b295:0:b0:496:b91a:f5f4 with SMTP id r21-20020a0cb295000000b00496b91af5f4mr19888973qve.20.1664243362579;
        Mon, 26 Sep 2022 18:49:22 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id y13-20020a37f60d000000b006bbc09af9f5sm101002qkj.101.2022.09.26.18.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 18:49:22 -0700 (PDT)
Date:   Tue, 27 Sep 2022 01:49:21 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <YzJWoRui7mUEDtox@google.com>
References: <20220926223222.GX4196@paulmck-ThinkPad-P17-Gen-1>
 <8344B0AB-608E-44DA-8FEE-3FE56EDF9172@joelfernandes.org>
 <20220926235944.GE4196@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220926235944.GE4196@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 04:59:44PM -0700, Paul E. McKenney wrote:
> On Mon, Sep 26, 2022 at 07:47:50PM -0400, Joel Fernandes wrote:
> > 
> > 
> > > On Sep 26, 2022, at 6:32 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > 
> > > ﻿On Mon, Sep 26, 2022 at 09:02:21PM +0000, Joel Fernandes wrote:
> > >> On Mon, Sep 26, 2022 at 09:32:44PM +0200, Uladzislau Rezki wrote:
> > >> [...]
> > >>>>>> On my KVM machine the boot time is affected:
> > >>>>>> 
> > >>>>>> <snip>
> > >>>>>> [    2.273406] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
> > >>>>>> [   11.945283] e1000 0000:00:03.0 ens3: renamed from eth0
> > >>>>>> [   22.165198] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
> > >>>>>> [   22.165206] cdrom: Uniform CD-ROM driver Revision: 3.20
> > >>>>>> [   32.406981] sr 1:0:0:0: Attached scsi CD-ROM sr0
> > >>>>>> [  104.115418] process '/usr/bin/fstype' started with executable stack
> > >>>>>> [  104.170142] EXT4-fs (sda1): mounted filesystem with ordered data mode. Quota mode: none.
> > >>>>>> [  104.340125] systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
> > >>>>>> [  104.340193] systemd[1]: Detected virtualization kvm.
> > >>>>>> [  104.340196] systemd[1]: Detected architecture x86-64.
> > >>>>>> [  104.359032] systemd[1]: Set hostname to <pc638>.
> > >>>>>> [  105.740109] random: crng init done
> > >>>>>> [  105.741267] systemd[1]: Reached target Remote File Systems.
> > >>>>>> <snip>
> > >>>>>> 
> > >>>>>> 2 - 11 and second delay is between 32 - 104. So there are still users which must
> > >>>>>> be waiting for "RCU" in a sync way.
> > >>>>> 
> > >>>>> I was wondering if you can compare boot logs and see which timestamp does the
> > >>>>> slow down start from. That way, we can narrow down the callback. Also another
> > >>>>> idea is, add "trace_event=rcu:rcu_callback,rcu:rcu_invoke_callback
> > >>>>> ftrace_dump_on_oops" to the boot params, and then manually call
> > >>>>> "tracing_off(); panic();" from the code at the first printk that seems off in
> > >>>>> your comparison of good vs bad. For example, if "crng init done" timestamp is
> > >>>>> off, put the "tracing_off(); panic();" there. Then grab the serial console
> > >>>>> output to see what were the last callbacks that was queued/invoked.
> > >>>> 
> > >>>> We do seem to be in need of some way to quickly and easily locate the
> > >>>> callback that needed to be _flush() due to a wakeup.
> > >>>> 
> > >>> <snip>
> > >>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > >>> index aeea9731ef80..fe1146d97f1a 100644
> > >>> --- a/kernel/workqueue.c
> > >>> +++ b/kernel/workqueue.c
> > >>> @@ -1771,7 +1771,7 @@ bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
> > >>> 
> > >>>        if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
> > >>>                rwork->wq = wq;
> > >>> -               call_rcu(&rwork->rcu, rcu_work_rcufn);
> > >>> +               call_rcu_flush(&rwork->rcu, rcu_work_rcufn);
> > >>>                return true;
> > >>>        }
> > >>> 
> > >>> <snip>
> > >>> 
> > >>> ?
> > >>> 
> > >>> But it does not fully solve my boot-up issue. Will debug tomorrow further.
> > >> 
> > >> Ah, but at least its progress, thanks. Could you send me a patch to include
> > >> in the next revision with details of this?
> > >> 
> > >>>> Might one more proactive approach be to use Coccinelle to locate such
> > >>>> callback functions?  We might not want -all- callbacks that do wakeups
> > >>>> to use call_rcu_flush(), but knowing which are which should speed up
> > >>>> slow-boot debugging by quite a bit.
> > >>>> 
> > >>>> Or is there a better way to do this?
> > >>>> 
> > >>> I am not sure what Coccinelle is. If we had something automated that measures
> > >>> a boot time and if needed does some profiling it would be good. Otherwise it
> > >>> is a manual debugging mainly, IMHO.
> > >> 
> > >> Paul, What about using a default-off kernel CONFIG that splats on all lazy
> > >> call_rcu() callbacks that do a wake up. We could use the trace hooks to do it
> > >> in kernel I think. I can talk to Steve to get ideas on how to do that but I
> > >> think it can be done purely from trace events (we might need a new
> > >> trace_end_invoke_callback to fire after the callback is invoked). Thoughts?
> > > 
> > > Could you look for wakeups invoked between trace_rcu_batch_start() and
> > > trace_rcu_batch_end() that are not from interrupt context?  This would
> > > of course need to be associated with a task rather than a CPU.
> > 
> > Yes this sounds good, but we also need to know if the callbacks are lazy or not since wake-up is ok from a non lazy one. I think I’ll need a table to track that at queuing time.
> 
> Agreed.
> 
> > > Note that you would need to check for wakeups from interrupt handlers
> > > even with the extra trace_end_invoke_callback().  The window where an
> > > interrupt handler could do a wakeup would be reduced, but not eliminated.
> > 
> > True! Since this is a  debugging option, can we not just disable interrupts across callback invocation?
> 
> Not without terminally annoying lockdep, at least for any RCU callbacks
> doing things like spin_lock_bh().
> 

Sorry if my last email bounced. Looks like my iPhone betrayed me this once ;)

I was thinking something like this:
1. Put a flag in rcu_head to mark CBs as lazy.
2. Add a trace_rcu_invoke_callback_end() trace point.

Both #1 and #2 can be a debug CONFIG option. #2 can be a tracepoint and not
exposed if needed.

3. Put an in-kernel probe on both trace_rcu_invoke_callback_start() and
trace_rcu_invoke_callback_end(). In the start probe, set a per-task flag if
the current CB is lazy. In the end probe, clear it.

4. Put an in-kernel probe on trace_rcu_sched_wakeup().

Splat in the wake up probe if:
1. Hard IRQs are on.
2. The per-cpu flag is set.

#3 actually does not even need probes if we can directly call the functions
from the rcu_do_batch() function.

I'll work on it in the morning and also look into Vlad's config.

thanks,

 - Joel



