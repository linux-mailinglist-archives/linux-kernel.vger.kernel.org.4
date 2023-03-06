Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB2D6AC57C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjCFPfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjCFPe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:34:27 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BED34F54
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 07:33:56 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id u5so10765138plq.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 07:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678116835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0HkTzoYYR05RgcCQCmtwD2GE4b0NXnbyOM+nFetWrg=;
        b=D6ntHtnnhgHWVvdz49MO9xHA9ktXCiifFFruGqkj+XK0Llmish+oypJoKvF1aXcxkB
         gA9UsiwmRd40G4dVn3kxhUEv9Bex3SAtOVK51AF/pRf1SVAH+BAPnTVyn1f9v5tgFWWO
         z/XsI1zkXQXtybcTtnK9MP6aC8dD7aPBZM1AU8HIW1JXnrb1Uou49wVvGVsTomg1WyG5
         H+29IkkNL2xFvpYPZZGq0aTXJnSaH1UEkaNekiaGPL11MsH5R5TKSlsxHX00GKUxQx6Y
         opywpDXyu1WG3Vs2y4aYh3G/6bpHXGi4fUijb2qTN/sWk+/YxBc7SlvyhBmTLWbBmxhz
         VAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0HkTzoYYR05RgcCQCmtwD2GE4b0NXnbyOM+nFetWrg=;
        b=trClI7pa145oLhNEj4sv+EEWDmczYcowbdiPuKsAYu5API0PGvHuO3n30hNryT5WqC
         6foIC/tMXQYdixEYPM0WBufqsHa9uIWoqMGP4SiVUGrwaZ7R4O2ZMoNrXX4eXxKfdwTd
         ewJRDn9RRBgLycJAY+4HFCVoD0hGfigpZg6ghfpJ74Arap/T2Vhc7XTr/Tdp98b830fA
         sQIgL6ccQJyE7Qvtfleoi9gsgfWbT84yblXL6qK6Osl/kufuNTReUFUzhAET2Pv9rIlr
         w1oTdLkIBgBuozkM++YfIGyE8rsmZBwUuXmhpNP1gylqc02/7jbT+DcIBpKaIs1wP9uU
         9PCA==
X-Gm-Message-State: AO0yUKVOfEQCREiv8eXjfRW3ynbfz9QGnKkgwsyJKU9kTw6lDQ8rbz3e
        TGcsxP8RQAUteoadSI3iSJ5U
X-Google-Smtp-Source: AK7set8S2Uvm5ccNl5/5SvtHMVLLac00gbXkO3lCAa+QYPC2cMP3c30S7MdEPCb1bDH10QBVjtdyYA==
X-Received: by 2002:a17:902:e741:b0:19e:7bd2:a224 with SMTP id p1-20020a170902e74100b0019e7bd2a224mr14494148plf.62.1678116835643;
        Mon, 06 Mar 2023 07:33:55 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id kl4-20020a170903074400b0019a7c890c61sm6837430plb.252.2023.03.06.07.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:33:55 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 18/19] arm64: dts: qcom: sc8280xp: Add "mhi" region to the PCIe nodes
Date:   Mon,  6 Mar 2023 21:02:21 +0530
Message-Id: <20230306153222.157667-19-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
References: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "mhi" region contains the debug registers that could be used to monitor
the PCIe link transitions.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 0d02599d8867..5c7f40345992 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1650,11 +1650,12 @@ pcie4: pcie@1c00000 {
 			device_type = "pci";
 			compatible = "qcom,pcie-sc8280xp";
 			reg = <0x0 0x01c00000 0x0 0x3000>,
+			      <0x0 0x01c03000 0x0 0x1000>,
 			      <0x0 0x30000000 0x0 0xf1d>,
 			      <0x0 0x30000f20 0x0 0xa8>,
 			      <0x0 0x30001000 0x0 0x1000>,
 			      <0x0 0x30100000 0x0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			reg-names = "parf", "mhi", "dbi", "elbi", "atu", "config";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			ranges = <0x01000000 0x0 0x30200000 0x0 0x30200000 0x0 0x100000>,
@@ -1749,11 +1750,12 @@ pcie3b: pcie@1c08000 {
 			device_type = "pci";
 			compatible = "qcom,pcie-sc8280xp";
 			reg = <0x0 0x01c08000 0x0 0x3000>,
+			      <0x0 0x01c0b000 0x0 0x1000>,
 			      <0x0 0x32000000 0x0 0xf1d>,
 			      <0x0 0x32000f20 0x0 0xa8>,
 			      <0x0 0x32001000 0x0 0x1000>,
 			      <0x0 0x32100000 0x0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			reg-names = "parf", "mhi", "dbi", "elbi", "atu", "config";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			ranges = <0x01000000 0x0 0x32200000 0x0 0x32200000 0x0 0x100000>,
@@ -1846,11 +1848,12 @@ pcie3a: pcie@1c10000 {
 			device_type = "pci";
 			compatible = "qcom,pcie-sc8280xp";
 			reg = <0x0 0x01c10000 0x0 0x3000>,
+			      <0x0 0x01c13000 0x0 0x1000>,
 			      <0x0 0x34000000 0x0 0xf1d>,
 			      <0x0 0x34000f20 0x0 0xa8>,
 			      <0x0 0x34001000 0x0 0x1000>,
 			      <0x0 0x34100000 0x0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			reg-names = "parf", "mhi", "dbi", "elbi", "atu", "config";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			ranges = <0x01000000 0x0 0x34200000 0x0 0x34200000 0x0 0x100000>,
@@ -1946,11 +1949,12 @@ pcie2b: pcie@1c18000 {
 			device_type = "pci";
 			compatible = "qcom,pcie-sc8280xp";
 			reg = <0x0 0x01c18000 0x0 0x3000>,
+			      <0x0 0x01c1b000 0x0 0x1000>,
 			      <0x0 0x38000000 0x0 0xf1d>,
 			      <0x0 0x38000f20 0x0 0xa8>,
 			      <0x0 0x38001000 0x0 0x1000>,
 			      <0x0 0x38100000 0x0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			reg-names = "parf", "mhi", "dbi", "elbi", "atu", "config";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			ranges = <0x01000000 0x0 0x38200000 0x0 0x38200000 0x0 0x100000>,
@@ -2043,11 +2047,12 @@ pcie2a: pcie@1c20000 {
 			device_type = "pci";
 			compatible = "qcom,pcie-sc8280xp";
 			reg = <0x0 0x01c20000 0x0 0x3000>,
+			      <0x0 0x01c23000 0x0 0x1000>,
 			      <0x0 0x3c000000 0x0 0xf1d>,
 			      <0x0 0x3c000f20 0x0 0xa8>,
 			      <0x0 0x3c001000 0x0 0x1000>,
 			      <0x0 0x3c100000 0x0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			reg-names = "parf", "mhi", "dbi", "elbi", "atu", "config";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			ranges = <0x01000000 0x0 0x3c200000 0x0 0x3c200000 0x0 0x100000>,
-- 
2.25.1

