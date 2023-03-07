Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7714B6AF95E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjCGWrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjCGWrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:07 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BC0A40D2;
        Tue,  7 Mar 2023 14:47:01 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id E14E37A06F8;
        Tue,  7 Mar 2023 23:46:48 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/32] pata_parport-bpck6: remove parallel port bit defines
Date:   Tue,  7 Mar 2023 23:46:05 +0100
Message-Id: <20230307224627.28011-11-linux@zary.sk>
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

Remove port_stb, port_afd, cmd_stb, port_init, data_stb and port_sel
defines and use standard PARPORT_CONTROL_* instead.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/ppc6lnx.c | 59 ++++++++++++++----------------
 1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
index ee8cee6bae7c..09480a7fcaee 100644
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -16,12 +16,6 @@
 //***************************************************************************
 
 
-#define port_stb					1
-#define port_afd					2
-#define cmd_stb						port_afd
-#define port_init					4
-#define data_stb					port_init
-#define port_sel					8
 #define port_int					16
 #define port_dir					0x20
 
@@ -123,7 +117,7 @@ static int ppc6_select(struct pi_adapter *pi)
 
 	CUR_CTRL = pi->saved_r2;
 
-	CUR_CTRL |= port_sel;
+	CUR_CTRL |= PARPORT_CONTROL_SELECT;
 
 	outb(CUR_CTRL, pi->port + 2);
 
@@ -135,11 +129,11 @@ static int ppc6_select(struct pi_adapter *pi)
 	outb(pi->unit, pi->port);
 	outb(~pi->unit, pi->port);
 
-	CUR_CTRL &= ~port_sel;
+	CUR_CTRL &= ~PARPORT_CONTROL_SELECT;
 
 	outb(CUR_CTRL, pi->port + 2);
 
-	CUR_CTRL = (CUR_CTRL & port_int) | port_init;
+	CUR_CTRL = (CUR_CTRL & port_int) | PARPORT_CONTROL_INIT;
 
 	outb(CUR_CTRL, pi->port + 2);
 
@@ -150,13 +144,13 @@ static int ppc6_select(struct pi_adapter *pi)
 
 	outb(i, pi->port);
 
-	CUR_CTRL |= port_sel;
+	CUR_CTRL |= PARPORT_CONTROL_SELECT;
 
 	outb(CUR_CTRL, pi->port + 2);
 
 	// DELAY
 
-	CUR_CTRL |= port_afd;
+	CUR_CTRL |= PARPORT_CONTROL_AUTOFD;
 
 	outb(CUR_CTRL, pi->port + 2);
 
@@ -166,7 +160,7 @@ static int ppc6_select(struct pi_adapter *pi)
 
 	if (j == k)
 	{
-		CUR_CTRL &= ~port_afd;
+		CUR_CTRL &= ~PARPORT_CONTROL_AUTOFD;
 
 		outb(CUR_CTRL, pi->port + 2);
 
@@ -175,9 +169,9 @@ static int ppc6_select(struct pi_adapter *pi)
 		if (j == k)
 		{
 			if (i & 4)	// EPP
-				CUR_CTRL &= ~(port_sel | port_init);
+				CUR_CTRL &= ~(PARPORT_CONTROL_SELECT | PARPORT_CONTROL_INIT);
 			else				// PPC/ECP
-				CUR_CTRL &= ~port_sel;
+				CUR_CTRL &= ~PARPORT_CONTROL_SELECT;
 
 			outb(CUR_CTRL, pi->port + 2);
 
@@ -197,15 +191,15 @@ static int ppc6_select(struct pi_adapter *pi)
 static void ppc6_deselect(struct pi_adapter *pi)
 {
 	if (mode_map[pi->mode] & 4)	// EPP
-		CUR_CTRL |= port_init;
+		CUR_CTRL |= PARPORT_CONTROL_INIT;
 	else								// PPC/ECP
-		CUR_CTRL |= port_sel;
+		CUR_CTRL |= PARPORT_CONTROL_SELECT;
 
 	outb(CUR_CTRL, pi->port + 2);
 
 	outb(pi->saved_r0, pi->port);
 
-	outb((pi->saved_r2 | port_sel), pi->port + 2);
+	outb((pi->saved_r2 | PARPORT_CONTROL_SELECT), pi->port + 2);
 
 	outb(pi->saved_r2, pi->port + 2);
 }
@@ -223,7 +217,7 @@ static void ppc6_send_cmd(struct pi_adapter *pi, u8 cmd)
 		{
 			outb(cmd, pi->port);
 
-			CUR_CTRL ^= cmd_stb;
+			CUR_CTRL ^= PARPORT_CONTROL_AUTOFD;
 
 			outb(CUR_CTRL, pi->port + 2);
 
@@ -254,7 +248,7 @@ static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data)
 		{
 			outb(data, pi->port);
 
-			CUR_CTRL ^= data_stb;
+			CUR_CTRL ^= PARPORT_CONTROL_INIT;
 
 			outb(CUR_CTRL, pi->port + 2);
 
@@ -283,7 +277,7 @@ static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
 		case PPCMODE_UNI_SW :
 		case PPCMODE_UNI_FW :
 		{
-			CUR_CTRL = (CUR_CTRL & ~port_stb) ^ data_stb;
+			CUR_CTRL = (CUR_CTRL & ~PARPORT_CONTROL_STROBE) ^ PARPORT_CONTROL_INIT;
 
 			outb(CUR_CTRL, pi->port + 2);
 
@@ -293,7 +287,7 @@ static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
 
 			data = ((data & 0x80) >> 1) | ((data & 0x38) >> 3);
 
-			CUR_CTRL |= port_stb;
+			CUR_CTRL |= PARPORT_CONTROL_STROBE;
 
 			outb(CUR_CTRL, pi->port + 2);
 
@@ -311,13 +305,13 @@ static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
 
 			outb(CUR_CTRL, pi->port + 2);
 
-			CUR_CTRL = (CUR_CTRL | port_stb) ^ data_stb;
+			CUR_CTRL = (CUR_CTRL | PARPORT_CONTROL_STROBE) ^ PARPORT_CONTROL_INIT;
 
 			outb(CUR_CTRL, pi->port + 2);
 
 			data = inb(pi->port);
 
-			CUR_CTRL &= ~port_stb;
+			CUR_CTRL &= ~PARPORT_CONTROL_STROBE;
 
 			outb(CUR_CTRL, pi->port + 2);
 
@@ -376,7 +370,8 @@ static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count)
 			{
 				u8 d;
 
-				CUR_CTRL = (CUR_CTRL & ~port_stb) ^ data_stb;
+				CUR_CTRL = (CUR_CTRL & ~PARPORT_CONTROL_STROBE)
+							^ PARPORT_CONTROL_INIT;
 
 				outb(CUR_CTRL, pi->port + 2);
 
@@ -386,7 +381,7 @@ static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count)
 
 				d = ((d & 0x80) >> 1) | ((d & 0x38) >> 3);
 
-				CUR_CTRL |= port_stb;
+				CUR_CTRL |= PARPORT_CONTROL_STROBE;
 
 				outb(CUR_CTRL, pi->port + 2);
 
@@ -408,11 +403,11 @@ static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count)
 
 			outb(CUR_CTRL, pi->port + 2);
 
-			CUR_CTRL |= port_stb;
+			CUR_CTRL |= PARPORT_CONTROL_STROBE;
 
 			while(count)
 			{
-				CUR_CTRL ^= data_stb;
+				CUR_CTRL ^= PARPORT_CONTROL_INIT;
 
 				outb(CUR_CTRL, pi->port + 2);
 
@@ -420,7 +415,7 @@ static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count)
 				count--;
 			}
 
-			CUR_CTRL &= ~port_stb;
+			CUR_CTRL &= ~PARPORT_CONTROL_STROBE;
 
 			outb(CUR_CTRL, pi->port + 2);
 
@@ -525,7 +520,7 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 			{
 				outb(*data++, pi->port);
 
-				CUR_CTRL ^= data_stb;
+				CUR_CTRL ^= PARPORT_CONTROL_INIT;
 
 				outb(CUR_CTRL, pi->port + 2);
 			}
@@ -540,7 +535,7 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 
 			ppc6_send_cmd(pi, CMD_PREFIX_SET | PREFIX_FASTWR);
 
-			CUR_CTRL |= port_stb;
+			CUR_CTRL |= PARPORT_CONTROL_STROBE;
 
 			outb(CUR_CTRL, pi->port + 2);
 
@@ -555,7 +550,7 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 
 				if (this == last)
 				{
-					CUR_CTRL ^= data_stb;
+					CUR_CTRL ^= PARPORT_CONTROL_INIT;
 
 					outb(CUR_CTRL, pi->port + 2);
 				}
@@ -567,7 +562,7 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 				}
 			}
 
-			CUR_CTRL &= ~port_stb;
+			CUR_CTRL &= ~PARPORT_CONTROL_STROBE;
 
 			outb(CUR_CTRL, pi->port + 2);
 
-- 
Ondrej Zary

