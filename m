Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9B4677164
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 19:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjAVSOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 13:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjAVSOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 13:14:23 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D6C110250;
        Sun, 22 Jan 2023 10:14:22 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 310517A033B;
        Sun, 22 Jan 2023 19:14:21 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] paride: Mark PARIDE as deprecated, point to PATA_PARPORT
Date:   Sun, 22 Jan 2023 19:14:15 +0100
Message-Id: <20230122181415.21031-1-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230122075710.GA4046@lst.de>
References: <20230122075710.GA4046@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Kconfig and runtime deprecation warnings to PARIDE, pointing users
to PATA_PARPORT.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/block/Kconfig         | 4 +++-
 drivers/block/paride/paride.c | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index a2184b428493..3a2065c6a4d7 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -104,7 +104,7 @@ config GDROM
 	  You can also build this as a module which will be called gdrom.
 
 config PARIDE
-	tristate "Parallel port IDE device support"
+	tristate "Parallel port IDE device support (DEPRECATED)"
 	depends on PARPORT_PC
 	help
 	  There are many external CD-ROM and disk devices that connect through
@@ -130,6 +130,8 @@ config PARIDE
 	  "MicroSolutions backpack protocol", "DataStor Commuter protocol"
 	  etc.).
 
+	  This driver is deprecated, replaced by libata-based PATA_PARPORT.
+
 source "drivers/block/paride/Kconfig"
 
 source "drivers/block/mtip32xx/Kconfig"
diff --git a/drivers/block/paride/paride.c b/drivers/block/paride/paride.c
index 0e287993b778..010daf605728 100644
--- a/drivers/block/paride/paride.c
+++ b/drivers/block/paride/paride.c
@@ -452,6 +452,8 @@ void *pi_register_driver(char *name)
 	struct parport_driver *parp_drv;
 	int ret;
 
+	printk(KERN_WARNING "PARIDE is deprecated. Use PATA_PARPORT instead.\n");
+
 	parp_drv = kzalloc(sizeof(*parp_drv), GFP_KERNEL);
 	if (!parp_drv)
 		return NULL;
-- 
Ondrej Zary

