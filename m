Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F1363F841
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiLATa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiLATac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:30:32 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9ECAC82FD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:30:19 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id l15so2199488qtv.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 11:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=di9LveXhpEtODK6vNhn4RUvUpuP2viTSwK389nw6d5U=;
        b=Q9R68ZQ7HsrNWZEFMqiSQNq+RhKlxioliytl4uSs8OlRH24UleTMhx3H85j/7lcXqM
         s+7u7FdqM5fQjce9x4HP7ATNv4ze+cyTxfSGX/lGMHauhqq49M+7UhIV9d4Ymh2LZSAZ
         r5iStg9r2b07FXwWJbwX6t6zicVto3KWcfIZ4WzgLyCRs8/aQs83Fuo3KxqnAYLxYeVg
         pMn04vczvmtdI1cvbJGVZuq0aXuqmP3K3PwSyGQXYKFDuPJfyn2Od6HPPwDJJnvGAt0G
         RmeaiUIgR52l9eoiSvtwEbG93oGncnNi+jJ32MPuMWxnUEdXsIILvOMxxiqsU5SHXyma
         aGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=di9LveXhpEtODK6vNhn4RUvUpuP2viTSwK389nw6d5U=;
        b=thkyLfVnmjL+aDhtdZ8IaNAkPb6US9ju6336zbGb87u5XxOR4XrBhlZUsUH2iAdQ1N
         ecVHnzms67+WeQLHKD1nVnaG2mT9dI4vTRpmMcBQzdvde2Ol7CVx7ndD3yDM7H1j9ZSg
         PcEI+Uc9lB5VQi9NzVwl0GEV+ZiQVE+u+8SgUfzWyGe47c3gR6HaRtlvbS+a3Cr5Lb1o
         /crhi6F7gxiOtIR1GQJAckHkeHWGdtBlhf8FphKBjaKywxBGgrLVREOF5+/yP4aKKOCS
         OfHbC/b9SMn5yruomKYp0K055fVAfEACJFuhUIZeGcHgZu7EcGXhNFZ9lWIKojRlp7Jr
         L7NQ==
X-Gm-Message-State: ANoB5plfn+nCDCY26kZ5Ok78Ea3uhFc/UdSOpp9NOzHpMRlRKJwQBNfn
        Pfo6FJd2Au605FALcQzY7ohhgg==
X-Google-Smtp-Source: AA0mqf5tB+RxE9OAiByRmXtLN4xavVPvLWFvTlSoTPkoewYIP+0S6OosgBcpShtrG9E7jwA3NowV6Q==
X-Received: by 2002:a05:620a:3720:b0:6fa:faad:2008 with SMTP id de32-20020a05620a372000b006fafaad2008mr44641719qkb.668.1669923018899;
        Thu, 01 Dec 2022 11:30:18 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id h19-20020ac85153000000b003a6328ee7acsm2977748qtn.87.2022.12.01.11.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:30:18 -0800 (PST)
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
Subject: [PATCH v2 2/3] mtd: spi-nor: Add additional octal-mode flags to be checked during SFDP
Date:   Thu,  1 Dec 2022 14:30:05 -0500
Message-Id: <20221201193007.261690-3-nathan.morrison@timesys.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221201193007.261690-1-nathan.morrison@timesys.com>
References: <20221201193007.261690-1-nathan.morrison@timesys.com>
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
 drivers/mtd/spi-nor/core.c | 7 +++++++
 drivers/mtd/spi-nor/core.h | 5 +++--
 drivers/mtd/spi-nor/sfdp.c | 8 ++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index bee8fc4c9f07..4c1a877e736f 100644
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

