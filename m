Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092816A53E6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjB1HtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjB1HtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:49:12 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03583244A6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 23:49:10 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id cf14so9506541qtb.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 23:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9nszujs/cR5S+IMyIjmZJZVbyFeU+vaQIe48z9YdiU=;
        b=XrtR6wPR45/o/EEFuB/1hakKKo2EqyNg33v7KbHEf4VwcQsxaBD7VGBFK1fmTeQtGQ
         0pIRg3o7I4rRDvIWPLvm1XORSUCUxZ9DA2iedPzOEgtzMRlQOlhNMuFwx+xx23lqIznp
         ChB2Wex0SVk9hcohDM+YT6CLjEAkl1zAKoAi8Oj/IaUbCXNrlmQl+aLn+M3zdgZdCm95
         BlnVuJPBITESFHmowMOa8FxtF1M0IXfz04eeNPy7d7rLmxf201YvCG/xLBUoHxhxjAts
         meRryQ8Krg+mC52ndK4biJXS9a4ARFQNycBey3BWWS/BXhgFlA3fQMgvZWe/T4DNB3D7
         90kQ==
X-Gm-Message-State: AO0yUKWH39Y0QHoAb7c9S/9oz2cqGfmi9yiwbYGSbLCD+EOssvilt332
        nv6PCuKz9NF9/R4/xDK4jRr2Mlb7cwYWhw==
X-Google-Smtp-Source: AK7set90o8U+dJcNXo/F2empMe19+Q1q+Fs4FPI2RVlOornhJECqj3EMdU5OcthndOqE/2WHn7s5fQ==
X-Received: by 2002:ac8:5f8b:0:b0:3b8:1f33:ab57 with SMTP id j11-20020ac85f8b000000b003b81f33ab57mr3485790qta.59.1677570549751;
        Mon, 27 Feb 2023 23:49:09 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id p3-20020ac84083000000b003b9a573aec6sm6058649qtl.70.2023.02.27.23.49.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 23:49:09 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-536c02eea4dso247870887b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 23:49:09 -0800 (PST)
X-Received: by 2002:a81:441c:0:b0:52e:f66d:b70f with SMTP id
 r28-20020a81441c000000b0052ef66db70fmr1003301ywa.5.1677570548820; Mon, 27 Feb
 2023 23:49:08 -0800 (PST)
MIME-Version: 1.0
References: <dff216da09ab7a60217c3fc2147e671ae07d636f.1677528627.git.geert@linux-m68k.org>
 <f0877485-16df-1bda-c935-5ef56afacc8d@linux-m68k.org>
In-Reply-To: <f0877485-16df-1bda-c935-5ef56afacc8d@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Feb 2023 08:48:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXMWaCm7OGq7O9F5SWBxhreTppUr4K6K9FmZf1GpaAtVA@mail.gmail.com>
Message-ID: <CAMuHMdXMWaCm7OGq7O9F5SWBxhreTppUr4K6K9FmZf1GpaAtVA@mail.gmail.com>
Subject: Re: [PATCH] m68k: mm: Move initrd phys_to_virt handling after paging_init()
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Mike Rapoport <rppt@kernel.org>, Stephen Walsh <vk3heg@vk3heg.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Mon, Feb 27, 2023 at 11:46 PM Finn Thain <fthain@linux-m68k.org> wrote:
> On Mon, 27 Feb 2023, Geert Uytterhoeven wrote:
> > When booting with an initial ramdisk on platforms where physical memory
> > does not start at address zero (e.g. on Amiga):
> >
> >     initrd: 0ef0602c - 0f800000
> >     Zone ranges:
> >       DMA      [mem 0x0000000008000000-0x000000f7ffffffff]
> >       Normal   empty
> >     Movable zone start for each node
> >     Early memory node ranges
> >       node   0: [mem 0x0000000008000000-0x000000000f7fffff]
> >     Initmem setup node 0 [mem 0x0000000008000000-0x000000000f7fffff]
> >     Unable to handle kernel access at virtual address (ptrval)
> >     Oops: 00000000
> >     Modules linked in:
> >     PC: [<00201d3c>] memcmp+0x28/0x56
> >
> > As phys_to_virt() relies on m68k_memoffset and module_fixup(), it must
> > not be called before paging_init().  Hence postpone the phys_to_virt
> > handling for the initial ramdisk until after calling paging_init().
>
> Thanks for debugging this issue.

Np, you're welcome.

> > While at it, reduce #ifdef clutter by using IS_ENABLED() instead.
> >
> > Fixes: 376e3fdecb0dcae2 ("m68k: Enable memtest functionality")
>
> I apologise for the trouble caused by that patch.

Does that count as an Acked-by? ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
