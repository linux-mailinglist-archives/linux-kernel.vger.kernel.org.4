Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D21363D106
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbiK3IrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236290AbiK3IrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:47:01 -0500
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5312AC64;
        Wed, 30 Nov 2022 00:47:00 -0800 (PST)
Received: by mail-qv1-f48.google.com with SMTP id u10so5903963qvp.4;
        Wed, 30 Nov 2022 00:47:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJL7tkk/7tNU8e/+vm4nPHM5D33dVrunJX89jUIX5MU=;
        b=VQ4lsS5BSC2dUU143JFqN7qKJgeNeL5Nc6Z+pa5IQmntUViFxyNXZiFfXG4z4Fr2bE
         8EA9B+rt1Ox7Nz/ouGYsy7lnvHHZk0TVsc5oS5fT9KURmN7Y0IeF/BP5IkyphqM4Q5uL
         MdMM0xFGCYnC2tgF+7TrMBKf53wZaLgcGetDyDdzmcOgBVvdpB8A5yqtPnjzdvhVbY8L
         EqHI5mtrrByYf4lYmFT0ZMrwUnzMiQiKIvtxKxsLUJpn+lTocQkDGySWze9IRB2aCS/9
         Rdkb+QKS6sHB2JhmLdGKULHs6JLlbJbFuKPkkbDjeJU4dIj8L2BdO6oE0WUWBy4Znlxz
         AOPA==
X-Gm-Message-State: ANoB5pkw8lY+y4lEIk/9k4+jH1avLuf1tV1gRppkxAnYrwies4Ee4Ywp
        rPln5KQTYiUE12/X+sqhTgpfZcZ6YeeY9Q==
X-Google-Smtp-Source: AA0mqf7f1Ji4Wyx3yDLonjjC0Vt/qm8wICINlLWUYYcnMTbfLe8/rtJkLKE/c+9LSqBZ3fnmWWQk6g==
X-Received: by 2002:a0c:814d:0:b0:4c6:e530:2c6b with SMTP id 71-20020a0c814d000000b004c6e5302c6bmr24469687qvc.15.1669798019303;
        Wed, 30 Nov 2022 00:46:59 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id de3-20020a05620a370300b006e99290e83fsm648467qkb.107.2022.11.30.00.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 00:46:59 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id c140so20649734ybf.11;
        Wed, 30 Nov 2022 00:46:58 -0800 (PST)
X-Received: by 2002:a25:7204:0:b0:6f0:9ff5:1151 with SMTP id
 n4-20020a257204000000b006f09ff51151mr31642088ybc.543.1669798018596; Wed, 30
 Nov 2022 00:46:58 -0800 (PST)
MIME-Version: 1.0
References: <20221124003351.7792-1-hayashi.kunihiko@socionext.com>
 <20221124003351.7792-3-hayashi.kunihiko@socionext.com> <CAMuHMdVH+amC83uMBpsCebaHd2EWp1EO59JNcgRTncbNGNNRsQ@mail.gmail.com>
 <6c423f87-1187-b2d6-8b70-c8cd709f3ea0@socionext.com>
In-Reply-To: <6c423f87-1187-b2d6-8b70-c8cd709f3ea0@socionext.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Nov 2022 09:46:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWa06ND-Tud1_bYTYAVbmo1qMnU3i0bETZo6FVehvLZhg@mail.gmail.com>
Message-ID: <CAMuHMdWa06ND-Tud1_bYTYAVbmo1qMnU3i0bETZo6FVehvLZhg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] spi: Add Socionext F_OSPI SPI flash controller driver
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi Hayashi-san,

On Wed, Nov 30, 2022 at 1:47 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
> On 2022/11/30 1:49, Geert Uytterhoeven wrote:
> > On Thu, Nov 24, 2022 at 1:36 AM Kunihiko Hayashi
> > <hayashi.kunihiko@socionext.com> wrote:
> >> Introduce Socionext F_OSPI controller driver. This controller is used to
> >> communicate with slave devices such as SPI Flash memories. It supports
> >> 4 slave devices and up to 8-bit wide bus, but supports master mode only.
> >>
> >> This driver uses spi-mem framework for SPI flash memory access, and
> >> can only operate indirect access mode and single data rate mode.
> >>
> >> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

> >> --- a/drivers/spi/Kconfig
> >> +++ b/drivers/spi/Kconfig
> >> @@ -906,6 +906,15 @@ config SPI_SLAVE_MT27XX
> >>            say Y or M here.If you are not sure, say N.
> >>            SPI slave drivers for Mediatek MT27XX series ARM SoCs.
> >>
> >> +config SPI_SN_F_OSPI
> >> +       tristate "Socionext F_OSPI SPI flash controller"
> >> +       depends on OF && HAS_IOMEM
> >> +       depends on SPI_MEM
> >
> > On which systems is this hardware block found?
> > Perhaps this should depend on ARCH_UNIPHIER || COMPILE_TEST?
>
> This IP doesn't depend on ARCH_UNIPHIER, so I expect that it can be widely
> applied not only to ARCH_UNIPHIER.

OK.

> If COMPILE_TEST is required, the dependency is like SPI_CADENCE_XSPI:
>          depends on (OF || COMPILE_TEST) && HAS_IOMEM

While this is not a hard requirement, it would be nice to have.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
