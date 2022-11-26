Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57066396FC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 17:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiKZQCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 11:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKZQBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 11:01:47 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E635193F8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 08:01:46 -0800 (PST)
Received: from dslb-188-096-151-149.188.096.pools.vodafone-ip.de ([188.96.151.149] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oyxca-0000Ub-Q7; Sat, 26 Nov 2022 17:01:40 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 09/10] staging: r8188eu: simplify error handling for missing station
Date:   Sat, 26 Nov 2022 17:01:28 +0100
Message-Id: <20221126160129.178697-10-martin@kaiser.cx>
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

Simplify the code to handle the case where we're associated to a station
that is not in our list of known stations.

We can simply exit in this case. This patch reverts the if-condition and
saves one level of indentation.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 24 ++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 76424bcba416..362313c49c52 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -597,19 +597,19 @@ static void OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 
 	if (((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE) && (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS)) {
 		psta = rtw_get_stainfo(pstapriv, mgmt->sa);
-		if (psta) {
-			ret = rtw_check_bcn_info(padapter, pframe, len);
-			if (!ret) {
-				receive_disconnect(padapter,
-						   pmlmeinfo->network.MacAddress, 0);
-				return;
-			}
-			/* update WMM, ERP in the beacon */
-			/* todo: the timer is used instead of the number of the beacon received */
-			if ((sta_rx_pkts(psta) & 0xf) == 0)
-				update_beacon_info(padapter, ie_ptr, ie_len, psta);
-			process_p2p_ps_ie(padapter, ie_ptr, ie_len);
+		if (!psta)
+			return;
+
+		ret = rtw_check_bcn_info(padapter, pframe, len);
+		if (!ret) {
+			receive_disconnect(padapter, pmlmeinfo->network.MacAddress, 0);
+			return;
 		}
+		/* update WMM, ERP in the beacon */
+		/* todo: the timer is used instead of the number of the beacon received */
+		if ((sta_rx_pkts(psta) & 0xf) == 0)
+			update_beacon_info(padapter, ie_ptr, ie_len, psta);
+		process_p2p_ps_ie(padapter, ie_ptr, ie_len);
 	} else if ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) {
 		psta = rtw_get_stainfo(pstapriv, mgmt->sa);
 		if (psta) {
-- 
2.30.2

