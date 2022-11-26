Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E756396FD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 17:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiKZQCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 11:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKZQBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 11:01:47 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2157A193ED
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 08:01:46 -0800 (PST)
Received: from dslb-188-096-151-149.188.096.pools.vodafone-ip.de ([188.96.151.149] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oyxca-0000Ub-21; Sat, 26 Nov 2022 17:01:40 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 08/10] staging: r8188eu: stop beacon processing if kmalloc fails
Date:   Sat, 26 Nov 2022 17:01:27 +0100
Message-Id: <20221126160129.178697-9-martin@kaiser.cx>
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

If we cannot allocate a struct wlan_bssid_ex in the OnBeacon function, we
should stop processing the incoming beacon message and return.

For kmalloc failures, the current code just skips the update of network
and beacon info and tries to continue with the authentication. The update
would set the encryption algorithm that should be used for the
authentication.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index a15998d912a7..76424bcba416 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -575,13 +575,14 @@ static void OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 	if (pmlmeinfo->state & WIFI_FW_AUTH_NULL) {
 		/* we should update current network before auth, or some IE is wrong */
 		pbss = kmalloc(sizeof(struct wlan_bssid_ex), GFP_ATOMIC);
-		if (pbss) {
-			if (collect_bss_info(padapter, precv_frame, pbss) == _SUCCESS) {
-				update_network(&pmlmepriv->cur_network.network, pbss, padapter, true);
-				rtw_get_bcn_info(&pmlmepriv->cur_network);
-			}
-			kfree(pbss);
+		if (!pbss)
+			return;
+
+		if (collect_bss_info(padapter, precv_frame, pbss) == _SUCCESS) {
+			update_network(&pmlmepriv->cur_network.network, pbss, padapter, true);
+			rtw_get_bcn_info(&pmlmepriv->cur_network);
 		}
+		kfree(pbss);
 
 		/* check the vendor of the assoc AP */
 		pmlmeinfo->assoc_AP_vendor = check_assoc_AP(pframe + sizeof(struct ieee80211_hdr_3addr), len - sizeof(struct ieee80211_hdr_3addr));
-- 
2.30.2

