Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0388260B5B9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiJXSif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiJXSiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:38:16 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5726589
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:20:15 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id q127so3650965vsa.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kQzpFZcP8Coy3MtkwLvplRdsueJt1u6B3qt5xoqDDG0=;
        b=DC/JXvGYxRCs4XEoLBmqW0D0Vz2KsH2C3DgLHL1fXNfSPBwBNLhBvG1aiiz7Uuj8I5
         WmXcMVYsgZ0vNojncjGyGTEg7WfCECT/PHBTwyfOAa1wN5JjymQANnwgpOuOnPLj5cBC
         azfIciBEYryDpqGxNAu6DhUj9whA1Y6gO1Ggc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQzpFZcP8Coy3MtkwLvplRdsueJt1u6B3qt5xoqDDG0=;
        b=ooWtzP8IjhEydGSEvu834rju3Eb7c/UnU9lFHlxXfq1Cj36FNOuzdFKxikJWQwYkXr
         g2Ae9VhYq3FlOzs7whuKOk0Tt1M1MGAY0EVEMqCdBdgpj2aMJxD/b/MCdtF4PRi/1VaZ
         rasVeohjmeBjmXTEwk+dDRRJTanBhyM6x9S7iDta6eyvhlJWnWoLomGIThes4aiMwWo+
         Fbofo28/VeNSpk470Aix62MNb9sZwM10mUMwk2mrncTZ/5yNvDigPim5IEfcELZlTW6J
         4eytPZmNprkqoeK6wLHT5JlStQBifYEiLoas5QFTYBkp7QPhH7Nyb11kskICfLGot14s
         kcBg==
X-Gm-Message-State: ACrzQf0V8DjQGvLiKkwJ99CUuw4s/hE5+2lmsNe8YvQK4xFCgf9RqTAm
        apTHICME60zsLtlyawoOL5OshxWbt6kw+Q==
X-Google-Smtp-Source: AMsMyM6FEitJGPsRHjisdkHAUPEM0ruUnVpPb6hbNLxjVbOYVZhQ3bjSyuzrN9+6KLLnMwN7klMeRQ==
X-Received: by 2002:a0c:aacd:0:b0:4ad:fe0:4e84 with SMTP id g13-20020a0caacd000000b004ad0fe04e84mr28565849qvb.8.1666631472425;
        Mon, 24 Oct 2022 10:11:12 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id j15-20020ac806cf000000b00359961365f1sm210801qth.68.2022.10.24.10.11.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 10:11:10 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-3321c2a8d4cso91468527b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:11:09 -0700 (PDT)
X-Received: by 2002:a81:d34c:0:b0:349:1e37:ce4e with SMTP id
 d12-20020a81d34c000000b003491e37ce4emr30065031ywl.112.1666631469533; Mon, 24
 Oct 2022 10:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com> <20221019203034.3795710-1-Jason@zx2c4.com>
 <Y1ZZyP4ZRBIbv+Kg@kili> <Y1ZbI4IzAOaNwhoD@kadam> <Y1a+cHkFt54gJv54@zx2c4.com>
In-Reply-To: <Y1a+cHkFt54gJv54@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Oct 2022 10:10:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgK3Vs+7Kor-SisRHJYzV1tXD+=D4+W1XkfHOV2KN_OGw@mail.gmail.com>
Message-ID: <CAHk-=wgK3Vs+7Kor-SisRHJYzV1tXD+=D4+W1XkfHOV2KN_OGw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Mon, Oct 24, 2022 at 9:34 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Give these a minute to hit Lore, but patches just submitted to various
> maintainers as fixes (for 6.1), since these are already broken on some
> architecture.

Hold up a minute.

Some of those may need more thought. For example, that first one:

> https://lore.kernel.org/all/20221024163005.536097-1-Jason@zx2c4.com

looks just *strange*. As far as I can tell, no other wireless drivers
do any sign checks at all.

Now, I didn't really look around a lot, but looking at a few other
SIOCSIWESSID users, most don't even seem to treat it as a string at
all, but as just a byte dump (so memcpy() instead of strncpy())

As far as I know, there are no actual rules for SSID character sets,
and while using utf-8 or something else might cause interoperability
problems, this driver seems to be just confused. If you want to check
for "printable characters", that check is still wrong.

So I don't think this is a "assume char is signed" issue. I think this
is a "driver is confused" issue.

IOW, I don't think these are 6.1 material as some kind of obvious
fixes, at least not without driver author acks.

                Linus
