Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330A86D18F1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjCaHq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjCaHqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:46:22 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6BF1A977
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:46:19 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a44so3487151ljr.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680248777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0sigra06UdM0F1urZc+vocV5eG5WzPi+hGexEngKTU=;
        b=X1ikQu7cdVcNDirIDWCbHY2Av890uHn1f8iauR36T1CANNByjkJ1iiwjbcMyepMkhy
         3zHuugsWwW1UD5blKh/Y6ow0NvoRRAFjhxte2PhIYV9od2DIPk1RnShAaB5yQhJtTuun
         Jqx4AhYxg9AeQ5RZ3SY1+XlHMcvxszYR2H4+4+sH4vK4RHEoLeV1WSd7m305olcjd8de
         QAO0EloURtLBc8lM9d42gTGYGsL45Jqo/5fdHRTh0yhWdb4QAn4dC0bn5Ul4050sKEmy
         3/xkSRbzi/v2OJF1rY4drkWQ2AYkBiZ1b0roO/GJtoA7RBhCYLBW9oENWCxJH8mjpiyY
         6BRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680248777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0sigra06UdM0F1urZc+vocV5eG5WzPi+hGexEngKTU=;
        b=0n6NeDxnkuL2OsBIsoTvIvsRZCUJ/WcoXL5P3ktZC2sjqDoe/FiPqPYWXDjo75ODTf
         kOzRpn3TOC22dbNH1ruQl69pkEBrVsBuu+EdEJnrlCGmrWT3MscasA2TGjwFn/bYuro9
         zbf7B9B7qNQDuYjn5g6Dy8806Rga4dkPeKgsHxQSbDepT6ZZEk9b5SF9GJtcF0m4eIyS
         Y3R0HMQE2Ii9CvP29ElyzMPXpaJ/xrfkcF7k2nK9rHlDhsvU9VzXnHIzeEXE2w86CWmZ
         FnEj2zu9pF6gO/lvf46zqSd7Ytvklw1gEgYUkC7KZvr6PlRnn7wrgBo8gsCtZuU9zanN
         ti5Q==
X-Gm-Message-State: AAQBX9c4rK/KDkY0r1tyHfCjtoVQD2U7Q7ra6FARg24bBJ1kdt0QJOYv
        B8PDyuYq+PZUHdIpiRGzU1zzew==
X-Google-Smtp-Source: AKy350b8r2jFMVrBia6qxne7eebOupqk+Y/4dq1+p1jUD2XO6Xp/Gssupf4yzEwsAJP4WCXH7pslYA==
X-Received: by 2002:a2e:9cd2:0:b0:29d:76c9:9803 with SMTP id g18-20020a2e9cd2000000b0029d76c99803mr8500974ljj.37.1680248777441;
        Fri, 31 Mar 2023 00:46:17 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id n20-20020a2e8794000000b0029573844d03sm241201lji.109.2023.03.31.00.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 00:46:17 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v5 06/10] mtd: spi-nor: Set the 4-Byte Address Mode method based on SFDP data
Date:   Fri, 31 Mar 2023 07:46:02 +0000
Message-Id: <20230331074606.3559258-7-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230331074606.3559258-1-tudor.ambarus@linaro.org>
References: <20230331074606.3559258-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JESD216 SFDP defines in BFPT methods to enter and exit the
4-Byte Address Mode. The flash parameters and settings that are
retrieved from SFDP have higher precedence than the static
initialized ones, because they should be more accurate and less
error prone than those initialized statically. Parse and favor the
BFPT-parsed set_4byte_addr_mode methods.

Some regressions may be introduced by this patch, because the
params->set_4byte_addr_mode method that was set either in
spi_nor_init_default_params() or later overwritten in default_init()
hooks, are now be overwritten with a different value based on the
BFPT data. If that's the case, the fix is to introduce a post_bfpt
fixup hook where one should fix the wrong BFPT info.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.c      |  7 ++++++-
 drivers/mtd/spi-nor/macronix.c  |  8 +++++++-
 drivers/mtd/spi-nor/micron-st.c |  8 ++++++--
 drivers/mtd/spi-nor/sfdp.c      | 11 +++++++++++
 drivers/mtd/spi-nor/sfdp.h      | 27 +++++++++++++++++++++++++++
 drivers/mtd/spi-nor/winbond.c   | 22 ++++++++++++++--------
 6 files changed, 71 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 75d28224ec62..50297be98d1b 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2898,6 +2898,8 @@ static void spi_nor_init_fixup_flags(struct spi_nor *nor)
  */
 static void spi_nor_late_init_params(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = nor->params;
+
 	if (nor->manufacturer && nor->manufacturer->fixups &&
 	    nor->manufacturer->fixups->late_init)
 		nor->manufacturer->fixups->late_init(nor);
@@ -2905,6 +2907,10 @@ static void spi_nor_late_init_params(struct spi_nor *nor)
 	if (nor->info->fixups && nor->info->fixups->late_init)
 		nor->info->fixups->late_init(nor);
 
+	/* Default method kept for backward compatibility. */
+	if (!params->set_4byte_addr_mode)
+		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_brwr;
+
 	spi_nor_init_flags(nor);
 	spi_nor_init_fixup_flags(nor);
 
@@ -2971,7 +2977,6 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
 	struct device_node *np = spi_nor_get_flash_node(nor);
 
 	params->quad_enable = spi_nor_sr2_bit1_quad_enable;
-	params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_brwr;
 	params->otp.org = &info->otp_org;
 
 	/* Default to 16-bit Write Status (01h) Command */
diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 91a8fa7d4512..075a26945f2d 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -105,11 +105,17 @@ static const struct flash_info macronix_nor_parts[] = {
 static void macronix_nor_default_init(struct spi_nor *nor)
 {
 	nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
-	nor->params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_en4b_ex4b;
+}
+
+static void macronix_nor_late_init(struct spi_nor *nor)
+{
+	if (!nor->params->set_4byte_addr_mode)
+		nor->params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_en4b_ex4b;
 }
 
 static const struct spi_nor_fixups macronix_nor_fixups = {
 	.default_init = macronix_nor_default_init,
+	.late_init = macronix_nor_late_init,
 };
 
 const struct spi_nor_manufacturer spi_nor_macronix = {
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index a75f0f4e1c38..a6f080112a51 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -425,13 +425,17 @@ static void micron_st_nor_default_init(struct spi_nor *nor)
 	nor->flags |= SNOR_F_HAS_LOCK;
 	nor->flags &= ~SNOR_F_HAS_16BIT_SR;
 	nor->params->quad_enable = NULL;
-	nor->params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;
 }
 
 static void micron_st_nor_late_init(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = nor->params;
+
 	if (nor->info->mfr_flags & USE_FSR)
-		nor->params->ready = micron_st_nor_ready;
+		params->ready = micron_st_nor_ready;
+
+	if (!params->set_4byte_addr_mode)
+		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;
 }
 
 static const struct spi_nor_fixups micron_st_nor_fixups = {
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 298ab5e53a8c..69e47c9778a2 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -438,6 +438,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 	size_t len;
 	int i, cmd, err;
 	u32 addr, val;
+	u32 dword;
 	u16 half;
 	u8 erase_mask;
 
@@ -607,6 +608,16 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		break;
 	}
 
+	dword = bfpt.dwords[SFDP_DWORD(16)] & BFPT_DWORD16_4B_ADDR_MODE_MASK;
+	if (SFDP_MASK_CHECK(dword, BFPT_DWORD16_4B_ADDR_MODE_BRWR))
+		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_brwr;
+	else if (SFDP_MASK_CHECK(dword, BFPT_DWORD16_4B_ADDR_MODE_WREN_EN4B_EX4B))
+		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;
+	else if (SFDP_MASK_CHECK(dword, BFPT_DWORD16_4B_ADDR_MODE_EN4B_EX4B))
+		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_en4b_ex4b;
+	else
+		dev_dbg(nor->dev, "BFPT: 4-Byte Address Mode method is not recognized or not implemented\n");
+
 	/* Soft Reset support. */
 	if (bfpt.dwords[SFDP_DWORD(16)] & BFPT_DWORD16_SWRST_EN_RST)
 		nor->flags |= SNOR_F_SOFT_RESET;
diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
index 500659b35655..6eb99e1cdd61 100644
--- a/drivers/mtd/spi-nor/sfdp.h
+++ b/drivers/mtd/spi-nor/sfdp.h
@@ -15,6 +15,7 @@
 
 /* SFDP DWORDS are indexed from 1 but C arrays are indexed from 0. */
 #define SFDP_DWORD(i)		((i) - 1)
+#define SFDP_MASK_CHECK(dword, mask)		(((dword) & (mask)) == (mask))
 
 /* Basic Flash Parameter Table */
 
@@ -89,6 +90,32 @@ struct sfdp_bfpt {
 #define BFPT_DWORD15_QER_SR2_BIT1_NO_RD		(0x4UL << 20)
 #define BFPT_DWORD15_QER_SR2_BIT1		(0x5UL << 20) /* Spansion */
 
+#define BFPT_DWORD16_EN4B_MASK			GENMASK(31, 24)
+#define BFPT_DWORD16_EN4B_ALWAYS_4B		BIT(30)
+#define BFPT_DWORD16_EN4B_4B_OPCODES		BIT(29)
+#define BFPT_DWORD16_EN4B_16BIT_NV_CR		BIT(28)
+#define BFPT_DWORD16_EN4B_BRWR			BIT(27)
+#define BFPT_DWORD16_EN4B_WREAR			BIT(26)
+#define BFPT_DWORD16_EN4B_WREN_EN4B		BIT(25)
+#define BFPT_DWORD16_EN4B_EN4B			BIT(24)
+#define BFPT_DWORD16_EX4B_MASK			GENMASK(18, 14)
+#define BFPT_DWORD16_EX4B_16BIT_NV_CR		BIT(18)
+#define BFPT_DWORD16_EX4B_BRWR			BIT(17)
+#define BFPT_DWORD16_EX4B_WREAR			BIT(16)
+#define BFPT_DWORD16_EX4B_WREN_EX4B		BIT(15)
+#define BFPT_DWORD16_EX4B_EX4B			BIT(14)
+#define BFPT_DWORD16_4B_ADDR_MODE_MASK			\
+	(BFPT_DWORD16_EN4B_MASK | BFPT_DWORD16_EX4B_MASK)
+#define BFPT_DWORD16_4B_ADDR_MODE_16BIT_NV_CR		\
+	(BFPT_DWORD16_EN4B_16BIT_NV_CR | BFPT_DWORD16_EX4B_16BIT_NV_CR)
+#define BFPT_DWORD16_4B_ADDR_MODE_BRWR			\
+	(BFPT_DWORD16_EN4B_BRWR | BFPT_DWORD16_EX4B_BRWR)
+#define BFPT_DWORD16_4B_ADDR_MODE_WREAR			\
+	(BFPT_DWORD16_EN4B_WREAR | BFPT_DWORD16_EX4B_WREAR)
+#define BFPT_DWORD16_4B_ADDR_MODE_WREN_EN4B_EX4B	\
+	(BFPT_DWORD16_EN4B_WREN_EN4B | BFPT_DWORD16_EX4B_WREN_EX4B)
+#define BFPT_DWORD16_4B_ADDR_MODE_EN4B_EX4B		\
+	(BFPT_DWORD16_EN4B_EN4B | BFPT_DWORD16_EX4B_EX4B)
 #define BFPT_DWORD16_SWRST_EN_RST		BIT(12)
 
 #define BFPT_DWORD18_CMD_EXT_MASK		GENMASK(30, 29)
diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 9cea241c204b..834d6ba5ce70 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -216,19 +216,25 @@ static const struct spi_nor_otp_ops winbond_nor_otp_ops = {
 	.is_locked = spi_nor_otp_is_locked_sr2,
 };
 
-static void winbond_nor_default_init(struct spi_nor *nor)
-{
-	nor->params->set_4byte_addr_mode = winbond_nor_set_4byte_addr_mode;
-}
-
 static void winbond_nor_late_init(struct spi_nor *nor)
 {
-	if (nor->params->otp.org->n_regions)
-		nor->params->otp.ops = &winbond_nor_otp_ops;
+	struct spi_nor_flash_parameter *params = nor->params;
+
+	if (params->otp.org->n_regions)
+		params->otp.ops = &winbond_nor_otp_ops;
+
+	/*
+	 * Winbond seems to require that the Extended Address Register to be set
+	 * to zero when exiting the 4-Byte Address Mode, at least for W25Q256FV.
+	 * This requirement is not described in the JESD216 SFDP standard, thus
+	 * it is Winbond specific. Since we do not know if other Winbond flashes
+	 * have the same requirement, play safe and overwrite the method parsed
+	 * from BFPT, if any.
+	 */
+	params->set_4byte_addr_mode = winbond_nor_set_4byte_addr_mode;
 }
 
 static const struct spi_nor_fixups winbond_nor_fixups = {
-	.default_init = winbond_nor_default_init,
 	.late_init = winbond_nor_late_init,
 };
 
-- 
2.40.0.348.gf938b09366-goog

