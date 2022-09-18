Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804E25BBF39
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 19:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiIRR5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 13:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiIRR5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 13:57:17 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9ED16592
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 10:57:15 -0700 (PDT)
Received: from dslb-188-096-149-102.188.096.pools.vodafone-ip.de ([188.96.149.102] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oZyXX-0006VL-Jq; Sun, 18 Sep 2022 19:57:11 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/6] staging: r8188eu: remove BlinkingLedState
Date:   Sun, 18 Sep 2022 19:56:58 +0200
Message-Id: <20220918175700.215170-5-martin@kaiser.cx>
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

Both bLedOn and BlinkingLedState in struct led_priv store the same
information.

The boolean bLedOn stores the curent led state while BlinkingLedState
stores the next led state to be set during blinking, which is the inverse
of the current led state. (The led is either off or blinking, it's never
continuously on.)

This patch removes BlinkingLedState and uses bLedOn instead.

The LED_BLINK_WPS_STOP case in blink_work checked for
pLed->BlinkingLedState != RTW_LED_ON. This is true if the next led
blinking state is ON, i.e. if the led has just been switched off by
blink_work, i.e. if (!pLed->bLedOn).

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c    | 62 ++---------------------
 drivers/staging/r8188eu/include/rtw_led.h |  4 --
 2 files changed, 4 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index aee3ea3613a9..744247af5956 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -25,7 +25,6 @@ static void ResetLedStatus(struct led_priv *pLed)
 	pLed->bLedWPSBlinkInProgress = false;
 
 	pLed->BlinkTimes = 0; /*  Number of times to toggle led state for blinking. */
-	pLed->BlinkingLedState = LED_UNKNOWN; /*  Next state for blinking, either RTW_LED_ON or RTW_LED_OFF are. */
 
 	pLed->bLedLinkBlinkInProgress = false;
 	pLed->bLedScanBlinkInProgress = false;
@@ -87,32 +86,19 @@ static void blink_work(struct work_struct *work)
 		return;
 	}
 
-	/*  Change LED according to BlinkingLedState specified. */
-	if (pLed->BlinkingLedState == RTW_LED_ON)
-		SwLedOn(padapter, pLed);
-	else
+	if (pLed->bLedOn)
 		SwLedOff(padapter, pLed);
+	else
+		SwLedOn(padapter, pLed);
 
 	switch (pLed->CurrLedState) {
 	case LED_BLINK_SLOWLY:
-		if (pLed->bLedOn)
-			pLed->BlinkingLedState = RTW_LED_OFF;
-		else
-			pLed->BlinkingLedState = RTW_LED_ON;
 		schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
 		break;
 	case LED_BLINK_NORMAL:
-		if (pLed->bLedOn)
-			pLed->BlinkingLedState = RTW_LED_OFF;
-		else
-			pLed->BlinkingLedState = RTW_LED_ON;
 		schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
 		break;
 	case LED_BLINK_SCAN:
-		if (pLed->bLedOn)
-			pLed->BlinkingLedState = RTW_LED_OFF;
-		else
-			pLed->BlinkingLedState = RTW_LED_ON;
 		pLed->BlinkTimes--;
 		if (pLed->BlinkTimes == 0) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
@@ -129,10 +115,6 @@ static void blink_work(struct work_struct *work)
 		}
 		break;
 	case LED_BLINK_TXRX:
-		if (pLed->bLedOn)
-			pLed->BlinkingLedState = RTW_LED_OFF;
-		else
-			pLed->BlinkingLedState = RTW_LED_ON;
 		pLed->BlinkTimes--;
 		if (pLed->BlinkTimes == 0) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
@@ -149,25 +131,16 @@ static void blink_work(struct work_struct *work)
 		}
 		break;
 	case LED_BLINK_WPS:
-		if (pLed->bLedOn)
-			pLed->BlinkingLedState = RTW_LED_OFF;
-		else
-			pLed->BlinkingLedState = RTW_LED_ON;
 		schedule_delayed_work(&pLed->blink_work, LED_BLINK_SCAN_INTVL);
 		break;
 	case LED_BLINK_WPS_STOP:	/* WPS success */
-		if (pLed->BlinkingLedState != RTW_LED_ON) {
+		if (!pLed->bLedOn) {
 			pLed->bLedLinkBlinkInProgress = true;
 			pLed->CurrLedState = LED_BLINK_NORMAL;
-			if (pLed->bLedOn)
-				pLed->BlinkingLedState = RTW_LED_OFF;
-			else
-				pLed->BlinkingLedState = RTW_LED_ON;
 			schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
 
 			pLed->bLedWPSBlinkInProgress = false;
 		} else {
-			pLed->BlinkingLedState = RTW_LED_OFF;
 			schedule_delayed_work(&pLed->blink_work, LED_BLINK_WPS_SUCESS_INTVL);
 		}
 		break;
@@ -223,10 +196,6 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 		pLed->bLedBlinkInProgress = false;
 
 		pLed->CurrLedState = LED_BLINK_SLOWLY;
-		if (pLed->bLedOn)
-			pLed->BlinkingLedState = RTW_LED_OFF;
-		else
-			pLed->BlinkingLedState = RTW_LED_ON;
 		schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
 		break;
 	case LED_CTL_LINK:
@@ -242,10 +211,6 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 		pLed->bLedLinkBlinkInProgress = true;
 
 		pLed->CurrLedState = LED_BLINK_NORMAL;
-		if (pLed->bLedOn)
-			pLed->BlinkingLedState = RTW_LED_OFF;
-		else
-			pLed->BlinkingLedState = RTW_LED_ON;
 		schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
 		break;
 	case LED_CTL_SITE_SURVEY:
@@ -266,10 +231,6 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 
 		pLed->CurrLedState = LED_BLINK_SCAN;
 		pLed->BlinkTimes = 24;
-		if (pLed->bLedOn)
-			pLed->BlinkingLedState = RTW_LED_OFF;
-		else
-			pLed->BlinkingLedState = RTW_LED_ON;
 		schedule_delayed_work(&pLed->blink_work, LED_BLINK_SCAN_INTVL);
 		break;
 	case LED_CTL_TX:
@@ -287,10 +248,6 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 
 		pLed->CurrLedState = LED_BLINK_TXRX;
 		pLed->BlinkTimes = 2;
-		if (pLed->bLedOn)
-			pLed->BlinkingLedState = RTW_LED_OFF;
-		else
-			pLed->BlinkingLedState = RTW_LED_ON;
 		schedule_delayed_work(&pLed->blink_work, LED_BLINK_FASTER_INTVL);
 		break;
 	case LED_CTL_START_WPS: /* wait until xinpin finish */
@@ -304,10 +261,6 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 		pLed->bLedScanBlinkInProgress = false;
 		pLed->bLedWPSBlinkInProgress = true;
 		pLed->CurrLedState = LED_BLINK_WPS;
-		if (pLed->bLedOn)
-			pLed->BlinkingLedState = RTW_LED_OFF;
-		else
-			pLed->BlinkingLedState = RTW_LED_ON;
 		schedule_delayed_work(&pLed->blink_work, LED_BLINK_SCAN_INTVL);
 		break;
 	case LED_CTL_STOP_WPS:
@@ -320,10 +273,8 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 
 		pLed->CurrLedState = LED_BLINK_WPS_STOP;
 		if (pLed->bLedOn) {
-			pLed->BlinkingLedState = RTW_LED_OFF;
 			schedule_delayed_work(&pLed->blink_work, LED_BLINK_WPS_SUCESS_INTVL);
 		} else {
-			pLed->BlinkingLedState = RTW_LED_ON;
 			schedule_delayed_work(&pLed->blink_work, 0);
 		}
 		break;
@@ -331,15 +282,10 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 		cancel_delayed_work(&pLed->blink_work);
 		pLed->bLedWPSBlinkInProgress = false;
 		pLed->CurrLedState = LED_BLINK_SLOWLY;
-		if (pLed->bLedOn)
-			pLed->BlinkingLedState = RTW_LED_OFF;
-		else
-			pLed->BlinkingLedState = RTW_LED_ON;
 		schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
 		break;
 	case LED_CTL_POWER_OFF:
 		pLed->CurrLedState = RTW_LED_OFF;
-		pLed->BlinkingLedState = RTW_LED_OFF;
 		pLed->bLedLinkBlinkInProgress = false;
 		pLed->bLedBlinkInProgress = false;
 		pLed->bLedWPSBlinkInProgress = false;
diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
index 6a0881990394..7b1775b9fa64 100644
--- a/drivers/staging/r8188eu/include/rtw_led.h
+++ b/drivers/staging/r8188eu/include/rtw_led.h
@@ -21,8 +21,6 @@ enum LED_CTL_MODE {
 };
 
 enum LED_STATE_871x {
-	LED_UNKNOWN = 0,
-	RTW_LED_ON = 1,
 	RTW_LED_OFF = 2,
 	LED_BLINK_NORMAL = 3,
 	LED_BLINK_SLOWLY = 4,
@@ -43,8 +41,6 @@ struct led_priv {
 	bool bRegUseLed;
 
 	enum LED_STATE_871x	CurrLedState; /*  Current LED state. */
-	enum LED_STATE_871x	BlinkingLedState; /*  Next state for blinking,
-				   * either RTW_LED_ON or RTW_LED_OFF are. */
 
 	bool bLedOn; /*  true if LED is ON, false if LED is OFF. */
 
-- 
2.30.2

