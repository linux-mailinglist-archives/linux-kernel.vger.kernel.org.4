Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D29B609C3B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiJXIPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiJXIOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:14:50 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EEE2497B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:14:43 -0700 (PDT)
Received: from ipservice-092-217-079-032.092.217.pools.vodafone-ip.de ([92.217.79.32] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1omsbX-0000nk-PL; Mon, 24 Oct 2022 10:14:40 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 12/17] staging: r8188eu: change mlme handlers to void
Date:   Mon, 24 Oct 2022 10:14:12 +0200
Message-Id: <20221024081417.66441-13-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221024081417.66441-1-martin@kaiser.cx>
References: <20221024081417.66441-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mlme handlers that are called from mgt_dispatcher return an error
code. mgt_dispatcher doesn't check this error code, we can remove it and
change the handler functions to void.

For now, make only the minimum changes to the handlers for removing the
error codes. If handlers can be simplified, that'll be done it separate
patches.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 93 ++++++++-----------
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  2 +-
 2 files changed, 41 insertions(+), 54 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 34b41931fb66..074c95f76e27 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -447,7 +447,7 @@ Following are the callback functions for each subtype of the management frames
 
 *****************************************************************************/
 
-static unsigned int OnProbeReq(struct adapter *padapter, struct recv_frame *precv_frame)
+static void OnProbeReq(struct adapter *padapter, struct recv_frame *precv_frame)
 {
 	unsigned int	ielen;
 	unsigned char	*p;
@@ -481,17 +481,17 @@ static unsigned int OnProbeReq(struct adapter *padapter, struct recv_frame *prec
 				report_survey_event(padapter, precv_frame);
 				p2p_listen_state_process(padapter,  get_sa(pframe));
 
-				return _SUCCESS;
+				return;
 			}
 		}
 	}
 
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
-		return _SUCCESS;
+		return;
 
 	if (!check_fwstate(pmlmepriv, _FW_LINKED) &&
 	    !check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE | WIFI_AP_STATE))
-		return _SUCCESS;
+		return;
 
 	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + _PROBEREQ_IE_OFFSET_, _SSID_IE_, (int *)&ielen,
 			len - WLAN_HDR_A3_LEN - _PROBEREQ_IE_OFFSET_);
@@ -503,7 +503,7 @@ static unsigned int OnProbeReq(struct adapter *padapter, struct recv_frame *prec
 
 		if ((ielen != 0 && memcmp((void *)(p + 2), (void *)cur->Ssid.Ssid, cur->Ssid.SsidLength)) ||
 		    (ielen == 0 && pmlmeinfo->hidden_ssid_mode))
-			return _SUCCESS;
+			return;
 
 _issue_probersp:
 
@@ -512,10 +512,9 @@ static unsigned int OnProbeReq(struct adapter *padapter, struct recv_frame *prec
 		    check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)))
 			issue_probersp(padapter, get_sa(pframe), is_valid_p2p_probereq);
 	}
-	return _SUCCESS;
 }
 
-static unsigned int OnProbeRsp(struct adapter *padapter, struct recv_frame *precv_frame)
+static void OnProbeRsp(struct adapter *padapter, struct recv_frame *precv_frame)
 {
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
@@ -537,7 +536,7 @@ static unsigned int OnProbeRsp(struct adapter *padapter, struct recv_frame *prec
 				}
 			}
 		}
-		return _SUCCESS;
+		return;
 	} else if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_GONEGO_ING)) {
 		if (pwdinfo->nego_req_info.benable) {
 			if (!memcmp(pwdinfo->nego_req_info.peerDevAddr, GetAddr2Ptr(pframe), ETH_ALEN)) {
@@ -555,13 +554,11 @@ static unsigned int OnProbeRsp(struct adapter *padapter, struct recv_frame *prec
 	}
 	if (pmlmeext->sitesurvey_res.state == SCAN_PROCESS) {
 		report_survey_event(padapter, precv_frame);
-		return _SUCCESS;
+		return;
 	}
-
-	return _SUCCESS;
 }
 
-static unsigned int OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
+static void OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 {
 	int cam_idx;
 	struct sta_info	*psta;
@@ -576,7 +573,7 @@ static unsigned int OnBeacon(struct adapter *padapter, struct recv_frame *precv_
 
 	if (pmlmeext->sitesurvey_res.state == SCAN_PROCESS) {
 		report_survey_event(padapter, precv_frame);
-		return _SUCCESS;
+		return;
 	}
 
 	if (!memcmp(GetAddr3Ptr(pframe), get_my_bssid(&pmlmeinfo->network), ETH_ALEN)) {
@@ -600,7 +597,7 @@ static unsigned int OnBeacon(struct adapter *padapter, struct recv_frame *precv_
 			/* start auth */
 			start_clnt_auth(padapter);
 
-			return _SUCCESS;
+			return;
 		}
 
 		if (((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE) && (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS)) {
@@ -610,7 +607,7 @@ static unsigned int OnBeacon(struct adapter *padapter, struct recv_frame *precv_
 				if (!ret) {
 					receive_disconnect(padapter,
 							   pmlmeinfo->network.MacAddress, 0);
-					return _SUCCESS;
+					return;
 				}
 				/* update WMM, ERP in the beacon */
 				/* todo: the timer is used instead of the number of the beacon received */
@@ -629,12 +626,12 @@ static unsigned int OnBeacon(struct adapter *padapter, struct recv_frame *precv_
 				/* allocate a new CAM entry for IBSS station */
 				cam_idx = allocate_fw_sta_entry(padapter);
 				if (cam_idx == NUM_STA)
-					goto _END_ONBEACON_;
+					return;
 
 				/* get supported rate */
 				if (update_sta_support_rate(padapter, (pframe + WLAN_HDR_A3_LEN + _BEACON_IE_OFFSET_), (len - WLAN_HDR_A3_LEN - _BEACON_IE_OFFSET_), cam_idx) == _FAIL) {
 					pmlmeinfo->FW_sta_info[cam_idx].status = 0;
-					goto _END_ONBEACON_;
+					return;
 				}
 
 				/* update TSF Value */
@@ -645,13 +642,9 @@ static unsigned int OnBeacon(struct adapter *padapter, struct recv_frame *precv_
 			}
 		}
 	}
-
-_END_ONBEACON_:
-
-	return _SUCCESS;
 }
 
-static unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
+static void OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 {
 	unsigned int	auth_mode, ie_len;
 	u16 seq;
@@ -668,7 +661,7 @@ static unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_fr
 	uint len = precv_frame->len;
 
 	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
-		return _FAIL;
+		return;
 
 	sa = GetAddr2Ptr(pframe);
 
@@ -784,7 +777,7 @@ static unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_fr
 	if (pstat->state & WIFI_FW_AUTH_SUCCESS)
 		pstat->auth_seq = 0;
 
-	return _SUCCESS;
+	return;
 
 auth_fail:
 
@@ -797,10 +790,9 @@ static unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_fr
 	memcpy(pstat->hwaddr, sa, 6);
 
 	issue_auth(padapter, pstat, (unsigned short)status);
-	return _FAIL;
 }
 
-static unsigned int OnAuthClient(struct adapter *padapter, struct recv_frame *precv_frame)
+static void OnAuthClient(struct adapter *padapter, struct recv_frame *precv_frame)
 {
 	unsigned int	seq, len, status, offset;
 	unsigned char	*p;
@@ -812,10 +804,10 @@ static unsigned int OnAuthClient(struct adapter *padapter, struct recv_frame *pr
 
 	/* check A1 matches or not */
 	if (memcmp(myid(&padapter->eeprompriv), get_da(pframe), ETH_ALEN))
-		return _SUCCESS;
+		return;
 
 	if (!(pmlmeinfo->state & WIFI_FW_AUTH_STATE))
-		return _SUCCESS;
+		return;
 
 	offset = (GetPrivacy(pframe)) ? 4 : 0;
 
@@ -848,7 +840,7 @@ static unsigned int OnAuthClient(struct adapter *padapter, struct recv_frame *pr
 			issue_auth(padapter, NULL, 0);
 			set_link_timer(pmlmeext, REAUTH_TO);
 
-			return _SUCCESS;
+			return;
 		} else {
 			/*  open system */
 			go2asoc = 1;
@@ -865,10 +857,10 @@ static unsigned int OnAuthClient(struct adapter *padapter, struct recv_frame *pr
 
 	if (go2asoc) {
 		start_clnt_assoc(padapter);
-		return _SUCCESS;
+		return;
 	}
 authclnt_fail:
-	return _FAIL;
+	return;
 }
 
 static void UpdateBrateTbl(u8 *mbrate)
@@ -911,7 +903,7 @@ static void UpdateBrateTblForSoftAP(u8 *bssrateset, u32 bssratelen)
 	}
 }
 
-static unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame)
+static void OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame)
 {
 	u16 capab_info;
 	struct rtw_ieee802_11_elems elems;
@@ -937,7 +929,7 @@ static unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *prec
 	u32 p2pielen = 0;
 
 	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
-		return _FAIL;
+		return;
 
 	frame_type = GetFrameSubType(pframe);
 	if (frame_type == WIFI_ASSOCREQ)
@@ -946,7 +938,7 @@ static unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *prec
 		ie_offset = _REASOCREQ_IE_OFFSET_;
 
 	if (pkt_len < IEEE80211_3ADDR_LEN + ie_offset)
-		return _FAIL;
+		return;
 
 	pstat = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 	if (pstat == (struct sta_info *)NULL) {
@@ -1300,13 +1292,13 @@ static unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *prec
 		report_add_sta_event(padapter, pstat->hwaddr, pstat->aid);
 	}
 
-	return _SUCCESS;
+	return;
 
 asoc_class2_error:
 
 	issue_deauth(padapter, (void *)GetAddr2Ptr(pframe), status);
 
-	return _FAIL;
+	return;
 
 OnAssocReqFail:
 
@@ -1316,10 +1308,10 @@ static unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *prec
 	else
 		issue_asocrsp(padapter, status, pstat, WIFI_REASSOCRSP);
 
-	return _FAIL;
+	return;
 }
 
-static unsigned int OnAssocRsp(struct adapter *padapter, struct recv_frame *precv_frame)
+static void OnAssocRsp(struct adapter *padapter, struct recv_frame *precv_frame)
 {
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)precv_frame->rx_data;
 	uint i;
@@ -1333,13 +1325,13 @@ static unsigned int OnAssocRsp(struct adapter *padapter, struct recv_frame *prec
 
 	/* check A1 matches or not */
 	if (memcmp(myid(&padapter->eeprompriv), mgmt->da, ETH_ALEN))
-		return _SUCCESS;
+		return;
 
 	if (!(pmlmeinfo->state & (WIFI_FW_AUTH_SUCCESS | WIFI_FW_ASSOC_STATE)))
-		return _SUCCESS;
+		return;
 
 	if (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS)
-		return _SUCCESS;
+		return;
 
 	_cancel_timer_ex(&pmlmeext->link_timer);
 
@@ -1392,11 +1384,9 @@ static unsigned int OnAssocRsp(struct adapter *padapter, struct recv_frame *prec
 
 report_assoc_result:
 	report_join_res(padapter, res);
-
-	return _SUCCESS;
 }
 
-static unsigned int OnDeAuth(struct adapter *padapter, struct recv_frame *precv_frame)
+static void OnDeAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 {
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)precv_frame->rx_data;
 	unsigned short	reason;
@@ -1406,7 +1396,7 @@ static unsigned int OnDeAuth(struct adapter *padapter, struct recv_frame *precv_
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	if (memcmp(mgmt->bssid, get_my_bssid(&pmlmeinfo->network), ETH_ALEN))
-		return _SUCCESS;
+		return;
 
 	if (pwdinfo->rx_invitereq_info.scan_op_ch_only) {
 		_cancel_timer_ex(&pwdinfo->reset_ch_sitesurvey);
@@ -1422,7 +1412,7 @@ static unsigned int OnDeAuth(struct adapter *padapter, struct recv_frame *precv_
 
 		psta = rtw_get_stainfo(pstapriv, mgmt->sa);
 		if (!psta)
-			return _SUCCESS;
+			return;
 
 		spin_lock_bh(&pstapriv->asoc_list_lock);
 		if (!list_empty(&psta->asoc_list)) {
@@ -1455,10 +1445,9 @@ static unsigned int OnDeAuth(struct adapter *padapter, struct recv_frame *precv_
 
 		pmlmepriv->LinkDetectInfo.bBusyTraffic = false;
 	}
-	return _SUCCESS;
 }
 
-static unsigned int OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame)
+static void OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame)
 {
 	u16 reason;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -1469,7 +1458,7 @@ static unsigned int OnDisassoc(struct adapter *padapter, struct recv_frame *prec
 
 	/* check A3 */
 	if (!(!memcmp(GetAddr3Ptr(pframe), get_my_bssid(&pmlmeinfo->network), ETH_ALEN)))
-		return _SUCCESS;
+		return;
 
 	if (pwdinfo->rx_invitereq_info.scan_op_ch_only) {
 		_cancel_timer_ex(&pwdinfo->reset_ch_sitesurvey);
@@ -1497,12 +1486,11 @@ static unsigned int OnDisassoc(struct adapter *padapter, struct recv_frame *prec
 			associated_clients_update(padapter, updated);
 		}
 
-		return _SUCCESS;
+		return;
 	} else {
 		receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
 	}
 	pmlmepriv->LinkDetectInfo.bBusyTraffic = false;
-	return _SUCCESS;
 }
 
 unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_frame)
@@ -3906,7 +3894,7 @@ unsigned int OnAction_p2p(struct adapter *padapter, struct recv_frame *precv_fra
 	return _SUCCESS;
 }
 
-static unsigned int OnAction(struct adapter *padapter, struct recv_frame *precv_frame)
+static void OnAction(struct adapter *padapter, struct recv_frame *precv_frame)
 {
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)precv_frame->rx_data;
 
@@ -3921,7 +3909,6 @@ static unsigned int OnAction(struct adapter *padapter, struct recv_frame *precv_
 		OnAction_p2p(padapter, precv_frame);
 		break;
 	}
-	return _SUCCESS;
 }
 
 struct xmit_frame *alloc_mgtxmitframe(struct xmit_priv *pxmitpriv)
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index f77e6dc81831..c8beaa927cba 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -184,7 +184,7 @@ enum SCAN_STATE {
 	SCAN_STATE_MAX,
 };
 
-typedef unsigned int (*mlme_handler)(struct adapter *adapt, struct recv_frame *frame);
+typedef void (*mlme_handler)(struct adapter *adapt, struct recv_frame *frame);
 
 struct	ss_res {
 	int	state;
-- 
2.30.2

