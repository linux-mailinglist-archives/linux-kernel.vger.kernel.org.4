Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D599F727466
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjFHBio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFHBim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:38:42 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 21ED01FF3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 18:38:40 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id C0E5C1801128C4;
        Thu,  8 Jun 2023 09:38:37 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li zeming <zeming@nfschina.com>
To:     jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] time: alarmtimer: Optimization function return value
Date:   Sat, 10 Jun 2023 02:09:55 +0800
Message-Id: <20230609180955.4357-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        RCVD_IN_SBL_CSS,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace -1 return values with -EPERM.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 kernel/time/alarmtimer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 82b28ab0f328..e918d556dd51 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -92,9 +92,9 @@ static int alarmtimer_rtc_add_device(struct device *dev)
 		return -EBUSY;
 
 	if (!test_bit(RTC_FEATURE_ALARM, rtc->features))
-		return -1;
+		return -EPERM;
 	if (!device_may_wakeup(rtc->dev.parent))
-		return -1;
+		return -EPERM;
 
 	pdev = platform_device_register_data(dev, "alarmtimer",
 					     PLATFORM_DEVID_AUTO, NULL, 0);
@@ -104,7 +104,7 @@ static int alarmtimer_rtc_add_device(struct device *dev)
 	spin_lock_irqsave(&rtcdev_lock, flags);
 	if (!IS_ERR(pdev) && !rtcdev) {
 		if (!try_module_get(rtc->owner)) {
-			ret = -1;
+			ret = -EPERM;
 			goto unlock;
 		}
 
@@ -113,7 +113,7 @@ static int alarmtimer_rtc_add_device(struct device *dev)
 		get_device(dev);
 		pdev = NULL;
 	} else {
-		ret = -1;
+		ret = -EPERM;
 	}
 unlock:
 	spin_unlock_irqrestore(&rtcdev_lock, flags);
-- 
2.18.2

