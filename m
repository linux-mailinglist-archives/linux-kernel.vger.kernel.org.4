Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011DE6396CF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 16:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiKZPnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 10:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiKZPnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 10:43:07 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E44FCE20
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 07:43:06 -0800 (PST)
Received: from dslb-188-096-151-149.188.096.pools.vodafone-ip.de ([188.96.151.149] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oyxKW-0000Lt-Mt; Sat, 26 Nov 2022 16:43:00 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/5] staging: r8188eu: fix the number of probereq retries
Date:   Sat, 26 Nov 2022 16:42:51 +0100
Message-Id: <20221126154253.178275-4-martin@kaiser.cx>
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

issue_probereq_ex sends a probe request and retries if this fails. There's
no point in making the number of retries configurable. Hard-code the value
that's used by issue_probereq_ex's only caller.

Simplify the code to check the loop condition only once.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 21 +++++++------------
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  3 +--
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 990336244030..667f54e313ef 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -4482,21 +4482,16 @@ inline void issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *ps
 	_issue_probereq(padapter, pssid, da, false);
 }
 
-void issue_probereq_ex(struct adapter *padapter, struct ndis_802_11_ssid *pssid, u8 *da,
-		       int try_cnt)
+void issue_probereq_ex(struct adapter *padapter, struct ndis_802_11_ssid *pssid, u8 *da)
 {
-	int ret;
-	int i = 0;
-
-	do {
-		ret = _issue_probereq(padapter, pssid, da, true);
-
-		i++;
+	int i;
 
-		if (i < try_cnt && ret == _FAIL)
+	for (i = 0; i < 3; i++) {
+		if (_issue_probereq(padapter, pssid, da, true) == _FAIL)
 			msleep(1);
-
-	} while ((i < try_cnt) && (ret == _FAIL));
+		else
+			break;
+	}
 }
 
 /*  if psta == NULL, indicate we are station (client) now... */
@@ -7046,7 +7041,7 @@ void linked_status_chk(struct adapter *padapter)
 				}
 
 				if (rx_chk != _SUCCESS)
-					issue_probereq_ex(padapter, &pmlmeinfo->network.Ssid, psta->hwaddr, 3);
+					issue_probereq_ex(padapter, &pmlmeinfo->network.Ssid, psta->hwaddr);
 
 				if ((tx_chk != _SUCCESS && pmlmeinfo->link_count++ == 0xf) || rx_chk != _SUCCESS) {
 					tx_chk = issue_nulldata(padapter, psta->hwaddr, 0, 3, 1);
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 04fd673d3a04..089bd5446773 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -512,8 +512,7 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta,
 		unsigned short status);
 void issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *pssid,
 		    u8 *da);
-void issue_probereq_ex(struct adapter *adapter, struct ndis_802_11_ssid *pssid,
-		       u8 *da, int try_cnt);
+void issue_probereq_ex(struct adapter *padapter, struct ndis_802_11_ssid *pssid, u8 *da);
 int issue_nulldata(struct adapter *padapter, unsigned char *da,
 		   unsigned int power_mode, int try_cnt, int wait_ms);
 int issue_qos_nulldata(struct adapter *padapter, unsigned char *da,
-- 
2.30.2

