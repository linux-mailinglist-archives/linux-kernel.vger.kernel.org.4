Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEB36AF71C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 22:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjCGVBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 16:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjCGVBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 16:01:04 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC559E521;
        Tue,  7 Mar 2023 13:00:56 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 610075FD31;
        Wed,  8 Mar 2023 00:00:53 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1678222853;
        bh=n7uelarKUUaeZ2SnEaQ3vwbd0u3Zv00FrAdmQ5cpVvY=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=i1v+rF0zh/wcscwgQJcUwBai8ousVafggtpd/rfB9noAmOTM9VfTk0Hxh06bHWz9w
         ZoRS8vKwLXINCde2jFPiXtCdxBTbrMUpAWuIwrr3lFjy5/0pK7RiCzRAsYa5+Rvpe4
         472JEhHDOpQ/81/lyMZGtw3UKcXOX9Ehynf4TuTBGDfhenbtNw3vpfIiWdzOnUsoFO
         419KseiiJqsuD6u9VcdL6OFrCECbYBBJCI6xuy0TwbwSzvLiw94eZEbIGlHDZgObN7
         HY0kZLf8SpVogbj+WouX20gOPZAkeAa4Af00HDhqVPFkzhfONTw0uqFXfwiBKi4l4z
         0Y+m4Wbs5X2Vg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed,  8 Mar 2023 00:00:51 +0300 (MSK)
From:   George Stark <gnstark@sberdevices.ru>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <krzysztof.kozlowski@linaro.org>, <alim.akhtar@samsung.com>
CC:     <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@sberdevices.ru>,
        <gnstark@sberdevices.ru>, George Stark <GNStark@sberdevices.ru>
Subject: [RFC PATCH v1] Revert "pwm: Clear chip_data in pwm_put()"
Date:   Wed, 8 Mar 2023 00:00:14 +0300
Message-ID: <20230307210014.1380102-1-gnstark@sberdevices.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/07 18:59:00 #20923273
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Stark <GNStark@sberdevices.ru>

This reverts commit e926b12c611c2095c7976e2ed31753ad6eb5ff1a.

There're several issues with the original change:

- it breaks generic semantics of set_driver_data-like routines that
only client code controls lifetime of it's own data.

- it breaks pwm-sti.c driver: pwm_set_chip_data is used only in probe stage
then pwm_get_chip_data used in capture callback

Change-Id: I5787c6b4c520d4a0997567c416b26fa4e0806b94
Signed-off-by: George Stark <GNStark@sberdevices.ru>
---
 drivers/pwm/core.c        | 1 -
 drivers/pwm/pwm-berlin.c  | 1 +
 drivers/pwm/pwm-samsung.c | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index e01147f66e15..3bc644cc16fe 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1036,7 +1036,6 @@ void pwm_put(struct pwm_device *pwm)
 	if (pwm->chip->ops->free)
 		pwm->chip->ops->free(pwm->chip, pwm);
 
-	pwm_set_chip_data(pwm, NULL);
 	pwm->label = NULL;
 
 	module_put(pwm->chip->ops->owner);
diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index e157273fd2f7..953cc2bba314 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -84,6 +84,7 @@ static void berlin_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct berlin_pwm_channel *channel = pwm_get_chip_data(pwm);
 
+	pwm_set_chip_data(pwm, NULL);
 	kfree(channel);
 }
 
diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 9c5b4f515641..7e5dbdd6fc64 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -249,6 +249,7 @@ static int pwm_samsung_request(struct pwm_chip *chip, struct pwm_device *pwm)
 static void pwm_samsung_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	kfree(pwm_get_chip_data(pwm));
+	pwm_set_chip_data(pwm, NULL);
 }
 
 static int pwm_samsung_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-- 
2.38.4

