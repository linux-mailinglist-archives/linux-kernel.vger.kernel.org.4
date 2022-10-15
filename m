Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DA65FFAD4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJOPMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiJOPLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:11:47 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A625B476F2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:11:43 -0700 (PDT)
Received: from ipservice-092-217-066-135.092.217.pools.vodafone-ip.de ([92.217.66.135] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ojip9-0006sp-Iy; Sat, 15 Oct 2022 17:11:39 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 10/10] staging: r8188eu: summarize tx/rx and scan blinking
Date:   Sat, 15 Oct 2022 17:11:15 +0200
Message-Id: <20221015151115.232095-11-martin@kaiser.cx>
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

Summarize the code for tx/rx blinking and for scan blinking in blink_work.
The only difference is the delay for scheduling the next worker.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index f8bd183fba1e..ce8de2eb7845 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -81,21 +81,6 @@ static void blink_work(struct work_struct *work)
 		schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
 		break;
 	case LED_BLINK_SCAN:
-		pLed->BlinkTimes--;
-		if (pLed->BlinkTimes == 0) {
-			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
-				pLed->CurrLedState = LED_BLINK_NORMAL;
-				schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
-			} else {
-				pLed->CurrLedState = LED_BLINK_SLOWLY;
-				schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
-			}
-			pLed->bLedBlinkInProgress = false;
-			pLed->bLedScanBlinkInProgress = false;
-		} else {
-			schedule_delayed_work(&pLed->blink_work, LED_BLINK_SCAN_INTVL);
-		}
-		break;
 	case LED_BLINK_TXRX:
 		pLed->BlinkTimes--;
 		if (pLed->BlinkTimes == 0) {
@@ -109,7 +94,9 @@ static void blink_work(struct work_struct *work)
 			pLed->bLedBlinkInProgress = false;
 			pLed->bLedScanBlinkInProgress = false;
 		} else {
-			schedule_delayed_work(&pLed->blink_work, LED_BLINK_FASTER_INTVL);
+			schedule_delayed_work(&pLed->blink_work,
+					      pLed->CurrLedState == LED_BLINK_SCAN ?
+					      LED_BLINK_SCAN_INTVL : LED_BLINK_FASTER_INTVL);
 		}
 		break;
 	case LED_BLINK_WPS:
-- 
2.30.2

