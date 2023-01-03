Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F101265B859
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 01:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjACAWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 19:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjACAWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 19:22:01 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8E66153
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 16:21:59 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id c11so23457966qtn.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 16:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lberQ9s8H9q3h4BbAU80BUmPvpUWvW4Ql62uwafcong=;
        b=CC9yyWoYu8YlriJaskROfGNDC7Aa+Owk/jFAzWoCVbua1t+8ZcEFwKjpcvsF5vXY/P
         rt3DkGuj5Fvlli1p23VRJZl+PUqiHkLmL2jjxqqHQQTj445adFMPShGXrPUCnj+YRIiN
         yWBSV7+c/27nNh8LYT7iPNSlgNfqxJIHcUCGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lberQ9s8H9q3h4BbAU80BUmPvpUWvW4Ql62uwafcong=;
        b=RRa31gsz2E1AqKOugqe+xV5WasuehExzZ/PYHBBdnwRlSP92zB8jCKII0CirFS0yIO
         AlPia2f64cnNajzNim7C3WwaNJz5XifTe8CgmckrXaiwfZJDV/lj5ItAND1Buk6c/MyG
         YAnwm2Fmp9EvPeIDwkAyn3hbYs6qemWElBZCZ1n2Ki4aMmtVBlNRFaQfsoIJ9jpYNZoL
         JFGvfryIQq08kpqy6obclAA8W6Rb6y9VsAop4S0O9P8CxkUqZ9P8WIIfitVNC2zpx/ew
         ORF0fYD/kFweXzCODPeBVED1lHOk7z08c+zJD/vRAN5im108x+V6RbUFEChl7Fu6kD6p
         mBKw==
X-Gm-Message-State: AFqh2koCbgTkUnHN8TuSIX4I/+CPkdMeCTZgkDZBfvwpyLP9kjw79SI2
        nj4bdh1KqNjmKUM2YrefUXftYpaqKAbM44Ow
X-Google-Smtp-Source: AMrXdXtUsaFMaQteQxPzmLW5BQG2ESQLr2C9u90Zw81lwrJLNXAKYYr1wJ9cYMYLZAb1tmFUEF3Jaw==
X-Received: by 2002:ac8:44b8:0:b0:3a8:2fba:b02d with SMTP id a24-20020ac844b8000000b003a82fbab02dmr60329945qto.51.1672705318044;
        Mon, 02 Jan 2023 16:21:58 -0800 (PST)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com. [209.85.219.50])
        by smtp.gmail.com with ESMTPSA id bp20-20020a05622a1b9400b003a591194221sm17987516qtb.7.2023.01.02.16.21.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 16:21:57 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id h10so20542363qvq.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 16:21:57 -0800 (PST)
X-Received: by 2002:a05:6214:1185:b0:4c6:608c:6b2c with SMTP id
 t5-20020a056214118500b004c6608c6b2cmr1978995qvv.130.1672705317084; Mon, 02
 Jan 2023 16:21:57 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wim8DMRzjyYTJ3UbdqZ26keQyZSU02NZb-JY1=9OpcO1w@mail.gmail.com>
 <20230102225656.GA3532398@roeck-us.net>
In-Reply-To: <20230102225656.GA3532398@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jan 2023 16:21:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjZPPscjDhsHQw_ttHOaQS69rADLm0KuRhbNavBiO62OQ@mail.gmail.com>
Message-ID: <CAHk-=wjZPPscjDhsHQw_ttHOaQS69rADLm0KuRhbNavBiO62OQ@mail.gmail.com>
Subject: Re: Linux 6.2-rc2
To:     Guenter Roeck <linux@roeck-us.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

[ Adding Jason in case he has any ideas, and seeing if sh maintainer
emails are still valid, and Arnd in case they aren't ]

On Mon, Jan 2, 2023 at 2:57 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> One detail to mention, though, is that sh:rts7751r2dplus_defconfig
> no longer builds with older versions of binutils (2.32). Trying to
> do so results in the following build error.
>
> `.exit.text' referenced in section `__bug_table' of drivers/char/hw_random/core.o:
>         defined in discarded section `.exit.text' of drivers/char/hw_random/core.o
>
> To make this more interesting, kernels older than v5.10 do not boot
> (at least not in qemu) when images are built with binutils 2.27 or newer.
> That is why I had used binutils 2.32 in the first place.
>
> I didn't bother tracking this down but switched to binutils 2.39 when
> building v5.10+ images.

I have to admit that I can't really see myself carding deeply about
SH, but somebody else may. I don't think I've gotten an arch/sh pull
in a couple of years.

That said, I also don't see anything wrong with the arch/sh version of
BUG() and friends, so I don't see why this would hit arch/sh and not
somebody else.

I _assume_ it is the BUG_ON() in hwrng_modexit() that triggers this:

  static void __exit hwrng_modexit(void)
  {
        mutex_lock(&rng_mutex);
        BUG_ON(current_rng);
        kfree(rng_buffer);
        ...

but again, I don't see what's special about sh here apart from maybe
"not well maintained binutils support".

Does removing the BUG_ON() fix the build?

None of this is at all new, though. Funky.

              Linus
