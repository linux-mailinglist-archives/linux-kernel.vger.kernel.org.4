Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B3768D552
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjBGLVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjBGLVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:21:23 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B9CF77B;
        Tue,  7 Feb 2023 03:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1675768869; bh=zGU+arlaqHl8H8JmkChoKl3R8XiYU178ouOVJ7yBri4=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=j0Ts0K7sl/DRfP1JAvksdF41tyT8ja22LmeSXqSKaLTCo2OOQ96+3PGQ+q0ho+RnA
         p6wlmRwHVMk7Bp49EYAemk3z2SXO/6bipvE5/wIdLQRGHwsbMdRAixzRx8qv46ynK7
         UQCjVxfix+JpnSZN6jjPagqynfy6zPxlfOvAxfGs=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue,  7 Feb 2023 12:21:09 +0100 (CET)
X-EA-Auth: JdEyjehX13xsM6I0QcuYhxHvDE76Xzp20TM6Dd4gKHs/FjAVzVh9YqTZBicJbSZQev2B6fD8g71+3QNjoLYq4IwU7fslrFh7
Date:   Tue, 7 Feb 2023 16:51:01 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] scsi: FlashPoint: Replace arithmetic addition by bitwise OR
Message-ID: <Y+I0HXsHezZRtFOM@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding two bit-field mask values, an OR operation offers higher
performance over an arithmetic operation. So, convert such additions to
an OR based expressions.
Issue identified using orplus.cocci semantic patch script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/scsi/FlashPoint.c | 92 +++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 47 deletions(-)

diff --git a/drivers/scsi/FlashPoint.c b/drivers/scsi/FlashPoint.c
index 3d9c56ac8224..1ecd7bd5a4ab 100644
--- a/drivers/scsi/FlashPoint.c
+++ b/drivers/scsi/FlashPoint.c
@@ -415,8 +415,8 @@ typedef struct SCCBscam_info {
 
 #define  DISABLE_INT       BIT(7)	/*Do not interrupt at end of cmd. */
 
-#define  HOST_WRT_CMD      ((DISABLE_INT + XFER_HOST_DMA + XFER_HOST_AUTO + XFER_DMA_8BIT))
-#define  HOST_RD_CMD       ((DISABLE_INT + XFER_DMA_HOST + XFER_HOST_AUTO + XFER_DMA_8BIT))
+#define  HOST_WRT_CMD      ((DISABLE_INT | XFER_HOST_DMA | XFER_HOST_AUTO | XFER_DMA_8BIT))
+#define  HOST_RD_CMD       ((DISABLE_INT | XFER_DMA_HOST | XFER_HOST_AUTO | XFER_DMA_8BIT))
 
 #define  hp_host_addr_lo      0x1C
 #define  hp_host_addr_hmi     0x1E
@@ -1892,7 +1892,7 @@ static int FlashPoint_HandleInterrupt(void *pcard)
 					   (unsigned char)0x00);
 				WR_HARPOON(ioport + hp_fifowrite, i);
 				WR_HARPOON(ioport + hp_autostart_3,
-					   (AUTO_IMMED + TAG_STRT));
+					   (AUTO_IMMED | TAG_STRT));
 			}
 		}
 
@@ -2218,14 +2218,14 @@ static unsigned char FPT_sfm(u32 port, struct sccb *pCurrSCCB)
 
 	message = RD_HARPOON(port + hp_scsidata_0);
 
-	WR_HARPOON(port + hp_scsisig, SCSI_ACK + S_MSGI_PH);
+	WR_HARPOON(port + hp_scsisig, (SCSI_ACK | S_MSGI_PH));
 
 	if (TimeOutLoop > 20000)
 		message = 0x00;	/* force message byte = 0 if Time Out on Req */
 
 	if ((RDW_HARPOON((port + hp_intstat)) & PARITY) &&
 	    (RD_HARPOON(port + hp_addstat) & SCSI_PAR_ERR)) {
-		WR_HARPOON(port + hp_scsisig, (SCSI_ACK + S_ILL_PH));
+		WR_HARPOON(port + hp_scsisig, (SCSI_ACK | S_ILL_PH));
 		WR_HARPOON(port + hp_xferstat, 0);
 		WR_HARPOON(port + hp_fiforead, 0);
 		WR_HARPOON(port + hp_fifowrite, 0);
@@ -2252,12 +2252,12 @@ static unsigned char FPT_sfm(u32 port, struct sccb *pCurrSCCB)
 
 			RD_HARPOON(port + hp_scsidata_0);
 
-			WR_HARPOON(port + hp_scsisig, (SCSI_ACK + S_ILL_PH));
+			WR_HARPOON(port + hp_scsisig, (SCSI_ACK | S_ILL_PH));
 
 		} while (1);
 
 	}
-	WR_HARPOON(port + hp_scsisig, (SCSI_ACK + S_ILL_PH));
+	WR_HARPOON(port + hp_scsisig, (SCSI_ACK | S_ILL_PH));
 	WR_HARPOON(port + hp_xferstat, 0);
 	WR_HARPOON(port + hp_fiforead, 0);
 	WR_HARPOON(port + hp_fifowrite, 0);
@@ -2385,7 +2385,7 @@ static void FPT_ssel(u32 port, unsigned char p_card)
 
 		currSCCB->Sccb_scsimsg = TARGET_RESET;
 
-		WR_HARPOON(port + hp_autostart_3, (SELECT + SELCHK_STRT));
+		WR_HARPOON(port + hp_autostart_3, (SELECT | SELCHK_STRT));
 		auto_loaded = 1;
 		currSCCB->Sccb_scsistat = SELECT_BDR_ST;
 
@@ -2421,7 +2421,7 @@ static void FPT_ssel(u32 port, unsigned char p_card)
 			    (MPM_OP + AMSG_OUT + currSCCB->Sccb_tag));
 		WRW_HARPOON((port + SYNC_MSGS + 4), (BRH_OP + ALWAYS + NP));
 
-		WR_HARPOON(port + hp_autostart_3, (SELECT + SELCHK_STRT));
+		WR_HARPOON(port + hp_autostart_3, (SELECT | SELCHK_STRT));
 		auto_loaded = 1;
 
 	}
@@ -2457,7 +2457,7 @@ static void FPT_ssel(u32 port, unsigned char p_card)
 					     currSCCB->Sccb_idmsg));
 
 				WR_HARPOON(port + hp_autostart_3,
-					   (SELECT + SELCHK_STRT));
+					   (SELECT | SELCHK_STRT));
 
 				/* Setup our STATE so we know what happened when
 				   the wheels fall off. */
@@ -2506,7 +2506,7 @@ static void FPT_ssel(u32 port, unsigned char p_card)
 				currSCCB->Sccb_scsistat = SELECT_Q_ST;
 
 				WR_HARPOON(port + hp_autostart_3,
-					   (SELECT + SELCHK_STRT));
+					   (SELECT | SELCHK_STRT));
 			}
 		}
 
@@ -2521,7 +2521,7 @@ static void FPT_ssel(u32 port, unsigned char p_card)
 			currSCCB->Sccb_scsistat = SELECT_ST;
 
 			WR_HARPOON(port + hp_autostart_3,
-				   (SELECT + SELCHK_STRT));
+				   (SELECT | SELCHK_STRT));
 		}
 
 		theCCB = (unsigned char *)&currSCCB->Cdb[0];
@@ -2826,7 +2826,7 @@ static void FPT_SendMsg(u32 port, unsigned char message)
 
 		WR_HARPOON(port + hp_scsidata_0, message);
 
-		WR_HARPOON(port + hp_scsisig, (SCSI_ACK + S_ILL_PH));
+		WR_HARPOON(port + hp_scsisig, (SCSI_ACK | S_ILL_PH));
 
 		ACCEPT_MSG(port);
 
@@ -2874,7 +2874,7 @@ static void FPT_sdecm(unsigned char message, u32 port, unsigned char p_card)
 
 		ACCEPT_MSG(port);
 		WR_HARPOON(port + hp_autostart_1,
-			   (AUTO_IMMED + DISCONNECT_START));
+			   (AUTO_IMMED | DISCONNECT_START));
 	}
 
 	else if (message == COMMAND_COMPLETE) {
@@ -2895,7 +2895,7 @@ static void FPT_sdecm(unsigned char message, u32 port, unsigned char p_card)
 
 		ACCEPT_MSG(port);
 		WR_HARPOON(port + hp_autostart_1,
-			   (AUTO_IMMED + DISCONNECT_START));
+			   (AUTO_IMMED | DISCONNECT_START));
 	}
 
 	else if (message == MESSAGE_REJECT) {
@@ -2979,7 +2979,7 @@ static void FPT_sdecm(unsigned char message, u32 port, unsigned char p_card)
 				    ~(unsigned char)F_USE_CMD_Q;
 
 				WR_HARPOON(port + hp_autostart_1,
-					   (AUTO_IMMED + DISCONNECT_START));
+					   (AUTO_IMMED | DISCONNECT_START));
 
 			}
 		}
@@ -2994,7 +2994,7 @@ static void FPT_sdecm(unsigned char message, u32 port, unsigned char p_card)
 
 			if (!(RDW_HARPOON((port + hp_intstat)) & BUS_FREE)) {
 				WR_HARPOON(port + hp_autostart_1,
-					   (AUTO_IMMED + DISCONNECT_START));
+					   (AUTO_IMMED | DISCONNECT_START));
 			}
 		}
 	}
@@ -3014,7 +3014,7 @@ static void FPT_sdecm(unsigned char message, u32 port, unsigned char p_card)
 		if (currSCCB->Sccb_scsimsg != MSG_PARITY_ERROR)
 			ACCEPT_MSG(port);
 		WR_HARPOON(port + hp_autostart_1,
-			   (AUTO_IMMED + DISCONNECT_START));
+			   (AUTO_IMMED | DISCONNECT_START));
 	}
 
 	else {
@@ -3024,7 +3024,7 @@ static void FPT_sdecm(unsigned char message, u32 port, unsigned char p_card)
 
 		ACCEPT_MSG_ATN(port);
 		WR_HARPOON(port + hp_autostart_1,
-			   (AUTO_IMMED + DISCONNECT_START));
+			   (AUTO_IMMED | DISCONNECT_START));
 	}
 }
 
@@ -3069,27 +3069,25 @@ static void FPT_shandem(u32 port, unsigned char p_card, struct sccb *pCurrSCCB)
 					ACCEPT_MSG_ATN(port);
 
 					WR_HARPOON(port + hp_autostart_1,
-						   (AUTO_IMMED +
-						    DISCONNECT_START));
+						   (AUTO_IMMED | DISCONNECT_START));
 				}
 			} else {
 
 				pCurrSCCB->Sccb_scsimsg = MESSAGE_REJECT;
 				ACCEPT_MSG_ATN(port);
 
-				WR_HARPOON(port + hp_autostart_1,
-					   (AUTO_IMMED + DISCONNECT_START));
+				WR_HARPOON(port + hp_autostart_1, (AUTO_IMMED | DISCONNECT_START));
 			}
 		} else {
 			if (pCurrSCCB->Sccb_scsimsg != MSG_PARITY_ERROR)
 				ACCEPT_MSG(port);
 			WR_HARPOON(port + hp_autostart_1,
-				   (AUTO_IMMED + DISCONNECT_START));
+				   (AUTO_IMMED | DISCONNECT_START));
 		}
 	} else {
 		if (pCurrSCCB->Sccb_scsimsg == MSG_PARITY_ERROR)
 			WR_HARPOON(port + hp_autostart_1,
-				   (AUTO_IMMED + DISCONNECT_START));
+				   (AUTO_IMMED | DISCONNECT_START));
 	}
 }
 
@@ -3154,14 +3152,14 @@ static unsigned char FPT_sisyncn(u32 port, unsigned char p_card,
 
 		if (syncFlag == 0) {
 			WR_HARPOON(port + hp_autostart_3,
-				   (SELECT + SELCHK_STRT));
+				   (SELECT | SELCHK_STRT));
 			currTar_Info->TarStatus =
 			    ((currTar_Info->
 			      TarStatus & ~(unsigned char)TAR_SYNC_MASK) |
 			     (unsigned char)SYNC_TRYING);
 		} else {
 			WR_HARPOON(port + hp_autostart_3,
-				   (AUTO_IMMED + CMD_ONLY_STRT));
+				   (AUTO_IMMED | CMD_ONLY_STRT));
 		}
 
 		return 1;
@@ -3196,7 +3194,7 @@ static void FPT_stsyncn(u32 port, unsigned char p_card)
 
 	if ((sync_msg == 0x00) && (currSCCB->Sccb_scsimsg == MSG_PARITY_ERROR)) {
 		WR_HARPOON(port + hp_autostart_1,
-			   (AUTO_IMMED + DISCONNECT_START));
+			   (AUTO_IMMED | DISCONNECT_START));
 		return;
 	}
 
@@ -3206,7 +3204,7 @@ static void FPT_stsyncn(u32 port, unsigned char p_card)
 
 	if ((offset == 0x00) && (currSCCB->Sccb_scsimsg == MSG_PARITY_ERROR)) {
 		WR_HARPOON(port + hp_autostart_1,
-			   (AUTO_IMMED + DISCONNECT_START));
+			   (AUTO_IMMED | DISCONNECT_START));
 		return;
 	}
 
@@ -3290,7 +3288,7 @@ static void FPT_stsyncn(u32 port, unsigned char p_card)
 					   (unsigned char)SYNC_SUPPORTED);
 
 		WR_HARPOON(port + hp_autostart_1,
-			   (AUTO_IMMED + DISCONNECT_START));
+			   (AUTO_IMMED | DISCONNECT_START));
 	}
 
 	else {
@@ -3330,7 +3328,7 @@ static void FPT_sisyncr(u32 port, unsigned char sync_pulse,
 	WR_HARPOON(port + hp_portctrl_0, SCSI_PORT);
 	WRW_HARPOON((port + hp_intstat), CLR_ALL_INT_1);
 
-	WR_HARPOON(port + hp_autostart_3, (AUTO_IMMED + CMD_ONLY_STRT));
+	WR_HARPOON(port + hp_autostart_3, (AUTO_IMMED | CMD_ONLY_STRT));
 
 	while (!(RDW_HARPOON((port + hp_intstat)) & (BUS_FREE | AUTO_INT))) {
 	}
@@ -3372,7 +3370,7 @@ static unsigned char FPT_siwidn(u32 port, unsigned char p_card)
 			    (MPM_OP + AMSG_OUT + SM16BIT));
 		WRW_HARPOON((port + SYNC_MSGS + 10), (BRH_OP + ALWAYS + NP));
 
-		WR_HARPOON(port + hp_autostart_3, (SELECT + SELCHK_STRT));
+		WR_HARPOON(port + hp_autostart_3, (SELECT | SELCHK_STRT));
 
 		currTar_Info->TarStatus = ((currTar_Info->TarStatus &
 					    ~(unsigned char)TAR_WIDE_MASK) |
@@ -3413,7 +3411,7 @@ static void FPT_stwidn(u32 port, unsigned char p_card)
 
 	if ((width == 0x00) && (currSCCB->Sccb_scsimsg == MSG_PARITY_ERROR)) {
 		WR_HARPOON(port + hp_autostart_1,
-			   (AUTO_IMMED + DISCONNECT_START));
+			   (AUTO_IMMED | DISCONNECT_START));
 		return;
 	}
 
@@ -3445,7 +3443,7 @@ static void FPT_stwidn(u32 port, unsigned char p_card)
 		} else {
 			ACCEPT_MSG(port);
 			WR_HARPOON(port + hp_autostart_1,
-				   (AUTO_IMMED + DISCONNECT_START));
+				   (AUTO_IMMED | DISCONNECT_START));
 		}
 	}
 
@@ -3487,7 +3485,7 @@ static void FPT_siwidr(u32 port, unsigned char width)
 	WR_HARPOON(port + hp_portctrl_0, SCSI_PORT);
 	WRW_HARPOON((port + hp_intstat), CLR_ALL_INT_1);
 
-	WR_HARPOON(port + hp_autostart_3, (AUTO_IMMED + CMD_ONLY_STRT));
+	WR_HARPOON(port + hp_autostart_3, (AUTO_IMMED | CMD_ONLY_STRT));
 
 	while (!(RDW_HARPOON((port + hp_intstat)) & (BUS_FREE | AUTO_INT))) {
 	}
@@ -3751,7 +3749,7 @@ static void FPT_sxfrp(u32 p_port, unsigned char p_card)
 
 	if (!(RDW_HARPOON((p_port + hp_intstat)) & (BUS_FREE | RESET))) {
 		WR_HARPOON(p_port + hp_autostart_0,
-			   (AUTO_IMMED + DISCONNECT_START));
+			   (AUTO_IMMED | DISCONNECT_START));
 		while (!(RDW_HARPOON((p_port + hp_intstat)) & AUTO_INT)) {
 		}
 
@@ -3987,7 +3985,7 @@ static void FPT_phaseDataOut(u32 port, unsigned char p_card)
 
 	WRW_HARPOON((port + hp_intstat), XFER_CNT_0);
 
-	WR_HARPOON(port + hp_autostart_0, (END_DATA + END_DATA_START));
+	WR_HARPOON(port + hp_autostart_0, (END_DATA | END_DATA_START));
 
 	FPT_dataXferProcessor(port, &FPT_BL_Card[p_card]);
 
@@ -4030,7 +4028,7 @@ static void FPT_phaseDataIn(u32 port, unsigned char p_card)
 
 	WRW_HARPOON((port + hp_intstat), XFER_CNT_0);
 
-	WR_HARPOON(port + hp_autostart_0, (END_DATA + END_DATA_START));
+	WR_HARPOON(port + hp_autostart_0, (END_DATA | END_DATA_START));
 
 	FPT_dataXferProcessor(port, &FPT_BL_Card[p_card]);
 
@@ -4115,7 +4113,7 @@ static void FPT_phaseStatus(u32 port, unsigned char p_card)
 
 	WR_HARPOON(port + hp_scsisig, 0x00);
 
-	WR_HARPOON(port + hp_autostart_0, (AUTO_IMMED + END_DATA_START));
+	WR_HARPOON(port + hp_autostart_0, (AUTO_IMMED | END_DATA_START));
 }
 
 /*---------------------------------------------------------------------
@@ -4199,7 +4197,7 @@ static void FPT_phaseMsgOut(u32 port, unsigned char p_card)
 
 	WR_HARPOON(port + hp_scsidata_0, message);
 
-	WR_HARPOON(port + hp_scsisig, (SCSI_ACK + S_ILL_PH));
+	WR_HARPOON(port + hp_scsisig, (SCSI_ACK | S_ILL_PH));
 
 	ACCEPT_MSG(port);
 
@@ -4251,7 +4249,7 @@ static void FPT_phaseMsgOut(u32 port, unsigned char p_card)
 		if (message == MSG_PARITY_ERROR) {
 			currSCCB->Sccb_scsimsg = NOP;
 			WR_HARPOON(port + hp_autostart_1,
-				   (AUTO_IMMED + DISCONNECT_START));
+				   (AUTO_IMMED | DISCONNECT_START));
 		} else {
 			FPT_sxfrp(port, p_card);
 		}
@@ -4282,7 +4280,7 @@ static void FPT_phaseMsgIn(u32 port, unsigned char p_card)
 	if ((message == DISCONNECT) || (message == SAVE_POINTERS)) {
 
 		WR_HARPOON(port + hp_autostart_1,
-			   (AUTO_IMMED + END_DATA_START));
+			   (AUTO_IMMED | END_DATA_START));
 
 	}
 
@@ -4297,7 +4295,7 @@ static void FPT_phaseMsgIn(u32 port, unsigned char p_card)
 			if (currSCCB->Sccb_scsimsg != MSG_PARITY_ERROR)
 				ACCEPT_MSG(port);
 			WR_HARPOON(port + hp_autostart_1,
-				   (AUTO_IMMED + DISCONNECT_START));
+				   (AUTO_IMMED | DISCONNECT_START));
 		}
 	}
 
@@ -6134,7 +6132,7 @@ static unsigned char FPT_scsell(u32 p_port, unsigned char targ_id)
 		while (!(RDW_HARPOON((p_port + hp_intstat)) & BUS_FREE)) {
 			if (RD_HARPOON(p_port + hp_scsisig) & SCSI_REQ) {
 				WR_HARPOON(p_port + hp_scsisig,
-					   (SCSI_ACK + S_ILL_PH));
+					   (SCSI_ACK | S_ILL_PH));
 				ACCEPT_MSG(p_port);
 			}
 		}
@@ -7284,7 +7282,7 @@ static void FPT_utilEEWrite(u32 p_port, unsigned short ee_data,
 
 	FPT_utilEESendCmdAddr(p_port, EE_WRITE, ee_addr);
 
-	ee_value |= (SEE_MS + SEE_CS);
+	ee_value |= (SEE_MS | SEE_CS);
 
 	for (i = 0x8000; i != 0; i >>= 1) {
 
@@ -7364,7 +7362,7 @@ static unsigned short FPT_utilEEReadOrg(u32 p_port, unsigned short ee_addr)
 
 	FPT_utilEESendCmdAddr(p_port, EE_READ, ee_addr);
 
-	ee_value |= (SEE_MS + SEE_CS);
+	ee_value |= (SEE_MS | SEE_CS);
 	ee_data = 0;
 
 	for (i = 1; i <= 16; i++) {
@@ -7382,7 +7380,7 @@ static unsigned short FPT_utilEEReadOrg(u32 p_port, unsigned short ee_addr)
 			ee_data |= 1;
 	}
 
-	ee_value &= ~(SEE_MS + SEE_CS);
+	ee_value &= ~(SEE_MS | SEE_CS);
 	WR_HARPOON(p_port + hp_ee_ctrl, (ee_value | SEE_MS));	/*Turn off CS */
 	WR_HARPOON(p_port + hp_ee_ctrl, ee_value);	/*Turn off Master Select */
 
-- 
2.34.1



