Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F416C4365
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjCVGlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCVGkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:40:46 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10055BC8A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:40:44 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id q16so11212936lfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679467243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJfZKigBIeChWOChUBeVAQfEZHFms3jVy0ZK/PQ531k=;
        b=GXOWONJwTRivIy6517fCgO6hyO0N3AxoYQNRie7uPM3oSvUEtTfErM2Ju2Q+JMhwrh
         02KdBggKf8GXBSQxTATLVlizdGXlaSxSk1nSP8Tk1dU0RQu0gDc5dlLb5Xud1wOVxLfm
         +05ecDO2Rhnr4cW/nwVFJcBZrtxcYO6gmrqcCHTIPM23CMFDE8QJ04GeT8A6TjZUW4fq
         vVnkmzNj5CwUGHY2SLY+QSAaudULkkR3Z0Nbm1VrNGgvRmj+wtfmUdW2AfeJ4Ci4Pr8c
         b216+98OAE3zfra/5eSupJyZ+f5v+4fR7Q1yHw7JoxAlzftJEEXq1By36uUSpgOHLBwg
         2/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679467243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJfZKigBIeChWOChUBeVAQfEZHFms3jVy0ZK/PQ531k=;
        b=M8iD/NhXxpkyo9esRnjrVB90p3Hgw+tw1o3vZOW/VpM1kVaB/W2rfqcvQ7es0hF+IU
         TjLGVdAfi2eppUr1ZotCyL+CQEwLLkGhKiFe910aaRquuC1ETzb46RVCSHWiHKuZKRx9
         ipipZscJMI1osz+R1qxbkUvcRLS536u/P2J1OCwpijzlzV9YXJu7gZ402OPrtST+gAOz
         d1Y/Mn0trR7+AXi11T4tikoKl92ytXIkeGHhoTGfEVFJOOCGwZ8Wn+MmsbrjZPK5eYCB
         Vu449R0hdKko1hcrfjxig6aPG9KLTmvtzbtqGMyzzyWtLxFTeqQJlOHg21ZY/tVokUg8
         7S1w==
X-Gm-Message-State: AO0yUKXiMgUVbBmNwXluXEB4j0XKwGR/e2apjNBXfjvZuv7+uI1Zw5dU
        Om5b6469KZK5t9pTFJPb1xdp9A==
X-Google-Smtp-Source: AKy350aU6oZfJKOyA5joErp2v+jd3KokKBm3ODOpDtqzLBKBfJpb9+F7caJ9EwuQ56pHTjQbER2k6Q==
X-Received: by 2002:ac2:428e:0:b0:4ea:c730:aac3 with SMTP id m14-20020ac2428e000000b004eac730aac3mr391733lfh.3.1679467243288;
        Tue, 21 Mar 2023 23:40:43 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id n20-20020ac242d4000000b004dafde0e7b7sm2462255lfl.279.2023.03.21.23.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 23:40:42 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 08/11] mtd: spi-nor: Stop exporting spi_nor_restore()
Date:   Wed, 22 Mar 2023 06:40:30 +0000
Message-Id: <20230322064033.2370483-9-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230322064033.2370483-1-tudor.ambarus@linaro.org>
References: <20230322064033.2370483-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SPI NOR controllers that used this method were moved to
drivers/spi/. We don't accept new support for the existing SPI NOR
controllers drivers under drivers/mtd/spi-nor/controllers/ and we
encourage their owners to move the drivers under drivers/spi/.
Make spi_nor_restore() private as we're going to use it just in core.c.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 Documentation/driver-api/mtd/spi-nor.rst | 3 ---
 drivers/mtd/spi-nor/core.c               | 3 +--
 include/linux/mtd/spi-nor.h              | 6 ------
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/Documentation/driver-api/mtd/spi-nor.rst b/Documentation/driver-api/mtd/spi-nor.rst
index 4a3adca417fd..c22f8c0f7950 100644
--- a/Documentation/driver-api/mtd/spi-nor.rst
+++ b/Documentation/driver-api/mtd/spi-nor.rst
@@ -63,6 +63,3 @@ The main API is spi_nor_scan(). Before you call the hook, a driver should
 initialize the necessary fields for spi_nor{}. Please see
 drivers/mtd/spi-nor/spi-nor.c for detail. Please also refer to spi-fsl-qspi.c
 when you want to write a new driver for a SPI NOR controller.
-Another API is spi_nor_restore(), this is used to restore the status of SPI
-flash chip such as addressing mode. Call it whenever detach the driver from
-device or reboot the system.
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 2a08f8de97fa..1cf566fed9c6 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2924,7 +2924,7 @@ static void spi_nor_put_device(struct mtd_info *mtd)
 	module_put(dev->driver->owner);
 }
 
-void spi_nor_restore(struct spi_nor *nor)
+static void spi_nor_restore(struct spi_nor *nor)
 {
 	int ret;
 
@@ -2944,7 +2944,6 @@ void spi_nor_restore(struct spi_nor *nor)
 	if (nor->flags & SNOR_F_SOFT_RESET)
 		spi_nor_soft_reset(nor);
 }
-EXPORT_SYMBOL_GPL(spi_nor_restore);
 
 static const struct flash_info *spi_nor_match_name(struct spi_nor *nor,
 						   const char *name)
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index a3f8cdca90c8..8aac4522bf2a 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -437,10 +437,4 @@ static inline struct device_node *spi_nor_get_flash_node(struct spi_nor *nor)
 int spi_nor_scan(struct spi_nor *nor, const char *name,
 		 const struct spi_nor_hwcaps *hwcaps);
 
-/**
- * spi_nor_restore_addr_mode() - restore the status of SPI NOR
- * @nor:	the spi_nor structure
- */
-void spi_nor_restore(struct spi_nor *nor);
-
 #endif
-- 
2.40.0.rc1.284.g88254d51c5-goog

