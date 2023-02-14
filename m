Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B5B6960FE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjBNKjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjBNKjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:39:42 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA47244B6;
        Tue, 14 Feb 2023 02:39:40 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id co8so11381199wrb.1;
        Tue, 14 Feb 2023 02:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oGjm8oBx0DVqNF28ZQWMD/Yy3Cb0BqYpu5HyyEPRUT4=;
        b=Jxq3HftI2tU9Q1sJCyGfgNcZ0OJSlkmn7JRWjGq/IVNaycfKG0mpJvfe6UaatTWHLX
         o0bQgL7WEQn6bsrMiL9e3HhvRKUX6zp2jf8D6YV8TJ+FiI7yE5hLg3vSdS60YpvjQ4Pr
         NDOBtb6AJqkeWHYwqJx8o0fuv1CKMuUypSmO/t33CfIS1Yala57mwEn6Fy5koz5sbKjE
         Zt8rbXAwrWM+ZpoLnOFevDs1l3xOjLAk6QpKdwTG3tXScSt8Bp6YshbrfG7Ityk+hvok
         W2P97Rdn4vcicGmDxJ37NCRNUzgoPrzrWJ5Q9HKIvkkqvagO/GyHRH6e0Y3s37ZzA1hv
         pz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oGjm8oBx0DVqNF28ZQWMD/Yy3Cb0BqYpu5HyyEPRUT4=;
        b=gBDq24yWm2FGvBKt4Zz6IA3rdR7mRYtm6QCjRoYQjbQVhe/4Zr5lEle+meVDQOf7Wp
         EoPx2PtnaS0a9Aadp7QkT1dSR4Mdhmhkg3iZUw60EuIrYBcRJ2vVp5e/SJVWp3G+3Vf/
         W8uW+RW4ifzExEfQRZA5+n1yuLaP94ItiUWrcjz6/NxSVufmH68GE7Eo4uQ5dhBIH2fA
         h9Z+spgJk08oHwF8Zt3knlA0zUTAB/QcW9pdTxTFVECjuSNvyhCpzBC3gRPBcJAbAAIS
         23nYhTTmKrobKUwrCupsnRt2/2EaiWWzy6XXuERt3KcecMCRDUMhDWKgaWMZcBNr/MgJ
         fPgA==
X-Gm-Message-State: AO0yUKVsuifico3tpVkyet23lDwXxR1IiHaeJH26CAbdThftWofwEQRS
        blvCSoy1WM7I1ktURaAwIGfduzp1FT0=
X-Google-Smtp-Source: AK7set87XWldfUeW3qzBirdz3IGvGZDTJ9pr2WGrPT4qeEz8VdHRQee+fZ7IB6fc7su/UToyUXpXKQ==
X-Received: by 2002:a5d:514a:0:b0:2c5:54a7:363a with SMTP id u10-20020a5d514a000000b002c554a7363amr1826254wrt.3.1676371178869;
        Tue, 14 Feb 2023 02:39:38 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d6102000000b002be5bdbe40csm12693241wrt.27.2023.02.14.02.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 02:39:38 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v7 0/5] watchdog: mt7621-wdt: avoid globals and arch dependencies
Date:   Tue, 14 Feb 2023 11:39:31 +0100
Message-Id: <20230214103936.1061078-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

v1 of this series here [0].
v2 of this series here [1].
v3 of this series here [2].
v4 of this series here [3].
v5 of this series here [4].
v6 of this series here [5].

Changes in v7:
    - Restore phandler 'mediatek,sysctl' in bindings with Krzysztof's 'Acked-by'.
    - Use regmap syscon 'syscon_regmap_lookup_by_phandle()' and only if this
      fails use 'syscon_regmap_lookup_by_compatible()' to avoid DTB's ABI breakage.

Changes in v6:
    - Get regmap syscon using 'syscon_regmap_lookup_by_compatible()'
    - Add COMPILE_TEST and dependencies to Kconfig.
    - Collect Philippe Mathieu-Daudé 'Reviewed-by' tag for watchdog node
      warning fix.

Changes in v5:
    - Drop patches related with device tree ABI breakage and only
      maintain the rest.
    - Collect Arinc 'Reviewed-by' tag for watchdog node warning fix.

Changes in v4:
    - Add a patch to fix a watchdog node warning with 'make dtbs_check'
      because of a wrong node name.
    - Collect Guenter 'Reviewed-by' tags for watchdog driver code.
    - Add a missing 'COMPILE_TEST' to Kconfig which was lost when driver
      code was split in two patches in v2.

Changes in v3:
    - rename phandler from 'ralink,sysctl' into 'mediatek,sysctl'.
    - Drop error message added in PATCH 3 that modifies functionality
      and we only want to maintain current functionaloty by now.

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
[2]: https://lore.kernel.org/linux-watchdog/20230210173841.705783-1-sergio.paracuellos@gmail.com/T/#t
[3]: https://lore.kernel.org/linux-watchdog/20230211073357.755893-1-sergio.paracuellos@gmail.com/T/#t
[4]: https://lore.kernel.org/linux-watchdog/20230213120638.850612-1-sergio.paracuellos@gmail.com/T/#t
[5]: https://lore.kernel.org/linux-watchdog/b302c25e-5365-c335-c790-71b3135847d0@arinc9.com/T/#t

Sergio Paracuellos (5):
  dt-bindings: watchdog: mt7621-wdt: add phandle to access system
    controller registers
  mips: dts: ralink: mt7621: rename watchdog node from 'wdt' into
    'watchdog'
  mips: dts: ralink: mt7621: add phandle to system controller node for
    watchdog
  watchdog: mt7621-wdt: avoid static global declarations
  watchdog: mt7621-wdt: avoid ralink architecture dependent code

 .../watchdog/mediatek,mt7621-wdt.yaml         |   7 +
 arch/mips/boot/dts/ralink/mt7621.dtsi         |   3 +-
 drivers/watchdog/Kconfig                      |   4 +-
 drivers/watchdog/mt7621_wdt.c                 | 122 ++++++++++++------
 4 files changed, 93 insertions(+), 43 deletions(-)

-- 
2.25.1

