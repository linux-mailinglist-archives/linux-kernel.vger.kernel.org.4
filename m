Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BFD6E1504
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjDMTRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjDMTRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:17:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEB183FA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681413355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k9WWwvbR/FZN1KSYOs1jbDKU8bkcjmWH5j2dCI6i4/4=;
        b=SmVuFS5VMoWqNRgnq3KccY0IPHfde8YRLBIShrdiSeJAs+SksymSQUbe6rWIyn2eiYW/hu
        OmEBZ3eIf+1woDPSXNyoAOHfuUyAkYMBGliAmtGN1k3fuLAIm7z/5mIIOakaFSimTE6P+W
        SCSAHtuESik84Wo7RsVTF/HGDrrsTlg=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-hAUkqqucOA-lswVRclcA2g-1; Thu, 13 Apr 2023 15:15:54 -0400
X-MC-Unique: hAUkqqucOA-lswVRclcA2g-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-54f8e31155bso63892297b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681413352; x=1684005352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9WWwvbR/FZN1KSYOs1jbDKU8bkcjmWH5j2dCI6i4/4=;
        b=eYFO3BtnvoYG8+CtlzqWH+F9xsSS8SpC01CiMyGGxh2RAoe4+iliCb553/L+kR27b8
         V8W+F1QvA3eNtPi9PkbpWttTLGNfmO+S/K7Mz2PJJYBQCguqL66DRreOHa8rig6+LO8+
         l4pvRVv5g3+OmNUn1LOoajTIECWKJED0pmD6LGQcs9C0cY1Kn63uXREn5UfssJjqKbni
         ZNG6BVSPxQ8B/B5wCmO4PfLmzb7X/Ej0UzCOb3kWhulNxLLiKPy11D8qkMjNNzvwXriX
         1Ud/uJGGPLAig78dpuMuXDPh356aXo508yj+JBdN6S9MbBSoounB6UKebjhL273X5i6t
         liPA==
X-Gm-Message-State: AAQBX9fjG2KyKeNXNAH6RJy6jKT2aPAaHIcwH9L+mkcB/Q5ATdB5qxro
        ZG0bQhB4bb8g1bqAi4eYfbePjA4A5982HZReL6y29Ti2i4qa5MKjU6nTmg7XQ4bcpFYrfaAIhOS
        qPIp9rbQko3jP+9idrva/MKDGgwWpl80iArzxPTtNiWXSYKneUIvoPV/Y0r1GIzYa4/AgRebV5y
        9EMg9+9LCx
X-Received: by 2002:a05:6902:114c:b0:b8f:469a:cb9b with SMTP id p12-20020a056902114c00b00b8f469acb9bmr3725973ybu.52.1681413352285;
        Thu, 13 Apr 2023 12:15:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350YRjOhJ5BgTW4nVvR3gmkWclEIC81iF4mHomqOkKgCvCQIoNpZOBWa6bEnrl40W7p2xmQGHGg==
X-Received: by 2002:a05:6902:114c:b0:b8f:469a:cb9b with SMTP id p12-20020a056902114c00b00b8f469acb9bmr3725930ybu.52.1681413351925;
        Thu, 13 Apr 2023 12:15:51 -0700 (PDT)
Received: from halaney-x13s.redhat.com (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id t11-20020a81780b000000b00545a4ec318dsm673203ywc.13.2023.04.13.12.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 12:15:51 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        richardcochran@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        netdev@vger.kernel.org, bmasney@redhat.com, echanude@redhat.com,
        ncai@quicinc.com, jsuraj@qti.qualcomm.com, hisunil@quicinc.com,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH v5 2/3] arm64: dts: qcom: sc8280xp: Add ethernet nodes
Date:   Thu, 13 Apr 2023 14:15:40 -0500
Message-Id: <20230413191541.1073027-3-ahalaney@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413191541.1073027-1-ahalaney@redhat.com>
References: <20230413191541.1073027-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This platform has 2 MACs integrated in it, go ahead and describe them.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

Changes since v4:
    * Be consistent in newlines (Brian)
    * Add Tested-by (Brian)

Changes since v3:
    * Order soc node via unit address (Konrad)
    * Add Reviewed-by (Konrad)

Changes since v2:
    * Fix spacing (Konrad)

Changes since v1:
    * None

 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 60 ++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 42bfa9fa5b96..fb5a3a691679 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -761,6 +761,36 @@ soc: soc@0 {
 		ranges = <0 0 0 0 0x10 0>;
 		dma-ranges = <0 0 0 0 0x10 0>;
 
+		ethernet0: ethernet@20000 {
+			compatible = "qcom,sc8280xp-ethqos";
+			reg = <0x0 0x00020000 0x0 0x10000>,
+			      <0x0 0x00036000 0x0 0x100>;
+			reg-names = "stmmaceth", "rgmii";
+
+			clocks = <&gcc GCC_EMAC0_AXI_CLK>,
+				 <&gcc GCC_EMAC0_SLV_AHB_CLK>,
+				 <&gcc GCC_EMAC0_PTP_CLK>,
+				 <&gcc GCC_EMAC0_RGMII_CLK>;
+			clock-names = "stmmaceth",
+				      "pclk",
+				      "ptp_ref",
+				      "rgmii";
+
+			interrupts = <GIC_SPI 946 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 936 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq", "eth_lpi";
+
+			iommus = <&apps_smmu 0x4c0 0xf>;
+			power-domains = <&gcc EMAC_0_GDSC>;
+
+			snps,tso;
+			snps,pbl = <32>;
+			rx-fifo-depth = <4096>;
+			tx-fifo-depth = <4096>;
+
+			status = "disabled";
+		};
+
 		gcc: clock-controller@100000 {
 			compatible = "qcom,gcc-sc8280xp";
 			reg = <0x0 0x00100000 0x0 0x1f0000>;
@@ -4681,6 +4711,36 @@ dispcc1: clock-controller@22100000 {
 
 			status = "disabled";
 		};
+
+		ethernet1: ethernet@23000000 {
+			compatible = "qcom,sc8280xp-ethqos";
+			reg = <0x0 0x23000000 0x0 0x10000>,
+			      <0x0 0x23016000 0x0 0x100>;
+			reg-names = "stmmaceth", "rgmii";
+
+			clocks = <&gcc GCC_EMAC1_AXI_CLK>,
+				 <&gcc GCC_EMAC1_SLV_AHB_CLK>,
+				 <&gcc GCC_EMAC1_PTP_CLK>,
+				 <&gcc GCC_EMAC1_RGMII_CLK>;
+			clock-names = "stmmaceth",
+				      "pclk",
+				      "ptp_ref",
+				      "rgmii";
+
+			interrupts = <GIC_SPI 929 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 919 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq", "eth_lpi";
+
+			iommus = <&apps_smmu 0x40 0xf>;
+			power-domains = <&gcc EMAC_1_GDSC>;
+
+			snps,tso;
+			snps,pbl = <32>;
+			rx-fifo-depth = <4096>;
+			tx-fifo-depth = <4096>;
+
+			status = "disabled";
+		};
 	};
 
 	sound: sound {
-- 
2.39.2

