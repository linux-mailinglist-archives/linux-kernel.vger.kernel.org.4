Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201D85EC6E7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiI0Ov2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiI0Ou4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:50:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA58E1E717
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:49:46 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664290185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CIBbc7Ixz0yANnUMl+8HLGWXcOy/Ot1heesGkqB0K/E=;
        b=MPLSul4d3QU5Mfo3jZO6sobZ61PTC0AjhGsv3l02R2EijqP9J2CXq58CXRoURqKDYhjFF6
        U2KSPbzqahC8TT4g5w2ZgeZ0cm0uJFXoWlarodbxSMWYe//5Eo3wT4VfhEsb4hmUIwZMhe
        t/F2Ueh05p6FZZHCr2tZw/167Qbqqmhw1yr8tX1ZfFVO5lzPXcFIX7yWKjHG2vDkYIiUfA
        OXLqJl/WWzNs3Ys96HkgKfYHqoW+dsV9oBoLr9hwHJt/6CfQdTqcjEJo0uTgMbWrkgbsho
        KQm0rcP4ChqVXQ5YOoeNfvQya7pi3W11ZRmcXJy7o+68JVJc/TkGu5vRQsxYzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664290185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CIBbc7Ixz0yANnUMl+8HLGWXcOy/Ot1heesGkqB0K/E=;
        b=BgOdwAxVWYluZ6fTRlN1UtTV6pLNICTlgjFsnhaur0Yy/mT2Aq/HAoXXzfDZUwjqBJ0jK6
        0gKTynPLMLyTnlAA==
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [patch RFC 28/29] printk: Provide functions for atomic write
 enforcement
In-Reply-To: <20220910222301.995758602@linutronix.de>
References: <20220910221947.171557773@linutronix.de>
 <20220910222301.995758602@linutronix.de>
Date:   Tue, 27 Sep 2022 16:55:44 +0206
Message-ID: <87k05olvnb.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a fix that was used for the LPC2022 demo so that after a
warning, the atomic printing context is not responsible for printing any
non-emergency backlog that came after the warning.

On 2022-09-11, Thomas Gleixner <tglx@linutronix.de> wrote:
> --- a/kernel/printk/printk_nobkl.c
> +++ b/kernel/printk/printk_nobkl.c
> + * cons_atomic_flush_one - Flush one console in atomic mode
> + * @con:	The console to flush
> + * @prio:	The priority of the current context
> + */
> +static void cons_atomic_flush_one(struct console *con, enum cons_prio prio)
> +{
> +	struct cons_write_context *wctxt = cons_get_wctxt(con, prio);
> +	struct cons_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +
> +	if (!cons_atomic_try_acquire(con, ctxt, prio))
> +		return;
> +
> +	do {
> +		/*
> +		 * cons_emit_record() returns false when the console was
> +		 * handed over or taken over. In both cases the context is
> +		 * not longer valid.
> +		 */
> +		if (!cons_emit_record(wctxt))
> +			return;

If the CPU is no longer in an elevated priority and kthreads are
available, abort the atomic printing and let the kthreads take over. Add
the following break condition here:

		/*
		 * If the CPU is no longer in an elevated priority, let the
		 * kthreads take over, if they are available.
		 */
		if (prio <= CONS_PRIO_NORMAL && con->kthread)
			break;


> +	} while (ctxt->backlog);
> +
> +	cons_release(ctxt);
> +}

John Ogness
