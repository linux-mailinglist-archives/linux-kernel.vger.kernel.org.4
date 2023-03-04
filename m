Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866A56AA9DF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 14:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjCDN1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 08:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjCDN1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 08:27:47 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3101D1E1EC
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 05:27:46 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id n2so6984401lfb.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 05:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677936464;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOECaGmGmUJLrulLw8TRNrQNT4lkSkMI20VbWaQaVaY=;
        b=PxfrGqPCxEQt9X2O89hlvg/SXVn71ccJUG122XYCJEGj8DqJVCi81qd+UAV1ujqGgK
         4lAg/LtneLVYzrPmcNUqg5g6plsvTrCzlnLjRFo4vr08J2C9mMN7HG/2DOUYb0nJa8Xo
         RJyNALYcEM7s3k0nV6NYJFiRDYKU+Q5B1rTuncjED0cb8zctwT4pVrpxHQSDiLfi/wnx
         kavK2firADnvOtKnLDJAtCMRHOou9TPJkOlGxO7UBjQLYtIfDpiP3yCBhitNn9vOqV8V
         ETc8TnTjb4XgHV90ulhOXzFa8AKRLa6dLJhfyDlwlL/mVJk/SyR4dOzgJoVFQ8/ShrQ1
         16gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677936464;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOECaGmGmUJLrulLw8TRNrQNT4lkSkMI20VbWaQaVaY=;
        b=ulJFUcwFt9hZ3q34HeKGgxmvvSkUlbigKIq1lH9MKd/YAVN45zCs2bf0mZzJp3RorJ
         sSjZlYZLCYsTzkCZIK7ChACoIgYUDorATpq+43MPh4uzRk5GPLhpmfoYl4V+aoWqdFox
         EV0s59I6hX6sVAKhcppVpU/NCp2fNqIZLdnT/RJpIl9NWgZhfychVvuEoVOaLYqHwuY9
         kyjqOhH/821tq6nhhvgZErctywnFggmOsTIH5E3g4l7xeQ40DtUjoGCnKEe8gznR/hVz
         UXIqGTGPsWCCqSmE0Hgp/NCJeDwU9Pv0YVjgmZs5sKCYqS7sSEGZg5vCSPo9emxOUthb
         BFnw==
X-Gm-Message-State: AO0yUKWDqfL2n39AqJnR+nAbzjR3yyq0/TjdfIyhDYNKnxuBxE5ILcCN
        x5IF4gqmcfZ3wtWgaEzMmhaUWw==
X-Google-Smtp-Source: AK7set/1wEvzDxZi+/2UVaws5T7xRDzQNppg9F1VYRh53WKUdEqu9lmMB9lto1KR9/wHvPvCPT3ivw==
X-Received: by 2002:ac2:5146:0:b0:4cb:88c:c794 with SMTP id q6-20020ac25146000000b004cb088cc794mr1442240lfd.35.1677936464443;
        Sat, 04 Mar 2023 05:27:44 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id j15-20020a19f50f000000b004e7fa99f2b5sm342975lfb.186.2023.03.04.05.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 05:27:44 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 04 Mar 2023 14:27:36 +0100
Subject: [PATCH RFT 01/20] clk: qcom: smd-rpm: Add .is_enabled hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-rpmcc_sleep-v1-1-d9cfaf9b27a7@linaro.org>
References: <20230303-topic-rpmcc_sleep-v1-0-d9cfaf9b27a7@linaro.org>
In-Reply-To: <20230303-topic-rpmcc_sleep-v1-0-d9cfaf9b27a7@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677936461; l=1448;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=DkAvY529UR+RwkQzY1FO48/jck/x44pR7ssps7xiA3g=;
 b=YXoN6u+y4uMm3usYO2+1lxRT7rL+nPk37A/NZn2isSkTCPveLpjtnsAE15jIJmlxZWNugmWTi21u
 bI21veBjB3v2oDa2VDvQiU3VN0Hu6WSri90wlXv906zUErCAlUNW
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

From: Shawn Guo <shawn.guo@linaro.org>

The RPM clock enabling state can be found with 'enabled' in struct
clk_smd_rpm.  Add .is_enabled hook so that clk_summary in debugfs can
show a correct enabling state for RPM clocks.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
[Konrad: rebase]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 198886c1b6c8..ecacfbc4a16c 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -424,18 +424,27 @@ static int clk_smd_rpm_enable_scaling(struct qcom_smd_rpm *rpm)
 	return 0;
 }
 
+static int clk_smd_rpm_is_enabled(struct clk_hw *hw)
+{
+	struct clk_smd_rpm *r = to_clk_smd_rpm(hw);
+
+	return r->enabled;
+}
+
 static const struct clk_ops clk_smd_rpm_ops = {
 	.prepare	= clk_smd_rpm_prepare,
 	.unprepare	= clk_smd_rpm_unprepare,
 	.set_rate	= clk_smd_rpm_set_rate,
 	.round_rate	= clk_smd_rpm_round_rate,
 	.recalc_rate	= clk_smd_rpm_recalc_rate,
+	.is_enabled	= clk_smd_rpm_is_enabled,
 };
 
 static const struct clk_ops clk_smd_rpm_branch_ops = {
 	.prepare	= clk_smd_rpm_prepare,
 	.unprepare	= clk_smd_rpm_unprepare,
 	.recalc_rate	= clk_smd_rpm_recalc_rate,
+	.is_enabled	= clk_smd_rpm_is_enabled,
 };
 
 DEFINE_CLK_SMD_RPM_BRANCH_A(bi_tcxo, QCOM_SMD_RPM_MISC_CLK, 0, 19200000);

-- 
2.39.2

