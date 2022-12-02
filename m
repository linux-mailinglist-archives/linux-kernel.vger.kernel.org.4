Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AE364080B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbiLBNz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiLBNzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:55:48 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9707BE4EC
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 05:55:47 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id x28so4028326qtv.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 05:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aN/7/h+h5Hpms0utb+UumNlSGE7V17/9wj785xAfzjY=;
        b=LCzV62wD19bVIRTiuK9BapJ+Qf6X3XlFWMnP6gGd28pj3TviIJMod7uNGVKOdQoVX1
         LsQtUx7YJat0zJT7K4QxsEKU2wfxSR5ZdUHJAnyKCFFK0XMofuQWMpKUs4SmRznJ6S7k
         tujqZqqCkHhwbkvuZnVqoIVjpVXJkzTHYFWqpmzVX84I3GKV7MD1lHql5hEZxl9sET6p
         h2u493NCAAOO4u6m2YkTPkjzoHFjp3f1LRkK1CJQRlmTNGMUV7db5dBNBX59a4Az5XT+
         Fd3nb3MqvIT8BPpsw/mVeoDKF7OldbaE+mcdRdWzoPjPH/N79nmmXwjDWP/zmPqDz0EP
         2olw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aN/7/h+h5Hpms0utb+UumNlSGE7V17/9wj785xAfzjY=;
        b=1+0NMIi+EwJcRMsvZRp8Hwm96XWZ/kCb3wu6474+L5wHgXElXna2WvKoewc/y6lTf3
         glIhLVsYp+qz9M7FyjsQEcCn6UdQb8rvgwd65s/HJssXHAc+Gh3OEWmuznxQQgR5pOAL
         YFWOga5Qw/WMYcmY3opVHmwYhxjJVCpwrSUC16VHHhLha3zhiAVdFyWdpjwcAa7tFXGr
         jQ9lRdaz8GuHY2L5ZvHhcYE8jSnWXFSMdZekgWvhQKNEp5BQpOgJBmlU7FOQrhJIvfFU
         zlEij63WHeSzO3nzkNuSQ71C6yhqpga85suMnDSSTGmXbJKVf/SR0EhsaV6Z+brRW2GA
         GDVg==
X-Gm-Message-State: ANoB5pknzDbH/zZfLWA0dHvyMYMCWMbDoDF2NxCB9No8taCGs48Ul+W7
        yU4D3GaQ69BMFSenvA6b1QF6Cg==
X-Google-Smtp-Source: AA0mqf7VunQ1iCgqE+Mr+ITm3DVf5R0l2fBjJE6prsVBDnASbLmjCsqFDvhXV+bKBmLfq/ij/nWssg==
X-Received: by 2002:ac8:704:0:b0:39c:d509:76a5 with SMTP id g4-20020ac80704000000b0039cd50976a5mr50313757qth.382.1669989346833;
        Fri, 02 Dec 2022 05:55:46 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id x1-20020ac84d41000000b0039a610a04b1sm4122237qtv.37.2022.12.02.05.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 05:55:46 -0800 (PST)
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
Subject: [PATCH v4 3/3] mtd: spi-nor: Add support for IS25LX256 operating in 1S-8S-8S octal read mode
Date:   Fri,  2 Dec 2022 08:55:39 -0500
Message-Id: <20221202135539.271936-4-nathan.morrison@timesys.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221202135539.271936-1-nathan.morrison@timesys.com>
References: <20221202135539.271936-1-nathan.morrison@timesys.com>
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

This adds the IS25LX256 chip into the ISSI flash_info parts table

Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
---
 drivers/mtd/spi-nor/issi.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 89a66a19d754..362bc3603d8f 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -29,6 +29,35 @@ static const struct spi_nor_fixups is25lp256_fixups = {
 	.post_bfpt = is25lp256_post_bfpt_fixups,
 };
 
+static int
+is25lx256_post_bfpt_fixups(struct spi_nor *nor,
+			   const struct sfdp_parameter_header *bfpt_header,
+			   const struct sfdp_bfpt *bfpt)
+{
+	/*
+	 * IS25LX256 supports both 1S-1S-8S and 1S-8S-8S.
+	 * However, the BFPT does not contain any information denoting this
+	 * functionality, so the proper fast read opcodes are never setup.
+	 * We're correcting this issue via the fixup below.  Page program
+	 * commands are detected and setup properly via the 4BAIT lookup.
+	 */
+	params->hwcaps.mask |= SNOR_HWCAPS_READ_1_1_8;
+	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_8],
+				  0, 8, SPINOR_OP_READ_1_1_8,
+				  SNOR_PROTO_1_1_8);
+
+	params->hwcaps.mask |= SNOR_HWCAPS_READ_1_8_8;
+	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_8_8],
+				  0, 16, SPINOR_OP_READ_1_8_8,
+				  SNOR_PROTO_1_8_8);
+
+	return 0;
+}
+
+static const struct spi_nor_fixups is25lx256_fixups = {
+	.post_bfpt = is25lx256_post_bfpt_fixups,
+};
+
 static void pm25lv_nor_late_init(struct spi_nor *nor)
 {
 	struct spi_nor_erase_map *map = &nor->params->erase_map;
@@ -74,6 +103,9 @@ static const struct flash_info issi_nor_parts[] = {
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
 		.fixups = &is25lp256_fixups },
+	{ "is25lx256", INFO(0x9d5a19, 0, 0, 0)
+		PARSE_SFDP
+		.fixups = &is25lx256_fixups },
 
 	/* PMC */
 	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2)
-- 
2.30.2

