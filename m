Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F56641FCF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 22:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiLDVYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 16:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLDVYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 16:24:21 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0203312D34
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 13:24:19 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id l15so10270472qtv.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 13:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HolxdYhsC6PPIuSCF4IWrRxJ55WK09MiKQKgTRRQ1u4=;
        b=LgrZIBNgjv+lshYOLGa+M54L/9z3KlJ+3Wa0Eftxr5t5Rh+W3izppj/A+bJmEPNgwj
         OC0C13AtDgJryL6ona35BuMC4+ZK/vgtrqYxVOuwTAMzgdVFBLuDFi8Xe2Oqo6y9pLdH
         WLfa94Ocazgs1GdbZ1XsvCsX0WJ2xvKuWczHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HolxdYhsC6PPIuSCF4IWrRxJ55WK09MiKQKgTRRQ1u4=;
        b=2+zmWY7lvtqtPQP53RjZh4a0NrtMxVtFQ4fd6dNr1i1L+qNY+0hRQ8x/uyn7ZlUfbT
         qbluvCaPwkK7z064iqKWZCk15arzQV6vpTTJfD9qJcZg/2K/E7iZvy7MzWXgyKZs/ypm
         REVLU3pgAltDtU04Dzrx9df3g2bneiRp5x3CWT8Phpn0oYUUzig+P7fKCDwg9kGZinDc
         QdgW3jZaxuYDnJNvQmHt7Tag/qkYsEO+9JRVCm2O/Wj/c0Ax8WE771Hng4KblmDHvoQX
         98jaorhGOWUe4d2R+M+e0FSCupFmjQz4/iTx5V8o0mvDfyqIu+TaDqyB5UHqf8AEgbw+
         w0Ww==
X-Gm-Message-State: ANoB5pkdN8X/ahAYSQrmTf9cEW3q8u9E/BpActO1rCtCEkrt1HUH4F2X
        LOaBHXPoGaereBLn6aoJqdQ2LjDbV0RM8dEp
X-Google-Smtp-Source: AA0mqf42CW/hlACDP+PTUaXdF/u/CyCAFMEeWhNC6dtSfFs5N0yyJvNDDWH1vKs5H4bb7UVnW7IA8g==
X-Received: by 2002:ac8:687:0:b0:3a5:41fd:2216 with SMTP id f7-20020ac80687000000b003a541fd2216mr75783162qth.338.1670189057569;
        Sun, 04 Dec 2022 13:24:17 -0800 (PST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com. [209.85.222.173])
        by smtp.gmail.com with ESMTPSA id r16-20020ac87ef0000000b003a7e25a10easm1428169qtc.72.2022.12.04.13.24.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 13:24:16 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id m5so2145446qkg.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 13:24:16 -0800 (PST)
X-Received: by 2002:ae9:e00c:0:b0:6f8:1e47:8422 with SMTP id
 m12-20020ae9e00c000000b006f81e478422mr71801248qkk.72.1670189055913; Sun, 04
 Dec 2022 13:24:15 -0800 (PST)
MIME-Version: 1.0
References: <20221203150539.11483-1-brgl@bgdev.pl> <CAHk-=wjD8+XZyO4H1STwXte6x1UcYsiHKaQ4OQF5ucssY=uT8g@mail.gmail.com>
 <CAMRc=Me--X58j+tLn50osPRXSsJeqms8m=aYDcwMwktfZvFQow@mail.gmail.com>
In-Reply-To: <CAMRc=Me--X58j+tLn50osPRXSsJeqms8m=aYDcwMwktfZvFQow@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Dec 2022 13:24:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi+7kAEK9f+t=z5B39bASzswNCVE+ZJKnDPjAHM_FoRNg@mail.gmail.com>
Message-ID: <CAHk-=wi+7kAEK9f+t=z5B39bASzswNCVE+ZJKnDPjAHM_FoRNg@mail.gmail.com>
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

On Sun, Dec 4, 2022 at 12:47 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> No, the data can't be removed with these locks in place. It's just to
> avoid going into the callbacks if gpiochip_remove() is already in
> progress (the only reason why trylock would fail).

That "the only reason why trylock would fail" may be true in practice,
but it's really just an implementation detail.

Other issues *could* make a trylock fail.

For example, assuming the trylock is just implemented as a non-looping
"cmpxchg" (which may or may not be the case), even another reader
coming in and racing with a trylock could make the cmpxchg fail.

That "do one single cmpxchg" is what the spinlock trylock code does,
for example.

Now, that's not actually what we do for the down_read_trylock() case -
we will actually loop over it - but locking is complicated and you
absolutely should not make assumptions about the exact implementation
details.

And even with the loop, if you ever have *any* other reason to get the
write-lock (or even just do a "try_write", suddenly the details of
when the trylock fails changes entirely.

So that's why I really don't want some random driver layer to depend
on some semantics for trylock that aren't actually guaranteed in the
bigger picture.

The only thing "trylock" says is "I tried to get the lock". It really
could easily fail for random reasons that aren't about actual writers.

For example, even aside from any "do a single cmpxchg" issue: a
sleeping lock could be implemented using a spinlock to protect the
"real" locking data. That kind of implementation is particularly
likely for debugging.

And then, in order to be usable in a recursive environment, a
"trylock" would quite likely be implemented without spinning on that
spinlock, even before it gets to the actual lock internal
implementation. So just contention on the spinlock - by other readers,
not writers - could make the trylock fail.

See?

             Linus
