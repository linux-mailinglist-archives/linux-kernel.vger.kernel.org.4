Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5257D6396F8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 17:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiKZQB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 11:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKZQBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 11:01:42 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605ED193E0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 08:01:42 -0800 (PST)
Received: from dslb-188-096-151-149.188.096.pools.vodafone-ip.de ([188.96.151.149] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oyxcW-0000Ub-D3; Sat, 26 Nov 2022 17:01:36 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 03/10] staging: r8188eu: replace GetAddr2Ptr calls
Date:   Sat, 26 Nov 2022 17:01:22 +0100
Message-Id: <20221126160129.178697-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221126160129.178697-1-martin@kaiser.cx>
References: <20221126160129.178697-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get the source address of a beacon frame from our struct ieee80211_mgmt
instead of using the driver's internal GetAddr2Ptr helper.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 66e3a90da3a3..5a31b20dc46d 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -586,7 +586,7 @@ static void OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 		}
 
 		if (((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE) && (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS)) {
-			psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
+			psta = rtw_get_stainfo(pstapriv, mgmt->sa);
 			if (psta) {
 				ret = rtw_check_bcn_info(padapter, pframe, len);
 				if (!ret) {
@@ -601,7 +601,7 @@ static void OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 				process_p2p_ps_ie(padapter, (pframe + WLAN_HDR_A3_LEN), (len - WLAN_HDR_A3_LEN));
 			}
 		} else if ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) {
-			psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
+			psta = rtw_get_stainfo(pstapriv, mgmt->sa);
 			if (psta) {
 				/* update WMM, ERP in the beacon */
 				/* todo: the timer is used instead of the number of the beacon received */
@@ -621,8 +621,7 @@ static void OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 
 				pmlmeext->TSFValue = le64_to_cpu(mgmt->u.beacon.timestamp);
 
-				/* report sta add event */
-				report_add_sta_event(padapter, GetAddr2Ptr(pframe), cam_idx);
+				report_add_sta_event(padapter, mgmt->sa, cam_idx);
 			}
 		}
 	}
-- 
2.30.2

