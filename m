Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7F25B364C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiIILZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiIILZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:25:39 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6B1D9EB4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:25:38 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id l12so1426821ljg.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=GeuxYakK9Jxo4XzlUulPeGlv4dypsXJd6AyF0HZjyCU=;
        b=XR+svUy8wJX+E1XngVFtHZ7lCkOTAjvHGnfmSztRAeMWwd2eDy62FB2cOsAI3mcLQ9
         YCJBAx70Wtt6rCWbqlUnDIYoccsgPlOjpZnALcAbGuazhdrwDw/vQ4v4+8HjDaf0poyz
         OAud1Ao1xVL9N7o14/PBy2sg8IqqoelVH7TcL6XrBXCc7zoFzJUi+Wy6C7gY+1Q6Wp23
         6f5oYQL+jT7Bb219lfMzvVi+FXxZuAalmb+cN8ez0WJNXfHQYAby2pDuTiSiywgbtaMX
         EsFfUrJrtI5zNTypps1qIULcknT3pKxhJTzsfp2WfdbhB6N8mPWMsoFYHkzV/oMdFhT0
         7MIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=GeuxYakK9Jxo4XzlUulPeGlv4dypsXJd6AyF0HZjyCU=;
        b=XOzLEZiQwRLCGlIkJMqM5fCoaV/hQJqIf/ww2K5RHxVgf8Eu2syF6Ec0ckqR3pVFKS
         NV6lsDmUg1vyyHG8wYs2tlPIabG+wMDCSpx16RkqEmeChPBERNO30NHpyjBQYuRFsSh6
         UFOXHwFO47qORlG1z2ZRvMjBtwNYSsK+3DldYtR6jFmQRH3zk29MNKwsd4Noj/DNxATu
         A1cbZaN8wSl7neu73NVYFvjzRK8HxEyvNVYyZ5adE/FOuZBDZVRlacm9DrNNH2q3hAYJ
         a+0ta9ol9EecpSHneMHVMBrAEDLKI4ee0obe4hepFFXRaSjMAhp586RXlx09l8Uq0SnG
         CWZQ==
X-Gm-Message-State: ACgBeo0oavmED4d+um98KWp8ayWs13fXOArSmOWTrbAXXwDvbE+SZKut
        +fSKM907tl4HW8k1gvs/Jodt6Q==
X-Google-Smtp-Source: AA6agR7tTlNHrdb1qgr7wZSpLphy8PI1ZK4l+a+w9yoVNjzi4BNIm2+yHbBLoLx5Pjfa6X6ELMXkmw==
X-Received: by 2002:a05:651c:210d:b0:266:26b8:31ba with SMTP id a13-20020a05651c210d00b0026626b831bamr3633883ljq.149.1662722736394;
        Fri, 09 Sep 2022 04:25:36 -0700 (PDT)
Received: from fedora.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id x23-20020ac24897000000b004946aef1814sm45469lfc.137.2022.09.09.04.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 04:25:36 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        stable@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] regulator: qcom_rpm: Fix circular deferral regression
Date:   Fri,  9 Sep 2022 13:25:29 +0200
Message-Id: <20220909112529.239143-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On recent kernels, the PM8058 L16 (or any other PM8058 LDO-regulator)
does not come up if they are supplied by an SMPS-regulator. This
is not very strange since the regulators are registered in a long
array and the L-regulators are registered before the S-regulators,
and if an L-regulator defers, it will never get around to registering
the S-regulator that it needs.

See arch/arm/boot/dts/qcom-apq8060-dragonboard.dts:

pm8058-regulators {
    (...)
    vdd_l13_l16-supply = <&pm8058_s4>;
    (...)

Ooops.

Fix this by moving the PM8058 S-regulators first in the array.

Do the same for the PM8901 S-regulators (though this is currently
not causing any problems with out device trees) so that the pattern
of registration order is the same on all PMnnnn chips.

Fixes: 087a1b5cdd55 ("regulator: qcom: Rework to single platform device")
Cc: stable@vger.kernel.org
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/qcom_rpm-regulator.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/qcom_rpm-regulator.c b/drivers/regulator/qcom_rpm-regulator.c
index 7f9d66ac37ff..3c41b71a1f52 100644
--- a/drivers/regulator/qcom_rpm-regulator.c
+++ b/drivers/regulator/qcom_rpm-regulator.c
@@ -802,6 +802,12 @@ static const struct rpm_regulator_data rpm_pm8018_regulators[] = {
 };
 
 static const struct rpm_regulator_data rpm_pm8058_regulators[] = {
+	{ "s0",   QCOM_RPM_PM8058_SMPS0,  &pm8058_smps, "vdd_s0" },
+	{ "s1",   QCOM_RPM_PM8058_SMPS1,  &pm8058_smps, "vdd_s1" },
+	{ "s2",   QCOM_RPM_PM8058_SMPS2,  &pm8058_smps, "vdd_s2" },
+	{ "s3",   QCOM_RPM_PM8058_SMPS3,  &pm8058_smps, "vdd_s3" },
+	{ "s4",   QCOM_RPM_PM8058_SMPS4,  &pm8058_smps, "vdd_s4" },
+
 	{ "l0",   QCOM_RPM_PM8058_LDO0,   &pm8058_nldo, "vdd_l0_l1_lvs"	},
 	{ "l1",   QCOM_RPM_PM8058_LDO1,   &pm8058_nldo, "vdd_l0_l1_lvs" },
 	{ "l2",   QCOM_RPM_PM8058_LDO2,   &pm8058_pldo, "vdd_l2_l11_l12" },
@@ -829,12 +835,6 @@ static const struct rpm_regulator_data rpm_pm8058_regulators[] = {
 	{ "l24",  QCOM_RPM_PM8058_LDO24,  &pm8058_nldo, "vdd_l23_l24_l25" },
 	{ "l25",  QCOM_RPM_PM8058_LDO25,  &pm8058_nldo, "vdd_l23_l24_l25" },
 
-	{ "s0",   QCOM_RPM_PM8058_SMPS0,  &pm8058_smps, "vdd_s0" },
-	{ "s1",   QCOM_RPM_PM8058_SMPS1,  &pm8058_smps, "vdd_s1" },
-	{ "s2",   QCOM_RPM_PM8058_SMPS2,  &pm8058_smps, "vdd_s2" },
-	{ "s3",   QCOM_RPM_PM8058_SMPS3,  &pm8058_smps, "vdd_s3" },
-	{ "s4",   QCOM_RPM_PM8058_SMPS4,  &pm8058_smps, "vdd_s4" },
-
 	{ "lvs0", QCOM_RPM_PM8058_LVS0, &pm8058_switch, "vdd_l0_l1_lvs" },
 	{ "lvs1", QCOM_RPM_PM8058_LVS1, &pm8058_switch, "vdd_l0_l1_lvs" },
 
@@ -843,6 +843,12 @@ static const struct rpm_regulator_data rpm_pm8058_regulators[] = {
 };
 
 static const struct rpm_regulator_data rpm_pm8901_regulators[] = {
+	{ "s0",   QCOM_RPM_PM8901_SMPS0, &pm8901_ftsmps, "vdd_s0" },
+	{ "s1",   QCOM_RPM_PM8901_SMPS1, &pm8901_ftsmps, "vdd_s1" },
+	{ "s2",   QCOM_RPM_PM8901_SMPS2, &pm8901_ftsmps, "vdd_s2" },
+	{ "s3",   QCOM_RPM_PM8901_SMPS3, &pm8901_ftsmps, "vdd_s3" },
+	{ "s4",   QCOM_RPM_PM8901_SMPS4, &pm8901_ftsmps, "vdd_s4" },
+
 	{ "l0",   QCOM_RPM_PM8901_LDO0, &pm8901_nldo, "vdd_l0" },
 	{ "l1",   QCOM_RPM_PM8901_LDO1, &pm8901_pldo, "vdd_l1" },
 	{ "l2",   QCOM_RPM_PM8901_LDO2, &pm8901_pldo, "vdd_l2" },
@@ -851,12 +857,6 @@ static const struct rpm_regulator_data rpm_pm8901_regulators[] = {
 	{ "l5",   QCOM_RPM_PM8901_LDO5, &pm8901_pldo, "vdd_l5" },
 	{ "l6",   QCOM_RPM_PM8901_LDO6, &pm8901_pldo, "vdd_l6" },
 
-	{ "s0",   QCOM_RPM_PM8901_SMPS0, &pm8901_ftsmps, "vdd_s0" },
-	{ "s1",   QCOM_RPM_PM8901_SMPS1, &pm8901_ftsmps, "vdd_s1" },
-	{ "s2",   QCOM_RPM_PM8901_SMPS2, &pm8901_ftsmps, "vdd_s2" },
-	{ "s3",   QCOM_RPM_PM8901_SMPS3, &pm8901_ftsmps, "vdd_s3" },
-	{ "s4",   QCOM_RPM_PM8901_SMPS4, &pm8901_ftsmps, "vdd_s4" },
-
 	{ "lvs0", QCOM_RPM_PM8901_LVS0, &pm8901_switch, "lvs0_in" },
 	{ "lvs1", QCOM_RPM_PM8901_LVS1, &pm8901_switch, "lvs1_in" },
 	{ "lvs2", QCOM_RPM_PM8901_LVS2, &pm8901_switch, "lvs2_in" },
-- 
2.37.3

