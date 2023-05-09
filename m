Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A4C6FCE81
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 21:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbjEITZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 15:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbjEITZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 15:25:16 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8632144B8
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 12:25:13 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4eed764a10cso6969823e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 12:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683660312; x=1686252312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlwZPVonowD5NeZWZeFy+H47+NTAgbeMkTo9feXnAlA=;
        b=BeJ6GqSc+RR7/1+vIkNUxCKSvDA5qG/OOWU+oO0mA9KWIAKSf1PtpxlJqnx3oDUyM9
         3RtjJiGcGxKFmJwhVRTveo7C9HnxnGTB29nElCbmE/HHm9j4Le6x4i7k5+8UfmLZj+8y
         GxowMC5zK8e6+21tu4nAgdfOYoCgOv3HPsVeo1c348se7xwNhOldLSgzoQk+SOD2W5xI
         zcqq3DFdYIe6FJvP/flh0JxFECGt4XP4b0bPj6IDYeMdCZzhUfGkRFQjWWCs57aO0Ci+
         0G5/djvNkUr9zlua9KJsCcK0YCwvS+z1UP7NrTBfLqT4o3UmDXiXVFukOjcdhFJ/07hv
         3deA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683660312; x=1686252312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlwZPVonowD5NeZWZeFy+H47+NTAgbeMkTo9feXnAlA=;
        b=MnqGtNuBwk4RPQbQ7c+Q/8LEfSmbCh259RmU7k3OxW3g8HzBZBEhm95dkHLUnBO7Yn
         HHVRuP8hHG7S1DAKOe9L6djwc8+tnYeJdVWiuJEFk982iLaLQepcngldG5GplOJUS5i7
         27FjONyAkhv2yI8n217p8BRRRwWwFOOFHeGR2shPGe2jKx9We9nSHy+A1AdsYWjJzoRn
         MlYwIC3miT5+Up6dah+zon/zuvtm9ScGLh/TMgV0ZitIk5gYTYG6VQXGOxkcwA55k124
         Ce7Yqmd0yJlfJDLlzTqr7M0tn7MRlc//diOOljqTGYtOezl7zl+zSvygcC1+wOin5lvs
         XHkw==
X-Gm-Message-State: AC+VfDxHYHdpylnpviN9TgTMYNO7h5PvTLRSB4gd7PWx26bK+5Clyzzo
        BpbtLxieiq2owj6HHj8ENga2Tw==
X-Google-Smtp-Source: ACHHUZ58dNpXVZ92PrAPLjAFX/l2ED0ejCnjnHgMc/JB8cptPNseKKGnosXD5GwiHBh4VsnDvj8J+Q==
X-Received: by 2002:a05:6512:11c2:b0:4e8:3dc1:70f4 with SMTP id h2-20020a05651211c200b004e83dc170f4mr948054lfr.34.1683660311711;
        Tue, 09 May 2023 12:25:11 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id 19-20020a05651c009300b002a6007383a0sm1681131ljq.135.2023.05.09.12.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 12:25:11 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     miquel.raynal@bootlin.com
Cc:     pratyush@kernel.org, michael@walle.cc, richard@nod.at,
        vigneshr@ti.com, Takahiro.Kuwano@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 1/2] mtd: spi-nor: spansion: make sure local struct does not contain garbage
Date:   Tue,  9 May 2023 19:25:05 +0000
Message-ID: <20230509192506.947094-1-tudor.ambarus@linaro.org>
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

Following error was seen with um-x86_64-gcc12/um-allyesconfig:
+ /kisskb/src/drivers/mtd/spi-nor/spansion.c: error: 'op' is used uninitialized [-Werror=uninitialized]:  => 495:27, 364:27

Initialise local struct spi_mem_op with all zeros at declaration in
order to avoid using garbage data for fields that are not explicitly
set afterwards.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: c87c9b11c53ce ("mtd: spi-nor: spansion: Determine current address mode")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/spansion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 15f9a80c10b9..d44ffaac1dba 100644
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
 
-- 
2.40.1.521.gf1e218fcd8-goog

