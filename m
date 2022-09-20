Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A52A5BDF9B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiITIOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiITINr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:13:47 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8605765804;
        Tue, 20 Sep 2022 01:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=1mp9KTiW7Fzm6dAODf6CTuUENPLklhUU20Em/a8MWa8=; b=AvO2L/zPgU6iS/Jvdu6/w1f/L/
        EYnLaEYsUxhR3zUiTcanrsHhRNONsQI4e3RCQFkyJNG8zZWkeeKA6PvR1qqr0a3wg8ztlsM+J2Z5/
        be28mOA8NPasP1owY5pZ//NtgvG52IAUi0tVmAyb77Oz7UG1o6w5w7zjyHD2lmzbrDQYGXZoM0bKm
        6WZdZlmiNfp2rpLm1zKY1SmfaYlU/Cdkf/+UkFkPXm6m/mJ4wZMrW13buzuVg19+6vrRoWGX2Sb+I
        dV4+aHZbMoLOKMH/jSz095nUnlHEZLKAqkvkITMMJenosm3lEyPSsGqFInSQDvDiTerr5y/yUKnbL
        LX6FyB3w==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1oaYMo-0017q3-U6; Tue, 20 Sep 2022 11:12:30 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/8] arm64: tegra: Add NVDEC on Tegra234
Date:   Tue, 20 Sep 2022 11:11:59 +0300
Message-Id: <20220920081203.3237744-5-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220920081203.3237744-1-cyndis@kapsi.fi>
References: <20220920081203.3237744-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Add a device tree node for NVDEC on Tegra234.

Booting the firmware requires some information regarding offsets
within the firmware binary. These are passed through the device
tree, but since the values vary depending on the firmware version,
and the firmware itself is not available to the OS, the flasher is
expected to provide a device tree overlay with values corresponding
to the firmware it is flashing. The overlay then replaces the
placeholder values here.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 27 ++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 81a0f599685f..65d49b27bc5f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -586,6 +586,33 @@ vic@15340000 {
 				iommus = <&smmu_niso1 TEGRA234_SID_VIC>;
 				dma-coherent;
 			};
+
+			nvdec@15480000 {
+				compatible = "nvidia,tegra234-nvdec";
+				reg = <0x15480000 0x00040000>;
+				clocks = <&bpmp TEGRA234_CLK_NVDEC>,
+				         <&bpmp TEGRA234_CLK_FUSE>,
+				         <&bpmp TEGRA234_CLK_TSEC_PKA>;
+				clock-names = "nvdec", "fuse", "tsec_pka";
+				resets = <&bpmp TEGRA234_RESET_NVDEC>;
+				reset-names = "nvdec";
+				power-domains = <&bpmp TEGRA234_POWER_DOMAIN_NVDEC>;
+				interconnects = <&mc TEGRA234_MEMORY_CLIENT_NVDECSRD &emc>,
+				                <&mc TEGRA234_MEMORY_CLIENT_NVDECSWR &emc>;
+				interconnect-names = "dma-mem", "write";
+				iommus = <&smmu_niso1 TEGRA234_SID_NVDEC>;
+				dma-coherent;
+
+				nvidia,memory-controller = <&mc>;
+
+				/* Placeholder values, to be replaced with values from overlay */
+				nvidia,bl-manifest-offset = <0>;
+				nvidia,bl-data-offset = <0>;
+				nvidia,bl-code-offset = <0>;
+				nvidia,os-manifest-offset = <0>;
+				nvidia,os-data-offset = <0>;
+				nvidia,os-code-offset = <0>;
+			};
 		};
 
 		gpio: gpio@2200000 {
-- 
2.37.0

