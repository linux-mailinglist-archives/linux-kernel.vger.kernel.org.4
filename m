Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809E86B47F9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbjCJO4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjCJOzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:55:10 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD62C118BF4;
        Fri, 10 Mar 2023 06:50:35 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id e9-20020a056830200900b00694651d19f6so3019563otp.12;
        Fri, 10 Mar 2023 06:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QrdFa+kbLMKBorg/N02iIyUwqoSJ0NfzGmn1ysWc/dk=;
        b=2XdiZpZK7s9De7IuoSu5+HSrHHiO9o73fV+IkLYywQQpFYlkxywv9WuTUAztysRPaL
         y9h7YiBvtoV8bg7TzvzeccQFiuZOpKfs1Lb357evLXeAcC/2V61FNMorZQX/D8SAKD0/
         /BcV+Uxpg86pOZbxCGza9I/3ppStYexBW8/kum3L3MAmW6RxjN2yFGdMFNKZMfwBWbL5
         ubAqJJvq4LLUHhJFnjkTBjPr52CjZYrYzovILBfBJTFex6MUOZ73OyW9OGJelr+scS7z
         P4UxvsdPEcr5cIwNCcRS0g6Wmm0k8HATJpoEbxCCjdTjT2qv7c4mJv7amv0N8PKxQqYD
         Ae2g==
X-Gm-Message-State: AO0yUKUKIowpz07vRwQS0IpoShfxIbAgfGmdboR67JkE/9RuJnJlnL6+
        PLMnEfEDsL/WQ+fMQeiPUQ==
X-Google-Smtp-Source: AK7set86eN4WoTusNTUyoUqLmafcF6+IvhdKnbV2zSrB36IVEA9DRtbNcoDjmuNaSOhbl1eeeSGHPw==
X-Received: by 2002:a9d:1e7:0:b0:694:3979:726e with SMTP id e94-20020a9d01e7000000b006943979726emr11529393ote.29.1678459703877;
        Fri, 10 Mar 2023 06:48:23 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 63-20020a9d0845000000b00690f6d9a737sm135452oty.8.2023.03.10.06.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:23 -0800 (PST)
Received: (nullmailer pid 1544040 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:16 -0000
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] mtd: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:15 -0600
Message-Id: <20230310144716.1543995-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/mtd/devices/spear_smi.c             | 4 ++--
 drivers/mtd/maps/sun_uflash.c               | 2 +-
 drivers/mtd/mtdcore.c                       | 2 +-
 drivers/mtd/nand/raw/fsmc_nand.c            | 2 +-
 drivers/mtd/nand/raw/nand_macronix.c        | 5 ++---
 drivers/mtd/spi-nor/controllers/nxp-spifi.c | 4 ++--
 6 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/devices/spear_smi.c b/drivers/mtd/devices/spear_smi.c
index f58742486d3d..cc17133be297 100644
--- a/drivers/mtd/devices/spear_smi.c
+++ b/drivers/mtd/devices/spear_smi.c
@@ -820,8 +820,8 @@ static int spear_smi_probe_config_dt(struct platform_device *pdev,
 		pdata->board_flash_info->mem_base = be32_to_cpup(&addr[0]);
 		pdata->board_flash_info->size = be32_to_cpup(&addr[1]);
 
-		if (of_get_property(pp, "st,smi-fast-mode", NULL))
-			pdata->board_flash_info->fast_mode = 1;
+		pdata->board_flash_info->fast_mode =
+			of_property_read_bool(pp, "st,smi-fast-mode");
 
 		i++;
 	}
diff --git a/drivers/mtd/maps/sun_uflash.c b/drivers/mtd/maps/sun_uflash.c
index 6c0c91bfec05..860b19f77090 100644
--- a/drivers/mtd/maps/sun_uflash.c
+++ b/drivers/mtd/maps/sun_uflash.c
@@ -112,7 +112,7 @@ static int uflash_probe(struct platform_device *op)
 	/* Flashprom must have the "user" property in order to
 	 * be used by this driver.
 	 */
-	if (!of_find_property(dp, "user", NULL))
+	if (!of_property_read_bool(dp, "user"))
 		return -ENODEV;
 
 	return uflash_devinit(op, dp);
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 0feacb9fbdac..5ba4227daf7f 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -739,7 +739,7 @@ int add_mtd_device(struct mtd_info *mtd)
 
 	mutex_unlock(&mtd_table_mutex);
 
-	if (of_find_property(mtd_get_of_node(mtd), "linux,rootfs", NULL)) {
+	if (of_property_read_bool(mtd_get_of_node(mtd), "linux,rootfs")) {
 		if (IS_BUILTIN(CONFIG_MTD)) {
 			pr_info("mtd: setting mtd%d (%s) as root device\n", mtd->index, mtd->name);
 			ROOT_DEV = MKDEV(MTD_BLOCK_MAJOR, mtd->index);
diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 6b2bda815b88..0d34d433b732 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -880,7 +880,7 @@ static int fsmc_nand_probe_config_dt(struct platform_device *pdev,
 		}
 	}
 
-	if (of_get_property(np, "nand-skip-bbtscan", NULL))
+	if (of_property_read_bool(np, "nand-skip-bbtscan"))
 		nand->options |= NAND_SKIP_BBTSCAN;
 
 	host->dev_timings = devm_kzalloc(&pdev->dev,
diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
index 1472f925f386..385957eb6762 100644
--- a/drivers/mtd/nand/raw/nand_macronix.c
+++ b/drivers/mtd/nand/raw/nand_macronix.c
@@ -93,14 +93,13 @@ static void macronix_nand_onfi_init(struct nand_chip *chip)
 	struct nand_parameters *p = &chip->parameters;
 	struct nand_onfi_vendor_macronix *mxic;
 	struct device_node *dn = nand_get_flash_node(chip);
-	int rand_otp = 0;
+	int rand_otp;
 	int ret;
 
 	if (!p->onfi)
 		return;
 
-	if (of_find_property(dn, "mxic,enable-randomizer-otp", NULL))
-		rand_otp = 1;
+	rand_otp = of_property_read_bool(dn, "mxic,enable-randomizer-otp");
 
 	mxic = (struct nand_onfi_vendor_macronix *)p->onfi->vendor;
 	/* Subpage write is prohibited in randomizer operatoin */
diff --git a/drivers/mtd/spi-nor/controllers/nxp-spifi.c b/drivers/mtd/spi-nor/controllers/nxp-spifi.c
index ab3990e6ac25..794c7b7d5c92 100644
--- a/drivers/mtd/spi-nor/controllers/nxp-spifi.c
+++ b/drivers/mtd/spi-nor/controllers/nxp-spifi.c
@@ -305,10 +305,10 @@ static int nxp_spifi_setup_flash(struct nxp_spifi *spifi,
 		}
 	}
 
-	if (of_find_property(np, "spi-cpha", NULL))
+	if (of_property_read_bool(np, "spi-cpha"))
 		mode |= SPI_CPHA;
 
-	if (of_find_property(np, "spi-cpol", NULL))
+	if (of_property_read_bool(np, "spi-cpol"))
 		mode |= SPI_CPOL;
 
 	/* Setup control register defaults */
-- 
2.39.2

