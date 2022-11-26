Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED0F6396CE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 16:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiKZPnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 10:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKZPnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 10:43:06 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CE9D13B
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 07:43:05 -0800 (PST)
Received: from dslb-188-096-151-149.188.096.pools.vodafone-ip.de ([188.96.151.149] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oyxKV-0000Lt-Ry; Sat, 26 Nov 2022 16:42:59 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/5] staging: r8188eu: remove wait_ms parameter
Date:   Sat, 26 Nov 2022 16:42:50 +0100
Message-Id: <20221126154253.178275-3-martin@kaiser.cx>
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

Remove the wait_ms parameter from function issue_probereq_ex. There's only
one caller, who requests a waiting time of 1 ms.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c    | 12 ++++++------
 drivers/staging/r8188eu/include/rtw_mlme_ext.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 2f3f7da08d0c..990336244030 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -4483,20 +4483,20 @@ inline void issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *ps
 }
 
 void issue_probereq_ex(struct adapter *padapter, struct ndis_802_11_ssid *pssid, u8 *da,
-		       int try_cnt, int wait_ms)
+		       int try_cnt)
 {
 	int ret;
 	int i = 0;
 
 	do {
-		ret = _issue_probereq(padapter, pssid, da, wait_ms > 0);
+		ret = _issue_probereq(padapter, pssid, da, true);
 
 		i++;
 
-		if (i < try_cnt && wait_ms > 0 && ret == _FAIL)
-			msleep(wait_ms);
+		if (i < try_cnt && ret == _FAIL)
+			msleep(1);
 
-	} while ((i < try_cnt) && ((ret == _FAIL) || (wait_ms == 0)));
+	} while ((i < try_cnt) && (ret == _FAIL));
 }
 
 /*  if psta == NULL, indicate we are station (client) now... */
@@ -7046,7 +7046,7 @@ void linked_status_chk(struct adapter *padapter)
 				}
 
 				if (rx_chk != _SUCCESS)
-					issue_probereq_ex(padapter, &pmlmeinfo->network.Ssid, psta->hwaddr, 3, 1);
+					issue_probereq_ex(padapter, &pmlmeinfo->network.Ssid, psta->hwaddr, 3);
 
 				if ((tx_chk != _SUCCESS && pmlmeinfo->link_count++ == 0xf) || rx_chk != _SUCCESS) {
 					tx_chk = issue_nulldata(padapter, psta->hwaddr, 0, 3, 1);
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 720610bc8fef..04fd673d3a04 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -513,7 +513,7 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta,
 void issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *pssid,
 		    u8 *da);
 void issue_probereq_ex(struct adapter *adapter, struct ndis_802_11_ssid *pssid,
-		       u8 *da, int try_cnt, int wait_ms);
+		       u8 *da, int try_cnt);
 int issue_nulldata(struct adapter *padapter, unsigned char *da,
 		   unsigned int power_mode, int try_cnt, int wait_ms);
 int issue_qos_nulldata(struct adapter *padapter, unsigned char *da,
-- 
2.30.2

