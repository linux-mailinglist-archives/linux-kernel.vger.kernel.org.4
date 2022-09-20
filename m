Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00DD5BECFD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiITSsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiITSsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:48:12 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB2F72FFE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:48:11 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id e18so2735520wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=e1rax8zHktkJE4NlsAmrfBmfy6JQLwKUdVTmbuE0Kvk=;
        b=hF571VujJCMDxHcL33xXykpja1h21tI7IF5yEPnBBYncPApGh+8n57VgyUlTu+m3yX
         wns7sSyA3Oug+os9C3c7qMqW79l4cj5reKYE2Ouc/wFN8PAQQcjeJZB2zME9NyX4GMY+
         TnUNugxpJMyKaX08YJLgZrChhBULnCHcIu9v6OSOffTu7aGJndgpEi8Z0xAU6ZDPHqlV
         JLlu2ajyA1yroEGrX1aIdMInErCeqvTSxr44265WFwqp0tN2HRpsl04/yFuQQA1jMJLT
         VFyej89biFNpTlhvnGzlJx0so2Rb3j1fGr+vyBD4YpjgYpPde+fVVxbcsnacpADRRE2M
         LJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=e1rax8zHktkJE4NlsAmrfBmfy6JQLwKUdVTmbuE0Kvk=;
        b=eCmDf7DYxBYKe2Iaki9536ovmZu60hYrsz0nPaxW6KEtbjx3a1TxLcvgZjavaPf3cn
         Nipkn4BFsJ8qNUgDY+kIY+bRiV3k4MavO/HYhI2o116TqiGpL/AnEspNG/2DBV9y+hq4
         5N8j/BuDIxjJjmQCkau6KNPfkhdg1F1hoTgc+4lLBkauYnPigLoHMUmC+xbjg2O4YnsG
         O4f4yZpU4EKnD2ENGlMOzSBpjjI64YzPLGqCird1iiybCrL8/1Y4CErL/7p29c0iUbh5
         HkYvIiajexLHiZfnBD1lNVyKeNPw+k1xXi33be8u4oHRbvD/nMxUpdnemNUBjhKzzFJv
         VSmw==
X-Gm-Message-State: ACrzQf0mavOqMEK/GyJAiQrUS2ivXZpyqs70Cafn6j8hnTYUrdK8qRtL
        VQqTKKPjCIui/+h4yB4s7TssMg==
X-Google-Smtp-Source: AMsMyM4Tw/NhBtw2kzdJcNMS4tkb4L/Hz8kHuIiUNdJMWTGNUCY8P/Fe189L7qnKquwt04na0P0VEw==
X-Received: by 2002:a05:600c:1f15:b0:3b4:8600:fd7e with SMTP id bd21-20020a05600c1f1500b003b48600fd7emr3570480wmb.40.1663699689952;
        Tue, 20 Sep 2022 11:48:09 -0700 (PDT)
Received: from localhost.localdomain (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id l16-20020a7bc350000000b003b4c40378casm469974wmj.39.2022.09.20.11.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 11:48:09 -0700 (PDT)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH v3 1/2] mtd: spi-nor: issi: is25wp256: Init flash based on SFDP
Date:   Tue, 20 Sep 2022 19:48:07 +0100
Message-Id: <20220920184808.44876-1-sudip.mukherjee@sifive.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The datasheet of is25wp256 says it supports SFDP. Get rid of the static
initialization of the flash parameters and init them when parsing SFDP.

Testing showed the flash using SPINOR_OP_READ_1_1_4_4B 0x6c,
SPINOR_OP_PP_4B 0x12 and SPINOR_OP_BE_4K_4B 0x21 before enabling SFDP.
After this patch, it parses the SFDP information and still uses the
same opcodes.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---

No change from v2, just resending again with the next patch.
Results from the tests given by Tudor in the following mail.


 drivers/mtd/spi-nor/issi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 89a66a19d754f..8b48459b5054c 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -71,7 +71,7 @@ static const struct flash_info issi_nor_parts[] = {
 	{ "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 512)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
+		PARSE_SFDP
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
 		.fixups = &is25lp256_fixups },
 
-- 
2.30.2

