Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFED661AF8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 00:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjAHXKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 18:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjAHXJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 18:09:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE5FB4B0;
        Sun,  8 Jan 2023 15:09:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6C5AB80BAB;
        Sun,  8 Jan 2023 23:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9711C433D2;
        Sun,  8 Jan 2023 23:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673219393;
        bh=CiXV87sI2yjAaSQoUCZaHTnYMhLou3ZeeRv1qp4rNx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fk8qmE2/OqsB0wSJYz3QuN1T4ivvteaepTMxvx51v9utqUMse7IN1brSIsTa75hrq
         HwvtdVoJ/ESrWRLC20JBeEjP0WzYzSulmkzTwcxPQRvGPuDj+sjkarkb+ajFLwd6Az
         CwhNVvaS6/DBOyZTkiuD7d8sZZRb4VrhtRV28c3QzzNZZsNxJ9pybdNGr0/YdDWY3B
         f6aYNKURzLehMt/JotJxzpvMef9qaFzlaIMOOZBGgPWAfnEo5QY3ECN0Ydcyei93po
         gWZ/M+xOgXX3ofvp7ktxyLzxXL2fDXrEAy/UxeKqLy/b8JK+oDIQPGc7t8Ydmq0Q2m
         zyu4KX+U6id2Q==
Date:   Mon, 9 Jan 2023 00:09:48 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     paulmck@kernel.org, Zqiang <qiang1.zhang@intel.com>,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix missing TICK_DEP_MASK_RCU_EXP dependency check
Message-ID: <Y7tNPF4x+HYJUwjK@lothringen>
References: <0BF2065B-1E02-498C-B999-EB52F005B62E@joelfernandes.org>
 <D445A93C-8315-4407-A8E4-C377BF63058A@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D445A93C-8315-4407-A8E4-C377BF63058A@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2023 at 09:55:22PM -0500, Joel Fernandes wrote:
> 
> 
> > On Jan 7, 2023, at 9:48 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> > ﻿
> >>> On Jan 7, 2023, at 5:11 PM, Frederic Weisbecker <frederic@kernel.org> wrote:
> >>> 
> >>> ﻿On Fri, Jan 06, 2023 at 07:01:28PM -0500, Joel Fernandes wrote:
> >>> (lost html content)
> > 
> > My problem is the iPhone wises up when I put a web link in an email. I want to look into smtp relays but then if I spent time on fixing that, I might not get time to learn from emails like these... 
> > 
> >> I can't find a place where the exp grace period sends an IPI to
> >> CPUs slow to report a QS. But anyway you really need the tick to poll
> >> periodically on the CPU to chase a quiescent state.
> > 
> > Ok.
> > 
> >> Now arguably it's probably only useful when CONFIG_PREEMPT_COUNT=y
> >> and rcu_exp_handler() has interrupted a preempt-disabled or bh-disabled
> >> section. Although rcu_exp_handler() sets TIF_RESCHED, which is handled
> >> by preempt_enable() and local_bh_enable() when CONFIG_PREEMPT=y.
> >> So probably it's only useful when CONFIG_PREEMPT_COUNT=y and CONFIG_PREEMPT=n
> >> (and there is also PREEMPT_DYNAMIC to consider).
> > 
> > Makes sense. I think I was missing this use case and was going by the general design of exp grace periods.  I was incorrectly assuming the IPIs were being sent repeatedly for hold out CPUs, which is not the case I think. But that would another way to fix it?
> > 
> > But yeah I get your point, the first set of IPIs missed it, so we need the rescue-tick for long non-rcu_read_lock() implicit critical sections.. 
> > 
> >> If CONFIG_PREEMPT_COUNT=n, the tick can only report idle and user
> >> as QS, but those are already reported explicitly on ct_kernel_exit() ->
> >> rcu_preempt_deferred_qs().
> > 
> > Oh hmm, because that function is a NOOP for PREEMPT_COUNT=y and PREEMPT=n and will not report the deferred QS?  Maybe it should then. However I think the tick is still useful if after the preempt disabled section, will still did not exit the kernel.
> 
> I think meant I here, an atomic section (like bh or Irq disabled). There is no such thing as disabling preemption for CONFIG_PREEMPT=n. Or maybe I am confused again.  This RCU thing…

Right, so when CONFIG_PREEMPT_COUNT=n, there is no way for a tick to tell if the
the interrupted code is safely considered as a QS. That's because
preempt_disable() <-> preempt_enable() are no-ops so the whole kernel is
assumed non-preemptible, and therefore the whole kernel is a READ side critical
section, except for the explicit points reporting a QS.

The only exception is when the tick interrupts idle (or user with
nohz_full). But we already have an exp QS reported on idle (and user with
nohz_full) entry through ct_kernel_exit(), and that happens on all RCU_TREE
configs (PREEMPT or not). Therefore the tick doesn't appear to be helpful at
all on a nohz_full CPU with CONFIG_PREEMPT_COUNT=n.

I suggest we don't bother optimizing that case though...

To summarize:

1) nohz_full && !CONFIG_PREEMPT_COUNT && !CONFIG_PREEMPT_RCU:
  Tick isn't helpful. It can only report idle/user QS, but that is
  already reported explicitly.

2) nohz_full && CONFIG_PREEMPT_COUNT && !CONFIG_PREEMPT_RCU:
  Tick is very helpful because it can tell if the kernel is in
  a QS state.

3) nohz_full && CONFIG_PREEMPT_RCU:
   Tick doesn't appear to be helpful because:
       - If the rcu_exp_handler() fires in an rcu_read_lock'ed section, then the
         exp QS is reported on rcu_read_unlock()
       - If the rcu_exp_handler() fires in a preempt/bh disabled section,
         TIF_RESCHED is forced which is handled on preempt/bh re-enablement,
	 reporting a QS.
   
  
The case 2) is a niche, only useful for debugging. But anyway I'm not sure it's
worth changing/optimizing the current state. Might be worth add a comment
though.

Thanks.
