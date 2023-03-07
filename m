Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0156AF95D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjCGWr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjCGWrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:07 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D9E84EE4;
        Tue,  7 Mar 2023 14:47:00 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 5F2977A05BD;
        Tue,  7 Mar 2023 23:46:48 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/32] pata_parport-bpck6: remove lpt_addr from struct ppc_storage
Date:   Tue,  7 Mar 2023 23:46:00 +0100
Message-Id: <20230307224627.28011-6-linux@zary.sk>
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

lpt_addr duplicates pi->port. Remove it.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c   |   1 -
 drivers/ata/pata_parport/ppc6lnx.c | 153 ++++++++++++++---------------
 2 files changed, 76 insertions(+), 78 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index bc128a2c444e..50d313fc529e 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -78,7 +78,6 @@ static int bpck6_test_port(struct pi_adapter *pi)   /* check for 8-bit port */
 
 	/*copy over duplicate stuff.. initialize state info*/
 	ppc->ppc_id = pi->unit;
-	ppc->lpt_addr = pi->port;
 
 	/* look at the parport device to see what modes we can use */
 	if (pi->pardev->port->modes & PARPORT_MODE_EPP)
diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
index f12bb019fc61..c00e561cc833 100644
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -65,7 +65,6 @@
 //***************************************************************************
 
 struct ppc_storage {
-	u16	lpt_addr;				// LPT base address
 	u8	ppc_id;
 	u8	mode;						// operating mode
 					// 0 = PPC Uni SW
@@ -124,65 +123,65 @@ static int ppc6_select(struct pi_adapter *pi)
 	struct ppc_storage *ppc = (void *)(pi->private);
 	u8 i, j, k;
 
-	i = inb(ppc->lpt_addr + 1);
+	i = inb(pi->port + 1);
 
 	if (i & 1)
-		outb(i, ppc->lpt_addr + 1);
+		outb(i, pi->port + 1);
 
-	ppc->org_data = inb(ppc->lpt_addr);
+	ppc->org_data = inb(pi->port);
 
-	ppc->org_ctrl = inb(ppc->lpt_addr + 2) & 0x5F; // readback ctrl
+	ppc->org_ctrl = inb(pi->port + 2) & 0x5F; // readback ctrl
 
 	ppc->cur_ctrl = ppc->org_ctrl;
 
 	ppc->cur_ctrl |= port_sel;
 
-	outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+	outb(ppc->cur_ctrl, pi->port + 2);
 
 	if (ppc->org_data == 'b')
-		outb('x', ppc->lpt_addr);
+		outb('x', pi->port);
 
-	outb('b', ppc->lpt_addr);
-	outb('p', ppc->lpt_addr);
-	outb(ppc->ppc_id, ppc->lpt_addr);
-	outb(~ppc->ppc_id,ppc->lpt_addr);
+	outb('b', pi->port);
+	outb('p', pi->port);
+	outb(ppc->ppc_id, pi->port);
+	outb(~ppc->ppc_id, pi->port);
 
 	ppc->cur_ctrl &= ~port_sel;
 
-	outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+	outb(ppc->cur_ctrl, pi->port + 2);
 
 	ppc->cur_ctrl = (ppc->cur_ctrl & port_int) | port_init;
 
-	outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+	outb(ppc->cur_ctrl, pi->port + 2);
 
 	i = ppc->mode & 0x0C;
 
 	if (i == 0)
 		i = (ppc->mode & 2) | 1;
 
-	outb(i, ppc->lpt_addr);
+	outb(i, pi->port);
 
 	ppc->cur_ctrl |= port_sel;
 
-	outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+	outb(ppc->cur_ctrl, pi->port + 2);
 
 	// DELAY
 
 	ppc->cur_ctrl |= port_afd;
 
-	outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+	outb(ppc->cur_ctrl, pi->port + 2);
 
 	j = ((i & 0x08) << 4) | ((i & 0x07) << 3);
 
-	k = inb(ppc->lpt_addr + 1) & 0xB8;
+	k = inb(pi->port + 1) & 0xB8;
 
 	if (j == k)
 	{
 		ppc->cur_ctrl &= ~port_afd;
 
-		outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+		outb(ppc->cur_ctrl, pi->port + 2);
 
-		k = (inb(ppc->lpt_addr + 1) & 0xB8) ^ 0xB8;
+		k = (inb(pi->port + 1) & 0xB8) ^ 0xB8;
 
 		if (j == k)
 		{
@@ -191,15 +190,15 @@ static int ppc6_select(struct pi_adapter *pi)
 			else				// PPC/ECP
 				ppc->cur_ctrl &= ~port_sel;
 
-			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+			outb(ppc->cur_ctrl, pi->port + 2);
 
 			return(1);
 		}
 	}
 
-	outb(ppc->org_ctrl, ppc->lpt_addr + 2);
+	outb(ppc->org_ctrl, pi->port + 2);
 
-	outb(ppc->org_data, ppc->lpt_addr);
+	outb(ppc->org_data, pi->port);
 
 	return(0); // FAIL
 }
@@ -214,13 +213,13 @@ static void ppc6_deselect(struct pi_adapter *pi)
 	else								// PPC/ECP
 		ppc->cur_ctrl |= port_sel;
 
-	outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+	outb(ppc->cur_ctrl, pi->port + 2);
 
-	outb(ppc->org_data, ppc->lpt_addr);
+	outb(ppc->org_data, pi->port);
 
-	outb((ppc->org_ctrl | port_sel), ppc->lpt_addr + 2);
+	outb((ppc->org_ctrl | port_sel), pi->port + 2);
 
-	outb(ppc->org_ctrl, ppc->lpt_addr + 2);
+	outb(ppc->org_ctrl, pi->port + 2);
 }
 
 //***************************************************************************
@@ -235,11 +234,11 @@ static void ppc6_send_cmd(struct pi_adapter *pi, u8 cmd)
 		case PPCMODE_BI_SW :
 		case PPCMODE_BI_FW :
 		{
-			outb(cmd, ppc->lpt_addr);
+			outb(cmd, pi->port);
 
 			ppc->cur_ctrl ^= cmd_stb;
 
-			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+			outb(ppc->cur_ctrl, pi->port + 2);
 
 			break;
 		}
@@ -248,7 +247,7 @@ static void ppc6_send_cmd(struct pi_adapter *pi, u8 cmd)
 		case PPCMODE_EPP_WORD :
 		case PPCMODE_EPP_DWORD :
 		{
-			outb(cmd, ppc->lpt_addr + 3);
+			outb(cmd, pi->port + 3);
 
 			break;
 		}
@@ -267,11 +266,11 @@ static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data)
 		case PPCMODE_BI_SW :
 		case PPCMODE_BI_FW :
 		{
-			outb(data, ppc->lpt_addr);
+			outb(data, pi->port);
 
 			ppc->cur_ctrl ^= data_stb;
 
-			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+			outb(ppc->cur_ctrl, pi->port + 2);
 
 			break;
 		}
@@ -280,7 +279,7 @@ static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data)
 		case PPCMODE_EPP_WORD :
 		case PPCMODE_EPP_DWORD :
 		{
-			outb(data, ppc->lpt_addr + 4);
+			outb(data, pi->port + 4);
 
 			break;
 		}
@@ -301,21 +300,21 @@ static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
 		{
 			ppc->cur_ctrl = (ppc->cur_ctrl & ~port_stb) ^ data_stb;
 
-			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+			outb(ppc->cur_ctrl, pi->port + 2);
 
 			// DELAY
 
-			data = inb(ppc->lpt_addr + 1);
+			data = inb(pi->port + 1);
 
 			data = ((data & 0x80) >> 1) | ((data & 0x38) >> 3);
 
 			ppc->cur_ctrl |= port_stb;
 
-			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+			outb(ppc->cur_ctrl, pi->port + 2);
 
 			// DELAY
 
-			data |= inb(ppc->lpt_addr + 1) & 0xB8;
+			data |= inb(pi->port + 1) & 0xB8;
 
 			break;
 		}
@@ -325,21 +324,21 @@ static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
 		{
 			ppc->cur_ctrl |= port_dir;
 
-			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+			outb(ppc->cur_ctrl, pi->port + 2);
 
 			ppc->cur_ctrl = (ppc->cur_ctrl | port_stb) ^ data_stb;
 
-			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+			outb(ppc->cur_ctrl, pi->port + 2);
 
-			data = inb(ppc->lpt_addr);
+			data = inb(pi->port);
 
 			ppc->cur_ctrl &= ~port_stb;
 
-			outb(ppc->cur_ctrl,ppc->lpt_addr + 2);
+			outb(ppc->cur_ctrl, pi->port + 2);
 
 			ppc->cur_ctrl &= ~port_dir;
 
-			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+			outb(ppc->cur_ctrl, pi->port + 2);
 
 			break;
 		}
@@ -348,11 +347,11 @@ static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
 		case PPCMODE_EPP_WORD :
 		case PPCMODE_EPP_DWORD :
 		{
-			outb((ppc->cur_ctrl | port_dir),ppc->lpt_addr + 2);
+			outb((ppc->cur_ctrl | port_dir), pi->port + 2);
 
-			data = inb(ppc->lpt_addr + 4);
+			data = inb(pi->port + 4);
 
-			outb(ppc->cur_ctrl,ppc->lpt_addr + 2);
+			outb(ppc->cur_ctrl, pi->port + 2);
 
 			break;
 		}
@@ -395,21 +394,21 @@ static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count)
 
 				ppc->cur_ctrl = (ppc->cur_ctrl & ~port_stb) ^ data_stb;
 
-				outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+				outb(ppc->cur_ctrl, pi->port + 2);
 
 				// DELAY
 
-				d = inb(ppc->lpt_addr + 1);
+				d = inb(pi->port + 1);
 
 				d = ((d & 0x80) >> 1) | ((d & 0x38) >> 3);
 
 				ppc->cur_ctrl |= port_stb;
 
-				outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+				outb(ppc->cur_ctrl, pi->port + 2);
 
 				// DELAY
 
-				d |= inb(ppc->lpt_addr + 1) & 0xB8;
+				d |= inb(pi->port + 1) & 0xB8;
 
 				*data++ = d;
 				count--;
@@ -423,7 +422,7 @@ static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count)
 		{
 			ppc->cur_ctrl |= port_dir;
 
-			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+			outb(ppc->cur_ctrl, pi->port + 2);
 
 			ppc->cur_ctrl |= port_stb;
 
@@ -431,84 +430,84 @@ static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count)
 			{
 				ppc->cur_ctrl ^= data_stb;
 
-				outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+				outb(ppc->cur_ctrl, pi->port + 2);
 
-				*data++ = inb(ppc->lpt_addr);
+				*data++ = inb(pi->port);
 				count--;
 			}
 
 			ppc->cur_ctrl &= ~port_stb;
 
-			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+			outb(ppc->cur_ctrl, pi->port + 2);
 
 			ppc->cur_ctrl &= ~port_dir;
 
-			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+			outb(ppc->cur_ctrl, pi->port + 2);
 
 			break;
 		}
 
 		case PPCMODE_EPP_BYTE :
 		{
-			outb((ppc->cur_ctrl | port_dir), ppc->lpt_addr + 2);
+			outb((ppc->cur_ctrl | port_dir), pi->port + 2);
 
 			// DELAY
 
 			while(count)
 			{
-				*data++ = inb(ppc->lpt_addr + 4);
+				*data++ = inb(pi->port + 4);
 				count--;
 			}
 
-			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+			outb(ppc->cur_ctrl, pi->port + 2);
 
 			break;
 		}
 
 		case PPCMODE_EPP_WORD :
 		{
-			outb((ppc->cur_ctrl | port_dir), ppc->lpt_addr + 2);
+			outb((ppc->cur_ctrl | port_dir), pi->port + 2);
 
 			// DELAY
 
 			while(count > 1)
 			{
-				*((u16 *)data) = inw(ppc->lpt_addr + 4);
+				*((u16 *)data) = inw(pi->port + 4);
 				data  += 2;
 				count -= 2;
 			}
 
 			while(count)
 			{
-				*data++ = inb(ppc->lpt_addr + 4);
+				*data++ = inb(pi->port + 4);
 				count--;
 			}
 
-			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+			outb(ppc->cur_ctrl, pi->port + 2);
 
 			break;
 		}
 
 		case PPCMODE_EPP_DWORD :
 		{
-			outb((ppc->cur_ctrl | port_dir),ppc->lpt_addr + 2);
+			outb((ppc->cur_ctrl | port_dir), pi->port + 2);
 
 			// DELAY
 
 			while(count > 3)
 			{
-				*((u32 *)data) = inl(ppc->lpt_addr + 4);
+				*((u32 *)data) = inl(pi->port + 4);
 				data  += 4;
 				count -= 4;
 			}
 
 			while(count)
 			{
-				*data++ = inb(ppc->lpt_addr + 4);
+				*data++ = inb(pi->port + 4);
 				count--;
 			}
 
-			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+			outb(ppc->cur_ctrl, pi->port + 2);
 
 			break;
 		}
@@ -526,7 +525,7 @@ static void ppc6_wait_for_fifo(struct pi_adapter *pi)
 	if (ppc->ppc_flags & fifo_wait)
 	{
 		for(i=0; i<20; i++)
-			inb(ppc->lpt_addr + 1);
+			inb(pi->port + 1);
 	}
 }
 
@@ -542,11 +541,11 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 		{
 			while(count--)
 			{
-				outb(*data++, ppc->lpt_addr);
+				outb(*data++, pi->port);
 
 				ppc->cur_ctrl ^= data_stb;
 
-				outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+				outb(ppc->cur_ctrl, pi->port + 2);
 			}
 
 			break;
@@ -561,11 +560,11 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 
 			ppc->cur_ctrl |= port_stb;
 
-			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+			outb(ppc->cur_ctrl, pi->port + 2);
 
 			last = *data;
 
-			outb(last, ppc->lpt_addr);
+			outb(last, pi->port);
 
 			while(count)
 			{
@@ -576,11 +575,11 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 				{
 					ppc->cur_ctrl ^= data_stb;
 
-					outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+					outb(ppc->cur_ctrl, pi->port + 2);
 				}
 				else
 				{
-					outb(this, ppc->lpt_addr);
+					outb(this, pi->port);
 
 					last = this;
 				}
@@ -588,7 +587,7 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 
 			ppc->cur_ctrl &= ~port_stb;
 
-			outb(ppc->cur_ctrl, ppc->lpt_addr + 2);
+			outb(ppc->cur_ctrl, pi->port + 2);
 
 			ppc6_send_cmd(pi, CMD_PREFIX_RESET | PREFIX_FASTWR);
 
@@ -599,7 +598,7 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 		{
 			while(count)
 			{
-				outb(*data++,ppc->lpt_addr + 4);
+				outb(*data++, pi->port + 4);
 				count--;
 			}
 
@@ -612,14 +611,14 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 		{
 			while(count > 1)
 			{
-				outw(*((u16 *)data),ppc->lpt_addr + 4);
+				outw(*((u16 *)data), pi->port + 4);
 				data  += 2;
 				count -= 2;
 			}
 
 			while(count)
 			{
-				outb(*data++,ppc->lpt_addr + 4);
+				outb(*data++, pi->port + 4);
 				count--;
 			}
 
@@ -632,14 +631,14 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 		{
 			while(count > 3)
 			{
-				outl(*((u32 *)data),ppc->lpt_addr + 4);
+				outl(*((u32 *)data), pi->port + 4);
 				data  += 4;
 				count -= 4;
 			}
 
 			while(count)
 			{
-				outb(*data++,ppc->lpt_addr + 4);
+				outb(*data++, pi->port + 4);
 				count--;
 			}
 
-- 
Ondrej Zary

