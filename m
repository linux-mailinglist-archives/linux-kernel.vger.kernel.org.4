Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63A56AA9E0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 14:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCDN16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 08:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCDN1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 08:27:48 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415391688D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 05:27:47 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id s22so6998951lfi.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 05:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677936467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CE+JnL554VLPGrdcTc20YFzCGjPgavHLDXyWnjlT8uQ=;
        b=hFDetAD7Gf3Uoj9lcHwDSwjbA+lpTNVXi9aHpKFB9gJOVRf6NZ287JAKeFQZAT5I4H
         Q5C/XumQWPXNO0bIN4ZIWaw3eFojXM49nlbFqWFbB4v/QHyjk27LbIBVIQNhuOMpsCmT
         cIHvA7bWUl+ddj8XnggIDpf6/aG+VInJvMLqoF2Tl8oBPZ0lrNkqlal6AzuWDCdUp50Z
         bIgpBuCG/uWpHt9EIYUerv9yW6ROHy7AY/7NOhGe5zf3zz6cp1XzeNSQki5jkRCfdsK5
         nuGylEvFzQAkf7hNobrBhFetuWyxTvmv+FNt1tHPV187WkUOf/MfuqeWBtBgDV9P3T9p
         f2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677936467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CE+JnL554VLPGrdcTc20YFzCGjPgavHLDXyWnjlT8uQ=;
        b=NK2ma4IPkMRR0ojaRwqMJYBb/P7TUKyAKpuClu+S//VdCLXV+ySqGZ4yneGBIfLYBR
         VlVJqJ94+jZNPas5PBQF5a18q3n4Z+2T6L1iSUqiVPdiI1QfhejlTH7nKD+LN9dxce62
         AtDLy8oPppbCVYOXfa41HYA8RVQOG3jn2t3bc9q59IsUal85dQmMxh3uGTDztmBKrE23
         N3KqNAOmYKrqHOqJJo96+7D9+seVE7dahhQczy76m4cI+5nkCyVbSzww+ucanTuDRVdc
         nN4D/gu0cG7BB2yrwUQBPZDYmfhqISikfXzaT7Bvt7sTkWq0+0DcFFkkmkjdYG991Y7x
         0+Ng==
X-Gm-Message-State: AO0yUKUs1sssunalYB3ie5Nq7jb5Uf/1EJX5lENNLKt5uGiK1OkwsSwh
        FKvGlTEAtI1WoSOtxhlPY7raOg==
X-Google-Smtp-Source: AK7set9Cqm4WAuyCFKHRyedsaPR4X+/m2vJJOe9x8dDgR1qnb9vqqd4H+k3gbsPWadxEbxydFh7MWQ==
X-Received: by 2002:a05:6512:249:b0:4dc:4cb6:6752 with SMTP id b9-20020a056512024900b004dc4cb66752mr1399674lfo.52.1677936466825;
        Sat, 04 Mar 2023 05:27:46 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id j15-20020a19f50f000000b004e7fa99f2b5sm342975lfb.186.2023.03.04.05.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 05:27:46 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 04 Mar 2023 14:27:38 +0100
Subject: [PATCH RFT 03/20] clk: qcom: smd-rpm: Add support for keepalive
 votes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-rpmcc_sleep-v1-3-d9cfaf9b27a7@linaro.org>
References: <20230303-topic-rpmcc_sleep-v1-0-d9cfaf9b27a7@linaro.org>
In-Reply-To: <20230303-topic-rpmcc_sleep-v1-0-d9cfaf9b27a7@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677936461; l=2703;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=VBzwbaXA+dk9JgBRximop+B+UNGSjqkXnpU8yOYDpzg=;
 b=vRvRa3GKRs17Whe+QiRk3sO5TcIbgjnytITqODU1Z5zQCAVGQX2c1QUVNHaml1lKhqyNINZN7wAh
 2up2QNTxBKgrxReKmOcfWimBYf+3AVFi4y7oV5nKza0tDL5Kx8v3
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some bus clock should always have a minimum (19.2 MHz) vote cast on
them, otherwise the platform will fall apart, hang and reboot.

Add support for specifying which clocks should be kept alive and
always keep a vote on XO_A to make sure the clock tree doesn't
collapse. This removes the need to keep a maximum vote that was
previously guaranteed by clk_smd_rpm_handoff.

This commit is a combination of existing (not-exactly-upstream) work
by Taniya Das, Shawn Guo and myself.

Co-developed-by: Shawn Guo <shawn.guo@linaro.org>
Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index cce7daa97c1e..8e017c575361 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2014, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/export.h>
@@ -178,6 +179,8 @@ struct clk_smd_rpm_req {
 struct rpm_smd_clk_desc {
 	struct clk_smd_rpm **clks;
 	size_t num_clks;
+	struct clk_hw **keepalive_clks;
+	size_t num_keepalive_clks;
 };
 
 static DEFINE_MUTEX(rpm_smd_clk_lock);
@@ -1278,6 +1281,7 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
 	struct qcom_smd_rpm *rpm;
 	struct clk_smd_rpm **rpm_smd_clks;
 	const struct rpm_smd_clk_desc *desc;
+	struct clk_hw **keepalive_clks;
 
 	rpm = dev_get_drvdata(pdev->dev.parent);
 	if (!rpm) {
@@ -1291,6 +1295,7 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
 
 	rpm_smd_clks = desc->clks;
 	num_clks = desc->num_clks;
+	keepalive_clks = desc->keepalive_clks;
 
 	for (i = 0; i < num_clks; i++) {
 		if (!rpm_smd_clks[i])
@@ -1321,6 +1326,24 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
+	/* Leave a permanent active vote on clocks that require it. */
+	for (i = 0; i < desc->num_keepalive_clks; i++) {
+		if (WARN_ON(!keepalive_clks[i]))
+			continue;
+
+		ret = clk_prepare_enable(keepalive_clks[i]->clk);
+		if (ret)
+			return ret;
+
+		ret = clk_set_rate(keepalive_clks[i]->clk, 19200000);
+		if (ret)
+			return ret;
+	}
+
+	/* Keep an active vote on CXO in case no other driver votes for it. */
+	if (rpm_smd_clks[RPM_SMD_XO_A_CLK_SRC])
+		return clk_prepare_enable(rpm_smd_clks[RPM_SMD_XO_A_CLK_SRC]->hw.clk);
+
 	return 0;
 err:
 	dev_err(&pdev->dev, "Error registering SMD clock driver (%d)\n", ret);

-- 
2.39.2

