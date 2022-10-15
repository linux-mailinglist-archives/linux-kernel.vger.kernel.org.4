Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A1B5FFAF7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiJOPZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJOPZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:25:05 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8034175B8
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:24:57 -0700 (PDT)
Received: from ipservice-092-217-066-135.092.217.pools.vodafone-ip.de ([92.217.66.135] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ojj1x-000722-Ra; Sat, 15 Oct 2022 17:24:53 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 6/9] staging: r8188eu: exit for deauth from unknown station
Date:   Sat, 15 Oct 2022 17:24:37 +0200
Message-Id: <20221015152440.232281-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221015152440.232281-1-martin@kaiser.cx>
References: <20221015152440.232281-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we receive a deauth message from an unknown station, we can drop this
message and exit immediately. Reorder the code to make this clearer, don't
wrap everything in an if statement.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 22 ++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 742976c38cd5..40df0f9982f4 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -1477,21 +1477,21 @@ unsigned int OnDeAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		struct sta_info *psta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
+		u8 updated = 0;
 
 		psta = rtw_get_stainfo(pstapriv, mgmt->sa);
-		if (psta) {
-			u8 updated = 0;
-
-			spin_lock_bh(&pstapriv->asoc_list_lock);
-			if (!list_empty(&psta->asoc_list)) {
-				list_del_init(&psta->asoc_list);
-				pstapriv->asoc_list_cnt--;
-				updated = ap_free_sta(padapter, psta, false, reason);
-			}
-			spin_unlock_bh(&pstapriv->asoc_list_lock);
+		if (!psta)
+			return _SUCCESS;
 
-			associated_clients_update(padapter, updated);
+		spin_lock_bh(&pstapriv->asoc_list_lock);
+		if (!list_empty(&psta->asoc_list)) {
+			list_del_init(&psta->asoc_list);
+			pstapriv->asoc_list_cnt--;
+			updated = ap_free_sta(padapter, psta, false, reason);
 		}
+		spin_unlock_bh(&pstapriv->asoc_list_lock);
+
+		associated_clients_update(padapter, updated);
 
 		return _SUCCESS;
 	} else {
-- 
2.30.2

