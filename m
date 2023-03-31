Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5436D2A92
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 00:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjCaV77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbjCaV7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:59:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7868918F9C
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680299908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dtvlaUsuOBNnhs3AQ92aPIaKuLGL5kAklD70GeG4yxs=;
        b=HM+hpeDYSl7PrBzo/IYHD3BmPOGmGekWNnqiGZnD7jcRlusVTj9fi32RXE2b0qqR48m5nO
        qbRLhEGLgbKvRIo+QHU9rdjfPjwKQcLoiLt8QaWxQ+LqI3qWG4qTb13kU4TABFuqFGMSA5
        K87QlxdFPizSe8d8ir399qVomlhMFiw=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-uB74awJPNc61qsuN1ZzzPg-1; Fri, 31 Mar 2023 17:58:27 -0400
X-MC-Unique: uB74awJPNc61qsuN1ZzzPg-1
Received: by mail-oo1-f70.google.com with SMTP id i2-20020a4abc02000000b0052529fc100aso6410653oop.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680299906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtvlaUsuOBNnhs3AQ92aPIaKuLGL5kAklD70GeG4yxs=;
        b=1W8tIxHqSluAn1kv/s9S3U8aVQHjd8nkGq6Rc7AnuoaSLb6tYnRYQOu9cSzXHs029A
         oqVE0kABEeWJNUgDh6uvZeTz2sM+1SeoV15vQUzqU2adc9InC6W1/34Oj5efAc7vVyj8
         LAKuV2oSlOmrK3zWABBwLzOaKvsniLmB/WEI+DSh61NHDeehVFSfAGrZrk+niqZprSlx
         HEHKTg1TKmo6YCxGMvx6Ff77CD7jqPhT7YosnKpJ17blRMeFfynLtvOsRhAlkIEAj4IS
         +ZB5T+lu8guS1nwjtlwEXpDseZfINH9DcWp1qZAtmjcHZCBoIXVv4ESvPf7y8vRswk1r
         kR4Q==
X-Gm-Message-State: AO0yUKVhyRSRRb6KEy7GgYcdg8peRPWGn7NaPtJC6SU2MVHGzm1qYJyu
        Sj3m3QIXt4kyLogDhrhbzqxGklwXEMAUF9JAHJc1SPkkMRKHorvmIt7/gMj7achdxMarBeDqogH
        CSYbTu28SkRIXoLRVvOe2CqUYwRajJvkxGmO4UGxPCb6IUIBQnUs93PcjmFgqHNSZOp9wmbDvNE
        WhctyaZm2Z
X-Received: by 2002:a4a:5291:0:b0:520:331d:9514 with SMTP id d139-20020a4a5291000000b00520331d9514mr13579913oob.1.1680299906504;
        Fri, 31 Mar 2023 14:58:26 -0700 (PDT)
X-Google-Smtp-Source: AK7set+TK42AynW8tKNUKi0xOljXNnE7dxT5w546BuQvwYGmXJyefwQ/4guiX20WF0fdgNHrp69cag==
X-Received: by 2002:a4a:5291:0:b0:520:331d:9514 with SMTP id d139-20020a4a5291000000b00520331d9514mr13579889oob.1.1680299906227;
        Fri, 31 Mar 2023 14:58:26 -0700 (PDT)
Received: from halaney-x13s.attlocal.net (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id g11-20020a4a894b000000b0053bb2ae3a78sm1299277ooi.24.2023.03.31.14.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 14:58:25 -0700 (PDT)
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
Subject: [PATCH v3 2/3] arm64: dts: qcom: sc8280xp: Add ethernet nodes
Date:   Fri, 31 Mar 2023 16:58:03 -0500
Message-Id: <20230331215804.783439-3-ahalaney@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331215804.783439-1-ahalaney@redhat.com>
References: <20230331215804.783439-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

Changes since v2:
    * Fix spacing (Konrad)

Changes since v1:
    * None

 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 59 ++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 42bfa9fa5b96..f28ea86b128d 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -761,6 +761,65 @@ soc: soc@0 {
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
+
 		gcc: clock-controller@100000 {
 			compatible = "qcom,gcc-sc8280xp";
 			reg = <0x0 0x00100000 0x0 0x1f0000>;
-- 
2.39.2

