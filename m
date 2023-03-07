Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D967B6AE4C4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjCGPcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjCGPcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:32:13 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5EC4FF06
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 07:32:08 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so1529341pjn.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 07:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678203128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=99KcN0KUzxUMOifeobUywCVUN2cCL7LQNwuX/8gz59Q=;
        b=RuRCRqRkSJ46eOsUdOViqsVJku4VaLtx75eL33+hukIU6nffPYmW8HTfQ3Uyq0S+fB
         tQpgbHKRUOBDc14AhvxeruizL//11F5CcP3PeU4AhSlqVWEXDl1gFYPnSXuAroyTGI6v
         6Cat1tHcRul0ClCFj64PPgs4HZpKmXvNz9sLRCnTwzKP0UoVLm/nVobmkaycnilYOTi1
         AweoDWEM6MuRvYRXgR7j4XHVFayLlTxz6XeRZl3i6iu3Ao+6KBBWj2gihcsPvoZzXZFU
         +1BhPsPlT3zpnVrpaDwxmU3/hbuFMmcK37uNymWCqRgleypjSxkHiipVMnCXCPJckng3
         tePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678203128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99KcN0KUzxUMOifeobUywCVUN2cCL7LQNwuX/8gz59Q=;
        b=EL80pLJFEyclEgtJvqBEbpyq+in0QPN9+idTrr+xf+Dr1EtIp+mjXMl7cjPh+rDjq8
         QWZx33QzzL9OyYt533/SzyIqzV/71Qf0WJnZjjVekk32sVT5kBk6eBsZfE0HVXCY+TW2
         Iq0RLIt3P+FPzsTssAPV7JkqPgZ4jbL+kkVDij1kXCcB+DW1Thu/Pg1sWpd3k5FcdzDH
         W5Q1i8kYLmvdKk/cnb74f75KgX8NL8K/0jVyc906cvaPn4InuREiLDGyCjE5l2Rn+/nJ
         dZlWFm60Xogap8JEsNib/M/YsS5lMFlXyBazCTjFmAbRtw/JRPSu0tFZVTzOIEOWnbBY
         fVMg==
X-Gm-Message-State: AO0yUKV587vMX8C4lIZ5r3C33S/IH0VGaSK2CIo17xQy5SV1lGrh7JI4
        +wbFBqmpj3zeXgUJTEcowBFP
X-Google-Smtp-Source: AK7set8mwO7YodY1cgNPBX2a08RLyOa/1GpC9j29FcBop7qYPg1YswB3SfdzYgYE884ytRDiP3YkEw==
X-Received: by 2002:a17:903:1d1:b0:19e:6947:3b27 with SMTP id e17-20020a17090301d100b0019e69473b27mr19965986plh.58.1678203127913;
        Tue, 07 Mar 2023 07:32:07 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id f18-20020a170902ce9200b0019c93ee6902sm8541436plg.109.2023.03.07.07.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 07:32:07 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] arm64: dts: qcom: sm8350: Mark UFS controller as cache coherent
Date:   Tue,  7 Mar 2023 21:02:00 +0530
Message-Id: <20230307153201.180626-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UFS controller on SM8350 supports cache coherency, hence add the
"dma-coherent" property to mark it as such.

Fixes: 59c7cf814783 ("arm64: dts: qcom: sm8350: Add UFS nodes")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 1c97e28da6ad..1a5a612d4234 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1664,6 +1664,7 @@ ufs_mem_hc: ufshc@1d84000 {
 			power-domains = <&gcc UFS_PHY_GDSC>;
 
 			iommus = <&apps_smmu 0xe0 0x0>;
+			dma-coherent;
 
 			clock-names =
 				"core_clk",
-- 
2.25.1

