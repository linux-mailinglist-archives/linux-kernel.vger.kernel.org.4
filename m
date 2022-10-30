Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18980612BF1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 18:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJ3ReK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 13:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJ3Rdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 13:33:51 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4F4A44E
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 10:33:49 -0700 (PDT)
Received: from ipservice-092-217-067-184.092.217.pools.vodafone-ip.de ([92.217.67.184] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1opCBu-000469-Et; Sun, 30 Oct 2022 18:33:46 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 07/13] staging: r8188eu: replace switch-case with if
Date:   Sun, 30 Oct 2022 18:33:20 +0100
Message-Id: <20221030173326.1588647-8-martin@kaiser.cx>
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

OnAction_p2p has a switch-case statement where only a single case is
handled. Use if instead, this makes the code shorter and easier to read.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index efcb2f3b6d3f..64d01da9c814 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -3852,19 +3852,8 @@ static void OnAction_p2p(struct adapter *padapter, struct recv_frame *precv_fram
 	len -= sizeof(struct ieee80211_hdr_3addr);
 	OUI_Subtype = frame_body[5];
 
-	switch (OUI_Subtype) {
-	case P2P_NOTICE_OF_ABSENCE:
-		break;
-	case P2P_PRESENCE_REQUEST:
+	if (OUI_Subtype == P2P_PRESENCE_REQUEST)
 		process_p2p_presence_req(pwdinfo, pframe, len);
-		break;
-	case P2P_PRESENCE_RESPONSE:
-		break;
-	case P2P_GO_DISC_REQUEST:
-		break;
-	default:
-		break;
-	}
 }
 
 static void OnAction(struct adapter *padapter, struct recv_frame *precv_frame)
-- 
2.30.2

