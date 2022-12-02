Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411EB64035C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbiLBJca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbiLBJcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:32:21 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B859EBE111
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 01:32:20 -0800 (PST)
Received: from ipservice-092-217-087-074.092.217.pools.vodafone-ip.de ([92.217.87.74] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1p12P0-0001zC-3F; Fri, 02 Dec 2022 10:32:14 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/2] staging: r8188eu: use subtype helper in rtw_check_bcn_info
Date:   Fri,  2 Dec 2022 10:31:59 +0100
Message-Id: <20221202093159.404111-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221202093159.404111-1-martin@kaiser.cx>
References: <20221202093159.404111-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ieee80211_is_beacon to check the frame subtype in rtw_check_bcn_info.
Replace the call to the driver-specific GetFrameSubType function.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index da3465d6bb0f..f1ebb5358cb9 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -874,9 +874,10 @@ void VCS_update(struct adapter *padapter, struct sta_info *psta)
 
 int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 {
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)pframe;
 	unsigned int		len;
 	unsigned char		*p;
-	unsigned short	val16, subtype;
+	unsigned short	val16;
 	struct wlan_network *cur_network = &Adapter->mlmepriv.cur_network;
 	/* u8 wpa_ie[255], rsn_ie[255]; */
 	u16 wpa_len = 0, rsn_len = 0;
@@ -908,9 +909,7 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	if (!bssid)
 		return _FAIL;
 
-	subtype = GetFrameSubType(pframe) >> 4;
-
-	if (subtype == WIFI_BEACON)
+	if (ieee80211_is_beacon(mgmt->frame_control))
 		bssid->Reserved[0] = 1;
 
 	bssid->Length = sizeof(struct wlan_bssid_ex) - MAX_IE_SZ + len;
-- 
2.30.2

