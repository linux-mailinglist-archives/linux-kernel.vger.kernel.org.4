Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D584641F73
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 21:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiLDUSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 15:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiLDUR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 15:17:58 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86603B02
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 12:17:56 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id l15so10206193qtv.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 12:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f8NYc7EM2IXtxuh3+i3Wr2qsy0YCzgxsK6G124ZiKxs=;
        b=QNyR8J4FWGkJDH1uMJUuRQ7dYv+ynzw21s/LyMWN1Pg8knCFhy7FW7VhlPZ2xQZs2b
         AL54p6NWnznEEGxyV4ZGDXhtz6/Qe3Y43lHdXVHyAeNc6GV+dy1XTlKXMrew3ztdKOXX
         KD+LWsnzq/ol6XAvzctbIk6ZUts1AVsyn95yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8NYc7EM2IXtxuh3+i3Wr2qsy0YCzgxsK6G124ZiKxs=;
        b=xjPZhWlRvQhHAecl+bKEPox3hPJs4cogaRiMgwJe4iKAfbOfAlQt30h6EOTGNwf3+M
         mg/wqCABH8G5P8PHjhSqTjnyJQ6hmxbinRuahtATIyzdx27QRoVbWCCy8+WBy+TGF8KG
         64Jy1tqN95V3HnsEv6k0J7AE8jJXtiELQN9TVSGCAC9hAOvEx+RLt6Vk7idOVDKEvK/x
         JeJQX3tHWjGKFk51ri8yvTODBppn+cg5kM4B6Lanhkj6IVfvFTJoAkNcx7YjFL+VLjS3
         GQSKpwktyLZvAetZoShEeYP3LOWao90BTpgXpeQ8MJ2zLaBzBL66UAsKMfMwxGtEaYlD
         nTDA==
X-Gm-Message-State: ANoB5pmcgU4KZMI63K4zQs7fiYYUWE4FnJMe//raBd7mHC3ScgluAF4D
        czKktW5hyVUB+CnJCjPAvqmRVs/ktWprWHcx
X-Google-Smtp-Source: AA0mqf6oDV4hufbRK3fS8qqPYO8YOIV/yfx4qqTyhHH8nHS7Q2pWVdLGVnw64ayki0XmxxiNweK6kA==
X-Received: by 2002:ac8:4918:0:b0:35b:b345:cf5f with SMTP id e24-20020ac84918000000b0035bb345cf5fmr74002313qtq.566.1670185075248;
        Sun, 04 Dec 2022 12:17:55 -0800 (PST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com. [209.85.222.179])
        by smtp.gmail.com with ESMTPSA id cj5-20020a05622a258500b00397e97baa96sm8533180qtb.0.2022.12.04.12.17.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 12:17:54 -0800 (PST)
Received: by mail-qk1-f179.google.com with SMTP id c2so3624212qko.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 12:17:53 -0800 (PST)
X-Received: by 2002:a37:54e:0:b0:6fc:c48b:8eab with SMTP id
 75-20020a37054e000000b006fcc48b8eabmr5679851qkf.216.1670185073545; Sun, 04
 Dec 2022 12:17:53 -0800 (PST)
MIME-Version: 1.0
References: <20221203150539.11483-1-brgl@bgdev.pl>
In-Reply-To: <20221203150539.11483-1-brgl@bgdev.pl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Dec 2022 12:17:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjD8+XZyO4H1STwXte6x1UcYsiHKaQ4OQF5ucssY=uT8g@mail.gmail.com>
Message-ID: <CAHk-=wjD8+XZyO4H1STwXte6x1UcYsiHKaQ4OQF5ucssY=uT8g@mail.gmail.com>
Subject: Re: [GIT PULL] gpio: fixes for v6.1-rc8 - take 2
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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

On Sat, Dec 3, 2022 at 7:05 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> Here's a fixed PR from the GPIO subsystem for the next rc.

No, this cannot be right.

That last commit seems *very* dubious, and in particular all those

        if (!down_read_trylock(&gdev->sem))
                return EPOLLHUP | EPOLLERR;

are a sign that something is very very wrong there.

Either the lock is necessary or it isn't, and "trylock" isn't the way
to deal with it, with random failures if you cannot take the lock.

If you are using "trylock" because the data structure might go away
from under you, you have already lost, and the code is buggy.

And if the data structure cannot go away from under  you,  you should
do an unconditional lock, and then check "gdev->chip" for being NULL
once you have gotten the lock (the same way you did in open()).

But a "trylock and return error if it failed" just means that now you
are randomly returning errors to user space, which is entirely
undebuggable and makes no sense.

Or, alternatively, the trylock succeeds - because it hits fully
*after* gpiochip_remove() has finished, and now ->chip is NULL anyway,
which is what you claim to protect against.

End result: "trylock" can never be right in this kind of context.

That "call_locked() helper might make sense more along the lines of

        ret = -ENODEV;

        down_read(&gdev->sem))
        // Does the device still exist?
        if (gdev->chip)
                ret = func(file, cmd, arg);
        up_read(&gdev->sem);

        return ret;

or similar. Not with that odd "try to lock, and if that fails, assume error".

And again - if the trylock is there because 'gdev' itself might go
away at any time and you can't afford to wait on the lock, then it's
broken regardless (and the above suggestion won't help either)

Anyway: the end result of this all is that I think this is a
fundamental bug in the gpio layer, and rc7 (soon to be rc8) is too
late to try these kinds of unfinished games.

Fix it properly for 6.2, and make it back-portable, because I'm not
pulling something like this right now.

               Linus
