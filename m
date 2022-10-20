Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B5A606967
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 22:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJTUR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 16:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJTURy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 16:17:54 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F811C73CF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 13:17:53 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id h10so456750qvq.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 13:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5JG4TG86FhBNXrSI5BCe8InCASAPAEk8+UVxaf6Yswk=;
        b=E19WGn5kg2GNc1bPFs3gE9EEYsek2Vz9u6HTo6hmpqmn7Hi12UWHL9jAgTjFKfVF05
         6WPFFX/ev06e4XHfeyqDGboH3+F1VDqcn+Il2RCSbhCnWl7DCYVzFB6iTaojMyAIqf0g
         nCtctV3bGTycdZKdJJzLvvpPgbVYjnyFJ10g8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JG4TG86FhBNXrSI5BCe8InCASAPAEk8+UVxaf6Yswk=;
        b=EJ2RKid7ZOz6bYM5GSa9kDFgNPhcB+AudLeE9/GPj91YQXVpPVrVf2wsmUND9zLv+W
         wBAnyyTROSZCQnb5lmxO7wFxlk/VJFl3yKws6XJcMu7lheSsgvG7sGWQPeaH2NJJP0Mk
         VPnwKBYGTihD9Bwygto9srQS4t55YeHBhtyfbRRxXduXVNX3CvgRCewMnvtCCwdnBHqq
         h1m2cFkjbEzg8kb02cqQifWOolSOXymL3FqhIVaJTNeuHcBcP2bP/9wSsw3vR5mln0p4
         FBRnwZpUSkM641GQ+gVQ1RPv3yYjyiFFL1js8/4cXCqTXxfNG65pjPn3VPONJw52p+gY
         nJTQ==
X-Gm-Message-State: ACrzQf2FU/RZ4ClNPBux2/HAUYXI6oFnMuOgxhpsTIB3BeSgIxxfE3xA
        AmulqvjmceD15w/zbvpiqu6rUGYM/n14rw==
X-Google-Smtp-Source: AMsMyM53R1P8njGH2GDX/zvvrfzYwx8PY02FpJTHyVvB9fAYx0fMuT2l6BXGWEMToQjYi/iCrsuBhQ==
X-Received: by 2002:a05:6214:c42:b0:4b4:189:363d with SMTP id r2-20020a0562140c4200b004b40189363dmr12921378qvj.25.1666297072587;
        Thu, 20 Oct 2022 13:17:52 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id bn39-20020a05620a2ae700b006b8e63dfffbsm7705097qkb.58.2022.10.20.13.17.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 13:17:50 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3690482f5dfso4325417b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 13:17:50 -0700 (PDT)
X-Received: by 2002:a81:5843:0:b0:361:2d0:7d9 with SMTP id m64-20020a815843000000b0036102d007d9mr13585688ywb.58.1666297070240;
 Thu, 20 Oct 2022 13:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221020000356.177CDC433C1@smtp.kernel.org> <Y1EZuQcO8UoN91cX@localhost.localdomain>
 <CAHmME9prEhkHqQmtDGCSFunNnxiKdE_8FHKiksyqebUN63U81Q@mail.gmail.com>
 <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com>
 <CAHmME9qBZqTd0D_gr8nE+DUzCrC0fxZNZK=7u+21jbgtFgAJBg@mail.gmail.com>
 <CAHk-=wjZDC9o8iwF+bU91Hx40HjGOpMui+VoFCDJkaGCu=rG4A@mail.gmail.com>
 <202210201151.ECC19BC97A@keescook> <CAHk-=wgdXRZy0-3v+vLZdDfRFKFXZLehgmR2QUKSemBA99sfmg@mail.gmail.com>
In-Reply-To: <CAHk-=wgdXRZy0-3v+vLZdDfRFKFXZLehgmR2QUKSemBA99sfmg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Oct 2022 13:17:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvp=ys2adnWwc1PNt3OrZ_0EkFaUcvjiVuOoVNjX_+AA@mail.gmail.com>
Message-ID: <CAHk-=wjvp=ys2adnWwc1PNt3OrZ_0EkFaUcvjiVuOoVNjX_+AA@mail.gmail.com>
Subject: Re: [PATCH -mm] -funsigned-char, x86: make struct p4_event_bind::cntr
 signed array
To:     Kees Cook <keescook@chromium.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, masahiroy@kernel.org,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 12:39 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So getting rid of that kind of pointless noise is just about all the
> effort here.

Current status: of 22.5k object files, 971 have differences.

In many cases, the differences are small and trivial. Example:

 - fscrypt_show_test_dummy_encryption() does that same "print a char with %c"

        seq_printf(seq, "%ctest_dummy_encryption=v%d", sep, vers);

which is entirely harmless and exactly the same as that  (but I most
certainly haven't figured out how to automatically script away that
"oh, %c is fine).

And in other cases, there's no actual difference at all, just
different register usage, so the diff looks fairly big, but doesn't
seem to be real.  In one case I looked at, it started with a 'movzbl',
but it was that in both cases, because the type was actually 'unsigned
char' to begin with. But for some reason it just used different
registers. Example:

 - handle_control_request() in drivers/usb/gadget/udc/dummy_hcd.c

   The reason here *seems* to be that

                        char *buf;
                        buf = (char *)urb->transfer_buffer;

   where it really probably should be 'u8 *buf', since it actually
does a cast to 'u8' in one place, but there isn't even any read of
that 'buf' pointer. So the difference seems to be entirely just some
"different type in assignment" cast internal to gcc that then
incidentally generated a random other choice in register allocation.

And in some cases the differences are enormous:

 - drivers/net/wireless/ralink/rt2x00/rt2800lib.c generates a 220kB diff

which seems to be due to entirely different inlining decisions or
something, and the differences are so enormous that I didn't even
start looking at the cause.

There's a fair number of things in between, like fs/ext4/super.c that
generates a lot of differences, some of them obvious, some of them
very much not obvious that may br similar to the
handle_control_request() ones.

*Presumably* the ext4 super.c code is fine (since it has been used on
architectures that already had unsigned char), but it actually
generates a bigger diff than the p4 events driver does...

And that arch/x86/events/intel/p4.c thing that Alexey found sadly does
not stand out at all in that "somewhere in the middle" bunch.

So I think my "hey, we can automate the comparison" is pretty much a
dud, but I'm not giving up quite yet. It's annoying how *most* of the
kernel files show no differences at all, but then I can't even figure
our why other files do show differences with no obvious reason for
them at all.

                Linus
