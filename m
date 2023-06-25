Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153F173D04E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 13:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjFYLLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 07:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjFYLLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 07:11:48 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A97118;
        Sun, 25 Jun 2023 04:11:47 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 30E97CEF26;
        Sun, 25 Jun 2023 11:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1687691505; bh=J9jEPcx35Z5VZe9C9tWJdEOLs/nTvAKqqUQBcM//nqs=;
        h=From:Date:Subject:To:Cc;
        b=ZTaOJvnWvHNVZZOo5ByIpJ4x+KlTSI7Sj95fBInT9p8MxgFqDh5iqFooy4Jr55H7I
         gHBS2vyubRfhHkRfp6A3mvYVVcDw5p4o809SZUTVNWM177RRKmdicis1CdMG+HG1wn
         PQ6QwdKryccfHWB6zFiqc2ZgxLrIV985lUsN7Uis=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 25 Jun 2023 13:11:33 +0200
Subject: [PATCH] thermal/drivers/qcom/temp-alarm: Use dev_err_probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230625-spmi-temp-alarm-defer-v1-1-2d57acf36855@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIAOQgmGQC/x2N0QrCMAwAf2Xk2UDtNqn+iviQbpkLtLWkU4Sxf
 zf4eAfH7dBYhRvcuh2UP9LkVQzOpw6mlcqTUWZj8M737uJHbDULbpwrUiLNOPPCii6EawxuHAb
 uwdpIjTEqlWm1urxTMlmVF/n+Z/fHcfwABt/pPnwAAAA=
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2434; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=J9jEPcx35Z5VZe9C9tWJdEOLs/nTvAKqqUQBcM//nqs=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkmCDtc1cXyq8Q5wrREWnpoRf9hEL/1VSO6b6NE
 xzAuZiyZQeJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZJgg7QAKCRBy2EO4nU3X
 VomyEAC1VhrEgpBghMAwvSNzEy1D7IPcSBEygZuyinpKla3Kok+wCKdAoQeOAXT6XJoqQ+fkYm1
 yCMbX/KYKloLmmk7jFJE2lD9acv6hv6DJJMQ5jVgzNBDY4V7dbYt2KtVwrkCrraPM25XPHFP6EF
 VAjoAYW8+i0TPdh9avP8L+95CfVen0Wm4TidFN/mXBIB39cfBNAn36vtfBYqocEwqPJX/IFLrNa
 pNRAXlrPysutQq7GMoXzChiy65N7NlYIKf8yxEys/9fP3kkwlRNRY78rmaT0O8zfZHKno0vRNVO
 wcNOQ1sP9RbQb2ESpqL3o249aC9z0Dgk4HmRBENVnuAtCpe0Kk3Kn15gxF7i0UCauUr/VUEe3rj
 YD+3NKew3yxQTxqgLW8uhaUVAA4PIkscUxM8DNFfKYCO1CAvijlVJKAgfQIhs1n6I2q127bCogW
 S5eNExxx+QnEc1I58G1YOKzFGq3FTy5Vtkv2PqzBoIySagUEWjKnjR4KwfuEG8yK4Tp7TKBS1js
 1R3g7CPnePZMskrsERKbegPYhJ51yUk5Qr4VVqngagXXesJI/T4IQ4+Gz1/bSx42ulxxpQUptkQ
 gMcYYFElPet5P5sdoPQbozjzliP9/8/38A7tvKvc227JPAl3krsRIEffKC6Nioq4d6CnWDVIdv8
 imLJ3uPndRAWc9Q==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the dev_err_probe function instead of dev_err in the probe function
so that the printed message includes the return value and also handles
-EPROBE_DEFER nicely.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 34 ++++++++++++-----------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 2a3b3e21260f..0e8ebfcd84c5 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -411,22 +411,19 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	chip->base = res;
 
 	ret = qpnp_tm_read(chip, QPNP_TM_REG_TYPE, &type);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "could not read type\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "could not read type\n");
 
 	ret = qpnp_tm_read(chip, QPNP_TM_REG_SUBTYPE, &subtype);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "could not read subtype\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "could not read subtype\n");
 
 	ret = qpnp_tm_read(chip, QPNP_TM_REG_DIG_MAJOR, &dig_major);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "could not read dig_major\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "could not read dig_major\n");
 
 	if (type != QPNP_TM_TYPE || (subtype != QPNP_TM_SUBTYPE_GEN1
 				     && subtype != QPNP_TM_SUBTYPE_GEN2)) {
@@ -448,16 +445,13 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	 */
 	chip->tz_dev = devm_thermal_of_zone_register(
 		&pdev->dev, 0, chip, &qpnp_tm_sensor_ops);
-	if (IS_ERR(chip->tz_dev)) {
-		dev_err(&pdev->dev, "failed to register sensor\n");
-		return PTR_ERR(chip->tz_dev);
-	}
+	if (IS_ERR(chip->tz_dev))
+		return dev_err_probe(&pdev->dev, PTR_ERR(chip->tz_dev),
+				     "failed to register sensor\n");
 
 	ret = qpnp_tm_init(chip);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "init failed\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "init failed\n");
 
 	devm_thermal_add_hwmon_sysfs(&pdev->dev, chip->tz_dev);
 

---
base-commit: 8d2be868b42c08290509c60515865f4de24ea704
change-id: 20230625-spmi-temp-alarm-defer-0889b80544e3

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

