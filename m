Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DBE69249F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjBJRiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjBJRis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:38:48 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF826CC4F;
        Fri, 10 Feb 2023 09:38:46 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id y1so5806107wru.2;
        Fri, 10 Feb 2023 09:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iarsir1V1LpADrLXXeDPpAQHGCzDI2yfKTDIM8CLOxQ=;
        b=N6lZJ9WGzWC/ESItuF096sD+7QjDQVaa/Pt9+xKMC1EeeDTGeHM1etT+FDYsyqzd0O
         +zR7PgrlZTjbfB13xR8/8mF1xayoqjWiJlF/G2RDv+OHnJlPR3v92xhAYVb6rKtgpAl3
         ikfWmyJdgg17RkpZj8m4V3nOw0mmDDTolX0UZRZrYZj611I23m7mGhW17z9fclRlIXFP
         1XC+D+TFnBk+JnLHld1ze5m9NuDu2yPrcvnCjtMcPrSVkArTM2LvrjVtYC5RdDBrAP09
         mVqZQm+2h9A2M6ZuzJzw/2luYlcPFKDrxC/RM3gHL2PcfLj8XYPAM5NBNrmlpcGI3Nqb
         fEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iarsir1V1LpADrLXXeDPpAQHGCzDI2yfKTDIM8CLOxQ=;
        b=k6L+nAEFLgQjL1F8WetK86sDi8pxaBbBybGL7AXsKHSlZYaFE7zHKnacWfBJoqPR5c
         FDZeSN4OhWHcFzNcw2L1GjNucBW3fWU7unvD+eBMjxS0HG6riTu1vzVsPP6YEylTZtv1
         3mQFf1aIR55aPC5d7Q5g81PZ2kB6oFuV/9E4gfv0PuItY+RFXPOvUgPE3ow0SuH4gd22
         GPLtus8If4OwjkAYg8LbSbUdG91YXxSJsS4NEWwem9VGntnl4NIUQHy4wzM+MBstojhT
         aIwl+DTJX1AIvYnERCKTkkoW2JusJYm5C7Eow7gaSu56hwxeetck4L5YeXk5kMWKan1L
         3OxA==
X-Gm-Message-State: AO0yUKXU4vKMeZZkK1NiD+BnmZQNeqRy3RG9V+HyVJIKJaH82E/PS5pX
        REwkxnn1IZPH8fbkNZEV5zz2TLsQbXY=
X-Google-Smtp-Source: AK7set+W20apu+hApcIsL8fouWpY6q7XXQy4HYvFACfQ3Y+WfCihl882Vmg94Uxj9XVmbT6tP5VciQ==
X-Received: by 2002:a5d:5231:0:b0:2c3:da8a:192 with SMTP id i17-20020a5d5231000000b002c3da8a0192mr15883469wra.15.1676050724541;
        Fri, 10 Feb 2023 09:38:44 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id t2-20020a0560001a4200b002c3ef7e74bdsm4024184wry.73.2023.02.10.09.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 09:38:43 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v3 0/4] watchdog: mt7621-wdt: avoid globals and arch dependencies
Date:   Fri, 10 Feb 2023 18:38:37 +0100
Message-Id: <20230210173841.705783-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series make an update in the MT7621 SoC's watchdog driver code. This
SoC already provides a system controller node to access reset status
register needed for the watchdog. Instead of using MIPS architecture
dependent operations in header 'asm/mach-ralink/ralink_regs.h' use
a phandle to the system controller node and use it through regmap APIs
from the code. Driver is also using some globals that are not needed at
all if a driver data structure is used along the code. Hence, add all
new needed stuff inside a new driver data structure. With this changes
driver can be properly compile tested.

Thanks in advance for reviewing this!

V1 of this series here [0].
V2 os thise series here [1].

Changes in v3:
    - rename phandler from 'ralink,sysctl' into 'mediatek,sysctl'.
    - Drop error message added in PATHC 3 that modifies functionality and we
      only want to maintain current functionaloty by now.

Changes in v2:
    - Remove no needed compatible 'syscon' from bindings.
    - Rewrite new syscon phandle description in bindings.
    - Remove 'syscon' from compatible in 'mt7621.dtsi'.
    - Split PATCH 3 into two different patches:
        - PATCH 3: removes static globals using a driver data structure.
        - PATCH 4: remove ralink architecture dependent includes and code.

Best regards,
    Sergio Paracuellos

[0]: https://lore.kernel.org/linux-watchdog/20230210065621.598120-1-sergio.paracuellos@gmail.com/T/#t
[1]: https://lore.kernel.org/linux-watchdog/20230210121735.639089-1-sergio.paracuellos@gmail.com/T/#t

Sergio Paracuellos (4):
  dt-bindings: watchdog: mt7621-wdt: add phandle to access system
    controller registers
  mips: dts: ralink: mt7621: add phandle to system controller node for
    watchdog
  watchdog: mt7621-wdt: avoid static global declarations
  watchdog: mt7621-wdt: avoid ralink architecture dependent code

 .../watchdog/mediatek,mt7621-wdt.yaml         |   7 ++
 arch/mips/boot/dts/ralink/mt7621.dtsi         |   1 +
 drivers/watchdog/Kconfig                      |   2 +
 drivers/watchdog/mt7621_wdt.c                 | 119 ++++++++++++------
 4 files changed, 88 insertions(+), 41 deletions(-)

-- 
2.25.1

