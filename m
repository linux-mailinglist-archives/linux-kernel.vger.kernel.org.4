Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEFD6396CC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 16:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiKZPnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 10:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKZPnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 10:43:06 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B13D10C
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 07:43:05 -0800 (PST)
Received: from dslb-188-096-151-149.188.096.pools.vodafone-ip.de ([188.96.151.149] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oyxKV-0000Lt-1L; Sat, 26 Nov 2022 16:42:59 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/5] staging: r8188eu: drop return value from issue_probereq_ex
Date:   Sat, 26 Nov 2022 16:42:49 +0100
Message-Id: <20221126154253.178275-2-martin@kaiser.cx>
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

The only caller of issue_probereq_ex does not check the return value. We
can remove it and make issue_probereq_ex a void function.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c    | 11 ++---------
 drivers/staging/r8188eu/include/rtw_mlme_ext.h |  4 ++--
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 161cb67f7882..2f3f7da08d0c 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -4482,8 +4482,8 @@ inline void issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *ps
 	_issue_probereq(padapter, pssid, da, false);
 }
 
-int issue_probereq_ex(struct adapter *padapter, struct ndis_802_11_ssid *pssid, u8 *da,
-	int try_cnt, int wait_ms)
+void issue_probereq_ex(struct adapter *padapter, struct ndis_802_11_ssid *pssid, u8 *da,
+		       int try_cnt, int wait_ms)
 {
 	int ret;
 	int i = 0;
@@ -4497,13 +4497,6 @@ int issue_probereq_ex(struct adapter *padapter, struct ndis_802_11_ssid *pssid,
 			msleep(wait_ms);
 
 	} while ((i < try_cnt) && ((ret == _FAIL) || (wait_ms == 0)));
-
-	if (ret != _FAIL) {
-		ret = _SUCCESS;
-		goto exit;
-	}
-exit:
-	return ret;
 }
 
 /*  if psta == NULL, indicate we are station (client) now... */
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index c46fc1a53085..720610bc8fef 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -512,8 +512,8 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta,
 		unsigned short status);
 void issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *pssid,
 		    u8 *da);
-s32 issue_probereq_ex(struct adapter *adapter, struct ndis_802_11_ssid *pssid,
-		      u8 *da, int try_cnt, int wait_ms);
+void issue_probereq_ex(struct adapter *adapter, struct ndis_802_11_ssid *pssid,
+		       u8 *da, int try_cnt, int wait_ms);
 int issue_nulldata(struct adapter *padapter, unsigned char *da,
 		   unsigned int power_mode, int try_cnt, int wait_ms);
 int issue_qos_nulldata(struct adapter *padapter, unsigned char *da,
-- 
2.30.2

