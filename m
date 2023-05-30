Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE343715B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjE3KUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjE3KUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:20:20 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A2490
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:20:12 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f4b384c09fso4875185e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685442010; x=1688034010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aF5NzyLnKl7zoihaKOQABOmTLo7g2FiY8plhOqJWWE=;
        b=KL18hG5ZcSfHdXMU8nINo0ozNDShQjM5vzvdQuBSHtY8YnyCUBmK0JZYp92oSvzksz
         PJQqas3ZWqa4uYoee36tPlrt6K10lXQHtVKYF2cW3gyGaV6CugK3HNjqBlEcjSbgyvhN
         BYPG0i2uXOVmHQYzYj2RmSu1sonzGpZobIdCyRq+Jwd8GauYG6o2hoq0OYgs8uyr9hl9
         U7VB8/H3ET0xjVi+EcWBz/ldjf7CGA/Su/bH6nPnABwYhBT9ZymCpfSm/xqOZnuKqmHU
         DASloBUVF60q3Tw0cOG29oGQt9JmVyRg1kl/hmZpMueKIBgjlFNf0UYTO1VtgUIZKcca
         apjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685442010; x=1688034010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aF5NzyLnKl7zoihaKOQABOmTLo7g2FiY8plhOqJWWE=;
        b=MlfaStnmn2EG1jHpH/29IUjfEK31fFQpuhkBdjjj2Kk5l1BoAxhabRPhfBJlu8YF7j
         tFzIbpCYfbBFzc4io16/WGjYlyuzGJdJDxwajBp5OsIZYblS0jeuj+4gPZWSsQfFte3k
         HVf16BgbrsF2VTukG0jjhq47nEo2K80C8Gp943vUFnx4zqYof8b9P9vyzFxZesJaiANa
         jD9vxWISzoMw2Ry3adPqUf71FG1upXnoJkhKCNQ3XHZ1fyRufD0hSiATpsYWp6vL6dAC
         UG/JXimzxZAxzrPdTYG3ykE5HCoO1oKSuW8pBPctAFyuCvj2ciR//nw0KPx19vA3HRNP
         axXg==
X-Gm-Message-State: AC+VfDwH3J55H5X7ru5nqm30owG7jKWj6rMDmmUnsrtVO13jVqnifwY9
        en/GasiDcFZG0Bxxwm54NAkk9g==
X-Google-Smtp-Source: ACHHUZ49jO4ej62nC5LYtMBcBGYeMuH4h/3xvYCghtPsS/zki7108GVeiL90tpIWHuwylPCqgq+a0A==
X-Received: by 2002:a05:6512:243:b0:4f3:a485:919a with SMTP id b3-20020a056512024300b004f3a485919amr532930lfo.57.1685442010378;
        Tue, 30 May 2023 03:20:10 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c25-20020ac24159000000b004cc8196a308sm290902lfi.98.2023.05.30.03.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:20:10 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 12:20:04 +0200
Subject: [PATCH 05/20] interconnect: qcom: icc-rpm: Introduce keep_alive
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v1-5-1bf8e6663c4e@linaro.org>
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685442001; l=3600;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=k3FKq4hsanyAIvzotN0m6bauADNeL2Fo1rigqnJlDac=;
 b=hvFTnD/dH0Sj2ysZovpz3wr8bDb7GQWdzjJvH/HBaWZIqENeiuglNUMKjH8ib2RYdbqm3Aj/e
 ZPbjZA4ZiqTDbcPF408eXt58YEsIIk+Y0RIP/mR78KKzxnrjj8nlfwg
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The downstream kernel employs the concept of "keeping the bus alive"
by voting for the minimum (XO/19.2MHz) rate at all times on certain
(well, most) buses. This is a very important thing to have, as if we
either have a lackluster/wrong DT that doesn't specify a (high enough)
vote on a certain bus, we may lose access to the entire bus altogether.
This is very apparent when we only start introducing interconnect
support on a given platform and haven't yet introduced voting on all
peripherals.

The same can happen if we only have a single driver casting a vote on
a certain bus and that driver exits/crashes/suspends.

The keepalive vote is limited to the ACTIVE bucket, as keeping a
permanent vote on the SLEEP one could prevent the platform from properly
entering low power mode states.

Introduce the very same concept, with a slight twist: the vendor
kernel checks whether the rate is zero before setting the minimum
vote, but that's rather silly, as in doing so we're at the mercy
of CCF. Instead, explicitly clamp the rates to always be >= 19.2 MHz
for providers with keep_alive=true.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 10 ++++++++++
 drivers/interconnect/qcom/icc-rpm.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 6acc7686ed38..863e8ba1daa2 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -50,6 +50,8 @@
 #define NOC_QOS_MODE_FIXED_VAL		0x0
 #define NOC_QOS_MODE_BYPASS_VAL		0x2
 
+#define ICC_BUS_CLK_MIN_RATE		19200000ULL
+
 static int qcom_icc_set_qnoc_qos(struct icc_node *src)
 {
 	struct icc_provider *provider = src->provider;
@@ -380,6 +382,13 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 		do_div(rate, src_qn->buswidth);
 		rate = min_t(u64, rate, LONG_MAX);
 
+		/*
+		 * Downstream checks whether the requested rate is zero, but it makes little sense
+		 * to vote for a value that's below the lower threshold, so let's not do so.
+		 */
+		if (bucket == QCOM_ICC_BUCKET_WAKE && qp->keep_alive)
+			rate = max(ICC_BUS_CLK_MIN_RATE, rate);
+
 		if (qp->bus_clk_rate[i] == rate)
 			continue;
 
@@ -453,6 +462,7 @@ int qnoc_probe(struct platform_device *pdev)
 	for (i = 0; i < qp->num_bus_clks; i++)
 		qp->bus_clks[i].id = bus_clocks[i];
 
+	qp->keep_alive = desc->keep_alive;
 	qp->type = desc->type;
 	qp->qos_offset = desc->qos_offset;
 
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index ee705edf19dd..d2c04c400cad 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -33,6 +33,7 @@ enum qcom_icc_type {
  * @bus_clk_rate: bus clock rate in Hz
  * @bus_clks: the clk_bulk_data table of bus clocks
  * @intf_clks: a clk_bulk_data array of interface clocks
+ * @keep_alive: whether to always keep a minimum vote on the bus clocks
  * @is_on: whether the bus is powered on
  */
 struct qcom_icc_provider {
@@ -45,6 +46,7 @@ struct qcom_icc_provider {
 	u64 bus_clk_rate[NUM_BUS_CLKS];
 	struct clk_bulk_data bus_clks[NUM_BUS_CLKS];
 	struct clk_bulk_data *intf_clks;
+	bool keep_alive;
 	bool is_on;
 };
 
@@ -102,6 +104,7 @@ struct qcom_icc_desc {
 	const char * const *bus_clocks;
 	const char * const *intf_clocks;
 	size_t num_intf_clocks;
+	bool keep_alive;
 	bool no_clk_scaling;
 	enum qcom_icc_type type;
 	const struct regmap_config *regmap_cfg;

-- 
2.40.1

