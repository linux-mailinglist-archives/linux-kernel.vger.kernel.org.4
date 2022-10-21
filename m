Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E98608012
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJUUqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiJUUpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:45:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B04A12E0F3;
        Fri, 21 Oct 2022 13:45:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E56D60D3F;
        Fri, 21 Oct 2022 20:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF1EC433D6;
        Fri, 21 Oct 2022 20:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666385030;
        bh=+Wm8MnCfMgvnGrZkq/NSP4dC8FF3aoE+uGAAN10YMp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f6vZ1lB04Q4TXb1CgW8wRsJ4HWkOrqhlckVmlf+mRNd/LcroMsYrFwPCHG1lmaUzO
         alsuvLolOa28fyoK6qHgIe+K73j1WCZEPyScREViZ3ckfr/xHK8OvhszHjRWbhxUTi
         2SLfVgp2omGRSJm3EKjmwzCT2o5KAVMLKnSBQROO7XoA/ZnIgWwtkCZ1IA7lmyhtCS
         NbTvyksRyesuyfpqrQStweLjs8wuhjOJRIuUilO1CHUZaCXPJZYbonrg3dlJg6EWyL
         Z1peDjawp56ux1LP0A6fzreFmY75Ypd7LRBbcN+f+jzEAXam7zeXUBdI1sqtkUkgNL
         K6sMpHKQovFqw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org
Subject: [PATCH 09/21] pata: remove samsung_cf driver
Date:   Fri, 21 Oct 2022 22:27:42 +0200
Message-Id: <20221021203329.4143397-9-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221021202254.4142411-1-arnd@kernel.org>
References: <20221021202254.4142411-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This device was only used by the smdk6410 board file that is now
gone, so the driver can be removed as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ata/Kconfig                          |  10 -
 drivers/ata/Makefile                         |   1 -
 drivers/ata/pata_samsung_cf.c                | 662 -------------------
 include/linux/platform_data/ata-samsung_cf.h |  31 -
 4 files changed, 704 deletions(-)
 delete mode 100644 drivers/ata/pata_samsung_cf.c
 delete mode 100644 include/linux/platform_data/ata-samsung_cf.h

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 6b446cfc3455..3b8cb7a29efd 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1136,16 +1136,6 @@ config PATA_RZ1000
 
 	  If unsure, say N.
 
-config PATA_SAMSUNG_CF
-	tristate "Samsung SoC PATA support"
-	depends on SAMSUNG_DEV_IDE || COMPILE_TEST
-	select PATA_TIMINGS
-	help
-	  This option enables basic support for Samsung's S3C/S5P board
-	  PATA controllers via the new ATA layer
-
-	  If unsure, say N.
-
 config PATA_WINBOND_VLB
 	tristate "Winbond W83759A VLB PATA support (Experimental)"
 	depends on ISA
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 2cca9f500649..4ee5c0761d90 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -109,7 +109,6 @@ obj-$(CONFIG_PATA_PLATFORM)	+= pata_platform.o
 obj-$(CONFIG_PATA_OF_PLATFORM)	+= pata_of_platform.o
 obj-$(CONFIG_PATA_RB532)	+= pata_rb532_cf.o
 obj-$(CONFIG_PATA_RZ1000)	+= pata_rz1000.o
-obj-$(CONFIG_PATA_SAMSUNG_CF)	+= pata_samsung_cf.o
 
 obj-$(CONFIG_PATA_PXA)		+= pata_pxa.o
 
diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
deleted file mode 100644
index aba1536ddd44..000000000000
diff --git a/include/linux/platform_data/ata-samsung_cf.h b/include/linux/platform_data/ata-samsung_cf.h
deleted file mode 100644
index fccf969dc4da..000000000000
-- 
2.29.2

