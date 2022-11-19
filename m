Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F54F630ACA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 03:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiKSCgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 21:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbiKSCgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 21:36:02 -0500
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397C77C027;
        Fri, 18 Nov 2022 18:22:43 -0800 (PST)
Received: from pride-PowerEdge-R740.. ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 2AJ2MJj5008882-2AJ2MJj8008882
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 19 Nov 2022 10:22:24 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] leds: leds-lp5521/3: fix uninitialized variable ret
Date:   Sat, 19 Nov 2022 10:22:16 +0800
Message-Id: <20221119022217.2474222-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports the following uninitialized symbols:

drivers/leds/leds-lp5521.c:368 lp5521_multicolor_brightness()
error: uninitialized symbol 'ret'.
drivers/leds/leds-lp5523.c:811 lp5523_multicolor_brightness()
error: uninitialized symbol 'ret'.

Fix these issues by initializing ret with zero value.

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/leds/leds-lp5521.c | 2 +-
 drivers/leds/leds-lp5523.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-lp5521.c b/drivers/leds/leds-lp5521.c
index 7ff20c260504..cef46a8b4cab 100644
--- a/drivers/leds/leds-lp5521.c
+++ b/drivers/leds/leds-lp5521.c
@@ -352,7 +352,7 @@ static int lp5521_run_selftest(struct lp55xx_chip *chip, char *buf)
 static int lp5521_multicolor_brightness(struct lp55xx_led *led)
 {
 	struct lp55xx_chip *chip = led->chip;
-	int ret;
+	int ret = 0;
 	int i;
 
 	mutex_lock(&chip->lock);
diff --git a/drivers/leds/leds-lp5523.c b/drivers/leds/leds-lp5523.c
index 369d40b0b65b..e0387639946e 100644
--- a/drivers/leds/leds-lp5523.c
+++ b/drivers/leds/leds-lp5523.c
@@ -795,7 +795,7 @@ static ssize_t store_master_fader_leds(struct device *dev,
 static int lp5523_multicolor_brightness(struct lp55xx_led *led)
 {
 	struct lp55xx_chip *chip = led->chip;
-	int ret;
+	int ret = 0;
 	int i;
 
 	mutex_lock(&chip->lock);
-- 
2.34.1

