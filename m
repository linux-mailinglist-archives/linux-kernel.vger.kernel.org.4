Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECC16396D1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 16:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiKZPnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 10:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiKZPnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 10:43:08 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044D9D13B
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 07:43:07 -0800 (PST)
Received: from dslb-188-096-151-149.188.096.pools.vodafone-ip.de ([188.96.151.149] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oyxKY-0000Lt-Fx; Sat, 26 Nov 2022 16:43:02 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/5] staging: r8188eu: use ieee80211 helper for protected bit
Date:   Sat, 26 Nov 2022 16:42:53 +0100
Message-Id: <20221126154253.178275-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221126154253.178275-1-martin@kaiser.cx>
References: <20221126154253.178275-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ieee80211_has_protected to check if the "protected" bit is set. Remove
the r8188eu driver's internal macro for this check.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 2 +-
 drivers/staging/r8188eu/include/wifi.h      | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 667f54e313ef..93696892ec7d 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -809,7 +809,7 @@ static void OnAuthClient(struct adapter *padapter, struct recv_frame *precv_fram
 	if (!(pmlmeinfo->state & WIFI_FW_AUTH_STATE))
 		return;
 
-	offset = (GetPrivacy(pframe)) ? 4 : 0;
+	offset = ieee80211_has_protected(hdr->frame_control) ? 4 : 0;
 
 	seq	= le16_to_cpu(*(__le16 *)((size_t)pframe + WLAN_HDR_A3_LEN + offset + 2));
 	status	= le16_to_cpu(*(__le16 *)((size_t)pframe + WLAN_HDR_A3_LEN + offset + 4));
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 2381c519ceaf..254a4bc1a141 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -170,9 +170,6 @@ enum WIFI_REG_DOMAIN {
 #define SetPrivacy(pbuf)	\
 	*(__le16 *)(pbuf) |= cpu_to_le16(_PRIVACY_)
 
-#define GetPrivacy(pbuf)					\
-	(((*(__le16 *)(pbuf)) & cpu_to_le16(_PRIVACY_)) != 0)
-
 #define GetFrameType(pbuf)				\
 	(le16_to_cpu(*(__le16 *)(pbuf)) & (BIT(3) | BIT(2)))
 
-- 
2.30.2

