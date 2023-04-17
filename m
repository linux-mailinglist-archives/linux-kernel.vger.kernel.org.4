Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49C96E4D51
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjDQPbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjDQPbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:31:41 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243DFBBA3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:31:06 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2a8bb726210so11951561fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681745429; x=1684337429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbVhusCEghNKEPZ8TLDEdqw82MnqWQVPyy1y462DY9k=;
        b=vG/uhlDHyTadETatt819cKu9odf4EjYBgf4EYXzYjIlvJmYFp7NLxrg5Pd9yQ4par0
         tbYp28bwgmFxSETBGY+Rrp6eA819DR7FLdIRZ1nSLwmq+P6m3crSEetKqQxqsniWVowW
         9zQ4EcoUSdtTYX9UgIl/9Cy8s2z/N4BocL5dP3R1rFtXNEkf9Xg6h8B72azDvJakrG+H
         sAzoupFMyUEdgG+P1l0Qypd35ABtdb9LG5rIRO4bY60GBF8LrP7axjSH2jV5YUPsVd3W
         IR8mc87yxRPLqGUEXs/r9RTa9Ycp43SKK0YAvqj599/dUo3qnXfxbEuDkPFlHGgHInFu
         nuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681745429; x=1684337429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbVhusCEghNKEPZ8TLDEdqw82MnqWQVPyy1y462DY9k=;
        b=CWyaGk6rpqo1Qqa4fJdu1CKHLIFrAAVMqQ3vrDHoCwc+euLw9//1MeyMlTHYMJNjHV
         H4xZWhD0Woxkog2U/l/M82NubT3QP+dhiUVd5fK/Pfgcx7RJWqz1uCT8VRObjS3M1XfA
         MSkZu2JCJC2/YPmi7iOsM/bOkM6m0hpx7Sl1gBl0WdzgKXfcdUTfI92yuTYBQnxr6vu0
         BrPrpnx20ltV67+kBY7bCWbO+pzpenb8X0p52UxHUyKw667QIBMQYmGwszXJyq5ZCiUp
         6iFnGd3ilp4lJjuhMbEw4uMQh1iTpbvgkf7C9MLw93zEvjq8CX6PVYGc3u00Y1V/tvpQ
         DIow==
X-Gm-Message-State: AAQBX9eHwSTNzBBZFgNcJDIzVXLCHLbHCu5ZZYt7uMLxXCoJL5kTV0d3
        GzfQwBedbkCbElIn8BGzmtxZ437fIN7wKP7FAG8=
X-Google-Smtp-Source: AKy350ZFca4MHSPEHzAuUtnlhK8+04AZOucpZ19yBZbQQlFSTFKEdxqPL/D9EBLV4ijZa2GEREui9g==
X-Received: by 2002:ac2:47e1:0:b0:4e9:ce2c:26b0 with SMTP id b1-20020ac247e1000000b004e9ce2c26b0mr2186862lfp.14.1681745429463;
        Mon, 17 Apr 2023 08:30:29 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id b16-20020ac25e90000000b004ec8a3d4200sm2053439lfq.293.2023.04.17.08.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 08:30:29 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 17 Apr 2023 17:30:18 +0200
Subject: [PATCH 4/5] drm/msm/mdss: Handle the reg bus ICC path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-topic-dpu_regbus-v1-4-06fbdc1643c0@linaro.org>
References: <20230417-topic-dpu_regbus-v1-0-06fbdc1643c0@linaro.org>
In-Reply-To: <20230417-topic-dpu_regbus-v1-0-06fbdc1643c0@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681745422; l=3137;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=wX+gJPCe8UmLoFyI2GJLXSE1t0Mv12xmqDSsK2E8jZI=;
 b=5xiKkr66PFQP6ZSqLKRRPFd+S077x81GWeppbqJQlTkHd+GVqAn2hoMw2omK55rgB2aCud7qPoYm
 7jn8UljSDUu65rLWRgQrdQbpTqj1ZycewVweNG7g9gkRH7l6DiQU
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

