Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC24C6C4363
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjCVGlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjCVGkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:40:45 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563F75B5D9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:40:43 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y20so22080512lfj.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679467241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jv+mpUAZwkOh2eeM+ctcdr1FWMN9cPSlCRNPkUJDfOM=;
        b=IsUHCsURkrKzfVF9FTo8CpXo5cdwqWMeHrhqOZXQ2LJ7Dxj125BHHR7lB0mgVaHrEB
         6jqc2tIt/Ojae4grV8rz812MXaoiuYheF3e1g6KceYQ1CGvCvceU2YbBNUNxgusosHq9
         tZ625ww5rA6Khu7QRyre8+Udyzoyn7W/3fIwloiYuqwvgmioJ4xs6mi7r26R5e8vlFPQ
         8nK0M5PNnwmN2KilGY114n1OZC6dmd1ilfXfSQgyh+nCl8Kzu0n+LzGQxI3ROKqZoBji
         KzAo0qQWrOKXTGL2ZAsKhkPDJ8Af6qhXdieLEHXeU0g/uzKgTnVDdqE5S5M5j3qsbjJf
         AftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679467241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jv+mpUAZwkOh2eeM+ctcdr1FWMN9cPSlCRNPkUJDfOM=;
        b=ZZQIQ02CguyBMC+gv0LMWKLamv7vz5ELyzhKAX8DAjWTZzMVCbpRk8ZU8NgihzXko8
         k/yGZ//KJGdyeOmBafX3tuEs8ltOvAQfjPYIFhLkOmz/qtpNWfe8ESB8LKKkErCiPtes
         Y9gCbfckt5aIctKZ2VR/ykEi+3Qo6Tl/tlMNy3Wv0CHqMS8QZUmb7C/s4Yi/XKnWmK9D
         5UPsK3wkpOnsDESdoOmaigHguoZ/m1/D4PXHXXRbOkq8JRIbxQqQhLsngOiNXvXWA57N
         R6c+0/bGzUjw6X4EATpzDCFghC+d62dI0qR/AWNoILlYQey4F0079QHw1hfLn7bdspu7
         f2/w==
X-Gm-Message-State: AO0yUKVvTkltPEnhIz9Jm1Nx6qi2NdnWpi1W5gjgWaN8ythCfGWFTxbM
        X9TXk5nkqp5HDMyXVpBKuptQcw==
X-Google-Smtp-Source: AK7set/WXhgfu25geTxkrdgYFE1ioV5AxG+bYZaCiZxwqSgK04DjO1lvy2TvrbLCaxZcNxLJuRNEaA==
X-Received: by 2002:a19:ae12:0:b0:4b5:26f3:2247 with SMTP id f18-20020a19ae12000000b004b526f32247mr1430002lfc.69.1679467241660;
        Tue, 21 Mar 2023 23:40:41 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id n20-20020ac242d4000000b004dafde0e7b7sm2462255lfl.279.2023.03.21.23.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 23:40:41 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 06/11] mtd: spi-nor: Parse BFPT to determine the 4-Byte Address Mode methods
Date:   Wed, 22 Mar 2023 06:40:28 +0000
Message-Id: <20230322064033.2370483-7-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230322064033.2370483-1-tudor.ambarus@linaro.org>
References: <20230322064033.2370483-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BFPT[DWORD(16)] defines the methods to enter and exit the 4-Byte Address
Mode. Parse BFPT to determine the method. Will rename the methods with
generic names in a further patch, to keep things trackable in this one.

Some regressions may be introduced by this patch, because the
params->set_4byte_addr_mode method that was set either in
spi_nor_init_default_params() or later overwritten in default_init() hooks,
may now be overwritten with a different value based on the BFPT data. If
that's the case, the fix is to introduce a post_bfpt fixup hook where one
should fix the wrong BFPT info.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/sfdp.c    | 11 +++++++++++
 drivers/mtd/spi-nor/sfdp.h    | 28 ++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/winbond.c | 11 ++++++++++-
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 298ab5e53a8c..63b2810cf75e 100644
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
+	if (sfdp_bits_set(dword, BFPT_DWORD16_4B_ADDR_MODE_BRWR))
+		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_brwr;
+	else if (sfdp_bits_set(dword, BFPT_DWORD16_4B_ADDR_MODE_WREN_EN4B_EX4B))
+		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;
+	else if (sfdp_bits_set(dword, BFPT_DWORD16_4B_ADDR_MODE_EN4B_EX4B))
+		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_en4b_ex4b;
+	else
+		dev_dbg(nor->dev, "BFPT: 4-Byte Address Mode method is not recognized or not implemented\n");
+
 	/* Soft Reset support. */
 	if (bfpt.dwords[SFDP_DWORD(16)] & BFPT_DWORD16_SWRST_EN_RST)
 		nor->flags |= SNOR_F_SOFT_RESET;
diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
index 500659b35655..a4b5fe795f18 100644
--- a/drivers/mtd/spi-nor/sfdp.h
+++ b/drivers/mtd/spi-nor/sfdp.h
@@ -16,6 +16,8 @@
 /* SFDP DWORDS are indexed from 1 but C arrays are indexed from 0. */
 #define SFDP_DWORD(i)		((i) - 1)
 
+#define sfdp_bits_set(dword, mask)		(((dword) & (mask)) == (mask))
+
 /* Basic Flash Parameter Table */
 
 /* JESD216 rev D defines a Basic Flash Parameter Table of 20 DWORDs. */
@@ -89,6 +91,32 @@ struct sfdp_bfpt {
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
index 9cea241c204b..a1b387accc07 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -218,13 +218,22 @@ static const struct spi_nor_otp_ops winbond_nor_otp_ops = {
 
 static void winbond_nor_default_init(struct spi_nor *nor)
 {
-	nor->params->set_4byte_addr_mode = winbond_nor_set_4byte_addr_mode;
 }
 
 static void winbond_nor_late_init(struct spi_nor *nor)
 {
 	if (nor->params->otp.org->n_regions)
 		nor->params->otp.ops = &winbond_nor_otp_ops;
+
+	/*
+	 * Winbond seems to require that the Extended Address Register to be set
+	 * to zero when exiting the 4-Byte Address Mode, at least for W25Q256FV.
+	 * This requirement is not described in the JESD216 SFDP standard, thus
+	 * it is Winbond specific. Since we do not know if other Winbond flashes
+	 * have the same requirement, play safe and overwrite the method parsed
+	 * from BFPT, if any.
+	 */
+	nor->params->set_4byte_addr_mode = winbond_nor_set_4byte_addr_mode;
 }
 
 static const struct spi_nor_fixups winbond_nor_fixups = {
-- 
2.40.0.rc1.284.g88254d51c5-goog

