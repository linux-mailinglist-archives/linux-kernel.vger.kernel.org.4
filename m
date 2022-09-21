Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE8F5BF81B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiIUHqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiIUHqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:46:48 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39EF77EB2;
        Wed, 21 Sep 2022 00:46:47 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id c11so3502740qtw.8;
        Wed, 21 Sep 2022 00:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=OhopKPZK57xXKGubPvCv9frnIozANjFyjeXFzVUULTY=;
        b=5Bl0Ov3ZE4I6E0b288w9kl81HA7PP+/Qmmzk7ZvIlRHkZNwIPVjPGyOI0eCEL4xIuO
         Ymozpe/dcnEiQMZuSeD+jJNGpuBPbLtjtkfwoFvBg1cjHPo3Xr/3Y2SQK3vDKalJGaGI
         obQrOLSV1z9F1RrqfXkEWN9yu5nX+ep65XT6BvR3VTq64gaF89ur6ixKVVwTLoOLUI/2
         45mJyWZOEDJr2msm9A8n+pC6v2iw8rjWHO0KdEsHM61tW6gb+kvlbWHU2Pew5usQJ8rk
         zp0jwPhOQlWQiB4XYePkqMekZ/g22cEgo4MpZQVhYJOb3cBMIRlZ8mW5gsFCVTve3Xnw
         /QKg==
X-Gm-Message-State: ACrzQf2gL/qUfOwLpgteco+d4AVJrxEs8vO4SZuJy+9Nj3fLOmgSMXqy
        Uex+BSsWmNbXFu3oyNLX+TyYttvDkYV4Eg==
X-Google-Smtp-Source: AMsMyM5CNdwKzgOZSQLEfegt3sBIMLvD49jy7iKbp2hvykIW4Ph2Toc0fiJ1FN1ZJlqHsJPEI2MJAg==
X-Received: by 2002:ac8:5d49:0:b0:35c:e066:b972 with SMTP id g9-20020ac85d49000000b0035ce066b972mr15221455qtx.303.1663746406583;
        Wed, 21 Sep 2022 00:46:46 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id v6-20020a05620a0f0600b006bc0980db76sm1485535qkl.126.2022.09.21.00.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 00:46:45 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-3454b0b1b6dso54712427b3.4;
        Wed, 21 Sep 2022 00:46:45 -0700 (PDT)
X-Received: by 2002:a81:8d3:0:b0:34d:1215:fb4b with SMTP id
 202-20020a8108d3000000b0034d1215fb4bmr10409981ywi.383.1663746405180; Wed, 21
 Sep 2022 00:46:45 -0700 (PDT)
MIME-Version: 1.0
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 21 Sep 2022 09:46:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUPm36RsxHdVwspR3NCAR3C507AyB6R65W42N2gXWq0ag@mail.gmail.com>
Message-ID: <CAMuHMdUPm36RsxHdVwspR3NCAR3C507AyB6R65W42N2gXWq0ag@mail.gmail.com>
Subject: Similar SoCs with different CPUs and interrupt bindings
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

        Hi Rob, Krzysztof,

This is a topic that came up at the RISC-V BoF at Plumbers, and it was
suggested to bring it up with you.

The same SoC may be available with either RISC-V or other (e.g. ARM) CPU
cores (an example of this are the Renesas RZ/Five and RZ/G2UL SoCs).
To avoid duplication, we would like to have:
  - <riscv-soc>.dtsi includes <base-soc>.dtsi,
  - <arm-soc>.dtsi includes <base-soc>.dtsi.

Unfortunately RISC-V and ARM typically use different types of interrupt
controllers, using different bindings (e.g. 2-cell vs. 3-cell), and
possibly using different interrupt numbers.  Hence the interrupt-parent
and interrupts{-extended} properties should be different, too.

Possible solutions[1]:
  1. interrupt-map

  2. Use a SOC_PERIPHERAL_IRQ() macro in interrupts properties in
     <base-soc>.dtsi, with
       - #define SOC_PERIPHERAL_IRQ(nr, na) nr          // RISC-V
       - #define SOC_PERIPHERAL_IRQ(nr, na) GIC_SPI na  // ARM
     Note that the cpp/dtc combo does not support arithmetic, so even
     the simple case where nr = 32 + na cannot be simplified.

  3. Wrap inside RISCV() and ARM() macros, e.g.:

        RISCV(interrupts = <412 IRQ_TYPE_LEVEL_HIGH>;)
        ARM(interrupts = <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>;)

     Cfr. ARM() and THUMB() in arch/arm/include/asm/unified.h, as used
     to express the same operation using plain ARM or ARM Thumb
     instructions.

Personally, I'm leaning towards the third solution, as it is the most
flexible, and allows us to extend to more than 2 interrupt controllers.

Note that this is actually not a new issue.  For years, ARM SoCs have
existed with multiple types of cores on the same die, using Cortex-A
cores for the application, and Cortex-R/SuperH/V850/... cores for
real-time and/or baseband operation.  So far this wasn't an issue, as
only the Cortex-A cores ran Linux, and we ignored the other cores (and
the related interrupt controllers and hierarchy) in DT.

What do you think?
Thanks for your comments!

[1] https://lore.kernel.org/lkml/20220815050815.22340-7-samuel@sholland.org

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
