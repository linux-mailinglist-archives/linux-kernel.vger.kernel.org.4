Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FACA6D2905
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 21:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjCaT7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 15:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjCaT7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:59:37 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F99A1A7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:59:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m2so23579961wrh.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680292775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiWk/+mgLAf2EnRX8Fh5IMnKjd+gQV6YsVP4qVwV4hY=;
        b=OqnRZ5hnreQvDc4qITG28Gj0eZpJTynwWVjUQkqQ9fkGuQE5+57+3nlQiZQzHX3xFT
         4DTqL7rsejVglX4Z9R0lCMtLo0IiYDv0q2N2yLupeaIyp9ZzPXvMg8we6Ewvit3RJXFr
         oYpZ+ljAGrXQn5sTd85ZTVAEbJfD5PIpfQy/IfUIbjXBJmZT7nTWDlg+ojiges9H0mNq
         6nVjqv+VB/nhU8MW9YgafrTl/XZ6oiNwFiCQMeURtnmrFxFzup86bpevC2Fol6y+ZVYu
         yNskiP7S+FDJiigtAk5PTM5p8b4yaPe/ohHYqGnn8VSMhxFUuGpBxBXlEnjL2giiQjqY
         TZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680292775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qiWk/+mgLAf2EnRX8Fh5IMnKjd+gQV6YsVP4qVwV4hY=;
        b=B6PCh8rWpkni+zS0AZ8RLbQp8fTpTLLIP1w49zItycVQN26egs9YZJcxtKlKsftWAL
         ENSeIF0WJzjT0hljyw4gouL9ues1NQanbwMdHhJjRh1sagmUQB+MolHvMF4u4SdjWotF
         r0N3PhaoBwzZq3mmliwrtgmU375utsVeIA+3frgqIA8YhVbUE2Lh5h50K3JrU0FqZi0e
         MGJd9KwxRqQ6BzN8GF7/NpYrAJMu3RB1V/IOqZxBw4DkW2l2AuN1SuJoFMIz9nJBuGPi
         DQ0U3FpXeCK6d6S2v0qMPBOSMYlHFSImKqiGfPgkNaHTHUIO99cB4NSW1TkLHgcRT2IG
         KIXg==
X-Gm-Message-State: AAQBX9deVTniom+gSX1grHu0aEJJW/ujbSeQVys7RhgxU3Bxst1WKUBL
        NzFM+Sm7gHJzJbJv+dIkx86tnA==
X-Google-Smtp-Source: AKy350bs3QR9n5wuAf+Vh9vvo16nfmEq/pwy+yxQWPrBhA55iLWx6x3/P/6zUnjRXOIpr5hKkU4MuA==
X-Received: by 2002:adf:fac6:0:b0:2cf:e67c:8245 with SMTP id a6-20020adffac6000000b002cfe67c8245mr19196088wrs.44.1680292775092;
        Fri, 31 Mar 2023 12:59:35 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1dc:d1f:e44f:2a1d])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d4ccd000000b002cff0e213ddsm2990286wrt.14.2023.03.31.12.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 12:59:34 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 4/5] arm64: dts: qcom: sa8775p: add UFS nodes
Date:   Fri, 31 Mar 2023 21:59:19 +0200
Message-Id: <20230331195920.582620-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230331195920.582620-1-brgl@bgdev.pl>
References: <20230331195920.582620-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add nodes for the UFS and its PHY on sa8775p platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 54 +++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index de5e8449397c..c737e67b9239 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -586,6 +586,60 @@ &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
 			};
 		};
 
+		ufs_mem_hc: ufs@1d84000 {
+			compatible = "qcom,sa8775p-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
+			reg = <0x0 0x01d84000 0x0 0x3000>;
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&ufs_mem_phy>;
+			phy-names = "ufsphy";
+			lanes-per-direction = <2>;
+			#reset-cells = <1>;
+			resets = <&gcc GCC_UFS_PHY_BCR>;
+			reset-names = "rst";
+			power-domains = <&gcc UFS_PHY_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
+			iommus = <&apps_smmu 0x100 0x0>;
+			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_UFS_PHY_AHB_CLK>,
+				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
+				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
+				 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
+			clock-names = "core_clk",
+				      "bus_aggr_clk",
+				      "iface_clk",
+				      "core_clk_unipro",
+				      "ref_clk",
+				      "tx_lane0_sync_clk",
+				      "rx_lane0_sync_clk",
+				      "rx_lane1_sync_clk";
+			freq-table-hz = <75000000 300000000>,
+					<0 0>,
+					<0 0>,
+					<75000000 300000000>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<0 0>;
+			status = "disabled";
+		};
+
+		ufs_mem_phy: phy@1d87000 {
+			compatible = "qcom,sa8775p-qmp-ufs-phy";
+			reg = <0x0 0x01d87000 0x0 0xe10>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
+				 <&gcc GCC_EDP_REF_CLKREF_EN>;
+			clock-names = "ref", "ref_aux", "qref";
+			power-domains = <&gcc UFS_PHY_GDSC>;
+			resets = <&ufs_mem_hc 0>;
+			reset-names = "ufsphy";
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x20000>;
-- 
2.37.2

