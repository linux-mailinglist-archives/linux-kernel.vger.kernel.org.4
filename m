Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A4B612BF8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 18:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJ3Re3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 13:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJ3Rdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 13:33:54 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D59895B4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 10:33:53 -0700 (PDT)
Received: from ipservice-092-217-067-184.092.217.pools.vodafone-ip.de ([92.217.67.184] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1opCBy-000469-8K; Sun, 30 Oct 2022 18:33:50 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 12/13] staging: r8188eu: rtw_action_public_decache's token is a u8
Date:   Sun, 30 Oct 2022 18:33:25 +0100
Message-Id: <20221030173326.1588647-13-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221030173326.1588647-1-martin@kaiser.cx>
References: <20221030173326.1588647-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both callers of rtw_action_public_decache pass a u8 value for the token
parameter. We can change token from s32 to u8 and remove the code for
token < 0.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index f5923792f067..93f3d387e92d 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -3490,7 +3490,7 @@ inline void issue_probereq_p2p(struct adapter *adapter, u8 *da)
 	_issue_probereq_p2p(adapter, da);
 }
 
-static s32 rtw_action_public_decache(struct recv_frame *recv_frame, s32 token)
+static s32 rtw_action_public_decache(struct recv_frame *recv_frame, u8 token)
 {
 	struct adapter *adapter = recv_frame->adapter;
 	struct mlme_ext_priv *mlmeext = &adapter->mlmeextpriv;
@@ -3499,21 +3499,13 @@ static s32 rtw_action_public_decache(struct recv_frame *recv_frame, s32 token)
 		(recv_frame->attrib.frag_num & 0xf);
 
 	if (GetRetry(frame)) {
-		if (token >= 0) {
-			if ((seq_ctrl == mlmeext->action_public_rxseq) &&
-			    (token == mlmeext->action_public_dialog_token))
-				return _FAIL;
-		} else {
-			if (seq_ctrl == mlmeext->action_public_rxseq)
-				return _FAIL;
-		}
+		if ((seq_ctrl == mlmeext->action_public_rxseq) &&
+		    (token == mlmeext->action_public_dialog_token))
+			return _FAIL;
 	}
 
 	mlmeext->action_public_rxseq = seq_ctrl;
-
-	if (token >= 0)
-		mlmeext->action_public_dialog_token = token;
-
+	mlmeext->action_public_dialog_token = token;
 	return _SUCCESS;
 }
 
-- 
2.30.2

