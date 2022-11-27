Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093FF639A20
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 12:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiK0LYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 06:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiK0LYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 06:24:41 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB281E098
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 03:24:39 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 6so7532513pgm.6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 03:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=af32RiZNOuCS1SpmNdhimvmfJ1uk/URYpjz9mBw96SQ=;
        b=jy0wVfV3VbjK6vnbeEMGF5KuhyMHGFPzWox8wvKIkcFG/HXdl5ggjSNkD/cq3HtEti
         FbcjMCtO3vYo5XM+uEMsS5nBY8aOUHO+WwYhU6kQLSFYvXlP5UTB7yomRoHBKyvYm1cN
         OZfhTsQ+hvG0E5/wQVAXX65unos/sx79FzXUEKw9WLvV0/rz2BAgRWudrtC0udPqWRYK
         pfss71dH2yHx/4NHOQ/C5HQwBGkilTv1xPe6KcDLdHf7fnNSBoAsCyAmWsCeVGgWSdnp
         IyRmomcN8Jc0clfmdtYaD4YPWaFO+pXdCNlWfg+Kf06+GkPebsUuhwAl72G+/izmgj+e
         RtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=af32RiZNOuCS1SpmNdhimvmfJ1uk/URYpjz9mBw96SQ=;
        b=JNIFaihqsDMMBhd/J+T9aXGaroPY7xNRWdn7zlO4Y1CwmW/eBoCJyX7jloosrhLLA/
         Wl2/LiU9ey5oGC7bsXvs67iRLoHJYvCrRni9Q5BwsindBGnoBpuMxgLiZukpEmB53MEX
         Wy85YFZu9d84G0CdqkQCjco7/HCEAEXbeyXgriqNMhNEvzPoX9PJiCxj5zq6t0/IpIpX
         niW64lPTpTx25FatS2djGmcXPWYXaRDfBBqKCqvp2PcfH+luUy7OIp80LEJUZrlMQxff
         I54dduGSjC+iIWpTVHHE+gOWYtJg11hRozbgKDQS6zb8OuCX6+D3vGXQB/cYmLcLW5j4
         e4GA==
X-Gm-Message-State: ANoB5pkMHuiaAmtowzQvrDR3ASyYOlUlitE7D2osPUSzcK5mJJRugzVH
        lqm1SWdlpYNaI+lYtgzfbnkYxw==
X-Google-Smtp-Source: AA0mqf5L3TYnjtJtzAa75ed/XwQKFkMTj7P+KxqwMlK5pbXVUY6CbgFHn+RGWM2wbLNqHgtdaEaB6w==
X-Received: by 2002:a63:f510:0:b0:478:1020:b1e6 with SMTP id w16-20020a63f510000000b004781020b1e6mr1109710pgh.561.1669548279323;
        Sun, 27 Nov 2022 03:24:39 -0800 (PST)
Received: from localhost.localdomain ([223.179.131.184])
        by smtp.gmail.com with ESMTPSA id oa14-20020a17090b1bce00b0020d24ea4400sm7691349pjb.38.2022.11.27.03.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 03:24:38 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH 2/2] soc: qcom: rpmpd: Add SM4250 support
Date:   Sun, 27 Nov 2022 16:52:04 +0530
Message-Id: <20221127112204.1486337-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221127112204.1486337-1-bhupesh.sharma@linaro.org>
References: <20221127112204.1486337-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM4250 has the same RPM power domains as SM6115. Add SM4250
support by reusing SM6115 power domains.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org> 
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> 
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 337b1ad1cd3b..f0db6a10cf4e 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -471,6 +471,23 @@ static const struct rpmpd_desc qcm2290_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO_NO_CPR,
 };
 
+static struct rpmpd *sm4250_rpmpds[] = {
+	[SM4250_VDDCX] = &sm6115_vddcx,
+	[SM4250_VDDCX_AO] = &sm6115_vddcx_ao,
+	[SM4250_VDDCX_VFL] = &sm6115_vddcx_vfl,
+	[SM4250_VDDMX] = &sm6115_vddmx,
+	[SM4250_VDDMX_AO] = &sm6115_vddmx_ao,
+	[SM4250_VDDMX_VFL] = &sm6115_vddmx_vfl,
+	[SM4250_VDD_LPI_CX] = &sm6115_vdd_lpi_cx,
+	[SM4250_VDD_LPI_MX] = &sm6115_vdd_lpi_mx,
+};
+
+static const struct rpmpd_desc sm4250_desc = {
+	.rpmpds = sm4250_rpmpds,
+	.num_pds = ARRAY_SIZE(sm4250_rpmpds),
+	.max_state = RPM_SMD_LEVEL_TURBO_NO_CPR,
+};
+
 static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,mdm9607-rpmpd", .data = &mdm9607_desc },
 	{ .compatible = "qcom,msm8226-rpmpd", .data = &msm8226_desc },
@@ -485,6 +502,7 @@ static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,qcm2290-rpmpd", .data = &qcm2290_desc },
 	{ .compatible = "qcom,qcs404-rpmpd", .data = &qcs404_desc },
 	{ .compatible = "qcom,sdm660-rpmpd", .data = &sdm660_desc },
+	{ .compatible = "qcom,sm4250-rpmpd", .data = &sm4250_desc },
 	{ .compatible = "qcom,sm6115-rpmpd", .data = &sm6115_desc },
 	{ .compatible = "qcom,sm6125-rpmpd", .data = &sm6125_desc },
 	{ .compatible = "qcom,sm6375-rpmpd", .data = &sm6375_desc },
-- 
2.38.1

