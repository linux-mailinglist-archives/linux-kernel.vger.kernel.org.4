Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879D6723AF9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbjFFIGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjFFIGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:06:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBE1A7;
        Tue,  6 Jun 2023 01:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MMfNt+/fpOAnK2jN5oJU+/ZY+OOaQU1hH992ihB2sdA=; b=p11KfsKDD6TYWcPs7TB5GTpp9W
        IHpNtc0s0s2SGqxggQyGsohZGa0SkrOQ4C08f8hW5bbCEw5NxYxi5dyRrlG+FX7/JDukVdWeR9kL3
        Vvq0z1oRKy6l8/Ue49NQBQti9mJzhASuCN+bwAKvvYWvghhE8LGLo5G8dCUwXzIwHtQPmW9UKn8kY
        tb8j1zSF+izeleWKa8XL2Xi3DujTas6DqeTYe1c03ecqmXVj/KLJcmSBKIzpz7OsydkjIiyffRN//
        pYmB2pHcGp7kOHKXmH4k5BU9b9rQC8eEnKjs73Xx5hk8sgyQljgxROJwUbCP6bAap88QBxLhW8mT5
        vCXD8i3g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q6Rhm-0042XD-2C;
        Tue, 06 Jun 2023 08:06:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 502DF30026A;
        Tue,  6 Jun 2023 10:06:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 32F8020D1CBDF; Tue,  6 Jun 2023 10:06:14 +0200 (CEST)
Date:   Tue, 6 Jun 2023 10:06:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org
Subject: Re: [tip: sched/core] arm64/arch_timer: Provide noinstr
 sched_clock_read() functions
Message-ID: <20230606080614.GB905437@hirez.programming.kicks-ass.net>
References: <20230519102715.435618812@infradead.org>
 <168599257881.404.5741830687039428221.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168599257881.404.5741830687039428221.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 07:16:18PM -0000, tip-bot2 for Peter Zijlstra wrote:
> @@ -753,14 +771,14 @@ static int arch_timer_set_next_event_phys(unsigned long evt,
>  	return 0;
>  }
>  
> -static u64 arch_counter_get_cnt_mem(struct arch_timer *t, int offset_lo)
> +static noinstr u64 arch_counter_get_cnt_mem(struct arch_timer *t, int offset_lo)
>  {
>  	u32 cnt_lo, cnt_hi, tmp_hi;
>  
>  	do {
> -		cnt_hi = readl_relaxed(t->base + offset_lo + 4);
> -		cnt_lo = readl_relaxed(t->base + offset_lo);
> -		tmp_hi = readl_relaxed(t->base + offset_lo + 4);
> +		cnt_hi = __raw_readl(t->base + offset_lo + 4);
> +		cnt_lo = __raw_readl(t->base + offset_lo);
> +		tmp_hi = __raw_readl(t->base + offset_lo + 4);
>  	} while (cnt_hi != tmp_hi);
>  
>  	return ((u64) cnt_hi << 32) | cnt_lo;

Mark noted that this looses the byteswap :/


---
Subject: arm64/arch_timer: Fix MMIO byteswap

The readl_relaxed() to __raw_readl() change meant to loose the
instrumentation, but also (inadvertently) lost the byteswap.

Fixes: 24ee7607b286 ("arm64/arch_timer: Provide noinstr sched_clock_read() functions")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index b23d23b033cc..e733a2a1927a 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -776,9 +776,9 @@ static noinstr u64 arch_counter_get_cnt_mem(struct arch_timer *t, int offset_lo)
 	u32 cnt_lo, cnt_hi, tmp_hi;
 
 	do {
-		cnt_hi = __raw_readl(t->base + offset_lo + 4);
-		cnt_lo = __raw_readl(t->base + offset_lo);
-		tmp_hi = __raw_readl(t->base + offset_lo + 4);
+		cnt_hi = __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo + 4));
+		cnt_lo = __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo));
+		tmp_hi = __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo + 4));
 	} while (cnt_hi != tmp_hi);
 
 	return ((u64) cnt_hi << 32) | cnt_lo;
