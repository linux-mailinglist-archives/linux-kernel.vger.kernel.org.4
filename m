Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD86D6AF991
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjCGWtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjCGWrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:45 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C0F957D0C;
        Tue,  7 Mar 2023 14:47:08 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id B21D77A0771;
        Tue,  7 Mar 2023 23:46:50 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 28/32] pata_parport-bpck6: move ppc6_rd_data_byte to bpck6.c and rename
Date:   Tue,  7 Mar 2023 23:46:23 +0100
Message-Id: <20230307224627.28011-29-linux@zary.sk>
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

Move ppc6_rd_data_byte to bpck6.c and rename it to bpck6_rd_data_byte

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c   | 38 ++++++++++++++++++-
 drivers/ata/pata_parport/ppc6lnx.c | 61 ------------------------------
 2 files changed, 36 insertions(+), 63 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 32dc9e61e80c..064696b6d68f 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -37,12 +37,46 @@ static void bpck6_send_cmd(struct pi_adapter *pi, u8 cmd)
 	}
 }
 
+static u8 bpck6_rd_data_byte(struct pi_adapter *pi)
+{
+	u8 data = 0;
+
+	switch (mode_map[pi->mode]) {
+	case PPCMODE_UNI_SW:
+	case PPCMODE_UNI_FW:
+		parport_frob_control(pi->pardev->port, PARPORT_CONTROL_STROBE,
+							PARPORT_CONTROL_INIT);
+		data = parport_read_status(pi->pardev->port);
+		data = ((data & 0x80) >> 1) | ((data & 0x38) >> 3);
+		parport_frob_control(pi->pardev->port, PARPORT_CONTROL_STROBE,
+							PARPORT_CONTROL_STROBE);
+		data |= parport_read_status(pi->pardev->port) & 0xB8;
+		break;
+	case PPCMODE_BI_SW:
+	case PPCMODE_BI_FW:
+		parport_data_reverse(pi->pardev->port);
+		parport_frob_control(pi->pardev->port, PARPORT_CONTROL_STROBE,
+				PARPORT_CONTROL_STROBE | PARPORT_CONTROL_INIT);
+		data = parport_read_data(pi->pardev->port);
+		parport_frob_control(pi->pardev->port, PARPORT_CONTROL_STROBE, 0);
+		parport_data_forward(pi->pardev->port);
+		break;
+	case PPCMODE_EPP_BYTE:
+	case PPCMODE_EPP_WORD:
+	case PPCMODE_EPP_DWORD:
+		pi->pardev->port->ops->epp_read_data(pi->pardev->port, &data, 1, 0);
+		break;
+	}
+
+	return data;
+}
+
 static int bpck6_read_regr(struct pi_adapter *pi, int cont, int reg)
 {
 	u8 port = cont ? reg | 8 : reg;
 
 	bpck6_send_cmd(pi, port | ACCESS_PORT | ACCESS_READ);
-	return ppc6_rd_data_byte(pi);
+	return bpck6_rd_data_byte(pi);
 }
 
 static void bpck6_write_regr(struct pi_adapter *pi, int cont, int reg, int val)
@@ -240,7 +274,7 @@ static int bpck6_open(struct pi_adapter *pi)
 			ppc6_wr_data_byte(pi, RAMSIZE_128K);
 
 			bpck6_send_cmd(pi, ACCESS_REG | ACCESS_READ | REG_VERSION);
-			if ((ppc6_rd_data_byte(pi) & 0x3F) == 0x0C)
+			if ((bpck6_rd_data_byte(pi) & 0x3F) == 0x0C)
 				pi->private |= fifo_wait;
 
 			return 1;
diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
index d3c3968fbfc8..838af60a0d4d 100644
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -68,7 +68,6 @@
 //***************************************************************************
 
 static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data);
-static u8 ppc6_rd_data_byte(struct pi_adapter *pi);
 
 //***************************************************************************
 
@@ -102,63 +101,3 @@ static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data)
 		}
 	}
 }
-
-//***************************************************************************
-
-static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
-{
-	u8 data = 0;
-
-	switch (mode_map[pi->mode])
-	{
-		case PPCMODE_UNI_SW :
-		case PPCMODE_UNI_FW :
-		{
-			parport_frob_control(pi->pardev->port,
-				PARPORT_CONTROL_STROBE, PARPORT_CONTROL_INIT);
-
-			// DELAY
-
-			data = parport_read_status(pi->pardev->port);
-
-			data = ((data & 0x80) >> 1) | ((data & 0x38) >> 3);
-
-			parport_frob_control(pi->pardev->port,
-				PARPORT_CONTROL_STROBE, PARPORT_CONTROL_STROBE);
-
-			// DELAY
-
-			data |= parport_read_status(pi->pardev->port) & 0xB8;
-
-			break;
-		}
-
-		case PPCMODE_BI_SW :
-		case PPCMODE_BI_FW :
-		{
-			parport_data_reverse(pi->pardev->port);
-
-			parport_frob_control(pi->pardev->port, PARPORT_CONTROL_STROBE,
-				PARPORT_CONTROL_STROBE | PARPORT_CONTROL_INIT);
-
-			data = parport_read_data(pi->pardev->port);
-
-			parport_frob_control(pi->pardev->port, PARPORT_CONTROL_STROBE, 0);
-
-			parport_data_forward(pi->pardev->port);
-
-			break;
-		}
-
-		case PPCMODE_EPP_BYTE :
-		case PPCMODE_EPP_WORD :
-		case PPCMODE_EPP_DWORD :
-		{
-			pi->pardev->port->ops->epp_read_data(pi->pardev->port, &data, 1, 0);
-
-			break;
-		}
-	}
-
-	return(data);
-}
-- 
Ondrej Zary

