Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8C664294A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbiLENYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiLENYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:24:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657661AF0C;
        Mon,  5 Dec 2022 05:24:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14932B80F79;
        Mon,  5 Dec 2022 13:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F5AC433C1;
        Mon,  5 Dec 2022 13:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670246637;
        bh=wY8WWEhsULxUa+5zkLjOJ6JIAAUgwhZ1yANEZ6F4tNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nv/TzyyF7Lsl7b2ve7RRq3FM+MHaDZjr1oLk5n3sFfOED0UCCblTzwckroNUUl7SO
         ToitNqOLxAsua4ashRVZyskpY1Cq0buEgUqBTXkr1SsLCwpbHzegCp3Tr9XplBtp5d
         G/9bXvJHlAE/LVhzJp7XqdHGLxmhdtBMa9+d6rgZtnLmJV4b2v9uI4vCKKUBRlKJvD
         ftvibbHcqq6SaN/GXyPNXCEWTX1ZvIkvsj1pk3NQjLt65saSUSR9ijR2B12K477oLE
         CG/EAYLn13cVMR0wG5JiX9sTFqY6vMa2tTKm7ofSC25cvU3QcMfpIjSPunXR3WaQyc
         OrQuf5yW/AkXg==
Date:   Mon, 5 Dec 2022 14:23:53 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zheng Yejian <zhengyejian1@huawei.com>, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix kernel stack overflow caused by kprobe on
 rcu_irq_enter_check_tick()
Message-ID: <20221205132353.GB1796992@lothringen>
References: <20221119040049.795065-1-zhengyejian1@huawei.com>
 <20221121195703.GO4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121195703.GO4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 11:57:03AM -0800, Paul E. McKenney wrote:
> On Sat, Nov 19, 2022 at 12:00:49PM +0800, Zheng Yejian wrote:
> > Register kprobe on __rcu_irq_enter_check_tick() can cause kernel stack
> > overflow [1]. This issue is first found in v5.10 and can be reproduced
> > by enabling CONFIG_NO_HZ_FULL and doing like:
> >   # cd /sys/kernel/debug/tracing/
> >   # echo 'p:mp1 __rcu_irq_enter_check_tick' >> kprobe_events
> >   # echo 1 > events/kprobes/enable
> > 
> > So __rcu_irq_enter_check_tick() should not be kprobed, mark it as noinstr.
> 
> Good catch!
> 
> I am inclined to queue this, but noticed that one of its callers need
> it to be noinstr but that the others do not.
> 
> Need noinstr:
> 
> o	enter_from_kernel_mode() -> __enter_from_kernel_mode() ->
> 	rcu_irq_enter_check_tick() -> __rcu_irq_enter_check_tick()
> 
> Doesn't need noinstr:
> 
> o	ct_nmi_enter() -> rcu_irq_enter_check_tick() ->
> 	__rcu_irq_enter_check_tick(), courtesy of the call to
> 	instrumentation_begin() in ct_nmi_enter() that precedes the call
> 	to rcu_irq_enter_check_tick().
> 
> o	irqentry_enter() -> rcu_irq_enter_check_tick() ->
> 	__rcu_irq_enter_check_tick(), courtesy of the call to
> 	instrumentation_begin() in irqentry_enter() that precedes the
> 	call to rcu_irq_enter_check_tick().
> 
> Is tagging __rcu_irq_enter_check_tick() with noinstr as
> proposed in this patch the right thing to do, or should there
> be calls to instrumentation_begin() and instrumentation_end() in
> enter_from_kernel_mode()?  Or something else entirely?

Tagging as noinstr doesn't look right as there are functions in
__rcu_irq_enter_check_tick() that can be traced anyway. Also that
function has the constraint that it can't be called while RCU is idle
so it's up to the caller to call instrumentation_begin()/end().

Thanks.
