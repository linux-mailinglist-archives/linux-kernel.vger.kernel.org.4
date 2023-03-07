Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7CC6AF94C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjCGWrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCGWrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:01 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E2A57288;
        Tue,  7 Mar 2023 14:46:49 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 3CBE07A05AB;
        Tue,  7 Mar 2023 23:46:48 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/32] pata_parport-bpck6: pass around struct pi_adapter *
Date:   Tue,  7 Mar 2023 23:45:59 +0100
Message-Id: <20230307224627.28011-5-linux@zary.sk>
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

Remove Interface typedef, pass around struct pi_adapter * down to all
functions instead. Remove PPCSTRUCT define.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c   |  43 ++++-----
 drivers/ata/pata_parport/ppc6lnx.c | 139 +++++++++++++++--------------
 2 files changed, 96 insertions(+), 86 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index fa1f7d4fe3cb..bc128a2c444e 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -18,67 +18,67 @@
 #include <linux/types.h>
 #include <asm/io.h>
 #include <linux/parport.h>
-#include "ppc6lnx.c"
 #include "pata_parport.h"
-
-#define PPCSTRUCT(pi) ((Interface *)(pi->private))
+#include "ppc6lnx.c"
 
 static int bpck6_read_regr(struct pi_adapter *pi, int cont, int reg)
 {
-	return ppc6_rd_port(PPCSTRUCT(pi), cont?reg|8:reg);
+	return ppc6_rd_port(pi, cont?reg|8:reg);
 }
 
 static void bpck6_write_regr(struct pi_adapter *pi, int cont, int reg, int val)
 {
-	ppc6_wr_port(PPCSTRUCT(pi), cont?reg|8:reg, val);
+	ppc6_wr_port(pi, cont?reg|8:reg, val);
 }
 
 static void bpck6_write_block(struct pi_adapter *pi, char *buf, int len)
 {
-	ppc6_wr_port16_blk(PPCSTRUCT(pi), ATA_REG_DATA, buf, (u32)len>>1);
+	ppc6_wr_port16_blk(pi, ATA_REG_DATA, buf, (u32)len>>1);
 }
 
 static void bpck6_read_block(struct pi_adapter *pi, char *buf, int len)
 {
-	ppc6_rd_port16_blk(PPCSTRUCT(pi), ATA_REG_DATA, buf, (u32)len>>1);
+	ppc6_rd_port16_blk(pi, ATA_REG_DATA, buf, (u32)len>>1);
 }
 
 static void bpck6_connect(struct pi_adapter *pi)
 {
+	struct ppc_storage *ppc = (void *)(pi->private);
 	dev_dbg(&pi->dev, "connect\n");
 
 	if(pi->mode >=2)
   	{
-		PPCSTRUCT(pi)->mode=4+pi->mode-2;	
+		ppc->mode = 4+pi->mode-2;
 	}
 	else if(pi->mode==1)
 	{
-		PPCSTRUCT(pi)->mode=3;	
+		ppc->mode = 3;
 	}
 	else
 	{
-		PPCSTRUCT(pi)->mode=1;		
+		ppc->mode = 1;
 	}
 
-	ppc6_open(PPCSTRUCT(pi));  
-	ppc6_wr_extout(PPCSTRUCT(pi),0x3);
+	ppc6_open(pi);
+	ppc6_wr_extout(pi, 0x3);
 }
 
 static void bpck6_disconnect(struct pi_adapter *pi)
 {
 	dev_dbg(&pi->dev, "disconnect\n");
-	ppc6_wr_extout(PPCSTRUCT(pi),0x0);
-	ppc6_close(PPCSTRUCT(pi));
+	ppc6_wr_extout(pi, 0x0);
+	ppc6_close(pi);
 }
 
 static int bpck6_test_port(struct pi_adapter *pi)   /* check for 8-bit port */
 {
+	struct ppc_storage *ppc = (void *)(pi->private);
 	dev_dbg(&pi->dev, "PARPORT indicates modes=%x for lp=0x%lx\n",
 		pi->pardev->port->modes, pi->pardev->port->base);
 
 	/*copy over duplicate stuff.. initialize state info*/
-	PPCSTRUCT(pi)->ppc_id=pi->unit;
-	PPCSTRUCT(pi)->lpt_addr=pi->port;
+	ppc->ppc_id = pi->unit;
+	ppc->lpt_addr = pi->port;
 
 	/* look at the parport device to see what modes we can use */
 	if (pi->pardev->port->modes & PARPORT_MODE_EPP)
@@ -90,23 +90,24 @@ static int bpck6_test_port(struct pi_adapter *pi)   /* check for 8-bit port */
 
 static int bpck6_probe_unit(struct pi_adapter *pi)
 {
+	struct ppc_storage *ppc = (void *)(pi->private);
 	int out;
 
 	dev_dbg(&pi->dev, "PROBE UNIT %x on port:%x\n", pi->unit, pi->port);
 
 	/*SET PPC UNIT NUMBER*/
-	PPCSTRUCT(pi)->ppc_id=pi->unit;
+	ppc->ppc_id = pi->unit;
 
 	/*LOWER DOWN TO UNIDIRECTIONAL*/
-	PPCSTRUCT(pi)->mode=1;		
+	ppc->mode = 1;
 
-	out=ppc6_open(PPCSTRUCT(pi));
+	out = ppc6_open(pi);
 
 	dev_dbg(&pi->dev, "ppc_open returned %2x\n", out);
 
   	if(out)
  	{
-		ppc6_close(PPCSTRUCT(pi));
+		ppc6_close(pi);
 		dev_dbg(&pi->dev, "leaving probe\n");
                return(1);
 	}
@@ -128,7 +129,7 @@ static void bpck6_log_adapter(struct pi_adapter *pi)
 
 static int bpck6_init_proto(struct pi_adapter *pi)
 {
-	Interface *p = kzalloc(sizeof(Interface), GFP_KERNEL);
+	struct ppc_storage *p = kzalloc(sizeof(struct ppc_storage), GFP_KERNEL);
 
 	if (p) {
 		pi->private = (unsigned long)p;
diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
index 5e5521d3b1dd..f12bb019fc61 100644
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -64,7 +64,7 @@
 
 //***************************************************************************
 
-typedef struct ppc_storage {
+struct ppc_storage {
 	u16	lpt_addr;				// LPT base address
 	u8	ppc_id;
 	u8	mode;						// operating mode
@@ -79,7 +79,7 @@ typedef struct ppc_storage {
 	u8	org_data;				// original LPT data port contents
 	u8	org_ctrl;				// original LPT control port contents
 	u8	cur_ctrl;				// current control port contents
-} Interface;
+};
 
 //***************************************************************************
 
@@ -101,26 +101,27 @@ typedef struct ppc_storage {
 
 //***************************************************************************
 
-static int ppc6_select(Interface *ppc);
-static void ppc6_deselect(Interface *ppc);
-static void ppc6_send_cmd(Interface *ppc, u8 cmd);
-static void ppc6_wr_data_byte(Interface *ppc, u8 data);
-static u8 ppc6_rd_data_byte(Interface *ppc);
-static u8 ppc6_rd_port(Interface *ppc, u8 port);
-static void ppc6_wr_port(Interface *ppc, u8 port, u8 data);
-static void ppc6_rd_data_blk(Interface *ppc, u8 *data, long count);
-static void ppc6_wait_for_fifo(Interface *ppc);
-static void ppc6_wr_data_blk(Interface *ppc, u8 *data, long count);
-static void ppc6_rd_port16_blk(Interface *ppc, u8 port, u8 *data, long length);
-static void ppc6_wr_port16_blk(Interface *ppc, u8 port, u8 *data, long length);
-static void ppc6_wr_extout(Interface *ppc, u8 regdata);
-static int ppc6_open(Interface *ppc);
-static void ppc6_close(Interface *ppc);
+static int ppc6_select(struct pi_adapter *pi);
+static void ppc6_deselect(struct pi_adapter *pi);
+static void ppc6_send_cmd(struct pi_adapter *pi, u8 cmd);
+static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data);
+static u8 ppc6_rd_data_byte(struct pi_adapter *pi);
+static u8 ppc6_rd_port(struct pi_adapter *pi, u8 port);
+static void ppc6_wr_port(struct pi_adapter *pi, u8 port, u8 data);
+static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count);
+static void ppc6_wait_for_fifo(struct pi_adapter *pi);
+static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count);
+static void ppc6_rd_port16_blk(struct pi_adapter *pi, u8 port, u8 *data, long length);
+static void ppc6_wr_port16_blk(struct pi_adapter *pi, u8 port, u8 *data, long length);
+static void ppc6_wr_extout(struct pi_adapter *pi, u8 regdata);
+static int ppc6_open(struct pi_adapter *pi);
+static void ppc6_close(struct pi_adapter *pi);
 
 //***************************************************************************
 
-static int ppc6_select(Interface *ppc)
+static int ppc6_select(struct pi_adapter *pi)
 {
+	struct ppc_storage *ppc = (void *)(pi->private);
 	u8 i, j, k;
 
 	i = inb(ppc->lpt_addr + 1);
@@ -205,8 +206,9 @@ static int ppc6_select(Interface *ppc)
 
 //***************************************************************************
 
-static void ppc6_deselect(Interface *ppc)
+static void ppc6_deselect(struct pi_adapter *pi)
 {
+	struct ppc_storage *ppc = (void *)(pi->private);
 	if (ppc->mode & 4)	// EPP
 		ppc->cur_ctrl |= port_init;
 	else								// PPC/ECP
@@ -223,8 +225,9 @@ static void ppc6_deselect(Interface *ppc)
 
 //***************************************************************************
 
-static void ppc6_send_cmd(Interface *ppc, u8 cmd)
+static void ppc6_send_cmd(struct pi_adapter *pi, u8 cmd)
 {
+	struct ppc_storage *ppc = (void *)(pi->private);
 	switch(ppc->mode)
 	{
 		case PPCMODE_UNI_SW :
@@ -254,8 +257,9 @@ static void ppc6_send_cmd(Interface *ppc, u8 cmd)
 
 //***************************************************************************
 
-static void ppc6_wr_data_byte(Interface *ppc, u8 data)
+static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data)
 {
+	struct ppc_storage *ppc = (void *)(pi->private);
 	switch(ppc->mode)
 	{
 		case PPCMODE_UNI_SW :
@@ -285,8 +289,9 @@ static void ppc6_wr_data_byte(Interface *ppc, u8 data)
 
 //***************************************************************************
 
-static u8 ppc6_rd_data_byte(Interface *ppc)
+static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
 {
+	struct ppc_storage *ppc = (void *)(pi->private);
 	u8 data = 0;
 
 	switch(ppc->mode)
@@ -358,26 +363,27 @@ static u8 ppc6_rd_data_byte(Interface *ppc)
 
 //***************************************************************************
 
-static u8 ppc6_rd_port(Interface *ppc, u8 port)
+static u8 ppc6_rd_port(struct pi_adapter *pi, u8 port)
 {
-	ppc6_send_cmd(ppc,(u8)(port | ACCESS_PORT | ACCESS_READ));
+	ppc6_send_cmd(pi, port | ACCESS_PORT | ACCESS_READ);
 
-	return(ppc6_rd_data_byte(ppc));
+	return ppc6_rd_data_byte(pi);
 }
 
 //***************************************************************************
 
-static void ppc6_wr_port(Interface *ppc, u8 port, u8 data)
+static void ppc6_wr_port(struct pi_adapter *pi, u8 port, u8 data)
 {
-	ppc6_send_cmd(ppc,(u8)(port | ACCESS_PORT | ACCESS_WRITE));
+	ppc6_send_cmd(pi, port | ACCESS_PORT | ACCESS_WRITE);
 
-	ppc6_wr_data_byte(ppc, data);
+	ppc6_wr_data_byte(pi, data);
 }
 
 //***************************************************************************
 
-static void ppc6_rd_data_blk(Interface *ppc, u8 *data, long count)
+static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count)
 {
+	struct ppc_storage *ppc = (void *)(pi->private);
 	switch(ppc->mode)
 	{
 		case PPCMODE_UNI_SW :
@@ -512,8 +518,9 @@ static void ppc6_rd_data_blk(Interface *ppc, u8 *data, long count)
 
 //***************************************************************************
 
-static void ppc6_wait_for_fifo(Interface *ppc)
+static void ppc6_wait_for_fifo(struct pi_adapter *pi)
 {
+	struct ppc_storage *ppc = (void *)(pi->private);
 	int i;
 
 	if (ppc->ppc_flags & fifo_wait)
@@ -525,8 +532,9 @@ static void ppc6_wait_for_fifo(Interface *ppc)
 
 //***************************************************************************
 
-static void ppc6_wr_data_blk(Interface *ppc, u8 *data, long count)
+static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 {
+	struct ppc_storage *ppc = (void *)(pi->private);
 	switch(ppc->mode)
 	{
 		case PPCMODE_UNI_SW :
@@ -549,7 +557,7 @@ static void ppc6_wr_data_blk(Interface *ppc, u8 *data, long count)
 		{
 			u8 this, last;
 
-			ppc6_send_cmd(ppc,(CMD_PREFIX_SET | PREFIX_FASTWR));
+			ppc6_send_cmd(pi, CMD_PREFIX_SET | PREFIX_FASTWR);
 
 			ppc->cur_ctrl |= port_stb;
 
@@ -582,7 +590,7 @@ static void ppc6_wr_data_blk(Interface *ppc, u8 *data, long count)
 
 			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
 
-			ppc6_send_cmd(ppc,(CMD_PREFIX_RESET | PREFIX_FASTWR));
+			ppc6_send_cmd(pi, CMD_PREFIX_RESET | PREFIX_FASTWR);
 
 			break;
 		}
@@ -595,7 +603,7 @@ static void ppc6_wr_data_blk(Interface *ppc, u8 *data, long count)
 				count--;
 			}
 
-			ppc6_wait_for_fifo(ppc);
+			ppc6_wait_for_fifo(pi);
 
 			break;
 		}
@@ -615,7 +623,7 @@ static void ppc6_wr_data_blk(Interface *ppc, u8 *data, long count)
 				count--;
 			}
 
-			ppc6_wait_for_fifo(ppc);
+			ppc6_wait_for_fifo(pi);
 
 			break;
 		}
@@ -635,7 +643,7 @@ static void ppc6_wr_data_blk(Interface *ppc, u8 *data, long count)
 				count--;
 			}
 
-			ppc6_wait_for_fifo(ppc);
+			ppc6_wait_for_fifo(pi);
 
 			break;
 		}
@@ -644,72 +652,73 @@ static void ppc6_wr_data_blk(Interface *ppc, u8 *data, long count)
 
 //***************************************************************************
 
-static void ppc6_rd_port16_blk(Interface *ppc, u8 port, u8 *data, long length)
+static void ppc6_rd_port16_blk(struct pi_adapter *pi, u8 port, u8 *data, long length)
 {
 	length = length << 1;
 
-	ppc6_send_cmd(ppc, (REG_BLKSIZE | ACCESS_REG | ACCESS_WRITE));
-	ppc6_wr_data_byte(ppc,(u8)length);
-	ppc6_wr_data_byte(ppc,(u8)(length >> 8));
-	ppc6_wr_data_byte(ppc,0);
+	ppc6_send_cmd(pi, REG_BLKSIZE | ACCESS_REG | ACCESS_WRITE);
+	ppc6_wr_data_byte(pi, (u8)length);
+	ppc6_wr_data_byte(pi, (u8)(length >> 8));
+	ppc6_wr_data_byte(pi, 0);
 
-	ppc6_send_cmd(ppc, (CMD_PREFIX_SET | PREFIX_IO16 | PREFIX_BLK));
+	ppc6_send_cmd(pi, CMD_PREFIX_SET | PREFIX_IO16 | PREFIX_BLK);
 
-	ppc6_send_cmd(ppc, (u8)(port | ACCESS_PORT | ACCESS_READ));
+	ppc6_send_cmd(pi, port | ACCESS_PORT | ACCESS_READ);
 
-	ppc6_rd_data_blk(ppc, data, length);
+	ppc6_rd_data_blk(pi, data, length);
 
-	ppc6_send_cmd(ppc, (CMD_PREFIX_RESET | PREFIX_IO16 | PREFIX_BLK));
+	ppc6_send_cmd(pi, CMD_PREFIX_RESET | PREFIX_IO16 | PREFIX_BLK);
 }
 
 //***************************************************************************
 
-static void ppc6_wr_port16_blk(Interface *ppc, u8 port, u8 *data, long length)
+static void ppc6_wr_port16_blk(struct pi_adapter *pi, u8 port, u8 *data, long length)
 {
 	length = length << 1;
 
-	ppc6_send_cmd(ppc, (REG_BLKSIZE | ACCESS_REG | ACCESS_WRITE));
-	ppc6_wr_data_byte(ppc,(u8)length);
-	ppc6_wr_data_byte(ppc,(u8)(length >> 8));
-	ppc6_wr_data_byte(ppc,0);
+	ppc6_send_cmd(pi, REG_BLKSIZE | ACCESS_REG | ACCESS_WRITE);
+	ppc6_wr_data_byte(pi, (u8)length);
+	ppc6_wr_data_byte(pi, (u8)(length >> 8));
+	ppc6_wr_data_byte(pi, 0);
 
-	ppc6_send_cmd(ppc, (CMD_PREFIX_SET | PREFIX_IO16 | PREFIX_BLK));
+	ppc6_send_cmd(pi, CMD_PREFIX_SET | PREFIX_IO16 | PREFIX_BLK);
 
-	ppc6_send_cmd(ppc, (u8)(port | ACCESS_PORT | ACCESS_WRITE));
+	ppc6_send_cmd(pi, port | ACCESS_PORT | ACCESS_WRITE);
 
-	ppc6_wr_data_blk(ppc, data, length);
+	ppc6_wr_data_blk(pi, data, length);
 
-	ppc6_send_cmd(ppc, (CMD_PREFIX_RESET | PREFIX_IO16 | PREFIX_BLK));
+	ppc6_send_cmd(pi, CMD_PREFIX_RESET | PREFIX_IO16 | PREFIX_BLK);
 }
 
 //***************************************************************************
 
-static void ppc6_wr_extout(Interface *ppc, u8 regdata)
+static void ppc6_wr_extout(struct pi_adapter *pi, u8 regdata)
 {
-	ppc6_send_cmd(ppc,(REG_VERSION | ACCESS_REG | ACCESS_WRITE));
+	ppc6_send_cmd(pi, REG_VERSION | ACCESS_REG | ACCESS_WRITE);
 
-	ppc6_wr_data_byte(ppc, (u8)((regdata & 0x03) << 6));
+	ppc6_wr_data_byte(pi, (u8)((regdata & 0x03) << 6));
 }
 
 //***************************************************************************
 
-static int ppc6_open(Interface *ppc)
+static int ppc6_open(struct pi_adapter *pi)
 {
+	struct ppc_storage *ppc = (void *)(pi->private);
 	int ret;
 
-	ret = ppc6_select(ppc);
+	ret = ppc6_select(pi);
 
 	if (ret == 0)
 		return(ret);
 
 	ppc->ppc_flags &= ~fifo_wait;
 
-	ppc6_send_cmd(ppc, (ACCESS_REG | ACCESS_WRITE | REG_RAMSIZE));
-	ppc6_wr_data_byte(ppc, RAMSIZE_128K);
+	ppc6_send_cmd(pi, ACCESS_REG | ACCESS_WRITE | REG_RAMSIZE);
+	ppc6_wr_data_byte(pi, RAMSIZE_128K);
 
-	ppc6_send_cmd(ppc, (ACCESS_REG | ACCESS_READ | REG_VERSION));
+	ppc6_send_cmd(pi, ACCESS_REG | ACCESS_READ | REG_VERSION);
 
-	if ((ppc6_rd_data_byte(ppc) & 0x3F) == 0x0C)
+	if ((ppc6_rd_data_byte(pi) & 0x3F) == 0x0C)
 		ppc->ppc_flags |= fifo_wait;
 
 	return(ret);
@@ -717,9 +726,9 @@ static int ppc6_open(Interface *ppc)
 
 //***************************************************************************
 
-static void ppc6_close(Interface *ppc)
+static void ppc6_close(struct pi_adapter *pi)
 {
-	ppc6_deselect(ppc);
+	ppc6_deselect(pi);
 }
 
 //***************************************************************************
-- 
Ondrej Zary

