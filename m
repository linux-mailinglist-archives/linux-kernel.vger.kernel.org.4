Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A18473F733
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjF0I3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjF0I2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:28:16 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C4726A8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:28:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so482020566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1687854489; x=1690446489;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8uhdc0vGRhVZn7i76kQPqxuDPzGvhRMJMMuHesHRx0=;
        b=jA3lP92ZFZ2gqMx6lDW6O07ihkd3l3XzaGJxuC/g2wtwdnfKVTbxH8xMCmMBhFkAfn
         XhRWbXQmZW9VfqvKgM9V/ufYcXvvOcE0Pr7oqA1TBEw8ivcUkqoOPWNrFgbJc/kxkxw3
         fyqQIMK2YqEJvvN/YHps3MSQuC08HiFJ5o7pDNwEVCWtwE1efv8ygroRZZlTrho0NP//
         9EER9mVtiNQMkxuGU1pLiLj8pD8fcA4HObgafIcVSDg0PCVhE1Kfqz0au+iBg6dl2wRa
         cyN6klB5VHWvtkGIH/be8fHAYD9RHnPxEtksmQEkAZHUzs2YDxBi4nBDRKY6ZhLbl8E4
         Asag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687854489; x=1690446489;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8uhdc0vGRhVZn7i76kQPqxuDPzGvhRMJMMuHesHRx0=;
        b=iUQE2gg42VViWcRTMpVnSkNS7zcD1qmWhYe8xoamlH6hVq6ntsXf59Yi+ivlNmfXlr
         APTv3FWv4TQ+p5/1FYz8s8WqLLeypPjM3AqNepAC27cohE5g7F9cByk1SU8cuuHlzBgH
         duj3JpYeTUEuLYrC9RCS4DgPTZ4QBhEYpyOqPOJgfvYCo1zj5V7umBeDCjXSHktrkfV2
         yM8M8Z0jcQFySgrmy6MgGpuziujHUbS/JcCQeLxk399k3dd01XOu0x7LOK3FTe6cGLa0
         uTxIllSvpcLxn6wybasaURU+p2a6vEEenOabj1vp2Wsci8MzoCzkogYQa0NLrEX2qXln
         AzPw==
X-Gm-Message-State: AC+VfDz/vGoZjnPgb55qXnTHeJc6SmvSakp62iQXTv5PHA9fPIhlE8vh
        4ADmSdVelK5OEscI00TsU4Njpw==
X-Google-Smtp-Source: ACHHUZ4b8ooGad04xAZNZR46c7dDBigN6joEZVBjCg51B/ahsXcmBhiabKcqs0pCUO20Iz0Jg4YNQA==
X-Received: by 2002:a17:907:5c8:b0:974:7713:293f with SMTP id wg8-20020a17090705c800b009747713293fmr29242940ejb.41.1687854489185;
        Tue, 27 Jun 2023 01:28:09 -0700 (PDT)
Received: from [172.16.240.113] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id kt19-20020a170906aad300b009894b476310sm4253038ejb.163.2023.06.27.01.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 01:28:08 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Tue, 27 Jun 2023 10:28:05 +0200
Subject: [PATCH v5 5/5] arm64: dts: qcom: sm8450: Use standalone ICE node
 for UFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221209-dt-binding-ufs-v5-5-c9a58c0a53f5@fairphone.com>
References: <20221209-dt-binding-ufs-v5-0-c9a58c0a53f5@fairphone.com>
In-Reply-To: <20221209-dt-binding-ufs-v5-0-c9a58c0a53f5@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <me@iskren.info>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the ICE driver now merged let's convert the ufs node to use the new
style.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 5cd7296c7660..79627117a776 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -4120,9 +4120,7 @@ system-cache-controller@19200000 {
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,sm8450-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
-			reg = <0 0x01d84000 0 0x3000>,
-			      <0 0x01d88000 0 0x8000>;
-			reg-names = "std", "ice";
+			reg = <0 0x01d84000 0 0x3000>;
 			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
 			phys = <&ufs_mem_phy_lanes>;
 			phy-names = "ufsphy";
@@ -4147,8 +4145,7 @@ ufs_mem_hc: ufshc@1d84000 {
 				"ref_clk",
 				"tx_lane0_sync_clk",
 				"rx_lane0_sync_clk",
-				"rx_lane1_sync_clk",
-				"ice_core_clk";
+				"rx_lane1_sync_clk";
 			clocks =
 				<&gcc GCC_UFS_PHY_AXI_CLK>,
 				<&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
@@ -4157,8 +4154,7 @@ ufs_mem_hc: ufshc@1d84000 {
 				<&rpmhcc RPMH_CXO_CLK>,
 				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
-				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
-				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
 			freq-table-hz =
 				<75000000 300000000>,
 				<0 0>,
@@ -4167,8 +4163,9 @@ ufs_mem_hc: ufshc@1d84000 {
 				<75000000 300000000>,
 				<0 0>,
 				<0 0>,
-				<0 0>,
-				<75000000 300000000>;
+				<0 0>;
+			qcom,ice = <&ice>;
+
 			status = "disabled";
 		};
 
@@ -4198,6 +4195,13 @@ ufs_mem_phy_lanes: phy@1d87400 {
 			};
 		};
 
+		ice: crypto@1d88000 {
+			compatible = "qcom,sm8450-inline-crypto-engine",
+				     "qcom,inline-crypto-engine";
+			reg = <0 0x01d88000 0 0x8000>;
+			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+		};
+
 		cryptobam: dma-controller@1dc4000 {
 			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
 			reg = <0 0x01dc4000 0 0x28000>;

-- 
2.41.0

