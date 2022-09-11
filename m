Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A615B4F83
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 16:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiIKOwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 10:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIKOvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 10:51:45 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707242CC8E
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 07:51:44 -0700 (PDT)
Received: from ipservice-092-217-076-063.092.217.pools.vodafone-ip.de ([92.217.76.63] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oXOJA-000829-Jf; Sun, 11 Sep 2022 16:51:40 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 7/9] staging: r8188eu: simplify the code to prevent link blinking restart
Date:   Sun, 11 Sep 2022 16:51:20 +0200
Message-Id: <20220911145122.15444-8-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220911145122.15444-1-martin@kaiser.cx>
References: <20220911145122.15444-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blinking code to signal that a link is up has the same big if clause
around it as most other blink events.

Revert this if condition and exit if we're already blinking to show that
the link is up.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c | 37 +++++++++++++-------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index 270880050c64..7cd6ed5385bb 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -237,25 +237,26 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 		schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
 		break;
 	case LED_CTL_LINK:
-		if (!pLed->bLedLinkBlinkInProgress) {
-			if (pLed->CurrLedState == LED_BLINK_SCAN || IS_LED_WPS_BLINKING(pLed))
-				return;
-			if (pLed->bLedNoLinkBlinkInProgress) {
-				cancel_delayed_work(&pLed->blink_work);
-				pLed->bLedNoLinkBlinkInProgress = false;
-			}
-			if (pLed->bLedBlinkInProgress) {
-				cancel_delayed_work(&pLed->blink_work);
-				pLed->bLedBlinkInProgress = false;
-			}
-			pLed->bLedLinkBlinkInProgress = true;
-			pLed->CurrLedState = LED_BLINK_NORMAL;
-			if (pLed->bLedOn)
-				pLed->BlinkingLedState = RTW_LED_OFF;
-			else
-				pLed->BlinkingLedState = RTW_LED_ON;
-			schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
+		if (!pLed->bLedLinkBlinkInProgress)
+			return;
+
+		if (pLed->CurrLedState == LED_BLINK_SCAN || IS_LED_WPS_BLINKING(pLed))
+			return;
+		if (pLed->bLedNoLinkBlinkInProgress) {
+			cancel_delayed_work(&pLed->blink_work);
+			pLed->bLedNoLinkBlinkInProgress = false;
+		}
+		if (pLed->bLedBlinkInProgress) {
+			cancel_delayed_work(&pLed->blink_work);
+			pLed->bLedBlinkInProgress = false;
 		}
+		pLed->bLedLinkBlinkInProgress = true;
+		pLed->CurrLedState = LED_BLINK_NORMAL;
+		if (pLed->bLedOn)
+			pLed->BlinkingLedState = RTW_LED_OFF;
+		else
+			pLed->BlinkingLedState = RTW_LED_ON;
+		schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
 		break;
 	case LED_CTL_SITE_SURVEY:
 		if ((pmlmepriv->LinkDetectInfo.bBusyTraffic) && (check_fwstate(pmlmepriv, _FW_LINKED)))
-- 
2.30.2

