Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E155EC11A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiI0LWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiI0LUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:20:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909161A05D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:20:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1FA24CE18AC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 11:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27908C4314E;
        Tue, 27 Sep 2022 11:20:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hWUqcvJ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664277640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=deeBd+dJsBe9w1g/cXfb8wK3HIlOdnJfRnJMuUjpenc=;
        b=hWUqcvJ05RJLEv3tf9Bsjddk+QVWRgYRBuLyRS4grAv3P6sEnVatOk/nDVf7xqosmxbvH5
        RxaBqCsVnWGP1qyijN8akE+vRp6w1ljCkcJTO1fMMG3qpRagym4uUo+ERDWRoBb2bdt9fE
        hungJNiLNVQt9my3XsQsOM47S/00HQM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e95295fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 27 Sep 2022 11:20:40 +0000 (UTC)
Date:   Tue, 27 Sep 2022 13:20:38 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 2/2] lib/vsprintf: Initialize vsprintf's pointer hash
 once the random core is ready.
Message-ID: <YzLchr32qSKgN4vC@zx2c4.com>
References: <20220927104912.622645-1-bigeasy@linutronix.de>
 <20220927104912.622645-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220927104912.622645-3-bigeasy@linutronix.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You added my Acked-by already (which is fine), but I thought I should
still add some final notes to that ack, for posterity:

On Tue, Sep 27, 2022 at 12:49:12PM +0200, Sebastian Andrzej Siewior wrote:
> The printk code invokes vnsprintf in order to compute the complete
> string before adding it into its buffer. This happens in an IRQ-off
> region which leads to a warning on PREEMPT_RT in the random code if the
> format strings contains a %p for pointer printing. This happens because
> the random core acquires locks which become sleeping locks on PREEMPT_RT
> which must not be acquired with disabled interrupts and or preemption
> disabled.
> By default the pointers are hashed which requires a random value on the
> first invocation (either by printk or another user which comes first.
> 
> One could argue that there is no need for printk to disable interrupts
> during the vsprintf() invocation which would fix the just mentioned
> problem. However printk itself can be invoked in a context with
> disabled interrupts which would lead to the very same problem.
> 
> Move the initialization of ptr_key into a worker and schedule it from
> subsys_initcall(). This happens early but after the workqueue subsystem
> is ready. Use get_random_bytes() to retrieve the random value if the RNG
> core is ready, otherwise schedule a worker in two seconds and try again.
> 
> Reported-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>

I really do hate the idea of polling every 2 seconds. But as we
discussed, this seems like the least bad solution, at least for now. If
we discover another bug in the tree that needs a gross solution like
that, then at that point, I'll move ahead with adding a notifier_block
to random.c, to avoid polling. But so long as this is a one-off (as we
understand it to be at the moment), this seems okay.

Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>

Jason
