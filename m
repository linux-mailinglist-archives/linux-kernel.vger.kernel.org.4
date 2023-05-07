Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFDD6F9B63
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 22:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjEGUNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 16:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjEGUMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 16:12:53 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3678E9EDE;
        Sun,  7 May 2023 13:12:52 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2ac88d9edf3so30592031fa.0;
        Sun, 07 May 2023 13:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683490370; x=1686082370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCrDWBMl4hp0qteih67nrdBeByN0/6V+auuAerq2y3I=;
        b=lXyF+mWYZ/lclt94np36RrvdvzVK+xZ/Y8pF/WReS3A+yVrnqIxIj0dRM2PhWWVbOP
         VDik2MrWVnSGdeIbKwH+Z5+jD3GQe4cODADYjICM3P9MqTINQaAcDuEw4Xfg9AJSlUXO
         VLvPe7MG2ZiL+yJ5IrpqCJbbvJnjh39nhAfQzst8hy7Zwh2zGFUDt6ewzEmu3dkn6Izk
         d/Oz6Jv6KFfpVkkdiNOSR+/euulOeC3W7GSW3FJcBDd6Z898tRjCgtqOG+h53Jeb9TBx
         ild4P+AF5IX5DluvMv9HFyzDHMLuFBSh1ifomVtb4Ea0Swp/ZsO/csagoLmfh21m2pN9
         OkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683490370; x=1686082370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCrDWBMl4hp0qteih67nrdBeByN0/6V+auuAerq2y3I=;
        b=Q9jUaGPYmuT5cnfYwZWZBsGB7I2iQdC51GJo+sVZCQ0LCwq8yEbM6Qr8ObXAoe1Vy7
         mTNdkJvjBZeBYa/S8aYa8n4+LhdwcqlPPeKhDydilVot/karnOWvNAhBWG1zfszGBMxY
         e1etzkSSPWKuNS+PFG6Pm2ptXbMFtNt7fpmlEc/cJuFlNA11XBkFpRvBwjuaW1QQRiQh
         OdqUENnMrRNNSPbvEckpP3luOHhC+0vj66NL1gI/eutyuzothlw1YI0ipO69EN61UHNa
         17vYLPhGc7KDEPmE69nYdls4mvk7uw937XDe4/qPm/2WEK259nAEVWaDFB53BHPVf9HY
         gIPw==
X-Gm-Message-State: AC+VfDwwUtvjWDkFtGbjWJOHW1pBX9XLEZS5QsNqmt6OYRk350x28zlH
        ylnJWNVmSs2DG9ahFjiLvJn4l54G8+iQJQ==
X-Google-Smtp-Source: ACHHUZ4a5ixUlJacIqpdc93Y2jU4S98+GrQO7eiSd1Yo5KmaW4TSqUkOzCIYB4DTKP/IIWKpxA8fCA==
X-Received: by 2002:a2e:818c:0:b0:2ad:1b99:beb6 with SMTP id e12-20020a2e818c000000b002ad1b99beb6mr1296280ljg.34.1683490370147;
        Sun, 07 May 2023 13:12:50 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id m19-20020a2e9113000000b00293d7c95df1sm918031ljg.78.2023.05.07.13.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 13:12:49 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] thermal/drivers/qcom/tsens-v0_1: Add support for MSM8226
Date:   Sun,  7 May 2023 23:12:21 +0300
Message-Id: <20230507201225.89694-4-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
References: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MSM8226 TSENS IP has 6 thermal sensors in a TSENS v0.1 block.
The thermal sensors use non-standard slope values.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 drivers/thermal/qcom/tsens-v0_1.c | 27 ++++++++++++++++++++++++++-
 drivers/thermal/qcom/tsens.c      |  3 +++
 drivers/thermal/qcom/tsens.h      |  2 +-
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index e89c6f39a3ae..ad57ab94546b 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -243,6 +243,18 @@ static int calibrate_8974(struct tsens_priv *priv)
 	return 0;
 }
 
+static int __init init_8226(struct tsens_priv *priv)
+{
+	priv->sensor[0].slope = 2901;
+	priv->sensor[1].slope = 2846;
+	priv->sensor[2].slope = 3038;
+	priv->sensor[3].slope = 2955;
+	priv->sensor[4].slope = 2901;
+	priv->sensor[5].slope = 2846;
+
+	return init_common(priv);
+}
+
 static int __init init_8939(struct tsens_priv *priv) {
 	priv->sensor[0].slope = 2911;
 	priv->sensor[1].slope = 2789;
@@ -258,7 +270,7 @@ static int __init init_8939(struct tsens_priv *priv) {
 	return init_common(priv);
 }
 
-/* v0.1: 8916, 8939, 8974, 9607 */
+/* v0.1: 8226, 8916, 8939, 8974, 9607 */
 
 static struct tsens_features tsens_v0_1_feat = {
 	.ver_major	= VER_0_1,
@@ -313,6 +325,19 @@ static const struct tsens_ops ops_v0_1 = {
 	.get_temp	= get_temp_common,
 };
 
+static const struct tsens_ops ops_8226 = {
+	.init		= init_8226,
+	.calibrate	= tsens_calibrate_common,
+	.get_temp	= get_temp_common,
+};
+
+struct tsens_plat_data data_8226 = {
+	.num_sensors	= 6,
+	.ops		= &ops_8226,
+	.feat		= &tsens_v0_1_feat,
+	.fields	= tsens_v0_1_regfields,
+};
+
 static const struct tsens_ops ops_8916 = {
 	.init		= init_common,
 	.calibrate	= calibrate_8916,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 8020ead2794e..eb33a8bf0488 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1095,6 +1095,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,mdm9607-tsens",
 		.data = &data_9607,
+	}, {
+		.compatible = "qcom,msm8226-tsens",
+		.data = &data_8226,
 	}, {
 		.compatible = "qcom,msm8916-tsens",
 		.data = &data_8916,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index dba9cd38f637..433eba370998 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -635,7 +635,7 @@ int get_temp_common(const struct tsens_sensor *s, int *temp);
 extern struct tsens_plat_data data_8960;
 
 /* TSENS v0.1 targets */
-extern struct tsens_plat_data data_8916, data_8939, data_8974, data_9607;
+extern struct tsens_plat_data data_8226, data_8916, data_8939, data_8974, data_9607;
 
 /* TSENS v1 targets */
 extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;
-- 
2.34.1

