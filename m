Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23AB606831
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiJTSaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiJTS3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:29:47 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5CB220C3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:29:45 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j4so1002426lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s10DD2bi79V+xICsKZzl2wJQlQcRDXrwKveFEEfHFNU=;
        b=Qd5U4LiDXA6FuonSe3Y4QdQO30sUdfBCSDiezwfWqixsQ81peTxRnkcBkhgo18/HnS
         Fecne8UMUr8/wm/DVZgB5BqrxQaj/5K1+8Nk7oL8/YEP9FQTJF4BsEpESNdMgV/npoa9
         3rlvBgyS3S/hvOrlrpempdjEQIzHA/JnXq243e1i05vt6GRClKGaVmmyPU0H6YzclNQu
         O1NFckB1dt/2WqEf47XvSWsTtppo2nsXfTvQYpU3jf1uvlp8S2+V8RAGqfyZAc3p2DbM
         goebqfokRduLAbW8SaoyF9r7xEnzFEry8x0oPQASP5mUX2SOKUcC80g1PZx5wpOlbr1i
         rjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s10DD2bi79V+xICsKZzl2wJQlQcRDXrwKveFEEfHFNU=;
        b=R2PgooDM577nd5Be8YmsfausPp0xbELvtXsTn59Eujd9c9gwXxbrnvnpvSOWU3RFdK
         sETtDUBZpdTGwaLtbIUT7Em6fYI1tj7bgn1ucx/HADFkrKgFd3ZvFTrekIJJQLIsSqCu
         4qZAjGMe84hBHDf7Ys9UeziMISSSkYPTTCE9WakcTJJjaszy1NVfox3bcDAc7PIkRVii
         l9E5XzrfYmxpZLB40wmcM2IO4I1Ay2+KI6TxdSDHwjhLgou5FJotPSAXiiUnv2J9vEpV
         37SI3qycOe9nSUodyMztd+SsQMOqqSdF+nfQv6hOCULVdV6AsboUoFf6L/VhCs7oosI7
         p46g==
X-Gm-Message-State: ACrzQf1WAC7quZgWXPfQi0Pd5c52RYQW7FsbU6BG6jwsLlf5s3OUeBh0
        5giXblmasMndtLkL1lISzU/vRLH4tdrYgrQ5
X-Google-Smtp-Source: AMsMyM73Q8wIFXFHiDUNsnAoDrIilohOmQDGU70XZXMJFKoveJIa8SKAr4mAnY0rK6ny9g7ZEcUvHA==
X-Received: by 2002:a05:6512:487:b0:4a2:2977:3a83 with SMTP id v7-20020a056512048700b004a229773a83mr5476069lfq.88.1666290584010;
        Thu, 20 Oct 2022 11:29:44 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id h10-20020a0565123c8a00b00497a3e11608sm2797216lfv.303.2022.10.20.11.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 11:29:43 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     forest@alittletooquiet.net
Cc:     greg@kroah.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH 4/6] staging: vt6655: refactor long lines of code in s_vGenerateTxParameter
Date:   Thu, 20 Oct 2022 18:27:44 +0000
Message-Id: <03dd39114b1e5c029cd8022245403a079ff03ae7.1666288416.git.tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666288416.git.tanjubrunostar0@gmail.com>
References: <cover.1666288416.git.tanjubrunostar0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix checkpatch errors by refactoring long lines of code in the function: s_vGenerateTxParameter

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 70 ++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index dc853b83459b..42f4261293ba 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -839,7 +839,8 @@ s_vFillCTSHead(struct vnt_private *pDevice,
 	}
 
 	if (byPktType == PK_TYPE_11GB || byPktType == PK_TYPE_11GA) {
-		if (byFBOption != AUTO_FB_NONE && uDMAIdx != TYPE_ATIMDMA && uDMAIdx != TYPE_BEACONDMA) {
+		if (byFBOption != AUTO_FB_NONE && uDMAIdx !=
+		    TYPE_ATIMDMA && uDMAIdx != TYPE_BEACONDMA) {
 			/* Auto Fall back */
 			struct vnt_cts_fb *buf = pvCTS;
 			/* Get SignalField, ServiceField & Length */
@@ -878,7 +879,10 @@ s_vFillCTSHead(struct vnt_private *pDevice,
 
 			ether_addr_copy(buf->data.ra,
 					pDevice->abyCurrentNetAddr);
-		} else { /* if (byFBOption != AUTO_FB_NONE && uDMAIdx != TYPE_ATIMDMA && uDMAIdx != TYPE_BEACONDMA) */
+		} else {
+			/* if (byFBOption != AUTO_FB_NONE && uDMAIdx != TYPE_ATIMDMA &&
+			 * uDMAIdx != TYPE_BEACONDMA)
+			 */
 			struct vnt_cts *buf = pvCTS;
 			/* Get SignalField, ServiceField & Length */
 			vnt_get_phy_field(pDevice, uCTSFrameLen,
@@ -964,50 +968,72 @@ static void s_vGenerateTxParameter(struct vnt_private *pDevice,
 			/* Fill RsvTime */
 			struct vnt_rrv_time_rts *buf = pvRrvTime;
 
-			buf->rts_rrv_time_aa = get_rtscts_time(pDevice, 2, byPktType, cbFrameSize, wCurrentRate);
-			buf->rts_rrv_time_ba = get_rtscts_time(pDevice, 1, byPktType, cbFrameSize, wCurrentRate);
-			buf->rts_rrv_time_bb = get_rtscts_time(pDevice, 0, byPktType, cbFrameSize, wCurrentRate);
-			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
-			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
-
-			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
+			buf->rts_rrv_time_aa = get_rtscts_time(pDevice, 2, byPktType, cbFrameSize,
+							       wCurrentRate);
+			buf->rts_rrv_time_ba = get_rtscts_time(pDevice, 1, byPktType, cbFrameSize,
+							       wCurrentRate);
+			buf->rts_rrv_time_bb = get_rtscts_time(pDevice, 0, byPktType, cbFrameSize,
+							       wCurrentRate);
+			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize,
+								wCurrentRate, bNeedACK);
+			buf->rrv_time_b =
+				vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize,
+						      pDevice->byTopCCKBasicRate, bNeedACK);
+
+			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
+				       psEthHeader, wCurrentRate, byFBOption);
 		} else {/* RTS_needless, PCF mode */
 			struct vnt_rrv_time_cts *buf = pvRrvTime;
 
-			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
-			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
-			buf->cts_rrv_time_ba = get_rtscts_time(pDevice, 3, byPktType, cbFrameSize, wCurrentRate);
+			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize,
+								wCurrentRate, bNeedACK);
+			buf->rrv_time_b =
+				vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize,
+						      pDevice->byTopCCKBasicRate, bNeedACK);
+			buf->cts_rrv_time_ba = get_rtscts_time(pDevice, 3, byPktType, cbFrameSize,
+							       wCurrentRate);
 
 			/* Fill CTS */
-			s_vFillCTSHead(pDevice, uDMAIdx, byPktType, pvCTS, cbFrameSize, bNeedACK, bDisCRC, wCurrentRate, byFBOption);
+			s_vFillCTSHead(pDevice, uDMAIdx, byPktType, pvCTS, cbFrameSize, bNeedACK,
+				       bDisCRC, wCurrentRate, byFBOption);
 		}
 	} else if (byPktType == PK_TYPE_11A) {
 		if (pvRTS) {/* RTS_need, non PCF mode */
-			struct vnt_rrv_time_ab *buf = pvRrvTime;
+			struct vnt_rrv_time_ab *buf = pvRrvT
+				ime;
 
-			buf->rts_rrv_time = get_rtscts_time(pDevice, 2, byPktType, cbFrameSize, wCurrentRate);
-			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
+			buf->rts_rrv_time = get_rtscts_time(pDevice, 2, byPktType, cbFrameSize,
+							    wCurrentRate);
+			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize,
+							      wCurrentRate, bNeedACK);
 
 			/* Fill RTS */
-			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
+			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
+				       psEthHeader, wCurrentRate, byFBOption);
 		} else if (!pvRTS) {/* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
-			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11A, cbFrameSize, wCurrentRate, bNeedACK);
+			buf->rrv_time =
+				vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11A, cbFrameSize,
+						      wCurrentRate, bNeedACK);
 		}
 	} else if (byPktType == PK_TYPE_11B) {
 		if (pvRTS) {/* RTS_need, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
-			buf->rts_rrv_time = get_rtscts_time(pDevice, 0, byPktType, cbFrameSize, wCurrentRate);
-			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
+			buf->rts_rrv_time = get_rtscts_time(pDevice, 0, byPktType, cbFrameSize,
+							    wCurrentRate);
+			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize,
+							      wCurrentRate, bNeedACK);
 
 			/* Fill RTS */
-			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
+			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
+				       psEthHeader, wCurrentRate, byFBOption);
 		} else { /* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
-			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
+			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize,
+							      wCurrentRate, bNeedACK);
 		}
 	}
 }
-- 
2.34.1

