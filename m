Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF5B659B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 18:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbiL3RyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 12:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbiL3Rx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 12:53:58 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405BD1C400
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 09:53:58 -0800 (PST)
Received: from dslb-188-097-208-179.188.097.pools.vodafone-ip.de ([188.97.208.179] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pBJZo-0004hN-8d; Fri, 30 Dec 2022 18:53:52 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/4] staging: r8188eu: merge on_action_public_default into its only caller
Date:   Fri, 30 Dec 2022 18:53:24 +0100
Message-Id: <20221230175326.90617-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221230175326.90617-1-martin@kaiser.cx>
References: <20221230175326.90617-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge on_action_public_default into on_action_public, which is the only
caller. Yet again, this makes the code a tiny bit smaller.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index cfa65813d3f2..0b2f5d6c1279 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -3735,29 +3735,20 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 	return _SUCCESS;
 }
 
-static void on_action_public_default(struct recv_frame *precv_frame)
-{
-	u8 *pframe = precv_frame->rx_data;
-	u8 *frame_body = pframe + sizeof(struct ieee80211_hdr_3addr);
-	u8 token;
-
-	token = frame_body[2];
-
-	rtw_action_public_decache(precv_frame, token);
-}
-
 static void on_action_public(struct adapter *padapter, struct recv_frame *precv_frame)
 {
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)precv_frame->rx_data;
 	u8 *pframe = precv_frame->rx_data;
 	u8 *frame_body = pframe + sizeof(struct ieee80211_hdr_3addr);
+	u8 token;
 
 	/* All members of the action enum start with action_code. */
 	if (mgmt->u.action.u.s1g.action_code == WLAN_PUB_ACTION_VENDOR_SPECIFIC) {
 		if (!memcmp(frame_body + 2, P2P_OUI, 4))
 			on_action_public_p2p(precv_frame);
 	} else {
-		on_action_public_default(precv_frame);
+		token = frame_body[2];
+		rtw_action_public_decache(precv_frame, token);
 	}
 }
 
-- 
2.30.2

