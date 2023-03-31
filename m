Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31FF6D18F4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjCaHrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjCaHqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:46:23 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6891B342
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:46:21 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id bx10so3807234ljb.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680248781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CyiO/jnkSOlLjiVkDdzrMM9bu1slR1a/Gy4hc+IUQ0=;
        b=w/saDpoF/cRoH5b+CQjU9rtOa6p8TYSJC1TDruBFhj2CblA9jaH2F6gvnMwjEpqDbH
         QHIkNy1njUCGjA/rXy7FllIVvaFfu3CUw/M/HmTouDJNZvAtS+PazJYC7oAKaH8KDkX5
         WI062OJ5QWVvPlE+SEw0ryRC0J8J6WGgQ2LPJXcSt1wqYvBx5jsmuP3NCJauthszER0Z
         yWtd1HFJ6ayiLXDqhcapBQLmFpW5xzr3oX4zuHhbGWIu8HyzqGE2PM9MhYPbZgpFBvjg
         /SRIjb/i+/MFAr+/bYhFZ5H4MYJeVY0F/BsrjHmvjAUTKRHdCU54wN6uaqfntbIkBhAI
         PJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680248781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CyiO/jnkSOlLjiVkDdzrMM9bu1slR1a/Gy4hc+IUQ0=;
        b=wdlwhFKKo/p3JKjFaZUp1qE4XuCKbswrERCQYJm8wus/pWCA1POveTiSTHB2GL5+y3
         XK6x55YKU/AeXKxihfVFt/3of4A7TGv2Td78vNqnt+fR0hI4Rs+bh4MXGw06WzKH3ySE
         C0lSInmYbuCW6avqCJ+L0VWczp2JBHf5A2hSDUp8ooNL6VTgPNtjV69DKlGBnauzZA3z
         KkS4hL/v/T5YMKND3U/kyHoT0poq59nHot+XIEnu0NifbrhaOwvUeU8zHLKFg2XISZsN
         xDbTuCKEyeuf+JhP/RddjPRRZsGcYDbhQ23i1f8mWTZeO7/BLpjivOCwtheZsM7EPcm/
         hOjQ==
X-Gm-Message-State: AAQBX9c0GMc7Cj4lbS7JBXo8VefEg/z5jRqjkEPqACBaERSTABCs8K/t
        v886HeJ6nBttEZBdraEmjcdmEQ==
X-Google-Smtp-Source: AKy350ZbPm/yrV6sn5Kp3ZKiO9RGV0dAUb6FJN47DstZEkyK7QWtzq94utFXbdjVFl9q2kaNBTImXw==
X-Received: by 2002:a2e:9cc7:0:b0:2a6:1b80:1fe8 with SMTP id g7-20020a2e9cc7000000b002a61b801fe8mr1378806ljj.0.1680248780812;
        Fri, 31 Mar 2023 00:46:20 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id n20-20020a2e8794000000b0029573844d03sm241201lji.109.2023.03.31.00.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 00:46:20 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v5 10/10] mtd: spi-nor: spansion: Determine current address mode
Date:   Fri, 31 Mar 2023 07:46:06 +0000
Message-Id: <20230331074606.3559258-11-tudor.ambarus@linaro.org>
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Internal address mode (3- or 4-byte) affects to the address length in
Read Any Reg op. Read Any Reg op is used in SMPT parse and other setup
functions. Current driver assumes that address mode is factory default
but users can change it via volatile and non-volatile registers.

Current address mode can be checked by CFR2V[7] but Read Any Reg op is
needed to read CFR2V (chicken-and-egg).

Introduce a way to determine current address mode by comparing status
register 1 values read by different address length.

Suggested-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/spansion.c | 131 ++++++++++++++++++++++++++++++++-
 1 file changed, 128 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 1678b7b2e9f7..352c40dd3864 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -14,10 +14,12 @@
 #define SPINOR_OP_CLSR		0x30	/* Clear status register 1 */
 #define SPINOR_OP_RD_ANY_REG			0x65	/* Read any register */
 #define SPINOR_OP_WR_ANY_REG			0x71	/* Write any register */
+#define SPINOR_REG_CYPRESS_STR1V		0x00800000
 #define SPINOR_REG_CYPRESS_CFR1V		0x00800002
 #define SPINOR_REG_CYPRESS_CFR1_QUAD_EN		BIT(1)	/* Quad Enable */
 #define SPINOR_REG_CYPRESS_CFR2V		0x00800003
 #define SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24	0xb
+#define SPINOR_REG_CYPRESS_CFR2_ADRBYT		BIT(7)
 #define SPINOR_REG_CYPRESS_CFR3V		0x00800004
 #define SPINOR_REG_CYPRESS_CFR3_PGSZ		BIT(4) /* Page size. */
 #define SPINOR_REG_CYPRESS_CFR5V		0x00800006
@@ -188,6 +190,117 @@ static int cypress_nor_quad_enable_volatile(struct spi_nor *nor)
 	return 0;
 }
 
+/**
+ * cypress_nor_determine_addr_mode_by_sr1() - Determine current address mode
+ *                                            (3 or 4-byte) by querying status
+ *                                            register 1 (SR1).
+ * @nor:		pointer to a 'struct spi_nor'
+ * @addr_mode:		ponter to a buffer where we return the determined
+ *			address mode.
+ *
+ * This function tries to determine current address mode by comparing SR1 value
+ * from RDSR1(no address), RDAR(3-byte address), and RDAR(4-byte address).
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int cypress_nor_determine_addr_mode_by_sr1(struct spi_nor *nor,
+						  u8 *addr_mode)
+{
+	struct spi_mem_op op =
+		CYPRESS_NOR_RD_ANY_REG_OP(3, SPINOR_REG_CYPRESS_STR1V, 0,
+					  nor->bouncebuf);
+	bool is3byte, is4byte;
+	int ret;
+
+	ret = spi_nor_read_sr(nor, &nor->bouncebuf[1]);
+	if (ret)
+		return ret;
+
+	ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
+	if (ret)
+		return ret;
+
+	is3byte = (nor->bouncebuf[0] == nor->bouncebuf[1]);
+
+	op = (struct spi_mem_op)
+		CYPRESS_NOR_RD_ANY_REG_OP(4, SPINOR_REG_CYPRESS_STR1V, 0,
+					  nor->bouncebuf);
+	ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
+	if (ret)
+		return ret;
+
+	is4byte = (nor->bouncebuf[0] == nor->bouncebuf[1]);
+
+	if (is3byte == is4byte)
+		return -EIO;
+	if (is3byte)
+		*addr_mode = 3;
+	else
+		*addr_mode = 4;
+
+	return 0;
+}
+
+/**
+ * cypress_nor_set_addr_mode_nbytes() - Set the number of address bytes mode of
+ *                                      current address mode.
+ * @nor:		pointer to a 'struct spi_nor'
+ *
+ * Determine current address mode by reading SR1 with different methods, then
+ * query CFR2V[7] to confirm. If determination is failed, force enter to 4-byte
+ * address mode.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int cypress_nor_set_addr_mode_nbytes(struct spi_nor *nor)
+{
+	struct spi_mem_op op;
+	u8 addr_mode;
+	int ret;
+
+	/*
+	 * Read SR1 by RDSR1 and RDAR(3- AND 4-byte addr). Use write enable
+	 * that sets bit-1 in SR1.
+	 */
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+	ret = cypress_nor_determine_addr_mode_by_sr1(nor, &addr_mode);
+	if (ret) {
+		ret = spi_nor_set_4byte_addr_mode(nor, true);
+		if (ret)
+			return ret;
+		return spi_nor_write_disable(nor);
+	}
+	ret = spi_nor_write_disable(nor);
+	if (ret)
+		return ret;
+
+	/*
+	 * Query CFR2V and make sure no contradiction between determined address
+	 * mode and CFR2V[7].
+	 */
+	op = (struct spi_mem_op)
+		CYPRESS_NOR_RD_ANY_REG_OP(addr_mode, SPINOR_REG_CYPRESS_CFR2V,
+					  0, nor->bouncebuf);
+	ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
+	if (ret)
+		return ret;
+
+	if (nor->bouncebuf[0] & SPINOR_REG_CYPRESS_CFR2_ADRBYT) {
+		if (addr_mode != 4)
+			return spi_nor_set_4byte_addr_mode(nor, true);
+	} else {
+		if (addr_mode != 3)
+			return spi_nor_set_4byte_addr_mode(nor, true);
+	}
+
+	nor->params->addr_nbytes = addr_mode;
+	nor->params->addr_mode_nbytes = addr_mode;
+
+	return 0;
+}
+
 /**
  * cypress_nor_set_page_size() - Set page size which corresponds to the flash
  *                               configuration.
@@ -227,9 +340,9 @@ s25fs256t_post_bfpt_fixup(struct spi_nor *nor,
 	struct spi_mem_op op;
 	int ret;
 
-	/* 4-byte address mode is enabled by default */
-	nor->params->addr_nbytes = 4;
-	nor->params->addr_mode_nbytes = 4;
+	ret = cypress_nor_set_addr_mode_nbytes(nor);
+	if (ret)
+		return ret;
 
 	/* Read Architecture Configuration Register (ARCFN) */
 	op = (struct spi_mem_op)
@@ -280,6 +393,12 @@ s25hx_t_post_bfpt_fixup(struct spi_nor *nor,
 			const struct sfdp_parameter_header *bfpt_header,
 			const struct sfdp_bfpt *bfpt)
 {
+	int ret;
+
+	ret = cypress_nor_set_addr_mode_nbytes(nor);
+	if (ret)
+		return ret;
+
 	/* Replace Quad Enable with volatile version */
 	nor->params->quad_enable = cypress_nor_quad_enable_volatile;
 
@@ -375,6 +494,12 @@ static int s28hx_t_post_bfpt_fixup(struct spi_nor *nor,
 				   const struct sfdp_parameter_header *bfpt_header,
 				   const struct sfdp_bfpt *bfpt)
 {
+	int ret;
+
+	ret = cypress_nor_set_addr_mode_nbytes(nor);
+	if (ret)
+		return ret;
+
 	return cypress_nor_set_page_size(nor);
 }
 
-- 
2.40.0.348.gf938b09366-goog

