Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8286E7375A0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjFTUEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjFTUDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:03:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07591716
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9891c73e0fbso243942066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687291420; x=1689883420;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNh4tw4QJvGCtMKo7byVsd1nt9V3Pw3QyW8v3QEj0hc=;
        b=ofP6NVaf+L5p5/BHd3ox/LW7NB1ATQc+i+qGcrkEMcZxDiaTCrAI5DB5GZ9bu3g/NQ
         +9kT6/X4Opxdn47yjcEafLximoKj21qnj3AYTTIlfzthr2G1LsV+2j8NSe31MczVtqFi
         tqJPNT+GcwNTdQBHztmDxE8MdZD17tVx7IO186wdIokDX0EjLIgiTlKFf44xzy/A3Zck
         mv7DvQr9cRS8gbYxRgueqpe1H7tIWTXWJwYWaTgSovDG97kR4d7wvJo1I4lYGFN9TNwf
         JRSRgYXib7w/3D7xeSxD+CJiB8vN5/Fp0BTXoPeDh1wxtjf4BR2XfqULClD+N+Ik+RyU
         Gc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291420; x=1689883420;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNh4tw4QJvGCtMKo7byVsd1nt9V3Pw3QyW8v3QEj0hc=;
        b=FR7CncsI1l04BlDXtpmctuPGGyreabKuwtyLtptV9/5tutBDKp5ht4ILBhlIrQ4VWK
         6Ael0MHbsey3/Jbj9UBuHsRg1NeSZU/nSQc/iL+wQcvQycn9zAPsOHYZFsrFAxqhwTu3
         ++ggabBjdru+B+4NPls2om17Sood1RRlp9yjldzaMuE0UKN36q0kSwMC+8d/jsC6y2qf
         Z54c9XWxyxmBO2j9H7FUYnnOz+f+KPCBvxgDX6c8/B9mVGoHEt5oxYohBmlTicyfLF1s
         jXXPvyHv3Z2AaLi+fhd0uLyzVySdzdt4iBVb9rmDKBWuMKy1OMymf8uQJdrYSDkZWJ3y
         v+Gw==
X-Gm-Message-State: AC+VfDyNHlg1dmqMe3TALnZiaGshJ9k6j7StzLkUQa9J6pU7m7EzOL5Z
        fAOs4gviDeqyfB9wOh4X+PPiXJtxPSy2GA==
X-Google-Smtp-Source: ACHHUZ50h/yflnso8/WOlipe9aYmBmM9XZHsqDe71S/Er+fciQjuAe/6adkucY4zWxMRHRm++JdBzQ==
X-Received: by 2002:a17:907:1ca8:b0:973:84b0:b077 with SMTP id nb40-20020a1709071ca800b0097384b0b077mr12867396ejc.33.1687291420061;
        Tue, 20 Jun 2023 13:03:40 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id u21-20020a17090617d500b00977e0bcff1esm1947064eje.10.2023.06.20.13.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:03:39 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Tue, 20 Jun 2023 22:03:02 +0200
Subject: [PATCH RFC v4 09/13] regulator: implement mon_disable_reg_disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dynamic-vmon-v4-9-4d3734e62ada@skidata.com>
References: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
In-Reply-To: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
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

The mon_disable_reg_disabled property disables all dt-enabled monitors
before a regulator is disabled. If an error occurs while disabling the
regulator, the monitors are enabled again.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/regulator/core.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 873e53633698..b37dcafff407 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2965,7 +2965,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 
 	trace_regulator_enable_complete(rdev_get_name(rdev));
 
-	return 0;
+	return monitors_reenable(rdev, rdev->desc->mon_disable_reg_disabled);
 }
 
 /**
@@ -3124,8 +3124,13 @@ EXPORT_SYMBOL_GPL(regulator_enable);
 
 static int _regulator_do_disable(struct regulator_dev *rdev)
 {
+	const struct regulator_desc *desc = rdev->desc;
 	int ret;
 
+	ret = monitors_disable(rdev, desc->mon_disable_reg_disabled);
+	if (ret)
+		return ret;
+
 	trace_regulator_disable(rdev_get_name(rdev));
 
 	if (rdev->ena_pin) {
@@ -3136,13 +3141,13 @@ static int _regulator_do_disable(struct regulator_dev *rdev)
 			rdev->ena_gpio_state = 0;
 		}
 
-	} else if (rdev->desc->ops->disable) {
-		ret = rdev->desc->ops->disable(rdev);
+	} else if (desc->ops->disable) {
+		ret = desc->ops->disable(rdev);
 		if (ret != 0)
 			return ret;
 	}
 
-	if (rdev->desc->off_on_delay)
+	if (desc->off_on_delay)
 		rdev->last_off = ktime_get_boottime();
 
 	trace_regulator_disable_complete(rdev_get_name(rdev));
@@ -3180,6 +3185,7 @@ static int _regulator_disable(struct regulator *regulator)
 				_notifier_call_chain(rdev,
 						REGULATOR_EVENT_ABORT_DISABLE,
 						NULL);
+				monitors_reenable(rdev, rdev->desc->mon_disable_reg_disabled);
 				return ret;
 			}
 			_notifier_call_chain(rdev, REGULATOR_EVENT_DISABLE,
@@ -3246,6 +3252,7 @@ static int _regulator_force_disable(struct regulator_dev *rdev)
 		rdev_err(rdev, "failed to force disable: %pe\n", ERR_PTR(ret));
 		_notifier_call_chain(rdev, REGULATOR_EVENT_FORCE_DISABLE |
 				REGULATOR_EVENT_ABORT_DISABLE, NULL);
+		monitors_reenable(rdev, rdev->desc->mon_disable_reg_disabled);
 		return ret;
 	}
 
@@ -6422,8 +6429,10 @@ static int regulator_late_cleanup(struct device *dev, void *data)
 		 */
 		rdev_info(rdev, "disabling\n");
 		ret = _regulator_do_disable(rdev);
-		if (ret != 0)
+		if (ret != 0) {
 			rdev_err(rdev, "couldn't disable: %pe\n", ERR_PTR(ret));
+			monitors_reenable(rdev, rdev->desc->mon_disable_reg_disabled);
+		}
 	} else {
 		/* The intention is that in future we will
 		 * assume that full constraints are provided

-- 
2.34.1

