Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B175F3CD5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 08:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJDGmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 02:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJDGmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 02:42:12 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B762BB3B;
        Mon,  3 Oct 2022 23:42:08 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id s18so7650693qtx.6;
        Mon, 03 Oct 2022 23:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=n6EQp8JL+DToxMMS0kkitvfxHKUAhOYfF1Ik8pCR8iY=;
        b=nVFm9G2lijfn5u7aonxyXyeWxSgQzGV9aABVxsOgaArHgFb8nl+s1UCk0+6fwCiTGK
         x4D71Y6dZHlOmKbtbakGAzFnFubqM/7iDhQmSivuGmqMnzJ+8HUcFr9UB7NsL4KyCdu0
         ORIx979wsz8bbJbm47VFo5zpNXqRkmhQ/Twn8ryOaEweY/wAr2nCTIyBI8hvdHDUjMpr
         Ngzs4LgPQU4i2FZhxw+Vlhc55pH01MaCoYuZ/bAiU35b7Npkir1woDl2E02buGZxGT/L
         DkRmoh+fT/tSG6EE0m5/D5uK+Ri4++aoAq/I2swq7aXB5rstKyasK1z95UwYVTxotZUo
         Hsbw==
X-Gm-Message-State: ACrzQf0HVCT7QswALSjMN2v2UlsT+EVaeCuAVB+eEfc2yH4+h94pmX7/
        SOa6v87zqZ0G+W/9bAqhp+ZhDcMKWtxfvA==
X-Google-Smtp-Source: AMsMyM5z0TIMxZLvT6YAA+IHQRrTvh4iZ2VCi9JPVV6N0cEK88c/LR6hbiBbGSvNRq6Q5UrfCRDv4w==
X-Received: by 2002:a05:622a:4c11:b0:35c:bbb2:d177 with SMTP id ey17-20020a05622a4c1100b0035cbbb2d177mr18721567qtb.314.1664865727325;
        Mon, 03 Oct 2022 23:42:07 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id 16-20020ac84e90000000b0035d4b13363fsm12189155qtp.48.2022.10.03.23.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 23:42:05 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id f189so15668535yba.12;
        Mon, 03 Oct 2022 23:42:05 -0700 (PDT)
X-Received: by 2002:a25:bc8f:0:b0:6bd:ab73:111 with SMTP id
 e15-20020a25bc8f000000b006bdab730111mr8977272ybk.36.1664865724940; Mon, 03
 Oct 2022 23:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221003223222.448551-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221003223222.448551-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Oct 2022 08:41:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX1BuvHz46QWd+ajEcwmWMeSmvN4AtODuFEysRk14ArZQ@mail.gmail.com>
Message-ID: <CAMuHMdX1BuvHz46QWd+ajEcwmWMeSmvN4AtODuFEysRk14ArZQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] dt-bindings: soc: renesas: r9a07g043f-l2-cache:
 Add DT binding documentation for L2 cache controller
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Prabhakar,

On Tue, Oct 4, 2022 at 12:32 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add DT binding documentation for L2 cache controller found on RZ/Five SoC.
>
> The Renesas RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
> Single) from Andes. The AX45MP core has an L2 cache controller, this patch
> describes the L2 cache block.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/renesas/r9a07g043f-l2-cache.yaml

Not andestech,ax45mp-cache.yaml?

> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2022 Renesas Electronics Corp.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/renesas/r9a07g043f-l2-cache.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiFive L2 Cache Controller

Andestech AX45MP?

> +
> +maintainers:
> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> +
> +description:
> +  A level-2 cache (L2C) is used to improve the system performance by providing
> +  a larger amount of cache line entries and reasonable access delays. The L2C
> +  is shared between cores, and a non-inclusive non-exclusive policy is used.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: andestech,ax45mp-cache
> +      - const: cache

This makes the schema apply to any node which is compatible with
"cache", cfr. the report from Rob's bot.

You need a select block to avoid that, cfr.
Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
