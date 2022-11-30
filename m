Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C6763D036
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbiK3IPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbiK3IPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:15:11 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016AF51C23
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:15:10 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id f7so23007039edc.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fM26/BX7+YrKiOIeW+5b8oCcE7ugPPDIGDOxKigOBdQ=;
        b=LX+1ED3kWIxIqw76sso+qroMFs0A6QxNMQguadkwKZLk517JN6fLHqu3y7lGjzJ4bA
         UqaPfWpfnPMsBuMdilvJqN+yS/XhAr7Uzdu814NIxSbyLBUD8YHBACVPp/be+onceYde
         ta1yARryDQxUdwiFwP5zzP4QFZ4YzTsChfg53onGCozqwfPD5XZ6IaVFvQOuJ2+HsxPK
         6NnvNpnneSfllRSRlJhoThwqCA4F9sZIgziLXgW7Lx0ztB/je6pKZ5fGjK9EAJfrG3cd
         1MQyUfmQjasrHF71DylYM+5VpdYsdqTezloS6P3w9sQS18GgDB3mrHitOXks1/SfFUfn
         uK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fM26/BX7+YrKiOIeW+5b8oCcE7ugPPDIGDOxKigOBdQ=;
        b=hAGYJNiKsy3mGlxqGtGtqxVAP90lZvEjD2HKlMltoxsXpaPmN5cJe9OW0ZJHlLERdY
         Pudn4YrKhUCGPzj82ZronlnOjUcoxq3nvnXM4obwb5imcPgmNdKmaielWifFzQni1BTF
         aHXFRioM8hsNFju7a+cDADpMTdWGks4wtPVka78DPjRudv8mIX++EGCfs85WQPDBrOJ6
         MUzmmdfe7QyOwye0jzL8LGtmk9HA1o+3drVPTphNuJsXUJ4An4UCP8hQb76JuKwMoIUN
         3TR3P1FEf2G/5iaWY4v0u3Csi3W/2JCU+mQRhqzZw4QWb1ahVAkbcAGD1q6mgYeNg7Uc
         J4ig==
X-Gm-Message-State: ANoB5pnHSY0I3LZyeM1yKRqPsid1GZBmnV09x3XA2pCl0kArE/fy4rRS
        zOk60ftibh6Yqjtx+/JaMkt1Fw==
X-Google-Smtp-Source: AA0mqf5w3rhlhkRUpiuUNjUaAMTdzJVhpCXqWtNJKHHVhNIBxZGHsNyQoMRtZ6RBZOxDdApp7Su9Qg==
X-Received: by 2002:aa7:d555:0:b0:464:6485:419b with SMTP id u21-20020aa7d555000000b004646485419bmr41081784edr.382.1669796108510;
        Wed, 30 Nov 2022 00:15:08 -0800 (PST)
Received: from otso.. (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id jw11-20020a17090776ab00b0074134543f82sm358285ejc.90.2022.11.30.00.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:15:08 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org, Johan Hovold <johan@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: dts: qcom: sm6350: Use specific qmpphy compatible
Date:   Wed, 30 Nov 2022 09:14:29 +0100
Message-Id: <20221130081430.67831-3-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130081430.67831-1-luca.weiss@fairphone.com>
References: <20221130081430.67831-1-luca.weiss@fairphone.com>
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

The sc7180 phy compatible works fine for some cases, but it turns out
sm6350 does need proper phy configuration in the driver, so use the
newly added sm6350 compatible.

Because the sm6350 compatible is using the new binding, we need to
change the node quite a bit to match it.

This fixes qmpphy init when no USB cable is plugged in during bootloader
stage.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes since v2:
* Rebase on https://lore.kernel.org/all/20221111094729.11842-2-johan+linaro@kernel.org/
  While this commit deletes the changes there it's still good to get it
  in for completeness
* Fix clocks, add power-domain

 arch/arm64/boot/dts/qcom/sm6350.dtsi | 50 ++++++++--------------------
 1 file changed, 14 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 43324bf291c3..cb48f03a6cc9 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interconnect/qcom,sm6350.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
+#include <dt-bindings/phy/phy-qcom-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
@@ -1119,49 +1120,26 @@ usb_1_hsphy: phy@88e3000 {
 			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
 		};
 
-		usb_1_qmpphy: phy@88e9000 {
-			compatible = "qcom,sc7180-qmp-usb3-dp-phy";
-			reg = <0 0x088e9000 0 0x200>,
-			      <0 0x088e8000 0 0x40>,
-			      <0 0x088ea000 0 0x200>;
-			status = "disabled";
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+		usb_1_qmpphy: phy@88e8000 {
+			compatible = "qcom,sm6350-qmp-usb3-dp-phy";
+			reg = <0 0x088e8000 0 0x3000>;
 
 			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
-				 <&xo_board>,
-				 <&rpmhcc RPMH_QLINK_CLK>,
-				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
-			clock-names = "aux", "cfg_ahb", "ref", "com_aux";
+				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+			clock-names = "aux", "ref", "com_aux", "usb3_pipe";
+
+			power-domains = <&gcc USB30_PRIM_GDSC>;
 
 			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
 				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
 			reset-names = "phy", "common";
 
-			usb_1_ssphy: usb3-phy@88e9200 {
-				reg = <0 0x088e9200 0 0x200>,
-				      <0 0x088e9400 0 0x200>,
-				      <0 0x088e9c00 0 0x400>,
-				      <0 0x088e9600 0 0x200>,
-				      <0 0x088e9800 0 0x200>,
-				      <0 0x088e9a00 0 0x100>;
-				#clock-cells = <0>;
-				#phy-cells = <0>;
-				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
-				clock-names = "pipe0";
-				clock-output-names = "usb3_phy_pipe_clk_src";
-			};
+			#clock-cells = <1>;
+			#phy-cells = <1>;
 
-			dp_phy: dp-phy@88ea200 {
-				reg = <0 0x088ea200 0 0x200>,
-				      <0 0x088ea400 0 0x200>,
-				      <0 0x088eaa00 0 0x200>,
-				      <0 0x088ea600 0 0x200>,
-				      <0 0x088ea800 0 0x200>;
-				#phy-cells = <0>;
-				#clock-cells = <1>;
-			};
+			status = "disabled";
 		};
 
 		dc_noc: interconnect@9160000 {
@@ -1235,7 +1213,7 @@ usb_1_dwc3: usb@a600000 {
 				snps,dis_enblslpm_quirk;
 				snps,has-lpm-erratum;
 				snps,hird-threshold = /bits/ 8 <0x10>;
-				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
+				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
 			};
 		};
-- 
2.38.1

