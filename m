Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAFA615EAB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiKBJCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiKBJCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:02:04 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C84827FD7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 02:01:48 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j15so23498173wrq.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 02:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJwgXX3StBPw4KOENIV6+/ZT/9r64J3QECerjdiBj8E=;
        b=Nh+SlWGOhrAOk0lcCXZSQa0YEfcrlvree0Gav6U+2pP8gd56TYkqNw41fXA38eEpjK
         YF1vtvIT5gQkez+kPI2sEWZjspVXxle1b7ResvKq/Q/t5NLktRVQ5hFUlZ7joP2kg//g
         PFDLfwWLDxPutFXyQP7N3UOqN0w/WqrJJP90+rG7u9d/Js4h35DGVGG61dzSnEDKyPTr
         vIWGRyCz3wmfZl0QTiOo5CSr2wGm3uCDqHC+tOQo5jBApMST0EusZ3yHffl2jMOC+uzW
         hWB8nujMspCxOQw4/jAw4Mw1T2jYPv/HSuvSwNnuR1xAw3HPZ2mQaOtBrFNXPawWjCX8
         B88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJwgXX3StBPw4KOENIV6+/ZT/9r64J3QECerjdiBj8E=;
        b=ho+jbIqDlxHjPCCNbwcd8+FEnDV8wO4LzAuCj1PkNNQw0wbjcoIEMGnGma0El5bgSS
         rC1cGQrpiZ5ufnww5QgCIAKwVWc++Vb9jG0TOZ/cplp+nR3/d/6aZ0yyBC+K8K/spVtb
         j+9+NfezA+Td39g8oOVU+VVE2OtsHk7X7aR32kPxc7vhXMhc0C6qV8JioW8TWWNsL13c
         4fotazbSMZ7SoOYVecB2gxC74WfUvv06G82EMR+HeOrnsEpMd72JektthbMOcA0Nh0JN
         zaG2YNIOqg8XCBRQfj9nBKghM5qYcFJpP7d+gEcGrTqyVueUy8p9PRyLcAlVM0fu/27V
         N+9A==
X-Gm-Message-State: ACrzQf1VVJtF1czO8GQLedAU/vE6ZRkUG64rdQYZE42iOf9amUXv2Jwk
        BrZI+a8wX0sR065XMh8ddfpEgg==
X-Google-Smtp-Source: AMsMyM5oE9tRKYcIQVRx/Gbrtq5SbtR7Y78r/us6639SISCxrHNUtW+DU78PL7XVA5bXP+n85aRxTw==
X-Received: by 2002:adf:e104:0:b0:236:dce2:35dc with SMTP id t4-20020adfe104000000b00236dce235dcmr7129994wrz.675.1667379706813;
        Wed, 02 Nov 2022 02:01:46 -0700 (PDT)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id bd26-20020a05600c1f1a00b003cf6c2f9513sm1425322wmb.2.2022.11.02.02.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 02:01:46 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        dmitry.baryshkov@linaro.org, Jonathan Marek <jonathan@marek.ca>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v2 1/5] clk: qcom: dispcc-sm8250: Disable EDP_GTC for sm8350
Date:   Wed,  2 Nov 2022 10:01:36 +0100
Message-Id: <20221102090140.965450-2-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102090140.965450-1-robert.foss@linaro.org>
References: <20221102090140.965450-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM8350 does not have the EDP_GTC clock, so let's disable it
for this SoC.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/dispcc-sm8250.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
index 709076f0f9d7..180ac2726f7e 100644
--- a/drivers/clk/qcom/dispcc-sm8250.c
+++ b/drivers/clk/qcom/dispcc-sm8250.c
@@ -1330,6 +1330,9 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
 		disp_cc_pll1_config.test_ctl_hi1_val = 0x01800000;
 		disp_cc_pll1_init.ops = &clk_alpha_pll_lucid_5lpe_ops;
 		disp_cc_pll1.vco_table = lucid_5lpe_vco;
+
+		disp_cc_sm8250_clocks[DISP_CC_MDSS_EDP_GTC_CLK] = NULL;
+		disp_cc_sm8250_clocks[DISP_CC_MDSS_EDP_GTC_CLK_SRC] = NULL;
 	}
 
 	clk_lucid_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
-- 
2.34.1

