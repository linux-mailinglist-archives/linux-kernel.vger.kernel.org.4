Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352C667B159
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbjAYLcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbjAYLcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:32:21 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B754228D36;
        Wed, 25 Jan 2023 03:32:18 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id q15so15672418qtn.0;
        Wed, 25 Jan 2023 03:32:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5WvLd9SfdkHB3CRAH8tRS8s4fzEGNZmn4CEwKI6hPA=;
        b=aAa2B5xaVVryDeodqOzBLBJ9c440ozY2QNwLPYHldAXNW9HRj0/bpgZQCRqXc9yGIY
         cZM5PSGzcjBbY7gFaMO87Gb4jBJEaVcjB1Ekj2gdHi3JjwdhJ2OLYXP/VPtllfR1j5ov
         p41Q/5pCH9AsN2yhloFm0s5whZvinkR1GuwpDOWX0Wo8WW/H3oRcxfiCnudIUbZqE05P
         okRB5MMQlODbjJkKrYFyGAHWJHx0nGgYUp8Crc/JlhvpmYzFJr2KzbGq+cMjJXSsc6Ma
         BGLYd2Lv8daO1yjt/1K5bdnv+k3mSv/dGEAdAV8fST30Qxh39tYJs8Hn3Hy9oD0Cx4zu
         NE2Q==
X-Gm-Message-State: AO0yUKVTKWzaGPDEne14X0m+TV760XL+Ju+I2KVoO1/STR3i3Ri3vi8v
        qVEdhFXetFxMJ6Vb8YG+4140nfGTMsYu6A==
X-Google-Smtp-Source: AK7set9pGXk28AL5VFhZgwC7Csm/rxlQQ9hEemId04ipnJzji4pvb1buPojlgJ99enayJ9jiA0cEkw==
X-Received: by 2002:ac8:59d3:0:b0:3b6:3af6:f2e1 with SMTP id f19-20020ac859d3000000b003b63af6f2e1mr2782330qtf.59.1674646337708;
        Wed, 25 Jan 2023 03:32:17 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id 198-20020a3705cf000000b006fed58fc1a3sm3179962qkf.119.2023.01.25.03.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 03:32:17 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id h5so5674550ybj.8;
        Wed, 25 Jan 2023 03:32:16 -0800 (PST)
X-Received: by 2002:a25:d505:0:b0:7bf:d201:60cb with SMTP id
 r5-20020a25d505000000b007bfd20160cbmr2593496ybe.365.1674646336737; Wed, 25
 Jan 2023 03:32:16 -0800 (PST)
MIME-Version: 1.0
References: <20230102221815.273719-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230102221815.273719-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230102221815.273719-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Jan 2023 12:32:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWM-L9=KW_ZGnK_9t8dn26FT7vc7f9twZcyQ2D03WqA0g@mail.gmail.com>
Message-ID: <CAMuHMdWM-L9=KW_ZGnK_9t8dn26FT7vc7f9twZcyQ2D03WqA0g@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] pinctrl: renesas: rzg2l: Fix configuring the GPIO
 pins as interrupts
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 2, 2023 at 11:18 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> On the RZ/G2UL SoC we have less number of pins compared to RZ/G2L and also
> the pin configs are completely different. This patch makes sure we use the
> appropriate pin configs for each SoC (which is passed as part of the OF
> data) while configuring the GPIO pin as interrupts instead of using
> rzg2l_gpio_configs[] for all the SoCs.
>
> Fixes: bfc69bdbaad1 ("pinctrl: renesas: rzg2l: Add RZ/G2UL support")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2 -> v3
> * No change

Thanks, will queue in renesas-pinctrl-for-v6.3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
