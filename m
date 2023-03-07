Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A266AF960
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjCGWrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjCGWrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:08 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68CEF93C8;
        Tue,  7 Mar 2023 14:47:01 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 2240E7A0708;
        Tue,  7 Mar 2023 23:46:49 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/32] pata_parport-bpck6: use parport access functions instead of port I/O
Date:   Tue,  7 Mar 2023 23:46:07 +0100
Message-Id: <20230307224627.28011-13-linux@zary.sk>
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

Use parport access functions instead of inb/outb/inw/outw/inl/outl.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c   |   1 -
 drivers/ata/pata_parport/ppc6lnx.c | 212 +++++++++--------------------
 2 files changed, 68 insertions(+), 145 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index dc0f71cc305e..39ac6e1a0aee 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -15,7 +15,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include <asm/io.h>
 #include <linux/parport.h>
 #include "pata_parport.h"
 #include "ppc6lnx.c"
diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
index 09480a7fcaee..89c40d6ab036 100644
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -17,7 +17,6 @@
 
 
 #define port_int					16
-#define port_dir					0x20
 
 #define ECR_EPP	0x80
 #define ECR_BI	0x20
@@ -106,65 +105,60 @@ static int ppc6_select(struct pi_adapter *pi)
 {
 	u8 i, j, k;
 
-	i = inb(pi->port + 1);
+	pi->saved_r0 = parport_read_data(pi->pardev->port);
 
-	if (i & 1)
-		outb(i, pi->port + 1);
-
-	pi->saved_r0 = inb(pi->port);
-
-	pi->saved_r2 = inb(pi->port + 2) & 0x5F; // readback ctrl
+	pi->saved_r2 = parport_read_control(pi->pardev->port) & 0x5F; // readback ctrl
 
 	CUR_CTRL = pi->saved_r2;
 
 	CUR_CTRL |= PARPORT_CONTROL_SELECT;
 
-	outb(CUR_CTRL, pi->port + 2);
+	parport_write_control(pi->pardev->port, CUR_CTRL);
 
 	if (pi->saved_r0 == 'b')
-		outb('x', pi->port);
+		parport_write_data(pi->pardev->port, 'x');
 
-	outb('b', pi->port);
-	outb('p', pi->port);
-	outb(pi->unit, pi->port);
-	outb(~pi->unit, pi->port);
+	parport_write_data(pi->pardev->port, 'b');
+	parport_write_data(pi->pardev->port, 'p');
+	parport_write_data(pi->pardev->port, pi->unit);
+	parport_write_data(pi->pardev->port, ~pi->unit);
 
 	CUR_CTRL &= ~PARPORT_CONTROL_SELECT;
 
-	outb(CUR_CTRL, pi->port + 2);
+	parport_write_control(pi->pardev->port, CUR_CTRL);
 
 	CUR_CTRL = (CUR_CTRL & port_int) | PARPORT_CONTROL_INIT;
 
-	outb(CUR_CTRL, pi->port + 2);
+	parport_write_control(pi->pardev->port, CUR_CTRL);
 
 	i = mode_map[pi->mode] & 0x0C;
 
 	if (i == 0)
 		i = (mode_map[pi->mode] & 2) | 1;
 
-	outb(i, pi->port);
+	parport_write_data(pi->pardev->port, i);
 
 	CUR_CTRL |= PARPORT_CONTROL_SELECT;
 
-	outb(CUR_CTRL, pi->port + 2);
+	parport_write_control(pi->pardev->port, CUR_CTRL);
 
 	// DELAY
 
 	CUR_CTRL |= PARPORT_CONTROL_AUTOFD;
 
-	outb(CUR_CTRL, pi->port + 2);
+	parport_write_control(pi->pardev->port, CUR_CTRL);
 
 	j = ((i & 0x08) << 4) | ((i & 0x07) << 3);
 
-	k = inb(pi->port + 1) & 0xB8;
+	k = parport_read_status(pi->pardev->port) & 0xB8;
 
 	if (j == k)
 	{
 		CUR_CTRL &= ~PARPORT_CONTROL_AUTOFD;
 
-		outb(CUR_CTRL, pi->port + 2);
+		parport_write_control(pi->pardev->port, CUR_CTRL);
 
-		k = (inb(pi->port + 1) & 0xB8) ^ 0xB8;
+		k = (parport_read_status(pi->pardev->port) & 0xB8) ^ 0xB8;
 
 		if (j == k)
 		{
@@ -173,15 +167,15 @@ static int ppc6_select(struct pi_adapter *pi)
 			else				// PPC/ECP
 				CUR_CTRL &= ~PARPORT_CONTROL_SELECT;
 
-			outb(CUR_CTRL, pi->port + 2);
+			parport_write_control(pi->pardev->port, CUR_CTRL);
 
 			return(1);
 		}
 	}
 
-	outb(pi->saved_r2, pi->port + 2);
+	parport_write_control(pi->pardev->port, pi->saved_r2);
 
-	outb(pi->saved_r0, pi->port);
+	parport_write_data(pi->pardev->port, pi->saved_r0);
 
 	return(0); // FAIL
 }
@@ -195,13 +189,13 @@ static void ppc6_deselect(struct pi_adapter *pi)
 	else								// PPC/ECP
 		CUR_CTRL |= PARPORT_CONTROL_SELECT;
 
-	outb(CUR_CTRL, pi->port + 2);
+	parport_write_control(pi->pardev->port, CUR_CTRL);
 
-	outb(pi->saved_r0, pi->port);
+	parport_write_data(pi->pardev->port, pi->saved_r0);
 
-	outb((pi->saved_r2 | PARPORT_CONTROL_SELECT), pi->port + 2);
+	parport_write_control(pi->pardev->port, (pi->saved_r2 | PARPORT_CONTROL_SELECT));
 
-	outb(pi->saved_r2, pi->port + 2);
+	parport_write_control(pi->pardev->port, pi->saved_r2);
 }
 
 //***************************************************************************
@@ -215,11 +209,11 @@ static void ppc6_send_cmd(struct pi_adapter *pi, u8 cmd)
 		case PPCMODE_BI_SW :
 		case PPCMODE_BI_FW :
 		{
-			outb(cmd, pi->port);
+			parport_write_data(pi->pardev->port, cmd);
 
 			CUR_CTRL ^= PARPORT_CONTROL_AUTOFD;
 
-			outb(CUR_CTRL, pi->port + 2);
+			parport_write_control(pi->pardev->port, CUR_CTRL);
 
 			break;
 		}
@@ -228,7 +222,7 @@ static void ppc6_send_cmd(struct pi_adapter *pi, u8 cmd)
 		case PPCMODE_EPP_WORD :
 		case PPCMODE_EPP_DWORD :
 		{
-			outb(cmd, pi->port + 3);
+			pi->pardev->port->ops->epp_write_addr(pi->pardev->port, &cmd, 1, 0);
 
 			break;
 		}
@@ -246,11 +240,11 @@ static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data)
 		case PPCMODE_BI_SW :
 		case PPCMODE_BI_FW :
 		{
-			outb(data, pi->port);
+			parport_write_data(pi->pardev->port, data);
 
 			CUR_CTRL ^= PARPORT_CONTROL_INIT;
 
-			outb(CUR_CTRL, pi->port + 2);
+			parport_write_control(pi->pardev->port, CUR_CTRL);
 
 			break;
 		}
@@ -259,7 +253,7 @@ static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data)
 		case PPCMODE_EPP_WORD :
 		case PPCMODE_EPP_DWORD :
 		{
-			outb(data, pi->port + 4);
+			pi->pardev->port->ops->epp_write_data(pi->pardev->port, &data, 1, 0);
 
 			break;
 		}
@@ -279,21 +273,21 @@ static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
 		{
 			CUR_CTRL = (CUR_CTRL & ~PARPORT_CONTROL_STROBE) ^ PARPORT_CONTROL_INIT;
 
-			outb(CUR_CTRL, pi->port + 2);
+			parport_write_control(pi->pardev->port, CUR_CTRL);
 
 			// DELAY
 
-			data = inb(pi->port + 1);
+			data = parport_read_status(pi->pardev->port);
 
 			data = ((data & 0x80) >> 1) | ((data & 0x38) >> 3);
 
 			CUR_CTRL |= PARPORT_CONTROL_STROBE;
 
-			outb(CUR_CTRL, pi->port + 2);
+			parport_write_control(pi->pardev->port, CUR_CTRL);
 
 			// DELAY
 
-			data |= inb(pi->port + 1) & 0xB8;
+			data |= parport_read_status(pi->pardev->port) & 0xB8;
 
 			break;
 		}
@@ -301,23 +295,19 @@ static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
 		case PPCMODE_BI_SW :
 		case PPCMODE_BI_FW :
 		{
-			CUR_CTRL |= port_dir;
-
-			outb(CUR_CTRL, pi->port + 2);
+			parport_data_reverse(pi->pardev->port);
 
 			CUR_CTRL = (CUR_CTRL | PARPORT_CONTROL_STROBE) ^ PARPORT_CONTROL_INIT;
 
-			outb(CUR_CTRL, pi->port + 2);
+			parport_write_control(pi->pardev->port, CUR_CTRL);
 
-			data = inb(pi->port);
+			data = parport_read_data(pi->pardev->port);
 
 			CUR_CTRL &= ~PARPORT_CONTROL_STROBE;
 
-			outb(CUR_CTRL, pi->port + 2);
-
-			CUR_CTRL &= ~port_dir;
+			parport_write_control(pi->pardev->port, CUR_CTRL);
 
-			outb(CUR_CTRL, pi->port + 2);
+			parport_data_forward(pi->pardev->port);
 
 			break;
 		}
@@ -326,11 +316,7 @@ static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
 		case PPCMODE_EPP_WORD :
 		case PPCMODE_EPP_DWORD :
 		{
-			outb((CUR_CTRL | port_dir), pi->port + 2);
-
-			data = inb(pi->port + 4);
-
-			outb(CUR_CTRL, pi->port + 2);
+			pi->pardev->port->ops->epp_read_data(pi->pardev->port, &data, 1, 0);
 
 			break;
 		}
@@ -373,21 +359,21 @@ static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count)
 				CUR_CTRL = (CUR_CTRL & ~PARPORT_CONTROL_STROBE)
 							^ PARPORT_CONTROL_INIT;
 
-				outb(CUR_CTRL, pi->port + 2);
+				parport_write_control(pi->pardev->port, CUR_CTRL);
 
 				// DELAY
 
-				d = inb(pi->port + 1);
+				d = parport_read_status(pi->pardev->port);
 
 				d = ((d & 0x80) >> 1) | ((d & 0x38) >> 3);
 
 				CUR_CTRL |= PARPORT_CONTROL_STROBE;
 
-				outb(CUR_CTRL, pi->port + 2);
+				parport_write_control(pi->pardev->port, CUR_CTRL);
 
 				// DELAY
 
-				d |= inb(pi->port + 1) & 0xB8;
+				d |= parport_read_status(pi->pardev->port) & 0xB8;
 
 				*data++ = d;
 				count--;
@@ -399,9 +385,7 @@ static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count)
 		case PPCMODE_BI_SW :
 		case PPCMODE_BI_FW :
 		{
-			CUR_CTRL |= port_dir;
-
-			outb(CUR_CTRL, pi->port + 2);
+			parport_data_reverse(pi->pardev->port);
 
 			CUR_CTRL |= PARPORT_CONTROL_STROBE;
 
@@ -409,84 +393,47 @@ static void ppc6_rd_data_blk(struct pi_adapter *pi, u8 *data, long count)
 			{
 				CUR_CTRL ^= PARPORT_CONTROL_INIT;
 
-				outb(CUR_CTRL, pi->port + 2);
+				parport_write_control(pi->pardev->port, CUR_CTRL);
 
-				*data++ = inb(pi->port);
+				*data++ = parport_read_data(pi->pardev->port);
 				count--;
 			}
 
 			CUR_CTRL &= ~PARPORT_CONTROL_STROBE;
 
-			outb(CUR_CTRL, pi->port + 2);
+			parport_write_control(pi->pardev->port, CUR_CTRL);
 
-			CUR_CTRL &= ~port_dir;
-
-			outb(CUR_CTRL, pi->port + 2);
+			parport_data_forward(pi->pardev->port);
 
 			break;
 		}
 
 		case PPCMODE_EPP_BYTE :
 		{
-			outb((CUR_CTRL | port_dir), pi->port + 2);
-
 			// DELAY
 
-			while(count)
-			{
-				*data++ = inb(pi->port + 4);
-				count--;
-			}
-
-			outb(CUR_CTRL, pi->port + 2);
+			pi->pardev->port->ops->epp_read_data(pi->pardev->port,
+					data, count, PARPORT_EPP_FAST_8);
 
 			break;
 		}
 
 		case PPCMODE_EPP_WORD :
 		{
-			outb((CUR_CTRL | port_dir), pi->port + 2);
-
 			// DELAY
 
-			while(count > 1)
-			{
-				*((u16 *)data) = inw(pi->port + 4);
-				data  += 2;
-				count -= 2;
-			}
-
-			while(count)
-			{
-				*data++ = inb(pi->port + 4);
-				count--;
-			}
-
-			outb(CUR_CTRL, pi->port + 2);
+			pi->pardev->port->ops->epp_read_data(pi->pardev->port,
+					data, count, PARPORT_EPP_FAST_16);
 
 			break;
 		}
 
 		case PPCMODE_EPP_DWORD :
 		{
-			outb((CUR_CTRL | port_dir), pi->port + 2);
-
 			// DELAY
 
-			while(count > 3)
-			{
-				*((u32 *)data) = inl(pi->port + 4);
-				data  += 4;
-				count -= 4;
-			}
-
-			while(count)
-			{
-				*data++ = inb(pi->port + 4);
-				count--;
-			}
-
-			outb(CUR_CTRL, pi->port + 2);
+			pi->pardev->port->ops->epp_read_data(pi->pardev->port,
+					data, count, PARPORT_EPP_FAST_32);
 
 			break;
 		}
@@ -503,7 +450,7 @@ static void ppc6_wait_for_fifo(struct pi_adapter *pi)
 	if (PPC_FLAGS & fifo_wait)
 	{
 		for(i=0; i<20; i++)
-			inb(pi->port + 1);
+			parport_read_status(pi->pardev->port);
 	}
 }
 
@@ -518,11 +465,11 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 		{
 			while(count--)
 			{
-				outb(*data++, pi->port);
+				parport_write_data(pi->pardev->port, *data++);
 
 				CUR_CTRL ^= PARPORT_CONTROL_INIT;
 
-				outb(CUR_CTRL, pi->port + 2);
+				parport_write_control(pi->pardev->port, CUR_CTRL);
 			}
 
 			break;
@@ -537,11 +484,11 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 
 			CUR_CTRL |= PARPORT_CONTROL_STROBE;
 
-			outb(CUR_CTRL, pi->port + 2);
+			parport_write_control(pi->pardev->port, CUR_CTRL);
 
 			last = *data;
 
-			outb(last, pi->port);
+			parport_write_data(pi->pardev->port, last);
 
 			while(count)
 			{
@@ -552,11 +499,11 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 				{
 					CUR_CTRL ^= PARPORT_CONTROL_INIT;
 
-					outb(CUR_CTRL, pi->port + 2);
+					parport_write_control(pi->pardev->port, CUR_CTRL);
 				}
 				else
 				{
-					outb(this, pi->port);
+					parport_write_data(pi->pardev->port, this);
 
 					last = this;
 				}
@@ -564,7 +511,7 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 
 			CUR_CTRL &= ~PARPORT_CONTROL_STROBE;
 
-			outb(CUR_CTRL, pi->port + 2);
+			parport_write_control(pi->pardev->port, CUR_CTRL);
 
 			ppc6_send_cmd(pi, CMD_PREFIX_RESET | PREFIX_FASTWR);
 
@@ -573,11 +520,8 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 
 		case PPCMODE_EPP_BYTE :
 		{
-			while(count)
-			{
-				outb(*data++, pi->port + 4);
-				count--;
-			}
+			pi->pardev->port->ops->epp_write_data(pi->pardev->port,
+					data, count, PARPORT_EPP_FAST_8);
 
 			ppc6_wait_for_fifo(pi);
 
@@ -586,18 +530,8 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 
 		case PPCMODE_EPP_WORD :
 		{
-			while(count > 1)
-			{
-				outw(*((u16 *)data), pi->port + 4);
-				data  += 2;
-				count -= 2;
-			}
-
-			while(count)
-			{
-				outb(*data++, pi->port + 4);
-				count--;
-			}
+			pi->pardev->port->ops->epp_write_data(pi->pardev->port,
+					data, count, PARPORT_EPP_FAST_16);
 
 			ppc6_wait_for_fifo(pi);
 
@@ -606,18 +540,8 @@ static void ppc6_wr_data_blk(struct pi_adapter *pi, u8 *data, long count)
 
 		case PPCMODE_EPP_DWORD :
 		{
-			while(count > 3)
-			{
-				outl(*((u32 *)data), pi->port + 4);
-				data  += 4;
-				count -= 4;
-			}
-
-			while(count)
-			{
-				outb(*data++, pi->port + 4);
-				count--;
-			}
+			pi->pardev->port->ops->epp_write_data(pi->pardev->port,
+					data, count, PARPORT_EPP_FAST_32);
 
 			ppc6_wait_for_fifo(pi);
 
-- 
Ondrej Zary

