Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F210691CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjBJKei convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Feb 2023 05:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjBJKeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:34:36 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043406D61D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:34:34 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id q13so5228996qtx.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:34:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZS+c56KQpRDCKl5uf42ZhDkTWWR4DPlYQhT2r1VZ60=;
        b=L8AACcPu2JGDZekHmAeXrLV3QODHYLkAqR8IIQfsLX9kuPxkvn30X3znuO60yRM9Sz
         5w1o8+NqLY9ijUKWmcF0j5W98bZLf3KCbLZeW8hT/36dMccwYOGNAqj02UYVJ1VTdSPc
         X6Krbrhf5d34r9/sPx1yp1M3d8r7YfaNhMJphXkynfIVlt6cBsW+XpysOcJzSjNJ12Hf
         t8OF4QW3Jwi9R9+stBNtndMzq533kPeUQ6qrFTewt5vzp3X2sjstSCJeGOsynktHKkm/
         7NdcADxKlJ65pkAVoZfcqRtgxG2C7zvvmi394zeEtKr8t1rfjQiVlKRA0XD6eHLQViXg
         0y0w==
X-Gm-Message-State: AO0yUKVr1YXqLLnFGSi2Z2Q8zBVRUv2K1AoYg8lUK+TL8qscrmHpjgH8
        W6sBjoZXb/WB4pmX5L21tGHsOVYaNRmhnMQE
X-Google-Smtp-Source: AK7set/2kko2+7MhxuInYBKO7/dSbvYQtbGECoqVJOwaFSdqIn9S/7evSnnlxGvV/4NEgSBEsc6+9w==
X-Received: by 2002:a05:622a:1716:b0:3b8:2e8b:d8af with SMTP id h22-20020a05622a171600b003b82e8bd8afmr21367017qtk.55.1676025273850;
        Fri, 10 Feb 2023 02:34:33 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id s75-20020a37454e000000b006fa22f0494bsm3273340qka.117.2023.02.10.02.34.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 02:34:33 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-520dad0a7d2so62135357b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:34:33 -0800 (PST)
X-Received: by 2002:a0d:f444:0:b0:526:78ad:bb15 with SMTP id
 d65-20020a0df444000000b0052678adbb15mr1562294ywf.47.1676024801737; Fri, 10
 Feb 2023 02:26:41 -0800 (PST)
MIME-Version: 1.0
References: <20221103213420.1395507-1-j.neuschaefer@gmx.net>
In-Reply-To: <20221103213420.1395507-1-j.neuschaefer@gmx.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Feb 2023 11:26:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWo5vHCeE6BeSHrUy12uT7_wFhW-VbQmQ5u+4Q8c7-wYQ@mail.gmail.com>
Message-ID: <CAMuHMdWo5vHCeE6BeSHrUy12uT7_wFhW-VbQmQ5u+4Q8c7-wYQ@mail.gmail.com>
Subject: Re: [PATCH v6] soc: nuvoton: Add SoC info driver for WPCM450
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     openbmc@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Hector Martin <marcan@marcan.st>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Brian Norris <briannorris@chromium.org>,
        Sven Peter <sven@svenpeter.dev>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Thu, Nov 3, 2022 at 10:37 PM Jonathan Neuschäfer
<j.neuschaefer@gmx.net> wrote:
> Add a SoC information driver for Nuvoton WPCM450 SoCs. It provides
> information such as the SoC revision.
>
> Usage example:
>
>   # grep . /sys/devices/soc0/*
>   /sys/devices/soc0/family:Nuvoton NPCM
>   /sys/devices/soc0/revision:A3
>   /sys/devices/soc0/soc_id:WPCM450
>
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> v6:
> - Select REGMAP
> - Rearrange Kconfig structure a bit

Thanks for your patch!

Unfortunately Joel seems to have sent v5 to Arnd instead of v6?
https://lore.kernel.org/all/20230201051717.1005938-1-joel@jms.id.au

Which is now commit 7dbb4a38bff34493 ("soc:
nuvoton: Add SoC info driver for WPCM450") in soc/for-next...

> --- /dev/null
> +++ b/drivers/soc/nuvoton/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0
> +menu "Nuvoton SoC drivers"
> +       depends on ARCH_NPCM || COMPILE_TEST

... and lacks the above dependency, hence appearing on my radar.

> +
> +config WPCM450_SOC
> +       tristate "Nuvoton WPCM450 SoC driver"
> +       default y if ARCH_WPCM450
> +       select SOC_BUS
> +       select REGMAP
> +       help
> +         Say Y here to compile the SoC information driver for Nuvoton
> +         WPCM450 SoCs.
> +
> +         This driver provides information such as the SoC model and
> +         revision.
> +
> +endmenu

Do you plan to send a follow-up patch?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
