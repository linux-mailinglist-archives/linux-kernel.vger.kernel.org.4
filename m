Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276CA7477D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjGDRd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjGDRdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:33:25 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B58D10E3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 10:33:23 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51d91e9b533so6511574a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 10:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1688492001; x=1691084001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=voSV3r6liSTPswELgXfBz+FbRIZzGdFTovggUY0LZ1c=;
        b=niI9qf70lz6ehiJfC5AEObc/h1RpkL9AWeQrbq4VstdIAjIdYtxtiE+305qWdgfmIr
         EGqP51lbJpROOFM446kUlZhkHSvo1czE7oDyobhSC/pEjwlgh9p1Nts6bHvMLwfiR/ll
         sZovZO3WkNucyZMbpVsNCxUQ6X+Tq8qiYXtFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688492001; x=1691084001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=voSV3r6liSTPswELgXfBz+FbRIZzGdFTovggUY0LZ1c=;
        b=MoIR/7gW9GDsiwFMpiPSi6UUaek52zQUlxhTLVXcMpR92REFGDpDF6SqdqsjdRaee6
         MCjSDlLfYOSVmSGBSJemu4qS++9k3RztF5gpKN9DGbJyNYj5mAz4bJJDLYUl7YLSMgFq
         hWAZy5OFhM8E4PZWsH9a/DT2Ykc6idCY9LWEVTAofujt7hWsX9OE83BB3kieLp9pAJIz
         J/HqY7jUt4x42sHPuj/yzIybqczZL3k7qVojEmgFCqIa58CXHWqKXHlG3YIOyfJAj7Sy
         rCegR3v2+xnMbMpJG79HgPDM41vE4n5Ao2Bx0Ya0V1cML6YQlEj5Mzm7mh1XBNd50eFz
         kC+A==
X-Gm-Message-State: ABy/qLZu+fbc0pm56ZHqWCJM7FvqX4m8kMhSl7Kipbwt3QKUoWB6Ly0y
        Rc+5Z1RY6ZrI+FLlCxTTOm1aeXR9Xwi+mOFxqDI=
X-Google-Smtp-Source: APBJJlHsQfO4bzGm+NE7pP3Z/pJZH72loPlBskyiVeaBbdPwNWxr2fgtRrjBVIkAOtimINeZlnEhDA==
X-Received: by 2002:aa7:df85:0:b0:51e:1692:1111 with SMTP id b5-20020aa7df85000000b0051e16921111mr3710970edy.3.1688492001252;
        Tue, 04 Jul 2023 10:33:21 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-58-49-236.retail.telecomitalia.it. [82.58.49.236])
        by smtp.gmail.com with ESMTPSA id p18-20020aa7d312000000b0051a2d2f82fdsm12241239edq.6.2023.07.04.10.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 10:33:20 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: dts: stm32: re-add CAN support on stm32f746
Date:   Tue,  4 Jul 2023 19:33:17 +0200
Message-Id: <20230704173317.590190-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The revert commit 36a6418bb1259 ("Revert "ARM: dts: stm32: add CAN support
on stm32f746"") prevented parsing errors due to the lack of CAN3 binding.

Now that the binding definition for CAN3 is available in the mainline
thanks to commit 8f3ef556f8e1a ("dt-bindings: mfd: stm32f7: Add binding
definition for CAN3"), we can re-add the CAN support and make the driver
usable again.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/boot/dts/st/stm32f746.dtsi | 47 +++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32f746.dtsi b/arch/arm/boot/dts/st/stm32f746.dtsi
index d1802efd067c..bfff1a58bf3d 100644
--- a/arch/arm/boot/dts/st/stm32f746.dtsi
+++ b/arch/arm/boot/dts/st/stm32f746.dtsi
@@ -257,6 +257,23 @@ rtc: rtc@40002800 {
 			status = "disabled";
 		};
 
+		can3: can@40003400 {
+			compatible = "st,stm32f4-bxcan";
+			reg = <0x40003400 0x200>;
+			interrupts = <104>, <105>, <106>, <107>;
+			interrupt-names = "tx", "rx0", "rx1", "sce";
+			resets = <&rcc STM32F7_APB1_RESET(CAN3)>;
+			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN3)>;
+			st,gcan = <&gcan3>;
+			status = "disabled";
+		};
+
+		gcan3: gcan@40003600 {
+			compatible = "st,stm32f4-gcan", "syscon";
+			reg = <0x40003600 0x200>;
+			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN3)>;
+		};
+
 		usart2: serial@40004400 {
 			compatible = "st,stm32f7-uart";
 			reg = <0x40004400 0x400>;
@@ -337,6 +354,36 @@ i2c4: i2c@40006000 {
 			status = "disabled";
 		};
 
+		can1: can@40006400 {
+			compatible = "st,stm32f4-bxcan";
+			reg = <0x40006400 0x200>;
+			interrupts = <19>, <20>, <21>, <22>;
+			interrupt-names = "tx", "rx0", "rx1", "sce";
+			resets = <&rcc STM32F7_APB1_RESET(CAN1)>;
+			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN1)>;
+			st,can-primary;
+			st,gcan = <&gcan1>;
+			status = "disabled";
+		};
+
+		gcan1: gcan@40006600 {
+			compatible = "st,stm32f4-gcan", "syscon";
+			reg = <0x40006600 0x200>;
+			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN1)>;
+		};
+
+		can2: can@40006800 {
+			compatible = "st,stm32f4-bxcan";
+			reg = <0x40006800 0x200>;
+			iterrupts = <63>, <64>, <65>, <66>;
+			interrupt-names = "tx", "rx0", "rx1", "sce";
+			resets = <&rcc STM32F7_APB1_RESET(CAN2)>;
+			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN2)>;
+			st,can-secondary;
+			st,gcan = <&gcan1>;
+			status = "disabled";
+		};
+
 		cec: cec@40006c00 {
 			compatible = "st,stm32-cec";
 			reg = <0x40006C00 0x400>;
-- 
2.32.0

