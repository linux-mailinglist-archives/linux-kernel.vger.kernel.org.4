Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91F9663219
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbjAIVAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237829AbjAIU6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:58:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83CB8F2B3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:55:30 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673297709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QtBImeerWqPbZp6EK7tFNjHJVrZNpD+SilDk05oqvCs=;
        b=W8EX8KUkOiJUCEBol4TyA4Mu8Wg6t/S9Qz3eIBTrQil77AwbF3rNePtwiIbUwS7WH0c9pv
        7oXiOpGqwTLG8M7b7IQ1x54fnKy+k4wSUUiONTbpOAY9OudzOYuwqaLp7TkhpGvsebMG0M
        PzunNy2dDldo8XXUhGtfE3hmIABwEMP1Jk8WPbYMh4Z5WzDWwTAveBpKSvKcGfWBR1gGIk
        ssSQ8TS1B6zQ+DHpS2cxDvKoi7hKhQo3xuuLHORZyjV84Ww7R8cAtcki9Gh0d09s12vI0p
        ZSgR/G+4pLDCxnTW3ugPwEyej0teoZ+YC4nWUZnoxrXOzr9DZ4DaFtxJpUIYsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673297709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QtBImeerWqPbZp6EK7tFNjHJVrZNpD+SilDk05oqvCs=;
        b=42LcaGX/RTqEr417RNiI5wDQpG7HDbzqohNSYZfEdyoTrP85SSL2O5tGhiUOHjrRGUZtbf
        /4WKRRt6UYjjUxBw==
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     Yann Sionneau <ysionneau@kalray.eu>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>
Subject: Re: [RFC PATCH 12/25] kvx: Add system call support
In-Reply-To: <20230103164359.24347-13-ysionneau@kalray.eu>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
 <20230103164359.24347-13-ysionneau@kalray.eu>
Date:   Mon, 09 Jan 2023 21:55:08 +0100
Message-ID: <87pmbnjumr.ffs@tglx>
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
> +/***********************************************************************
> +*                  Common exception return path
> +***********************************************************************/
> +/**
> + * Restore registers after exception
> + * When entering this macro, $sp must be located right before regs
> + * storage.
> + */
> +EXCEPTION_ENTRY(return_from_exception)
> +#ifdef CONFIG_DEBUG_EXCEPTION_STACK
> +	ld $r1 = 0[$sp]
> +	;;
> +	sbfd $r1 = $r1, $sp
> +	;;
> +	cb.deqz $r1, _check_ok
> +	;;
> +	make $r2 = panic
> +	make $r0 = stack_error_panic_str_label
> +	;;
> +	icall $r2
> +	;;
> +_check_ok:
> +	addd $sp = $sp, STACK_REG_SIZE
> +	;;
> +#endif
> +	get $r11 = $sr
> +	/* Load sps value from saved registers */
> +	ld $r6 = PT_SPS[$sp]
> +	;;
> +	/* Disable interrupt to check task flags atomically */
> +	disable_interrupt $r60
> +	;;
> +	/* Check PL bit of sps, if set, then it means we are returning
> +	 * to a lower privilege level (ie to user), if so, we need to
> +	 * check work pending. If coming from kernel, directly go to
> +	 * register restoration */
> +	cb.even $r6? _restore_regs
> +	ld $r1 = TASK_TI_FLAGS[$r11]
> +	;;
> +	/* Do we have work pending ? */
> +	andd $r5 = $r1, _TIF_WORK_MASK

Please use the generic entry code to handle pending work, tracing etc.

All over the place....

Thanks,

        tglx
