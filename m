Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D235EB1F1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiIZURL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiIZURE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:17:04 -0400
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080C1A2236;
        Mon, 26 Sep 2022 13:17:03 -0700 (PDT)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1ocu8w-0001Yl-Il; Mon, 26 Sep 2022 21:51:54 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ata: allow enabling FUA support in Kconfig
Date:   Mon, 26 Sep 2022 21:51:43 +0200
Message-Id: <df8701f3905c1a394863e57c7a2d30c5b5dc3503.1664221825.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <ed1c179cff84b49e22cf229cc69751fa4d357d9a.1664221825.git.maciej.szmigiero@oracle.com>
References: <ed1c179cff84b49e22cf229cc69751fa4d357d9a.1664221825.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Currently, if one wants to make use of FUA support in libata it is
necessary to provide an explicit kernel command line parameter in order to
enable it (for drives that report such support).

In terms of Git archaeology: FUA support was enabled by default in early
libata versions but was disabled soon after.
Since then there were a few attempts to enable this support by default:
[1] (for NCQ drives only), [2] (for all drives).
However, the second change had to be reverted after a report came of
an incompatibility with the HDD in 2011 Mac Mini.

Enabling FUA avoids having to emulate it by issuing an extra drive cache
flush for every request that have this flag set.
Since FUA support is required by the ATA/ATAPI spec for any drive that
supports LBA48 and so these days should be pretty widespread let's provide
an ability to enable it by default in Kconfig.

[1]: https://lore.kernel.org/lkml/45CFFF82.4030301@shaw.ca/
[2]: https://lore.kernel.org/lkml/1336447443-4685-1-git-send-email-wenqing.lz@taobao.com/

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 drivers/ata/Kconfig       | 15 +++++++++++++++
 drivers/ata/libata-core.c |  5 +++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 36833a8629980..fd39bb22963a3 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -102,6 +102,21 @@ config SATA_PMP
 	  This option adds support for SATA Port Multipliers
 	  (the SATA version of an ethernet hub, or SAS expander).
 
+config ATA_FUA
+	bool "ATA FUA support"
+	help
+	  Enables Forced Unit Access (FUA) support by default for drives that
+	  have it.
+	  Otherwise the FUA flag has to be emulated by flushing the drive cache.
+
+	  Regardless of this option, you can enable or disable such support at
+	  kernel boot time by providing libata.fua=1 or libata.fua=0 kernel
+	  command line parameter.
+
+	  If building a kernel for yourself, say Y.
+	  If building a kernel for a distro that's supposed to run out of the
+	  box on old and broken hardware say N.
+
 if HAS_DMA
 
 comment "Controllers with non-SFF native interface"
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b322006c85806..941836c4b5eda 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -127,9 +127,10 @@ int atapi_passthru16 = 1;
 module_param(atapi_passthru16, int, 0444);
 MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI devices (0=off, 1=on [default])");
 
-int libata_fua = 0;
+int libata_fua = IS_ENABLED(CONFIG_ATA_FUA);
 module_param_named(fua, libata_fua, int, 0644);
-MODULE_PARM_DESC(fua, "FUA support (0=off [default], 1=on)");
+MODULE_PARM_DESC(fua,
+		 "FUA support (0=off, 1=on), default " __stringify(IS_ENABLED(CONFIG_ATA_FUA)));
 
 static int ata_ignore_hpa;
 module_param_named(ignore_hpa, ata_ignore_hpa, int, 0644);
