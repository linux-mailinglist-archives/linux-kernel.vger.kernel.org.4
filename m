Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2163E6B1434
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjCHVhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjCHVg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:36:28 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21D9D1ADC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:36:00 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m6so23121219lfq.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678311358;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urmGJAPgwAGGBM7URg5kN0SEKagUfLPIGhnTYX/DEYE=;
        b=GNVYLg9ohWuW/v3/mcICnAg/PJu6Qnk0xgBCKATX+YqfrOteGWMKGJ6x2aceFAPe+U
         Eed8PXwSoxFpmiVN64rjRWJCRU4k0CZZV3JTs8KNCf3rlju0OR7Pe/RM8iHNny+MHlcZ
         ac30gMHU6JmSL0Gmcs5I8CfOmSBO9yR6xlMdCsnK60NVq/mPpA8Cc9lXcPe8tAFTJ9Oh
         6vTBMrNGJE+6OoKu5hdaDu0kId4/ovnbOYzOvuq9HVk0eL43NavA8x86S0STXaWghkML
         eGGrsZP/41ehBnZ3m2XjFF61XJSVMQ2pzIG52PjgPBszQmxmbrSWjh6z7KPliEGGANkt
         2B+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678311358;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urmGJAPgwAGGBM7URg5kN0SEKagUfLPIGhnTYX/DEYE=;
        b=gOL7qh7QPfbHcM8pBxSR1PA+enkbHACU9j0QAVW047nZneZyLjdOvRKtHx9Or4jxNf
         R2X5ms3uIj3pGvUsFN7oIuyaK/iCeqe6TAgFZmxEhyIBKysqJQJzO2OoScZaYlN8mo2P
         DzQND1tsUN/0Wh2l10PBO4Pl/RnGYvV4Yj2Qc0nFYxXSgd/zDEWLqmB/uZ5XMgmsxxHO
         qW5HG0OSJzMlLpLPXGkz1TRQCNZNn/H0dTZ2XRVpz4gm9r6DEUPHGk4bNf1icanMdOrJ
         +MHM0lOKPSCEBStuL1x4yS9DBwRt1wgSBrsyPU3aU0YDmbUK5DzMO9sYFpw0EzvUpcQ+
         kEYA==
X-Gm-Message-State: AO0yUKVYeZSGlF/m8wZHn5UcO1yTRJgzTMNfDC22GVEqGJAM1ojJdNRc
        +x0iWw4sIj7hJowJNFzIZQ4ycg==
X-Google-Smtp-Source: AK7set92Z69NMyyEQP7wB0K4PZMXIufxALGgm1eGkSDTelNQPsB4m1mLnlSOBQbzDg412IiaFtMdNw==
X-Received: by 2002:a19:7609:0:b0:4dd:9931:c4f6 with SMTP id c9-20020a197609000000b004dd9931c4f6mr5223428lff.16.1678311358070;
        Wed, 08 Mar 2023 13:35:58 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id u7-20020ac243c7000000b004dc4d26c324sm2467479lfl.143.2023.03.08.13.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:35:57 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 08 Mar 2023 22:35:29 +0100
Subject: [PATCH RFT v2 13/14] clk: qcom: smd-rpm: Mark clock enabled in
 clk_smd_rpm_handoff()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-rpmcc_sleep-v2-13-ae80a325fe94@linaro.org>
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
In-Reply-To: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678311334; l=2789;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ptSW3wZBetlXgOZ2HWII0h2GkDDWkHkQylreBSIoYDE=;
 b=pVN/1pfoxRb/PkVrgLyzANO7P40tBDrd+dWqphNKXRPek7PH4uHm0+pV220EEBj+mIfB6GdTztpy
 +YM8AiROBnYjd+FexpLOMnYZNLdFEZt3JQjhi/s2TTFeEEiQoQHd
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shawn Guo <shawn.guo@linaro.org>

The result of clock handoff is that the clock is voted by APSS and
enabled by RPM.  So it should be marked as enabled.

This, combined with .is_enabled/prepared will ultimately cause RPM
clocks that were enabled by the bootloader to actually be shut down
if unused. We can only afford to do so if we have a functioning ICC
driver. An immediate thought to test for that can be to provide an
ICC path to the RPMCC node, however that would create a couple of
circular dependencies between GCC/DISPCC/.../RPMCC and ICC.

The next best thing to do without breaking older device trees is to
add an opt-in DTS property. Do just that.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
[Konrad: make conditional, explain the consequences]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index ef3157fd29d5..6736e53e607a 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -197,7 +197,7 @@ struct rpm_smd_clk_desc {
 
 static DEFINE_MUTEX(rpm_smd_clk_lock);
 
-static int clk_smd_rpm_handoff(struct clk_smd_rpm *r)
+static int clk_smd_rpm_handoff(struct clk_smd_rpm *r, bool disable_unused_clks)
 {
 	int ret;
 	struct clk_smd_rpm_req req = {
@@ -222,6 +222,10 @@ static int clk_smd_rpm_handoff(struct clk_smd_rpm *r)
 	if (ret)
 		return ret;
 
+	/* Marking clocks enabled here will trigger unused cleanup */
+	if (disable_unused_clks)
+		r->enabled = true;
+
 	return 0;
 }
 
@@ -1319,6 +1323,7 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
 	struct qcom_smd_rpm *rpm;
 	struct clk_smd_rpm **rpm_smd_clks;
 	const struct rpm_smd_clk_desc *desc;
+	bool disable_unused_clks;
 
 	rpm = dev_get_drvdata(pdev->dev.parent);
 	if (!rpm) {
@@ -1326,6 +1331,14 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	/*
+	 * We can only really park unused clocks if we have a sane interconnect
+	 * driver. Otherwise, the platform may (and probably will) try accessing
+	 * IPs that are hosted on unclocked buses. In an effort not to break
+	 * older DTs, make this an opt-in through a DT property.
+	 */
+	disable_unused_clks = of_property_read_bool(pdev->dev.of_node, "qcom,clk-disable-unused");
+
 	desc = of_device_get_match_data(&pdev->dev);
 	if (!desc)
 		return -EINVAL;
@@ -1339,7 +1352,7 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
 
 		rpm_smd_clks[i]->rpm = rpm;
 
-		ret = clk_smd_rpm_handoff(rpm_smd_clks[i]);
+		ret = clk_smd_rpm_handoff(rpm_smd_clks[i], disable_unused_clks);
 		if (ret)
 			goto err;
 	}

-- 
2.39.2

