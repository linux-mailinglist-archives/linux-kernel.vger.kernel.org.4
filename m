Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4026A5D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjB1QuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjB1QuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:50:06 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94E734F43
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:48:57 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id i5so9393188pla.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mS14RoV+P3AFH8a/cHRRDGPu5wgcpokXNUSOl49FuEQ=;
        b=U44EcFFMQk0/IWAhWFePxyUVQM09DsReR8dgGZslsw2jTu3J99TAwmPDyvp/PwzAs1
         Pwp7zvV9vUuXwUd20GINMVc3AlxOAhQIAwoeSoyuikuyY9Z/PL98SqluFw1ODw8LerQR
         1T73IVBtxYyIvSGK2No9Rw+o0svL3coZGVX35vh25HjE5BXelbakbibQ/bnncnSSpJp0
         fmY/KhzkOnwKFrhcjIil5S86vtiMnUyfo/oJgJIA6goB/BzdjDalo62smJJlHMBgF4uy
         CUayKp6+GAJJEAE4eJvkrd0HWJNILcRcDaTslKul/5wEMTAv8DkPL4lA/+z2XjmOUeSo
         FGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mS14RoV+P3AFH8a/cHRRDGPu5wgcpokXNUSOl49FuEQ=;
        b=4tytkyw87LraXfxr4gU8d4bsA33m2tJwrjSrhHgfMH0bIlu9oSMf7XunOD+SNqNumM
         +cAUg+UEje4TPEcJv3QPGUadys1NdfqMJL9BsENvMENZPcfp8rSefSn25S7O/hfWv0/A
         hNFiK03ixRpQSh/QUSYGiPoECIPfoP5ZTTnQ3empFLymb0sUB+durBoUJkRdPbZlzhhB
         J97aAlEOUtkYbQY6aswvdaJNUWQOPZNV/4Qa2AJ5X2WzlKWjf3Kj9GXwp7ro6xb+uU/X
         ARx/JWJjV5IW7RYZRIUWnFqz5AM7sTm7KR3bFWMUvSvSKYAxISSJCV1eUf8pISpmOTty
         r8Cg==
X-Gm-Message-State: AO0yUKVhSXG+XNCyW3zeZB6qU3Rs7bNe4Ab52/VaWAa1f2jXEuyfOV+3
        6hS0kMTkcSJMpFsah+gZ5htYmO0zNaaWEYY=
X-Google-Smtp-Source: AK7set/pqaCfHZK1mNlRSQeZTuBVC9yfwZ6TTmFvltNVF9QiDN3BW73tWaoGU22TNMPMZF+LHwi1cQ==
X-Received: by 2002:a05:6a20:a110:b0:cc:63c6:8d3a with SMTP id q16-20020a056a20a11000b000cc63c68d3amr4360211pzk.41.1677602937090;
        Tue, 28 Feb 2023 08:48:57 -0800 (PST)
Received: from localhost.localdomain ([103.197.115.185])
        by smtp.gmail.com with ESMTPSA id z11-20020a6552cb000000b00476dc914262sm5908792pgp.1.2023.02.28.08.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 08:48:56 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 14/16] ARM: dts: qcom: apq8064: Use 0x prefix for the PCI I/O and MEM ranges
Date:   Tue, 28 Feb 2023 22:17:50 +0530
Message-Id: <20230228164752.55682-15-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230228164752.55682-1-manivannan.sadhasivam@linaro.org>
References: <20230228164752.55682-1-manivannan.sadhasivam@linaro.org>
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

To maintain the uniformity, let's use the 0x prefix for the values of
ranges property.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 92aa2b081901..210b24e510c5 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -1494,8 +1494,8 @@ pcie: pci@1b500000 {
 			num-lanes = <1>;
 			#address-cells = <3>;
 			#size-cells = <2>;
-			ranges = <0x81000000 0 0          0x0fe00000 0 0x00100000>, /* I/O */
-				 <0x82000000 0 0x08000000 0x08000000 0 0x07e00000>; /* mem */
+			ranges = <0x81000000 0x0 0x00000000 0x0fe00000 0x0 0x00100000>, /* I/O */
+				 <0x82000000 0x0 0x08000000 0x08000000 0x0 0x07e00000>; /* mem */
 			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
 			#interrupt-cells = <1>;
-- 
2.25.1

