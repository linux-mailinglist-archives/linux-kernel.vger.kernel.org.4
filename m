Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509EC6AF980
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjCGWtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjCGWrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:45 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E3DC99C2D;
        Tue,  7 Mar 2023 14:47:09 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id CAA287A0776;
        Tue,  7 Mar 2023 23:46:50 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 29/32] pata_parport-bpck6: move ppc6_wr_data_byte to bpck6.c and rename
Date:   Tue,  7 Mar 2023 23:46:24 +0100
Message-Id: <20230307224627.28011-30-linux@zary.sk>
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

Move ppc6_wr_data_byte to bpck6.c and rename it to bpck6_wr_data_byte

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c   | 36 ++++++++++++++++++++++--------
 drivers/ata/pata_parport/ppc6lnx.c | 32 --------------------------
 2 files changed, 27 insertions(+), 41 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 064696b6d68f..f6d0916577b3 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -71,6 +71,24 @@ static u8 bpck6_rd_data_byte(struct pi_adapter *pi)
 	return data;
 }
 
+static void bpck6_wr_data_byte(struct pi_adapter *pi, u8 data)
+{
+	switch (mode_map[pi->mode]) {
+	case PPCMODE_UNI_SW:
+	case PPCMODE_UNI_FW:
+	case PPCMODE_BI_SW:
+	case PPCMODE_BI_FW:
+		parport_write_data(pi->pardev->port, data);
+		parport_frob_control(pi->pardev->port, 0, PARPORT_CONTROL_INIT);
+		break;
+	case PPCMODE_EPP_BYTE:
+	case PPCMODE_EPP_WORD:
+	case PPCMODE_EPP_DWORD:
+		pi->pardev->port->ops->epp_write_data(pi->pardev->port, &data, 1, 0);
+		break;
+	}
+}
+
 static int bpck6_read_regr(struct pi_adapter *pi, int cont, int reg)
 {
 	u8 port = cont ? reg | 8 : reg;
@@ -84,7 +102,7 @@ static void bpck6_write_regr(struct pi_adapter *pi, int cont, int reg, int val)
 	u8 port = cont ? reg | 8 : reg;
 
 	bpck6_send_cmd(pi, port | ACCESS_PORT | ACCESS_WRITE);
-	ppc6_wr_data_byte(pi, val);
+	bpck6_wr_data_byte(pi, val);
 }
 
 static void bpck6_wait_for_fifo(struct pi_adapter *pi)
@@ -102,9 +120,9 @@ static void bpck6_write_block(struct pi_adapter *pi, char *buf, int len)
 	u8 this, last;
 
 	bpck6_send_cmd(pi, REG_BLKSIZE | ACCESS_REG | ACCESS_WRITE);
-	ppc6_wr_data_byte(pi, (u8)len);
-	ppc6_wr_data_byte(pi, (u8)(len >> 8));
-	ppc6_wr_data_byte(pi, 0);
+	bpck6_wr_data_byte(pi, (u8)len);
+	bpck6_wr_data_byte(pi, (u8)(len >> 8));
+	bpck6_wr_data_byte(pi, 0);
 
 	bpck6_send_cmd(pi, CMD_PREFIX_SET | PREFIX_IO16 | PREFIX_BLK);
 	bpck6_send_cmd(pi, ATA_REG_DATA | ACCESS_PORT | ACCESS_WRITE);
@@ -169,9 +187,9 @@ static void bpck6_write_block(struct pi_adapter *pi, char *buf, int len)
 static void bpck6_read_block(struct pi_adapter *pi, char *buf, int len)
 {
 	bpck6_send_cmd(pi, REG_BLKSIZE | ACCESS_REG | ACCESS_WRITE);
-	ppc6_wr_data_byte(pi, (u8)len);
-	ppc6_wr_data_byte(pi, (u8)(len >> 8));
-	ppc6_wr_data_byte(pi, 0);
+	bpck6_wr_data_byte(pi, (u8)len);
+	bpck6_wr_data_byte(pi, (u8)(len >> 8));
+	bpck6_wr_data_byte(pi, 0);
 
 	bpck6_send_cmd(pi, CMD_PREFIX_SET | PREFIX_IO16 | PREFIX_BLK);
 	bpck6_send_cmd(pi, ATA_REG_DATA | ACCESS_PORT | ACCESS_READ);
@@ -271,7 +289,7 @@ static int bpck6_open(struct pi_adapter *pi)
 			pi->private = 0;
 
 			bpck6_send_cmd(pi, ACCESS_REG | ACCESS_WRITE | REG_RAMSIZE);
-			ppc6_wr_data_byte(pi, RAMSIZE_128K);
+			bpck6_wr_data_byte(pi, RAMSIZE_128K);
 
 			bpck6_send_cmd(pi, ACCESS_REG | ACCESS_READ | REG_VERSION);
 			if ((bpck6_rd_data_byte(pi) & 0x3F) == 0x0C)
@@ -305,7 +323,7 @@ static void bpck6_deselect(struct pi_adapter *pi)
 static void bpck6_wr_extout(struct pi_adapter *pi, u8 regdata)
 {
 	bpck6_send_cmd(pi, REG_VERSION | ACCESS_REG | ACCESS_WRITE);
-	ppc6_wr_data_byte(pi, (u8)((regdata & 0x03) << 6));
+	bpck6_wr_data_byte(pi, (u8)((regdata & 0x03) << 6));
 }
 
 static void bpck6_connect(struct pi_adapter *pi)
diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
index 838af60a0d4d..9a763cbda130 100644
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -67,37 +67,5 @@
 
 //***************************************************************************
 
-static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data);
-
-//***************************************************************************
-
 int mode_map[] = { PPCMODE_UNI_FW, PPCMODE_BI_FW, PPCMODE_EPP_BYTE,
 		   PPCMODE_EPP_WORD, PPCMODE_EPP_DWORD };
-
-//***************************************************************************
-
-static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data)
-{
-	switch (mode_map[pi->mode])
-	{
-		case PPCMODE_UNI_SW :
-		case PPCMODE_UNI_FW :
-		case PPCMODE_BI_SW :
-		case PPCMODE_BI_FW :
-		{
-			parport_write_data(pi->pardev->port, data);
-			parport_frob_control(pi->pardev->port, 0, PARPORT_CONTROL_INIT);
-
-			break;
-		}
-
-		case PPCMODE_EPP_BYTE :
-		case PPCMODE_EPP_WORD :
-		case PPCMODE_EPP_DWORD :
-		{
-			pi->pardev->port->ops->epp_write_data(pi->pardev->port, &data, 1, 0);
-
-			break;
-		}
-	}
-}
-- 
Ondrej Zary

