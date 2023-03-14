Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591DC6B8CD0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjCNILa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjCNIK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:10:59 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003EA99254
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:09:29 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id j11so58458458edq.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678781364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ueNaJ0XTotz6J2p6MR7byzx7hLWRSeF4YWSXmbAw8M=;
        b=Ydg45VO4USdBVbP+UqICzebHjPr9OYOcWR0yDnSt8a0J6OvFWw9xif8PqZLC0pwaov
         a3cxVhVBQmmsin17gcDbHvVThflOz5u3dl5itxhJvVDbbIch6PWZlnnwvYfY1Ct4unMd
         JTwYXYRnQc9yclIjfSHkWVyXjcMLk/qiQYpc9XV8vNesx9sgA02kp9w+Fur4gxyq4xtT
         BU1yUbdu/tqF7H9S47cmI2pInPg73nWUp4BmJh7ANHW+QMhXKX8SLA465p5NHg6Y/iGL
         kQhdIJih6a01v+rNFD0aij9QhH744mAKYeZfs25XfRhHSmbA/Gn7NUHdDqndwxF6etvr
         t3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678781364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ueNaJ0XTotz6J2p6MR7byzx7hLWRSeF4YWSXmbAw8M=;
        b=rvHd0EDs0LlEB2fflBCP+oWbhf6sFSC9gMQCwNE+Th/erD3CJ41fWioB3rJn+FvOgC
         2TPdC6iAHNVJdWT7oqT6RzmHiLhUqIjTKQLrKcFKp1hHEZBcLOdeMKAtx1cRfTBScRWn
         Xev1O2qiWQ9cXLMNdSXlUXngWgdk68hJNqnVBGUc5/mhwpOyq+goUtEVi2Z37g4YDA9z
         dvhwMLaahHK+KNyOahd2zkVu2S9gUIBEfU6q3k+kQi3U8oRFGq+89Zjm2SBIyaX7fcPm
         uYlMdsoscRzWPgmdLtjyWz/2GyxJAHyXRr7Rf1YFHLGcT7qnyOIrLkcsImk8cqAWTACL
         0efQ==
X-Gm-Message-State: AO0yUKXk1+SHy2dt1ZomO3fnyAdxDdfRmlyvW44SxXYwSRB9uGZFULiL
        DMaJSvi57XF5TKyigbhyp8aItg==
X-Google-Smtp-Source: AK7set83ncjzK4FqCufKrmZh8kygXiLTO/NzzCK1eucXjGn2OKBIaHsVmOTLOqTLTbjUwFI4o3Y9sQ==
X-Received: by 2002:aa7:cd7a:0:b0:4fc:e605:556a with SMTP id ca26-20020aa7cd7a000000b004fce605556amr4656610edb.5.1678781364298;
        Tue, 14 Mar 2023 01:09:24 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6932:5570:6254:9edd])
        by smtp.gmail.com with ESMTPSA id co2-20020a0564020c0200b004fce9ff4830sm584872edb.88.2023.03.14.01.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 01:09:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 05/13] arm64: dts: qcom: ipq8074: add compatible fallback to mailbox
Date:   Tue, 14 Mar 2023 09:09:09 +0100
Message-Id: <20230314080917.68246-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230314080917.68246-1-krzysztof.kozlowski@linaro.org>
References: <20230314080917.68246-1-krzysztof.kozlowski@linaro.org>
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

IPQ8074 mailbox is compatible with IPQ6018.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 62d05d740646..3fa7a63db74e 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -687,7 +687,8 @@ watchdog: watchdog@b017000 {
 		};
 
 		apcs_glb: mailbox@b111000 {
-			compatible = "qcom,ipq8074-apcs-apps-global";
+			compatible = "qcom,ipq8074-apcs-apps-global",
+				     "qcom,ipq6018-apcs-apps-global";
 			reg = <0x0b111000 0x1000>;
 			clocks = <&a53pll>, <&xo>;
 			clock-names = "pll", "xo";
-- 
2.34.1

