Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94706C248A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjCTWTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCTWSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:18:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F198634C14
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679350621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=st1rjJ7aUc1T8Np6RFrdYsV7Bx3+UgNenWZwcLLRIAM=;
        b=gSqWfL7VIfltej02AM5R8W/HHRCvWNp1a8+SZVFC69Xml6Wcklqm5syHH04QK6lAnC54J9
        wvG7aXcP1Ahxnlx8quP64goyfmnbsDWwu/IPSnmObUHhVcDIs35bSdwrJJm+pgbedOccAg
        wyxVvc3omawv5WazoMGvcgj3VS3U/ME=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-YjZyWqVaO8ObdWRlNkNCpA-1; Mon, 20 Mar 2023 18:17:00 -0400
X-MC-Unique: YjZyWqVaO8ObdWRlNkNCpA-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-17e0c22bc88so3496850fac.19
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679350618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=st1rjJ7aUc1T8Np6RFrdYsV7Bx3+UgNenWZwcLLRIAM=;
        b=4zkZ+nQIieKXvrLIM8lrJ+JEWbPXF9vVLBrQnyiJsxCtp09uuv9raJw+z45YTFzpUl
         YlFh2YuDtmYCx1MwfczIfe5NGSI3uk30/6uAxtElcG98Lx4oPulFvmy8IJRxL1daWC62
         4lrXzbQIcKI5fXLVhkQ77cYHKRdt4vj5m2FfR5qk4aRJ/YSsKX5ZzHnY/RqjCGaHl9Zl
         G2xJcd9Tf1MNApCcYxW6B9BFVKw+ZZ+ee1TPdT/DOyR/J4Y9EuC5xwsnmJ+AoED9jYYw
         TMiUda6lQqGrJSBwjjoRXRDaDYRAYE7CHdNRI3g/ktvUurkN55sSJykI93a7Yih/BZD5
         c4ug==
X-Gm-Message-State: AO0yUKU4z10jIBrDFoGBUAJHwaHXfY31SX/A5zmQ/i29th5MgtWfQQ61
        F/mHiSBWSNI6bw7/RD6acf6tWGn3mVvhsG4IhdwMuokgQPumYuV9QJN1iXxw/WkhrqIlAOZ3YF0
        zC3z1w/qOhaVmTkJmyStpqCTzHk3szMQVDTFtFHlqswD16/PX/ZJc2AmNyQPQqSRmv4QfJOQDr3
        1ncofmKJU8m/8=
X-Received: by 2002:a4a:5213:0:b0:51a:6ea9:5053 with SMTP id d19-20020a4a5213000000b0051a6ea95053mr552534oob.9.1679350618748;
        Mon, 20 Mar 2023 15:16:58 -0700 (PDT)
X-Google-Smtp-Source: AK7set/I1dgh6ojXzLoG9TkOkq4yCA55YncbX2+E5PoAf4MDA49+HyT7Pkos0cAy5On/2t8jXt8KZw==
X-Received: by 2002:a4a:5213:0:b0:51a:6ea9:5053 with SMTP id d19-20020a4a5213000000b0051a6ea95053mr552491oob.9.1679350618286;
        Mon, 20 Mar 2023 15:16:58 -0700 (PDT)
Received: from halaney-x13s.redhat.com (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id q204-20020a4a33d5000000b0053853156b5csm4092465ooq.8.2023.03.20.15.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 15:16:57 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        bhupesh.sharma@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, peppe.cavallaro@st.com,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
        linux@armlinux.org.uk, veekhee@apple.com,
        tee.min.tan@linux.intel.com, mohammad.athari.ismail@intel.com,
        jonathanh@nvidia.com, ruppala@nvidia.com, bmasney@redhat.com,
        andrey.konovalov@linaro.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, ncai@quicinc.com,
        jsuraj@qti.qualcomm.com, hisunil@quicinc.com, echanude@redhat.com,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH net-next v2 06/12] arm64: dts: qcom: sc8280xp: Add ethernet nodes
Date:   Mon, 20 Mar 2023 17:16:11 -0500
Message-Id: <20230320221617.236323-7-ahalaney@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320221617.236323-1-ahalaney@redhat.com>
References: <20230320221617.236323-1-ahalaney@redhat.com>
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

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

Changes since v1:
	* None

 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 53 ++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 0d02599d8867..a63e8e81a8c4 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -761,6 +761,59 @@ soc: soc@0 {
 		ranges = <0 0 0 0 0x10 0>;
 		dma-ranges = <0 0 0 0 0x10 0>;
 
+		ethernet0: ethernet@20000 {
+			compatible = "qcom,sc8280xp-ethqos";
+			reg = <0x0 0x00020000 0x0 0x10000>,
+				<0x0 0x00036000 0x0 0x100>;
+			reg-names = "stmmaceth", "rgmii";
+
+			clocks = <&gcc GCC_EMAC0_AXI_CLK>,
+				<&gcc GCC_EMAC0_SLV_AHB_CLK>,
+				<&gcc GCC_EMAC0_PTP_CLK>,
+				<&gcc GCC_EMAC0_RGMII_CLK>;
+			clock-names = "stmmaceth", "pclk", "ptp_ref", "rgmii";
+
+			interrupts = <GIC_SPI 946 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 936 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq", "eth_lpi";
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
+		ethernet1: ethernet@23000000 {
+			compatible = "qcom,sc8280xp-ethqos";
+			reg = <0x0 0x23000000 0x0 0x10000>,
+				<0x0 0x23016000 0x0 0x100>;
+			reg-names = "stmmaceth", "rgmii";
+
+			clocks = <&gcc GCC_EMAC1_AXI_CLK>,
+				<&gcc GCC_EMAC1_SLV_AHB_CLK>,
+				<&gcc GCC_EMAC1_PTP_CLK>,
+				<&gcc GCC_EMAC1_RGMII_CLK>;
+			clock-names = "stmmaceth", "pclk", "ptp_ref", "rgmii";
+
+			interrupts = <GIC_SPI 929 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 919 IRQ_TYPE_LEVEL_HIGH>;
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
+
 		gcc: clock-controller@100000 {
 			compatible = "qcom,gcc-sc8280xp";
 			reg = <0x0 0x00100000 0x0 0x1f0000>;
-- 
2.39.2

