Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F271A5B3560
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 12:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiIIKku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 06:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiIIKkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:40:46 -0400
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C643134C2E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 03:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1662720042;
        bh=moyCOVLTLgtvkGdeoqzEJhhH4xd+dkMzT/AaRw4nmAo=;
        h=From:To:Cc:Subject:Date;
        b=cBhvix+OwCZg2lo03EEnza1mPAOHMb7haQOrxgJpQVauV+D+4jLbEFnXZM6S9nk4J
         WqSjBEyk9Z3sAreINXySLn8FzQUl6RkpVzBCqrTUoMw51oaVOJRRVRY8wvdUQ/A6ep
         1WMOx75ib1PvJcU0ttRNjhQPeXz0dhAwgAHI9zE0=
Received: from localhost.localdomain ([59.172.176.188])
        by newxmesmtplogicsvrszc10.qq.com (NewEsmtp) with SMTP
        id A2810C67; Fri, 09 Sep 2022 18:40:40 +0800
X-QQ-mid: xmsmtpt1662720040tnqyheovx
Message-ID: <tencent_C3B899D2FC3F1BC827F3552E0B0734056006@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8rYnMFzSHOj7N6uP2cMNaeRcALeO1T4QD1KAoh3JMHQQiA1TJ+w
         FS1hGJ86uCYUhyRfg4lvZAhzu0juj8KxzyrluLkC8zDCMxNoyK8ikAP6U6Tpac1UY+zh6Zpoa8as
         Z/Hs1ZzPglfURTRKZ4UDRc39P8JPUHNXa6pQRhqb6sHM03WPHHyvJsWxaBVL9MEy4HK4LvwOAz1x
         mM4u0rxL1KrFWEWfE7yr3JedMUrJvWGkt78PtXJLEyGBg/DokOX8nVBqG06/nM+4zfHsdbieJ5rW
         hYuPRUYA2WVFzqRmDfVVhOL8rCCi7ZtA45jgJhwbFwQ55Tl3vzRUXF6TKL7WLohzYrixTULVXDi8
         urNA1vfqAdEqAIx51zztri3JjJZtxr/iSTsKImqutIgrfRxoVx7NEYdbuZeTbidjn89QNnmKsIxL
         2lnOLCE0Go7wGzeWZaEEkg3+6AlpTMhWgaD/NWp+VLYQ0kuGBb1XUwyo0mheWYcCrFPDvN0jpoU1
         SwEHh1Qmdj1Sy0e+huwnHTodLmRLu+RTXaDgJND71czc8Ou3mh6K7kBN4xCkGamZG54tperF94lB
         eTsfXKYXoKeVOKxnWNI3f5zRmxTvQM2co/5l6f9WcQ3pHwtGeHQmFDEGAfA7wdB4JWp3LML4Hdw9
         SrDjAtZOJ44tpF10GQbpnunzYYmS9IVXnM28AI8cxpmHglZYRcYIy08H9KBTtf7XqZZoLzA6VnE0
         lGFlxT68tnNc+pZ7G32r4fDsb7NP5faKw6P8K4LVzJdYPGKDwEMeeEVXHYBLIkRyaGKsXOGuGCDt
         ihbxDy1bTo0Ik0c34YkcRJrMUKtwLlZJzcLNq2hn14FQayyAa9lOJbMbls/uVfPMHYVsgoPSMrBg
         bjnWYEAmaWQZOP3RxgB9IcO0sovbR40VWdzVfyUL4yfAlO0/J2B6gAQ0UClAxVSMehq991uFmQFJ
         j+K15UbQbuvlRieT3GeV4Yx97Q37pMeDUjj8HQWGZ+E05aB62BjXxMBwfBSw3kXcU1+QhgbPo=
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v4] staging: rtl8723bs: fix potential memory leak in rtw_init_drv_sw()
Date:   Fri,  9 Sep 2022 18:39:35 +0800
X-OQ-MSGID: <20220909103935.3196-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

In rtw_init_drv_sw(), there are various init functions are called to
populate the padapter structure and some checks for their return value.
However, except for the first one error path, the other five error paths
do not properly release the previous allocated resources, which leads to
various memory leaks.

This patch fixes them and keeps the success and error separate.
Note that these changes keep the form of `rtw_init_drv_sw()` in
"drivers/staging/r8188eu/os_dep/os_intfs.c". As there is no proper device
to test with, no runtime testing was performed.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 update the description.
v2->v3 update the description.
v3->v4 remove trailing whitespace and update the description.
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 60 +++++++++++----------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 0a8c24e..1bf6fc0 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -664,51 +664,36 @@ void rtw_reset_drv_sw(struct adapter *padapter)
 
 u8 rtw_init_drv_sw(struct adapter *padapter)
 {
-	u8 ret8 = _SUCCESS;
-
 	rtw_init_default_value(padapter);
 
 	rtw_init_hal_com_default_value(padapter);
 
-	if (rtw_init_cmd_priv(&padapter->cmdpriv)) {
-		ret8 = _FAIL;
-		goto exit;
-	}
+	if (rtw_init_cmd_priv(&padapter->cmdpriv))
+		return _FAIL;
 
 	padapter->cmdpriv.padapter = padapter;
 
-	if (rtw_init_evt_priv(&padapter->evtpriv)) {
-		ret8 = _FAIL;
-		goto exit;
-	}
+	if (rtw_init_evt_priv(&padapter->evtpriv))
+		goto free_cmd_priv;
 
-
-	if (rtw_init_mlme_priv(padapter) == _FAIL) {
-		ret8 = _FAIL;
-		goto exit;
-	}
+	if (rtw_init_mlme_priv(padapter) == _FAIL)
+		goto free_evt_priv;
 
 	init_mlme_ext_priv(padapter);
 
-	if (_rtw_init_xmit_priv(&padapter->xmitpriv, padapter) == _FAIL) {
-		ret8 = _FAIL;
-		goto exit;
-	}
+	if (_rtw_init_xmit_priv(&padapter->xmitpriv, padapter) == _FAIL)
+		goto free_mlme_ext;
 
-	if (_rtw_init_recv_priv(&padapter->recvpriv, padapter) == _FAIL) {
-		ret8 = _FAIL;
-		goto exit;
-	}
+	if (_rtw_init_recv_priv(&padapter->recvpriv, padapter) == _FAIL)
+		goto free_xmit_priv;
 	/*  add for CONFIG_IEEE80211W, none 11w also can use */
 	spin_lock_init(&padapter->security_key_mutex);
 
 	/*  We don't need to memset padapter->XXX to zero, because adapter is allocated by vzalloc(). */
 	/* memset((unsigned char *)&padapter->securitypriv, 0, sizeof (struct security_priv)); */
 
-	if (_rtw_init_sta_priv(&padapter->stapriv) == _FAIL) {
-		ret8 = _FAIL;
-		goto exit;
-	}
+	if (_rtw_init_sta_priv(&padapter->stapriv) == _FAIL)
+		goto free_recv_priv;
 
 	padapter->stapriv.padapter = padapter;
 	padapter->setband = GHZ24_50;
@@ -719,9 +704,26 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 
 	rtw_hal_dm_init(padapter);
 
-exit:
+	return _SUCCESS;
+
+free_recv_priv:
+	_rtw_free_recv_priv(&padapter->recvpriv);
+
+free_xmit_priv:
+	_rtw_free_xmit_priv(&padapter->xmitpriv);
+
+free_mlme_ext:
+	free_mlme_ext_priv(&padapter->mlmeextpriv);
 
-	return ret8;
+	rtw_free_mlme_priv(&padapter->mlmepriv);
+
+free_evt_priv:
+	rtw_free_evt_priv(&padapter->evtpriv);
+
+free_cmd_priv:
+	rtw_free_cmd_priv(&padapter->cmdpriv);
+
+	return _FAIL;
 }
 
 void rtw_cancel_all_timer(struct adapter *padapter)
-- 
