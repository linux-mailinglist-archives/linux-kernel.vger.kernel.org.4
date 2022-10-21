Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C933607D72
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiJURYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiJURYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:24:19 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3975A24FEDA
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 10:24:18 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id t16so2247447qvm.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 10:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pc1MZrum9U3f5zrb42uMivoTovnGyDRppcBiM2u8cio=;
        b=dExWfQycVB6K7KJX/TXQHtrKNvEFZmzoTPkRzg+mJaUK3ypYPlc0sUv4uB6zv6aejJ
         kj9UBWHeeFZ7ZHJTdgI62G5YA5Z0NTFJj3qJ6YMGIjufATFepwCgO8gFj3FlkJrezqmC
         LmSb69RShHf7vR6ms6pyjbHeKsgpw+eUrC5c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pc1MZrum9U3f5zrb42uMivoTovnGyDRppcBiM2u8cio=;
        b=Damvz9AyYCM9JmoVo0TOgeV92vKtwBff3tr7nTR1R2KAiH3k3RP533gHjgn35rnr5j
         3fEApowfeFghW5uzxAgOqfloDrt7G6x85bW0a2AqnhFkpZUfZFukeQK9Xha1Q25AvCvY
         3SS+W7CYz+/+h2/VXnR9Z/SeAn7BmfdI0RguOJdajOlzMXZ9Y4/E6AiNitc0ACWV/Evv
         HbvQmU2FcTlmoHgyAVE4zGVBQ4M+nGHgDoeaH2MceHw1QiqL8oAowslJkHgeRe+Igb/c
         GL61EGNc4EXLjH1uorrf8DytQbCn7C/EqVYBdvQQE8/Je1WZFfLfYoJgRI3uZVAd1SzC
         xIUg==
X-Gm-Message-State: ACrzQf0gz/+2ZPv+3mvpy7JnWmDYd/xQkSZS+99aqH2EeitgYLemIAUL
        b88ax6ZLtWf3M6aj2quvOMXPq3qUOv9Ljg==
X-Google-Smtp-Source: AMsMyM6sqkFgyBP8nbD5r/Nv+GzPsuCbGu8SOijhnIEvrKPG3qLOT4LSIB8kJuNFZiZw/CdUqoKdpg==
X-Received: by 2002:a05:6214:508c:b0:4b4:3b0e:5fee with SMTP id kk12-20020a056214508c00b004b43b0e5feemr17430442qvb.23.1666373056955;
        Fri, 21 Oct 2022 10:24:16 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id hf8-20020a05622a608800b0039cbbcc7da8sm8139174qtb.7.2022.10.21.10.24.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 10:24:16 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-36855db808fso30047577b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 10:24:16 -0700 (PDT)
X-Received: by 2002:a81:d34c:0:b0:349:1e37:ce4e with SMTP id
 d12-20020a81d34c000000b003491e37ce4emr17794908ywl.112.1666373055922; Fri, 21
 Oct 2022 10:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221020000356.177CDC433C1@smtp.kernel.org> <Y1EZuQcO8UoN91cX@localhost.localdomain>
 <CAHmME9prEhkHqQmtDGCSFunNnxiKdE_8FHKiksyqebUN63U81Q@mail.gmail.com>
 <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com>
 <Y1I1S86zbBmeJ+jq@localhost.localdomain> <CAHk-=wgb3RYTPd24rXs8dRdiqiPAzq7uc4Suxu1On6_DTDnf5g@mail.gmail.com>
In-Reply-To: <CAHk-=wgb3RYTPd24rXs8dRdiqiPAzq7uc4Suxu1On6_DTDnf5g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Oct 2022 10:23:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wigjpfSxu4-JXrKK9gW7m35h4pgmOd1gY2Moe9VCrXh8Q@mail.gmail.com>
Message-ID: <CAHk-=wigjpfSxu4-JXrKK9gW7m35h4pgmOd1gY2Moe9VCrXh8Q@mail.gmail.com>
Subject: Re: [PATCH -mm] -funsigned-char, x86: make struct p4_event_bind::cntr
 signed array
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com
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

On Fri, Oct 21, 2022 at 10:11 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think you can fix that by simply warning about character constants
> with the high bit set.
>
> Something like this..

This actually triggers for the kernel, and I think those (few)
warnings are likely worth just fixing.

Because things like

                put_tty_queue('\377', ldata);

just isn't worth it.

Or look at this horror:

                        if (c == (unsigned char) '\377' && I_PARMRK(tty))

where somebody did realize that '\377' might be -1, so they added the
"helpful" cast.

Wouldn't that be much nicer and simpler as just

                        if (c == 255 && I_PARMRK(tty))

instead? Or just 0377 if you really love octal in the context of
characters (and really, nobody should). Or 0xff.

At no point does "(unsigned char) '\377' " strike me as a really
readable way to write things. There's two of those things.

We also have

        memset(stack, '\xff', 64);

which really isn't helpful either. Why not just use 0xff, or even just -1.

We also have a lot of those in lib/hexdump.c, for no good reason,
particularly as those arrays are 'unsigned char[]' to begin with, not
'char'.

I really don't understand why people would use '\xAA' instead of just
using 0xAA.

We also have

        static char sample_rate_buffer[4] = { '\x80', '\xbb', '\x00', '\x00' };

in sound/usb/mixer_scarlett.c, and that should be a byte array, so the
'char' should probably be 'unsigned char' or 'u8' in the first place,
and again it would be just simpler and clearer to use plain hex
constants.

So that sparse warning looks simple enough, and I think every single
case was just the kernel being odd.

Now, in *string* constants, you sometimes do want to use that format, ie

    u8 array[] = "abcd\377";

is a reasonable way to avoid having to use a more complex initializer.
But that sparse patch of mine only complains about (non-wide)
character constants unless I screwed something up.

                  Linus
