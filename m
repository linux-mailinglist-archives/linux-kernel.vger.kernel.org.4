Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9739867F16D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjA0WwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjA0WwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:52:18 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECD17293
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:52:12 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id jl3so6420175plb.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K52wS5rF9aiQPb4ZzRNctCuQfwDm/ySIxaaXnFlTZ9k=;
        b=CYj1UFyU383PUwT9s6xDnJb+MIjyIGvtxMHzsg6tL8bkXVG+35cI4qGSFG3FyDbyDa
         AdNmZW5fvtxFlqK9CrnH07HtFS5kra5CMp943FsnS/VY2XG+/GvNedUyHWNmJigK3yr6
         1W2pLZhn4+x17pJa/NaoOcX/nBxuXrJz1iNWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K52wS5rF9aiQPb4ZzRNctCuQfwDm/ySIxaaXnFlTZ9k=;
        b=2qkMWtxrSg7VV3kt9TVarNzIThLfbRHEFchQYjmMCRjyBRlyXRwQZdNY+wIJLsH/ZK
         5HtlLjfS6UBAlt4NVf5OhY/5IKFl1FIbwDWCxqeCNBj0f+cMmINCl//V1SZ1JT93hzLg
         Y7ZnEdIDdPN+ODQXdD/wWlFM+vDtUkHH3U8tnXU0obfKykS5qjafok+w3jmWlBWY1wX1
         1tIMwbb09QaMZCuV0rQ09CVEH40T4yVRkhNUhVgj1PdMBt+tPIIngTNz13ualLRsKEwz
         VIKpWmBL4G8cAfDGPotqcvuahyb/Kn5nk1Fei9LOniVPFO7XM4vBYse8KBasxXN8krqh
         KOYQ==
X-Gm-Message-State: AO0yUKVHOK076vi656p59vrwCB5+v7y74QMIKwdmmEn6N5qXY6ucDilp
        5VjXrg+RyICpzekrnOdH0ao9Fg==
X-Google-Smtp-Source: AK7set+3U6YSEw7269WmIkaRSvw4QfWyeYqXoZsE8cXauzg9Hm1rjWzDSNNrWWa2mJfwa63PqsVI3g==
X-Received: by 2002:a17:903:ca:b0:196:3f55:f813 with SMTP id x10-20020a17090300ca00b001963f55f813mr6055372plc.41.1674859931452;
        Fri, 27 Jan 2023 14:52:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e80500b00194974a2b3asm3359721plg.151.2023.01.27.14.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 14:52:11 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Javier Martinez Canillas <javier@dowhile0.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] regulator: max77802: Bounds check regulator id against opmode
Date:   Fri, 27 Jan 2023 14:52:07 -0800
Message-Id: <20230127225203.never.864-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4827; h=from:subject:message-id; bh=62KkJ/CLu9oe8dj8hMENNitDv2SDENSHuT320hSmG/M=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj1FWXTez41R3sGZhrmEDTTfPYde+8a4cBIal8Qv07 Iz88bd6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY9RVlwAKCRCJcvTf3G3AJvsYD/ wNI0+n7VbpIZtqQj+NkJ7J2+OSA0TJHsxKMegTxWEnk9Ek/gXu29cAAJ3U0gxtSLiGiAtS9Kv0jC9q gj14I0/MJPVR1ghkd22fBmrwWooLxJBIGEKav+oBC10lh9JQtmRUq3Wrr1sC9b0741BT7CPnx1m7+2 JAUnwWEpphLRV/rNabBKdLv7wRwzldhujCUEVYl3wqZG5CRb3PGN7buiwlCd/naonNAfoMjnG2aHb0 x4/axHK5jcIbc90bg8WrqeJ36TeLX19W8tQvKZs135ipXS0JcJfRoHwu2c5xdBpJ6zrt/Bjd93YEmt 4+TZ8rZxcSGJvXWlF/QZASHbq82WW2u0fk5+TxnMqzeajdfcqaosFEpvy86sfx7cLrWptp/ScQ6cFy UiM9oXUZSkWWJvqcyip5Z2RKPPFbqrFVw9SfWZ6S4yuxjGtQqw2qWPwukXC2UA3dOYa0uZ4W2hFWZp aNfag2H/3RKHOS5uOOaYw0feLDz9DEG+ujGzw2J7QEfatrTjNdzG3MSLtixRbhhUxTRJt37kSXUYtl CYDEe1XZUl+NXkQeV2woQt5RJQZnw+GbuUFGMvJyn02Xfd3O+PhBEiwuv1rnPI0HWiG9Oe4R5O/+QG 6CWtIjBomd3c/dNmOfCx4au1A73HnHPKGxXM8BixM1eTSReFQ1+1kgKwLVIQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly bounds-check the id before accessing the opmode array. Seen
with GCC 13:

../drivers/regulator/max77802-regulator.c: In function 'max77802_enable':
../drivers/regulator/max77802-regulator.c:217:29: warning: array subscript [0, 41] is outside array bounds of 'unsigned int[42]' [-Warray-bounds=]
  217 |         if (max77802->opmode[id] == MAX77802_OFF_PWRREQ)
      |             ~~~~~~~~~~~~~~~~^~~~
../drivers/regulator/max77802-regulator.c:62:22: note: while referencing 'opmode'
   62 |         unsigned int opmode[MAX77802_REG_MAX];
      |                      ^~~~~~

Cc: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/regulator/max77802-regulator.c | 34 ++++++++++++++++++--------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/max77802-regulator.c b/drivers/regulator/max77802-regulator.c
index 21e0eb0f43f9..befe5f319819 100644
--- a/drivers/regulator/max77802-regulator.c
+++ b/drivers/regulator/max77802-regulator.c
@@ -94,9 +94,11 @@ static int max77802_set_suspend_disable(struct regulator_dev *rdev)
 {
 	unsigned int val = MAX77802_OFF_PWRREQ;
 	struct max77802_regulator_prv *max77802 = rdev_get_drvdata(rdev);
-	int id = rdev_get_id(rdev);
+	unsigned int id = rdev_get_id(rdev);
 	int shift = max77802_get_opmode_shift(id);
 
+	if (WARN_ON_ONCE(id >= ARRAY_SIZE(max77802->opmode)))
+		return -EINVAL;
 	max77802->opmode[id] = val;
 	return regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
 				  rdev->desc->enable_mask, val << shift);
@@ -110,7 +112,7 @@ static int max77802_set_suspend_disable(struct regulator_dev *rdev)
 static int max77802_set_mode(struct regulator_dev *rdev, unsigned int mode)
 {
 	struct max77802_regulator_prv *max77802 = rdev_get_drvdata(rdev);
-	int id = rdev_get_id(rdev);
+	unsigned int id = rdev_get_id(rdev);
 	unsigned int val;
 	int shift = max77802_get_opmode_shift(id);
 
@@ -127,6 +129,9 @@ static int max77802_set_mode(struct regulator_dev *rdev, unsigned int mode)
 		return -EINVAL;
 	}
 
+	if (WARN_ON_ONCE(id >= ARRAY_SIZE(max77802->opmode)))
+		return -EINVAL;
+
 	max77802->opmode[id] = val;
 	return regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
 				  rdev->desc->enable_mask, val << shift);
@@ -135,8 +140,10 @@ static int max77802_set_mode(struct regulator_dev *rdev, unsigned int mode)
 static unsigned max77802_get_mode(struct regulator_dev *rdev)
 {
 	struct max77802_regulator_prv *max77802 = rdev_get_drvdata(rdev);
-	int id = rdev_get_id(rdev);
+	unsigned int id = rdev_get_id(rdev);
 
+	if (WARN_ON_ONCE(id >= ARRAY_SIZE(max77802->opmode)))
+		return -EINVAL;
 	return max77802_map_mode(max77802->opmode[id]);
 }
 
@@ -160,10 +167,13 @@ static int max77802_set_suspend_mode(struct regulator_dev *rdev,
 				     unsigned int mode)
 {
 	struct max77802_regulator_prv *max77802 = rdev_get_drvdata(rdev);
-	int id = rdev_get_id(rdev);
+	unsigned int id = rdev_get_id(rdev);
 	unsigned int val;
 	int shift = max77802_get_opmode_shift(id);
 
+	if (WARN_ON_ONCE(id >= ARRAY_SIZE(max77802->opmode)))
+		return -EINVAL;
+
 	/*
 	 * If the regulator has been disabled for suspend
 	 * then is invalid to try setting a suspend mode.
@@ -209,9 +219,11 @@ static int max77802_set_suspend_mode(struct regulator_dev *rdev,
 static int max77802_enable(struct regulator_dev *rdev)
 {
 	struct max77802_regulator_prv *max77802 = rdev_get_drvdata(rdev);
-	int id = rdev_get_id(rdev);
+	unsigned int id = rdev_get_id(rdev);
 	int shift = max77802_get_opmode_shift(id);
 
+	if (WARN_ON_ONCE(id >= ARRAY_SIZE(max77802->opmode)))
+		return -EINVAL;
 	if (max77802->opmode[id] == MAX77802_OFF_PWRREQ)
 		max77802->opmode[id] = MAX77802_OPMODE_NORMAL;
 
@@ -495,7 +507,7 @@ static int max77802_pmic_probe(struct platform_device *pdev)
 
 	for (i = 0; i < MAX77802_REG_MAX; i++) {
 		struct regulator_dev *rdev;
-		int id = regulators[i].id;
+		unsigned int id = regulators[i].id;
 		int shift = max77802_get_opmode_shift(id);
 		int ret;
 
@@ -513,10 +525,12 @@ static int max77802_pmic_probe(struct platform_device *pdev)
 		 * the hardware reports OFF as the regulator operating mode.
 		 * Default to operating mode NORMAL in that case.
 		 */
-		if (val == MAX77802_STATUS_OFF)
-			max77802->opmode[id] = MAX77802_OPMODE_NORMAL;
-		else
-			max77802->opmode[id] = val;
+		if (id < ARRAY_SIZE(max77802->opmode)) {
+			if (val == MAX77802_STATUS_OFF)
+				max77802->opmode[id] = MAX77802_OPMODE_NORMAL;
+			else
+				max77802->opmode[id] = val;
+		}
 
 		rdev = devm_regulator_register(&pdev->dev,
 					       &regulators[i], &config);
-- 
2.34.1

