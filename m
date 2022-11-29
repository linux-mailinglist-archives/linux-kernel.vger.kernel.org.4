Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E292F63C719
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 19:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbiK2SXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 13:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbiK2SXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 13:23:08 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4FC5B592
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 10:23:07 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id r15so9822665qvm.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 10:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n5pwqIj3PrHpdId7vb21KDK9R1X5LK4qhQgrXej7v2w=;
        b=RuyTL10DprGITUjn+JcPkfo84FUio0NZagemjubRT5q9TQOqw32GkOuLDkRwnwWahy
         UkIyEMR2C+Wgz3jOR2/WhDo1WwJHLjLtRK6hNiUnOBdyLbPgMIJsX/rXJi2rvzZIuTwo
         sN3g9gwUipVMdmZULez+/G/FvRL4QMRT18qDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5pwqIj3PrHpdId7vb21KDK9R1X5LK4qhQgrXej7v2w=;
        b=S1u9n3+YIet6v0y/poM0nJpKgytEIKzAHcgMOgjp1MfE6t9Lt0aJNKTZ2jnI8gRl1/
         ur3268XtUjSL9lWah31i6ladR3EEPMLl1z6AsHKUIza46buDuH1D29ASSjl5P/1fPbwC
         liIvgCHgZhrehDCprRTGY9OQRf9JvPAOtARvhM914g1TAKW3EG1VFt0jJZBRYBkATHe6
         r0ENMCM7PIVvl7m81lZmbkiZGEWBpI7pcp7wNmoCI3I8CsrC0YDlR9JtCxzj9oKSqgBX
         +sEDkFCaeahoDDz4hNFlIjaM2US0SX+QrDSn9/n/Ww9V9q6tebUXUm5q7MPRukM11t3n
         FSVQ==
X-Gm-Message-State: ANoB5pk9Hxxb8MmDbIkjOsdOKp+ODQT3vumKnHIEVpjV9VjrUAvpktWc
        6PKzZ5VxyEEfEedsfgYW4XWVtf39Kjhwhw==
X-Google-Smtp-Source: AA0mqf7N77i9wroAKcY1V+lOAZcVALfXWx9OO+RsOMjuX/BaDr7v73Oj77WRJ1tNGngxsnrPC3gSKw==
X-Received: by 2002:a05:6214:590e:b0:4c6:aaeb:6384 with SMTP id lp14-20020a056214590e00b004c6aaeb6384mr34916949qvb.41.1669746186441;
        Tue, 29 Nov 2022 10:23:06 -0800 (PST)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id h9-20020a05620a244900b006fa617ac616sm11102108qkn.49.2022.11.29.10.23.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 10:23:05 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id cg5so9514447qtb.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 10:23:05 -0800 (PST)
X-Received: by 2002:ac8:518b:0:b0:3a5:49fa:3983 with SMTP id
 c11-20020ac8518b000000b003a549fa3983mr53085004qtn.436.1669746184837; Tue, 29
 Nov 2022 10:23:04 -0800 (PST)
MIME-Version: 1.0
References: <Y4YiArbU5h3h4n3s@linutronix.de>
In-Reply-To: <Y4YiArbU5h3h4n3s@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Nov 2022 10:22:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=whU3jhye3kZPq61S0tAkW2sKv2JzGpog1owrv8--ZABhQ@mail.gmail.com>
Message-ID: <CAHk-=whU3jhye3kZPq61S0tAkW2sKv2JzGpog1owrv8--ZABhQ@mail.gmail.com>
Subject: Re: [PATCH] signal: Allow tasks to cache one sigqueue struct (again).
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 7:15 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> The idea for this originates from the real time tree to make signal
> delivery for realtime applications more efficient.

NAK.

This was attempted once. It had unexplained problems, and very unclear locking.

And this new version is THE SAME CRAZY STUFF. That whole
sigqueue_cache_or_free() hasn't been improved, and is just a thousand
monkeys on crack typing wildly on a keyboard.

This updated patch seems to *attempt* to do everything under the
sighand->siglock, and several of the comments point to it.

But - exactly like the first version - that isn't actually always
true, so it then does *other* random tests instead.

And in at least one case - sigqueue_free() - this code *literally* does that

        spin_unlock_irqrestore(lock, flags);

        if (q)
                __sigqueue_cache_or_free(q);

where that "spin_unlock_irqrestore()" just released 'sighand->siglock'
which is what allegedly is protecting this all.

In other words, STOP DOING THIS.

Insanity is doing the same thing over and over again, expecting
different results. This is insanity.

We have a couple of alternatives here:

 (a) do it *properly* and obviously under that sighand->lock in EVERY
SINGLE PATH.

     None of these games with random code paths either having the lock
conditionally (the 'sigqueue_flags' in __sigqueue_alloc()).

     And none of these "I just dropped the lock, and then free the cache"

 (b) alternatively, do no locking at all, and depend on 'current'
being single-threaded, and _only_ do it in task-synchronous contexts
(so no interrupts)

 (c) use proper atomics that don't *need* locking (ie "xchg(p,NULL)"
kind of things)

but no, we do not repeat the mistake of mixing (a) and (b) with random code.

And exactly because we've already done this once - badly - I want the
new code to be *obviously* correct.

That very much means "don't try to revive a patch that was already
reverted because it was broken and didn't make sense". Throw this
patch AWAY. It's not worth reviving. Start from scratch, with that
"this needs to be _obviously_ correct" as the starting point.

Honestly, I suspect the proper approach is:

 - absolutely *no* "test if task is dead". Free the last left-over
cached entry as you free the 'struct task_struct".

   Stop doing these "test random other unrelated flags".

   If you cannot based it on just the cache field and the lock, DON'T
DO IT AT ALL.

 - absolutely no "test the 'sigqueue_flags' argument".

   Again, stop doing these "test random flags".

   Either only do the "do I have a cached entry" in the path that
unambiguously already holds the lock!

   Or do a cache-specific lock (ie "use atomics") so that it doesn't
*matter* whether the lock is held.

 - make every step *so* obvious that you don't even need a comment.

   And then add the comment about it anyway.

Ok? Because I never want to see this broken approach again.

                Linus
