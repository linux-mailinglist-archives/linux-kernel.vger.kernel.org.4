Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8AC6BC8AC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjCPIOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCPINj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:13:39 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7A538EB7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:13:03 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id i5so898877pla.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678954364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azG6rPTW4OW7MpxRM4BYmIziHm2wpGO0S0WPmax4BIQ=;
        b=LXCy3/68yfGlI4UKZS89Aih1UutWoa9bN94wKp+vONYqH4ynGGOUgKjbnhXBt/okiF
         RtyRJxHDBkVd73Sbh8/4zxp+8ePflXlz1PXJbkoh5edqKFyegdiMYx1Xymr9ZojQaqbq
         3ZGUXMWqnomgup9gAvRbi8JhsYAHGryoGYISDsfmKsNG1immAVaHhdIUdaS7ilk32QLq
         AvAE6VMNjTm00k69is76gSBUKlgSXNQqi7/DN9QgE5HXdasm7M9PQS5kg4JpnoxgXZo5
         5Tdxa0e4d2Fv2cW7nUB+xWHQVPiE2696QCxnzBiLwKqeAbawaD92PyBUojRaOPy9QFTr
         Cgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678954364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azG6rPTW4OW7MpxRM4BYmIziHm2wpGO0S0WPmax4BIQ=;
        b=dfrGZOSpL2OIguCz84uyTKZ+oq4JuxVQmoNe2+EfEgpsu30OspanvW47CkbdN8Kew/
         2ApxGU35y6cV95zPrxLahckCgtGYIYwRCI0meX+WeO8dBjpJ9HxUhGTa0zo8z43fbmgV
         Rgo0dJN5KDHkL5JHP5pBEQYuDsEtrSf5lMn/jJ1Gv+lDjLpxBI+HuxGMDg54OpL8Ri4r
         SsAwWtY0dGcUr+NKGUwAAc16SfSKhePW42McV+GJp5/CFdHGk2KQ3KBjy33Rz4H1AQ1z
         bnedzNJkG7DNrPdP2jVJ6Tw3b8vMZ5P6lA30dMOrlDRrNgVjlLZBLuqXoCKShc1uUG7y
         LYdQ==
X-Gm-Message-State: AO0yUKWYm0+uIGAV9yqWz1SZr5hWFA7GDBQrk9+1ldPodko+/Yk+bezw
        oFR3mcmm1lmVHSry9x9T40XUNb2WFMeidNW7rg==
X-Google-Smtp-Source: AK7set+PcbIlK8K31rlQMA/Sj0+PzkUG4C29kmo7uq0+s3PXw9tmlfNRwxOBk7N8ik9yH5otRUEREA==
X-Received: by 2002:a05:6a20:929d:b0:c2:b6cf:96db with SMTP id q29-20020a056a20929d00b000c2b6cf96dbmr2100410pzg.39.1678954364120;
        Thu, 16 Mar 2023 01:12:44 -0700 (PDT)
Received: from localhost.localdomain ([117.207.30.24])
        by smtp.gmail.com with ESMTPSA id 13-20020aa7910d000000b005d9984a947bsm4804422pfh.139.2023.03.16.01.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 01:12:43 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 16/19] arm64: dts: qcom: sdm845: Add "mhi" region to the PCIe nodes
Date:   Thu, 16 Mar 2023 13:41:14 +0530
Message-Id: <20230316081117.14288-17-manivannan.sadhasivam@linaro.org>
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
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 479859bd8ab3..46caac9acc95 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2282,8 +2282,9 @@ pcie0: pci@1c00000 {
 			reg = <0 0x01c00000 0 0x2000>,
 			      <0 0x60000000 0 0xf1d>,
 			      <0 0x60000f20 0 0xa8>,
-			      <0 0x60100000 0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "config";
+			      <0 0x60100000 0 0x100000>,
+			      <0 0x01c07000 0 0x1000>;
+			reg-names = "parf", "dbi", "elbi", "config", "mhi";
 			device_type = "pci";
 			linux,pci-domain = <0>;
 			bus-range = <0x00 0xff>;
@@ -2387,8 +2388,9 @@ pcie1: pci@1c08000 {
 			reg = <0 0x01c08000 0 0x2000>,
 			      <0 0x40000000 0 0xf1d>,
 			      <0 0x40000f20 0 0xa8>,
-			      <0 0x40100000 0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "config";
+			      <0 0x40100000 0 0x100000>,
+			      <0 0x01c0c000 0 0x1000>;
+			reg-names = "parf", "dbi", "elbi", "config", "mhi";
 			device_type = "pci";
 			linux,pci-domain = <1>;
 			bus-range = <0x00 0xff>;
-- 
2.25.1

