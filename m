Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B93363F9CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiLAV2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiLAV16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:27:58 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A061DDCB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:27:55 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id jr1so2661602qtb.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 13:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFCBGy/PHSqulvVt1jN7WYpo1L/uAw3+z6frKWBhRoc=;
        b=3CXh/w9VqvcrpteYx9ZB6drtCGMaYRyRN3VkzHIHJUjgctE/YIBhqFIb1Q8LDz2obG
         03sUPuMoq04AewWPt24FcyfTfGVob9U1O5iUUfZXHA+VJQ76jR3N2w7aERMHjFA3PMw3
         bwA5ZBI30wBg4Vvgz3HKRXFYqWdXRnK/17ml4D7Oa344Tvlrd73XcEaLHszpAOkw4KWJ
         waTX2CZoNpddDf02/2M4qEcqBrCFxf6a0YiQcq1ZXuRcSqRAQqkyW66jyw3NgqdprRi5
         nQ+dGC9UwbsUp0bnoliqhRM7jD5JzprvH4CIN8ixgoiw6sArPUNONhgXPNAgXhSSbQtk
         lpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFCBGy/PHSqulvVt1jN7WYpo1L/uAw3+z6frKWBhRoc=;
        b=5FYcy5vQcQ7P6ZrV55M/3OZjTS5CcSObDRBkoazGNoQHX2lwYIuYohVtL1TaXff/xt
         2di7vHCKBpIaXbzSa5ks/1wueFe5hUEAnegAiBOAAR+X62mRzj/VlPhKrbPn9Pwt9t9S
         z5KKUJubzU4w7L/I6rEfzMhGMWhrIDsMcOfKk6pY6HhTcPd3+PCTqt2HQnpLquTGQDPr
         m3jbutS2HlCKhglxP9prDOa90qOqvrb7tmSxV02dd0ihN0o29w6snm558xba0A+BrVpn
         Ad4md+8NwAuoCLEOuL5suKANLxmi6yEePZftHeIxNP0Ojo5VmcpH5iajfYMGIKnVAS+g
         GWBw==
X-Gm-Message-State: ANoB5pnFEJpKl1RA8NU7ap142vFoxO+ScR9qmK7meH5bEXTzG9+8ukqw
        ofJfAzKHMMjyr/OipD5A6sikrQ==
X-Google-Smtp-Source: AA0mqf6szy4I7PVwPg1bZSQuN0IPneSUTPM6WK5Q36vfQp5jcMHNA+3GVZJuPY4CohsqFf7kF3h+Pg==
X-Received: by 2002:a37:6d7:0:b0:6fc:a68a:64b8 with SMTP id 206-20020a3706d7000000b006fca68a64b8mr3852069qkg.341.1669930074446;
        Thu, 01 Dec 2022 13:27:54 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id l15-20020a37f90f000000b006fc447eebe5sm4071321qkj.27.2022.12.01.13.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 13:27:54 -0800 (PST)
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
Subject: [PATCH v3 1/3] mtd: spi-nor: Extend SFDP 4byte address instruction lookup table with new octal modes as per JEDEC JESD216F
Date:   Thu,  1 Dec 2022 16:27:48 -0500
Message-Id: <20221201212750.267721-2-nathan.morrison@timesys.com>
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

