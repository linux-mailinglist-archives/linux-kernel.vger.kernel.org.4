Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE726FCEA8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 21:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjEITjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 15:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbjEITjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 15:39:08 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDCF4EC7
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 12:39:06 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f13d8f74abso7128279e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 12:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683661145; x=1686253145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjRYRiygujOMdMi47FokaOkwwmbe8xeOyySyfPzkKoQ=;
        b=K5uDrOlg7wxrIEEUXL4IqqMSaHYVxpFE5MzreB7nMcV6sNxaWyJ1UWS6WaKfQ4xy30
         pzO3w4CtkAUdImbT56U6IMXRqrp++x6pYKFf8c5MybpthgYVA7pLlrCCCdFyXncftFQm
         YXdxgd1+VRvMyKGPOi1qGFaYRXAtJrLCsuBj4iAxzlFKrljjDLFwuJSbxZFaI4pZ6M0Z
         q5RDclDFdMotV66m+REhh5HoLOS7XHgk4321f2W4QuEwzaI9NfjLxqXu0VpgYUQGnjVV
         8DBGEiUc9zDM1rQXJTIrQ0rd4MQffMpNsko32I2jYDaTRiq31NeWjgWQtsfntYtPjPwW
         24EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683661145; x=1686253145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjRYRiygujOMdMi47FokaOkwwmbe8xeOyySyfPzkKoQ=;
        b=IuBkhlocHvKylrlBjD9MO2g6+3lkiABingBTi83qCdxPkoAyK9iUFNmUqMTcKmk74H
         PnWH7ZMQB1vflWRSbUwiwTSQnpoP5B7mUSMP2h5wCHoF8Gfu1PmmC9GrRx2GmDz9ws0u
         zibVTV90QryUCZi5jOB/Dh+R93yAVIKTLLQTecVIH7R5wNR3f/wxNGdZDpMgzBQWK8kp
         Vp8caJFd2ImlnagvAoItN7LogJe8jxDdNbY3t8koOr9Nnmt7QyhggN8FmHdQoZyk5hIt
         OJTHjIp2Jh//AGa9rM/S704cnD5AYkoc3+LaJF2wvf/eBmT0UqEIxsiN0xoG6CPmc/Kk
         VIGA==
X-Gm-Message-State: AC+VfDwsVtmx90Kfa8LjH8j8QYG/5soRdp7FBGBaX4W80jHQ7sTgDOZ4
        xc/tz9LU0HHrV8yqFsKg00mrUw==
X-Google-Smtp-Source: ACHHUZ5Lvym173rLLRPpv6EOhKVBpcCF7Lyy6agBSy8BhlZ89X4wwH0J2i0lMBJI0BDe090uWrX9kg==
X-Received: by 2002:ac2:546b:0:b0:4ed:b329:5d85 with SMTP id e11-20020ac2546b000000b004edb3295d85mr972332lfn.15.1683661145049;
        Tue, 09 May 2023 12:39:05 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id g12-20020a19ee0c000000b004eb42f5367bsm453943lfb.19.2023.05.09.12.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 12:39:04 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     miquel.raynal@bootlin.com
Cc:     pratyush@kernel.org, michael@walle.cc, richard@nod.at,
        vigneshr@ti.com, Takahiro.Kuwano@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2] mtd: spi-nor: spansion: make sure local struct does not contain garbage
Date:   Tue,  9 May 2023 19:39:00 +0000
Message-ID: <20230509193900.948753-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <749c2fc2-93dc-585-3826-dea581602d6e@linux-m68k.org>
References: <749c2fc2-93dc-585-3826-dea581602d6e@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following errors were seen with um-x86_64-gcc12/um-allyesconfig:
+ /kisskb/src/drivers/mtd/spi-nor/spansion.c: error: 'op' is used uninitialized [-Werror=uninitialized]:  => 495:27, 364:27

Initialise local struct spi_mem_op with all zeros at declaration in
order to avoid using garbage data for fields that are not explicitly
set afterwards.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: c87c9b11c53ce ("mtd: spi-nor: spansion: Determine current address mode")
Fixes: 6afcc84080c41 ("mtd: spi-nor: spansion: Add support for Infineon S25FS256T")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
v2:
- init both local vars with all zeros at declaration
- squash patches as the blamed commits were just introduced in this
  merge window.

 drivers/mtd/spi-nor/spansion.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 15f9a80c10b9..36876aa849ed 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -361,7 +361,7 @@ static int cypress_nor_determine_addr_mode_by_sr1(struct spi_nor *nor,
  */
 static int cypress_nor_set_addr_mode_nbytes(struct spi_nor *nor)
 {
-	struct spi_mem_op op;
+	struct spi_mem_op op = {};
 	u8 addr_mode;
 	int ret;
 
@@ -492,7 +492,7 @@ s25fs256t_post_bfpt_fixup(struct spi_nor *nor,
 			  const struct sfdp_parameter_header *bfpt_header,
 			  const struct sfdp_bfpt *bfpt)
 {
-	struct spi_mem_op op;
+	struct spi_mem_op op = {};
 	int ret;
 
 	ret = cypress_nor_set_addr_mode_nbytes(nor);
-- 
2.40.1.521.gf1e218fcd8-goog

