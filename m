Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C12974A149
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjGFPkI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jul 2023 11:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGFPkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:40:04 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2604D1FD2;
        Thu,  6 Jul 2023 08:39:40 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-57722942374so10923627b3.1;
        Thu, 06 Jul 2023 08:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688657976; x=1691249976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3DiZE9JB6ColP1aIV7E9G0pPGJNewraAmq4lD+0Ir4=;
        b=d0GSVQiUzPYJ/Qf9h4+29ktP7gJaxqg6FnXp4dEv7i97j9T/UctC02scgNnzUFA2F8
         OrgnuAQw7Yb1EBOamYLCKcqT2kUeiw9mN0sVi9YokfsC9Zue6BIP8nSqW+Fq/9ebYatl
         ZZ09/3fe0SpfRVX1QnMmpxU+ho2S5mO9yzATFkPc6jgXAxzCTB7rfbkI9S8fFAMcsPSf
         QVaQMYfihQnUQCHPfwuOnN2TmtDiY4dVZ3AVYcYEG7aSG7MWgebdqSveBvgiV8yFP7nP
         UCM5KTfqe20UhhE+Ypd99gayxyI1tV8MkfAXvm6msFEz4XyuBSBAIeqnNiRoj5xKH97T
         MKHQ==
X-Gm-Message-State: ABy/qLa9xfiOAjpxrd4Y+021mLyYdOEu4A0maISuHmQjjHh/SrpDpq7p
        YvV5L5zPWzo5I+Tt4lPzTiLvkmM2bEYkOw==
X-Google-Smtp-Source: APBJJlGRyJMnRqZebmp9ZEnoqbz5EMFdTHaqJgenZpIOiNelblR/Xq2fbsp3gNyaQMG5UHYRN0xUIQ==
X-Received: by 2002:a0d:e8c8:0:b0:576:896a:dbc5 with SMTP id r191-20020a0de8c8000000b00576896adbc5mr2232985ywe.48.1688657975973;
        Thu, 06 Jul 2023 08:39:35 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id v126-20020a0dd384000000b0057a02887d4esm409974ywd.100.2023.07.06.08.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 08:39:35 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-c4e4c258ba9so901758276.1;
        Thu, 06 Jul 2023 08:39:35 -0700 (PDT)
X-Received: by 2002:a25:a4c1:0:b0:c18:4f16:aaf6 with SMTP id
 g59-20020a25a4c1000000b00c184f16aaf6mr1782557ybi.58.1688657975503; Thu, 06
 Jul 2023 08:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net>
In-Reply-To: <fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Jul 2023 17:39:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUfXdCf_CQuWXpP72MzKFYvXg3Ud1VN_3Bd0RHxfLhVeQ@mail.gmail.com>
Message-ID: <CAMuHMdUfXdCf_CQuWXpP72MzKFYvXg3Ud1VN_3Bd0RHxfLhVeQ@mail.gmail.com>
Subject: Re: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Günter,

On Thu, Jul 6, 2023 at 4:03 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, Jun 01, 2023 at 11:22:17PM +0300, Sergey Shtylyov wrote:
> > IRQ0 is no longer returned by platform_get_irq() and its ilk -- they now
> > return -EINVAL instead.  However, the kernel code supporting SH3/4-based
> > SoCs still maps the IRQ #s starting at 0 -- modify that code to start the
> > IRQ #s from 16 instead.
> >
> > The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
> > indeed are using IRQ0 for the SMSC911x compatible Ethernet chip.
> >
>
> Unfortunately it also affects all sh4 emulations in qemu, and results in
> boot stalls with those. There isn't a relevant log to attach because there
> is no error message - booting just stalls until the emulation is aborted.

Which sh4 platforms in particular?

I booted a kernel with this patch on rts7751r2d (QEMU) and landisk
(physical) two days ago.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
