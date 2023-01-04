Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7FA65D15D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 12:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbjADL2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 06:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbjADL2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:28:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FE441AA33
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 03:28:08 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 246B11596;
        Wed,  4 Jan 2023 03:28:50 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.37.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 736F03F587;
        Wed,  4 Jan 2023 03:28:07 -0800 (PST)
Date:   Wed, 4 Jan 2023 11:28:04 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>
Subject: Re: [RFC PATCH 13/25] kvx: Add signal handling support
Message-ID: <Y7VixOou0y+VPIXS@FVFF77S0Q05N>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
 <20230103164359.24347-14-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103164359.24347-14-ysionneau@kalray.eu>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 05:43:47PM +0100, Yann Sionneau wrote:
> Add sigcontext definition and signal handling support for
> kvx.

[...]

> +asmlinkage void do_work_pending(struct pt_regs *regs,
> +				unsigned long thread_flags)
> +{
> +	/* We are called with IRQs disabled */
> +	trace_hardirqs_off();
> +
> +	do {
> +		if (thread_flags & _TIF_NEED_RESCHED) {
> +			schedule();
> +		} else {
> +			local_irq_enable();
> +			if (thread_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
> +				do_signal(regs);
> +
> +			if (thread_flags & _TIF_NOTIFY_RESUME) {
> +				clear_thread_flag(TIF_NOTIFY_RESUME);
> +				resume_user_mode_work(regs);
> +			}
> +		}
> +		/* Guarantee task flag atomic read */
> +		local_irq_disable();
> +		thread_flags = READ_ONCE(current_thread_info()->flags);

The comment here is a bit misleading; disabling IRQs doesn't affect the
atomicity of the read (and flags can be set by remote threads), so I'd
recommend removing it.

Please use read_thread_flags() to read the flags.

> +	} while (thread_flags & _TIF_WORK_MASK);
> +}

Thanks,
Mark.
