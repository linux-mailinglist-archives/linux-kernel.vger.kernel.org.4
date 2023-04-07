Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586B46DAAFC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240528AbjDGJfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbjDGJed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:34:33 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F8B59D8
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:34:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id y14so41882230wrq.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 02:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680860071; x=1683452071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tORp1I37+JIRNlLfmuNLwniBkIh0XbsRy1El1Qwfh5w=;
        b=RSuG1BBx4bCJQ0eYtxaDMD910vcDXWy+sIyWzJ1nIcv/nKMsdJB1eaQrQyFQz+4FGF
         xuqULq4rBZ0/Kv7cxGn8KM2rTQaBoUjJgrF+k0xZbk8Tf7zvSEw9CyEiEWebrd/sIO/C
         pdQYBZgmsjzw92YR4NwCKHl7C7kQKkhmJ0dcRQeuAI9Tb35vmPY59HOfQeewwTsPys27
         mdXTTX0/+BJmP8AS/nIvNZacmkXpxKa5U0MsNq35Syd6OI+1JpAFzvCG9UEKjiP/OaX3
         Ed1xWybbx5PBFFwBlb2IPeTqAMl9Ye1keoxUvrh6yH4bbwywOq8QcOanwdWKjBwMqFql
         zmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680860071; x=1683452071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tORp1I37+JIRNlLfmuNLwniBkIh0XbsRy1El1Qwfh5w=;
        b=oWNH+Al1rJth5O8QJYqOq4U6xkL+rFfqSLVBTWURsaqWVNox2XYzNzEUXoZEAuF+Lx
         RmBzkxAlSUh1wFDStSp5NWd0sq4eNnckncgE4pJkKKmqQuiuN1ubpuojTQdhmjTgun2/
         v7pMKjbNJ4pEvnWaZMiRh962/X0DheHKRbH0QlqzBo8x+uUdqFTMU9SI5Cv1uejzA8tu
         06PAZlrAGqmuYvbxVx0MeN5GYDciHXQXZpq/zw/e5G0m4i9P4Ku1Y0Eq0b2IbNKf6U4K
         hsexRkTa7hyYa3mC3N0kSfrjWAbkR8JOf0upk496zFuPVSXgIQEEFA3039v6EJFBQnbE
         qGjw==
X-Gm-Message-State: AAQBX9eXNPYN8vELXENrtIdEO81X79qPNEu+CW70Y65hRfiSd5EU2McC
        RXANFMq+5hGLDSwdyRIsn+4Sm10dVDfl8QrxVB0=
X-Google-Smtp-Source: AKy350bRaX25BJjuwBAyn87C14/6uA3JGJnA5KyGgh44d6eFan6tIBFWLkxt/l2BsXfJJPQMt2kKiA==
X-Received: by 2002:adf:ec4d:0:b0:2cf:ea5d:f5fe with SMTP id w13-20020adfec4d000000b002cfea5df5femr955931wrn.36.1680860071643;
        Fri, 07 Apr 2023 02:34:31 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id s13-20020a5d510d000000b002d64fcb362dsm4020432wrt.111.2023.04.07.02.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 02:34:31 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 07 Apr 2023 11:34:16 +0200
Subject: [PATCH v3 5/7] arm64: dts: mediatek: add smi support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v3-5-97e19ad4e85d@baylibre.com>
References: <20230207-iommu-support-v3-0-97e19ad4e85d@baylibre.com>
In-Reply-To: <20230207-iommu-support-v3-0-97e19ad4e85d@baylibre.com>
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2121; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=J4LWefgCJNgBuhY1OJrPCpnKJtdzqFO3621y4agMuJ0=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkL+OhKpEy6cL/H1p/HvPE1aODq1i4kG0au3hXRwDH
 /tjxL7CJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZC/joQAKCRArRkmdfjHURdIKD/
 4iom3SPa8zqPqQUkQ9Jm7J4cF7sgWkc8BOx84oRJ8+klX0dQE0QFEyPsdSHaAjfgWKlikAiuiUzW+v
 EUJ9L7d0mPOg6IzWcAxHE89S06vjqmpBoyVwztw35bheyqzdstL6yfylwrYAfMY8+E8ZkxG9irn6II
 QokCOjedbM7IR/0urZ2vsz0EGilZjbzRKnqxlNUU7GGxXlau5FyS2HID92k6erM51JdDWQO/H2S5jN
 Ug9pUYQfPIH6SX/7ihLD5LIapPfAu0f4JDKp1o6aBgEpriwTUjUEr7Sv34ijvWR8uogIml1R8yPouM
 Yz31dI3xVkQmY9cDh2HO8weWhE6p9VtrCpDGWu15avcMKkc83aro1JbQTbbwsk3kVMgbpUcCkWJpOX
 2HG8JGA+FHVBSEQU4RqPZ36TUDw3ayzOc2NX0SJFN204VVQG/0K3tfMzuMaJrldI8qVDXYr96Bj/Os
 6JNHkOIUzmVyDzHSCcxjNg6wapdWcPot90H3fE4k1ii3ZRjoCescfAizuwSjVWo1HXip2K+qbygS1F
 HlixobTBiOxSESZ9MP5/RQv6lET9NlZ34jSgjvg9fxC5aDzgey89HwW5xaJk5HWqbygLPPOXmsrVgB
 2TqI0+Pab5wV4PfNuKsu+u06FNj1V2P8fsleq/GlHrwT1f4BEzbGXGJKzlmQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smart Multimedia Interface (SMI) local arbiter does the arbitration for
memory requests from multi-media engines. Add SMI in the MT8365 DTS will
allow to add local ARBiter (LARB), use by IOMMU.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 0e4fa69a2415..70915beb513c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -324,16 +324,19 @@ power-domain@MT8365_POWER_DOMAIN_CAM {
 							      "cam-4", "cam-5";
 						#power-domain-cells = <0>;
 						mediatek,infracfg = <&infracfg>;
+						mediatek,smi = <&smi_common>;
 					};
 
 					power-domain@MT8365_POWER_DOMAIN_VDEC {
 						reg = <MT8365_POWER_DOMAIN_VDEC>;
 						#power-domain-cells = <0>;
+						mediatek,smi = <&smi_common>;
 					};
 
 					power-domain@MT8365_POWER_DOMAIN_VENC {
 						reg = <MT8365_POWER_DOMAIN_VENC>;
 						#power-domain-cells = <0>;
+						mediatek,smi = <&smi_common>;
 					};
 
 					power-domain@MT8365_POWER_DOMAIN_APU {
@@ -351,6 +354,7 @@ power-domain@MT8365_POWER_DOMAIN_APU {
 							      "apu-5";
 						#power-domain-cells = <0>;
 						mediatek,infracfg = <&infracfg>;
+						mediatek,smi = <&smi_common>;
 					};
 				};
 
@@ -709,6 +713,17 @@ mmsys: syscon@14000000 {
 			#clock-cells = <1>;
 		};
 
+		smi_common: smi@14002000 {
+			compatible = "mediatek,mt8365-smi-common";
+			reg = <0 0x14002000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MM_SMI_COMMON>,
+				 <&mmsys CLK_MM_MM_SMI_COMMON>,
+				 <&mmsys CLK_MM_MM_SMI_COMM0>,
+				 <&mmsys CLK_MM_MM_SMI_COMM1>;
+			clock-names = "apb", "smi", "gals0", "gals1";
+			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
+		};
+
 		camsys: syscon@15000000 {
 			compatible = "mediatek,mt8365-imgsys", "syscon";
 			reg = <0 0x15000000 0 0x1000>;

-- 
2.25.1

