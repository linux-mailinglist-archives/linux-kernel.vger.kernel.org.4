Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DC565EDBB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjAENr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjAENrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:47:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA583F13B;
        Thu,  5 Jan 2023 05:47:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A455B81AD7;
        Thu,  5 Jan 2023 13:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15C1C433F0;
        Thu,  5 Jan 2023 13:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926424;
        bh=Yiulr7Sl0+EFOJK9Ppots4MUfhCrrD1tUceLFrFQBAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Au29traIASfq9dNyl8+ZbpOYCSGvTUHA36hQmRXoeSdhcuZNHgxROKVUPJcimuE1n
         wTEbQgbBcTh9IKa30BBGzEEizNTCmerQLas4A01ekpZ58esEAO/+Rde/Vg27XOVo9b
         bZNnVdGZ93ajq5l4ODUBGX0WnM68txXrJsYBDAwyEidQ9mf8CIKrOVXYFYQWaPEn+O
         SZjSn6y6w3oUdaUw+CnGpaDlHsnD5C4XYBSugOjNdoXwB2Q3c/7/PEbf9fq/02yvJT
         D7aT/kVmyHHz6NK7VOyLFzbHEYox6ou3pPktli0m8tKNR2Nmx/a9L3hF3PeLfot47M
         iz0s6LCgloHbQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Marek Vasut <marek.vasut@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
Subject: [PATCH 08/27] ata: remove palmld pata driver
Date:   Thu,  5 Jan 2023 14:46:03 +0100
Message-Id: <20230105134622.254560-9-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105134622.254560-1-arnd@kernel.org>
References: <20230105134622.254560-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The PXA palmld machine was removed, so the pata driver is no
longer used and can be removed. There is a chance that some of
this code might be useful for turning some of the other PXA
PCMCIA host drivers into PATA drivers, but it's clear that
it would not work unmodified, and it seems unlikely that
someone would do this work.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ata/Kconfig       |   9 ---
 drivers/ata/Makefile      |   1 -
 drivers/ata/pata_palmld.c | 137 --------------------------------------
 3 files changed, 147 deletions(-)
 delete mode 100644 drivers/ata/pata_palmld.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index e4d9e39b08dd..4aafb75bf0c3 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1082,15 +1082,6 @@ config PATA_OPTI
 
 	  If unsure, say N.
 
-config PATA_PALMLD
-	tristate "Palm LifeDrive PATA support"
-	depends on MACH_PALMLD
-	help
-	  This option enables support for Palm LifeDrive's internal ATA
-	  port via the new ATA layer.
-
-	  If unsure, say N.
-
 config PATA_PCMCIA
 	tristate "PCMCIA PATA support"
 	depends on PCMCIA
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 0a863e7f3c60..4ee5c0761d90 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -105,7 +105,6 @@ obj-$(CONFIG_PATA_MPIIX)	+= pata_mpiix.o
 obj-$(CONFIG_PATA_NS87410)	+= pata_ns87410.o
 obj-$(CONFIG_PATA_OPTI)		+= pata_opti.o
 obj-$(CONFIG_PATA_PCMCIA)	+= pata_pcmcia.o
-obj-$(CONFIG_PATA_PALMLD)	+= pata_palmld.o
 obj-$(CONFIG_PATA_PLATFORM)	+= pata_platform.o
 obj-$(CONFIG_PATA_OF_PLATFORM)	+= pata_of_platform.o
 obj-$(CONFIG_PATA_RB532)	+= pata_rb532_cf.o
diff --git a/drivers/ata/pata_palmld.c b/drivers/ata/pata_palmld.c
deleted file mode 100644
index 51caa2a427dd..000000000000
-- 
2.39.0

