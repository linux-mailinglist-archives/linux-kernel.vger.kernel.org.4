Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9CC67B160
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbjAYLdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbjAYLcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:32:51 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFA2CDDF;
        Wed, 25 Jan 2023 03:32:49 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id a25so15607997qto.10;
        Wed, 25 Jan 2023 03:32:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvOTe42diDJsXWior/btva8s4CUD0I041nCSE4A5HyQ=;
        b=pxtHjZvYrQcmhBVCVsR1qptd9W0tXVHWjO8H4ZG/D4k1u8QVTg8igUd7joo2JYAMSb
         S1nQnw67fXGB+HvuqOaAnrba+FH0VPBX6hkQvOnrWm9wWxlc4IPdr2jnbKHdCKJi692m
         UOE1HNul7H4z4edxYHvIS+Nc/rBcx7BmYBFZOkqI2xPTTuzI/jfmuPKREbp/3hesCt9L
         EOFr32jcdVdugRrKw/QCfZcEcxtflM/BQ+5qbqObVrj8bTG4x2EjlNeRj/ZREE7688Ij
         6yzfNiOjADN2tDAbPODUnSJBHfWJRBHzzRLk/COPbJiCHDxRtOA+u426hd9b+ci8NKEu
         c9sg==
X-Gm-Message-State: AO0yUKVoDt62AfcxX/qxC84TFBZnPrHbl/F8Ern6lXE8G6uvAx1rGNP8
        G9axvrkLVrmSk1p/Y9lCwTkgKyYY12K5uw==
X-Google-Smtp-Source: AK7set8Q9avr/pkkmbR9AqjB7f59f6BYJ5zqKR/+HXNXQWK9dUtmh+DoVWs7WVkOQ/+75cmelO2WbQ==
X-Received: by 2002:ac8:4e85:0:b0:3b7:fafc:73e3 with SMTP id 5-20020ac84e85000000b003b7fafc73e3mr6561646qtp.41.1674646368686;
        Wed, 25 Jan 2023 03:32:48 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id 7-20020a05620a048700b006fc2f74ad12sm3326171qkr.92.2023.01.25.03.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 03:32:48 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id 123so22577383ybv.6;
        Wed, 25 Jan 2023 03:32:47 -0800 (PST)
X-Received: by 2002:a25:9801:0:b0:7d5:b884:3617 with SMTP id
 a1-20020a259801000000b007d5b8843617mr2825187ybo.380.1674646367559; Wed, 25
 Jan 2023 03:32:47 -0800 (PST)
MIME-Version: 1.0
References: <20230102221815.273719-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230102221815.273719-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230102221815.273719-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Jan 2023 12:32:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWTSHCLOrTzUq8y860P61jCJ+hMR4oiE_XGtQ9F_8kPBg@mail.gmail.com>
Message-ID: <CAMuHMdWTSHCLOrTzUq8y860P61jCJ+hMR4oiE_XGtQ9F_8kPBg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] pinctrl: renesas: rzg2l: Add BUILD_BUG_ON() checks
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

On Mon, Jan 2, 2023 at 11:19 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add BUILD_BUG_ON() checks to avoid overflows for GPIO configs for each
> supported SoC.
>
> While at it, for readability set n_port_pins based on the GPIO pin configs
> and not on GPIO names for r9a07g044_data as done for r9a07g043_data.
>
> Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2 -> v3
> * No change

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl-for-v6.3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
