Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F54610FD0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiJ1LfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiJ1LfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:35:18 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677A16B65B;
        Fri, 28 Oct 2022 04:35:16 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id d13so3197941qko.5;
        Fri, 28 Oct 2022 04:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yam5XYWQb6y7gKmWe0fD9G/82ZNnLxLp0NPkpKXtkPQ=;
        b=hFlmsC2jNUkECNbMKm1K+OH42ndwYTMhZ90zXWyoiMx2lKWcV2l9MXAg82xRFCUhGO
         GISZnFB7RXqpms2Es956Z/xt8Bp3bUwObRB6e0f+NC2lcdMbUlNbgiVc75QvIMv+nuOE
         nWEH7Ore8SoSK/VPL++7rjYAj4p1086XXATS9njzG2vWNPP4kzbPuTCtITvIqy3PMCox
         CkP9zqeDj0nX2ZQz5ZvNtA6t3R31mNtHF2h2sP29khAli7pUzmCsxlKr69RcGNO9V7zv
         k7lwmvkey3xLl6y60LUL8YyHi7JCwyMlthx71g5ql56PNdvM8R0BWnbDz/kU/0XbCHiC
         QJQg==
X-Gm-Message-State: ACrzQf3z7enA601AO9goJvj9HcUshNkfzvFZcQUCMp6g/wkkhQ3P84Dk
        1bLN1X7a1GwKan6/zW6+f0MGLxEN4xeCxw==
X-Google-Smtp-Source: AMsMyM7gJwNOt1TP8H5NSEOfSB4RdgmJGTeRMyI15CpFeoAUgP1Nr5PE32vZHEg+YvjcsIPiMmmn7A==
X-Received: by 2002:a05:620a:51c4:b0:6fa:e95:264c with SMTP id cx4-20020a05620a51c400b006fa0e95264cmr313381qkb.115.1666956915887;
        Fri, 28 Oct 2022 04:35:15 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id y2-20020a05620a44c200b006ce76811a07sm2772434qkp.75.2022.10.28.04.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 04:35:14 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id m125so5796326ybb.6;
        Fri, 28 Oct 2022 04:35:13 -0700 (PDT)
X-Received: by 2002:a25:d64e:0:b0:6cb:7faa:af94 with SMTP id
 n75-20020a25d64e000000b006cb7faaaf94mr16836632ybg.36.1666956913602; Fri, 28
 Oct 2022 04:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221025220629.79321-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221025220629.79321-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221025220629.79321-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 28 Oct 2022 13:35:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXw0DTAXFjqutP4X2E3gzkBQ579tHPfjtLC2X0j3R-+Lw@mail.gmail.com>
Message-ID: <CAMuHMdXw0DTAXFjqutP4X2E3gzkBQ579tHPfjtLC2X0j3R-+Lw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: renesas: r9a07g043: Split out RZ/G2UL
 SoC specific parts
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Prabhakar,

On Wed, Oct 26, 2022 at 12:06 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Move RZ/G2UL SoC specific parts to r9a07g043u.dtsi so that r9a07g043.dtsi
> can be shared with RZ/Five (RISC-V SoC).
>
> Below are the changes due to which SoC specific parts are moved to
> r9a07g043u.dtsi:
> - RZ/G2UL has Cortex-A55 (ARM64) whereas the RZ/Five has AX45MP (RISC-V)
> - RZ/G2UL has GICv3 as interrupt controller whereas the RZ/Five has PLIC
> - RZ/G2UL has interrupts for SYSC block whereas interrupts are missing
>   for SYSC block on RZ/Five
> - RZ/G2UL has armv8-timer whereas the RZ/Five has riscv-timer
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.2.

> ---
> RFC->v2
> * Updated commit message about timer

Right. And I'll add while applying:

  - RZ/G2UL has PSCI whereas RZ/Five have OpenSBI


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
