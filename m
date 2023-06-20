Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935CB737597
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjFTUDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjFTUDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:03:38 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26181727
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:36 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98802908fedso482697566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687291415; x=1689883415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJ7nRTavTjNVtBrEy1gn6F2ROiTuME9nRILwA8zx4J8=;
        b=OIu7UVO4EyAc5v1waVv43DlilrLBYhjbb+skdC6K2JfpHmGrlnzr104g6zjaOMD4kE
         NnYSk+nxWcRKX6+tC2O3AFb+aMcr4DNWLVi9PHHcbL8x309l41faPLMbNmNjWUCuvpVh
         F25cNeF0VMu3jWocbFNogYX4zAB6rPFtZ4lPHofSaNU9YeTCNEP/qbaR0WlB5RfkLAiZ
         5S9mJNV+4v0G7oeRWsqooGCs2b6A8BTz+PnZrz73rjn+8xFd+WknPTtpqmedgtDrIt9/
         zdGU2GBi+luPCjVxpVl0QU+VylfcGlRwkqVEBUNo8TU/JaI45W7e63kSkSceNwdWS17P
         KW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291415; x=1689883415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJ7nRTavTjNVtBrEy1gn6F2ROiTuME9nRILwA8zx4J8=;
        b=Sme7OGva0K6HL7YCTKyqevC/DYYpS9x6hAoiZO/+TjvbAGhtOduy9UCvW0Lit+GyIw
         FxEdqrb10zq/r9DxsyFqo6bImzjdAnmRlqwzK1ctPWKi8MKYtTnBImdlZeDr5+bpRQUD
         NQRAoofMe1E/MfaLK0541TAdI0c98X9Mx/uttcXXF+A0dcNwSQTdMjU1TDwE2f5Zqm6g
         8QKEqGT9QpGPxPq1x4TwSw1WFyMzNJoYokcMBReY61G8ykfbIWjjasR2qlhkdu4JChZu
         ssOEZn4agaG1CDAuWfKgghCc07H8/q/dtIXIUMfFjCluO2Jy2QEoFOO8OX5krW5CoO63
         206A==
X-Gm-Message-State: AC+VfDzcZxTwkhExmLPa/SEuJ2/iCi1QmZpbFQpyWrW7ISyyAWDmqCow
        cxTKRpeU9SBRvr9ttVZAGVo=
X-Google-Smtp-Source: ACHHUZ6a1mglnPca8iH5MPxaYCuLh1LijlOIGdVT+73prLug3FucblKCBYb9wfn/QEr3y9QMhhlt6w==
X-Received: by 2002:a17:907:72c2:b0:982:3bae:afda with SMTP id du2-20020a17090772c200b009823baeafdamr11567827ejc.45.1687291415224;
        Tue, 20 Jun 2023 13:03:35 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id u21-20020a17090617d500b00977e0bcff1esm1947064eje.10.2023.06.20.13.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:03:34 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Tue, 20 Jun 2023 22:02:56 +0200
Subject: [PATCH RFC v4 03/13] regulator: da9063: implement
 get_active_protections()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dynamic-vmon-v4-3-4d3734e62ada@skidata.com>
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

Implement the new get_active_protections() op. This helps to find out if
a monitor is enabled and the DT is unaware of it. This could result to
an invalid state, as the !PWR_OK state might be triggered if the
regulator is turned off while the monitor stays active.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/regulator/da9063-regulator.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 308ad63fcf78..071b368f154f 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -207,6 +207,24 @@ static const unsigned int da9063_bmem_bio_merged_limits[] = {
 	4600000, 4800000, 5000000, 5200000, 5400000, 5600000, 5800000, 6000000
 };
 
+static int da9063_get_xvp(struct regulator_dev *rdev, unsigned int *state)
+{
+	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_field_read(regl->vmon, &val);
+	if (ret)
+		return ret;
+
+	*state = REGULATOR_MONITOR_NONE;
+	if (val)
+		*state = REGULATOR_MONITOR_OVER_VOLTAGE |
+			 REGULATOR_MONITOR_UNDER_VOLTAGE;
+
+	return 0;
+}
+
 static int da9063_set_xvp(struct regulator_dev *rdev, int lim_uV, int severity, bool enable)
 {
 	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
@@ -580,6 +598,7 @@ static const struct regulator_ops da9063_buck_ops = {
 	.set_suspend_mode		= da9063_buck_set_suspend_mode,
 	.set_over_voltage_protection	= da9063_set_xvp,
 	.set_under_voltage_protection	= da9063_set_xvp,
+	.get_active_protections		= da9063_get_xvp,
 };
 
 static const struct regulator_ops da9063_ldo_ops = {
@@ -598,6 +617,7 @@ static const struct regulator_ops da9063_ldo_ops = {
 	.set_suspend_mode		= da9063_ldo_set_suspend_mode,
 	.set_over_voltage_protection	= da9063_set_xvp,
 	.set_under_voltage_protection	= da9063_set_xvp,
+	.get_active_protections		= da9063_get_xvp,
 };
 
 /* Info of regulators for DA9063 */

-- 
2.34.1

