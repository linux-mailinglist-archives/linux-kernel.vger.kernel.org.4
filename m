Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAF95BBF38
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 19:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiIRR5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 13:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiIRR5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 13:57:14 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E93316598
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 10:57:13 -0700 (PDT)
Received: from dslb-188-096-149-102.188.096.pools.vodafone-ip.de ([188.96.149.102] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oZyXV-0006VL-CY; Sun, 18 Sep 2022 19:57:09 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/6] staging: r8188eu: remove bLedNoLinkBlinkInProgress
Date:   Sun, 18 Sep 2022 19:56:57 +0200
Message-Id: <20220918175700.215170-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220918175700.215170-1-martin@kaiser.cx>
References: <20220918175700.215170-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the bLedNoLinkBlinkInProgress state variable. Its sole purpose is
to block subsequent requests for "no link" blinking when this blinking
pattern is already active.

It's perfectly safe to restart "no link" blinking. We can remove
bLedNoLinkBlinkInProgress and the many places where it's updated.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c    | 14 --------------
 drivers/staging/r8188eu/include/rtw_led.h |  1 -
 2 files changed, 15 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index eac35f048f52..aee3ea3613a9 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -27,7 +27,6 @@ static void ResetLedStatus(struct led_priv *pLed)
 	pLed->BlinkTimes = 0; /*  Number of times to toggle led state for blinking. */
 	pLed->BlinkingLedState = LED_UNKNOWN; /*  Next state for blinking, either RTW_LED_ON or RTW_LED_OFF are. */
 
-	pLed->bLedNoLinkBlinkInProgress = false;
 	pLed->bLedLinkBlinkInProgress = false;
 	pLed->bLedScanBlinkInProgress = false;
 }
@@ -121,7 +120,6 @@ static void blink_work(struct work_struct *work)
 				pLed->CurrLedState = LED_BLINK_NORMAL;
 				schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
 			} else {
-				pLed->bLedNoLinkBlinkInProgress = true;
 				pLed->CurrLedState = LED_BLINK_SLOWLY;
 				schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
 			}
@@ -142,7 +140,6 @@ static void blink_work(struct work_struct *work)
 				pLed->CurrLedState = LED_BLINK_NORMAL;
 				schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
 			} else {
-				pLed->bLedNoLinkBlinkInProgress = true;
 				pLed->CurrLedState = LED_BLINK_SLOWLY;
 				schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
 			}
@@ -217,9 +214,6 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 	switch (LedAction) {
 	case LED_CTL_START_TO_LINK:
 	case LED_CTL_NO_LINK:
-		if (pLed->bLedNoLinkBlinkInProgress)
-			return;
-
 		if (pLed->CurrLedState == LED_BLINK_SCAN || IS_LED_WPS_BLINKING(pLed))
 			return;
 
@@ -227,7 +221,6 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 
 		pLed->bLedLinkBlinkInProgress = false;
 		pLed->bLedBlinkInProgress = false;
-		pLed->bLedNoLinkBlinkInProgress = true;
 
 		pLed->CurrLedState = LED_BLINK_SLOWLY;
 		if (pLed->bLedOn)
@@ -245,7 +238,6 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 
 		cancel_delayed_work(&pLed->blink_work);
 
-		pLed->bLedNoLinkBlinkInProgress = false;
 		pLed->bLedBlinkInProgress = false;
 		pLed->bLedLinkBlinkInProgress = true;
 
@@ -268,7 +260,6 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 
 		cancel_delayed_work(&pLed->blink_work);
 
-		pLed->bLedNoLinkBlinkInProgress = false;
 		pLed->bLedLinkBlinkInProgress = false;
 		pLed->bLedBlinkInProgress = false;
 		pLed->bLedScanBlinkInProgress = true;
@@ -291,7 +282,6 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 
 		cancel_delayed_work(&pLed->blink_work);
 
-		pLed->bLedNoLinkBlinkInProgress = false;
 		pLed->bLedLinkBlinkInProgress = false;
 		pLed->bLedBlinkInProgress = true;
 
@@ -309,7 +299,6 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 
 		cancel_delayed_work(&pLed->blink_work);
 
-		pLed->bLedNoLinkBlinkInProgress = false;
 		pLed->bLedLinkBlinkInProgress = false;
 		pLed->bLedBlinkInProgress = false;
 		pLed->bLedScanBlinkInProgress = false;
@@ -324,7 +313,6 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 	case LED_CTL_STOP_WPS:
 		cancel_delayed_work(&pLed->blink_work);
 
-		pLed->bLedNoLinkBlinkInProgress = false;
 		pLed->bLedLinkBlinkInProgress = false;
 		pLed->bLedBlinkInProgress = false;
 		pLed->bLedScanBlinkInProgress = false;
@@ -342,7 +330,6 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 	case LED_CTL_STOP_WPS_FAIL:
 		cancel_delayed_work(&pLed->blink_work);
 		pLed->bLedWPSBlinkInProgress = false;
-		pLed->bLedNoLinkBlinkInProgress = true;
 		pLed->CurrLedState = LED_BLINK_SLOWLY;
 		if (pLed->bLedOn)
 			pLed->BlinkingLedState = RTW_LED_OFF;
@@ -353,7 +340,6 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 	case LED_CTL_POWER_OFF:
 		pLed->CurrLedState = RTW_LED_OFF;
 		pLed->BlinkingLedState = RTW_LED_OFF;
-		pLed->bLedNoLinkBlinkInProgress = false;
 		pLed->bLedLinkBlinkInProgress = false;
 		pLed->bLedBlinkInProgress = false;
 		pLed->bLedWPSBlinkInProgress = false;
diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
index d6b0c1c2f9a2..6a0881990394 100644
--- a/drivers/staging/r8188eu/include/rtw_led.h
+++ b/drivers/staging/r8188eu/include/rtw_led.h
@@ -54,7 +54,6 @@ struct led_priv {
 
 	u32 BlinkTimes; /*  Number of times to toggle led state for blinking. */
 
-	bool bLedNoLinkBlinkInProgress;
 	bool bLedLinkBlinkInProgress;
 	bool bLedScanBlinkInProgress;
 	struct delayed_work blink_work;
-- 
2.30.2

