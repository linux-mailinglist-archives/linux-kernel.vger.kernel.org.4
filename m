Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C935370ADC3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 13:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjEULrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 07:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjEULqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 07:46:05 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21E3E49
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 04:40:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96f53c06babso549932266b.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 04:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684669207; x=1687261207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5+cmzLz6/sx+KBZ1IqAfTTXRmFup3O6Bm7K5a68gJk=;
        b=V2sBcJR6gvj5KaqfKFqHmKHM4+SeAw+djCQInECpMzgh1JxJpHjdWNR+hJciioEJuU
         sgnNpkEMv7NDqqP/HWAVCZCwBaZTwLm93dGZHodMgXCNFMNVdyZuWU243m70lnFjssB+
         KV77DUbQPYIg910BHGSrz6Dx234i6cjhXYtArIvE9wSm9AqOS90A2KDsObAVUPoXkWlK
         lxCBRL+uYvOZUwHipb7WPin4gsa/0uc4Cj8djAxF2jiXOVvnxR/UVZOEUr3dZ3+yST6W
         0aBbIZ3CtmsjYliDMhwR8Hv4myj2xJcfrcwoBYMNEhZVBuCxBM2ynZKK44bdskSSnRzK
         ax9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684669207; x=1687261207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5+cmzLz6/sx+KBZ1IqAfTTXRmFup3O6Bm7K5a68gJk=;
        b=QDpJIZKLyUxDnPbqxzq46IvXMWVaVVLlfPT5wQuMin50FhtyoVT08xePIAzA0QRHRk
         DVQJe2D4KEQN+iAO8UyJocFkWfbG16WBZ/LAanwlHQCo+gLp7E8eKnf+3H3JgtTDshNA
         bbsfoCkex3GwDcqVPv2SCHusVWCvv7J+4xyrCB+rqXw9J6fXDCdBNH7bSa+tIS5QzdDT
         JogL+RgxyfJpcDlH8tBN99apcZ3ZO/sPhDCA09pz0cMFJebKsBRv9UacmlLXuxqwEPHo
         jxQAfpwusg8Q9TSL3yfae2cBsVx53J9p29cjhMogGT8PuUlTqLoGdHtcU0ON38hn7v+j
         /5jA==
X-Gm-Message-State: AC+VfDxUoTp9Uvr6CNyoUvvkrKya0l4gxV/NzxRX7AvDFyUSm2i1ZoOp
        Q/+VGSEKBE9eNktdUNAYMUM=
X-Google-Smtp-Source: ACHHUZ7CgQxi/BlZ4ZA11VDoLFX2kFm9dnMNUX7ESYahIsj3U3CH3dluiB/EGpOMPBdcgekzV5Jzsg==
X-Received: by 2002:a17:907:31ce:b0:96a:6723:da48 with SMTP id xf14-20020a17090731ce00b0096a6723da48mr5845547ejb.75.1684669207146;
        Sun, 21 May 2023 04:40:07 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709070b1900b0096f7996d59csm1833911ejl.184.2023.05.21.04.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 04:40:06 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Sun, 21 May 2023 13:39:52 +0200
Subject: [PATCH RFC v3 3/5] regulator: add getter for active monitors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dynamic-vmon-v3-3-4179b586d8a1@skidata.com>
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

Add an op to get all active monitors of a regulator.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 include/linux/regulator/driver.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index d3b4a3d4514a..35547e9eca48 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -25,6 +25,12 @@ struct regulator_config;
 struct regulator_init_data;
 struct regulator_enable_gpio;
 
+#define REGULATOR_MONITOR_INVALID 0x0
+#define REGULATOR_MONITOR_OVER_CURRENT 0x1
+#define REGULATOR_MONITOR_OVER_VOLTAGE 0x2
+#define REGULATOR_MONITOR_UNDER_VOLTAGE 0x4
+#define REGULATOR_MONITOR_OVER_TEMPERATURE 0x8
+
 enum regulator_status {
 	REGULATOR_STATUS_OFF,
 	REGULATOR_STATUS_ON,
@@ -112,6 +118,8 @@ enum regulator_detection_severity {
  * @set_thermal_protection: Support enabling of and setting limits for over
  *	temperature situation detection.Detection can be configured for same
  *	severities as over current protection. Units of degree Kelvin.
+ * @get_active_protections: Get all enabled monitors of a regulator. OR'ed val
+ *	of REGULATOR_MONITOR_*. REGULATOR_MONITOR_INVALID means no one active.
  *
  * @set_active_discharge: Set active discharge enable/disable of regulators.
  *
@@ -183,6 +191,7 @@ struct regulator_ops {
 					    int severity, bool enable);
 	int (*set_thermal_protection)(struct regulator_dev *, int lim,
 				      int severity, bool enable);
+	int (*get_active_protections)(struct regulator_dev *dev, unsigned int *state);
 	int (*set_active_discharge)(struct regulator_dev *, bool enable);
 
 	/* enable/disable regulator */

-- 
2.34.1

