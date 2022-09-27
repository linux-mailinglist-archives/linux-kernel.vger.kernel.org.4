Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85AC5EC5E9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiI0OXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiI0OXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:23:02 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D3B1822FC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:22:57 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id j8so6260220qvt.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=SANNny3XJD7Havp3tnOroY7ZkZMTg0XHU4J3ixI/d48=;
        b=NIF4NC+aogNz6X9+Oj/JESY1Uom0nDPTFkRU+A5epIZ84vp52jWW9IuCbHm4BFma4Z
         TWvNaK48WIWcNH+MeROrqN3eNTi+YvQnxVZudXyqZw+VCE/g4KWZEWTwC/NmpBPdP8iu
         g2fpKg6FugJhNdXlA1BPQBEL5HIWl17fPivUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SANNny3XJD7Havp3tnOroY7ZkZMTg0XHU4J3ixI/d48=;
        b=mS9m/swanEZt5OrZeZmXqjhZT3o5pQ/Xr21NWaqfI3q7VF/Not1VbXD8UQqYGukke+
         tUwnA64AQqxQj+yBeyCwfX2ydRa3exvVK57srUMSHi7QLCP4jH6n6HRyvKG47TKmVCvf
         8LbRaY2x4auPeTKaSLyW7YgZYzff7rnRgmkEr4eYHxMreZZImn+kY/LPlpBuFx9BaA5e
         Urta+S270kYhVnPRtnt/buA4IC8GaqmBw5QjpOix2e5VIVEYg5jBcIvggku/w5N9ZLd3
         EQxy+3BZvTE9MnazjM1Z/5htrGsXwCdFIyFBmPVRFRV3HBxcBVqifjRqDufXf/OPBg3b
         DYLg==
X-Gm-Message-State: ACrzQf2AHHyAzIUTNgnGkhpvDCLPfJotuL7+qM1MjL9F6k1Mjx96IRoE
        WxfVsBlybcwCsCS+6le8uxqDuw==
X-Google-Smtp-Source: AMsMyM6tv+CnTD7oGFE5pYMQtmzCxRHT+rUah2/NWZCEZz/WhB8FdlYetjGWdu65Osy36vO+1sd8dw==
X-Received: by 2002:a05:6214:e62:b0:4ac:aaf6:3944 with SMTP id jz2-20020a0562140e6200b004acaaf63944mr21049960qvb.9.1664288577068;
        Tue, 27 Sep 2022 07:22:57 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id l23-20020a37f917000000b006ce51b541dfsm1087527qkj.36.2022.09.27.07.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:22:56 -0700 (PDT)
Date:   Tue, 27 Sep 2022 14:22:56 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <YzMHQPStqfm7ll/P@google.com>
References: <20220926223222.GX4196@paulmck-ThinkPad-P17-Gen-1>
 <8344B0AB-608E-44DA-8FEE-3FE56EDF9172@joelfernandes.org>
 <20220926235944.GE4196@paulmck-ThinkPad-P17-Gen-1>
 <YzJWoRui7mUEDtox@google.com>
 <20220927032246.GH4196@paulmck-ThinkPad-P17-Gen-1>
 <YzL1JauFkeLEMgqV@google.com>
 <20220927141403.GJ4196@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220927141403.GJ4196@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 07:14:03AM -0700, Paul E. McKenney wrote:
> On Tue, Sep 27, 2022 at 01:05:41PM +0000, Joel Fernandes wrote:
> > On Mon, Sep 26, 2022 at 08:22:46PM -0700, Paul E. McKenney wrote:
> > [..]
> > > > > > >>> --- a/kernel/workqueue.c
> > > > > > >>> +++ b/kernel/workqueue.c
> > > > > > >>> @@ -1771,7 +1771,7 @@ bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
> > > > > > >>> 
> > > > > > >>>        if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
> > > > > > >>>                rwork->wq = wq;
> > > > > > >>> -               call_rcu(&rwork->rcu, rcu_work_rcufn);
> > > > > > >>> +               call_rcu_flush(&rwork->rcu, rcu_work_rcufn);
> > > > > > >>>                return true;
> > > > > > >>>        }
> > > > > > >>> 
> > > > > > >>> <snip>
> > > > > > >>> 
> > > > > > >>> ?
> > > > > > >>> 
> > > > > > >>> But it does not fully solve my boot-up issue. Will debug tomorrow further.
> > > > > > >> 
> > > > > > >> Ah, but at least its progress, thanks. Could you send me a patch to include
> > > > > > >> in the next revision with details of this?
> > > > > > >> 
> > > > > > >>>> Might one more proactive approach be to use Coccinelle to locate such
> > > > > > >>>> callback functions?  We might not want -all- callbacks that do wakeups
> > > > > > >>>> to use call_rcu_flush(), but knowing which are which should speed up
> > > > > > >>>> slow-boot debugging by quite a bit.
> > > > > > >>>> 
> > > > > > >>>> Or is there a better way to do this?
> > > > > > >>>> 
> > > > > > >>> I am not sure what Coccinelle is. If we had something automated that measures
> > > > > > >>> a boot time and if needed does some profiling it would be good. Otherwise it
> > > > > > >>> is a manual debugging mainly, IMHO.
> > > > > > >> 
> > > > > > >> Paul, What about using a default-off kernel CONFIG that splats on all lazy
> > > > > > >> call_rcu() callbacks that do a wake up. We could use the trace hooks to do it
> > > > > > >> in kernel I think. I can talk to Steve to get ideas on how to do that but I
> > > > > > >> think it can be done purely from trace events (we might need a new
> > > > > > >> trace_end_invoke_callback to fire after the callback is invoked). Thoughts?
> > > > > > > 
> > > > > > > Could you look for wakeups invoked between trace_rcu_batch_start() and
> > > > > > > trace_rcu_batch_end() that are not from interrupt context?  This would
> > > > > > > of course need to be associated with a task rather than a CPU.
> > > > > > 
> > > > > > Yes this sounds good, but we also need to know if the callbacks are
> > > > > > lazy or not since wake-up is ok from a non lazy one. I think I’ll
> > > > > > need a table to track that at queuing time.
> > > > > 
> > > > > Agreed.
> > > > > 
> > > > > > > Note that you would need to check for wakeups from interrupt handlers
> > > > > > > even with the extra trace_end_invoke_callback().  The window where an
> > > > > > > interrupt handler could do a wakeup would be reduced, but not eliminated.
> > > > > > 
> > > > > > True! Since this is a  debugging option, can we not just disable interrupts across callback invocation?
> > > > > 
> > > > > Not without terminally annoying lockdep, at least for any RCU callbacks
> > > > > doing things like spin_lock_bh().
> > > > > 
> > > > 
> > > > Sorry if my last email bounced. Looks like my iPhone betrayed me this once ;)
> > > > 
> > > > I was thinking something like this:
> > > > 1. Put a flag in rcu_head to mark CBs as lazy.
> > > > 2. Add a trace_rcu_invoke_callback_end() trace point.
> > > > 
> > > > Both #1 and #2 can be a debug CONFIG option. #2 can be a tracepoint and not
> > > > exposed if needed.
> > > > 
> > > > 3. Put an in-kernel probe on both trace_rcu_invoke_callback_start() and
> > > > trace_rcu_invoke_callback_end(). In the start probe, set a per-task flag if
> > > > the current CB is lazy. In the end probe, clear it.
> > > > 
> > > > 4. Put an in-kernel probe on trace_rcu_sched_wakeup().
> > > > 
> > > > Splat in the wake up probe if:
> > > > 1. Hard IRQs are on.
> > > > 2. The per-cpu flag is set.
> > > > 
> > > > #3 actually does not even need probes if we can directly call the functions
> > > > from the rcu_do_batch() function.
> > > 
> > > This is fine for an experiment or a debugging session, but a solution
> > > based totally on instrumentation would be better for production use.
> > 
> > Maybe we can borrow the least-significant bit of rhp->func to mark laziness?
> > Then it can be production as long as we're ok with the trace_sched_wakeup
> > probe.
> 
> Last time I tried this, there were architectures that could have odd-valued
> function addresses.  Maybe this is no longer the case?

Oh ok! If this happens, maybe we can just make it depend on x86-64 assuming
x86-64 does not have pointer oddness. We can also add a warning for if the
function address is odd before setting the bit.

thanks,

 - Joel


