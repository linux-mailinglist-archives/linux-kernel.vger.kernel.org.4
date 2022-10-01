Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C035F1E1A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 19:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJARGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 13:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJARGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 13:06:34 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6B152FF0
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 10:06:32 -0700 (PDT)
Received: from dslb-188-104-058-002.188.104.pools.vodafone-ip.de ([188.104.58.2] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oefwX-0008H7-Mz; Sat, 01 Oct 2022 19:06:25 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] staging: r8188eu: remove bLedLinkBlinkInProgress
Date:   Sat,  1 Oct 2022 19:06:18 +0200
Message-Id: <20221001170618.444444-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the bLedLinkBlinkInProgress component from struct led_priv. Its
only use is to block requests for "link blinking" when this blinking
pattern is already active.

The "link blinking" pattern is a continuous blinking pattern (as opposed
to other patterns where we blink N times), it's no problem to restart this
pattern when it's already running.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c    | 14 --------------
 drivers/staging/r8188eu/include/rtw_led.h |  1 -
 2 files changed, 15 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index 1e316e6358ea..2527c252c3e9 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -26,7 +26,6 @@ static void ResetLedStatus(struct led_priv *pLed)
 
 	pLed->BlinkTimes = 0; /*  Number of times to toggle led state for blinking. */
 
-	pLed->bLedLinkBlinkInProgress = false;
 	pLed->bLedScanBlinkInProgress = false;
 }
 
@@ -99,7 +98,6 @@ static void blink_work(struct work_struct *work)
 		pLed->BlinkTimes--;
 		if (pLed->BlinkTimes == 0) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
-				pLed->bLedLinkBlinkInProgress = true;
 				pLed->CurrLedState = LED_BLINK_NORMAL;
 				schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
 			} else {
@@ -115,7 +113,6 @@ static void blink_work(struct work_struct *work)
 		pLed->BlinkTimes--;
 		if (pLed->BlinkTimes == 0) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
-				pLed->bLedLinkBlinkInProgress = true;
 				pLed->CurrLedState = LED_BLINK_NORMAL;
 				schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
 			} else {
@@ -132,7 +129,6 @@ static void blink_work(struct work_struct *work)
 		break;
 	case LED_BLINK_WPS_STOP:	/* WPS success */
 		if (!pLed->bLedOn) {
-			pLed->bLedLinkBlinkInProgress = true;
 			pLed->CurrLedState = LED_BLINK_NORMAL;
 			schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
 
@@ -189,23 +185,18 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 
 		cancel_delayed_work(&pLed->blink_work);
 
-		pLed->bLedLinkBlinkInProgress = false;
 		pLed->bLedBlinkInProgress = false;
 
 		pLed->CurrLedState = LED_BLINK_SLOWLY;
 		schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
 		break;
 	case LED_CTL_LINK:
-		if (!pLed->bLedLinkBlinkInProgress)
-			return;
-
 		if (pLed->CurrLedState == LED_BLINK_SCAN || IS_LED_WPS_BLINKING(pLed))
 			return;
 
 		cancel_delayed_work(&pLed->blink_work);
 
 		pLed->bLedBlinkInProgress = false;
-		pLed->bLedLinkBlinkInProgress = true;
 
 		pLed->CurrLedState = LED_BLINK_NORMAL;
 		schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
@@ -222,7 +213,6 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 
 		cancel_delayed_work(&pLed->blink_work);
 
-		pLed->bLedLinkBlinkInProgress = false;
 		pLed->bLedBlinkInProgress = false;
 		pLed->bLedScanBlinkInProgress = true;
 
@@ -240,7 +230,6 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 
 		cancel_delayed_work(&pLed->blink_work);
 
-		pLed->bLedLinkBlinkInProgress = false;
 		pLed->bLedBlinkInProgress = true;
 
 		pLed->CurrLedState = LED_BLINK_TXRX;
@@ -253,7 +242,6 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 
 		cancel_delayed_work(&pLed->blink_work);
 
-		pLed->bLedLinkBlinkInProgress = false;
 		pLed->bLedBlinkInProgress = false;
 		pLed->bLedScanBlinkInProgress = false;
 		pLed->bLedWPSBlinkInProgress = true;
@@ -263,7 +251,6 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 	case LED_CTL_STOP_WPS:
 		cancel_delayed_work(&pLed->blink_work);
 
-		pLed->bLedLinkBlinkInProgress = false;
 		pLed->bLedBlinkInProgress = false;
 		pLed->bLedScanBlinkInProgress = false;
 		pLed->bLedWPSBlinkInProgress = true;
@@ -283,7 +270,6 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 		break;
 	case LED_CTL_POWER_OFF:
 		pLed->CurrLedState = RTW_LED_OFF;
-		pLed->bLedLinkBlinkInProgress = false;
 		pLed->bLedBlinkInProgress = false;
 		pLed->bLedWPSBlinkInProgress = false;
 		pLed->bLedScanBlinkInProgress = false;
diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
index 8520f022a67f..f57dcf6c8b24 100644
--- a/drivers/staging/r8188eu/include/rtw_led.h
+++ b/drivers/staging/r8188eu/include/rtw_led.h
@@ -47,7 +47,6 @@ struct led_priv {
 
 	u32 BlinkTimes; /*  Number of times to toggle led state for blinking. */
 
-	bool bLedLinkBlinkInProgress;
 	bool bLedScanBlinkInProgress;
 	struct delayed_work blink_work;
 };
-- 
2.30.2

