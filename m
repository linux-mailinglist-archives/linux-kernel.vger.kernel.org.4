Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F53747971
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 23:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGDVL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 17:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGDVL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 17:11:27 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04543B6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 14:11:26 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fa16c6a85cso9354689e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 14:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688505084; x=1691097084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7OcYoyp9zrXAWwGmr1xgHzDvXudU/vsZ1gHRM/15ODE=;
        b=aXWJ0QrlfEm/r62vgNW9TWiXY27P5YvwFYQkXpJCfQJYuk/nChjZZpcNCpsnye7G7q
         wRw8lcz2LYbxn4E5LMkjmMOR56scYdo2TEjVEkFZ71PjURY9b2GIebgYzwViyxzk7kYN
         4wQ8Y4Ln7eCZjMqSJ7AixeMJxFdCZcFogpVUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688505084; x=1691097084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OcYoyp9zrXAWwGmr1xgHzDvXudU/vsZ1gHRM/15ODE=;
        b=W/uc+DwHmnu6l7nKKpH4ZjiLv4s9KIxyEiHS2fifUbyy2UoeMF7ND+cJPkvcLyTLwK
         rwuSgZpHz2vfbXxaAXrBNbw6ddojZLD5c5BQbS4/28bs9dG73M7JexDJHwv2Co7s1AFq
         5QicCjUjVfYUBRQlj6tPbS06XZa2DjFvtgGh1bq41DPjQUfrCDL3Qsnj4r1NDZWT/Vem
         zZwUCqXVN4ZgbcLuLNYZzycEd6IAY6NlytG6EEPM8Xzyl2prGcVwMCuDNTW/0yKZW/2D
         v4mfvMBXz/fkU549Ux+1yMxyHfs6XGYwIAK3NxppkaFnYkeCLLYYnGfcMg5WBeRgKasA
         karg==
X-Gm-Message-State: ABy/qLYlIQm34LnmgeYV8OuUXkW40dZUGNoBgHTnsR6sP5S3M8Ql7sA5
        5ojfRt1F0z37P4u+ypmeDQALK0GN/KI/bIwamgCcCNYK
X-Google-Smtp-Source: APBJJlFgD0MixQY5tV4s3lKlOKgA1e21tyK3kF367Z23alvgYui2aYM8Gta1UG6luvrGEvLsYcJu7w==
X-Received: by 2002:ac2:5e6b:0:b0:4f8:bfb4:e4c4 with SMTP id a11-20020ac25e6b000000b004f8bfb4e4c4mr9073048lfr.19.1688505084008;
        Tue, 04 Jul 2023 14:11:24 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id w15-20020ac2598f000000b004fbab4b7d45sm2270536lfn.67.2023.07.04.14.11.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 14:11:22 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4fb8574a3a1so9358555e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 14:11:22 -0700 (PDT)
X-Received: by 2002:a05:6512:acb:b0:4f8:661f:60a4 with SMTP id
 n11-20020a0565120acb00b004f8661f60a4mr11584978lfu.41.1688505082398; Tue, 04
 Jul 2023 14:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230626125726.GU4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230626125726.GU4253@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jul 2023 14:11:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjsb5gZTvhXofPCQthk48S9_bSGohXKU8x8XDnf7=bROw@mail.gmail.com>
Message-ID: <CAHk-=wjsb5gZTvhXofPCQthk48S9_bSGohXKU8x8XDnf7=bROw@mail.gmail.com>
Subject: Re: [GIT PULL] Scope-based Resource Management for 6.5
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 at 05:57, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Please consider pulling the SBRM infrastructure so that people can start
> building upon it. Specifically Greg also wants to start using this soon.
>
> Once this lands, I'll start to trickle in the conversions I've done for
> the next release.

So things are quiet (partly presumably due to July 4th in the US) and
I've mostly emptied my merge window queue, so I've pulled this since I
obviously was happy with the final syntax.

However, let's agree to not really use it for 6.5 yet, and consider it
all purely infrastructure for the next release, and for testing it all
out in linux-next etc.

We should probably also strive to avoid it for bug-fixes that end up
going to stable. I'm sure this will all be backported to stable
eventually, but I'd at least personally be happier if that started
happening only after we actually have some more interaction with this.

I hope - and expect - that the core compiler infrastructure should be
stable due to C++ uses of destructors, but I also note that at least
in the system headers I have, the only use of the __cleanup__
attribute seems to be a very special pthread_cleanup_push() helper,
and some (fairly minimal) glib use in the g_auto*() types.

So this attribute has been around forever, and the low-level
functionality has presumably gotten a lot of testing, but at the same
time it really looks like the C interface is somewhat limited in its
use.

I did do a Debian core search on g_autoptr() use, and in the first ten
pages, most uses seemed to be either comments or tests. But there are
certainly *some* real users too.

Anyway, I did find enough use that I'm not worried, but I'd still like
us to take this somewhat slowly.

Let's *not* treat this as a "W00t! Black Friday at Walmart! Everybody
rush in at once!"

             Linus
