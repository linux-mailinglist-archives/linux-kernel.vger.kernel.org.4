Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFFF718174
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbjEaNX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbjEaNXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:23:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60B91A2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:22:57 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f4f89f71b8so4614386e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685539376; x=1688131376;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hb3cJs8S+b9i+3pqmaiIthRfWx6iQntlvpEpXJn9bLA=;
        b=tWm4kuPdRIaPGwf7Vpgi5R+PsmQ5J49nOnsODqNeP9jWy3KRzIHWSeFkMDXthmi9fu
         UORpSqQedoaUGcM8iFyvOFwzqprX1pj1CVJP/fOJCPar2wn6bbg/rYtSFUerKJ45Cn+t
         liOeMYHHHlXnZUbBCTpbm+CmPTWr+yjAh8/nM909r2nwQLOiXGPJwQ66EczSbR9Pys1E
         /0ByOmRWSWqLhmtYaYBJe2CwMQ/Zs9YQ7kiDePuEuOpwibCHf4wGDgD14Mn40GdFw0XB
         zyHdJLre4s2U2FzGOfm+6k7OjOolzxtBSOaFV3OEVmWTl7txNKn2IEhuIby0F2OhW1+q
         VUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685539376; x=1688131376;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hb3cJs8S+b9i+3pqmaiIthRfWx6iQntlvpEpXJn9bLA=;
        b=PH4n4uptsKxjd4arLWQqWPoWzy3NjJ0cNHXCROBnJ7XidxJ68F9nNFRFRQiuyTGXG6
         HbHmuYpWG49bvKVc43DDz9FhIdxe14ANrfBYXrJX8RpJ7a60Ds23XBnp8CYV1OLeBHWs
         UC3+FriFznFAUKLaGGw+XmocT3lJ6iW0Wt2qughx5CSgSXXB1jnPIC+xBkpHBpDSyMe6
         WM2N92RkS4svkA/yL9aGSeYHrP0V6qJHA/Q+DaggfNjz19KhZKR0pHHzIHHYC+t/MG3f
         PvcbstziQnTXL2B8I6bvDhcOfasa9BD4nmzhtbuLaoFpcjMudNdFkfgf3EqCiqFHjuFq
         1PpA==
X-Gm-Message-State: AC+VfDz5SijNkj/AFhTrjgmQ4SxgFxAXxfSiRQz0unpe0wCkF57lbmnS
        CRDYkrEl/H0mVgr0NCbmffDmZA==
X-Google-Smtp-Source: ACHHUZ7VQDSKkTLphTD91X960e9ZnUQdqciyF3gpI8iNi33oullRyjLbxxYpnR1xEXJovT5YSIjf1A==
X-Received: by 2002:a19:740f:0:b0:4f1:444e:6c5a with SMTP id v15-20020a19740f000000b004f1444e6c5amr2793402lfe.8.1685539375755;
        Wed, 31 May 2023 06:22:55 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id w8-20020ac24428000000b004eb0c51780bsm720138lfl.29.2023.05.31.06.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 06:22:55 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 31 May 2023 15:22:41 +0200
Subject: [PATCH 7/8] arm64: dts: qcom: sm6350: Flush RSC sleep & wake votes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-rsc-v1-7-b4a985f57b8b@linaro.org>
References: <20230531-topic-rsc-v1-0-b4a985f57b8b@linaro.org>
In-Reply-To: <20230531-topic-rsc-v1-0-b4a985f57b8b@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685539362; l=1004;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=469DtGv+StozkNQONl/RzrsYYq164VDguNLK8FCEzCQ=;
 b=4iaFll04ZJ6w8qa55AtksLRnhQ5nFnAq/HVuH0NMmlmCdHLKuch85b+tL3htVyOH8YalkXcpG
 K1DL5/wG9/+B1w/++Hjo918M+f6yHc2ZhnFIEKLpNiZCulmArWN35Ff
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

The rpmh driver will cache sleep and wake votes until the cluster
power-domain is about to enter idle, to avoid unnecessary writes. So
associate the apps_rsc with the cluster pd, so that it can be notified
about this event.

Without this, only AMC votes are being commited.

Fixes: 5f82b9cda61e ("arm64: dts: qcom: Add SM6350 device tree")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 9311bb6bddab..1cdad69e3c07 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -2055,6 +2055,7 @@ apps_rsc: rsc@18200000 {
 			qcom,drv-id = <2>;
 			qcom,tcs-config = <ACTIVE_TCS 2>, <SLEEP_TCS 3>,
 					  <WAKE_TCS 3>, <CONTROL_TCS 1>;
+			power-domains = <&CLUSTER_PD>;
 
 			rpmhcc: clock-controller {
 				compatible = "qcom,sm6350-rpmh-clk";

-- 
2.40.1

