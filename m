Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D712B5BD70D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 00:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiISWPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 18:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiISWPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 18:15:45 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5044DF39
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:15:32 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id a29so953468pfk.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=DRxqMyGvhPtofl8YxA3T39m6sweXx0A08o/k3+hG0Lk=;
        b=S20OV1WVT6ahPEdkPKZYnRFNaEiVhTD3umoyZtuzqAkz59ljaSe6lHSxvwdEBEjwO3
         tjyE5xFjWHiOu95Y7tiYOd8XP2hdcuwaANpgRcxcn0Ntw60aQtyGs8TjsEhhm6g6W/AD
         B3R3psrMdvafTvesEJCJgII52ZunxtJgWzbdixMWoqmPUDj4QSbQcd7I3E2fD1NP9Z9l
         QHpLXr8NgWSUo0MEYv0fvu7xEkRpht4ARkQuu4NZtVPYLjrULTvnzxy01HQez9T2Gnkj
         49qNtWtSEdrLSUKGY9OsubQnpSDMQxv23EmtZJMZqMgjPd6RjzcoKPDRK/h67i/E8D/N
         Jyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DRxqMyGvhPtofl8YxA3T39m6sweXx0A08o/k3+hG0Lk=;
        b=RkRKCzE74T55EavCffO1F5XdQ21lIqFCUCFURi8zrIcM3KBytxYlPvw6UH/KJcCnGk
         d9pkBU9+K++9QI6TkqXZQaAF+HQJtujOzuINvXCyDKuKdwQ5glngUOgMVXue5UTfbMrt
         Hk++rBy7Z/VB0DHDC0z1u3MGgkv7Ht07q1cdh+zPRo/LZfsjz/ilHNocnbn9+j99S9u4
         PeDlHCYuX/bBFzdxEdUp6pkk9at8/XHfJhZjqn3bBILp6x4uvwSwzqsWqqjnsojUzN60
         YourXcSk0o4EN1e+Y3j2OBAK71DMaW0TiQiz8l7SCya/yufOjHweOLC2pCoR+ZKU+qQI
         kSDA==
X-Gm-Message-State: ACrzQf0TNxPW931jTU38RSqeUfy8IfofVgITAq8zNPhFPKy6mMiMapWT
        99JraJe13QD88sW9TvaD+NykrQ==
X-Google-Smtp-Source: AMsMyM7Y4Qbt7tlg+lDefUN99fZmk5adL/WAtpTvuR9koYYbTSquLK920at5EvVXbbrskFksRxhDKQ==
X-Received: by 2002:a63:5b61:0:b0:41d:3227:37b8 with SMTP id l33-20020a635b61000000b0041d322737b8mr17238272pgm.265.1663625731881;
        Mon, 19 Sep 2022 15:15:31 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:6535:ca5f:67d1:670d:e188])
        by smtp.gmail.com with ESMTPSA id b22-20020a170902d89600b00176ab6a0d5fsm16198966plz.54.2022.09.19.15.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 15:15:31 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, thara.gopinath@gmail.com,
        devicetree@vger.kernel.org, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        Jordan Crouse <jorcrous@amazon.com>
Subject: [PATCH v6 2/4 RESEND] arm64: dts: qcom: sm8250: Add dt entries to support crypto engine.
Date:   Tue, 20 Sep 2022 03:45:07 +0530
Message-Id: <20220919221509.1057574-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220919221509.1057574-1-bhupesh.sharma@linaro.org>
References: <20220919221509.1057574-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add crypto engine (CE) and CE BAM related nodes and definitions to
'sm8250.dtsi'.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Tested-by: Jordan Crouse <jorcrous@amazon.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index a5b62cadb129..7b3af34f8486 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2188,6 +2188,34 @@ ufs_mem_phy_lanes: phy@1d87400 {
 			};
 		};
 
+		cryptobam: dma-controller@1dc4000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0 0x01dc4000 0 0x24000>;
+			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			iommus = <&apps_smmu 0x584 0x0011>,
+				 <&apps_smmu 0x586 0x0011>,
+				 <&apps_smmu 0x594 0x0011>,
+				 <&apps_smmu 0x596 0x0011>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 &mc_virt SLAVE_EBI_CH0>;
+			interconnect-names = "memory";
+		};
+
+		crypto: crypto@1dfa000 {
+			compatible = "qcom,sm8250-qce";
+			reg = <0 0x01dfa000 0 0x6000>;
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x584 0x0011>,
+				 <&apps_smmu 0x586 0x0011>,
+				 <&apps_smmu 0x594 0x0011>,
+				 <&apps_smmu 0x596 0x0011>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 &mc_virt SLAVE_EBI_CH0>;
+			interconnect-names = "memory";
+		};
+
 		ipa_virt: interconnect@1e00000 {
 			compatible = "qcom,sm8250-ipa-virt";
 			reg = <0 0x01e00000 0 0x1000>;
-- 
2.37.1

