Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BDF723B12
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbjFFIN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjFFINz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:13:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25D30C7;
        Tue,  6 Jun 2023 01:13:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8325CAB6;
        Tue,  6 Jun 2023 01:14:38 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.23.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 191CD3F793;
        Tue,  6 Jun 2023 01:13:51 -0700 (PDT)
Date:   Tue, 6 Jun 2023 09:13:44 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org
Subject: Re: [tip: sched/core] arm64/arch_timer: Provide noinstr
 sched_clock_read() functions
Message-ID: <ZH7quID+xqcT4tLi@FVFF77S0Q05N>
References: <20230519102715.435618812@infradead.org>
 <168599257881.404.5741830687039428221.tip-bot2@tip-bot2>
 <20230606080614.GB905437@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606080614.GB905437@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 10:06:14AM +0200, Peter Zijlstra wrote:
> On Mon, Jun 05, 2023 at 07:16:18PM -0000, tip-bot2 for Peter Zijlstra wrote:
> > @@ -753,14 +771,14 @@ static int arch_timer_set_next_event_phys(unsigned long evt,
> >  	return 0;
> >  }
> >  
> > -static u64 arch_counter_get_cnt_mem(struct arch_timer *t, int offset_lo)
> > +static noinstr u64 arch_counter_get_cnt_mem(struct arch_timer *t, int offset_lo)
> >  {
> >  	u32 cnt_lo, cnt_hi, tmp_hi;
> >  
> >  	do {
> > -		cnt_hi = readl_relaxed(t->base + offset_lo + 4);
> > -		cnt_lo = readl_relaxed(t->base + offset_lo);
> > -		tmp_hi = readl_relaxed(t->base + offset_lo + 4);
> > +		cnt_hi = __raw_readl(t->base + offset_lo + 4);
> > +		cnt_lo = __raw_readl(t->base + offset_lo);
> > +		tmp_hi = __raw_readl(t->base + offset_lo + 4);
> >  	} while (cnt_hi != tmp_hi);
> >  
> >  	return ((u64) cnt_hi << 32) | cnt_lo;
> 
> Mark noted that this looses the byteswap :/
> 
> 
> ---
> Subject: arm64/arch_timer: Fix MMIO byteswap
> 
> The readl_relaxed() to __raw_readl() change meant to loose the
> instrumentation, but also (inadvertently) lost the byteswap.
> 
> Fixes: 24ee7607b286 ("arm64/arch_timer: Provide noinstr sched_clock_read() functions")
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index b23d23b033cc..e733a2a1927a 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -776,9 +776,9 @@ static noinstr u64 arch_counter_get_cnt_mem(struct arch_timer *t, int offset_lo)
>  	u32 cnt_lo, cnt_hi, tmp_hi;
>  
>  	do {
> -		cnt_hi = __raw_readl(t->base + offset_lo + 4);
> -		cnt_lo = __raw_readl(t->base + offset_lo);
> -		tmp_hi = __raw_readl(t->base + offset_lo + 4);
> +		cnt_hi = __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo + 4));
> +		cnt_lo = __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo));
> +		tmp_hi = __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo + 4));
>  	} while (cnt_hi != tmp_hi);

This LGTM, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Longer term it'd be good to have noistr-safe forms of the MMIO accessors, but
from a quick play that's a much bigger piece of work, and I think this is fine
for now!

Thanks,
Mark.
