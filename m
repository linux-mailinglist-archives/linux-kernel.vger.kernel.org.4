Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436056947B8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjBMOJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBMOJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:09:49 -0500
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85F1113FF;
        Mon, 13 Feb 2023 06:09:46 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id mg2so1174114qvb.9;
        Mon, 13 Feb 2023 06:09:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIx7iOv4awyIg6e6bYoyKtpDPdQ/N84+GemJuTUJibc=;
        b=Vt+K47R7JfdQuvkbTaVwgh5nSFm76N4o54+zvp4tUxgWgpx0NwsKSBru+Af7BXFFMp
         0wddQvR20anbsJ2PxqemRvF5zn9et1vNE1gG2P9ToRFWviCwee9hkqn0RdCA/JMleqe3
         eFLYW4UKCcXZCdGzxvT1ornnWoGl9xKPqcIJjfgKjLos5gxXEEOb5Esdp3sE0lb4qf8m
         zrYojidFAWsk/LnA9vA1jO4FI0BT8d5vOkGVsPEYl2XmUq5l4K8uRooYkNwqKGse2CrA
         NmBEdQzUoIJeEuX87JNnfb1lD8dlDbUr6sQmedDwc5HmUg3yx6AkM9UkJa6uUtwuV+TB
         zjlw==
X-Gm-Message-State: AO0yUKVxnFVL9CLlOlJHGRQE/f5CnbjM1x9SLuxv+VGSKObYpCVGos5P
        X1ZEEobCgrNo4vJQniCXIK6PtEvmGU1Cig==
X-Google-Smtp-Source: AK7set9Zf5tiC2qkf70M3ILdt98GK0lAgJehVgRDjcwlzH/FPXT5N6tcUDiUKBGg2FBT3CbelmKmQQ==
X-Received: by 2002:a05:6214:27cb:b0:56e:a7d1:4d65 with SMTP id ge11-20020a05621427cb00b0056ea7d14d65mr9401737qvb.52.1676297385852;
        Mon, 13 Feb 2023 06:09:45 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id y206-20020a3764d7000000b0071c2a68d6f2sm9787015qkb.20.2023.02.13.06.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 06:09:45 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-52f1b1d08c2so39429087b3.5;
        Mon, 13 Feb 2023 06:09:45 -0800 (PST)
X-Received: by 2002:a0d:e004:0:b0:52a:7505:84bc with SMTP id
 j4-20020a0de004000000b0052a750584bcmr2454168ywe.383.1676297385046; Mon, 13
 Feb 2023 06:09:45 -0800 (PST)
MIME-Version: 1.0
References: <20230131223529.11905-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230131223529.11905-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230131223529.11905-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Feb 2023 15:09:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUszsaQDOT-eZz8+BvFGsFuBbhif+-gHDEZa_oMZUG7ng@mail.gmail.com>
Message-ID: <CAMuHMdUszsaQDOT-eZz8+BvFGsFuBbhif+-gHDEZa_oMZUG7ng@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: renesas: r9a07g044: Use SoC specific
 macro for CPG and RESET
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Prabhakar,

On Tue, Jan 31, 2023 at 11:42 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Use a SoC specific macro for CPG and RESET so that we can re-use the
> RZ/G2L SoC DTSI for RZ/V2L SoC by just updating the SoC specific macro.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * No change

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> @@ -1,12 +1,16 @@
>  // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  /*
> - * Device Tree Source for the RZ/G2L and RZ/G2LC common SoC parts
> + * Device Tree Source for the RZ/G2L, RZ/G2LC and RZ/V2L common SoC parts
>   *
>   * Copyright (C) 2021 Renesas Electronics Corp.
>   */
>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +#ifndef SOC_CPG_PREFIX
>  #include <dt-bindings/clock/r9a07g044-cpg.h>
> +#define SOC_CPG_PREFIX(X)      R9A07G044_ ## X

As we're setting a precedent, this might as well be just SOC_PREFIX(X).
Some SoCs have multiple sets of definitions.
I can make that change myself while/if applying.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> +#endif

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
