Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB1F72BCBE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjFLJdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjFLJbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:31:23 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28614205
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:25:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so3894818f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686561903; x=1689153903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5Kztbbt+Lx+Q6hVK4LvKEHOry/qYQ8OvL9Z8ei/Rso=;
        b=P/Jhfjzh0ruh8aQrw/lvBEWcmDeyZDzd+KU0wuDZSn9r92Pbi5G0y48qPXJTHn5RC4
         kIzNj52wkDwMA68v/kq9zzP3zPaQKZim/cG9i+vNjAzcAMo1M4AcuVkSgWsHGt2DU2LU
         PFrSXKzl06uMIUf7pVrJo4DjNQp8LvcL0gIpifSO0LwHiJsrWKXsQGTWDhllY4QeBTNF
         CNaL9VHRXacLDGSae9qdh7Z++fN1rP4KZe9SPL0P3QQeakYkXnojA+fEt/yIZB3h/PPT
         QNUg7068ipJqt+O5/0maFA8OJzwE+Ya05qCeGA7lNrXRD1vNSDOG0Hl6TSakoutgdRgf
         VzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561903; x=1689153903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5Kztbbt+Lx+Q6hVK4LvKEHOry/qYQ8OvL9Z8ei/Rso=;
        b=SEkNFmUguLxCgx1WBHiXXS0MWG5CMffGuPmAcLhYuG6HmupFyEka7jJldKGrCK8d3N
         4JWCkNALFLAh5SVqwxdLeRkgP0KL7g0n6u/m4sNQBvMnkSA4L17SdJEf3bSc2fZHTAXI
         FOVru16D31Ly5qU4vMiIYAjGqslzMBwsLqiaFfM50Gff7AbPE1KBgVEbvQrEKSmOxX3v
         vOap6BH10OtnNNfz3rl9rau6X1BfNgAhaKyh8Ts+yx6KGIwX3MCgYwrsYQ6e1xhx1ZRW
         CTT8E3hwHvNlmkRzScLqLz3YMIFIAntRSf3TLNwKKY44cPreJOOcbtx/gTtSOJL3yW7X
         nbHg==
X-Gm-Message-State: AC+VfDzU9YlJwYB/uyfX7axMbes/etprF9IEiyxWlnmcje+XcSj16vhv
        1IQ2fH8Tg1z9kvZfxoV19EzgBw==
X-Google-Smtp-Source: ACHHUZ6kJTKSQMRxQnmZHKgDHv+8GM+Ey+dfH5KXUQrQ58aTzmadnxCcaM+NOxPdk4JKh+HKGp5Seg==
X-Received: by 2002:a5d:6403:0:b0:307:7e64:4b52 with SMTP id z3-20020a5d6403000000b003077e644b52mr4735283wru.36.1686561903258;
        Mon, 12 Jun 2023 02:25:03 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a222:bbe9:c688:33ae])
        by smtp.gmail.com with ESMTPSA id p14-20020a7bcc8e000000b003f727764b10sm10892044wma.4.2023.06.12.02.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:25:02 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 26/26] arm64: dts: qcom: sa8775p-ride: enable ethernet0
Date:   Mon, 12 Jun 2023 11:23:55 +0200
Message-Id: <20230612092355.87937-27-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612092355.87937-1-brgl@bgdev.pl>
References: <20230612092355.87937-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable the first 1Gb ethernet port on sa8775p-ride development board.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 89 +++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index dbd9553aa5c7..13508271bca8 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -261,6 +261,95 @@ vreg_l8e: ldo8 {
 	};
 };
 
+&ethernet0 {
+	phy-mode = "sgmii";
+	phy-handle = <&sgmii_phy>;
+	phy-supply = <&vreg_l5a>;
+
+	pinctrl-0 = <&ethernet0_default>;
+	pinctrl-names = "default";
+
+	snps,mtl-rx-config = <&mtl_rx_setup>;
+	snps,mtl-tx-config = <&mtl_tx_setup>;
+	snps,ps-speed = <1000>;
+
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reset-gpios = <&pmm8654au_2_gpios 8 GPIO_ACTIVE_LOW>;
+		reset-delay-us = <11000>;
+		reset-post-delay-us = <70000>;
+
+		sgmii_phy: phy@8 {
+			reg = <0x8>;
+			device_type = "ethernet-phy";
+		};
+	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <4>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+			snps,route-up;
+			snps,priority = <0x1>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x1>;
+			snps,route-ptp;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x2>;
+			snps,route-avcp;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x3>;
+			snps,priority = <0xc>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <4>;
+		snps,tx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+	};
+};
+
 &i2c11 {
 	clock-frequency = <400000>;
 	pinctrl-0 = <&qup_i2c11_default>;
-- 
2.39.2

