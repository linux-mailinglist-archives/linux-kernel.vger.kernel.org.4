Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E5E5EC6C4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiI0OrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbiI0Oqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:46:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80BB57545
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:40:49 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664289647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XoBJBmZ5UAwI42BPOdJ+eigxCsaa7zGOoB8JqcvHGZU=;
        b=dnIaWaAg6g6tnH5NlwAQg8kS87oziPYVinVpkIlbcGIKoDeSqbFcSJwx+egsf1t/+hJXgP
        STLZ4mYAGH16DWBAwgiMarfRdhEKxLFUbC//+2c6YMy4l8PSdQ3LtKYO5hWOsK43cCKUU3
        l5u7g32kUz3qTDw6J1mbS3JzssSAV71XmzkkFpwXHSDbdjHBS2KjNGnqU0b2RoSFT8UNHl
        y7ITm5qyBmOyP3pvwXCaR4Qpmdl+S4gs+bjDCGfi9kOA+d6vzbIAWgJw/Ig6nc8/gyzala
        POihYc/zgxafFGVJhtCIz0akpnEshhevbe20CzxDCE6Hx14V3vu+28g6oAA02A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664289647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XoBJBmZ5UAwI42BPOdJ+eigxCsaa7zGOoB8JqcvHGZU=;
        b=K5+W7osXpHjlV1/Jg3G61fqndpnAVpEKJ1UqEkaHdFLHYCVx/+HIy51o7FRaY2LGMumWwi
        u+v9EjYBYm4m0SDQ==
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
Date:   Tue, 27 Sep 2022 16:46:46 +0206
Message-ID: <87mtaklw29.fsf@jogness.linutronix.de>
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

Below is a fix that was used for the LPC2022 demo so that an
interrupting context does not clobber the console state when the
interrupted context was the console owner.

On 2022-09-11, Thomas Gleixner <tglx@linutronix.de> wrote:
> --- a/kernel/printk/printk_nobkl.c
> +++ b/kernel/printk/printk_nobkl.c
> +/**
> + * cons_atomic_flush_one - Flush one console in atomic mode
> + * @con:	The console to flush
> + * @prio:	The priority of the current context
> + */
> +static void cons_atomic_flush_one(struct console *con, enum cons_prio prio)
> +{
> +	struct cons_write_context *wctxt = cons_get_wctxt(con, prio);
> +	struct cons_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);

@ctxt is per-console, per-cpu, and per-prio. But it is *not*
per-context. If a CPU is in EMERGENCY priority and is interrupted by
another context that calls into printk() while the first context had the
console locked, the following cons_atomic_try_acquire() will use the
same ctxt and clobber the values used by the first context. This
corrupts the state information for the first context and results in
situations where the console is never unlocked because the owner's state
was corrupt.

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
> +	} while (ctxt->backlog);
> +
> +	cons_release(ctxt);
> +}

Since it is not desirable to actively print from nested contexts
of the same priority, add an @in_use flag to wctxt, allowing to
detect the situation and avoid active printing and corrupting
the state.

Applying the following patch on top does just that:

diff --git a/include/linux/console.h b/include/linux/console.h
index e6bde0e879fc..1b3028cce3f3 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -317,6 +317,7 @@ struct cons_context {
  * @len:	Length to write
  * @pos:	Current write position in @outbuf
  * @unsafe:	Invoked in unsafe state due to force takeover
+ * @in_use:	The context is in use
  */
 struct cons_write_context {
 	struct cons_context __private	ctxt;
@@ -324,6 +325,7 @@ struct cons_write_context {
 	unsigned int			len;
 	unsigned int			pos;
 	bool				unsafe;
+	bool				in_use;
 };
 
 #define CONS_MAX_NEST_LVL	8
diff --git a/kernel/printk/printk_nobkl.c b/kernel/printk/printk_nobkl.c
index 736f71361799..b513b2fb2c2d 100644
--- a/kernel/printk/printk_nobkl.c
+++ b/kernel/printk/printk_nobkl.c
@@ -1338,8 +1338,12 @@ static void cons_atomic_flush_one(struct console *con, enum cons_prio prio)
 	struct cons_write_context *wctxt = cons_get_wctxt(con, prio);
 	struct cons_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
 
-	if (!cons_atomic_try_acquire(con, ctxt, prio))
+	if (wctxt->in_use)
 		return;
+	wctxt->in_use = true;
+
+	if (!cons_atomic_try_acquire(con, ctxt, prio))
+		goto out;
 
 	do {
 		/*
@@ -1348,10 +1352,12 @@ static void cons_atomic_flush_one(struct console *con, enum cons_prio prio)
 		 * not longer valid.
 		 */
 		if (!cons_emit_record(wctxt))
-			return;
+			goto out;
 	} while (ctxt->backlog);
 
 	cons_release(ctxt);
+out:
+	wctxt->in_use = false;
 }
 
 /**

John Ogness
