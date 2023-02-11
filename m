Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247B8692F03
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 08:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBKHeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 02:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBKHeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 02:34:03 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3721CF48;
        Fri, 10 Feb 2023 23:34:02 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r18so5363014wmq.5;
        Fri, 10 Feb 2023 23:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mS48sJa2kBrwifHNkgUloOkh4Q8E05ql75kqB8Pm4RA=;
        b=PPByFFsxA1wL66MHhB39Owp3aIB3s0UYiMniNrY91MwDMUWyq/rv2eWQjnVVc4lfzF
         xnRxUoo1ywURS4zctOmf6uGaEAsO9vXuxzLkO3EIXsKTj5nHPqz7akPmVupsq9yIhnUY
         OjMQ0iI3o8whEU9wIaYuIWAnEOReQ8qpXx1Lu7pdIymQk7OGo/2BXkv0d9CCu85l9dxG
         TvaXZTubO9OmJrM0KFgErMc8Rft+xwdXfFKLHw8cLGnNB8X9NSwfWqrZJCAsXkH9DNuK
         IAznW9nCs0SFKg2vwkX9JuwGwIxi4bukM13ke5G25g3shAiPcS1G2kMZDibqIymgmBFq
         X//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mS48sJa2kBrwifHNkgUloOkh4Q8E05ql75kqB8Pm4RA=;
        b=5eS/gOV0QCvsAs41RIIcRVZELZth5LLI/dAKhBcuz7VuouIWdl9iRvzbpBFfZ3eHeK
         8LAnDmo0CpLQ+bCwqBrfwoF9ouTC7uOvZSrhl1vsn37ZOlgW2VzjhFx8d6LUahLJTnxa
         etwsYFDmKcaMHboOXFVGXxbS6DwUDrGxRPk2sUWQKp3yqcuGaXZ4OdNRWtYdybeA6w4U
         DY//0EcJKUdoC6pQdKYpXkNUg8nt93dXK0azEpoJyIZ20p1i/fH9msw/0e/aCkG18N0O
         PRqOWz+ulX+5k3E0lA/hZfxdsfpPqcXnb6oI5PcaW+eUrZN60ttK2TmpxWc4BCmRStwI
         40/A==
X-Gm-Message-State: AO0yUKUJND892YIFP794qbqKgk8ng9KcWbIQSed0tDDy59M8qHPn5y8q
        Xys+pGOfAvM5fOPygjBX4iMQYl2w9iU=
X-Google-Smtp-Source: AK7set+8Lm9GHQpQE7GlX5jlxh8bgUOrJddBLabrKIxQDzNEaW0EhSIwEjMQHd1aQGjZu5nixGw8fg==
X-Received: by 2002:a05:600c:4394:b0:3de:a525:1d05 with SMTP id e20-20020a05600c439400b003dea5251d05mr534554wmn.8.1676100840220;
        Fri, 10 Feb 2023 23:34:00 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003daf681d05dsm7917829wms.26.2023.02.10.23.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 23:33:59 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v4 0/5] watchdog: mt7621-wdt: avoid globals and arch dependencies
Date:   Sat, 11 Feb 2023 08:33:52 +0100
Message-Id: <20230211073357.755893-1-sergio.paracuellos@gmail.com>
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

v1 of this series here [0].
v2 os thise series here [1].
v3 os thise series here [2].

Cahnges in v4:
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

Sergio Paracuellos (5):
  dt-bindings: watchdog: mt7621-wdt: add phandle to access system
    controller registers
  mips: dts: ralink: mt7621: add phandle to system controller node for
    watchdog
  mips: dts: ralink: mt7621: rename watchdog node from 'wdt' into
    'watchdog'
  watchdog: mt7621-wdt: avoid static global declarations
  watchdog: mt7621-wdt: avoid ralink architecture dependent code

 .../watchdog/mediatek,mt7621-wdt.yaml         |   7 ++
 arch/mips/boot/dts/ralink/mt7621.dtsi         |   3 +-
 drivers/watchdog/Kconfig                      |   4 +-
 drivers/watchdog/mt7621_wdt.c                 | 119 ++++++++++++------
 4 files changed, 90 insertions(+), 43 deletions(-)

-- 
2.25.1

