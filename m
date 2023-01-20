Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1EA675580
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjATNSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjATNSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:18:35 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECD0C41E6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:14:54 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id kt14so13893080ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ySBpf/g54h4mieeOX1iTHn4nbDJmcd4e2yinCvFCp5c=;
        b=LQoXIY51ocKZoiJFhh/AKSvIacV/F1db3r+IWRBBO5CRnSUd4/y6t+JPN0hZcOZC4j
         5g67O4XNBTR/+4FcVFML8g5LzcxfzWKtB9YbLXV3o/Db+9DuJBVvgDmf6VRweZz9QhDU
         bV1mIusIhlsezQ+F7aqLrpXr/4I4jyYEmNI8gosKdTeftWaoFn1xi/3E81QKglReGzWm
         TGMHSuUcV+YZiR5D5WDxbZsbn3viFZ1oQNXG1fdq0+VPKfTaNemr1mbtrXs9xNrEEgw4
         7JVC9CibLH/pdTT/Po5D4c3F3Oiyy4xXwS3aNWAxEZNeXLTRFj386RA7xlUos4xg0BOx
         gGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySBpf/g54h4mieeOX1iTHn4nbDJmcd4e2yinCvFCp5c=;
        b=BZPX3ttCMF9FbAb0OmFpaP+0wQGKD9se+qx9//txfyUTN7NInbiiikf10dPKbPCl/K
         zJq78TB7JzVcTLbAsm7lxG289qV2WhW3NWVONMAn00RUsLg6hTmvRJnCe5UV3WHd1XaN
         flITL1UAad5SxxAn5yG1h1l97JXpOsoK7+xj6ikP9UdwrSLjOloKthGiwjR41ji+UAAY
         wr1XhPGhOFOzQv5RrGENh7L7AfXXjbqi1ziqBz+J9kDRqKwh26efga1BS/WQ4HOt91Yb
         3t04wh0WHEmQoITguwC82Ubb4i8rdhtw41QHZ+rxail7C6zYuNHITpSXfXk1ISSuETYd
         0WBg==
X-Gm-Message-State: AFqh2kqXyo9fX3301HRitqgMTTDJorC/JpoHQQQhlcNQ7Dg1V282gj5A
        SleVhgU8CNSRh8wfAwqXArTvLg==
X-Google-Smtp-Source: AMrXdXvwTGSr0VTfDAVxv+4egpg34iuffH5U0RjzGKJRCWUe2ybZYxw/9OuLWcE4dBOerhoopk/deA==
X-Received: by 2002:a17:906:c7cc:b0:7ae:bfec:74c7 with SMTP id dc12-20020a170906c7cc00b007aebfec74c7mr14237590ejb.72.1674220492599;
        Fri, 20 Jan 2023 05:14:52 -0800 (PST)
Received: from [172.16.220.87] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id t1-20020a1709061be100b0086f40238403sm8063276ejg.223.2023.01.20.05.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 05:14:52 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 20 Jan 2023 14:13:45 +0100
Subject: [PATCH v2 2/4] arm64: dts: qcom: sm6350: Add camera clock
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221213-sm6350-cci-v2-2-15c2c14c34bb@fairphone.com>
References: <20221213-sm6350-cci-v2-0-15c2c14c34bb@fairphone.com>
In-Reply-To: <20221213-sm6350-cci-v2-0-15c2c14c34bb@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12-dev-78462
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the camcc found on SM6350 SoC.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 8224adb99948..300ced5cda57 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1435,6 +1435,15 @@ usb_1_dwc3: usb@a600000 {
 			};
 		};
 
+		camcc: clock-controller@ad00000 {
+			compatible = "qcom,sm6350-camcc";
+			reg = <0 0x0ad00000 0 0x16000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sm6350-pdc", "qcom,pdc";
 			reg = <0 0x0b220000 0 0x30000>, <0 0x17c000f0 0 0x64>;

-- 
2.39.1

