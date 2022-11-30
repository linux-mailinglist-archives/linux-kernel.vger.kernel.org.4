Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6184063D4B2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbiK3LeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbiK3Ld3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:33:29 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE122DCD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:32:42 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id a17so9986965qvt.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hFKaHqzbGlUEM8rKZvcD8m1MwmFaEM8f9ElXQHb0zpQ=;
        b=YmX4SKq8IPWagj5OQjGf+up9sfCBJF1xdK9qLZSdy4lGHzt5aikzMdwPUAzfr26mW2
         tdl11J7vulBrAXk9Iu+27zOeoar4kzYoQ3/tLkaEnaD/8NNKWFuW4YW1Jtu9ANIjuyhO
         oRtdCz7I4XyRTjmGEhTUfLyWW+zX/ND0F42m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFKaHqzbGlUEM8rKZvcD8m1MwmFaEM8f9ElXQHb0zpQ=;
        b=O+C/kMOcBtxppB5eTc9lAmRRW0hQpcco90qBMMxJOsDncm3/isKON8dhuufrpvu3p5
         RRudONmvc4usG37CknnCmNAeyfu6cZSMNp+ZTNfSA8w6IXPxh/bTJc8xLpeuYVJB/0pG
         eZpFNioGZQSLWR05g/WerJ1UuWfa6l8OPE3w/rSUG1b05ZKwmxFc4KZawrdg1GTa3Ddw
         cNlv4Ga8SLIaJ0y2pZGkB01m+VT+tUMEq3kzqPntyCeQ7EwJFbgXaRyXJVvoT+ie0kub
         UcD9yoaPymWxiCMzyMfKrHlCH+kdUa6WwbetbIE+oqvUelyeifove0DxDvTjTAw/wTo8
         2Cdg==
X-Gm-Message-State: ANoB5pm4L4i2w4+8BBzksQKqVNUyIzmsy1NcIt/+4O7KVFNYELIPkHXg
        QZsdVqu6vNf3IiNPHZ9XAmediAqvHrhPew==
X-Google-Smtp-Source: AA0mqf7ZV07pZyHaQAFftTTRGWH6Mz2Cuih1d9ssUHJgo3zWCjgKHdXk4zCLI57Pse7C+62QML4UDA==
X-Received: by 2002:a05:6214:4585:b0:4c6:82cd:de09 with SMTP id op5-20020a056214458500b004c682cdde09mr39736033qvb.119.1669807961603;
        Wed, 30 Nov 2022 03:32:41 -0800 (PST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id u11-20020a05620a0c4b00b006fc8fc061f7sm888378qki.129.2022.11.30.03.32.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 03:32:40 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id fz10so10890353qtb.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:32:39 -0800 (PST)
X-Received: by 2002:a05:622a:5a87:b0:3a5:47de:a214 with SMTP id
 fz7-20020a05622a5a8700b003a547dea214mr40297480qtb.304.1669807959062; Wed, 30
 Nov 2022 03:32:39 -0800 (PST)
MIME-Version: 1.0
References: <Y4YiArbU5h3h4n3s@linutronix.de> <CAHk-=whU3jhye3kZPq61S0tAkW2sKv2JzGpog1owrv8--ZABhQ@mail.gmail.com>
 <CAHk-=wiJ9BoQadX7aefY8LEEZ4CJFTEWpAyKV0CzL3yu3Xybdw@mail.gmail.com> <Y4cpRRMXiA6RHsXL@linutronix.de>
In-Reply-To: <Y4cpRRMXiA6RHsXL@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Nov 2022 03:32:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wizzhP-h-4V-CD7vyq3Emf6YGHmfvZkhx6v+40xqgWWaQ@mail.gmail.com>
Message-ID: <CAHk-=wizzhP-h-4V-CD7vyq3Emf6YGHmfvZkhx6v+40xqgWWaQ@mail.gmail.com>
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

On Wed, Nov 30, 2022 at 1:58 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> That one case which was not covered by the sighand lock was clearly an
> oversight. It should have been under the sighand. The commit description
> said so.

Well, I think it was more than an oversight - it looks like it came
from basically starting from that old known-bad patch, which did the
same thing, with __sigqueue_free() intentionally called outside the
lock.

Which really is why I'm unhappy about that patch. We _know_ there were
some (possibly not entirely debugged) problems with the original
patch, and from a quick look I could find at least one remaining
oddity, and several remaining ugly cases.

Who knows - that issue with sigqueue_free() calling __sigqueue_free()
outside the lock may be what was the problem originally too, and that
caused the revert in the first place (I'm not sure we ever actually
had it ever debugged more than "this is reported to cause problems").

I suspect it would be best to not have that "do the cache case in the
normal alloc/free path" exactly because the normal alloc/free patch is
used in situations where we just don't hold that lock. Either because
of the 'sigqueue_flags' issue on the allocation path, or because - as
here - the freeing path was done separately after having dropped the
lock (to avoid lock contention, I assume).

Maybe just having the cache alloc/free be a separate function would solve it?

Or maybe that sigqueue_free() locking optimization should just be
undone, and maybe that fixes everything. Maybe that was always the
only actual bug in the original code. But I really dislike those other
games it plays too.

> You need set sigqueue_cache to NULL in copy_process().

Ack.

> The SIGQUEUE_PREALLOC signals work slightly different.

Yeah, I think that SIGQUEUE_PREALLOC hack of mine was a mistake, it
looked like a good idea in that sigqueue_free() path that I started
looking at, but it's probably a horrible idea in general.

But that "please don't use a known-broken patch as the starting point"
argument remains.

              Linus
