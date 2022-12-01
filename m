Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A960363F9CD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiLAV2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiLAV17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:27:59 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9637345ED2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:27:56 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id jr1so2661676qtb.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 13:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEyo4vlQR3u2sX38LTBhVX1Aa2arb17/54UJyym5vVg=;
        b=EWk5IELMmlI38n1uhUacmXE6nI16ZieyrjDtXucqKGOoILjkZCVKd7G5MmpoHtVUDR
         FODUAoMPinQwe7s/RYoC24pIP5eSH5ct7ktaljx7Ne+L+GrC7Zw9P1lbpqcNIctg7Oys
         K5MPpKo9YR9fnOMDN/QtxzqAAqAFeoUA8LuDQM/xMlxw4jadGSbkKxbwBV8M2Ypa8+HO
         fyZ56Xplt1NT6SFye1XZpVCIYFEiCmoA7TZeQwcNZKkCy3GQJkYiTY7N8Qzco3MdgL+Z
         BJexh6if4a8RuEKHFOxVaUqXIMFiqiYJ/HMg6j1NhyhdRS/lLtn+FvKyEXmCRrosq6hB
         UQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEyo4vlQR3u2sX38LTBhVX1Aa2arb17/54UJyym5vVg=;
        b=gqN/M/IXinX4V7vw3oLGZS+owYGaCjNXXrZcUoHiZF+Ckm4Zs1exRFiKY7oe10kMtP
         CZQT2c4dGZbRZYI9OSJihAzl2IlySptCaCX1kem3xWRpnB4GlW6kf+27OqyN3tGvfrIl
         19p4lLpET4jEnsdWqnu2rzwn9FIsp34BQM4mxaDttI4hdM8hCapCQ0vMsDVekMDc1yRM
         LA96zAlWMw/SwGlw4UnbljyL5L8GDzn5ykg4o0Qgj4ln1iSmvTxrtTsWXqv2LvxDDc9Z
         5D5f2wrijlfJlswzpky3vkutXJSsTzmmA3zcLKU64Ml/cr4a3MGCg/vw6inZfSETMUEK
         amyg==
X-Gm-Message-State: ANoB5pm8Dpj15vCUKe41N2a+rdxDYzPQusBu9vVh/CDOnc9/I2/5iwaQ
        L0m66bnMN+y/dIBH+hdUP2r/eA==
X-Google-Smtp-Source: AA0mqf4k5vhbOKyhVfUNFXRGyBkYZpgvQPpouVWk0dqcsycuplAYPA4KGV+Z/aOB9NXAI7JE7i3h3w==
X-Received: by 2002:a05:620a:1098:b0:6ef:a7f:e09d with SMTP id g24-20020a05620a109800b006ef0a7fe09dmr61482350qkk.109.1669930075721;
        Thu, 01 Dec 2022 13:27:55 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id l15-20020a37f90f000000b006fc447eebe5sm4071321qkj.27.2022.12.01.13.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 13:27:55 -0800 (PST)
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
Subject: [PATCH v3 2/3] mtd: spi-nor: Add additional octal-mode flags to be checked during SFDP
Date:   Thu,  1 Dec 2022 16:27:49 -0500
Message-Id: <20221201212750.267721-3-nathan.morrison@timesys.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221201212750.267721-1-nathan.morrison@timesys.com>
References: <20221201212750.267721-1-nathan.morrison@timesys.com>
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
 drivers/mtd/spi-nor/core.c | 8 ++++++++
 drivers/mtd/spi-nor/core.h | 5 +++--
 drivers/mtd/spi-nor/sfdp.c | 8 ++++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index bee8fc4c9f07..2f882608abc6 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2359,6 +2359,13 @@ static void spi_nor_no_sfdp_init_params(struct spi_nor *nor)
 					  SNOR_PROTO_1_1_8);
 	}
 
+	if (no_sfdp_flags & SPI_NOR_OCTAL_READ_1_8_8) {
+		params->hwcaps.mask |= SNOR_HWCAPS_READ_1_8_8;
+		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_8_8],
+					  0, 16, SPINOR_OP_READ_1_8_8,
+					  SNOR_PROTO_1_8_8);
+	}
+
 	if (no_sfdp_flags & SPI_NOR_OCTAL_DTR_READ) {
 		params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
 		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8_DTR],
@@ -2514,6 +2521,7 @@ static void spi_nor_init_params_deprecated(struct spi_nor *nor)
 	if (nor->info->no_sfdp_flags & (SPI_NOR_DUAL_READ |
 					SPI_NOR_QUAD_READ |
 					SPI_NOR_OCTAL_READ |
+					SPI_NOR_OCTAL_READ_1_8_8 |
 					SPI_NOR_OCTAL_DTR_READ))
 		spi_nor_sfdp_init_params_deprecated(nor);
 }
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 85b0cf254e97..7bc1cde049b7 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -514,8 +514,9 @@ struct flash_info {
 #define SPI_NOR_DUAL_READ		BIT(3)
 #define SPI_NOR_QUAD_READ		BIT(4)
 #define SPI_NOR_OCTAL_READ		BIT(5)
-#define SPI_NOR_OCTAL_DTR_READ		BIT(6)
-#define SPI_NOR_OCTAL_DTR_PP		BIT(7)
+#define SPI_NOR_OCTAL_READ_1_8_8	BIT(6)
+#define SPI_NOR_OCTAL_DTR_READ		BIT(7)
+#define SPI_NOR_OCTAL_DTR_PP		BIT(8)
 
 	u8 fixup_flags;
 #define SPI_NOR_4B_OPCODES		BIT(0)
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index e4e87815ba94..e1b7547bf81e 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -1089,6 +1089,14 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 		spi_nor_set_pp_settings(&params_pp[SNOR_CMD_PP_1_4_4],
 					SPINOR_OP_PP_1_4_4_4B,
 					SNOR_PROTO_1_4_4);
+	if (pp_hwcaps & SNOR_HWCAPS_PP_1_1_8)
+		spi_nor_set_pp_settings(&params_pp[SNOR_CMD_PP_1_1_8],
+					SPINOR_OP_PP_1_1_8_4B,
+					SNOR_PROTO_1_1_8);
+	if (pp_hwcaps & SNOR_HWCAPS_PP_1_8_8)
+		spi_nor_set_pp_settings(&params_pp[SNOR_CMD_PP_1_8_8],
+					SPINOR_OP_PP_1_8_8_4B,
+					SNOR_PROTO_1_8_8);
 
 	for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++) {
 		if (erase_mask & BIT(i))
-- 
2.30.2

