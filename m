Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B656BC8B0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCPIO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjCPINt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:13:49 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05322A908B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:13:05 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id a2so893084plm.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678954368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4buO9u/YEJ2XslOs7PK/sn8ZofMZxzKI+5s+2aMPGs=;
        b=RwRAaEMIlk/mrXg+pCIfOvQvhKsNC7GEuichkCxci4MLOrgvGz2p8B38RD3HZ8Ebt8
         fwVXird8dM36xR3LI2U2F1UyYlLNPOnn7THzvQAB0gMiYUxBF6seATahsY+puXX+xfQQ
         68MB1PnmEp4U2T+fXs0xCJgS/bLUjhLX8IoXE6Ds9uIvfe1AutAerfgjR+MRpdghd4cU
         xaQAWsnk/4ryl50rlCk2CpD8E9inFs9TCSChDSFONFmk3Je627oa3VPLTTGJtPhybMiA
         meW6/P6ImYp2vooyTOJckiyNijkq7n2KmHESV1e+wgQMCSr/cGWCICLsanR1SeJXhgvR
         WC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678954368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4buO9u/YEJ2XslOs7PK/sn8ZofMZxzKI+5s+2aMPGs=;
        b=b5V/G4NRiCBUcn7uXjVAW/2gyLZWGnf+/+DCSpmGsnw1BlTdIPi7/WYQx9IOXGvcxR
         mqgw+QKY7N4L4f3W7nAMY1bSGAwleCjG3TtB19bn4oWHKVqJN9Ptb4p/mYSyLjUKYQKk
         O7OLHATuzcWG/oOeM1yzSTalPmSFwmfEV6b2amkLd+6a6hr9PVjo5sswyGDPC6pqr873
         BEx6fSX+eSlNoB21Jx6UQPoNm6A81dF3N/xN+2h9MtuQOhVUEieTJILiY2iNZnQSnLCl
         JX4P2DQUK04AZbHGV3HSK+y9t0MkIJIC/eCGZYXHt81qxciUkojgPBrF7NAF1taSxx3k
         LL1w==
X-Gm-Message-State: AO0yUKWsNq32sL3RSFU8hHdWj4SgOh8rUrbpV7O2Nk4jm0x/wpvGI/nd
        RXxC5zyOy94/IlBqEOcoKU3D
X-Google-Smtp-Source: AK7set/s6R+SkVUkKC3BBcLCjyUa35HL9pMUs1Dur1QiC0F9w3VURXEXhY4WZ9K5XQF3cTtHMOCs+g==
X-Received: by 2002:a05:6a20:2a26:b0:cc:aedf:9a1e with SMTP id e38-20020a056a202a2600b000ccaedf9a1emr2237606pzh.61.1678954368448;
        Thu, 16 Mar 2023 01:12:48 -0700 (PDT)
Received: from localhost.localdomain ([117.207.30.24])
        by smtp.gmail.com with ESMTPSA id 13-20020aa7910d000000b005d9984a947bsm4804422pfh.139.2023.03.16.01.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 01:12:48 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 17/19] arm64: dts: qcom: sm8250: Add "mhi" region to the PCIe nodes
Date:   Thu, 16 Mar 2023 13:41:15 +0530
Message-Id: <20230316081117.14288-18-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
References: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
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

