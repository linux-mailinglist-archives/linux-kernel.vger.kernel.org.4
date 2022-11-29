Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107F163C9E2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbiK2UwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbiK2UwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:52:07 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08565FE7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 12:52:05 -0800 (PST)
Received: from dslb-188-104-061-001.188.104.pools.vodafone-ip.de ([188.104.61.1] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1p07aC-0001pO-Aq; Tue, 29 Nov 2022 21:52:00 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/5] staging: r8188eu: use ieee80211_mgmt to parse addresses
Date:   Tue, 29 Nov 2022 21:51:48 +0100
Message-Id: <20221129205152.128172-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221129205152.128172-1-martin@kaiser.cx>
References: <20221129205152.128172-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a struct ieee80211_mgmt in the OnDisassoc function and use it to
parse the addresses in the incoming disassoc message. This replaces some
driver-specific functions for address parsing.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index d32b2d569e23..b2b2cb57ed04 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -1427,6 +1427,7 @@ static void OnDeAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 
 static void OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame)
 {
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)precv_frame->rx_data;
 	u16 reason;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
@@ -1434,8 +1435,7 @@ static void OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame)
 	u8 *pframe = precv_frame->rx_data;
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
-	/* check A3 */
-	if (!(!memcmp(GetAddr3Ptr(pframe), get_my_bssid(&pmlmeinfo->network), ETH_ALEN)))
+	if (memcmp(mgmt->bssid, get_my_bssid(&pmlmeinfo->network), ETH_ALEN))
 		return;
 
 	if (pwdinfo->rx_invitereq_info.scan_op_ch_only) {
@@ -1449,7 +1449,7 @@ static void OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame)
 		struct sta_info *psta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
 
-		psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
+		psta = rtw_get_stainfo(pstapriv, mgmt->sa);
 		if (psta) {
 			u8 updated = 0;
 
@@ -1466,7 +1466,7 @@ static void OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame)
 
 		return;
 	} else {
-		receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
+		receive_disconnect(padapter, mgmt->bssid, reason);
 	}
 	pmlmepriv->LinkDetectInfo.bBusyTraffic = false;
 }
-- 
2.30.2

