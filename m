Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1ADD72FA78
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243706AbjFNKXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243558AbjFNKWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:22:43 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBE51BD4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:22:30 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b1a7e31dcaso6625001fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686738148; x=1689330148;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tznUKYMNGUVufVQqnleYMuCU9FFyTKNRAjeP7Rsq2rU=;
        b=Xdy82ohDJDubZkVT03B8Lbrd+ANj+fWIVm4kwZ0JZdhdodVhgr+dafRbpAuzh3zsbY
         VH8a1mx9PcYO7R2AV7Uz4jlz0UkffifGiB03WUBTObb3hTDTpYTy3iG38NqNXBLoCd6S
         qzx5at6bIIIe8HRa7mef4n8mvFXcA/ZDodNdtzzQrDglhPrnJiVWSVYt4MWhGliXeT4S
         +JlefTWcuPqIiRFRtev5wThz9iIeKwdNzSWN1ma2BJfJR+2KSVHWy7tv6C3TIaoB1EMp
         1DOecXNH8ApMnuG9vffn5eADQgiNMeldkBeg6Vne3c6ReiiQo54dhhDIMFRYdqnrSBIH
         8NYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686738148; x=1689330148;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tznUKYMNGUVufVQqnleYMuCU9FFyTKNRAjeP7Rsq2rU=;
        b=hH1TyhvlvL5XUNMUmbsg+R+nUemAWBUKV6WTBo0VQNbRWUDK4P94++0U49RGS5QL+Z
         eQgjBlP2f3sY/teRhYo0vdupUZZ3wzvxbysv0eZqo/J1ZtAAXb6DS9kMSTl7Hme9vNpB
         R6/SA/bxDHFKyWXtdyby7PsuF0EETh0J4jpUAv5FmTliHV0oB4wFwOdzCNVxqdrjtMJQ
         BxogACY6fasNlm54WCwDBUV3wkWaMP4uDTg1cdVDt0N4K/27w8hhdprUhFrFuZxXASGJ
         lGqvFOqak01f+p6U1hpMxAQSi0lqsbPEM6babuxTDtn0KIgeDVroopuldCUdWgDPnLO9
         WHZQ==
X-Gm-Message-State: AC+VfDx+wvUMGT8/eCNW6JRRWivZK4CtcyJkdntqYDIyGJhsfoYg1Ku3
        z6F/2oeEFXqrbxSATSx3C6qFbw==
X-Google-Smtp-Source: ACHHUZ5Kkm0HtcszG9xhJK4da0bGiELT4wgNxMniwLnMhBAE14Mz8PEzUg+pTrpchNtiGDY5bzlVkg==
X-Received: by 2002:a2e:9784:0:b0:2ad:8380:770d with SMTP id y4-20020a2e9784000000b002ad8380770dmr6514901lji.21.1686738148360;
        Wed, 14 Jun 2023 03:22:28 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id m2-20020a2eb6c2000000b002b20d8f270asm2520057ljo.74.2023.06.14.03.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 03:22:28 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 12:22:19 +0200
Subject: [PATCH v5 08/22] interconnect: qcom: smd-rpm: Add rpmcc handling
 skeleton code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v5-8-eeaa09d0082e@linaro.org>
References: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686738135; l=3224;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=o4L7cQzLORJ+ozHEwT+lr8CvspibuRjlWs1YqX2mbng=;
 b=Ak/0TZAGFcfewU2zztSvVpLThAYHkY2Lc7fdBqphnIQuz1YptTD1A3M+Uf7UQNU2Xd8Dxw7Qk
 siq4suj3+dWCRVxEMTkyDL1w+KNME3k0+7GIuKoICo58Fs/0QIKZaI1
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce qcom_icc_rpm_set_bus_rate() in preparation for handling RPM
clock resources within the interconnect framework. This lets us greatly
simplify all of the code handling, as setting the rate comes down to:

u32 rate_khz = max(clk.sleep_rate, clk.active_rate, clk_a.active_rate)
write_to_rpm(clock.description, rate_khz);

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.h | 15 +++++++++++++++
 drivers/interconnect/qcom/smd-rpm.c | 21 +++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 9ec90e13bfbd..d857fb1efb75 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -22,6 +22,18 @@ enum qcom_icc_type {
 	QCOM_ICC_QNOC,
 };
 
+/**
+ * struct rpm_clk_resource - RPM bus clock resource
+ * @resource_type: RPM resource type of the clock resource
+ * @clock_id: index of the clock resource of a specific resource type
+ * @branch: whether the resource represents a branch clock
+*/
+struct rpm_clk_resource {
+	u32 resource_type;
+	u32 clock_id;
+	bool branch;
+};
+
 #define NUM_BUS_CLKS	2
 
 /**
@@ -47,6 +59,7 @@ struct qcom_icc_provider {
 	unsigned int qos_offset;
 	u64 bus_clk_rate[NUM_BUS_CLKS];
 	struct clk_bulk_data bus_clks[NUM_BUS_CLKS];
+	const struct rpm_clk_resource *bus_clk_desc;
 	struct clk_bulk_data *intf_clks;
 	bool keep_alive;
 	bool is_on;
@@ -104,6 +117,7 @@ struct qcom_icc_desc {
 	struct qcom_icc_node * const *nodes;
 	size_t num_nodes;
 	const char * const *bus_clocks;
+	const struct rpm_clk_resource *bus_clk_desc;
 	const char * const *intf_clocks;
 	size_t num_intf_clocks;
 	bool keep_alive;
@@ -125,5 +139,6 @@ int qnoc_remove(struct platform_device *pdev);
 
 bool qcom_icc_rpm_smd_available(void);
 int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
+int qcom_icc_rpm_set_bus_rate(const struct rpm_clk_resource *clk, int rsc_type, u32 rate);
 
 #endif
diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
index b0183262ba66..b06374340eeb 100644
--- a/drivers/interconnect/qcom/smd-rpm.c
+++ b/drivers/interconnect/qcom/smd-rpm.c
@@ -16,6 +16,7 @@
 #include "icc-rpm.h"
 
 #define RPM_KEY_BW		0x00007762
+#define QCOM_RPM_SMD_KEY_RATE	0x007a484b
 
 static struct qcom_smd_rpm *icc_smd_rpm;
 
@@ -44,6 +45,26 @@ int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val)
 }
 EXPORT_SYMBOL_GPL(qcom_icc_rpm_smd_send);
 
+int qcom_icc_rpm_set_bus_rate(const struct rpm_clk_resource *clk, int rsc_type, u32 rate)
+{
+	struct clk_smd_rpm_req req = {
+		.key = cpu_to_le32(QCOM_RPM_SMD_KEY_RATE),
+		.nbytes = cpu_to_le32(sizeof(u32)),
+	};
+
+	/* Branch clocks are only on/off */
+	if (clk->branch)
+		rate = !!rate;
+
+	req.value = cpu_to_le32(rate);
+	return qcom_rpm_smd_write(icc_smd_rpm,
+				  rsc_type,
+				  clk->resource_type,
+				  clk->clock_id,
+				  &req, sizeof(req));
+}
+EXPORT_SYMBOL_GPL(qcom_icc_rpm_set_bus_rate);
+
 static int qcom_icc_rpm_smd_remove(struct platform_device *pdev)
 {
 	icc_smd_rpm = NULL;

-- 
2.41.0

