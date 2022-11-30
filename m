Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC00463D29E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiK3J6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiK3J6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:58:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C892E697
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:58:34 -0800 (PST)
Date:   Wed, 30 Nov 2022 10:58:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669802312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rYQvpCX5CmODpLH+qzBy5bciqEOghCapy1UrUvPqIxA=;
        b=sPKRQX1AabuzhixHmnNym5p3eQoRlojWOC/HLhbXG5AemK3wRLXIMM9vB2wyASxWQyV7j+
        dZZOpTysW3q2IYxQF+NvdoElWB9FfLcxunOLukxSpvmREGDyWlLjRQwP1IvsBaslrIusEp
        LKvTCaVvJbf+Rbckpz8sW+gQ2HDZBf0lEu7x/mrKAmptYfqt4YWBOqOO39qTKjs9VWORnE
        23lCbUOB6oBoo+64k3Cg0HcDGuD8ndhbvJ1MOvBMzsZrg/P3ILTnz/X2b1/qd98Dy1ciSt
        1rWJVn26rlx7WkV1WGeCf0C8ehMKtyt/Yebx2cB0mrmXZhHqpD7PZ8tRgLzqew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669802312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rYQvpCX5CmODpLH+qzBy5bciqEOghCapy1UrUvPqIxA=;
        b=QiqAQpsAIQbtp9FHanxDoF1PDzR0g1Ib3IoLVXOwnXPRDz53qv335XEoZTs3viRhwHGvWL
        PI5l4moI9I46cUAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ben Segall <bsegall@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] signal: Allow tasks to cache one sigqueue struct (again).
Message-ID: <Y4cpRRMXiA6RHsXL@linutronix.de>
References: <Y4YiArbU5h3h4n3s@linutronix.de>
 <CAHk-=whU3jhye3kZPq61S0tAkW2sKv2JzGpog1owrv8--ZABhQ@mail.gmail.com>
 <CAHk-=wiJ9BoQadX7aefY8LEEZ4CJFTEWpAyKV0CzL3yu3Xybdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiJ9BoQadX7aefY8LEEZ4CJFTEWpAyKV0CzL3yu3Xybdw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-29 12:06:22 [-0800], Linus Torvalds wrote:
> In other words, this is *really* meant as not a good patch, but as a
> "can we please go in this direction instead".
> 
> And yes, maybe some other "free this siginfo" paths should *also* do
> that "try to add it to the cache, and if so, you're done" after doing
> the accounting. So this is probably all mis-guided, but I ended up
> wanting to just see how an alternative approach would look, and this
> feels a lot safer to me.

That one case which was not covered by the sighand lock was clearly an
oversight. It should have been under the sighand. The commit description
said so.

> We already have that SIGQUEUE_PREALLOC case, why not use some of the
> same logic for the cached entry. Sure, it bypasses the rlimit, but
> what else is new?

You need set sigqueue_cache to NULL in copy_process().

The SIGQUEUE_PREALLOC signals work slightly different. It is allocated
once at timer_create(2) time and can send a signal multiple times before
finally removed by timer_delete(2). So the signal delivery is, in a way,
already cached. The caching here for timer_create(2) does not work as
__send_signal_locked() (where you grab the cached struct) isn't used by
that code using SIGQUEUE_PREALLOC.
Instead it allocates its sigqueue via sigqueue_alloc() while not holding
the sighand lock.
So after a timer_delete(2), the next signal it receives (which is not
from a posix timer/ SIGQUEUE_PREALLOC) would be from the cache.

>               Linus

Sebastian
