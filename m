Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94B363F75A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiLASQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiLASPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:15:53 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF544730A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 10:15:47 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id y15so1876694qtv.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 10:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQZKgZOgE0+wcpYy5gXw4iw3dPKVanHGPihBaubSi28=;
        b=x59QEa7bZQqO1AFVk9FRyfCCfSVGHzLtXt+GsDBzQV2XpmgTbI+20SSoPy5NjJtFgX
         frSLaVwZbwm7Nb2Wyathy4WvUU75+ba0wLS5DldfJj9Q60RbFEqRy6fTIlxCFfluUQob
         2CSOFUwNoNDIng9xnWp6eBL/UAqSFpBZkS7+OrX9h1UIbPxk1JleYhWSLWQCfxkli469
         UtOrZyDzD2ob8P3nFLmdaUtZ8Akf7AG4bpaMdiBf1O8Ar7dl7d0y6qBfguHe4Aw+xuQ8
         h6N9aJksd3DnK2KQgJLjk7q0cQRmd20GsNGHYHnsEpgBQ95IuqCRmhiRQ41/OQL3Hwn6
         jEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQZKgZOgE0+wcpYy5gXw4iw3dPKVanHGPihBaubSi28=;
        b=mpyHO64/3dzj3LbMjqKZUHa7KHPNTPWkv/i8cT/fgCFHY3PP0zMAQINkKnLx5/iVYG
         2HWj0Il51pPT1XEg45XLqdIQ3l/RxampU4ZRWHtbcMIT/xxB/6ZuCQpIouCKk9GNRioq
         A5klFFqUpFccClVZnwkuCH04Ts/j8i2wA4WDEGEGxQVnDiEvsfDulqmpVw215esT/wi0
         7wy3Sw++N4/gS/Z+ZieymtWhvzt2m87MIhGDy3ytJsfussMmkVSjR/1/9h8feGEmwUWf
         7outcGMcF8tspY592UXXPiGAYP41O4iIwCQ+c0ccrbV+A7sPB7zafEr3eh4Vz4TQ0amH
         C4pA==
X-Gm-Message-State: ANoB5pmFeqiI2lURmnOgrKR4teOHXa5uwRjoxmKk4uQzvTWfNGtQ0UAW
        Qysn6rbdHKVfg/OS6bStfpg9Bw==
X-Google-Smtp-Source: AA0mqf7+IDmSKa2Va2r5CHxgM9ham1PoxV3KaGTyA7NkUkgl3HX8cBko8K0JCB+8esEWHVjYtYkdMg==
X-Received: by 2002:a05:622a:8cf:b0:3a4:ef5c:c69d with SMTP id i15-20020a05622a08cf00b003a4ef5cc69dmr23190959qte.194.1669918546392;
        Thu, 01 Dec 2022 10:15:46 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id f12-20020ac8464c000000b003a55fe9f352sm2908912qto.64.2022.12.01.10.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 10:15:45 -0800 (PST)
From:   Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     nathan.morrison@timesys.com, greg.malysa@timesys.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org (open list:SPI NOR SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] mtd: spi-nor: Add additional octal-mode flags to be checked during SFDP
Date:   Thu,  1 Dec 2022 13:15:31 -0500
Message-Id: <20221201181532.255449-3-nathan.morrison@timesys.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221201181532.255449-1-nathan.morrison@timesys.com>
References: <20221201181532.255449-1-nathan.morrison@timesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds some support for searching a chips SFDP table for:

read commands: 1S-8S-8S
program commands: 1S-1S-8S, 1S-8S-8S

Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
---
 drivers/mtd/spi-nor/core.c | 21 ++++++++++++++++++++-
 drivers/mtd/spi-nor/core.h |  9 ++++++---
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index bee8fc4c9f07..7475a9a22881 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2335,7 +2335,7 @@ static void spi_nor_no_sfdp_init_params(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params = nor->params;
 	struct spi_nor_erase_map *map = &params->erase_map;
-	const u8 no_sfdp_flags = nor->info->no_sfdp_flags;
+	const u16 no_sfdp_flags = nor->info->no_sfdp_flags;
 	u8 i, erase_mask;
 
 	if (no_sfdp_flags & SPI_NOR_DUAL_READ) {
@@ -2359,6 +2359,25 @@ static void spi_nor_no_sfdp_init_params(struct spi_nor *nor)
 					  SNOR_PROTO_1_1_8);
 	}
 
+	if (no_sfdp_flags & SPI_NOR_OCTAL_READ_1_8_8) {
+		params->hwcaps.mask |= SNOR_HWCAPS_READ_1_8_8;
+		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_8_8],
+					  0, 16, SPINOR_OP_READ_1_8_8,
+					  SNOR_PROTO_1_8_8);
+	}
+
+	if (no_sfdp_flags & SPI_NOR_OCTAL_PP) {
+		params->hwcaps.mask |= SNOR_HWCAPS_PP_1_1_8;
+		spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_1_1_8],
+					SPINOR_OP_PP_1_1_8, SNOR_PROTO_1_1_8);
+	}
+
+	if (no_sfdp_flags & SPI_NOR_OCTAL_PP_1_8_8) {
+		params->hwcaps.mask |= SNOR_HWCAPS_PP_1_8_8;
+		spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_8_8_8],
+					SPINOR_OP_PP_1_8_8, SNOR_PROTO_1_8_8);
+	}
+
 	if (no_sfdp_flags & SPI_NOR_OCTAL_DTR_READ) {
 		params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
 		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8_DTR],
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 85b0cf254e97..25a0d4f1850b 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -508,14 +508,17 @@ struct flash_info {
 #define NO_CHIP_ERASE			BIT(7)
 #define SPI_NOR_NO_FR			BIT(8)
 
-	u8 no_sfdp_flags;
+	u16 no_sfdp_flags;
 #define SPI_NOR_SKIP_SFDP		BIT(0)
 #define SECT_4K				BIT(1)
 #define SPI_NOR_DUAL_READ		BIT(3)
 #define SPI_NOR_QUAD_READ		BIT(4)
 #define SPI_NOR_OCTAL_READ		BIT(5)
-#define SPI_NOR_OCTAL_DTR_READ		BIT(6)
-#define SPI_NOR_OCTAL_DTR_PP		BIT(7)
+#define SPI_NOR_OCTAL_READ_1_8_8	BIT(6)
+#define SPI_NOR_OCTAL_PP		BIT(7)
+#define SPI_NOR_OCTAL_PP_1_8_8		BIT(8)
+#define SPI_NOR_OCTAL_DTR_READ		BIT(9)
+#define SPI_NOR_OCTAL_DTR_PP		BIT(10)
 
 	u8 fixup_flags;
 #define SPI_NOR_4B_OPCODES		BIT(0)
-- 
2.30.2

