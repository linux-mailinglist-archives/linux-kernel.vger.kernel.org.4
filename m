Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D3E612493
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 19:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJ2RKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 13:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJ2RKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 13:10:41 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C0C27178
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 10:10:39 -0700 (PDT)
Received: from dslb-188-097-213-253.188.097.pools.vodafone-ip.de ([188.97.213.253] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oopLu-0006xg-T0; Sat, 29 Oct 2022 19:10:34 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/2] staging: r8188eu: remove get_da
Date:   Sat, 29 Oct 2022 19:10:11 +0200
Message-Id: <20221029171011.1572091-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221029171011.1572091-1-martin@kaiser.cx>
References: <20221029171011.1572091-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the last get_da call with ieee80211_get_DA and remove the get_da
function.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c |  3 ++-
 drivers/staging/r8188eu/include/wifi.h        | 22 -------------------
 2 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
index dff0cba751df..f01ae71bcdb1 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
@@ -108,6 +108,7 @@ void update_recvframe_attrib_88e(struct recv_frame *precvframe, struct recv_stat
  */
 void update_recvframe_phyinfo_88e(struct recv_frame *precvframe, struct phy_stat *pphy_status)
 {
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)precvframe->rx_data;
 	struct adapter *padapter = precvframe->adapter;
 	struct rx_pkt_attrib *pattrib = &precvframe->attrib;
 	struct hal_data_8188e *pHalData = &padapter->haldata;
@@ -125,7 +126,7 @@ void update_recvframe_phyinfo_88e(struct recv_frame *precvframe, struct phy_stat
 		 get_bssid(&padapter->mlmepriv), ETH_ALEN));
 
 	pkt_info.bPacketToSelf = pkt_info.bPacketMatchBSSID &&
-				 (!memcmp(get_da(wlanhdr),
+				 (!memcmp(ieee80211_get_DA(hdr),
 				  myid(&padapter->eeprompriv), ETH_ALEN));
 
 	pkt_info.bPacketBeacon = pkt_info.bPacketMatchBSSID && ieee80211_is_beacon(fc);
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 6b50089cea29..92a584a8b6c0 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -217,28 +217,6 @@ enum WIFI_REG_DOMAIN {
 
 #define GetAddr4Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 24))
 
-static inline unsigned char *get_da(unsigned char *pframe)
-{
-	unsigned char	*da;
-	unsigned int to_fr_ds = (GetToDs(pframe) << 1) | GetFrDs(pframe);
-
-	switch (to_fr_ds) {
-	case 0x00:	/*  ToDs=0, FromDs=0 */
-		da = GetAddr1Ptr(pframe);
-		break;
-	case 0x01:	/*  ToDs=0, FromDs=1 */
-		da = GetAddr1Ptr(pframe);
-		break;
-	case 0x02:	/*  ToDs=1, FromDs=0 */
-		da = GetAddr3Ptr(pframe);
-		break;
-	default:	/*  ToDs=1, FromDs=1 */
-		da = GetAddr3Ptr(pframe);
-		break;
-	}
-	return da;
-}
-
 static inline unsigned char *get_sa(unsigned char *pframe)
 {
 	unsigned char	*sa;
-- 
2.30.2

