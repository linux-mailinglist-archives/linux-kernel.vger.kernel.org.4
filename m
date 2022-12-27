Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FCB6568BF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 10:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiL0JJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 04:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiL0JJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 04:09:50 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8496549;
        Tue, 27 Dec 2022 01:09:49 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id bp44so7400037qtb.0;
        Tue, 27 Dec 2022 01:09:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hyk7cPGA30ht9CIHOHoD2wEIGOPlfpDmF3Sx7wsll0k=;
        b=jCYgmONV/YT8MpfL3Ek8gYg1aEr9iYLlijOC/GrU0BJnm2nNdOlG1kqDW0X7NrsPNW
         ZhAisiKsQF/wbWLAVVGNVbjaLCIVt4FbH8aWvq1SRcL3HiBhiRnz61EpM0T+FH55Mk9g
         4Mak3P5Y5PKi9AOWgzkw0Rn/n6wOJutFacEnEfRLy6yRzJzUusauRfkyxJGIu6iWnnGR
         9mFvR8bGZRFYnZ3LNgrkWRS7YiF+YC8cE6FOf0V7llHBbDvcANo34P6mOpWBJwDXkc8o
         4F9Rc/peCSW5rLfe0W20yu1DdpXZ+xgXL4zw254eY7VVFb4vg/nCpRp7+L4Cbi7zh/ow
         02hA==
X-Gm-Message-State: AFqh2kpfgDenk+UdDbmd1eyS5QH1UJ0ZCauOfT5V3lAYhlbF/zSvaMHd
        jJ+nJKskj/PZKs2grnUw6DC1RcbuXboeMA==
X-Google-Smtp-Source: AMrXdXsTUJgV9HRD45Nh8OkJCpo7w6mD1vYRoC6VzQ978bKYONPGJEgxyIq0wQ78Ty9wi2rQVrJlKg==
X-Received: by 2002:a05:622a:2286:b0:3a5:f9eb:22e with SMTP id ay6-20020a05622a228600b003a5f9eb022emr24919267qtb.27.1672132188252;
        Tue, 27 Dec 2022 01:09:48 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id bs7-20020a05620a470700b006b61b2cb1d2sm9295004qkb.46.2022.12.27.01.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 01:09:47 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 192so13768071ybt.6;
        Tue, 27 Dec 2022 01:09:47 -0800 (PST)
X-Received: by 2002:a25:3143:0:b0:77a:b5f3:d0ac with SMTP id
 x64-20020a253143000000b0077ab5f3d0acmr584880ybx.202.1672132187403; Tue, 27
 Dec 2022 01:09:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1669213027.git.geert+renesas@glider.be> <167213158107.15520.15699943919910529014.b4-ty@linaro.org>
 <2d62f33e-69d4-064c-f226-2d38396f0e9e@linaro.org>
In-Reply-To: <2d62f33e-69d4-064c-f226-2d38396f0e9e@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Dec 2022 10:09:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUT4eW0KPV8DD40kPD0Cr+QudBfOxfhKy9iWnrcGBSM0Q@mail.gmail.com>
Message-ID: <CAMuHMdUT4eW0KPV8DD40kPD0Cr+QudBfOxfhKy9iWnrcGBSM0Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] memory: renesas-rpc-if: Rebind fixes and misc cleanups
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 10:06 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 27/12/2022 09:59, Krzysztof Kozlowski wrote:
> > On Wed, 23 Nov 2022 15:41:16 +0100, Geert Uytterhoeven wrote:
> >> The Renesas RPC-IF provides either HyperFlash or SPI host access.
> >> To handle this, three drivers are used:
> >>   1. The RPC-IF core diver,
> >>   2. An HyperFlash child driver,
> >>   3. An SPI child driver.
> >>
> >> [...]
> >
> > Applied, thanks!
> >
> > [1/6] memory: renesas-rpc-if: Split-off private data from struct rpcif
> >       https://git.kernel.org/krzk/linux-mem-ctrl/c/f8fa9cb3fb16e06514fec0bac58996015dedc453
>
> Missing checkpatch. I corrected now:
> WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1>
> ("<title line>")' - ie: 'Fixes: ca7d8b980b67 ("memory: add Renesas
> RPC-IF driver")'

Oh well... Merry Xmas ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
