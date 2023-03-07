Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68E16AF974
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjCGWsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjCGWrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:21 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B33D2ED57;
        Tue,  7 Mar 2023 14:47:08 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 734E07A0756;
        Tue,  7 Mar 2023 23:46:50 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/32] pata_parport-bpck6: merge ppc6_select into bpck6_open
Date:   Tue,  7 Mar 2023 23:46:20 +0100
Message-Id: <20230307224627.28011-26-linux@zary.sk>
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

ppc6_select is only called by bpck6_open. Merge ppc6_select into
bpck6_open.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c   | 68 ++++++++++++++++++++++++------
 drivers/ata/pata_parport/ppc6lnx.c | 66 -----------------------------
 2 files changed, 55 insertions(+), 79 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 02f16dedfd29..9b05e1c827cd 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -176,21 +176,63 @@ static void bpck6_read_block(struct pi_adapter *pi, char *buf, int len)
 
 static int bpck6_open(struct pi_adapter *pi)
 {
-	int ret = ppc6_select(pi);
-
-	if (ret == 0)
-		return ret;
-
-	pi->private = 0;
-
-	ppc6_send_cmd(pi, ACCESS_REG | ACCESS_WRITE | REG_RAMSIZE);
-	ppc6_wr_data_byte(pi, RAMSIZE_128K);
+	u8 i, j, k;
+
+	pi->saved_r0 = parport_read_data(pi->pardev->port);
+	pi->saved_r2 = parport_read_control(pi->pardev->port) & 0x5F;
+
+	parport_frob_control(pi->pardev->port, PARPORT_CONTROL_SELECT,
+						PARPORT_CONTROL_SELECT);
+	if (pi->saved_r0 == 'b')
+		parport_write_data(pi->pardev->port, 'x');
+	parport_write_data(pi->pardev->port, 'b');
+	parport_write_data(pi->pardev->port, 'p');
+	parport_write_data(pi->pardev->port, pi->unit);
+	parport_write_data(pi->pardev->port, ~pi->unit);
+
+	parport_frob_control(pi->pardev->port, PARPORT_CONTROL_SELECT, 0);
+	parport_write_control(pi->pardev->port, PARPORT_CONTROL_INIT);
+
+	i = mode_map[pi->mode] & 0x0C;
+	if (i == 0)
+		i = (mode_map[pi->mode] & 2) | 1;
+	parport_write_data(pi->pardev->port, i);
+
+	parport_frob_control(pi->pardev->port, PARPORT_CONTROL_SELECT,
+						PARPORT_CONTROL_SELECT);
+	parport_frob_control(pi->pardev->port, PARPORT_CONTROL_AUTOFD,
+						PARPORT_CONTROL_AUTOFD);
+
+	j = ((i & 0x08) << 4) | ((i & 0x07) << 3);
+	k = parport_read_status(pi->pardev->port) & 0xB8;
+	if (j == k) {
+		parport_frob_control(pi->pardev->port, PARPORT_CONTROL_AUTOFD, 0);
+		k = (parport_read_status(pi->pardev->port) & 0xB8) ^ 0xB8;
+		if (j == k) {
+			if (i & 4)	// EPP
+				parport_frob_control(pi->pardev->port,
+					PARPORT_CONTROL_SELECT | PARPORT_CONTROL_INIT, 0);
+			else				// PPC/ECP
+				parport_frob_control(pi->pardev->port,
+					PARPORT_CONTROL_SELECT, 0);
+
+			pi->private = 0;
+
+			ppc6_send_cmd(pi, ACCESS_REG | ACCESS_WRITE | REG_RAMSIZE);
+			ppc6_wr_data_byte(pi, RAMSIZE_128K);
+
+			ppc6_send_cmd(pi, ACCESS_REG | ACCESS_READ | REG_VERSION);
+			if ((ppc6_rd_data_byte(pi) & 0x3F) == 0x0C)
+				pi->private |= fifo_wait;
+
+			return 1;
+		}
+	}
 
-	ppc6_send_cmd(pi, ACCESS_REG | ACCESS_READ | REG_VERSION);
-	if ((ppc6_rd_data_byte(pi) & 0x3F) == 0x0C)
-		pi->private |= fifo_wait;
+	parport_write_control(pi->pardev->port, pi->saved_r2);
+	parport_write_data(pi->pardev->port, pi->saved_r0);
 
-	return ret;
+	return 0; // FAIL
 }
 
 static void bpck6_wr_extout(struct pi_adapter *pi, u8 regdata)
diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
index a902ede5ecc5..16d0497dfeaa 100644
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -67,7 +67,6 @@
 
 //***************************************************************************
 
-static int ppc6_select(struct pi_adapter *pi);
 static void ppc6_deselect(struct pi_adapter *pi);
 static void ppc6_send_cmd(struct pi_adapter *pi, u8 cmd);
 static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data);
@@ -78,71 +77,6 @@ static u8 ppc6_rd_data_byte(struct pi_adapter *pi);
 int mode_map[] = { PPCMODE_UNI_FW, PPCMODE_BI_FW, PPCMODE_EPP_BYTE,
 		   PPCMODE_EPP_WORD, PPCMODE_EPP_DWORD };
 
-static int ppc6_select(struct pi_adapter *pi)
-{
-	u8 i, j, k;
-
-	pi->saved_r0 = parport_read_data(pi->pardev->port);
-
-	pi->saved_r2 = parport_read_control(pi->pardev->port) & 0x5F; // readback ctrl
-
-	parport_frob_control(pi->pardev->port, PARPORT_CONTROL_SELECT, PARPORT_CONTROL_SELECT);
-
-	if (pi->saved_r0 == 'b')
-		parport_write_data(pi->pardev->port, 'x');
-
-	parport_write_data(pi->pardev->port, 'b');
-	parport_write_data(pi->pardev->port, 'p');
-	parport_write_data(pi->pardev->port, pi->unit);
-	parport_write_data(pi->pardev->port, ~pi->unit);
-
-	parport_frob_control(pi->pardev->port, PARPORT_CONTROL_SELECT, 0);
-
-	parport_write_control(pi->pardev->port, PARPORT_CONTROL_INIT);
-
-	i = mode_map[pi->mode] & 0x0C;
-
-	if (i == 0)
-		i = (mode_map[pi->mode] & 2) | 1;
-
-	parport_write_data(pi->pardev->port, i);
-
-	parport_frob_control(pi->pardev->port, PARPORT_CONTROL_SELECT, PARPORT_CONTROL_SELECT);
-
-	// DELAY
-
-	parport_frob_control(pi->pardev->port, PARPORT_CONTROL_AUTOFD, PARPORT_CONTROL_AUTOFD);
-
-	j = ((i & 0x08) << 4) | ((i & 0x07) << 3);
-
-	k = parport_read_status(pi->pardev->port) & 0xB8;
-
-	if (j == k)
-	{
-		parport_frob_control(pi->pardev->port, PARPORT_CONTROL_AUTOFD, 0);
-
-		k = (parport_read_status(pi->pardev->port) & 0xB8) ^ 0xB8;
-
-		if (j == k)
-		{
-			if (i & 4)	// EPP
-				parport_frob_control(pi->pardev->port,
-					PARPORT_CONTROL_SELECT | PARPORT_CONTROL_INIT, 0);
-			else				// PPC/ECP
-				parport_frob_control(pi->pardev->port,
-					PARPORT_CONTROL_SELECT, 0);
-
-			return(1);
-		}
-	}
-
-	parport_write_control(pi->pardev->port, pi->saved_r2);
-
-	parport_write_data(pi->pardev->port, pi->saved_r0);
-
-	return(0); // FAIL
-}
-
 //***************************************************************************
 
 static void ppc6_deselect(struct pi_adapter *pi)
-- 
Ondrej Zary

