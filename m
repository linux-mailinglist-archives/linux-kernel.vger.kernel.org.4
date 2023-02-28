Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231EF6A5A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjB1Nzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjB1Nz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:55:28 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5681EBEF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:55:27 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pX0Rt-0007wv-33; Tue, 28 Feb 2023 14:55:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pX0Rr-000sdC-Si; Tue, 28 Feb 2023 14:55:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pX0Rr-0011dg-0Q; Tue, 28 Feb 2023 14:55:19 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Munehisa Kamata <kamatam@amazon.com>,
        Benson Leung <bleung@chromium.org>
Cc:     Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 2/4] pwm: cros-ec: Explicitly set .polarity in .get_state()
Date:   Tue, 28 Feb 2023 14:55:06 +0100
Message-Id: <20230228135508.1798428-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230228135508.1798428-1-u.kleine-koenig@pengutronix.de>
References: <20230228135508.1798428-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=749; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=IAtiCGV0wRa2U+/PppANZkZKRqaD1N3SRiIodPKqHTk=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBj/gevfhS7IyOpnmkoKmE420NdX4odBQ8eZG4d2 I2ybrXNvZCJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY/4HrwAKCRDB/BR4rcrs Ceq2B/9uCvaS+h95L+nfKjNahQfxtSyvPKw84Bl5AdHl2eN8Dy3mvqKAj725tx3O8JoslREBw4/ k1yU9cCbtDN000837fApwnhAo5parWgJLsStdKIuE8ddcjtwTFLlku5s7gtUkPT/DxCAb7pE9Wz jsltzncD+SOAQAJi2mZqE1GYrVMBTqUDc5JtB1RW/Z0H4/jq00y1p4T9i8Xxhy4N8LpYeax+Xnu gYp9kfIyT/KWyGBhbndnN+QCxFC8kgs03aonHEF8uflNO3hVQwOAnRJFqN3tLWwBnvZpZJaKOEf nuL3FO6V8tuHZwwslunaK8Ex15qdmjfaNLhFqXxRhVXOpWF1
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver only supports normal polarity. Complete the implementation of
.get_state() by setting .polarity accordingly.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-cros-ec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 86df6702cb83..ad18b0ebe3f1 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -198,6 +198,7 @@ static int cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	state->enabled = (ret > 0);
 	state->period = EC_PWM_MAX_DUTY;
+	state->polarity = PWM_POLARITY_NORMAL;
 
 	/*
 	 * Note that "disabled" and "duty cycle == 0" are treated the same. If
-- 
2.39.1

