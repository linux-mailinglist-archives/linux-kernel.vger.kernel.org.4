Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F9661EE7B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiKGJP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiKGJPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:15:25 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5382B3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:15:24 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id r12so15894465lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 01:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9uKTBrb1cZ8JuClZS3AGG9aisdrkJ7CzIFst1hgk3qs=;
        b=oDJNR31hj7iUbwjauab9UvB3Q9h9onQgb7TbWvtG4rm7WHKo7YonXPQBbM51Z74olx
         e9Goa2k6AMJfwomNn+qPUFKY0/UJemsbDejiKJNTan/eQeaLAvNhkukaLci0U49Py7ow
         YPXN3gYV7QDU7aGA6AjofZGtDuD4BEmNiT5a9Y+IMVBRc/LmmPR0QWrt++f4Jg98QTnu
         i/PeIjHwqMK8K+QfvFTjTt4jzkYdbqIAslPP3O+45m1YFMDns1+OOU7GNumZ6XLT2ZQ4
         zBj/HqvcMR9kZw3luuh6b5oypg8YqZmaIM96TzvwO4SqPRTXobUDdVYG7zkky19YRCGR
         wqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9uKTBrb1cZ8JuClZS3AGG9aisdrkJ7CzIFst1hgk3qs=;
        b=sz0A8K6kH5feqGIp6pt/FQ44S8v49za4kVxHG+7kFOL87T26K9iDt30wwhXtFGNqul
         bxQVUhzNJYp7+NMo+Hc4oQ9/awz5p4CBvSfagy7PqZem6vECEC1Vx0kFZmmEwhZfASzO
         4kdndl0gTG46wRL76rFdXm/Fr8vQStb5KJx2GwJ58NpBX+m7Suz4AHBp9n77ckGJBb1+
         Wuw0lqEfzuEhVDLyEaI8PbIrVXlaeRuwI4OB6Yv6vwx6GxQKJnnk4AI7LYaxMTIXu8Aq
         VG+KZ/u09NRa+mWLFyrR6m+L7FH8A4BDHWaySG5pvE5dTINzKgGLY3F4nTgjYSLtrnTi
         i9Gw==
X-Gm-Message-State: ACrzQf08l3y+1OHPY+4UlcYVxoWz2kTDr6/eSb8G+iUKSDhlnRK70Lvc
        lsquA+hWCMVeMgcrFXj9OKxuM2NwMpZAVw==
X-Google-Smtp-Source: AMsMyM6YWPkIuKdP98rWv6xcwRnTEE1S5vHzsHTFZZwL75lSkeSRTzSr+lizaqvB8PzLV/E4+XZy6A==
X-Received: by 2002:ac2:47fc:0:b0:4a2:4e9a:64f5 with SMTP id b28-20020ac247fc000000b004a24e9a64f5mr18556671lfp.434.1667812523272;
        Mon, 07 Nov 2022 01:15:23 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id h20-20020ac250d4000000b004a240eb0217sm1133588lfm.251.2022.11.07.01.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 01:15:22 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH v2] mtd: onenand: omap2: add dependency on GPMC
Date:   Mon,  7 Nov 2022 10:15:20 +0100
Message-Id: <20221107091520.127053-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OMAP2 OneNAND driver uses gpmc_omap_onenand_set_timings() provided by
OMAP_GPMC driver, so the latter cannot be module if OneNAND driver is
built-in:

  /usr/bin/arm-linux-gnueabi-ld: drivers/mtd/nand/onenand/onenand_omap2.o: in function `omap2_onenand_probe':
  onenand_omap2.c:(.text+0x520): undefined reference to `gpmc_omap_onenand_set_timings'

The OMAP_GPMC is also a runtime dependency.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 854fd9209b20 ("memory: omap-gpmc: Allow building as a module")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Always require OMAP_GPMC (drop !OMAP_GPMC).
2. Adjust commit msg.
---
 drivers/mtd/nand/onenand/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/onenand/Kconfig b/drivers/mtd/nand/onenand/Kconfig
index 34d9a7a82ad4..c94bf483541e 100644
--- a/drivers/mtd/nand/onenand/Kconfig
+++ b/drivers/mtd/nand/onenand/Kconfig
@@ -26,6 +26,7 @@ config MTD_ONENAND_OMAP2
 	tristate "OneNAND on OMAP2/OMAP3 support"
 	depends on ARCH_OMAP2 || ARCH_OMAP3 || (COMPILE_TEST && ARM)
 	depends on OF || COMPILE_TEST
+	depends on OMAP_GPMC
 	help
 	  Support for a OneNAND flash device connected to an OMAP2/OMAP3 SoC
 	  via the GPMC memory controller.
-- 
2.34.1

