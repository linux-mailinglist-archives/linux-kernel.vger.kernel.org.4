Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CE76AF993
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjCGWtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjCGWru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:50 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F26893125;
        Tue,  7 Mar 2023 14:47:08 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 977937A076F;
        Tue,  7 Mar 2023 23:46:50 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 27/32] pata_parport-bpck6: move ppc6_send_cmd to bpck6.c and rename
Date:   Tue,  7 Mar 2023 23:46:22 +0100
Message-Id: <20230307224627.28011-28-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230307224627.28011-1-linux@zary.sk>
References: <20230307224627.28011-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ppc6_send_cmd to bpck6.c and rename it to bpck6_send_cmd

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c   | 48 ++++++++++++++++++++----------
 drivers/ata/pata_parport/ppc6lnx.c | 29 ------------------
 2 files changed, 33 insertions(+), 44 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 46a91b04aed3..32dc9e61e80c 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -19,11 +19,29 @@
 #include "pata_parport.h"
 #include "ppc6lnx.c"
 
+static void bpck6_send_cmd(struct pi_adapter *pi, u8 cmd)
+{
+	switch (mode_map[pi->mode]) {
+	case PPCMODE_UNI_SW:
+	case PPCMODE_UNI_FW:
+	case PPCMODE_BI_SW:
+	case PPCMODE_BI_FW:
+		parport_write_data(pi->pardev->port, cmd);
+		parport_frob_control(pi->pardev->port, 0, PARPORT_CONTROL_AUTOFD);
+		break;
+	case PPCMODE_EPP_BYTE:
+	case PPCMODE_EPP_WORD:
+	case PPCMODE_EPP_DWORD:
+		pi->pardev->port->ops->epp_write_addr(pi->pardev->port, &cmd, 1, 0);
+		break;
+	}
+}
+
 static int bpck6_read_regr(struct pi_adapter *pi, int cont, int reg)
 {
 	u8 port = cont ? reg | 8 : reg;
 
-	ppc6_send_cmd(pi, port | ACCESS_PORT | ACCESS_READ);
+	bpck6_send_cmd(pi, port | ACCESS_PORT | ACCESS_READ);
 	return ppc6_rd_data_byte(pi);
 }
 
@@ -31,7 +49,7 @@ static void bpck6_write_regr(struct pi_adapter *pi, int cont, int reg, int val)
 {
 	u8 port = cont ? reg | 8 : reg;
 
-	ppc6_send_cmd(pi, port | ACCESS_PORT | ACCESS_WRITE);
+	bpck6_send_cmd(pi, port | ACCESS_PORT | ACCESS_WRITE);
 	ppc6_wr_data_byte(pi, val);
 }
 
@@ -49,13 +67,13 @@ static void bpck6_write_block(struct pi_adapter *pi, char *buf, int len)
 {
 	u8 this, last;
 
-	ppc6_send_cmd(pi, REG_BLKSIZE | ACCESS_REG | ACCESS_WRITE);
+	bpck6_send_cmd(pi, REG_BLKSIZE | ACCESS_REG | ACCESS_WRITE);
 	ppc6_wr_data_byte(pi, (u8)len);
 	ppc6_wr_data_byte(pi, (u8)(len >> 8));
 	ppc6_wr_data_byte(pi, 0);
 
-	ppc6_send_cmd(pi, CMD_PREFIX_SET | PREFIX_IO16 | PREFIX_BLK);
-	ppc6_send_cmd(pi, ATA_REG_DATA | ACCESS_PORT | ACCESS_WRITE);
+	bpck6_send_cmd(pi, CMD_PREFIX_SET | PREFIX_IO16 | PREFIX_BLK);
+	bpck6_send_cmd(pi, ATA_REG_DATA | ACCESS_PORT | ACCESS_WRITE);
 
 	switch (mode_map[pi->mode]) {
 	case PPCMODE_UNI_SW:
@@ -68,7 +86,7 @@ static void bpck6_write_block(struct pi_adapter *pi, char *buf, int len)
 		break;
 	case PPCMODE_UNI_FW:
 	case PPCMODE_BI_FW:
-		ppc6_send_cmd(pi, CMD_PREFIX_SET | PREFIX_FASTWR);
+		bpck6_send_cmd(pi, CMD_PREFIX_SET | PREFIX_FASTWR);
 
 		parport_frob_control(pi->pardev->port, PARPORT_CONTROL_STROBE,
 							PARPORT_CONTROL_STROBE);
@@ -92,7 +110,7 @@ static void bpck6_write_block(struct pi_adapter *pi, char *buf, int len)
 
 		parport_frob_control(pi->pardev->port, PARPORT_CONTROL_STROBE,
 							0);
-		ppc6_send_cmd(pi, CMD_PREFIX_RESET | PREFIX_FASTWR);
+		bpck6_send_cmd(pi, CMD_PREFIX_RESET | PREFIX_FASTWR);
 		break;
 	case PPCMODE_EPP_BYTE:
 		pi->pardev->port->ops->epp_write_data(pi->pardev->port, buf,
@@ -111,18 +129,18 @@ static void bpck6_write_block(struct pi_adapter *pi, char *buf, int len)
 		break;
 	}
 
-	ppc6_send_cmd(pi, CMD_PREFIX_RESET | PREFIX_IO16 | PREFIX_BLK);
+	bpck6_send_cmd(pi, CMD_PREFIX_RESET | PREFIX_IO16 | PREFIX_BLK);
 }
 
 static void bpck6_read_block(struct pi_adapter *pi, char *buf, int len)
 {
-	ppc6_send_cmd(pi, REG_BLKSIZE | ACCESS_REG | ACCESS_WRITE);
+	bpck6_send_cmd(pi, REG_BLKSIZE | ACCESS_REG | ACCESS_WRITE);
 	ppc6_wr_data_byte(pi, (u8)len);
 	ppc6_wr_data_byte(pi, (u8)(len >> 8));
 	ppc6_wr_data_byte(pi, 0);
 
-	ppc6_send_cmd(pi, CMD_PREFIX_SET | PREFIX_IO16 | PREFIX_BLK);
-	ppc6_send_cmd(pi, ATA_REG_DATA | ACCESS_PORT | ACCESS_READ);
+	bpck6_send_cmd(pi, CMD_PREFIX_SET | PREFIX_IO16 | PREFIX_BLK);
+	bpck6_send_cmd(pi, ATA_REG_DATA | ACCESS_PORT | ACCESS_READ);
 
 	switch (mode_map[pi->mode]) {
 	case PPCMODE_UNI_SW:
@@ -171,7 +189,7 @@ static void bpck6_read_block(struct pi_adapter *pi, char *buf, int len)
 		break;
 	}
 
-	ppc6_send_cmd(pi, CMD_PREFIX_RESET | PREFIX_IO16 | PREFIX_BLK);
+	bpck6_send_cmd(pi, CMD_PREFIX_RESET | PREFIX_IO16 | PREFIX_BLK);
 }
 
 static int bpck6_open(struct pi_adapter *pi)
@@ -218,10 +236,10 @@ static int bpck6_open(struct pi_adapter *pi)
 
 			pi->private = 0;
 
-			ppc6_send_cmd(pi, ACCESS_REG | ACCESS_WRITE | REG_RAMSIZE);
+			bpck6_send_cmd(pi, ACCESS_REG | ACCESS_WRITE | REG_RAMSIZE);
 			ppc6_wr_data_byte(pi, RAMSIZE_128K);
 
-			ppc6_send_cmd(pi, ACCESS_REG | ACCESS_READ | REG_VERSION);
+			bpck6_send_cmd(pi, ACCESS_REG | ACCESS_READ | REG_VERSION);
 			if ((ppc6_rd_data_byte(pi) & 0x3F) == 0x0C)
 				pi->private |= fifo_wait;
 
@@ -252,7 +270,7 @@ static void bpck6_deselect(struct pi_adapter *pi)
 
 static void bpck6_wr_extout(struct pi_adapter *pi, u8 regdata)
 {
-	ppc6_send_cmd(pi, REG_VERSION | ACCESS_REG | ACCESS_WRITE);
+	bpck6_send_cmd(pi, REG_VERSION | ACCESS_REG | ACCESS_WRITE);
 	ppc6_wr_data_byte(pi, (u8)((regdata & 0x03) << 6));
 }
 
diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
index 6c34bbbdf6db..d3c3968fbfc8 100644
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -67,7 +67,6 @@
 
 //***************************************************************************
 
-static void ppc6_send_cmd(struct pi_adapter *pi, u8 cmd);
 static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data);
 static u8 ppc6_rd_data_byte(struct pi_adapter *pi);
 
@@ -78,34 +77,6 @@ int mode_map[] = { PPCMODE_UNI_FW, PPCMODE_BI_FW, PPCMODE_EPP_BYTE,
 
 //***************************************************************************
 
-static void ppc6_send_cmd(struct pi_adapter *pi, u8 cmd)
-{
-	switch (mode_map[pi->mode])
-	{
-		case PPCMODE_UNI_SW :
-		case PPCMODE_UNI_FW :
-		case PPCMODE_BI_SW :
-		case PPCMODE_BI_FW :
-		{
-			parport_write_data(pi->pardev->port, cmd);
-			parport_frob_control(pi->pardev->port, 0, PARPORT_CONTROL_AUTOFD);
-
-			break;
-		}
-
-		case PPCMODE_EPP_BYTE :
-		case PPCMODE_EPP_WORD :
-		case PPCMODE_EPP_DWORD :
-		{
-			pi->pardev->port->ops->epp_write_addr(pi->pardev->port, &cmd, 1, 0);
-
-			break;
-		}
-	}
-}
-
-//***************************************************************************
-
 static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data)
 {
 	switch (mode_map[pi->mode])
-- 
Ondrej Zary

