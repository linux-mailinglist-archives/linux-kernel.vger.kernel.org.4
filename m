Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9671473759D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjFTUDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjFTUDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:03:37 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F9D1716
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9889952ed18so424970766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687291414; x=1689883414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NURFoPzOpzPWAlV9sdcHGrSNeXHdcY9e57Q+SkpU0s=;
        b=QgWGEsbgpWllrg5VSzUBxjJ2pR7k0JX8MX5TF74RBzA4ImRC+S4vK8R/OqqbDS7t06
         0xogVncHLgAYOXq60hXw2b5sAtXndJVw5+gnuD/pBbk1gHHxEB27R4STRIblWgC5ZsFn
         hXfT/oD/2VTExj07Zv+V5ZTZ2BJagyvD3GEubyn4gB68wmqpacsqPSZuEMYeg3qock58
         Nc2qNglbdYRmRe35f5uVE2JU8dcTmD4qI53PBSOiT06Rp9ryvY9sO35U2ro2NmjEB+8w
         94xcTd25Nu+JtB8H2HynJ7ZiHxG9tbrlm5jg73pl+Bo6XQuBSISYMYO82fceF7Q7jyGo
         mjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291414; x=1689883414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NURFoPzOpzPWAlV9sdcHGrSNeXHdcY9e57Q+SkpU0s=;
        b=DO5bk7O4Qzwubwq1LDnd9IUJIzxKc9t15zHjy6GcyHyaUtmBxD6oUR/a0+IXXi8kWK
         2wuBfdjaCZ41EG9F5DWhtWSAuMsbnrz8E8pz4zsKH+lyfx8HmfxmZuej9jLkRNykJIoF
         kcrXwjMl0ko09By6v93sV2IQJ4VBHJoua1IfOV+MRKFeUgRs4Jqe8gBiY/yoJfwpEnTA
         a3LDf7XhkfiuRgdhZ7kSawRNSw0PQ1u+kf2TulCxHlC2RtLchRj1mdx4DsEQbVAbQFcv
         F9sq1NIxptEb9kt3MJhmIOK0yj3b2X9AP4ztNQjsyHInYs/gHEHn/2mItCOevqCKMH+p
         qQ7g==
X-Gm-Message-State: AC+VfDzve+HfmwJ6QY2zlJky0mhSfHSjuHD6v96aJd13CAbznqzgC7Ta
        0rjbC6jRL7YN8BQ6widXW3w=
X-Google-Smtp-Source: ACHHUZ5x80xjwTf15LZ3yfmaApv6rMHkMnyFZVDBlWeWfwve8iE6aqaVoXg/qZvuRqXhaGGMyIaRxA==
X-Received: by 2002:a17:907:844:b0:982:9dc1:a434 with SMTP id ww4-20020a170907084400b009829dc1a434mr12252052ejb.19.1687291414455;
        Tue, 20 Jun 2023 13:03:34 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id u21-20020a17090617d500b00977e0bcff1esm1947064eje.10.2023.06.20.13.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:03:34 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Tue, 20 Jun 2023 22:02:55 +0200
Subject: [PATCH RFC v4 02/13] regulator: add getter for active monitors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dynamic-vmon-v4-2-4d3734e62ada@skidata.com>
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

Add an op to get all active monitors of a regulator. This is useful to
find out if any monitor is turned on, of which the device-tree is not
aware of (e.g. by bootloader or OTP).

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 include/linux/regulator/driver.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index d3b4a3d4514a..9a9163cae769 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -25,6 +25,13 @@ struct regulator_config;
 struct regulator_init_data;
 struct regulator_enable_gpio;
 
+#define REGULATOR_MONITOR_NONE 0x0
+#define REGULATOR_MONITOR_OVER_CURRENT 0x1
+#define REGULATOR_MONITOR_OVER_VOLTAGE 0x2
+#define REGULATOR_MONITOR_UNDER_VOLTAGE 0x4
+#define REGULATOR_MONITOR_OVER_TEMPERATURE 0x8
+#define REGULATOR_MONITOR_ALL 0xF
+
 enum regulator_status {
 	REGULATOR_STATUS_OFF,
 	REGULATOR_STATUS_ON,
@@ -112,6 +119,8 @@ enum regulator_detection_severity {
  * @set_thermal_protection: Support enabling of and setting limits for over
  *	temperature situation detection.Detection can be configured for same
  *	severities as over current protection. Units of degree Kelvin.
+ * @get_active_protections: Get all enabled monitors of a regulator. OR'ed val
+ *	of REGULATOR_MONITOR_*.
  *
  * @set_active_discharge: Set active discharge enable/disable of regulators.
  *
@@ -183,6 +192,7 @@ struct regulator_ops {
 					    int severity, bool enable);
 	int (*set_thermal_protection)(struct regulator_dev *, int lim,
 				      int severity, bool enable);
+	int (*get_active_protections)(struct regulator_dev *dev, unsigned int *state);
 	int (*set_active_discharge)(struct regulator_dev *, bool enable);
 
 	/* enable/disable regulator */

-- 
2.34.1

