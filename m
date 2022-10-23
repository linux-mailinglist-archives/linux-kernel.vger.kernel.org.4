Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED489609501
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 19:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJWRIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 13:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiJWRI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 13:08:26 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E477973305
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 10:08:24 -0700 (PDT)
Received: from ipservice-092-217-070-181.092.217.pools.vodafone-ip.de ([92.217.70.181] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1omeSQ-0000Rj-G1; Sun, 23 Oct 2022 19:08:18 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/5] staging: r8188eu: NetworkTypeInUse is not in use
Date:   Sun, 23 Oct 2022 19:08:06 +0200
Message-Id: <20221023170808.46233-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221023170808.46233-1-martin@kaiser.cx>
References: <20221023170808.46233-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NetworkTypeInUse from struct wlan_bssid_ex is not used. Remove
NetworkTypeInUse itself, the code to set it and the enum for its
possible values.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme.c       | 16 ----------------
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  3 ---
 drivers/staging/r8188eu/include/wlan_bssdef.h |  9 ---------
 3 files changed, 28 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 1f69e5c57d5d..a47ae33454b3 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1819,22 +1819,6 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 
 	pdev_network->Rssi = 0;
 
-	switch (pregistrypriv->wireless_mode) {
-	case WIRELESS_11B:
-		pdev_network->NetworkTypeInUse = (Ndis802_11DS);
-		break;
-	case WIRELESS_11G:
-	case WIRELESS_11BG:
-	case WIRELESS_11_24N:
-	case WIRELESS_11G_24N:
-	case WIRELESS_11BG_24N:
-		pdev_network->NetworkTypeInUse = (Ndis802_11OFDM24);
-		break;
-	default:
-		/*  TODO */
-		break;
-	}
-
 	pdev_network->Configuration.DSConfig = (pregistrypriv->channel);
 
 	if (cur_network->network.InfrastructureMode == Ndis802_11IBSS)
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 8050f682c997..61d2680cbafc 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -6188,9 +6188,6 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 		memcpy(bssid->SupportedRates + i, (p + 2), len);
 	}
 
-	/* todo: */
-	bssid->NetworkTypeInUse = Ndis802_11OFDM24;
-
 	if (bssid->IELength < 12)
 		return _FAIL;
 
diff --git a/drivers/staging/r8188eu/include/wlan_bssdef.h b/drivers/staging/r8188eu/include/wlan_bssdef.h
index 81bda91a4136..831c465df500 100644
--- a/drivers/staging/r8188eu/include/wlan_bssdef.h
+++ b/drivers/staging/r8188eu/include/wlan_bssdef.h
@@ -17,14 +17,6 @@ struct ndis_802_11_ssid {
 	u8  Ssid[32];
 };
 
-enum NDIS_802_11_NETWORK_TYPE {
-	Ndis802_11FH,
-	Ndis802_11DS,
-	Ndis802_11OFDM5,
-	Ndis802_11OFDM24,
-	Ndis802_11NetworkTypeMax    /*  dummy upper bound */
-};
-
 struct ndis_802_11_config_fh {
 	u32           Length;		/*  Length of structure */
 	u32           HopPattern;	/*  As defined by 802.11, MSB set */
@@ -233,7 +225,6 @@ struct wlan_bssid_ex {
 	struct ndis_802_11_ssid  Ssid;
 	u32  Privacy;
 	NDIS_802_11_RSSI  Rssi;/* in dBM,raw data ,get from PHY) */
-	enum  NDIS_802_11_NETWORK_TYPE  NetworkTypeInUse;
 	struct ndis_802_11_config  Configuration;
 	enum ndis_802_11_network_infra  InfrastructureMode;
 	unsigned char SupportedRates[NDIS_802_11_LENGTH_RATES_EX];
-- 
2.30.2

