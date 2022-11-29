Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0529A63C9EA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbiK2Uwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbiK2UwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:52:23 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C29B5FE7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 12:52:22 -0800 (PST)
Received: from dslb-188-104-061-001.188.104.pools.vodafone-ip.de ([188.104.61.1] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1p07aT-0001pO-0u; Tue, 29 Nov 2022 21:52:17 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/5] staging: r8188eu: handle the non-ap case first
Date:   Tue, 29 Nov 2022 21:51:51 +0100
Message-Id: <20221129205152.128172-5-martin@kaiser.cx>
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

The OnDisassoc function hasn't got much to do if we're not working as an
access point. Move this case out of the large if statement to simplify the
code.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 36 ++++++++++-----------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index dd1e0b4fc5a0..d5c9eb52fb0e 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -1433,6 +1433,8 @@ static void OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame)
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
+	struct sta_info *psta;
+	struct sta_priv *pstapriv = &padapter->stapriv;
 
 	if (memcmp(mgmt->bssid, get_my_bssid(&pmlmeinfo->network), ETH_ALEN))
 		return;
@@ -1444,29 +1446,25 @@ static void OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame)
 
 	reason = le16_to_cpu(mgmt->u.disassoc.reason_code);
 
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
-		struct sta_info *psta;
-		struct sta_priv *pstapriv = &padapter->stapriv;
-
-		psta = rtw_get_stainfo(pstapriv, mgmt->sa);
-		if (psta) {
-			u8 updated = 0;
+	if (!check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
+		receive_disconnect(padapter, mgmt->bssid, reason);
+		pmlmepriv->LinkDetectInfo.bBusyTraffic = false;
+		return;
+	}
 
-			spin_lock_bh(&pstapriv->asoc_list_lock);
-			if (!list_empty(&psta->asoc_list)) {
-				list_del_init(&psta->asoc_list);
-				pstapriv->asoc_list_cnt--;
-				updated = ap_free_sta(padapter, psta, false, reason);
-			}
-			spin_unlock_bh(&pstapriv->asoc_list_lock);
+	psta = rtw_get_stainfo(pstapriv, mgmt->sa);
+	if (psta) {
+		u8 updated = 0;
 
-			associated_clients_update(padapter, updated);
+		spin_lock_bh(&pstapriv->asoc_list_lock);
+		if (!list_empty(&psta->asoc_list)) {
+			list_del_init(&psta->asoc_list);
+			pstapriv->asoc_list_cnt--;
+			updated = ap_free_sta(padapter, psta, false, reason);
 		}
+		spin_unlock_bh(&pstapriv->asoc_list_lock);
 
-		return;
-	} else {
-		receive_disconnect(padapter, mgmt->bssid, reason);
-		pmlmepriv->LinkDetectInfo.bBusyTraffic = false;
+		associated_clients_update(padapter, updated);
 	}
 }
 
-- 
2.30.2

