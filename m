Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0835B65C7C9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjACT77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjACT74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:59:56 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6680414097
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:59:55 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id bp26so3935921ilb.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 11:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Xug8HsBhB4vw61CYQrO6p56II484h234IA/MNnX9p8=;
        b=EbYiDfIyp249xUh5FwvkVnPr7aBXtVFVGZSFtl9pIKq68SODoEw8kZPQnYL8sXX69z
         F8E5UHAWixIJOtaSy7hFVhbt6eKa4sXCG4zalB7Ox/hGl++YbRVBW/YzL9Wjbkm4SzAX
         YQKeVGr58BgkVk4yWdEMW4R74YCb6drskvcyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Xug8HsBhB4vw61CYQrO6p56II484h234IA/MNnX9p8=;
        b=6D7poBPeeOCaelAZqAo4aE0/gZYhvftkbzzjg3zKDGPTKZ3fvp/6eG1laMiSVhYxQd
         mEZuCVqjM71PywGVe6qJyT9Iz0BI9fzEa7phoTQaT/9WHD67RNzweut1YSCFYsMiS/KG
         8zSBOu1bQpjm0uEceBqmBUHu39a8YQ5+sBHRd81XzAxbzfS7xp54S6VhsxTxSrctdhMJ
         7IJ0TBu7j2or2jtLAxHANoOxJ+C7HHLwlPmu+PhBAjwVHpcCwfKCAi63tDs6aC2wnc0Z
         NIC/9MGXmqxZ8e7ZtJX8zs5ISPDLkjWdlYmDupEOriE0dV+0ewZrlyv2VFlNNys0LD+f
         wc3A==
X-Gm-Message-State: AFqh2krLLYPqAC4AKcON0Nn5nabZUJrGhCceeh0FFnBtV02oMVSzKhtP
        HcXr25w7sKjIMhB1lwv3J8172VnL1nYoBttQ
X-Google-Smtp-Source: AMrXdXvH1mOE3ls7xK6HFCCTRsyMkSBrn1fZqWTKMIKF6hjvRMojmsYKSg9zlG67AMSf0XqfexnEGw==
X-Received: by 2002:a92:c7c1:0:b0:30c:5319:96c4 with SMTP id g1-20020a92c7c1000000b0030c531996c4mr3545014ilk.13.1672775994535;
        Tue, 03 Jan 2023 11:59:54 -0800 (PST)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id m30-20020a02a15e000000b0038a6ee3c07bsm10418421jah.62.2023.01.03.11.59.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 11:59:54 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id d123so17128677iof.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 11:59:54 -0800 (PST)
X-Received: by 2002:ac8:4913:0:b0:3ab:88cb:97cb with SMTP id
 e19-20020ac84913000000b003ab88cb97cbmr986538qtq.436.1672775691842; Tue, 03
 Jan 2023 11:54:51 -0800 (PST)
MIME-Version: 1.0
References: <20230101162910.710293-1-Jason@zx2c4.com> <20230101162910.710293-3-Jason@zx2c4.com>
 <Y7QIg/hAIk7eZE42@gmail.com> <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
 <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com> <Y7SDgtXayQCy6xT6@zx2c4.com>
In-Reply-To: <Y7SDgtXayQCy6xT6@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Jan 2023 11:54:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
Message-ID: <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org
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

On Tue, Jan 3, 2023 at 11:35 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> I don't think this is about micro-optimization. Rather, userspace RNGs
> aren't really possible in a safe way at the moment.

"Bah, humbug", to quote a modern-time philosopher.

It's humbug simply because it makes two assumptions that aren't even valid:

 (a) that you have to do it in user space in the first place

 (b) that you care about the particular semantics that you are looking for

The thing is, you can just do getrandom(). It's what people already
do. Problem solved.

The system call interface just isn't that expensive. Sure, the various
spectre mitigations have screwed us over in a big way on various
hardware, but even with that in mind system calls aren't some kind of
insurmountable hazard. There are absolutely tons of system calls that
are way more performance-critical than getrandom() has ever been.

So 99% of the time, the solution really is just "getrandom()",
generally with the usual buffering ("read more than you need, so that
you don't do it all the time").\

Which is not at all different from all the other system calls like
"read()" and friends.

And that's entirely ignoring the fact that something like "read()"
basically *has* to be a system call, because there are no alternatives
(ok, mmap, but that's actually much slower, unless you're in it for
the reuse-and/or-sparse-use situation).

With random numbers, you have tons of other alternatives, including
just hardware giving you the random numbers almost for free and you
just using your own rng in user space entirely.

And yes, some users might want to do things like periodic re-seeding,
but we actually do have fast ways to check for periodic events in user
space, ranging from entirely non-kernel things like rdtsc to actual
vdso's for gettimeofday().

So when you say that this isn't about micro-optimizations, I really
say "humbug". It's *clearly* about micro-optimization of an area that
very few people care about, since the alternative is just our existing
"getrandom()" that is not at all horribly slow.

Let me guess: the people you talked to who were excited about this are
mainly just library people?

And they are excited about this not because they actually need the
random numbers themselves, but because they just don't want to do the
work. They want to get nice benchmark numbers, and push the onus of
complexity onto somebody else?

Because the people who actually *use* the random numbers and are *so*
performance-critical about them already have their own per-thread
buffers or what-not, and need to have them anyway because they write
real applications that possibly work on other systems than Linux, but
that *definitely* work on enterprise systems that won't even have this
kind of new support for another several years even if we implemented
it today.

In fact, they probably are people inside of cloud vendors that are
still running 4.x kernels on a large portion of their machines.

          Linus
