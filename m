Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B306C6C222D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCTUFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjCTUFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:05:11 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7D5C167
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:04:59 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id d14so3111320ion.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679342698;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FuvMmA7tsMzT2IG4AsR61roPXvyHSJm+OtWNjVpvWLM=;
        b=dLZ5qlRDQreian19hx8rEVxM/WrWNleueEiYZPkSpF9IDkH5BMxP4A8uLT4mI1LbWP
         /u6d2u5hN8Aj5n2TIsrHPV+mdAXr08W3wfFmV2do8fP8UGz5j7OL7f19eXyt3QSw9VOf
         xILepYvVO0CRbeHw8aRWUJJf+qt0c58HJZracUBHURCOeqoHwNOZ+nliEFT8mmKx36z8
         vXUFuZb4i8txIM21H/XHbKJ8xeaSWo7RZaw52Ai0JIsIi1L0WAsEJe45UWQrTRv5f0n1
         FSCZpZSM99juFyu60aMzUnvvwfQsTF0aWwbPrYhMPKGWqz9q/uH7d26vzHPF4gL/jmJi
         SDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679342698;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FuvMmA7tsMzT2IG4AsR61roPXvyHSJm+OtWNjVpvWLM=;
        b=0KkjK328fBtIrQ+KKdy24g95PtuEb+D7T7WDZhmAsN6bGer54mGtn9aY5UlOZ4Nz93
         DVCH/ApNCjyed5q45AtKZtZunH1eLSPNlnkv3iUQVdnnyCD1xt6/vIJE++trKbYg+4QM
         3QriBIHYfT2Fgbp5Msk+VKGBtYatgg6LtH6XllMte2fC5NPvZ0GDAYvFacdm7qybfMKB
         UTL01D/vUOmxgkB1SjNVdaVNCj/mdWTQBALZxCSQMNoS3p0ah9tM6Az2aqxg+dD+eLnJ
         fZQgVcCvbjLayuYbBO47kr9arkGdTuCPE/jkquDsTZCgUTIc8bAq8+nr6ZEq/bEqr41L
         mYdg==
X-Gm-Message-State: AO0yUKXRrcpykOe/i66W3n/JqRDFam11A05nQXzxUIv/3AYTiWfcT3DY
        q00jJ7O2dzIiFnTdpOlh6M8=
X-Google-Smtp-Source: AK7set+LO0j8cGdeLIZy/9F7alcIS4BjKOm22OraNqeqo7JFbRLYlOivaTzGObTPkuqSMp0F9f1QBw==
X-Received: by 2002:a6b:fd0c:0:b0:758:1db1:ca99 with SMTP id c12-20020a6bfd0c000000b007581db1ca99mr2627ioi.19.1679342698537;
        Mon, 20 Mar 2023 13:04:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a43-20020a02942e000000b0040617a81e1asm3428014jai.59.2023.03.20.13.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:04:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 20 Mar 2023 13:04:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: Linux 6.3-rc3
Message-ID: <4adbed5a-6f73-42ac-b7be-e12c764ae808@roeck-us.net>
References: <CAHk-=wiPd8R8-zSqTOtJ9KYeZLBByHug7ny3rgP-ZqzpP_KELg@mail.gmail.com>
 <20230320180501.GA598084@dev-arch.thelio-3990X>
 <CAHk-=wgSqpdkeJBb92M37JNTdRQJRnRUApraHKE8uGHTqQuu2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgSqpdkeJBb92M37JNTdRQJRnRUApraHKE8uGHTqQuu2Q@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:26:17AM -0700, Linus Torvalds wrote:
> On Mon, Mar 20, 2023 at 11:05 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On the clang front, I am still seeing the following warning turned error
> > for arm64 allmodconfig at least:
> >
> >   drivers/gpu/host1x/dev.c:520:6: error: variable 'syncpt_irq' is uninitialized when used here [-Werror,-Wuninitialized]
> >           if (syncpt_irq < 0)
> >               ^~~~~~~~~~
> 
> Hmm. I do my arm64 allmodconfig builds with gcc, and I'm surprised
> that gcc doesn't warn about this.
> 
> That syncpt_irq thing isn't written to anywhere, so that's pretty egregious.
> 
> We use -Wno-maybe-uninitialized because gcc gets it so wrong, but
> that's different from the "-Wuninitialized" thing (without the
> "maybe").
> 
> I've seen gcc mess this up when there is one single assignment,
> because then the SSA format makes it *so* easy to just use that
> assignment out-of-order (or unconditionally), but this case looks
> unusually clear-cut.
> 
> So the fact that gcc doesn't warn about it is outright odd.
> 
> > If that does not come to you through other means before -rc4, could you
> > just apply it directly so that I can stop applying it to our CI? :)
> 
> Bah. I took it now, there's no excuse for that thing.
> 
> Do we have any gcc people around that could explain why gcc failed so
> miserably at this trivial case?
> 

I have noticed that gcc doesn't always warn about uninitialized variables
in most architectures. The conditional btrfs build failure (only seen on
sparc and parisc) is similar: gcc is silent even if I on purpose create
and use uninitialized variables. Since the gcc version I use is the
same for all architectures, I thought it must have something to do with
compile options (like maybe the option to always initialize stack
variables, or with some gcc plugin), but I have been unable to track it
down.

Guenter
