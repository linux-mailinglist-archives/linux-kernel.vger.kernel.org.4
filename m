Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAF770ADC2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 13:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjEULrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 07:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjEULqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 07:46:05 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB3AE46
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 04:40:07 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96fbc74fbf1so103276666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 04:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684669206; x=1687261206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPGXCIV+plZCCdzziB6S7Ng67mf6lvRgxH4hTs2ibfc=;
        b=oAtW79EvYmAzL5FZxdLAQJ1Dwxan8iNCa+64waGBTJq1IB1EUFfPGFeapNiySACZ2f
         xiCsgyTJIvf6LkqyD44LeapgnGlE/0zqtWpornA5DFDz3T6S7PPsAV9ji70Pat6/LTlG
         Frz2XjYbkHlo2Rr68+vr/0hfbno2Bz45dJTmRL4wmAlLnmrNBrmAh+Kgq5ocJ7LiEQtQ
         xcsRh9C2HFoGRPo4kENIl64MGtt/Xbq12/gSo7d9LOFMGbq9MBX+ljQA2uTrFkJYtH/v
         QZDPjpqJWcM/zBhH8PVeEDrxQ2qIvAeD2oQmqWbX2cg5r9VRgg7+2XL7OkgpqyeaGVlu
         ZVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684669206; x=1687261206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPGXCIV+plZCCdzziB6S7Ng67mf6lvRgxH4hTs2ibfc=;
        b=Nf7cj9DmYFfOo1UczdpRyEhRO4SU49zSG30wDpoxoRkRiFp1+D7dgxbz2A4iD6XoVR
         uOqVy1Qn6SEndqmuTqedWZ/PjlOKtKoc39Fp499I1X/aNpF8zQ92shjtu2YkltaZgm9+
         +qugN5pHM++eP2TEuE02zhNFH8K0nOOSbBuq4umS4Ub7cPUoRrnADYCFbGLiTuaU796u
         PAR1+SWhchLK4lEkg9tdKdQtN2QoDOrLkeOkHGSjd5vc+4f6jiNjAeYPu9S/s4DVfi2I
         o9Lsurhdv81955O1d8KxrZKj0YMeR4NCQ8NZo1jwSCJatD/QVUKqS9d+lw3rEjGpufO2
         Cszw==
X-Gm-Message-State: AC+VfDwNYKdyJMIglzsLm/yINrw5v/lsE//wlOvUC1FH89/m/Li0KcLc
        Mo3SyAzpZAmxddDnzspjCLo=
X-Google-Smtp-Source: ACHHUZ5ugiYydXwfcpYi4n7scOcKuUXjWTEeqmH5P3R1Bosn8ghe2AVxBktG3D2zu7BUMOu+jrV2KQ==
X-Received: by 2002:a17:906:ef0e:b0:96a:1260:dbf5 with SMTP id f14-20020a170906ef0e00b0096a1260dbf5mr6357702ejs.45.1684669206223;
        Sun, 21 May 2023 04:40:06 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709070b1900b0096f7996d59csm1833911ejl.184.2023.05.21.04.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 04:40:06 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Sun, 21 May 2023 13:39:51 +0200
Subject: [PATCH RFC v3 2/5] regulator: disable monitors when regulator is
 disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dynamic-vmon-v3-2-4179b586d8a1@skidata.com>
References: <20230419-dynamic-vmon-v3-0-4179b586d8a1@skidata.com>
In-Reply-To: <20230419-dynamic-vmon-v3-0-4179b586d8a1@skidata.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

This disables all enabled monitors before a regulator is disabled. This
only happens if an protection is enabled in the device-tree. If an error
occurs while disabling the regulator, the monitors are enabled again.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/regulator/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 76f112817f9d..e59204920d6c 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2828,7 +2828,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 
 	trace_regulator_enable_complete(rdev_get_name(rdev));
 
-	return 0;
+	return monitors_set_state(rdev, true);
 }
 
 /**
@@ -2989,6 +2989,10 @@ static int _regulator_do_disable(struct regulator_dev *rdev)
 {
 	int ret;
 
+	ret = monitors_set_state(rdev, false);
+	if (ret)
+		return ret;
+
 	trace_regulator_disable(rdev_get_name(rdev));
 
 	if (rdev->ena_pin) {
@@ -3043,6 +3047,7 @@ static int _regulator_disable(struct regulator *regulator)
 				_notifier_call_chain(rdev,
 						REGULATOR_EVENT_ABORT_DISABLE,
 						NULL);
+				monitors_set_state(rdev, true);
 				return ret;
 			}
 			_notifier_call_chain(rdev, REGULATOR_EVENT_DISABLE,
@@ -3109,6 +3114,7 @@ static int _regulator_force_disable(struct regulator_dev *rdev)
 		rdev_err(rdev, "failed to force disable: %pe\n", ERR_PTR(ret));
 		_notifier_call_chain(rdev, REGULATOR_EVENT_FORCE_DISABLE |
 				REGULATOR_EVENT_ABORT_DISABLE, NULL);
+		monitors_set_state(rdev, true);
 		return ret;
 	}
 
@@ -6251,8 +6257,10 @@ static int regulator_late_cleanup(struct device *dev, void *data)
 		 */
 		rdev_info(rdev, "disabling\n");
 		ret = _regulator_do_disable(rdev);
-		if (ret != 0)
+		if (ret != 0) {
 			rdev_err(rdev, "couldn't disable: %pe\n", ERR_PTR(ret));
+			monitors_set_state(rdev, true);
+		}
 	} else {
 		/* The intention is that in future we will
 		 * assume that full constraints are provided

-- 
2.34.1

