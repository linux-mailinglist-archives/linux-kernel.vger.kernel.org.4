Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561606F4050
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 11:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbjEBJkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 05:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjEBJkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 05:40:16 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D9F4EFF
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 02:40:14 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-52867360efcso2358062a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 02:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683020414; x=1685612414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UNC+LX2BmXQMWBXgbv+OqEeJQ6Zi4DiU1OHCYwdBxk=;
        b=vkj+2Aa+VROJOBGgZVu0noLrlC2Fr++Ng76P03GC4WH5szz/UE8CqUPdGKM8WK5KLE
         89SrExXi9o6RHQlRKii5Tht6RoeeLjA2KB4OCxFjj0hHSKRPXSgpJd2KoEAHQPastJFk
         CDehPU69rtgrOqdHWhUPO2IXu51JnMV+WXP6FbtN/UId6KeshKHBeM2ZBcjF5heKRMa9
         MR9NjL2tbfju4yvveb+JErmrq4XxZIJmn+1M2FwUgdKq8xvwRBLui3SQ1UDCPKkugah8
         hMkNN2aXiqdG0O3OmZYXFy7Sqbh4T7/6apV2EXpMCmNaA90jGdDpfYy0VZsYeIRfs7ZA
         vy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683020414; x=1685612414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UNC+LX2BmXQMWBXgbv+OqEeJQ6Zi4DiU1OHCYwdBxk=;
        b=F88Bta3fAVDsMQ7y6Rkgp1MrbyI2CjwoO+m1BzGAsuR80QOVO0QVpEaNv4xv7OglAj
         gqeX07kQ+sBnfKR/V22xheg1LNDUp9gqe3/DZDJEwSu4TOjjdPKcTa5AWMOczfO95oRg
         XIIP8rM2KQmuwddjpLaOjdLwqxLXChWRG/5QxfkdU5vtJGgshYKZ1E40RQv5FSoGzZ8x
         d5YeNgZfst6q6S12rur6pFKk5riZnTiIG2c3wbzQO9RNpzPYaGoeTByM9zK+jgBaR1k7
         pxIfoZjUPGS3vifx5HV5/owBEZdAL1m/n4ikC+RxdnAEp4GXeuh0ymyKsIZ382w3ZXkQ
         fFAQ==
X-Gm-Message-State: AC+VfDyGCUKTh1ykV4OGSPokF5yBsMA3lQS1Qk/wofLvJpVTIZCttKaz
        1fMln+VPZzjqXhTEHmR4zG1Qkw==
X-Google-Smtp-Source: ACHHUZ7VsFhBrU1B+6uS9XmXRuueMqYbmW6E4KE6Am22hhLQJXtYiUyy0uK6kgVfRcSNHH1mGjXNNw==
X-Received: by 2002:a05:6a20:8f08:b0:ef:5f:3c15 with SMTP id b8-20020a056a208f0800b000ef005f3c15mr21494619pzk.47.1683020413833;
        Tue, 02 May 2023 02:40:13 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3b:58fa:39f6:37e1:bb9a:a094])
        by smtp.gmail.com with ESMTPSA id r78-20020a632b51000000b00520f316ebe3sm18201585pgr.62.2023.05.02.02.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 02:40:13 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v2 1/2] arm64: dts: qcom: sc7280: Fix EUD dt node syntax
Date:   Tue,  2 May 2023 15:09:58 +0530
Message-Id: <20230502093959.1258889-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230502093959.1258889-1-bhupesh.sharma@linaro.org>
References: <20230502093959.1258889-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As noted by Konrad while reviewing [1], fix the EUD and DWC3
node syntax in sc7280 dtsi file.

While at it also fix the errors reported by '$ make dtbs_check'
for the EUD node:

 arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb: eud@88e0000: ports:
    'oneOf' conditional failed, one must be fixed:
	'port' is a required property
	'#address-cells' is a required property
	'#size-cells' is a required property
  From schema: Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml

[1]. https://lore.kernel.org/linux-arm-msm/20221231131945.3286639-1-bhupesh.sharma@linaro.org

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 36 ++++++++++++++--------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 31728f461422..e441b1d6cad3 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -640,6 +640,18 @@ cpu7_opp_3014mhz: opp-3014400000 {
 		};
 	};
 
+	eud_typec: connector {
+		compatible = "usb-c-connector";
+
+		ports {
+			port@0 {
+				con_eud: endpoint {
+					remote-endpoint = <&eud_con>;
+				};
+			};
+		};
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		/* We expect the bootloader to fill in the size */
@@ -3421,6 +3433,7 @@ usb_2_dwc3: usb@8c00000 {
 				phy-names = "usb2-phy";
 				maximum-speed = "high-speed";
 				usb-role-switch;
+
 				port {
 					usb2_role_switch: endpoint {
 						remote-endpoint = <&eud_ep>;
@@ -3596,10 +3609,11 @@ system-cache-controller@9200000 {
 		};
 
 		eud: eud@88e0000 {
-			compatible = "qcom,sc7280-eud","qcom,eud";
-			reg = <0 0x088e0000 0 0x2000>,
-			      <0 0x088e2000 0 0x1000>;
+			compatible = "qcom,sc7280-eud", "qcom,eud";
+			reg = <0 0x88e0000 0 0x2000>,
+			      <0 0x88e2000 0 0x1000>;
 			interrupts-extended = <&pdc 11 IRQ_TYPE_LEVEL_HIGH>;
+
 			ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -3610,6 +3624,7 @@ eud_ep: endpoint {
 						remote-endpoint = <&usb2_role_switch>;
 					};
 				};
+
 				port@1 {
 					reg = <1>;
 					eud_con: endpoint {
@@ -3619,21 +3634,6 @@ eud_con: endpoint {
 			};
 		};
 
-		eud_typec: connector {
-			compatible = "usb-c-connector";
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
-					con_eud: endpoint {
-						remote-endpoint = <&eud_con>;
-					};
-				};
-			};
-		};
-
 		nsp_noc: interconnect@a0c0000 {
 			reg = <0 0x0a0c0000 0 0x10000>;
 			compatible = "qcom,sc7280-nsp-noc";
-- 
2.38.1

