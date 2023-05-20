Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202DE70AB97
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 00:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjETWkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 18:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjETWks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 18:40:48 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259D8B1;
        Sat, 20 May 2023 15:40:46 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96f53c06babso478439066b.3;
        Sat, 20 May 2023 15:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684622444; x=1687214444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=89JgfI+k7tA4qY1CeB5U1E+kQ+fqj2SuI+jIiC7quro=;
        b=BIzkJh+mRNjK8zJuo8DIcqjha8uRsGXIaQe8h0vGxN8+wdO8nOn5Mivum/yVPOAXo1
         aJ+anLZor3qQiCg08Ez3taiP39oHAEncOW0gNwUw76LX++0ZDnlxFMPY0NVl2TTDnVwy
         pd2CgAH4MmELv/9lJwBGlBGYWOakxf089BS+ATLeAJMMYv1vVWVNlvH31ZqkdJ6UJk/o
         qZnZZFO/7LGQrpOHtgzM2WNv+vzk8fOIXNQGKnd7Cl6YMX7hdA6pko/sf65weffVrW8S
         cURK7aJ+06vIEX8bAdUnTP24bP3SI70SSH5ornE83SUtz9mOoW+nCht6fX9lVxZNNqng
         lngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684622444; x=1687214444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89JgfI+k7tA4qY1CeB5U1E+kQ+fqj2SuI+jIiC7quro=;
        b=ez/DVPcpGI+mzr3RnxViB31BRVKLFAPMqhVHkZAtvcsVXDJHoUkBx2oVAGK9GDnTgy
         NoWa+4ZC86LfxPbLrz792kZkHf0scqfY2O31kmRyGqJvF+l961JD8p0pAUbSW16TDcIJ
         eyMqbP1809kyuVEeXZb58FRyZKZnWmdviO2uxpwfz86P+y+jzYloiI24N4inbo9vrH2T
         l4/PVLVo9+MGCucH8eeph9JC8Pl4WeNP8mHIhOi/Hrpo/QpL8Ff9X86WEp16RfGoJxfI
         K3r2k8OiFhIKaEvkj+G4lK0RS+0zMsC+v2qB/9m2CbO68FtocD4iILQfr6LxKezBb3pu
         2C3Q==
X-Gm-Message-State: AC+VfDzRgypf9ZWKTf8CqA7dtifrNHDGK3cBws4JI/zATxYQGMCM5KC3
        kisZm2JMbY2VEKtnnl96NKESb4+yIDI=
X-Google-Smtp-Source: ACHHUZ71CbqkU/pZS0bAQ6iDO42aD393vG3s6ag3i6gwk6y6BqaPOa3bMarACn4o/P4ztvKwkMO99w==
X-Received: by 2002:a17:907:6094:b0:96f:af50:9884 with SMTP id ht20-20020a170907609400b0096faf509884mr1833823ejc.11.1684622444304;
        Sat, 20 May 2023 15:40:44 -0700 (PDT)
Received: from Osmten.. ([103.84.150.74])
        by smtp.gmail.com with ESMTPSA id lh24-20020a170906f8d800b00969f44bbef3sm1266592ejb.11.2023.05.20.15.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 15:40:43 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     fancer.lancer@gmail.com, broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH v1] spi-dw-core.c: Fix error checking for debugfs_create_dir
Date:   Sun, 21 May 2023 03:40:25 +0500
Message-Id: <20230520224025.14928-1-osmtendev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the error checking in spi-dw-core.c in
debugfs_create_dir. The DebugFS kernel API is developed in
a way that the caller can safely ignore the errors that
occur during the creation of DebugFS nodes.

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 drivers/spi/spi-dw-core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index ae3108c70f50..c21152a40391 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -57,21 +57,18 @@ static const struct debugfs_reg32 dw_spi_dbgfs_regs[] = {
 	DW_SPI_DBGFS_REG("RX_SAMPLE_DLY", DW_SPI_RX_SAMPLE_DLY),
 };
 
-static int dw_spi_debugfs_init(struct dw_spi *dws)
+static void dw_spi_debugfs_init(struct dw_spi *dws)
 {
 	char name[32];
 
 	snprintf(name, 32, "dw_spi%d", dws->master->bus_num);
 	dws->debugfs = debugfs_create_dir(name, NULL);
-	if (!dws->debugfs)
-		return -ENOMEM;
 
 	dws->regset.regs = dw_spi_dbgfs_regs;
 	dws->regset.nregs = ARRAY_SIZE(dw_spi_dbgfs_regs);
 	dws->regset.base = dws->regs;
 	debugfs_create_regset32("registers", 0400, dws->debugfs, &dws->regset);
 
-	return 0;
 }
 
 static void dw_spi_debugfs_remove(struct dw_spi *dws)
@@ -80,9 +77,8 @@ static void dw_spi_debugfs_remove(struct dw_spi *dws)
 }
 
 #else
-static inline int dw_spi_debugfs_init(struct dw_spi *dws)
+static inline void dw_spi_debugfs_init(struct dw_spi *dws)
 {
-	return 0;
 }
 
 static inline void dw_spi_debugfs_remove(struct dw_spi *dws)
-- 
2.34.1

