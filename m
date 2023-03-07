Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224C76AF95A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjCGWrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjCGWrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:07 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0DA315C91;
        Tue,  7 Mar 2023 14:47:02 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 409EE7A0709;
        Tue,  7 Mar 2023 23:46:49 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/32] pata_parport-bpck6: use parport_frob_control and remove CUR_CTRL
Date:   Tue,  7 Mar 2023 23:46:08 +0100
Message-Id: <20230307224627.28011-14-linux@zary.sk>
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

Use parport_frob_control instead of manually maintaining control
register state.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/ppc6lnx.c | 120 +++++++++--------------------
 1 file changed, 36 insertions(+), 84 deletions(-)

diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
index 89c40d6ab036..fdc11875bf1b 100644
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -15,14 +15,6 @@
 
 //***************************************************************************
 
-
-#define port_int					16
-
-#define ECR_EPP	0x80
-#define ECR_BI	0x20
-
-//***************************************************************************
-
 //  60772 Commands
 
 #define ACCESS_REG				0x00
@@ -57,7 +49,6 @@
 
 //***************************************************************************
 
-#define CUR_CTRL	(((u8 *)&pi->private)[0])
 #define PPC_FLAGS	(((u8 *)&pi->private)[1])
 
 //***************************************************************************
@@ -109,11 +100,7 @@ static int ppc6_select(struct pi_adapter *pi)
 
 	pi->saved_r2 = parport_read_control(pi->pardev->port) & 0x5F; // readback ctrl
 
-	CUR_CTRL = pi->saved_r2;
-
-	CUR_CTRL |= PARPORT_CONTROL_SELECT;
-
-	parport_write_control(pi->pardev->port, CUR_CTRL);
+	parport_frob_control(pi->pardev->port, PARPORT_CONTROL_SELECT, PARPORT_CONTROL_SELECT);
 
 	if (pi->saved_r0 == 'b')
 		parport_write_data(pi->pardev->port, 'x');
@@ -123,13 +110,9 @@ static int ppc6_select(struct pi_adapter *pi)
 	parport_write_data(pi->pardev->port, pi->unit);
 	parport_write_data(pi->pardev->port, ~pi->unit);
 
-	CUR_CTRL &= ~PARPORT_CONTROL_SELECT;
-
-	parport_write_control(pi->pardev->port, CUR_CTRL);
+	parport_frob_control(pi->pardev->port, PARPORT_CONTROL_SELECT, 0);
 
-	CUR_CTRL = (CUR_CTRL & port_int) | PARPORT_CONTROL_INIT;
-
-	parport_write_control(pi->pardev->port, CUR_CTRL);
+	parport_write_control(pi->pardev->port, PARPORT_CONTROL_INIT);
 
 	i = mode_map[pi->mode] & 0x0C;
 
@@ -138,15 +121,11 @@ static int ppc6_select(struct pi_adapter *pi)
 
 	parport_write_data(pi->pardev->port, i);
 
-	CUR_CTRL |= PARPORT_CONTROL_SELECT;
-
-	parport_write_control(pi->pardev->port, CUR_CTRL);
+	parport_frob_control(pi->pardev->port, PARPORT_CONTROL_SELECT, PARPORT_CONTROL_SELECT);
 
 	// DELAY
 
-	CUR_CTRL |= PARPORT_CONTROL_AUTOFD;
-
-	parport_write_control(pi->pardev->port, CUR_CTRL);
+	parport_frob_control(pi->pardev->port, PARPORT_CONTROL_AUTOFD, PARPORT_CONTROL_AUTOFD);
 
 	j = ((i & 0x08) << 4) | ((i & 0x07) << 3);
 
@@ -154,20 +133,18 @@ static int ppc6_select(struct pi_adapter *pi)
 
 	if (j == k)
 	{
-		CUR_CTRL &= ~PARPORT_CONTROL_AUTOFD;
-
-		parport_write_control(pi->pardev->port, CUR_CTRL);
+		parport_frob_control(pi->pardev->port, PARPORT_CONTROL_AUTOFD, 0);
 
 		k = (parport_read_status(pi->pardev->port) & 0xB8) ^ 0xB8;
 
 		if (j == k)
 		{
 			if (i & 4)	// EPP
-				CUR_CTRL &= ~(PARPORT_CONTROL_SELECT | PARPORT_CONTROL_INIT);
+				parport_frob_control(pi->pardev->port,
+					PARPORT_CONTROL_SELECT | PARPORT_CONTROL_INIT, 0);
 			else				// PPC/ECP
-				CUR_CTRL &= ~PARPORT_CONTROL_SELECT;
-
-			parport_write_control(pi->pardev->port, CUR_CTRL);
+				parport_frob_control(pi->pardev->port,
+					PARPORT_CONTROL_SELECT, 0);
 
 			return(1);
 		}
@@ -185,11 +162,11 @@ static int ppc6_select(struct pi_adapter *pi)
 static void ppc6_deselect(struct pi_adapter *pi)
 {
 	if (mode_map[pi->mode] & 4)	// EPP
-		CUR_CTRL |= PARPORT_CONTROL_INIT;
+		parport_frob_control(pi->pardev->port,
+			PARPORT_CONTROL_INIT, PARPORT_CONTROL_INIT);
 	else								// PPC/ECP
-		CUR_CTRL |= PARPORT_CONTROL_SELECT;
-
-	parport_write_control(pi->pardev->port, CUR_CTRL);
+		parport_frob_control(pi->pardev->port,
+			PARPORT_CONTROL_SELECT, PARPORT_CONTROL_SELECT);
 
 	parport_write_data(pi->pardev->port, pi->saved_r0);
 
@@ -210,10 +187,7 @@ static void ppc6_send_cmd(struct pi_adapter *pi, u8 cmd)
 		case PPCMODE_BI_FW :
 		{
 			parport_write_data(pi->pardev->port, cmd);
-
-			CUR_CTRL ^= PARPORT_CONTROL_AUTOFD;
-
-			parport_write_control(pi->pardev->port, CUR_CTRL);
+			parport_frob_control(pi->pardev->port, 0, PARPORT_CONTROL_AUTOFD);
 
 			break;
 		}
@@ -241,10 +215,7 @@ static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data)
 		case PPCMODE_BI_FW :
 		{
 			parport_write_data(pi->pardev->port, data);
-
-			CUR_CTRL ^= PARPORT_CONTROL_INIT;
-
-			parport_write_control(pi->pardev->port, CUR_CTRL);
+			parport_frob_control(pi->pardev->port, 0, PARPORT_CONTROL_INIT);
 
 			break;
 		}
@@ -271,9 +242,8 @@ static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
 		case PPCMODE_UNI_SW :
 		case PPCMODE_UNI_FW :
 		{
-			CUR_CTRL = (CUR_CTRL & ~PARPORT_CONTROL_STROBE) ^ PARPORT_CONTROL_INIT;
-
-			parport_write_control(pi->pardev->port, CUR_CTRL);
+			parport_frob_control(pi->pardev->port,
+				PARPORT_CONTROL_STROBE, PARPORT_CONTROL_INIT);
 
 			// DELAY
 
@@ -281,9 +251,8 @@ static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
 
 			data = ((data & 0x80) >> 1) | ((data & 0x38) >> 3);
 
-			CUR_CTRL |= PARPORT_CONTROL_STROBE;
-
-			parport_write_control(pi->pardev->port, CUR_CTRL);
+			parport_frob_control(pi->pardev->port,
+				PARPORT_CONTROL_STROBE, PARPORT_CONTROL_STROBE);
 
 			// DELAY
 
@@ -297,15 +266,12 @@ static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
 		{
 			parport_data_reverse(pi->pardev->port);
 
-			CUR_CTRL = (CUR_CTRL | PARPORT_CONTROL_STROBE) ^ PARPORT_CONTROL_INIT;
-
-			parport_write_control(pi->pardev->port, CUR_CTRL);
+			parport_frob_control(pi->pardev->port, PARPORT_CONTROL_STROBE,
+				PARPORT_CONTROL_STROBE | PARPORT_CONTROL_INIT);
 
 			data = parport_read_data(pi->pardev->port);
 
-			CUR_CTRL &= ~PARPORT_CONTROL_STROBE;
-
-			parport_write_control(pi->pardev->port, CUR_CTRL);
+			parport_frob_control(pi->pardev->port, PARPORT_CONTROL_STROBE, 0);
 
 			parport_data_forward(pi->pardev->port);
 
@@ -356,10 +322,8 @@ static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count)
 			{
 				u8 d;
 
-				CUR_CTRL = (CUR_CTRL & ~PARPORT_CONTROL_STROBE)
-							^ PARPORT_CONTROL_INIT;
-
-				parport_write_control(pi->pardev->port, CUR_CTRL);
+				parport_frob_control(pi->pardev->port,
+					PARPORT_CONTROL_STROBE, PARPORT_CONTROL_INIT);
 
 				// DELAY
 
@@ -367,9 +331,8 @@ static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count)
 
 				d = ((d & 0x80) >> 1) | ((d & 0x38) >> 3);
 
-				CUR_CTRL |= PARPORT_CONTROL_STROBE;
-
-				parport_write_control(pi->pardev->port, CUR_CTRL);
+				parport_frob_control(pi->pardev->port,
+					PARPORT_CONTROL_STROBE, PARPORT_CONTROL_STROBE);
 
 				// DELAY
 
@@ -387,21 +350,16 @@ static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count)
 		{
 			parport_data_reverse(pi->pardev->port);
 
-			CUR_CTRL |= PARPORT_CONTROL_STROBE;
-
 			while(count)
 			{
-				CUR_CTRL ^= PARPORT_CONTROL_INIT;
-
-				parport_write_control(pi->pardev->port, CUR_CTRL);
+				parport_frob_control(pi->pardev->port, PARPORT_CONTROL_STROBE,
+					PARPORT_CONTROL_STROBE | PARPORT_CONTROL_INIT);
 
 				*data++ = parport_read_data(pi->pardev->port);
 				count--;
 			}
 
-			CUR_CTRL &= ~PARPORT_CONTROL_STROBE;
-
-			parport_write_control(pi->pardev->port, CUR_CTRL);
+			parport_frob_control(pi->pardev->port, PARPORT_CONTROL_STROBE, 0);
 
 			parport_data_forward(pi->pardev->port);
 
@@ -467,9 +425,7 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 			{
 				parport_write_data(pi->pardev->port, *data++);
 
-				CUR_CTRL ^= PARPORT_CONTROL_INIT;
-
-				parport_write_control(pi->pardev->port, CUR_CTRL);
+				parport_frob_control(pi->pardev->port, 0, PARPORT_CONTROL_INIT);
 			}
 
 			break;
@@ -482,9 +438,8 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 
 			ppc6_send_cmd(pi, CMD_PREFIX_SET | PREFIX_FASTWR);
 
-			CUR_CTRL |= PARPORT_CONTROL_STROBE;
-
-			parport_write_control(pi->pardev->port, CUR_CTRL);
+			parport_frob_control(pi->pardev->port,
+				PARPORT_CONTROL_STROBE, PARPORT_CONTROL_STROBE);
 
 			last = *data;
 
@@ -497,9 +452,8 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 
 				if (this == last)
 				{
-					CUR_CTRL ^= PARPORT_CONTROL_INIT;
-
-					parport_write_control(pi->pardev->port, CUR_CTRL);
+					parport_frob_control(pi->pardev->port,
+						0, PARPORT_CONTROL_INIT);
 				}
 				else
 				{
@@ -509,9 +463,7 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 				}
 			}
 
-			CUR_CTRL &= ~PARPORT_CONTROL_STROBE;
-
-			parport_write_control(pi->pardev->port, CUR_CTRL);
+			parport_frob_control(pi->pardev->port, PARPORT_CONTROL_STROBE, 0);
 
 			ppc6_send_cmd(pi, CMD_PREFIX_RESET | PREFIX_FASTWR);
 
-- 
Ondrej Zary

