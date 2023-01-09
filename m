Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323E56631FC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237669AbjAIU4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237732AbjAIUzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:55:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3628B51F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:54:36 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673297674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8qeFEqQ4IOt0anyptkgiI7e33u5DzSFvrnoNG8eLIZQ=;
        b=ajGUQOrML1zNkR0fk1KotYKMBAKwWsIx59GbeDyE0wI+qcgyK4U/vkgT/nPrjQVdVkGkw7
        6+QXFbeM8O181U4mauwY+WOCSVrZwELqcTEJ+k5BQQ/X2EP+XjmWP25NpnmItu+4w/AI7F
        EDaJXZusSCZ6Ow0KFsCm2sQbwqMCmhcvjTL7M+ouoelK6yWgvEc7n9BFLcA4e/zjhCTN6h
        gd1OXwt7+L3leHEutPRSJndR4VnpzMGxIGrlXkf3N1PPKn8CW8waBY2trMDIFTJaksblD9
        ea0aRLLCEEeIaqLxGm9QnaPZGjZ3JgJPsAeSpLpxPSunKIHu+PJ/p9rW1sGj2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673297674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8qeFEqQ4IOt0anyptkgiI7e33u5DzSFvrnoNG8eLIZQ=;
        b=FAbVYPDt08Nmj0VDublDd2siRaJWY8yB9QByTJvMOBEs/PM6eBJ1fKfRQMkUjcvSIj4hl0
        Zu7v2rMJPNDl0YCg==
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     Yann Sionneau <ysionneau@kalray.eu>, linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>
Subject: Re: [RFC PATCH 08/25] kvx: Add exception/interrupt handling
In-Reply-To: <20230103164359.24347-9-ysionneau@kalray.eu>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
 <20230103164359.24347-9-ysionneau@kalray.eu>
Date:   Mon, 09 Jan 2023 21:54:33 +0100
Message-ID: <87r0w3junq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03 2023 at 17:43, Yann Sionneau wrote:
> --- /dev/null
> +++ b/arch/kvx/kernel/irq.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2017-2023 Kalray Inc.
> + * Author(s): Clement Leger
> + */
> +
> +#include <linux/irqdomain.h>
> +#include <linux/irqflags.h>
> +#include <linux/hardirq.h>
> +#include <linux/irqchip.h>
> +#include <linux/bitops.h>
> +#include <linux/init.h>
> +
> +#include <asm/dame.h>
> +
> +#define IT_MASK(__it) (KVX_SFR_ILL_ ## __it ## _MASK)
> +#define IT_LEVEL(__it, __level) \
> +	(__level##ULL << KVX_SFR_ILL_ ## __it ## _SHIFT)
> +
> +void do_IRQ(unsigned long hwirq_mask, struct pt_regs *regs)
> +{
> +	struct pt_regs *old_regs = set_irq_regs(regs);
> +	int irq;
> +	unsigned int hwirq;
> +
> +	trace_hardirqs_off();
> +
> +	irq_enter();

Please use the generic entry code for interrupts to handle tracing,
irq_enter() etc. correctly.

> +/**
> + * trap_handler - trap handler called by _trap_handler routine in trap_handler.S
> + * This handler will redirect to other trap handlers if present
> + * If not then it will do a generic action
> + * @es: Exception Syndrome register value
> + * @ea: Exception Address register
> + * @regs: pointer to registers saved when trapping
> + */
> +void trap_handler(uint64_t es, uint64_t ea, struct pt_regs *regs)
> +{
> +	enum ctx_state prev_state = exception_enter();

Please do not implement exception_enter/exit(). Use the generic entry
handling code so your code is correct and extensible.

Thanks,

        tglx
