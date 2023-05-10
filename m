Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D970B6FE071
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbjEJOgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbjEJOf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:35:56 -0400
Received: from exchange.fintech.ru (e10edge.fintech.ru [195.54.195.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0860786A2;
        Wed, 10 May 2023 07:35:44 -0700 (PDT)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 10 May
 2023 17:35:41 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 10 May
 2023 17:35:41 +0300
From:   Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To:     Jean Delvare <jdelvare@suse.com>
CC:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] hwmon: (f71882fg) prevent possible division by zero
Date:   Wed, 10 May 2023 07:35:37 -0700
Message-ID: <20230510143537.145060-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.253.138]
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the unlikely event that something goes wrong with the device and
its registers, the fan_from_reg() function may return 0. This value
will cause a division-by-zero error in the show_pwm() function.

To prevent this, test the value of
fan_from_reg(data->fan_full_speed[nr]) against 0 before performing
the division. If the division-by-zero error is avoided, assign 0 to
the val variable.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: df9ec2dae094 ("hwmon: (f71882fg) Reorder symbols to get rid of a few forward declarations")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 drivers/hwmon/f71882fg.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 70121482a617..27207ec6f7fe 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -1096,8 +1096,11 @@ static ssize_t show_pwm(struct device *dev,
 		val = data->pwm[nr];
 	else {
 		/* RPM mode */
-		val = 255 * fan_from_reg(data->fan_target[nr])
-			/ fan_from_reg(data->fan_full_speed[nr]);
+		if (fan_from_reg(data->fan_full_speed[nr]))
+			val = 255 * fan_from_reg(data->fan_target[nr])
+				/ fan_from_reg(data->fan_full_speed[nr]);
+		else
+			val = 0;
 	}
 	mutex_unlock(&data->update_lock);
 	return sprintf(buf, "%d\n", val);
-- 
2.25.1

