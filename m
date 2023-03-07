Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C4E6AF964
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjCGWsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjCGWrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:11 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3E47136DA;
        Tue,  7 Mar 2023 14:47:01 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id CC22D7A06F6;
        Tue,  7 Mar 2023 23:46:48 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/32] pata_parport-bpck6: remove struct ppc_storage
Date:   Tue,  7 Mar 2023 23:46:04 +0100
Message-Id: <20230307224627.28011-10-linux@zary.sk>
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

Store the remaining two variables (cur_ctrl and ppc_flags) in struct
ppc_storage directly in pi->private and remove struct ppc_storage.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c   |  21 ----
 drivers/ata/pata_parport/ppc6lnx.c | 149 +++++++++++++----------------
 2 files changed, 69 insertions(+), 101 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index fe97d1dee51c..dc0f71cc305e 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/slab.h>
 #include <linux/types.h>
 #include <asm/io.h>
 #include <linux/parport.h>
@@ -107,24 +106,6 @@ static void bpck6_log_adapter(struct pi_adapter *pi)
 		pi->unit, pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
-static int bpck6_init_proto(struct pi_adapter *pi)
-{
-	struct ppc_storage *p = kzalloc(sizeof(struct ppc_storage), GFP_KERNEL);
-
-	if (p) {
-		pi->private = (unsigned long)p;
-		return 0;
-	}
-
-	dev_err(&pi->dev, "ERROR COULDN'T ALLOCATE MEMORY\n");
-	return -1;
-}
-
-static void bpck6_release_proto(struct pi_adapter *pi)
-{
-	kfree((void *)(pi->private)); 
-}
-
 static struct pi_protocol bpck6 = {
 	.owner		= THIS_MODULE,
 	.name		= "bpck6",
@@ -140,8 +121,6 @@ static struct pi_protocol bpck6 = {
 	.test_port	= bpck6_test_port,
 	.probe_unit	= bpck6_probe_unit,
 	.log_adapter	= bpck6_log_adapter,
-	.init_proto	= bpck6_init_proto,
-	.release_proto	= bpck6_release_proto,
 };
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
index 75f9748d8de5..ee8cee6bae7c 100644
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -64,10 +64,8 @@
 
 //***************************************************************************
 
-struct ppc_storage {
-	u8	ppc_flags;
-	u8	cur_ctrl;				// current control port contents
-};
+#define CUR_CTRL	(((u8 *)&pi->private)[0])
+#define PPC_FLAGS	(((u8 *)&pi->private)[1])
 
 //***************************************************************************
 
@@ -112,7 +110,6 @@ int mode_map[] = { PPCMODE_UNI_FW, PPCMODE_BI_FW, PPCMODE_EPP_BYTE,
 
 static int ppc6_select(struct pi_adapter *pi)
 {
-	struct ppc_storage *ppc = (void *)(pi->private);
 	u8 i, j, k;
 
 	i = inb(pi->port + 1);
@@ -124,11 +121,11 @@ static int ppc6_select(struct pi_adapter *pi)
 
 	pi->saved_r2 = inb(pi->port + 2) & 0x5F; // readback ctrl
 
-	ppc->cur_ctrl = pi->saved_r2;
+	CUR_CTRL = pi->saved_r2;
 
-	ppc->cur_ctrl |= port_sel;
+	CUR_CTRL |= port_sel;
 
-	outb(ppc->cur_ctrl, pi->port + 2);
+	outb(CUR_CTRL, pi->port + 2);
 
 	if (pi->saved_r0 == 'b')
 		outb('x', pi->port);
@@ -138,13 +135,13 @@ static int ppc6_select(struct pi_adapter *pi)
 	outb(pi->unit, pi->port);
 	outb(~pi->unit, pi->port);
 
-	ppc->cur_ctrl &= ~port_sel;
+	CUR_CTRL &= ~port_sel;
 
-	outb(ppc->cur_ctrl, pi->port + 2);
+	outb(CUR_CTRL, pi->port + 2);
 
-	ppc->cur_ctrl = (ppc->cur_ctrl & port_int) | port_init;
+	CUR_CTRL = (CUR_CTRL & port_int) | port_init;
 
-	outb(ppc->cur_ctrl, pi->port + 2);
+	outb(CUR_CTRL, pi->port + 2);
 
 	i = mode_map[pi->mode] & 0x0C;
 
@@ -153,15 +150,15 @@ static int ppc6_select(struct pi_adapter *pi)
 
 	outb(i, pi->port);
 
-	ppc->cur_ctrl |= port_sel;
+	CUR_CTRL |= port_sel;
 
-	outb(ppc->cur_ctrl, pi->port + 2);
+	outb(CUR_CTRL, pi->port + 2);
 
 	// DELAY
 
-	ppc->cur_ctrl |= port_afd;
+	CUR_CTRL |= port_afd;
 
-	outb(ppc->cur_ctrl, pi->port + 2);
+	outb(CUR_CTRL, pi->port + 2);
 
 	j = ((i & 0x08) << 4) | ((i & 0x07) << 3);
 
@@ -169,20 +166,20 @@ static int ppc6_select(struct pi_adapter *pi)
 
 	if (j == k)
 	{
-		ppc->cur_ctrl &= ~port_afd;
+		CUR_CTRL &= ~port_afd;
 
-		outb(ppc->cur_ctrl, pi->port + 2);
+		outb(CUR_CTRL, pi->port + 2);
 
 		k = (inb(pi->port + 1) & 0xB8) ^ 0xB8;
 
 		if (j == k)
 		{
 			if (i & 4)	// EPP
-				ppc->cur_ctrl &= ~(port_sel | port_init);
+				CUR_CTRL &= ~(port_sel | port_init);
 			else				// PPC/ECP
-				ppc->cur_ctrl &= ~port_sel;
+				CUR_CTRL &= ~port_sel;
 
-			outb(ppc->cur_ctrl, pi->port + 2);
+			outb(CUR_CTRL, pi->port + 2);
 
 			return(1);
 		}
@@ -199,13 +196,12 @@ static int ppc6_select(struct pi_adapter *pi)
 
 static void ppc6_deselect(struct pi_adapter *pi)
 {
-	struct ppc_storage *ppc = (void *)(pi->private);
 	if (mode_map[pi->mode] & 4)	// EPP
-		ppc->cur_ctrl |= port_init;
+		CUR_CTRL |= port_init;
 	else								// PPC/ECP
-		ppc->cur_ctrl |= port_sel;
+		CUR_CTRL |= port_sel;
 
-	outb(ppc->cur_ctrl, pi->port + 2);
+	outb(CUR_CTRL, pi->port + 2);
 
 	outb(pi->saved_r0, pi->port);
 
@@ -218,7 +214,6 @@ static void ppc6_deselect(struct pi_adapter *pi)
 
 static void ppc6_send_cmd(struct pi_adapter *pi, u8 cmd)
 {
-	struct ppc_storage *ppc = (void *)(pi->private);
 	switch (mode_map[pi->mode])
 	{
 		case PPCMODE_UNI_SW :
@@ -228,9 +223,9 @@ static void ppc6_send_cmd(struct pi_adapter *pi, u8 cmd)
 		{
 			outb(cmd, pi->port);
 
-			ppc->cur_ctrl ^= cmd_stb;
+			CUR_CTRL ^= cmd_stb;
 
-			outb(ppc->cur_ctrl, pi->port + 2);
+			outb(CUR_CTRL, pi->port + 2);
 
 			break;
 		}
@@ -250,7 +245,6 @@ static void ppc6_send_cmd(struct pi_adapter *pi, u8 cmd)
 
 static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data)
 {
-	struct ppc_storage *ppc = (void *)(pi->private);
 	switch (mode_map[pi->mode])
 	{
 		case PPCMODE_UNI_SW :
@@ -260,9 +254,9 @@ static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data)
 		{
 			outb(data, pi->port);
 
-			ppc->cur_ctrl ^= data_stb;
+			CUR_CTRL ^= data_stb;
 
-			outb(ppc->cur_ctrl, pi->port + 2);
+			outb(CUR_CTRL, pi->port + 2);
 
 			break;
 		}
@@ -282,7 +276,6 @@ static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data)
 
 static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
 {
-	struct ppc_storage *ppc = (void *)(pi->private);
 	u8 data = 0;
 
 	switch (mode_map[pi->mode])
@@ -290,9 +283,9 @@ static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
 		case PPCMODE_UNI_SW :
 		case PPCMODE_UNI_FW :
 		{
-			ppc->cur_ctrl = (ppc->cur_ctrl & ~port_stb) ^ data_stb;
+			CUR_CTRL = (CUR_CTRL & ~port_stb) ^ data_stb;
 
-			outb(ppc->cur_ctrl, pi->port + 2);
+			outb(CUR_CTRL, pi->port + 2);
 
 			// DELAY
 
@@ -300,9 +293,9 @@ static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
 
 			data = ((data & 0x80) >> 1) | ((data & 0x38) >> 3);
 
-			ppc->cur_ctrl |= port_stb;
+			CUR_CTRL |= port_stb;
 
-			outb(ppc->cur_ctrl, pi->port + 2);
+			outb(CUR_CTRL, pi->port + 2);
 
 			// DELAY
 
@@ -314,23 +307,23 @@ static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
 		case PPCMODE_BI_SW :
 		case PPCMODE_BI_FW :
 		{
-			ppc->cur_ctrl |= port_dir;
+			CUR_CTRL |= port_dir;
 
-			outb(ppc->cur_ctrl, pi->port + 2);
+			outb(CUR_CTRL, pi->port + 2);
 
-			ppc->cur_ctrl = (ppc->cur_ctrl | port_stb) ^ data_stb;
+			CUR_CTRL = (CUR_CTRL | port_stb) ^ data_stb;
 
-			outb(ppc->cur_ctrl, pi->port + 2);
+			outb(CUR_CTRL, pi->port + 2);
 
 			data = inb(pi->port);
 
-			ppc->cur_ctrl &= ~port_stb;
+			CUR_CTRL &= ~port_stb;
 
-			outb(ppc->cur_ctrl, pi->port + 2);
+			outb(CUR_CTRL, pi->port + 2);
 
-			ppc->cur_ctrl &= ~port_dir;
+			CUR_CTRL &= ~port_dir;
 
-			outb(ppc->cur_ctrl, pi->port + 2);
+			outb(CUR_CTRL, pi->port + 2);
 
 			break;
 		}
@@ -339,11 +332,11 @@ static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
 		case PPCMODE_EPP_WORD :
 		case PPCMODE_EPP_DWORD :
 		{
-			outb((ppc->cur_ctrl | port_dir), pi->port + 2);
+			outb((CUR_CTRL | port_dir), pi->port + 2);
 
 			data = inb(pi->port + 4);
 
-			outb(ppc->cur_ctrl, pi->port + 2);
+			outb(CUR_CTRL, pi->port + 2);
 
 			break;
 		}
@@ -374,7 +367,6 @@ static void ppc6_wr_port(struct pi_adapter *pi, u8 port, u8 data)
 
 static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count)
 {
-	struct ppc_storage *ppc = (void *)(pi->private);
 	switch (mode_map[pi->mode])
 	{
 		case PPCMODE_UNI_SW :
@@ -384,9 +376,9 @@ static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count)
 			{
 				u8 d;
 
-				ppc->cur_ctrl = (ppc->cur_ctrl & ~port_stb) ^ data_stb;
+				CUR_CTRL = (CUR_CTRL & ~port_stb) ^ data_stb;
 
-				outb(ppc->cur_ctrl, pi->port + 2);
+				outb(CUR_CTRL, pi->port + 2);
 
 				// DELAY
 
@@ -394,9 +386,9 @@ static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count)
 
 				d = ((d & 0x80) >> 1) | ((d & 0x38) >> 3);
 
-				ppc->cur_ctrl |= port_stb;
+				CUR_CTRL |= port_stb;
 
-				outb(ppc->cur_ctrl, pi->port + 2);
+				outb(CUR_CTRL, pi->port + 2);
 
 				// DELAY
 
@@ -412,36 +404,36 @@ static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count)
 		case PPCMODE_BI_SW :
 		case PPCMODE_BI_FW :
 		{
-			ppc->cur_ctrl |= port_dir;
+			CUR_CTRL |= port_dir;
 
-			outb(ppc->cur_ctrl, pi->port + 2);
+			outb(CUR_CTRL, pi->port + 2);
 
-			ppc->cur_ctrl |= port_stb;
+			CUR_CTRL |= port_stb;
 
 			while(count)
 			{
-				ppc->cur_ctrl ^= data_stb;
+				CUR_CTRL ^= data_stb;
 
-				outb(ppc->cur_ctrl, pi->port + 2);
+				outb(CUR_CTRL, pi->port + 2);
 
 				*data++ = inb(pi->port);
 				count--;
 			}
 
-			ppc->cur_ctrl &= ~port_stb;
+			CUR_CTRL &= ~port_stb;
 
-			outb(ppc->cur_ctrl, pi->port + 2);
+			outb(CUR_CTRL, pi->port + 2);
 
-			ppc->cur_ctrl &= ~port_dir;
+			CUR_CTRL &= ~port_dir;
 
-			outb(ppc->cur_ctrl, pi->port + 2);
+			outb(CUR_CTRL, pi->port + 2);
 
 			break;
 		}
 
 		case PPCMODE_EPP_BYTE :
 		{
-			outb((ppc->cur_ctrl | port_dir), pi->port + 2);
+			outb((CUR_CTRL | port_dir), pi->port + 2);
 
 			// DELAY
 
@@ -451,14 +443,14 @@ static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count)
 				count--;
 			}
 
-			outb(ppc->cur_ctrl, pi->port + 2);
+			outb(CUR_CTRL, pi->port + 2);
 
 			break;
 		}
 
 		case PPCMODE_EPP_WORD :
 		{
-			outb((ppc->cur_ctrl | port_dir), pi->port + 2);
+			outb((CUR_CTRL | port_dir), pi->port + 2);
 
 			// DELAY
 
@@ -475,14 +467,14 @@ static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count)
 				count--;
 			}
 
-			outb(ppc->cur_ctrl, pi->port + 2);
+			outb(CUR_CTRL, pi->port + 2);
 
 			break;
 		}
 
 		case PPCMODE_EPP_DWORD :
 		{
-			outb((ppc->cur_ctrl | port_dir), pi->port + 2);
+			outb((CUR_CTRL | port_dir), pi->port + 2);
 
 			// DELAY
 
@@ -499,7 +491,7 @@ static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count)
 				count--;
 			}
 
-			outb(ppc->cur_ctrl, pi->port + 2);
+			outb(CUR_CTRL, pi->port + 2);
 
 			break;
 		}
@@ -511,10 +503,9 @@ static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count)
 
 static void ppc6_wait_for_fifo(struct pi_adapter *pi)
 {
-	struct ppc_storage *ppc = (void *)(pi->private);
 	int i;
 
-	if (ppc->ppc_flags & fifo_wait)
+	if (PPC_FLAGS & fifo_wait)
 	{
 		for(i=0; i<20; i++)
 			inb(pi->port + 1);
@@ -525,7 +516,6 @@ static void ppc6_wait_for_fifo(struct pi_adapter *pi)
 
 static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 {
-	struct ppc_storage *ppc = (void *)(pi->private);
 	switch (mode_map[pi->mode])
 	{
 		case PPCMODE_UNI_SW :
@@ -535,9 +525,9 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 			{
 				outb(*data++, pi->port);
 
-				ppc->cur_ctrl ^= data_stb;
+				CUR_CTRL ^= data_stb;
 
-				outb(ppc->cur_ctrl, pi->port + 2);
+				outb(CUR_CTRL, pi->port + 2);
 			}
 
 			break;
@@ -550,9 +540,9 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 
 			ppc6_send_cmd(pi, CMD_PREFIX_SET | PREFIX_FASTWR);
 
-			ppc->cur_ctrl |= port_stb;
+			CUR_CTRL |= port_stb;
 
-			outb(ppc->cur_ctrl, pi->port + 2);
+			outb(CUR_CTRL, pi->port + 2);
 
 			last = *data;
 
@@ -565,9 +555,9 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 
 				if (this == last)
 				{
-					ppc->cur_ctrl ^= data_stb;
+					CUR_CTRL ^= data_stb;
 
-					outb(ppc->cur_ctrl, pi->port + 2);
+					outb(CUR_CTRL, pi->port + 2);
 				}
 				else
 				{
@@ -577,9 +567,9 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 				}
 			}
 
-			ppc->cur_ctrl &= ~port_stb;
+			CUR_CTRL &= ~port_stb;
 
-			outb(ppc->cur_ctrl, pi->port + 2);
+			outb(CUR_CTRL, pi->port + 2);
 
 			ppc6_send_cmd(pi, CMD_PREFIX_RESET | PREFIX_FASTWR);
 
@@ -694,7 +684,6 @@ static void ppc6_wr_extout(struct pi_adapter *pi, u8 regdata)
 
 static int ppc6_open(struct pi_adapter *pi)
 {
-	struct ppc_storage *ppc = (void *)(pi->private);
 	int ret;
 
 	ret = ppc6_select(pi);
@@ -702,7 +691,7 @@ static int ppc6_open(struct pi_adapter *pi)
 	if (ret == 0)
 		return(ret);
 
-	ppc->ppc_flags &= ~fifo_wait;
+	PPC_FLAGS &= ~fifo_wait;
 
 	ppc6_send_cmd(pi, ACCESS_REG | ACCESS_WRITE | REG_RAMSIZE);
 	ppc6_wr_data_byte(pi, RAMSIZE_128K);
@@ -710,7 +699,7 @@ static int ppc6_open(struct pi_adapter *pi)
 	ppc6_send_cmd(pi, ACCESS_REG | ACCESS_READ | REG_VERSION);
 
 	if ((ppc6_rd_data_byte(pi) & 0x3F) == 0x0C)
-		ppc->ppc_flags |= fifo_wait;
+		PPC_FLAGS |= fifo_wait;
 
 	return(ret);
 }
-- 
Ondrej Zary

