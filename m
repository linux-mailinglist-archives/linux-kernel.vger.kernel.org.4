Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A222F63C9E9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbiK2Uwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbiK2UwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:52:25 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EC712606
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 12:52:24 -0800 (PST)
Received: from dslb-188-104-061-001.188.104.pools.vodafone-ip.de ([188.104.61.1] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1p07aU-0001pO-QO; Tue, 29 Nov 2022 21:52:18 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/5] staging: r8188eu: simplify err handling for unknown station
Date:   Tue, 29 Nov 2022 21:51:52 +0100
Message-Id: <20221129205152.128172-6-martin@kaiser.cx>
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

If we receive a disassoc message from an unknown station, we can drop this
message immediately. Reorder the code to make this clearer.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 22 ++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index d5c9eb52fb0e..49e0b50b1243 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -1435,6 +1435,7 @@ static void OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame)
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 	struct sta_info *psta;
 	struct sta_priv *pstapriv = &padapter->stapriv;
+	u8 updated = 0;
 
 	if (memcmp(mgmt->bssid, get_my_bssid(&pmlmeinfo->network), ETH_ALEN))
 		return;
@@ -1453,19 +1454,18 @@ static void OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame)
 	}
 
 	psta = rtw_get_stainfo(pstapriv, mgmt->sa);
-	if (psta) {
-		u8 updated = 0;
-
-		spin_lock_bh(&pstapriv->asoc_list_lock);
-		if (!list_empty(&psta->asoc_list)) {
-			list_del_init(&psta->asoc_list);
-			pstapriv->asoc_list_cnt--;
-			updated = ap_free_sta(padapter, psta, false, reason);
-		}
-		spin_unlock_bh(&pstapriv->asoc_list_lock);
+	if (!psta)
+		return;
 
-		associated_clients_update(padapter, updated);
+	spin_lock_bh(&pstapriv->asoc_list_lock);
+	if (!list_empty(&psta->asoc_list)) {
+		list_del_init(&psta->asoc_list);
+		pstapriv->asoc_list_cnt--;
+		updated = ap_free_sta(padapter, psta, false, reason);
 	}
+	spin_unlock_bh(&pstapriv->asoc_list_lock);
+
+	associated_clients_update(padapter, updated);
 }
 
 static void OnAction_back(struct adapter *padapter, struct recv_frame *precv_frame)
-- 
2.30.2

