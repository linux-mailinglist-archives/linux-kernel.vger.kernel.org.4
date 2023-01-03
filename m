Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C265365BC54
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbjACIhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjACIhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:37:04 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27BDDB1;
        Tue,  3 Jan 2023 00:37:03 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id bp44so21441981qtb.0;
        Tue, 03 Jan 2023 00:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWeWb1u/JuV5suDY2SKD5PHzHvJTULCOtib+YqqeP4w=;
        b=6pPcU23hufQ0FbTfWOEFYYMq7ukQcGJKYZkP3PeuF9RsynMxSiqewcraIOC1ClXCph
         +d1hikONp8vHGpIscUSdpLMJUNhXQhZDH3CmrucGOlUnVgIbBZYW16m16vPEGSeilL1+
         oYwFKWHxAUeOV3Z8JsPzdhKDgW0EIrfdhf51CoP/KJXXuNIteug1+xSpdger1fn/vWYi
         KMVeOhyManSxNkcZpUZYuLl5m2Or5qlCbfM4qTvyjp8QQajUgkOsZgr4oCLjz0RkxAgZ
         m7pDoTRj0pbMAC3NSkWwJgCRy6xu2u5H4b9Wez6ywrj8UUvaCs3/nwNnBURsMMobCgTJ
         vdCw==
X-Gm-Message-State: AFqh2kqgLb7YmSPZwsoaOz8izhK2lV5PrXwRFT7EiyBiBaDCwFJr7y8w
        Bu5yxf16A/mN9xM1HW1mnc9S03jV2/zoCg==
X-Google-Smtp-Source: AMrXdXtbGNYMhz5ktOx4uqOZ2ZZLBZXcDFAhoE/101XXHKJ6Ss6r/3Hy8DKiDiL5Cwy0PB9H6l+8kQ==
X-Received: by 2002:a05:622a:5c89:b0:3ab:71c2:62d3 with SMTP id ge9-20020a05622a5c8900b003ab71c262d3mr55968748qtb.55.1672735022859;
        Tue, 03 Jan 2023 00:37:02 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id z6-20020a05622a124600b003a606428a59sm18683968qtx.91.2023.01.03.00.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 00:37:02 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-476e643d1d5so311084297b3.1;
        Tue, 03 Jan 2023 00:37:01 -0800 (PST)
X-Received: by 2002:a05:690c:c02:b0:48d:1334:6e38 with SMTP id
 cl2-20020a05690c0c0200b0048d13346e38mr2327636ywb.316.1672735021431; Tue, 03
 Jan 2023 00:37:01 -0800 (PST)
MIME-Version: 1.0
References: <20221221210917.458537-1-fabrizio.castro.jz@renesas.com> <20221221210917.458537-3-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20221221210917.458537-3-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Jan 2023 09:36:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXDwEUzBpG+w_G6=CzKo=n92cdVw6v8JwOwf9o86HnOZQ@mail.gmail.com>
Message-ID: <CAMuHMdXDwEUzBpG+w_G6=CzKo=n92cdVw6v8JwOwf9o86HnOZQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mfd: Add RZ/V2M PWC core driver
To:     fabrizio.castro.jz@renesas.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
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

Hi Fabrizio,

On Wed, Dec 21, 2022 at 10:09 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> The External Power Sequence Controller (PWC) IP (found in the
> RZ/V2M SoC) is a controller for external power supplies (regulators
> and power switches), and it supports the following features: it
> generates a power on/off sequence for external power supplies,
> it generates an on/off sequence for the LPDDR4 core power supply
> (LPVDD), it comes with General-Purpose Outputs, and it processes
> key input signals.

Thanks for your patch!

> The PWC is basically a Multi-Function Device (MFD), its software
> support comes with a core driver, and specialized drivers for
> its specific features.

I have to admit I'm not such a big fan of MFD.  In this driver,
you are not even sharing resources in the MFD cells, just the mapped
register base.  So I think you can easily save +100 LoC and reduce
maintenance synchronization overhead across subsystems by just having
a single non-MFD driver instead.

Did you pick MFD because the PWC poweroff feature depends on board
wiring, and thus is optional?

Are there any other MFD cells planned (e.g. regulators) to be added
later? The public datasheet does not list the actual registers of the
block, only a high-level overview with (rather detailed) behavioral
information.

Thanks!

> --- /dev/null
> +++ b/drivers/mfd/rzv2m-pwc.h

> +struct rzv2m_pwc_priv {
> +       void __iomem *base;
> +};
> +
> +#endif /* __LINUX_RZV2M_PWC_H__ */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
