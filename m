Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDBD63AECF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbiK1RZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiK1RZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:25:04 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A176D1EAEE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:25:03 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id x18so7783095qki.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WISYZ1L8dfjkhr9HPz2HhCPMd5gq2zqE5S/0zz5aWa0=;
        b=hcx970gPX8djEoRWtYW0NHM3NG3c5io9Z9ad1LPZUPufe2wTe0GoeT1ULY2q0sjog7
         NncYkw5V+5VopZJInbOAWSlwue7xv6ssNaSdX5RMpm1CWKFEwvqeHvqNdotA32Ug6/Nj
         SCcBemXPE/DvCahfHVNKFZFrtEMLnF1hGcWuMS0qjtL5qMTkRQabXULrNw40xHY6K0T/
         hnooEZ1UjrCmv3U+mNOldEaKxF8/sDX5HYBFXeaKHCnSOzlmbTe+GNfXB5Jly9q66nfZ
         OElGWiZxz02rWn3kQW5D0ru7zZEKl1aYBwyt3LAk17NUxUAW604R1mCCo9WnT4cwTO/G
         xKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WISYZ1L8dfjkhr9HPz2HhCPMd5gq2zqE5S/0zz5aWa0=;
        b=srBDIKg1JJATVWW3qzNdqEqnb4goCYldoLO2lABQiaihM6L5cnRuTTDnqBn1tLnL2C
         BD41oxPZL6z80Q0mHbgCO1pmTGLbASNUxv/csvTXblkMehNkBgMAYHL+i2Umwgmp44yU
         dwCbBdHhdHh/uCd1pTYVlQSsUcicQh2Lb6oGyy13cBDzEYmSOnXPWBJlrzry0aW362fq
         SMi/fBXPQFa6dAKKKZ6Y/x+PXfrOC2aAk41f3dN2T5pHe05+6Venbo2FmbDsJz4R9H7N
         /+iKecgTjdB1UX5+xlLDsm8KU/cWDvB2cWM+7vDc3iOUleqLz425W6buAeeJjSxxRsDp
         2fkQ==
X-Gm-Message-State: ANoB5pkIEEThaOPCNQZUgRLl/Pogv3uOp7W4LpIcwCaHoKuVSMtzR9yS
        R00hCdpm1KY6PpNtdE/jZ8N4eg==
X-Google-Smtp-Source: AA0mqf7J2PGTa8s7U3vNZDbIq6NFc/rDbfTBe35D7AbD06oqD+c+yNMjAQxBaVljPT+i/M7mRn5ZcA==
X-Received: by 2002:a05:620a:271f:b0:6fc:15c2:c4a8 with SMTP id b31-20020a05620a271f00b006fc15c2c4a8mr27490322qkp.174.1669656302813;
        Mon, 28 Nov 2022 09:25:02 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id r9-20020a05622a034900b003a526675c07sm7322712qtw.52.2022.11.28.09.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 09:25:02 -0800 (PST)
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
Subject: [PATCH] mtd: spi-nor: issi: Add in support for IS25LX256 chip, operating in 1S-1S-8S mode.
Date:   Mon, 28 Nov 2022 12:24:54 -0500
Message-Id: <20221128172455.159787-1-nathan.morrison@timesys.com>
X-Mailer: git-send-email 2.30.2
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

Adds the is25lx256 entry to the nor_parts table along with the additional
fixup logic to operate in 1S-1S-8S mode while programming.

Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
---
 drivers/mtd/spi-nor/issi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 89a66a19d754..e9b32b726bf3 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -29,6 +29,21 @@ static const struct spi_nor_fixups is25lp256_fixups = {
 	.post_bfpt = is25lp256_post_bfpt_fixups,
 };
 
+static void is25lx256_post_sfdp_fixup(struct spi_nor *nor)
+{
+	/* Fixup page program command to 1S-1S-8S */
+	nor->params->hwcaps.mask |= SNOR_HWCAPS_PP_1_1_8;
+	spi_nor_set_pp_settings(&nor->params->page_programs[SNOR_CMD_PP_1_1_8],
+				SPINOR_OP_PP_1_1_8, SNOR_PROTO_1_1_8);
+
+	/* Disable quad_enable */
+	nor->params->quad_enable = NULL;
+}
+
+static struct spi_nor_fixups is25lx256_fixups = {
+	.post_sfdp = is25lx256_post_sfdp_fixup,
+};
+
 static void pm25lv_nor_late_init(struct spi_nor *nor)
 {
 	struct spi_nor_erase_map *map = &nor->params->erase_map;
@@ -74,6 +89,10 @@ static const struct flash_info issi_nor_parts[] = {
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
 		.fixups = &is25lp256_fixups },
+	{ "is25lx256",  INFO(0x9d5a19, 0, 128 * 1024, 256)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_READ)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &is25lx256_fixups },
 
 	/* PMC */
 	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2)
-- 
2.30.2

