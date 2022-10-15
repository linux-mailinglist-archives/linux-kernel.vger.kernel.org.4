Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10795FFACF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJOPMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJOPLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:11:44 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BB446847
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:11:40 -0700 (PDT)
Received: from ipservice-092-217-066-135.092.217.pools.vodafone-ip.de ([92.217.66.135] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ojip5-0006sp-9a; Sat, 15 Oct 2022 17:11:35 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 05/10] staging: r8188eu: SwLedOff needs no padapter parameter
Date:   Sat, 15 Oct 2022 17:11:10 +0200
Message-Id: <20221015151115.232095-6-martin@kaiser.cx>
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

Remove the padapter parameter from the SwLedOff function. padapter can
be derived from the pLed parameter.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index aa8f41edfade..56f043d8ff38 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -42,8 +42,10 @@ static void SwLedOn(struct led_priv *pLed)
 	pLed->bLedOn = true;
 }
 
-static void SwLedOff(struct adapter *padapter, struct led_priv *pLed)
+static void SwLedOff(struct led_priv *pLed)
 {
+	struct adapter *padapter = container_of(pLed, struct adapter, ledpriv);
+
 	if (padapter->bDriverStopped)
 		return;
 
@@ -61,13 +63,13 @@ static void blink_work(struct work_struct *work)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	if (padapter->pwrctrlpriv.rf_pwrstate != rf_on) {
-		SwLedOff(padapter, pLed);
+		SwLedOff(pLed);
 		ResetLedStatus(pLed);
 		return;
 	}
 
 	if (pLed->bLedOn)
-		SwLedOff(padapter, pLed);
+		SwLedOff(pLed);
 	else
 		SwLedOn(pLed);
 
@@ -141,7 +143,7 @@ void rtl8188eu_DeInitSwLeds(struct adapter *padapter)
 
 	cancel_delayed_work_sync(&ledpriv->blink_work);
 	ResetLedStatus(ledpriv);
-	SwLedOff(padapter, ledpriv);
+	SwLedOff(ledpriv);
 }
 
 void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
@@ -258,7 +260,7 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 		pLed->bLedWPSBlinkInProgress = false;
 		pLed->bLedScanBlinkInProgress = false;
 		cancel_delayed_work(&pLed->blink_work);
-		SwLedOff(padapter, pLed);
+		SwLedOff(pLed);
 		break;
 	default:
 		break;
-- 
2.30.2

