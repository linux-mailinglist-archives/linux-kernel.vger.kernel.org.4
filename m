Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCDB6D260B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjCaQqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjCaQpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:45:20 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD11CC05
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:44:09 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so23961268pjz.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680281046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuEDYxPh1iqRLp/0Giai1ZnY3ruEMo64qCfhktsCtAU=;
        b=Ux+Q3qKm93LGW1CPI1uH9edfXV60TnNyp231STi5a0jylVo3YVPtuFwGbfLcKnphCq
         suXMco85bicN22P5FfzSSIKWDGaUpFO/PAXuWxGsV3TlPKXTnj7FlOfnr1HxcCzMDgGq
         GIQQu5zGRy7xh9ym91vUK8bjbWq2iIpQdu8wYOifkrndI4f2/keq74jtn5+P+/18EDFD
         OdPyvDhzt/0auzhWvdF6+Ga8Gdi+VEBGhEy4PGnzk7tUr4QIaYVigT329Z9wVf5NPQ21
         YPP4p3wiyQ7586U95iZEedGGAWl1vZrlFyH/YytW9n6N4D//2T9vUuzDI2ndC4uXUUcT
         +nOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680281046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuEDYxPh1iqRLp/0Giai1ZnY3ruEMo64qCfhktsCtAU=;
        b=WNhB3C/KHLttTD3Hw2qKq0UH2VzhVG0zfnJ5sn3JHOn93i4aYh50+WGYj1azYrJpr1
         Ksi0zu2DF1bniy8ubYJAOzeN++nxv//kYo/Ui2uoqILc0mPHSzSBTcidGd+14Wx977Fd
         NHPjeGeNQFPin9vM98XTGWsG+Clz6NVISRHqIiAYODdir9AN19Rq1WezdAfd92ZGgoKT
         j538jLCYt4hB1P+RFveBO1EVGDCUJxf0NY8wYmWhdCmH3XD8XyVFhaqmvlMDHPMI6qBI
         XXi5kvxGnbBEnhPP027I7GB6wY8dwNDfw0JaYzf88WaDNGPBtOpjZIDWtV4+1tCOZBmb
         PQGA==
X-Gm-Message-State: AAQBX9fnpNFg0A1mLwwe+Hwyg54+uCdvGipMklN2m3SYhvpQMZmyyxDd
        q+BgsKpVOWBx/hmet6gevbPk/g==
X-Google-Smtp-Source: AKy350YrFnTQteSVPXoJ1DU+cOvZPqDc0sncTaXFpNr4hMxTFxsVvJ8G4XF9n0y5AWbND7vrZOgvWA==
X-Received: by 2002:a17:90b:1a88:b0:23e:aba9:d51d with SMTP id ng8-20020a17090b1a8800b0023eaba9d51dmr30114332pjb.7.1680281046637;
        Fri, 31 Mar 2023 09:44:06 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c5e:53ce:1f39:30a5:d20f:f205])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902b40d00b0019b089bc8d7sm1798767plr.78.2023.03.31.09.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 09:44:06 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
Subject: [PATCH v4 07/11] arm64: dts: qcom: sm6115: Add Crypto Engine support
Date:   Fri, 31 Mar 2023 22:13:19 +0530
Message-Id: <20230331164323.729093-8-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230331164323.729093-1-bhupesh.sharma@linaro.org>
References: <20230331164323.729093-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add crypto engine (CE) and CE BAM related nodes and definitions to
'sm6115.dtsi'.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 2a51c938bbcb..ebac026b4cc7 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -650,6 +650,28 @@ usb_hsphy: phy@1613000 {
 			status = "disabled";
 		};
 
+		cryptobam: dma-controller@1b04000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0x0 0x01b04000 0x0 0x24000>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			num-channels = <8>;
+			qcom,num-ees = <2>;
+			iommus = <&apps_smmu 0x94 0x11>,
+				 <&apps_smmu 0x96 0x11>;
+		};
+
+		crypto: crypto@1b3a000 {
+			compatible = "qcom,sm6115-qce", "qcom,sm8150-qce", "qcom,qce";
+			reg = <0x0 0x01b3a000 0x0 0x6000>;
+			dmas = <&cryptobam 6>, <&cryptobam 7>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x94 0x11>,
+				 <&apps_smmu 0x96 0x11>;
+		};
+
 		qfprom@1b40000 {
 			compatible = "qcom,sm6115-qfprom", "qcom,qfprom";
 			reg = <0x0 0x01b40000 0x0 0x7000>;
-- 
2.38.1

