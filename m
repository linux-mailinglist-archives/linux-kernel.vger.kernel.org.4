Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A656872FA6F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243504AbjFNKWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbjFNKWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:22:38 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A575C1BF6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:22:27 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b344476313so6710001fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686738145; x=1689330145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UEM3N0iLIlvYLepw85JsPFibfyRzMkZ98OPjRwmkvbs=;
        b=UrbFlgODVPmj2NGdwjbJRN5t/sB1AfaciGH68h64gdEejWHI3SD3zK8hGzT1VGsHuc
         Xx+z+e1I9qjCkj2StftG05xScivv+lWx3n41s9vEVxgE6CNNvtjCnIrT1wUSeE8sZMIy
         LM9elia3GePns6kaWAfbSjsKhsdmZ+cm+XGmvUSyUB79k1eEtD7iK84Dt1K+JQOc9B87
         gM6zOHZpYr4qT11kvmm3PpxFgmJL8fZG+vDczAtreBIclrmX49LzF+cqqXYDka1/uwht
         zZIeb+6ksWaTk5cKtAaTYfMT8ukPLWo2TlI3SuhhL1Sx2LpMao643lmxFz7/Oe7f+f9n
         neIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686738145; x=1689330145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEM3N0iLIlvYLepw85JsPFibfyRzMkZ98OPjRwmkvbs=;
        b=eWN8BPMPb105CXpFlW5hGOODu/opsRm5ug0ihdaUoXe1//URmb7zqGRtgiEZHOI3z2
         GEVECXoEOyDsD0eH1mTucNWT9gG1IYpAoIvpOqDPL8o2q8qwIwFQM0nxoj+pyFn9j3Io
         rFxXuiIplODM1sbvWmjTdEzcvtpoLK8LzoDjZ2f0bsjzAnw4d6lbQeEarFf2Hc574vbo
         /mffxx+nXFhp7aMR3MBcs57G+DHiPoRwNhhqU/7kb/LX487VLyZEOtcWUyMsCt3e3dZv
         hn0/tGnVAy3FKWJK0xe22vwbb+E/s4mfb5TlmwtAR+LqRgrETPB31iH1kCGi3P8CAkmG
         A6pQ==
X-Gm-Message-State: AC+VfDxtK0ryFsPg197iFlpRuQtSm8pPJNOpXHRoo0nPLF3BKW+7X+eI
        DyzividArsO+cZ1r8j9qDYucng==
X-Google-Smtp-Source: ACHHUZ6QIgny4qx99n2wOMJLyHIrxll5PjxQICjC+F7POpODJ+0rfetBkmTUy/GzGbRQRyZ4lnoHNQ==
X-Received: by 2002:a2e:7208:0:b0:2b1:eb9e:20df with SMTP id n8-20020a2e7208000000b002b1eb9e20dfmr5951905ljc.17.1686738145613;
        Wed, 14 Jun 2023 03:22:25 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id m2-20020a2eb6c2000000b002b20d8f270asm2520057ljo.74.2023.06.14.03.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 03:22:25 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 12:22:17 +0200
Subject: [PATCH v5 06/22] interconnect: qcom: icc-rpm: Introduce keep_alive
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v5-6-eeaa09d0082e@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686738135; l=3661;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=g6kESh9vFn5cUExPwamnhleED6tFd+S7dtFe11cmEVE=;
 b=+5TX+IWvITvOPt3FKf80PLSfZpyEXg88Ruo8CN8uG442tDQftNEqI6MIJVm4RfvIrr5ZrEjJb
 Pyy9LVaNOsnCtkERlGg1opf2kH26p6NKEihhv9gZBKtDVHoKjOeOEUI
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
2.41.0

