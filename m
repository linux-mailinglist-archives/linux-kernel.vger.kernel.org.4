Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6176AF992
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjCGWtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjCGWru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:50 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E2165371E;
        Tue,  7 Mar 2023 14:47:08 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 2FB3A7A074C;
        Tue,  7 Mar 2023 23:46:50 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 22/32] pata_parport-bpck6: move ppc6_wait_for_fifo to bpck6.c and rename
Date:   Tue,  7 Mar 2023 23:46:17 +0100
Message-Id: <20230307224627.28011-23-linux@zary.sk>
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

Move ppc6_wait_for_fifo to bpck6.c and rename it to bpck6_wait_for_fifo

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c   | 16 +++++++++++++---
 drivers/ata/pata_parport/ppc6lnx.c | 14 --------------
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 27c1fa3bb336..1f976ee04ef2 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -35,6 +35,16 @@ static void bpck6_write_regr(struct pi_adapter *pi, int cont, int reg, int val)
 	ppc6_wr_data_byte(pi, val);
 }
 
+static void bpck6_wait_for_fifo(struct pi_adapter *pi)
+{
+	int i;
+
+	if (pi->private & fifo_wait) {
+		for (i = 0; i < 20; i++)
+			parport_read_status(pi->pardev->port);
+	}
+}
+
 static void bpck6_write_block(struct pi_adapter *pi, char *buf, int len)
 {
 	u8 this, last;
@@ -87,17 +97,17 @@ static void bpck6_write_block(struct pi_adapter *pi, char *buf, int len)
 	case PPCMODE_EPP_BYTE:
 		pi->pardev->port->ops->epp_write_data(pi->pardev->port, buf,
 						len, PARPORT_EPP_FAST_8);
-		ppc6_wait_for_fifo(pi);
+		bpck6_wait_for_fifo(pi);
 		break;
 	case PPCMODE_EPP_WORD:
 		pi->pardev->port->ops->epp_write_data(pi->pardev->port, buf,
 						len, PARPORT_EPP_FAST_16);
-		ppc6_wait_for_fifo(pi);
+		bpck6_wait_for_fifo(pi);
 		break;
 	case PPCMODE_EPP_DWORD:
 		pi->pardev->port->ops->epp_write_data(pi->pardev->port, buf,
 						len, PARPORT_EPP_FAST_32);
-		ppc6_wait_for_fifo(pi);
+		bpck6_wait_for_fifo(pi);
 		break;
 	}
 
diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
index 3ba920251c1c..cd4fa31a5ff8 100644
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -72,7 +72,6 @@ static void ppc6_deselect(struct pi_adapter *pi);
 static void ppc6_send_cmd(struct pi_adapter *pi, u8 cmd);
 static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data);
 static u8 ppc6_rd_data_byte(struct pi_adapter *pi);
-static void ppc6_wait_for_fifo(struct pi_adapter *pi);
 static void ppc6_wr_extout(struct pi_adapter *pi, u8 regdata);
 static int ppc6_open(struct pi_adapter *pi);
 
@@ -282,19 +281,6 @@ static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
 
 //***************************************************************************
 
-static void ppc6_wait_for_fifo(struct pi_adapter *pi)
-{
-	int i;
-
-	if (pi->private & fifo_wait)
-	{
-		for(i=0; i<20; i++)
-			parport_read_status(pi->pardev->port);
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

