Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B395EB1EF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiIZURG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiIZURD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:17:03 -0400
X-Greylist: delayed 1507 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Sep 2022 13:17:00 PDT
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC9DA285B;
        Mon, 26 Sep 2022 13:17:00 -0700 (PDT)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1ocu8r-0001Yg-4N; Mon, 26 Sep 2022 21:51:49 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ata: allow toggling fua parameter at runtime
Date:   Mon, 26 Sep 2022 21:51:42 +0200
Message-Id: <ed1c179cff84b49e22cf229cc69751fa4d357d9a.1664221825.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.37.3
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

Currently, the libata.fua parameter isn't runtime-writable, so a
system restart is required in order to toggle it.
This unnecessarily complicates testing how drives behave with FUA on and
off.

Let's make this parameter R/W instead, like many others in the kernel.

Example usage:
Disable the parameter:
echo 0 >/sys/module/libata/parameters/fua

Revalidate disk cache settings:
F=/sys/class/scsi_disk/0\:0\:0\:0/cache_type; echo `cat $F` >$F

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 75b86913db1ac..b322006c85806 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -128,7 +128,7 @@ module_param(atapi_passthru16, int, 0444);
 MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI devices (0=off, 1=on [default])");
 
 int libata_fua = 0;
-module_param_named(fua, libata_fua, int, 0444);
+module_param_named(fua, libata_fua, int, 0644);
 MODULE_PARM_DESC(fua, "FUA support (0=off [default], 1=on)");
 
 static int ata_ignore_hpa;
