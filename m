Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0519C6AF97F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjCGWsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjCGWrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:21 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8426B9CBE4;
        Tue,  7 Mar 2023 14:47:07 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id F351D7A0742;
        Tue,  7 Mar 2023 23:46:49 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/32] pata_parport-bpck6: merge ppc6_rd_data_blk into bpck6_read_block
Date:   Tue,  7 Mar 2023 23:46:15 +0100
Message-Id: <20230307224627.28011-21-linux@zary.sk>
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

ppc6_rd_data_blk is only called by bpck6_read_block. Merge
ppc6_rd_data_blk into bpck6_read_block.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c   | 49 +++++++++++++++-
 drivers/ata/pata_parport/ppc6lnx.c | 91 ------------------------------
 2 files changed, 48 insertions(+), 92 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 1c04fcaba74a..d379603424ff 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -57,7 +57,54 @@ static void bpck6_read_block(struct pi_adapter *pi, char *buf, int len)
 
 	ppc6_send_cmd(pi, CMD_PREFIX_SET | PREFIX_IO16 | PREFIX_BLK);
 	ppc6_send_cmd(pi, ATA_REG_DATA | ACCESS_PORT | ACCESS_READ);
-	ppc6_rd_data_blk(pi, buf, len);
+
+	switch (mode_map[pi->mode]) {
+	case PPCMODE_UNI_SW:
+	case PPCMODE_UNI_FW:
+		while (len) {
+			u8 d;
+
+			parport_frob_control(pi->pardev->port,
+					PARPORT_CONTROL_STROBE,
+					PARPORT_CONTROL_INIT); /* DATA STROBE */
+			d = parport_read_status(pi->pardev->port);
+			d = ((d & 0x80) >> 1) | ((d & 0x38) >> 3);
+			parport_frob_control(pi->pardev->port,
+					PARPORT_CONTROL_STROBE,
+					PARPORT_CONTROL_STROBE);
+			d |= parport_read_status(pi->pardev->port) & 0xB8;
+			*buf++ = d;
+			len--;
+		}
+		break;
+	case PPCMODE_BI_SW:
+	case PPCMODE_BI_FW:
+		parport_data_reverse(pi->pardev->port);
+		while (len) {
+			parport_frob_control(pi->pardev->port,
+				PARPORT_CONTROL_STROBE,
+				PARPORT_CONTROL_STROBE | PARPORT_CONTROL_INIT);
+			*buf++ = parport_read_data(pi->pardev->port);
+			len--;
+		}
+		parport_frob_control(pi->pardev->port, PARPORT_CONTROL_STROBE,
+					0);
+		parport_data_forward(pi->pardev->port);
+		break;
+	case PPCMODE_EPP_BYTE:
+		pi->pardev->port->ops->epp_read_data(pi->pardev->port, buf, len,
+						PARPORT_EPP_FAST_8);
+		break;
+	case PPCMODE_EPP_WORD:
+		pi->pardev->port->ops->epp_read_data(pi->pardev->port, buf, len,
+						PARPORT_EPP_FAST_16);
+		break;
+	case PPCMODE_EPP_DWORD:
+		pi->pardev->port->ops->epp_read_data(pi->pardev->port, buf, len,
+						PARPORT_EPP_FAST_32);
+		break;
+	}
+
 	ppc6_send_cmd(pi, CMD_PREFIX_RESET | PREFIX_IO16 | PREFIX_BLK);
 }
 
diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
index d275de3f1ead..679261e19ac5 100644
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -72,7 +72,6 @@ static void ppc6_deselect(struct pi_adapter *pi);
 static void ppc6_send_cmd(struct pi_adapter *pi, u8 cmd);
 static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data);
 static u8 ppc6_rd_data_byte(struct pi_adapter *pi);
-static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count);
 static void ppc6_wait_for_fifo(struct pi_adapter *pi);
 static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count);
 static void ppc6_wr_extout(struct pi_adapter *pi, u8 regdata);
@@ -284,96 +283,6 @@ static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
 
 //***************************************************************************
 
-static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count)
-{
-	switch (mode_map[pi->mode])
-	{
-		case PPCMODE_UNI_SW :
-		case PPCMODE_UNI_FW :
-		{
-			while(count)
-			{
-				u8 d;
-
-				parport_frob_control(pi->pardev->port,
-					PARPORT_CONTROL_STROBE, PARPORT_CONTROL_INIT);
-
-				// DELAY
-
-				d = parport_read_status(pi->pardev->port);
-
-				d = ((d & 0x80) >> 1) | ((d & 0x38) >> 3);
-
-				parport_frob_control(pi->pardev->port,
-					PARPORT_CONTROL_STROBE, PARPORT_CONTROL_STROBE);
-
-				// DELAY
-
-				d |= parport_read_status(pi->pardev->port) & 0xB8;
-
-				*data++ = d;
-				count--;
-			}
-
-			break;
-		}
-
-		case PPCMODE_BI_SW :
-		case PPCMODE_BI_FW :
-		{
-			parport_data_reverse(pi->pardev->port);
-
-			while(count)
-			{
-				parport_frob_control(pi->pardev->port, PARPORT_CONTROL_STROBE,
-					PARPORT_CONTROL_STROBE | PARPORT_CONTROL_INIT);
-
-				*data++ = parport_read_data(pi->pardev->port);
-				count--;
-			}
-
-			parport_frob_control(pi->pardev->port, PARPORT_CONTROL_STROBE, 0);
-
-			parport_data_forward(pi->pardev->port);
-
-			break;
-		}
-
-		case PPCMODE_EPP_BYTE :
-		{
-			// DELAY
-
-			pi->pardev->port->ops->epp_read_data(pi->pardev->port,
-					data, count, PARPORT_EPP_FAST_8);
-
-			break;
-		}
-
-		case PPCMODE_EPP_WORD :
-		{
-			// DELAY
-
-			pi->pardev->port->ops->epp_read_data(pi->pardev->port,
-					data, count, PARPORT_EPP_FAST_16);
-
-			break;
-		}
-
-		case PPCMODE_EPP_DWORD :
-		{
-			// DELAY
-
-			pi->pardev->port->ops->epp_read_data(pi->pardev->port,
-					data, count, PARPORT_EPP_FAST_32);
-
-			break;
-		}
-	}
-
-}
-
-//***************************************************************************
-
 static void ppc6_wait_for_fifo(struct pi_adapter *pi)
 {
 	int i;
-- 
Ondrej Zary

