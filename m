Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974245B4F7E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 16:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiIKOwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 10:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiIKOvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 10:51:44 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779F6109D
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 07:51:43 -0700 (PDT)
Received: from ipservice-092-217-076-063.092.217.pools.vodafone-ip.de ([92.217.76.63] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oXOJ9-000829-Rt; Sun, 11 Sep 2022 16:51:39 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 6/9] staging: r8188eu: update status before scan blinking
Date:   Sun, 11 Sep 2022 16:51:19 +0200
Message-Id: <20220911145122.15444-7-martin@kaiser.cx>
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

Always update the status variables in rtw_led_control when we start tx/rx
blinking. The if statements are not necessary.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index 358dbbcd5c55..270880050c64 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -291,13 +291,11 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 			return;
 
 		cancel_delayed_work(&pLed->blink_work);
-		if (pLed->bLedNoLinkBlinkInProgress)
-			pLed->bLedNoLinkBlinkInProgress = false;
-
-		if (pLed->bLedLinkBlinkInProgress)
-			pLed->bLedLinkBlinkInProgress = false;
 
+		pLed->bLedNoLinkBlinkInProgress = false;
+		pLed->bLedLinkBlinkInProgress = false;
 		pLed->bLedBlinkInProgress = true;
+
 		pLed->CurrLedState = LED_BLINK_TXRX;
 		pLed->BlinkTimes = 2;
 		if (pLed->bLedOn)
-- 
2.30.2

