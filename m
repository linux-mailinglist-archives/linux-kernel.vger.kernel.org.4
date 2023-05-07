Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F456F9AB3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 19:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjEGRp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 13:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjEGRpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 13:45:23 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E551156D
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 10:45:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-965fc25f009so375759266b.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 10:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683481520; x=1686073520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcswfvm3sxKnzlLAM1J7B57hE1e8oo2kqkYprKrpw0c=;
        b=ez8yQkdu/3XgM2cpNvixD3XTfVtmBlaxcwuarYYIPx2HSsfqMflUFt79JfuK9mpyiG
         JkV2M0m/1iuaSELOzWjAekLccY+oZhwhM5C9qSC4ktcWHew+APBexRwHQuMyJLbHxk55
         Iqp8HqFVQYwBXRF8ywg8CLL0zo0PmjViqd6bIezcF6J1rKDo6sydlZSBdXZqtHYG/yqb
         as7hiotNzLTOBQG83JqfbLYih2EZCogpCx3UkQt91wjuXgBexyg42SYCPzyL6nWkF8Hd
         xll09EaoDVFSp1q64ZvBnLNd0yE2S9j59OoygL7SdlgBoUe5Jzkz7SrWc3ZBKDDAvbXc
         w+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683481520; x=1686073520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcswfvm3sxKnzlLAM1J7B57hE1e8oo2kqkYprKrpw0c=;
        b=UwWt2qA+lSkcSBIN/9u5R8p5To6OmodgwU5L1zXqMYD9CoZLs7RvIipd19d/WE45LJ
         63BB0mG5blCsIO0KhoQLgz2zqHiQcVbQRPh6jNEBikTORa+Bs/MaScdW/TdLma0bGHWx
         o83hsvp0BebM2bpNnxqxG10qs2Yvrjflh1nrUNdU5ZlaS9wT60yqJhpC95IoAgIGAEid
         ZkXJ5dEP7xaZCbzyXNe4dkO0haTcUylLash1pUORILjNO5DWx7zja79aYl66YKps3zAJ
         RsxEA8FY+7Jsx+vu0F5S6ODD4j0aNXpCpuoCNSCGUhh/DIZHKLGqD6MtmWxJIDkwDgVb
         UDTA==
X-Gm-Message-State: AC+VfDz/l3QKWKkPWDzx0eG8ehw/+Xh7TzEcUUiixDo+QgOmcQ8zDSZy
        /yWq7qJ0WwRErElvyXQI0uOV/Q==
X-Google-Smtp-Source: ACHHUZ5m+I/1St22GhgOl7dpS+HlR1lnuwDFsRuWEcbs6oooS+TV9XoXEWQRTtRBrj651YXNKgB8ig==
X-Received: by 2002:a17:907:2d2a:b0:965:b087:8002 with SMTP id gs42-20020a1709072d2a00b00965b0878002mr6637626ejc.0.1683481520117;
        Sun, 07 May 2023 10:45:20 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:1757:b51a:9965:e81])
        by smtp.gmail.com with ESMTPSA id jl3-20020a17090775c300b009655eb8be26sm3950864ejc.73.2023.05.07.10.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 10:45:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] arm64: dts: qcom: msm8996: correct MMCC clocks order
Date:   Sun,  7 May 2023 19:45:15 +0200
Message-Id: <20230507174516.264936-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230507174516.264936-1-krzysztof.kozlowski@linaro.org>
References: <20230507174516.264936-1-krzysztof.kozlowski@linaro.org>
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

Re-order the clocks for MMCC clock controller node to match the bindings (Linux
driver takes by name):

  msm8996-mtp.dtb: clock-controller@8c0000: clock-names:1: 'gpll0' was expected
  msm8996-mtp.dtb: clock-controller@8c0000: clock-names:2: 'gcc_mmss_noc_cfg_ahb_clk' was expected

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index fe9e1cb12a73..718007cfb10e 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -939,16 +939,16 @@ mmcc: clock-controller@8c0000 {
 			#power-domain-cells = <1>;
 			reg = <0x008c0000 0x40000>;
 			clocks = <&xo_board>,
-				 <&gcc GCC_MMSS_NOC_CFG_AHB_CLK>,
 				 <&gcc GPLL0>,
+				 <&gcc GCC_MMSS_NOC_CFG_AHB_CLK>,
 				 <&dsi0_phy 1>,
 				 <&dsi0_phy 0>,
 				 <&dsi1_phy 1>,
 				 <&dsi1_phy 0>,
 				 <&hdmi_phy>;
 			clock-names = "xo",
-				      "gcc_mmss_noc_cfg_ahb_clk",
 				      "gpll0",
+				      "gcc_mmss_noc_cfg_ahb_clk",
 				      "dsi0pll",
 				      "dsi0pllbyte",
 				      "dsi1pll",
-- 
2.34.1

