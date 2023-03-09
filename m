Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832B66B1EEC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjCIIxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjCIIwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:52:40 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BE3DCA45
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:52:22 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u5so1251972plq.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 00:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678351934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4buO9u/YEJ2XslOs7PK/sn8ZofMZxzKI+5s+2aMPGs=;
        b=Rrn/R99V8jCiHue6c0i2TBTzDE2tjgHHI/RAQxkDVXYcCXzNLkQAZiw2M2g1AbRoqp
         4hgCz2JhbbVY7+YweDVSEhBwfHueWmQlKBWOAG+UPNINkKH1yC5T+wfFbSSkhPB9hfZv
         jUb/sbdfSqjgYuCLln/SZZUH8UXQjSdGFregmhoBNEe74XwRrADAMWgVyLxwWoJSIV3w
         19NdjkRDzPl4V2oejK8u4cVlTdGXCUbrl5WE8LoiIM+q/9HoHwLbZKwkr13pCLyV6Gv2
         B03NoOqIgDey4hPQreZGT5B4FsgLtd4MOZqDALPPVlTRyQP4258jYTxOkXlvuOP2AHah
         kIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4buO9u/YEJ2XslOs7PK/sn8ZofMZxzKI+5s+2aMPGs=;
        b=6qiqf6mGCJm2voxeL7h6OTafKQt6AYl4b84ADldKZ1oUK/GG6USrF+rE5GC48zM3iH
         0VByqBW/3C0jL+Z5V14yvQiZpVlQtktu1z0vQ+VKblpQ3sbHmV2aybZZBep0TxIxyqrk
         4VudpSvatSUHX2PqLCWJ30gPDkVT1tW3fDEYMM5Y0aJ5EMK04iKpDqs35VdzECWh3seP
         eZplbCd9xpKyvLa2RnkYAIEAdQTOcvjt1Br02h8f5v777LRtjGcWsEJhDI623LDKdBdD
         QDcxsVjyK2yMp0ik4eUkD/tsSvL3OKDQ0vUwhp1mIOamFysmAe+A/3j5SOkUHCDqrZ/G
         2u1g==
X-Gm-Message-State: AO0yUKX+7uZXCqTZAVfGs9yjFwsSHYABsxdY76Uy3UQ8uoaee0GBqyu5
        ODIfwTHezoiVM34ZmXjGMdqM
X-Google-Smtp-Source: AK7set8Vri41GKOzVMVo3zr3DuYMaU4Cp5ip7V+6tr7kh7hn7rMwqwFmbaxu8FLKyYUvjQZz/yfKdw==
X-Received: by 2002:a05:6a20:8f09:b0:cb:cfb1:5009 with SMTP id b9-20020a056a208f0900b000cbcfb15009mr26838793pzk.34.1678351934715;
        Thu, 09 Mar 2023 00:52:14 -0800 (PST)
Received: from localhost.localdomain ([220.158.158.11])
        by smtp.gmail.com with ESMTPSA id u4-20020aa78484000000b005809d382016sm10638604pfn.74.2023.03.09.00.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:52:14 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 15/17] arm64: dts: qcom: sm8250: Add "mhi" region to the PCIe nodes
Date:   Thu,  9 Mar 2023 14:21:00 +0530
Message-Id: <20230309085102.120977-16-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
References: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
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

The "mhi" region contains the debug registers that could be used to monitor
the PCIe link transitions.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 2f0e460acccd..81383e20d3d9 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1824,8 +1824,9 @@ pcie0: pci@1c00000 {
 			      <0 0x60000000 0 0xf1d>,
 			      <0 0x60000f20 0 0xa8>,
 			      <0 0x60001000 0 0x1000>,
-			      <0 0x60100000 0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			      <0 0x60100000 0 0x100000>,
+			      <0 0x01c03000 0 0x1000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
 			device_type = "pci";
 			linux,pci-domain = <0>;
 			bus-range = <0x00 0xff>;
@@ -1933,8 +1934,9 @@ pcie1: pci@1c08000 {
 			      <0 0x40000000 0 0xf1d>,
 			      <0 0x40000f20 0 0xa8>,
 			      <0 0x40001000 0 0x1000>,
-			      <0 0x40100000 0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			      <0 0x40100000 0 0x100000>,
+			      <0 0x01c0b000 0 0x1000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
 			device_type = "pci";
 			linux,pci-domain = <1>;
 			bus-range = <0x00 0xff>;
@@ -2041,8 +2043,9 @@ pcie2: pci@1c10000 {
 			      <0 0x64000000 0 0xf1d>,
 			      <0 0x64000f20 0 0xa8>,
 			      <0 0x64001000 0 0x1000>,
-			      <0 0x64100000 0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			      <0 0x64100000 0 0x100000>,
+			      <0 0x01c13000 0 0x1000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
 			device_type = "pci";
 			linux,pci-domain = <2>;
 			bus-range = <0x00 0xff>;
-- 
2.25.1

