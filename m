Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1226D18F2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjCaHq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjCaHqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:46:22 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA751A97E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:46:19 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q14so22125553ljm.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680248778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7NTWdMiStTh7vkRgScnjQ7EbMR0iuczOZLyK0JYbPQ=;
        b=ZzrZyDZBZ1t0pXXxbwNRoDoE5Wox+GfU6DC9vGhIspumjRbyQ3pimGPHzXGWbzejig
         HgYXv4RV4Yn3HaMO/KrjknoYMNhnnIjQz86P6E5FvpjmobP1U0TZLNgVU6d/G8LsH7qF
         o6cuwxQ5NcCAvkElGJXIYh06JLKiGjcVEVHP1FbXnbz7VEXEe4yzU3rGXO5zI/3Bp35j
         zyM7+DhEV8aR+OhpnwkTyCzr3SWsRaAQ15+1EAZB0RvYIlr//XbxrySwzlqhixMtmXa+
         tQkc9a+kvzIu+xcSAVHc+KKfPDcXe+B1RzatxceQfGRtlPwBWoW7Kgaj8WlX/xesldVi
         IyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680248778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7NTWdMiStTh7vkRgScnjQ7EbMR0iuczOZLyK0JYbPQ=;
        b=6kCVIEN7dz9mjQKnW1RX5phKUKYnRIrZYnS6U0aHJVVo+a0+hfQyfoXcKwqNkUyqQc
         dHbpk7fl+e2c0tLg2ggkWa52ltVn7xS8LwvAVzIQOs/e47E9ohAAkH+McDa9gHcuzrSv
         JcLDblfh5q6of4wkdG0jAG4cYEhxHnYDrvsWNOmywyhGeYc/wW+lQr0teLLb/kKVaVOv
         vAp9WcawUwxQn+ItZGz38gPZo7HWs15Pxcg73JsQCJ/ZHhBoDcEtfQInDsqSOB/ccsPO
         aBg1SmNLhJL6A5knEqL+/1TTnqbByQMu//mp1K4d3G1lRaFF0YxlnddwMRcYxh70HU3Q
         OoXw==
X-Gm-Message-State: AAQBX9d76cCR1LVMBmsiRAGBBKbgN7puMoyDpDxnEZsqqc4GaWMfVjY6
        s8A5q4sV/dJOlNrIbKpq2iPwAQ==
X-Google-Smtp-Source: AKy350b7Rp9xYw4Le0T0/Q/T8sfqMkHE7nRnYiZQqUEzTRpsyzDyIr9arnAwVh1Txj4yztxzNHgtIA==
X-Received: by 2002:a2e:9d4d:0:b0:2a0:202c:93b3 with SMTP id y13-20020a2e9d4d000000b002a0202c93b3mr7078739ljj.49.1680248778304;
        Fri, 31 Mar 2023 00:46:18 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id n20-20020a2e8794000000b0029573844d03sm241201lji.109.2023.03.31.00.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 00:46:17 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v5 07/10] mtd: spi-nor: Stop exporting spi_nor_restore()
Date:   Fri, 31 Mar 2023 07:46:03 +0000
Message-Id: <20230331074606.3559258-8-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230331074606.3559258-1-tudor.ambarus@linaro.org>
References: <20230331074606.3559258-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 50297be98d1b..0517a61975e4 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3290,7 +3290,7 @@ static void spi_nor_put_device(struct mtd_info *mtd)
 	module_put(dev->driver->owner);
 }
 
-void spi_nor_restore(struct spi_nor *nor)
+static void spi_nor_restore(struct spi_nor *nor)
 {
 	int ret;
 
@@ -3310,7 +3310,6 @@ void spi_nor_restore(struct spi_nor *nor)
 	if (nor->flags & SNOR_F_SOFT_RESET)
 		spi_nor_soft_reset(nor);
 }
-EXPORT_SYMBOL_GPL(spi_nor_restore);
 
 static const struct flash_info *spi_nor_match_name(struct spi_nor *nor,
 						   const char *name)
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 82547b4b3708..cdcfe0fd2e7d 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -450,10 +450,4 @@ static inline struct device_node *spi_nor_get_flash_node(struct spi_nor *nor)
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
2.40.0.348.gf938b09366-goog

