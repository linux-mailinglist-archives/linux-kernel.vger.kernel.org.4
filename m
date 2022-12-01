Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A4A63F83F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiLATat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiLATab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:30:31 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD02C8D1A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:30:18 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id x28so1085764qtv.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 11:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFCBGy/PHSqulvVt1jN7WYpo1L/uAw3+z6frKWBhRoc=;
        b=pJfX+eHFT2vr3LfxVwv0ulFSIwHsF3KFI6OdOpmKL4VLyW1+SxJnJmblhVqrm7ZfmB
         Cb8X9ZFzETRxMZQvrtL62/1zxbAlmXa9vlfoM8/x6XT5QZEB38f1id47sOYyCnsgsdAM
         U7RoIdCSHrpowQMCu5Y88BNH+MGRYlm4MqBT2wFnPNmkkfZsOCEIfVQJl6T6VFUMMseO
         jQLvSV+BbjvNykJyhiy9FMl+QtGb5eKud/YaOjk2Q6hHEdKTxAKranqC445PppZUj04K
         9LfQzu57Pr/2/s45N8b2h4ojeMlScCqJ+FZ/Rlt22WWoq8z1mlrI7OKakgdzhcsqxQJs
         PuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFCBGy/PHSqulvVt1jN7WYpo1L/uAw3+z6frKWBhRoc=;
        b=KTgG/ZqBU+r2ix1IioO+CcXdLNcmripPeLZBXNR8LAV+i1yHt6AABJaX0SSAiC+lpA
         9rCx59omPOV+YLSOXfxVFS8rDQy5vvx+voEb5pbyiSlyA9sIlBzJ4vkCsgN6AwV6tsh2
         BUwd5WISTKKwxruLP79CH9Zx87QnjR6yTfOInsp3PO/Pn8PXQtLCaGCwggx8+Oo5YTb7
         bh1/40hpaPzKY0+G2MeEdxIrOZK2/DRD++XkewfZuEVpzJlZlpikVKTQh2QwymMjUJNo
         eJrRchUm8IJhUILhHgkHZXnk2AwCsbzKDl51cEIrQ6fO4+Gbq7YyrE7FS158bGEY/1IY
         I6CA==
X-Gm-Message-State: ANoB5pldQ936sEqo8Hde2KpacjFCABD5JCuBCzNkIWTc9d0OYx2piRXC
        7TmUM4PNW9AhD8dRr+0kiDDd4Q==
X-Google-Smtp-Source: AA0mqf7oOJj+mqSJLhu5GzlaWfWuN/sjSCuidJiPAU+TiPNDNySKnR0cHUv6efS6LIqcdmUngb98fw==
X-Received: by 2002:ac8:7497:0:b0:3a5:e592:37c8 with SMTP id v23-20020ac87497000000b003a5e59237c8mr61541174qtq.609.1669923017432;
        Thu, 01 Dec 2022 11:30:17 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id h19-20020ac85153000000b003a6328ee7acsm2977748qtn.87.2022.12.01.11.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:30:17 -0800 (PST)
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
Subject: [PATCH v2 1/3] mtd: spi-nor: Extend SFDP 4byte address instruction lookup table with new octal modes as per JEDEC JESD216F
Date:   Thu,  1 Dec 2022 14:30:04 -0500
Message-Id: <20221201193007.261690-2-nathan.morrison@timesys.com>
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

This adds the new bit fields for
reading: 1S-1S-8S, 1S-8S-8S, 1D-8D-8D
programming: 1S-1S-8S, 1S-8S-8S

Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
---
 drivers/mtd/spi-nor/sfdp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 2257f1b4c2e2..e4e87815ba94 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -953,11 +953,16 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 		{ SNOR_HWCAPS_READ_1_1_1_DTR,	BIT(13) },
 		{ SNOR_HWCAPS_READ_1_2_2_DTR,	BIT(14) },
 		{ SNOR_HWCAPS_READ_1_4_4_DTR,	BIT(15) },
+		{ SNOR_HWCAPS_READ_1_1_8,       BIT(20) },
+		{ SNOR_HWCAPS_READ_1_8_8,       BIT(21) },
+		{ SNOR_HWCAPS_READ_1_8_8_DTR,   BIT(22) },
 	};
 	static const struct sfdp_4bait programs[] = {
 		{ SNOR_HWCAPS_PP,		BIT(6) },
 		{ SNOR_HWCAPS_PP_1_1_4,		BIT(7) },
 		{ SNOR_HWCAPS_PP_1_4_4,		BIT(8) },
+		{ SNOR_HWCAPS_PP_1_1_8,         BIT(23) },
+		{ SNOR_HWCAPS_PP_1_8_8,         BIT(24) },
 	};
 	static const struct sfdp_4bait erases[SNOR_ERASE_TYPE_MAX] = {
 		{ 0u /* not used */,		BIT(9) },
-- 
2.30.2

