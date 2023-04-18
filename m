Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EF96E60E2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjDRMMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjDRMLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:11:40 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D45F72A2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:11:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4ec8eca56cfso2167940e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681819864; x=1684411864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbVhusCEghNKEPZ8TLDEdqw82MnqWQVPyy1y462DY9k=;
        b=swJ6/Exu986U2znXzl7Sx2Lj5KHn8dVTqtNXNU+FIA6UM4wu/HEowRKYm/z/prpcId
         VM4J6JeqKPWlKvFhNaIOa3hMIKyq3Ol2bCH+MuacZfeSMQYCIqw6IrWTcjFA44fKZD9D
         cDgyxq+DxNgfR7zcwKKzE6VMiW4t6vRJl15M+NeWyeAmZWc+Jd30zpaz4oY2U++ojnTz
         U79skAUExsLFHiqAKXKQa+kF96i1q5n4yJXyltnxgqkQljs6Ped4PgsaowdunD1QRi++
         v82pM6y3+7PaKdK53jsDSGhmXyxvKn/4CQc7HRwfT8xxRvagvG9X6Wi9l2cdpaPbIM9I
         SRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681819864; x=1684411864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbVhusCEghNKEPZ8TLDEdqw82MnqWQVPyy1y462DY9k=;
        b=haDt1HWW4j6is+pta5wzU/DRicp8zRKVpUrcBqI4Mcb1QzJd/RE9YdboamE+TMK4YG
         C3l67cOpT9tTZ4zfUSXNf+VeXFVTlf649CFRDFFLpOgYatWQ5iSQ9DIue6PRX1If+hfX
         sApgMHsRvXP+uJXPzjbyGBWEk1kBrklgAzdqJ6y3sQGGS39STmJk7AW5xhiBkr/RuvGz
         xNFJ+lvbV2zk9ezuuCskjsakWSS8GBEfw8q6jJ5IJWlxw2WieIr62UTaKbdvjWItNoo0
         nsMez/uOjnFgU5UyxzLhI0Vqeu4+BnKPtcBb4cK/hJD6erEpR5XE6B5N79zqtc2bIPvf
         eLbQ==
X-Gm-Message-State: AAQBX9cGqJwqjL9C+8unF9Y9SnieIePQA4uK/3uYGPMBpTzj8oUebkac
        ZnXRcHl2O0pwFpC0lESRxCYJWw==
X-Google-Smtp-Source: AKy350bPFfWUOLpWel/8DUUJQFJNYhY785GrX3wMbeGJZeX8OlOeyQdJUrVbfdfWsy1pAnBkEYqUkw==
X-Received: by 2002:ac2:511b:0:b0:4eb:13ff:6ca7 with SMTP id q27-20020ac2511b000000b004eb13ff6ca7mr2818344lfb.16.1681819863993;
        Tue, 18 Apr 2023 05:11:03 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id q17-20020a19a411000000b004d86808fd33sm2365895lfc.15.2023.04.18.05.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 05:11:03 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 18 Apr 2023 14:10:59 +0200
Subject: [PATCH v2 4/5] drm/msm/mdss: Handle the reg bus ICC path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-topic-dpu_regbus-v2-4-91a66d04898e@linaro.org>
References: <20230417-topic-dpu_regbus-v2-0-91a66d04898e@linaro.org>
In-Reply-To: <20230417-topic-dpu_regbus-v2-0-91a66d04898e@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681819856; l=3137;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=wX+gJPCe8UmLoFyI2GJLXSE1t0Mv12xmqDSsK2E8jZI=;
 b=Fl2losD0yxtKUBCjTBabIjaes/wJD0CNKIE43B+HBU9fLD5PGoyshXp3GJ8ZfODxRfctdbQnAGhz
 EDCNeSo8CFhnc35D2jEK9RnI6hh2Gf2ys+xxVtGeDWOXIMH07UQL
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

Apart from the already handled data bus (MAS_MDP_Pn<->DDR), there's
another path that needs to be handled to ensure MDSS functions properly,
namely the "reg bus", a.k.a the CPU-MDSS interconnect.

Gating that path may have a variety of effects.. from none to otherwise
inexplicable DSI timeouts..

On the MDSS side, we only have to ensure that it's on at what Qualcomm
downstream calls "77 MHz", a.k.a 76.8 Mbps and turn it off at suspend.

To achieve that, make msm_mdss_icc_request_bw() accept a boolean to
indicate whether we want the busses to be on or off, as this function's
only use is to vote for minimum or no bandwidth at all.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/msm_mdss.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 9e2ce7f22677..4d126d20d661 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -50,6 +50,7 @@ struct msm_mdss {
 	const struct msm_mdss_data *mdss_data;
 	struct icc_path *mdp_path[2];
 	u32 num_mdp_paths;
+	struct icc_path *reg_bus_path;
 };
 
 static int msm_mdss_parse_data_bus_icc_path(struct device *dev,
@@ -57,6 +58,7 @@ static int msm_mdss_parse_data_bus_icc_path(struct device *dev,
 {
 	struct icc_path *path0;
 	struct icc_path *path1;
+	struct icc_path *reg_bus_path;
 
 	path0 = of_icc_get(dev, "mdp0-mem");
 	if (IS_ERR_OR_NULL(path0))
@@ -71,6 +73,10 @@ static int msm_mdss_parse_data_bus_icc_path(struct device *dev,
 		msm_mdss->num_mdp_paths++;
 	}
 
+	reg_bus_path = of_icc_get(dev, "cpu-cfg");
+	if (!IS_ERR_OR_NULL(reg_bus_path))
+		msm_mdss->reg_bus_path = reg_bus_path;
+
 	return 0;
 }
 
@@ -83,12 +89,15 @@ static void msm_mdss_put_icc_path(void *data)
 		icc_put(msm_mdss->mdp_path[i]);
 }
 
-static void msm_mdss_icc_request_bw(struct msm_mdss *msm_mdss, unsigned long bw)
+static void msm_mdss_icc_request_bw(struct msm_mdss *msm_mdss, bool enable)
 {
 	int i;
 
 	for (i = 0; i < msm_mdss->num_mdp_paths; i++)
-		icc_set_bw(msm_mdss->mdp_path[i], 0, Bps_to_icc(bw));
+		icc_set_bw(msm_mdss->mdp_path[i], 0, enable ? Bps_to_icc(MIN_IB_BW) : 0);
+
+	if (msm_mdss->reg_bus_path)
+		icc_set_bw(msm_mdss->reg_bus_path, 0, enable ? 76800 : 0);
 }
 
 static void msm_mdss_irq(struct irq_desc *desc)
@@ -241,7 +250,7 @@ static int msm_mdss_enable(struct msm_mdss *msm_mdss)
 	 * the interconnect is enabled (non-zero bandwidth). Let's make sure
 	 * that the interconnects are at least at a minimum amount.
 	 */
-	msm_mdss_icc_request_bw(msm_mdss, MIN_IB_BW);
+	msm_mdss_icc_request_bw(msm_mdss, true);
 
 	ret = clk_bulk_prepare_enable(msm_mdss->num_clocks, msm_mdss->clocks);
 	if (ret) {
@@ -289,7 +298,7 @@ static int msm_mdss_enable(struct msm_mdss *msm_mdss)
 static int msm_mdss_disable(struct msm_mdss *msm_mdss)
 {
 	clk_bulk_disable_unprepare(msm_mdss->num_clocks, msm_mdss->clocks);
-	msm_mdss_icc_request_bw(msm_mdss, 0);
+	msm_mdss_icc_request_bw(msm_mdss, false);
 
 	return 0;
 }

-- 
2.40.0

