Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A576124A1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 19:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJ2RY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 13:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiJ2RYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 13:24:10 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422B640E2F
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 10:24:01 -0700 (PDT)
Received: from dslb-188-097-213-253.188.097.pools.vodafone-ip.de ([188.97.213.253] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oopYq-00074v-Fq; Sat, 29 Oct 2022 19:23:56 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 04/13] staging: r8188eu: make OnAction_back static void
Date:   Sat, 29 Oct 2022 19:23:28 +0200
Message-Id: <20221029172337.1574593-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221029172337.1574593-1-martin@kaiser.cx>
References: <20221029172337.1574593-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OnAction_back is called only by OnAction, its return value is not checked.
We can make it a static void function.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c    | 13 +++++--------
 drivers/staging/r8188eu/include/rtw_mlme_ext.h |  2 --
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index caa73f16dbf9..b13593523fd0 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -1481,7 +1481,7 @@ static void OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame)
 	pmlmepriv->LinkDetectInfo.bBusyTraffic = false;
 }
 
-unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_frame)
+static void OnAction_back(struct adapter *padapter, struct recv_frame *precv_frame)
 {
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)precv_frame->rx_data;
 	struct sta_info *psta = NULL;
@@ -1494,21 +1494,20 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	/* check RA matches or not */
 	if (memcmp(myid(&padapter->eeprompriv), mgmt->da, ETH_ALEN))/* for if1, sta/ap mode */
-		return _SUCCESS;
+		return;
 
 	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
 		if (!(pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS))
-			return _SUCCESS;
+			return;
 
 	psta = rtw_get_stainfo(pstapriv, mgmt->sa);
-
 	if (!psta)
-		return _SUCCESS;
+		return;
 
 	frame_body = (unsigned char *)(pframe + sizeof(struct ieee80211_hdr_3addr));
 
 	if (!pmlmeinfo->HT_enable)
-		return _SUCCESS;
+		return;
 	/* All union members start with an action code, it's ok to use addba_req. */
 	switch (mgmt->u.action.u.addba_req.action_code) {
 	case WLAN_ACTION_ADDBA_REQ:
@@ -1550,8 +1549,6 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 	default:
 		break;
 	}
-
-	return _SUCCESS;
 }
 
 static int get_reg_classes_full_count(struct p2p_channels *channel_list)
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index ec2e9352011b..4ccdce1ad9be 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -536,8 +536,6 @@ void start_clnt_auth(struct adapter *padapter);
 void start_clnt_join(struct adapter *padapter);
 void start_create_ibss(struct adapter *padapter);
 
-unsigned int OnAction_back(struct adapter *padapter,
-			   struct recv_frame *precv_frame);
 unsigned int OnAction_p2p(struct adapter *padapter,
 			  struct recv_frame *precv_frame);
 
-- 
2.30.2

