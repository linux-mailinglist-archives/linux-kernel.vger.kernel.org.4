Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4216AF970
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjCGWsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjCGWr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:26 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D914C59D9;
        Tue,  7 Mar 2023 14:47:07 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 143267A0749;
        Tue,  7 Mar 2023 23:46:50 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/32] pata_parport-bpck6: merge ppc6_wr_data_blk into bpck6_write_block
Date:   Tue,  7 Mar 2023 23:46:16 +0100
Message-Id: <20230307224627.28011-22-linux@zary.sk>
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

ppc6_wr_data_blk is only called by bpck6_write_block. Merge
ppc6_wr_data_blk into bpck6_write_block.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c   | 58 ++++++++++++++++++-
 drivers/ata/pata_parport/ppc6lnx.c | 91 ------------------------------
 2 files changed, 57 insertions(+), 92 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index d379603424ff..27c1fa3bb336 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -37,6 +37,8 @@ static void bpck6_write_regr(struct pi_adapter *pi, int cont, int reg, int val)
 
 static void bpck6_write_block(struct pi_adapter *pi, char *buf, int len)
 {
+	u8 this, last;
+
 	ppc6_send_cmd(pi, REG_BLKSIZE | ACCESS_REG | ACCESS_WRITE);
 	ppc6_wr_data_byte(pi, (u8)len);
 	ppc6_wr_data_byte(pi, (u8)(len >> 8));
@@ -44,7 +46,61 @@ static void bpck6_write_block(struct pi_adapter *pi, char *buf, int len)
 
 	ppc6_send_cmd(pi, CMD_PREFIX_SET | PREFIX_IO16 | PREFIX_BLK);
 	ppc6_send_cmd(pi, ATA_REG_DATA | ACCESS_PORT | ACCESS_WRITE);
-	ppc6_wr_data_blk(pi, buf, len);
+
+	switch (mode_map[pi->mode]) {
+	case PPCMODE_UNI_SW:
+	case PPCMODE_BI_SW:
+		while (len--) {
+			parport_write_data(pi->pardev->port, *buf++);
+			parport_frob_control(pi->pardev->port, 0,
+							PARPORT_CONTROL_INIT);
+		}
+		break;
+	case PPCMODE_UNI_FW:
+	case PPCMODE_BI_FW:
+		ppc6_send_cmd(pi, CMD_PREFIX_SET | PREFIX_FASTWR);
+
+		parport_frob_control(pi->pardev->port, PARPORT_CONTROL_STROBE,
+							PARPORT_CONTROL_STROBE);
+
+		last = *buf;
+
+		parport_write_data(pi->pardev->port, last);
+
+		while (len) {
+			this = *buf++;
+			len--;
+
+			if (this == last) {
+				parport_frob_control(pi->pardev->port, 0,
+							PARPORT_CONTROL_INIT);
+			} else {
+				parport_write_data(pi->pardev->port, this);
+				last = this;
+			}
+		}
+
+		parport_frob_control(pi->pardev->port, PARPORT_CONTROL_STROBE,
+							0);
+		ppc6_send_cmd(pi, CMD_PREFIX_RESET | PREFIX_FASTWR);
+		break;
+	case PPCMODE_EPP_BYTE:
+		pi->pardev->port->ops->epp_write_data(pi->pardev->port, buf,
+						len, PARPORT_EPP_FAST_8);
+		ppc6_wait_for_fifo(pi);
+		break;
+	case PPCMODE_EPP_WORD:
+		pi->pardev->port->ops->epp_write_data(pi->pardev->port, buf,
+						len, PARPORT_EPP_FAST_16);
+		ppc6_wait_for_fifo(pi);
+		break;
+	case PPCMODE_EPP_DWORD:
+		pi->pardev->port->ops->epp_write_data(pi->pardev->port, buf,
+						len, PARPORT_EPP_FAST_32);
+		ppc6_wait_for_fifo(pi);
+		break;
+	}
+
 	ppc6_send_cmd(pi, CMD_PREFIX_RESET | PREFIX_IO16 | PREFIX_BLK);
 }
 
diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
index 679261e19ac5..3ba920251c1c 100644
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -73,7 +73,6 @@ static void ppc6_send_cmd(struct pi_adapter *pi, u8 cmd);
 static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data);
 static u8 ppc6_rd_data_byte(struct pi_adapter *pi);
 static void ppc6_wait_for_fifo(struct pi_adapter *pi);
-static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count);
 static void ppc6_wr_extout(struct pi_adapter *pi, u8 regdata);
 static int ppc6_open(struct pi_adapter *pi);
 
@@ -296,96 +295,6 @@ static void ppc6_wait_for_fifo(struct pi_adapter *pi)
 
 //***************************************************************************
 
-static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
-{
-	switch (mode_map[pi->mode])
-	{
-		case PPCMODE_UNI_SW :
-		case PPCMODE_BI_SW :
-		{
-			while(count--)
-			{
-				parport_write_data(pi->pardev->port, *data++);
-
-				parport_frob_control(pi->pardev->port, 0, PARPORT_CONTROL_INIT);
-			}
-
-			break;
-		}
-
-		case PPCMODE_UNI_FW :
-		case PPCMODE_BI_FW :
-		{
-			u8 this, last;
-
-			ppc6_send_cmd(pi, CMD_PREFIX_SET | PREFIX_FASTWR);
-
-			parport_frob_control(pi->pardev->port,
-				PARPORT_CONTROL_STROBE, PARPORT_CONTROL_STROBE);
-
-			last = *data;
-
-			parport_write_data(pi->pardev->port, last);
-
-			while(count)
-			{
-				this = *data++;
-				count--;
-
-				if (this == last)
-				{
-					parport_frob_control(pi->pardev->port,
-						0, PARPORT_CONTROL_INIT);
-				}
-				else
-				{
-					parport_write_data(pi->pardev->port, this);
-
-					last = this;
-				}
-			}
-
-			parport_frob_control(pi->pardev->port, PARPORT_CONTROL_STROBE, 0);
-
-			ppc6_send_cmd(pi, CMD_PREFIX_RESET | PREFIX_FASTWR);
-
-			break;
-		}
-
-		case PPCMODE_EPP_BYTE :
-		{
-			pi->pardev->port->ops->epp_write_data(pi->pardev->port,
-					data, count, PARPORT_EPP_FAST_8);
-
-			ppc6_wait_for_fifo(pi);
-
-			break;
-		}
-
-		case PPCMODE_EPP_WORD :
-		{
-			pi->pardev->port->ops->epp_write_data(pi->pardev->port,
-					data, count, PARPORT_EPP_FAST_16);
-
-			ppc6_wait_for_fifo(pi);
-
-			break;
-		}
-
-		case PPCMODE_EPP_DWORD :
-		{
-			pi->pardev->port->ops->epp_write_data(pi->pardev->port,
-					data, count, PARPORT_EPP_FAST_32);
-
-			ppc6_wait_for_fifo(pi);
-
-			break;
-		}
-	}
-}
-
-//***************************************************************************
-
 static void ppc6_wr_extout(struct pi_adapter *pi, u8 regdata)
 {
 	ppc6_send_cmd(pi, REG_VERSION | ACCESS_REG | ACCESS_WRITE);
-- 
Ondrej Zary

