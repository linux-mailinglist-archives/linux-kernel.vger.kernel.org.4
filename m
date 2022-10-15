Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012565FFAD1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJOPMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiJOPLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:11:44 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796C9474E1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:11:42 -0700 (PDT)
Received: from ipservice-092-217-066-135.092.217.pools.vodafone-ip.de ([92.217.66.135] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ojip7-0006sp-So; Sat, 15 Oct 2022 17:11:37 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 08/10] staging: r8188eu: remove padapter from struct led_priv
Date:   Sat, 15 Oct 2022 17:11:13 +0200
Message-Id: <20221015151115.232095-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221015151115.232095-1-martin@kaiser.cx>
References: <20221015151115.232095-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only struct led_priv that's used in the r8188eu driver in embedded in
the driver's global struct adapter. We can use container_of to access the
"outer" structure, there's no need to store a pointer to it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c    | 3 +--
 drivers/staging/r8188eu/include/rtw_led.h | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index 56f043d8ff38..2dbd7b5ffdd0 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -59,7 +59,7 @@ static void blink_work(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
 	struct led_priv *pLed = container_of(dwork, struct led_priv, blink_work);
-	struct adapter *padapter = pLed->padapter;
+	struct adapter *padapter = container_of(pLed, struct adapter, ledpriv);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	if (padapter->pwrctrlpriv.rf_pwrstate != rf_on) {
@@ -132,7 +132,6 @@ void rtl8188eu_InitSwLeds(struct adapter *padapter)
 {
 	struct led_priv *pledpriv = &padapter->ledpriv;
 
-	pledpriv->padapter = padapter;
 	ResetLedStatus(pledpriv);
 	INIT_DELAYED_WORK(&pledpriv->blink_work, blink_work);
 }
diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
index f57dcf6c8b24..ea5f5edd9013 100644
--- a/drivers/staging/r8188eu/include/rtw_led.h
+++ b/drivers/staging/r8188eu/include/rtw_led.h
@@ -33,8 +33,6 @@ enum LED_STATE_871x {
 };
 
 struct led_priv {
-	struct adapter *padapter;
-
 	bool bRegUseLed;
 
 	enum LED_STATE_871x	CurrLedState; /*  Current LED state. */
-- 
2.30.2

