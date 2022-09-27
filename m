Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E125EC79A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiI0PZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiI0PZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:25:09 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055DA5F998
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:25:04 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c19so6224754qkm.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=tiLA/iocf4nQFXZZX4OGOXS4ifRO5PJ7Het5teuu+0A=;
        b=u8oHBM87yHdwA3WsH5poAjhN95kTzEf9Oy72Vrf/NiGT+rvDjfLfIeciN8XIGwzXdV
         aS5CmdQpYnKYDtw5Q0gejWjdb4lp4fqf6lYUgeVdHx0wIzHJMFMgNIE1/j3T/OdzNFb4
         P/GZs8ghZox4UnLwK9oaiFOGX5GEgu1GxF088=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tiLA/iocf4nQFXZZX4OGOXS4ifRO5PJ7Het5teuu+0A=;
        b=T67m4ppZSZgEEp76SNt2WiCm7G1yBrliTwr8xAp0nJ1JXKApWKfxALFF+/0H4jQgUi
         g44JOLCnXp7EBrcqGMZZWkvZr37+1GISGgStChCOQSduLxpTQNy1CYT9xz4lMc/kTFaw
         5IXWgmv75RSJ3Zy3sWY+ATFuRcsV+OscGL22H51iJjJLg3jMxyrOGJx3p2dhpJJcFEOR
         bpU3KpSaNCzsQhZVhASDji95EWFf7awI1mqCvMxBikUyJy0KXkM2Eh5BMJBRFIhgYYwe
         Y5tXZTVT3Om4p9ohRl0v3xqD49/F4zOnLXfiL0pO80ivWVpjtq4zLzmc6CUUl3qDMy+T
         BuuA==
X-Gm-Message-State: ACrzQf2NbmCUjCwB75Bj6QCj8wCYF0V9WS/RE9CIT5Q18ALGye4MLg2u
        FKidhwnWhbJaCvHlvK4CbyQlSQ==
X-Google-Smtp-Source: AMsMyM6PISmedsLrJiZp6C28onvj4U3ncEBjENDfgjsLNhsCEDhWNRcf2wO/Ahuh3iisYrgDFFg33Q==
X-Received: by 2002:a05:620a:167a:b0:6cd:eec3:1785 with SMTP id d26-20020a05620a167a00b006cdeec31785mr17913014qko.211.1664292303404;
        Tue, 27 Sep 2022 08:25:03 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id z4-20020ac87ca4000000b0035d465ae4cdsm942744qtv.27.2022.09.27.08.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:25:02 -0700 (PDT)
Date:   Tue, 27 Sep 2022 15:25:02 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <YzMVzpvvHbbkFMs8@google.com>
References: <20220926223222.GX4196@paulmck-ThinkPad-P17-Gen-1>
 <8344B0AB-608E-44DA-8FEE-3FE56EDF9172@joelfernandes.org>
 <20220926235944.GE4196@paulmck-ThinkPad-P17-Gen-1>
 <YzJWoRui7mUEDtox@google.com>
 <20220927032246.GH4196@paulmck-ThinkPad-P17-Gen-1>
 <YzL1JauFkeLEMgqV@google.com>
 <20220927141403.GJ4196@paulmck-ThinkPad-P17-Gen-1>
 <YzMHQPStqfm7ll/P@google.com>
 <20220927143020.GK4196@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220927143020.GK4196@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 07:30:20AM -0700, Paul E. McKenney wrote:
> On Tue, Sep 27, 2022 at 02:22:56PM +0000, Joel Fernandes wrote:
> > On Tue, Sep 27, 2022 at 07:14:03AM -0700, Paul E. McKenney wrote:
> > > On Tue, Sep 27, 2022 at 01:05:41PM +0000, Joel Fernandes wrote:
> > > > On Mon, Sep 26, 2022 at 08:22:46PM -0700, Paul E. McKenney wrote:
> > > > [..]
> > > > > > > > >>> --- a/kernel/workqueue.c
> > > > > > > > >>> +++ b/kernel/workqueue.c
> > > > > > > > >>> @@ -1771,7 +1771,7 @@ bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
> > > > > > > > >>> 
> > > > > > > > >>>        if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
> > > > > > > > >>>                rwork->wq = wq;
> > > > > > > > >>> -               call_rcu(&rwork->rcu, rcu_work_rcufn);
> > > > > > > > >>> +               call_rcu_flush(&rwork->rcu, rcu_work_rcufn);
> > > > > > > > >>>                return true;
> > > > > > > > >>>        }
> > > > > > > > >>> 
> > > > > > > > >>> <snip>
> > > > > > > > >>> 
> > > > > > > > >>> ?
> > > > > > > > >>> 
> > > > > > > > >>> But it does not fully solve my boot-up issue. Will debug tomorrow further.
> > > > > > > > >> 
> > > > > > > > >> Ah, but at least its progress, thanks. Could you send me a patch to include
> > > > > > > > >> in the next revision with details of this?
> > > > > > > > >> 
> > > > > > > > >>>> Might one more proactive approach be to use Coccinelle to locate such
> > > > > > > > >>>> callback functions?  We might not want -all- callbacks that do wakeups
> > > > > > > > >>>> to use call_rcu_flush(), but knowing which are which should speed up
> > > > > > > > >>>> slow-boot debugging by quite a bit.
> > > > > > > > >>>> 
> > > > > > > > >>>> Or is there a better way to do this?
> > > > > > > > >>>> 
> > > > > > > > >>> I am not sure what Coccinelle is. If we had something automated that measures
> > > > > > > > >>> a boot time and if needed does some profiling it would be good. Otherwise it
> > > > > > > > >>> is a manual debugging mainly, IMHO.
> > > > > > > > >> 
> > > > > > > > >> Paul, What about using a default-off kernel CONFIG that splats on all lazy
> > > > > > > > >> call_rcu() callbacks that do a wake up. We could use the trace hooks to do it
> > > > > > > > >> in kernel I think. I can talk to Steve to get ideas on how to do that but I
> > > > > > > > >> think it can be done purely from trace events (we might need a new
> > > > > > > > >> trace_end_invoke_callback to fire after the callback is invoked). Thoughts?
> > > > > > > > > 
> > > > > > > > > Could you look for wakeups invoked between trace_rcu_batch_start() and
> > > > > > > > > trace_rcu_batch_end() that are not from interrupt context?  This would
> > > > > > > > > of course need to be associated with a task rather than a CPU.
> > > > > > > > 
> > > > > > > > Yes this sounds good, but we also need to know if the callbacks are
> > > > > > > > lazy or not since wake-up is ok from a non lazy one. I think I’ll
> > > > > > > > need a table to track that at queuing time.
> > > > > > > 
> > > > > > > Agreed.
> > > > > > > 
> > > > > > > > > Note that you would need to check for wakeups from interrupt handlers
> > > > > > > > > even with the extra trace_end_invoke_callback().  The window where an
> > > > > > > > > interrupt handler could do a wakeup would be reduced, but not eliminated.
> > > > > > > > 
> > > > > > > > True! Since this is a  debugging option, can we not just disable interrupts across callback invocation?
> > > > > > > 
> > > > > > > Not without terminally annoying lockdep, at least for any RCU callbacks
> > > > > > > doing things like spin_lock_bh().
> > > > > > > 
> > > > > > 
> > > > > > Sorry if my last email bounced. Looks like my iPhone betrayed me this once ;)
> > > > > > 
> > > > > > I was thinking something like this:
> > > > > > 1. Put a flag in rcu_head to mark CBs as lazy.
> > > > > > 2. Add a trace_rcu_invoke_callback_end() trace point.
> > > > > > 
> > > > > > Both #1 and #2 can be a debug CONFIG option. #2 can be a tracepoint and not
> > > > > > exposed if needed.
> > > > > > 
> > > > > > 3. Put an in-kernel probe on both trace_rcu_invoke_callback_start() and
> > > > > > trace_rcu_invoke_callback_end(). In the start probe, set a per-task flag if
> > > > > > the current CB is lazy. In the end probe, clear it.
> > > > > > 
> > > > > > 4. Put an in-kernel probe on trace_rcu_sched_wakeup().
> > > > > > 
> > > > > > Splat in the wake up probe if:
> > > > > > 1. Hard IRQs are on.
> > > > > > 2. The per-cpu flag is set.
> > > > > > 
> > > > > > #3 actually does not even need probes if we can directly call the functions
> > > > > > from the rcu_do_batch() function.
> > > > > 
> > > > > This is fine for an experiment or a debugging session, but a solution
> > > > > based totally on instrumentation would be better for production use.
> > > > 
> > > > Maybe we can borrow the least-significant bit of rhp->func to mark laziness?
> > > > Then it can be production as long as we're ok with the trace_sched_wakeup
> > > > probe.
> > > 
> > > Last time I tried this, there were architectures that could have odd-valued
> > > function addresses.  Maybe this is no longer the case?
> > 
> > Oh ok! If this happens, maybe we can just make it depend on x86-64 assuming
> > x86-64 does not have pointer oddness. We can also add a warning for if the
> > function address is odd before setting the bit.
> 
> Let me rephrase this...  ;-)
> 
> Given that this used to not work and still might not work, let's see
> if we can find some other way to debug this.  Unless and until it can
> be demonstrated that there is no supported compiler that will generated
> odd-valued function addresses on any supported architecture.
> 
> Plus there was a time that x86 did odd-valued pointer addresses.
> The instruction set is plenty fine with this, so it would have to be a
> compiler and assembly-language convention to avoid it.

Ok, so then I am not sure how to make it work in production at the moment. I
could track the lazy callbacks in a hashtable but then that's overhead.

Or, I could focus on trying Vlad's config and figure out what's going on and
keep the auto-debug for later.

On another thought, this is the sort of thing that should be doable via Daniel
Bristot's runtime verification framework, as its a classical "see if these
traces look right" issue which should be teachable to a computer with a few rules.

thanks,

 - Joel

