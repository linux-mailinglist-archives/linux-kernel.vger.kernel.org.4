Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBCC63863F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiKYJ3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiKYJ2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:28:42 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B402253A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:28:39 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ho10so9042377ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDlDbAHR12BKCMIARhmBHpen1uRLAhjJaEci7K6+OM8=;
        b=Y0/gjH7Z7VH4bu0X+rO60RMSq8bgcJ07Whg6hgXdtirNhC/MCzivcqnRAC0LKbbRXJ
         MgtIMgwqYSfgg8yKHXpATNes6Il5oeHwQqW7qkGy3d3u2iRnId8iUEAXL2XJTUvwwSzc
         GKOnqeMGs1LdBz2Q5KRWeQ43gPPBsGt+jSsK4C06uhJrP1XSv/a+4lLIQX0aUOINb6CN
         6fzEa3vcI8V/S3i6MzblZmWZYhF0n7vpBSaeNl/xPHF7wubyFcVm56HlCP3SEoT2WGjJ
         jP4nJpDYjt4WmNtNE7pWMnudbDGqwNoIHfZ72d4m1XkK/i/VOW1++f8Wl+abqSv5KR45
         H6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDlDbAHR12BKCMIARhmBHpen1uRLAhjJaEci7K6+OM8=;
        b=uwip0uUG8b9PnxL9XN8B/DVUeS0FgphnxGPQttX0Yl++ERtNap+ySusA9oZ1/cS+6p
         qqHae4b15I4DUNnQllO00JKxjzw7G/O1khzweHCLWd1cnl9ShKGF0+gkRI7P+9MRydgo
         c4YekGutq1BPwvdU3rQV9a8ZO0ft/pCF1gc8YV1HIUMyse2SvzfWpsnwC3sHoIYyGSyb
         qd2RLA99omNkLHSEZvFGSxT8KcqCWcVKKKPcfp7RAyyicczGAziiTLQvo0vrfYtI1FJW
         0AEoVYWCQBieUG4bn/J9YY8AeapAKKe9xu0Kv00NmCAMTdn9fy11ltacPgSUQnE4IU/l
         XRPg==
X-Gm-Message-State: ANoB5pn9uoQo+igcbUqKr4wqtwNsiwi+SlRorTtf+2KeR2iSQ6vQKmXV
        2rJcu5beHhfVdFlUY8NTFpoPUw==
X-Google-Smtp-Source: AA0mqf7oHl9+H293gFxLoBWl9XlcaihpEzinILW3YWYFjePNchpZGOt0bqS/jPIxrLU7CLPDeIzxTA==
X-Received: by 2002:a17:906:1b48:b0:78d:a136:732b with SMTP id p8-20020a1709061b4800b0078da136732bmr15760264ejg.135.1669368518226;
        Fri, 25 Nov 2022 01:28:38 -0800 (PST)
Received: from otso.. (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id q10-20020a170906b28a00b007b47748d22fsm1329315ejz.220.2022.11.25.01.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 01:28:37 -0800 (PST)
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
Subject: [RFC PATCH v2 3/3] arm64: dts: qcom: sm6350: Use specific qmpphy compatible
Date:   Fri, 25 Nov 2022 10:27:49 +0100
Message-Id: <20221125092749.46073-3-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125092749.46073-1-luca.weiss@fairphone.com>
References: <20221125092749.46073-1-luca.weiss@fairphone.com>
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
@Johan Hovold, in this patch there's also the question about cfg_ahb,
power-domains but I'm also not happy about using the
QMP_USB43DP_USB3_PHY define for the phy reference. Do you think it's a
good idea to introduce e.g. QMP_USB3DP_USB3_PHY with the same value so
it's essentially just an alias to the other?

This series is tested on next-20221124 with next branch of linux-phy
repo (commit bea3ce759b46) merged in.

 arch/arm64/boot/dts/qcom/sm6350.dtsi | 46 +++++++---------------------
 1 file changed, 11 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 0f01ff4feb55..923c8bb7e5f8 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interconnect/qcom,sm6350.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
+#include <dt-bindings/phy/phy-qcom-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
@@ -1119,50 +1120,25 @@ usb_1_hsphy: phy@88e3000 {
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
 				 <&xo_board>,
 				 <&rpmhcc RPMH_QLINK_CLK>,
-				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
-			clock-names = "aux", "cfg_ahb", "ref", "com_aux";
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref", "com_aux", "usb3_pipe";
 
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
-				      <0 0x088eac00 0 0x400>,
-				      <0 0x088ea600 0 0x200>,
-				      <0 0x088ea800 0 0x200>,
-				      <0 0x088eaa00 0 0x100>;
-				#phy-cells = <0>;
-				#clock-cells = <1>;
-			};
+			status = "disabled";
 		};
 
 		dc_noc: interconnect@9160000 {
@@ -1236,7 +1212,7 @@ usb_1_dwc3: usb@a600000 {
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

