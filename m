Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDB661E22A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 13:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiKFMtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 07:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiKFMtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 07:49:12 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC90963B8
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 04:49:11 -0800 (PST)
Received: from ipservice-092-217-068-220.092.217.pools.vodafone-ip.de ([92.217.68.220] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1orf5I-0008Dj-QE; Sun, 06 Nov 2022 13:49:08 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/9] staging: r8188eu: don't store addba request
Date:   Sun,  6 Nov 2022 13:48:53 +0100
Message-Id: <20221106124901.720785-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221106124901.720785-1-martin@kaiser.cx>
References: <20221106124901.720785-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to store an incoming addba request in struct
mlme_ext_info. We only need the addba request to copy some of its fields
into our addba response.

It's simpler to pass the incoming request's management frame to
issue_action_BA as an additional parameter. issue_action_BA can then
extract the required fields. If issue_action_BA prepares a request rather
than a response, the caller sets the parameter for the incoming request to
NULL.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 25 ++++++++-----------
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  4 +--
 drivers/staging/r8188eu/include/wifi.h        |  8 ------
 3 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 6679d4037d6b..324757699716 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -1486,11 +1486,9 @@ static void OnAction_back(struct adapter *padapter, struct recv_frame *precv_fra
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)precv_frame->rx_data;
 	struct sta_info *psta = NULL;
 	struct recv_reorder_ctrl *preorder_ctrl;
-	unsigned char		*frame_body;
 	unsigned short	tid;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
-	u8 *pframe = precv_frame->rx_data;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
 	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
@@ -1501,23 +1499,19 @@ static void OnAction_back(struct adapter *padapter, struct recv_frame *precv_fra
 	if (!psta)
 		return;
 
-	frame_body = (unsigned char *)(pframe + sizeof(struct ieee80211_hdr_3addr));
-
 	if (!pmlmeinfo->HT_enable)
 		return;
 	/* All union members start with an action code, it's ok to use addba_req. */
 	switch (mgmt->u.action.u.addba_req.action_code) {
 	case WLAN_ACTION_ADDBA_REQ:
-		memcpy(&pmlmeinfo->ADDBA_req, &frame_body[2], sizeof(struct ADDBA_request));
 		tid = u16_get_bits(le16_to_cpu(mgmt->u.action.u.addba_req.capab),
 				   IEEE80211_ADDBA_PARAM_TID_MASK);
 		preorder_ctrl = &psta->recvreorder_ctrl[tid];
 		preorder_ctrl->indicate_seq = 0xffff;
 		preorder_ctrl->enable = pmlmeinfo->bAcceptAddbaReq;
-
 		issue_action_BA(padapter, mgmt->sa, WLAN_ACTION_ADDBA_RESP,
 				pmlmeinfo->bAcceptAddbaReq ?
-					WLAN_STATUS_SUCCESS : WLAN_STATUS_REQUEST_DECLINED);
+					WLAN_STATUS_SUCCESS : WLAN_STATUS_REQUEST_DECLINED, mgmt);
 		break;
 	case WLAN_ACTION_ADDBA_RESP:
 		tid = u16_get_bits(le16_to_cpu(mgmt->u.action.u.addba_resp.capab),
@@ -5377,7 +5371,8 @@ int issue_deauth_ex(struct adapter *padapter, u8 *da, unsigned short reason, int
 	return ret;
 }
 
-void issue_action_BA(struct adapter *padapter, unsigned char *raddr, u8 action, u16 status)
+void issue_action_BA(struct adapter *padapter, unsigned char *raddr, u8 action,
+		     u16 status, struct ieee80211_mgmt *mgmt_req)
 {
 	u16 start_seq;
 	u16 BA_starting_seqctrl = 0;
@@ -5446,13 +5441,13 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, u8 action,
 		break;
 	case WLAN_ACTION_ADDBA_RESP:
 		mgmt->u.action.u.addba_resp.action_code = WLAN_ACTION_ADDBA_RESP;
-		mgmt->u.action.u.addba_resp.dialog_token = pmlmeinfo->ADDBA_req.dialog_token;
+		mgmt->u.action.u.addba_resp.dialog_token = mgmt_req->u.action.u.addba_req.dialog_token;
 		mgmt->u.action.u.addba_resp.status = cpu_to_le16(status);
-		capab = le16_to_cpu(pmlmeinfo->ADDBA_req.BA_para_set) & 0x3f;
+		capab = le16_to_cpu(mgmt_req->u.action.u.addba_req.capab) & 0x3f;
 		capab |= u16_encode_bits(64, IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK);
 		capab |= u16_encode_bits(pregpriv->ampdu_amsdu, IEEE80211_ADDBA_PARAM_AMSDU_MASK);
 		mgmt->u.action.u.addba_req.capab = cpu_to_le16(capab);
-		mgmt->u.action.u.addba_resp.timeout = pmlmeinfo->ADDBA_req.BA_timeout_value;
+		mgmt->u.action.u.addba_resp.timeout = mgmt_req->u.action.u.addba_req.timeout;
 		pattrib->pktlen = offsetofend(struct ieee80211_mgmt, u.action.u.addba_resp.timeout);
 		break;
 	case WLAN_ACTION_DELBA:
@@ -5620,7 +5615,8 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 	if (initiator == 0) { /*  recipient */
 		for (tid = 0; tid < MAXTID; tid++) {
 			if (psta->recvreorder_ctrl[tid].enable) {
-				issue_action_BA(padapter, addr, WLAN_ACTION_DELBA, (((tid << 1) | initiator) & 0x1F));
+				issue_action_BA(padapter, addr, WLAN_ACTION_DELBA,
+						(((tid << 1) | initiator) & 0x1F), NULL);
 				psta->recvreorder_ctrl[tid].enable = false;
 				psta->recvreorder_ctrl[tid].indicate_seq = 0xffff;
 			}
@@ -5628,7 +5624,8 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 	} else if (initiator == 1) { /*  originator */
 		for (tid = 0; tid < MAXTID; tid++) {
 			if (psta->htpriv.agg_enable_bitmap & BIT(tid)) {
-				issue_action_BA(padapter, addr, WLAN_ACTION_DELBA, (((tid << 1) | initiator) & 0x1F));
+				issue_action_BA(padapter, addr, WLAN_ACTION_DELBA,
+						(((tid << 1) | initiator) & 0x1F), NULL);
 				psta->htpriv.agg_enable_bitmap &= ~BIT(tid);
 				psta->htpriv.candidate_tid_bitmap &= ~BIT(tid);
 			}
@@ -7683,7 +7680,7 @@ u8 add_ba_hdl(struct adapter *padapter, unsigned char *pbuf)
 
 	if (((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) && (pmlmeinfo->HT_enable)) ||
 	    ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE)) {
-		issue_action_BA(padapter, pparm->addr, WLAN_ACTION_ADDBA_REQ, (u16)pparm->tid);
+		issue_action_BA(padapter, pparm->addr, WLAN_ACTION_ADDBA_REQ, (u16)pparm->tid, NULL);
 		_set_timer(&psta->addba_retry_timer, ADDBA_TO);
 	} else {
 		psta->htpriv.candidate_tid_bitmap &= ~BIT(pparm->tid);
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index e234a3b9af6f..a519a3dcdf61 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -285,7 +285,6 @@ struct mlme_ext_info {
 	u8	bwmode_updated;
 	u8	hidden_ssid_mode;
 
-	struct ADDBA_request	ADDBA_req;
 	struct WMM_para_element	WMM_param;
 	struct HT_caps_element	HT_caps;
 	struct HT_info_element	HT_info;
@@ -523,7 +522,8 @@ int issue_deauth(struct adapter *padapter, unsigned char *da,
 		 unsigned short reason);
 int issue_deauth_ex(struct adapter *padapter, u8 *da, unsigned short reason,
 		    int try_cnt, int wait_ms);
-void issue_action_BA(struct adapter *padapter, unsigned char *raddr, u8 action, u16 status);
+void issue_action_BA(struct adapter *padapter, unsigned char *raddr, u8 action,
+		     u16 status, struct ieee80211_mgmt *mgmt_req);
 unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr);
 unsigned int send_beacon(struct adapter *padapter);
 bool get_beacon_valid_bit(struct adapter *adapter);
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 92a584a8b6c0..2381c519ceaf 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -430,14 +430,6 @@ struct WMM_para_element {
 	struct AC_param	ac_param[4];
 } __packed;
 
-struct ADDBA_request {
-	unsigned char	action_code;
-	unsigned char	dialog_token;
-	__le16	BA_para_set;
-	__le16	BA_timeout_value;
-	__le16	BA_starting_seqctrl;
-} __packed;
-
 #define MAX_AMPDU_FACTOR_64K	3
 
 /* Spatial Multiplexing Power Save Modes */
-- 
2.30.2

