Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B3366E8B0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjAQVnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjAQVlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:41:05 -0500
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A0B59E40;
        Tue, 17 Jan 2023 12:06:12 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-4a263c4ddbaso439105247b3.0;
        Tue, 17 Jan 2023 12:06:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xoeiV+nYOsKZ3P5r1QIbmJ251MgYmk7NsIx6imHg00=;
        b=LT+pk/oLcwTv8EU6sQ/ZnsBHU19VF7IwbPUcjZISKMjKSAtTaxzH0wEy1WjmJ0Rx8M
         LYeKn3+jBYHsAcTIWmLAqTKaOQL49gQaPahTpB15wk8E+Wyjvtc8LiI9l5+kMgXFLeTt
         qXEFb1ryIoWAHGOecGkSX6zUh3FdgmsCu4/XC1uls65A1tSonTh6KsjfjrrrmVs3wqus
         dK139lAPcpAAy1eE25wDdrLAiuCRuaNmsYtX3YSVi2a5Ld/bLtfG5S3uiodxXaPNvPEu
         NPXl8wpqPJ2nn8GlAx2dlotaQQz37V1m2QUMVEIcMsd2QSjip3Tuu/O5z+TdqKxi0BIn
         BVMA==
X-Gm-Message-State: AFqh2kr9nZnFQh1Fe2+n2sGsxOoKoZEepu2VIsCK2Ey6enEjJVccmAxF
        RYJ2zboS+Nn34oCEUi7TYdmfAUH1EodupA==
X-Google-Smtp-Source: AMrXdXs8bjgJJgEy05if+fStjoRA36OhgQ/dSSAxHMnpDMC3+ehjDWidy/8KK5sulArv5URW9PAbfQ==
X-Received: by 2002:a81:1249:0:b0:468:5fe3:7778 with SMTP id 70-20020a811249000000b004685fe37778mr3763309yws.7.1673985971479;
        Tue, 17 Jan 2023 12:06:11 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id r7-20020ae9d607000000b0070650f5ee2fsm5966789qkk.65.2023.01.17.12.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 12:06:10 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id v19so29624290ybv.1;
        Tue, 17 Jan 2023 12:06:10 -0800 (PST)
X-Received: by 2002:a25:9012:0:b0:7b8:a0b8:f7ec with SMTP id
 s18-20020a259012000000b007b8a0b8f7ecmr700718ybl.36.1673985970579; Tue, 17 Jan
 2023 12:06:10 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20221227082932.798359-1-geert@linux-m68k.org> <alpine.DEB.2.22.394.2212270933530.311423@ramsan.of.borg>
 <c05bee5d-0d69-289b-fe4b-98f4cd31a4f5@physik.fu-berlin.de>
 <CAMuHMdXNJveXHeS=g-aHbnxtyACxq1wCeaTg8LbpYqJTCqk86g@mail.gmail.com>
 <3800eaa8-a4da-b2f0-da31-6627176cb92e@physik.fu-berlin.de>
 <CAMuHMdWbBRkhecrqcir92TgZnffMe8ku2t7PcVLqA6e6F-j=iw@mail.gmail.com> <429140e0-72fe-c91c-53bc-124d33ab5ffa@physik.fu-berlin.de>
In-Reply-To: <429140e0-72fe-c91c-53bc-124d33ab5ffa@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 17 Jan 2023 21:05:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWpHSsAB3WosyCVgS6+t4pU35Xfj3tjmdCDoyS2QkS7iw@mail.gmail.com>
Message-ID: <CAMuHMdWpHSsAB3WosyCVgS6+t4pU35Xfj3tjmdCDoyS2QkS7iw@mail.gmail.com>
Subject: Re: Calculating array sizes in C - was: Re: Build regressions/improvements
 in v6.2-rc1
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        linux-xtensa@linux-xtensa.org,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Tue, Jan 17, 2023 at 6:06 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 1/17/23 18:01, Geert Uytterhoeven wrote:
> > The issue is that some of the parameters are not arrays, but
> > NULL. E.g.:
> >
> > arch/sh/kernel/cpu/sh2/setup-sh7619.c:static
> > DECLARE_INTC_DESC(intc_desc, "sh7619", vectors, NULL,
> > arch/sh/kernel/cpu/sh2/setup-sh7619.c-                   NULL,
> > prio_registers, NULL);
>
> Isn't this supposed to be caught by this check:
>
>         a, __same_type(a, NULL)
>
> ?

Yeah, but gcc thinks it is smarter than us...
Probably it drops the test, assuming UB cannot happen.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
