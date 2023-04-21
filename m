Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105F06EAA6B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjDUMg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjDUMg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:36:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53F2E66
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 05:36:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 679EF64FD2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E99C433D2;
        Fri, 21 Apr 2023 12:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682080615;
        bh=u4jrpcuB0tGC0jTpHkQU1WpjtyJWlbwEF7D0jtYMEX0=;
        h=Date:From:To:Cc:Subject:From;
        b=I+WKMXy1X8Yiv+dsnqps2XrgcLGK9AxC368CWYKMSwljatGpNDLDXg0+LXtlP5p7Y
         BC/WLDcNuUofT11oMlYwkF+e+TmwtBdqtViPiwN0iIWpc2yT9LmbhLtSVtqY+ycBAM
         cvaifLRMSCZSZXaVO8x/lvpBP1xwE3eu1xUInH7cEIFUrhyRYDfZ0m6xLO9mbjs9xk
         bkOgRrgy9g3nPxyMZA6bxAic//7i/5t7QOuIvFuVwXJ0DXB4VEVF2+tPePxg3bgGH1
         SLAyT+iZx9YEBv26VrA0n0UgP7+FM+T1Qlfs2HPlf8IETS7cZC3zG+XPDgnjoLMdk+
         NTMBJ5dywtHhQ==
Date:   Fri, 21 Apr 2023 14:36:52 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Loongson (and other $ARCHs?) idle VS timer enqueue
Message-ID: <ZEKDZEQmKExv0O7Q@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm looking at the __arch_cpu_idle() implementation in Loongarch
and I'm wondering about the rollback code. I don't understand well
that code but with the help from PeterZ I might have seen something,
so tell me if I'm wrong: when an interrupt happens within
__arch_cpu_idle(), handle_vint() rolls back the return value to the
beginning of __arch_cpu_idle(), so that TIF_NEED_RESCHED is checked
again. Is that correct?

Because if an interrupt fires while in __arch_cpu_idle(), that IRQ
might enqueue a new timer and that new timer needs to be reprogrammed
from the main idle loop and just checking TIF_NEED_RESCHED doesn't
tell about that information.

More generally IRQs must _not_ be re-enabled between cpuidle_select()
(or just tick_nohz_idle_stop_tick() if no cpuidle support) and the
last halting ASM instruction. If that happens there must be
a mechanism to cope with that and make sure we return to the main
idle loop.

If that mechanism has to go through rollback (I wish your arch allows
you to find a simpler and less error prone mechanism through), then the
rollback must actually fast forward to after the halting instruction
so that the main idle loop re-checks the timers. But then
__arch_cpu_idle() alone is not enough to be part of the fastforward
section, it has to start before the raw_local_irq_enable() in
arch_cpu_idle().

Another way to cope with this would be to have:

#define TIF_IDLE_TIMER	 ...
#define TIF_IDLE_EXIT	 (TIF_NEED_RESCHED | TIF_IDLE_TIMER)

And set that from the timer enqueue in idle time and check TIF_IDLE_EXIT
on idle callback. It depends how many architectures are concerned by this.
All I know so far is:

* mwait based mechanism should be fine if called with IRQs disabled (or
sti is called right before) but then we must be sure that IRQs have never
been even temporarily re-enabled between cpuidle_select() and mwait. How
to detect that kind of mistake?

* wfi based mechanism look fine, but again we must make sure IRQs have
never been re-enabled.

* sti;hlt should be fine but again...

* Need to check all other archs

I'm trying to find an automated way to debug this kind of issue but it's not
easy...

Thanks.
