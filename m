Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7992F74FA86
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjGKWDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGKWC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:02:58 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31226170C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:02:57 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so9445104e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689112975; x=1691704975;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F0Z+tdeHGTaKzHcow1KpcWdGeQHImw6XYl8ad7qpvIU=;
        b=opoXvky99JLSERxqHP3e7AadJFBDskor1nn3ZdGiII4s5uVUMvgpRKU11dEzEghN/z
         qZDr31SmizAnRmueXaV4Fxasr4IaOihv27cwnrOkpneFtyPX9KuMwVk7dba9GGKMNQ/U
         Brw8S/N5o5pjr/XIE8yJw7Q+IvizmICzRvc+Sf1GoxHbFu0Dn4raiPX9RAHuVugZh5xN
         rshTpQzb4teh6teJTSa9QQ6+RMmj9zWIwMO7f3xVX5coudjLosmIZtqBPRbAXbsbS2KD
         K32HQtein9aaNpVh/0GhTCzZF3d113GHWiprgpyLVE6mBKQZ2kx4wVM3ge1Sj8NA673P
         90Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689112975; x=1691704975;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F0Z+tdeHGTaKzHcow1KpcWdGeQHImw6XYl8ad7qpvIU=;
        b=hKTMX8isPoCsZAG5QS1ceCKS85AKFidKuvJr0oqhPkmpzP0NdwmrWJZjHTR052/YsS
         noory0quIhaDl19XVPkXsm7ckckrI45H+suYXgyAiQj7X25Y/Wu3YhsAQ4372z+l/MrN
         zw/Xd17SHPNVTqVbRrKzWEZWB4W2hG3ucv1J7R9XTv1CIMOwgYiZeQiZGeBXWBu/FhQv
         NK5fYiZFpaBTOnIkic5SOh8tSSQzAmkjwZUgIPTUXrHutX+7WHIeQU7X/GBA0MIZj0ob
         S84P3WnYRcWbGDyoXgw+pLXGKDxjQ4V3EoECXacQF1alRgUjeQ6AidGOhhHDwehJC+AU
         9aww==
X-Gm-Message-State: ABy/qLaWTMR+HKfz9QLQ0AR6Hss/7G6dltK55BEVUR6IX+FqtvPjfeiP
        6kj7sk2A54ruoVRuZ5rZkdqHNQ==
X-Google-Smtp-Source: APBJJlGq6zZ3FxteufYERYIQNUpUpceO0dRrygOsbwoKYU5z9QAe2GSlieM91r14nBVCFfBPk6+tRw==
X-Received: by 2002:ac2:4c4b:0:b0:4f8:72fd:ed95 with SMTP id o11-20020ac24c4b000000b004f872fded95mr16316159lfk.22.1689112975359;
        Tue, 11 Jul 2023 15:02:55 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id o1-20020ac24341000000b004eff1163c37sm455369lfl.308.2023.07.11.15.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 15:02:54 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jul 2023 00:02:53 +0200
Subject: [PATCH] mtd: spi-nor: Correct flags for Winbond w25q128
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230712-spi-nor-winbond-w25q128-v1-1-f78f3bb42a1c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIzRrWQC/x3MOQqAQAxA0atIagOTiAteRSxcoqbJ6AyoIN7dw
 fIV/z8QJahEaLMHgpwa1VsC5RlM22CroM7JwI4LVxNh3BXNB7zURm8zXlwexA0WTEPlWISrGlK
 9B1n0/s9d/74f6ioqOWkAAAA=
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Winbond W25Q128 (actual vendor name W25Q128JV)
has exactly the same flags as the sibling device
w25q128fw. The devices both require unlocking and
support dual and quad SPI transport.

The actual product naming between devices:

0xef4018: "w25q128"   W25Q128JV-IM/JM
0xef7018: "w25q128fw" W25Q128JV-IN/IQ/JQ

The latter device, "w25q128fw" supports features
named DTQ and QPI, otherwise it is the same.

Not having the right flags has the annoying side
effect that write access does not work.

After this patch I can write to the flash on the
Inteno XG6846 router.

Cc: stable@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/spi-nor/winbond.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 834d6ba5ce70..a67e1d4206f3 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -121,7 +121,9 @@ static const struct flash_info winbond_nor_parts[] = {
 	{ "w25q80bl", INFO(0xef4014, 0, 64 * 1024,  16)
 		NO_SFDP_FLAGS(SECT_4K) },
 	{ "w25q128", INFO(0xef4018, 0, 64 * 1024, 256)
-		NO_SFDP_FLAGS(SECT_4K) },
+		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
+			      SPI_NOR_QUAD_READ) },
 	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		.fixups = &w25q256_fixups },

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230711-spi-nor-winbond-w25q128-321a602ee267

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

