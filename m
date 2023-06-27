Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33ED74010C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjF0QYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjF0QYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:24:43 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136453584
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:24:42 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f86e6e4038so42080e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687883080; x=1690475080;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ay5CzniySnwEMooKVt/XOy1z9VfFqB2Jhn8qIwDw2AU=;
        b=pc1ltOmRM0YZYgZOi+g3p1/3rAqT0Q/AYh4yLt+KniBs5IdXvrwjPGmMqK5YTbxCnB
         xFEa8f8eSouuMDsImmQbpOi4CFsZHRb8dMe/581qn6WRKlbvVBluGK+Y5MKQcgRs3jyK
         0+p5RGW7p3bRBXvPM8s4iuiQJNtshbGS/jLgyHx8cKj4ro3LcucpEI+do6hqQmszEKla
         wN0hmUFciYaVoom4FsMVkpXFEkOUNjvK0xP8Zh9+bG8iCLzLdr4pI/Dr2moQcBAR60HO
         6qEFUf332HQDNFd6rdGLwBoEPrVYnH8l5iQJgFvcgGbf1VwyQHndGiRD//DXcMCVcw7F
         lu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687883080; x=1690475080;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ay5CzniySnwEMooKVt/XOy1z9VfFqB2Jhn8qIwDw2AU=;
        b=DgHv0ueOLPnuazB/LvecbhBiaV2yQaaAQhA9n4VeqZU5/pUHACbebZHh2F7JqMZKZ+
         +6SkSbe0+WX2vZ++jCNmvsiga2xJk83KhPisW49YdilWyFL9AhxIzk9BhSmFPqZs11Ep
         3WpYTS+BNuhy7VfPH84plwzBP1Fj8Vv+2ECwWoKi5b1eS5Yzi/uDx2dWjpCKE5EGY6wC
         ZB7mlaTnI23pIsCgZAIxvgbaF8cKH58j3t5p6PNVc6K5/vZZn5cqgSF80LFDx9zobG45
         TVjNQdnOAN0z9Iq/b1esbmdiLBXftNsjoHnywvkbBlzKcodIAJQYaKKpTil6jgHozcRG
         IJow==
X-Gm-Message-State: AC+VfDzNvcDaRJ8IwDovynXDOnWzEJBUUzSMOz5YiMqPKFYil+LEYC3k
        zcR8hEvF4Z8YzXUG9lNVfcUgbA==
X-Google-Smtp-Source: ACHHUZ49YzKh1xHFKDTfmdAfCT+y7MRWyFEMO2kfF9W5tFQkv+4/HgwK3Tei8g4VbO1JOR8V88J7fg==
X-Received: by 2002:a19:4354:0:b0:4f9:56b8:45e5 with SMTP id m20-20020a194354000000b004f956b845e5mr6207966lfj.25.1687883080136;
        Tue, 27 Jun 2023 09:24:40 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id g7-20020a19ac07000000b004fb259a5589sm1190508lfc.104.2023.06.27.09.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 09:24:39 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 27 Jun 2023 18:24:17 +0200
Subject: [PATCH 01/11] arm64: dts: qcom: sc7180: Fix DSI0_PHY reg-names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230627-topic-more_bindings-v1-1-6b4b6cd081e5@linaro.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
In-Reply-To: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Benjamin Li <benl@squareup.com>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Zac Crosby <zac@squareup.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xu Yang <xu.yang_2@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Jun Nie <jun.nie@linaro.org>, Max Chen <mchen@squareup.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        alsa-devel@alsa-project.org, iommu@lists.linux.dev,
        linux-usb@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Rob Herring <robh@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687883074; l=941;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=qMPr5ji7TxiW7p+3tmhmdQkl5/eI9UsztKpO6YmgD0s=;
 b=MbgNEkJ4ywd3Nj8Je7BLfi3S0Ws+2ZSlBsN3swV7U0MpdhsVAYIeNsR07In2pvGOe8Wu+U3MD
 PgOYyCpmXUMAqmmRQTd/MAr5w0NCcApsYpskUCP32H0enI9VrE0eLfz
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

Commit 2b616f86d51b ("arm64: dts: qcom: sc7180: rename labels for DSI
nodes") broke reg-names, possibly with search-and-replace. Fix it.

Fixes: 2b616f86d51b ("arm64: dts: qcom: sc7180: rename labels for DSI nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 34eff97f8630..b9640574e73b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3120,8 +3120,8 @@ mdss_dsi0_phy: phy@ae94400 {
 				reg = <0 0x0ae94400 0 0x200>,
 				      <0 0x0ae94600 0 0x280>,
 				      <0 0x0ae94a00 0 0x1e0>;
-				reg-names = "dsi0_phy",
-					    "dsi0_phy_lane",
+				reg-names = "dsi_phy",
+					    "dsi_phy_lane",
 					    "dsi_pll";
 
 				#clock-cells = <1>;

-- 
2.41.0

