Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50288636C27
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 22:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbiKWVOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 16:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbiKWVNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 16:13:48 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6100360346
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 13:13:47 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id z6so20455qtv.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 13:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REepYSvQGyqEeu/ZRQp2JZIqxZIOwqWc5SzYerGHAew=;
        b=mculQF0leNtbQou2zemAjMCIPOe4mtbo6ZaI3SoQUOrPYbmpwZjKEURMJuNIddSc0K
         S0SKnprU6XhARUarT6G5oq5IhiYPe3iCfjHhP19NfZOCod6gSMVaM+N36/htjyEJDSCd
         49SL3RXDf/lCk1srcNhPhPwOnmWmch4f72YD5UGOLHWQPMezBsZ7EZ+rngTEbpblm8IR
         Nn7+X0vSvW/en7Veg8K0fBQ4wt4jP+16DKieDVXvF1ZNlAokrCxrs0ZECvwXu4N6+Kb8
         X9Ux96PTNRGle1f8x9TN2wF+3JIk4lWegfmhAovLg87swEFnBYR+at6lXd4wZWH2bEiX
         oRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REepYSvQGyqEeu/ZRQp2JZIqxZIOwqWc5SzYerGHAew=;
        b=ywlHDn9ZxBZfBmmvBgBslSwN3QDZrsVTk1o2lbSQSIQTK4/bhqriBxxoaWb4LiasKc
         qrxQxVZv7SH7TNDEPAs0hrNj0c+eL10uHox1AHHLqjVH0Lo1X7xvtwTkdlr9617nLRVL
         BrZh7cxUqr29A+UUDw4O98uJTagpne2X72jZ5u9w7y3Xk7CSyr4a2GZpdpsE1l/7MiCN
         SeV4wBXCCAE++loqQsoR4rmobCU4tPgk2IHqiYjh0xBnCUu1cjZa/zcISBQmVG7LJQxJ
         JSfsfGbOyZcmCSj0pWd0GJutgi63zLZwNv8IrMVZdtyfVFPZK1ZJEURC5EH9DWUo+LVJ
         80Kg==
X-Gm-Message-State: ANoB5plLvtZ2KesGwzwzu0V/edVM6aWF6S6Rn2+oOoXzZlFxyTRljIuC
        lTebsyGwSh6IQ5WQBGpR8btYCA==
X-Google-Smtp-Source: AA0mqf6S8r1kTn9XVcCp36idhYyS6f+Vi9KZuRKjP5ZxGucP+Q+1FHhyCFZdkmIcqx9NZ68KJz2HpA==
X-Received: by 2002:a05:622a:1184:b0:3a5:6f39:4bd7 with SMTP id m4-20020a05622a118400b003a56f394bd7mr9685697qtk.226.1669238026485;
        Wed, 23 Nov 2022 13:13:46 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id cf11-20020a05622a400b00b0039ee562799csm10222928qtb.59.2022.11.23.13.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 13:13:46 -0800 (PST)
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
Subject: [PATCH 2/2] mtd: spi-nor: issi: Add in support for IS25LX256 chip, operating in Octal STR mode
Date:   Wed, 23 Nov 2022 16:13:35 -0500
Message-Id: <20221123211335.126417-3-nathan.morrison@timesys.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221123211335.126417-1-nathan.morrison@timesys.com>
References: <20221123211335.126417-1-nathan.morrison@timesys.com>
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

Adds the is25lx256 entry to the nor_parts table along with the
additional STR enablement fixups and logic

Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
---
 drivers/mtd/spi-nor/issi.c | 101 +++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 89a66a19d754..89f3cdd51075 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -8,6 +8,15 @@
 
 #include "core.h"
 
+#define SPINOR_OP_STR_RD	0x8B	/* Fast Read opcode in DTR mode */
+#define SPINOR_OP_STR_PP	0x82	/* Octal Input Fast Program */
+#define SPINOR_OP_RD_ANY_REG	0x85	/* Read volatile register */
+#define SPINOR_OP_WR_ANY_REG	0x81	/* Write volatile register */
+#define SPINOR_REG_CFR0V	0x00	/* For setting octal DTR mode */
+#define SPINOR_REG_CFR1V	0x01	/* For setting dummy cycles */
+#define SPINOR_OCT_STR		0xc7	/* Enable Octal DTR. */
+#define SPINOR_EXSPI		0xff	/* Enable Extended SPI (default) */
+
 static int
 is25lp256_post_bfpt_fixups(struct spi_nor *nor,
 			   const struct sfdp_parameter_header *bfpt_header,
@@ -29,6 +38,94 @@ static const struct spi_nor_fixups is25lp256_fixups = {
 	.post_bfpt = is25lp256_post_bfpt_fixups,
 };
 
+static int spi_nor_issi_octal_str_enable(struct spi_nor *nor, bool enable)
+{
+	struct spi_mem_op op;
+	u8 *buf = nor->bouncebuf;
+	int ret;
+
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
+	if (enable)
+		*buf = SPINOR_OCT_STR;
+	else
+		*buf = SPINOR_EXSPI;
+
+	op = (struct spi_mem_op)
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
+			   SPI_MEM_OP_ADDR(enable ? 3 : 4,
+					   SPINOR_REG_CFR0V, 1),
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_OUT(1, buf, 1));
+
+	if (!enable)
+		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_1_1_8);
+	else
+		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_1_1_1);
+
+
+	ret = spi_mem_exec_op(nor->spimem, &op);
+	if (ret)
+		return ret;
+
+
+	/* Read flash ID to make sure the switch was successful. */
+	op = (struct spi_mem_op)
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 1),
+			   SPI_MEM_OP_NO_ADDR,
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_IN(round_up(nor->info->id_len, 2),
+					      buf, 1));
+
+	if (enable)
+		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_1_1_8);
+	else
+		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_1_1_1);
+
+
+	ret = spi_mem_exec_op(nor->spimem, &op);
+	if (ret)
+		return ret;
+
+	if (memcmp(buf, nor->info->id, nor->info->id_len))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void is25lx256_default_init(struct spi_nor *nor)
+{
+	nor->params->octal_str_enable = spi_nor_issi_octal_str_enable;
+}
+
+static void is25lx256_post_sfdp_fixup(struct spi_nor *nor)
+{
+	/* Fixup read command to 8 dummy cycles, 1S-1S-8S */
+	nor->params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8;
+	spi_nor_set_read_settings(&nor->params->reads[SNOR_CMD_READ_8_8_8],
+				  0, 8, SPINOR_OP_STR_RD,
+				  SNOR_PROTO_1_1_8);
+
+	/* Fixup page program command to 1S-1S-8S */
+	nor->params->hwcaps.mask |= SNOR_HWCAPS_PP_8_8_8;
+	spi_nor_set_pp_settings(&nor->params->page_programs[SNOR_CMD_PP_8_8_8],
+				SPINOR_OP_STR_PP, SNOR_PROTO_1_1_8);
+
+	/*
+	 * The BFPT quad enable field is set to a reserved value so the quad
+	 * enable function is ignored by spi_nor_parse_bfpt(). Make sure we
+	 * disable it.
+	 */
+	nor->params->quad_enable = NULL;
+}
+
+static struct spi_nor_fixups is25lx256_fixups = {
+	.default_init = is25lx256_default_init,
+	.post_sfdp = is25lx256_post_sfdp_fixup,
+};
+
 static void pm25lv_nor_late_init(struct spi_nor *nor)
 {
 	struct spi_nor_erase_map *map = &nor->params->erase_map;
@@ -74,6 +171,10 @@ static const struct flash_info issi_nor_parts[] = {
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
 		.fixups = &is25lp256_fixups },
+	{ "is25lx256",  INFO(0x9d5a19, 0, 128 * 1024, 256)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_STR_PP | SPI_NOR_OCTAL_STR_READ)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES | SPI_NOR_IO_MODE_EN_VOLATILE)
+		.fixups = &is25lx256_fixups },
 
 	/* PMC */
 	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2)
-- 
2.30.2

