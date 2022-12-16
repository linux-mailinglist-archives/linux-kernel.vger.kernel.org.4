Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F41B64F515
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiLPXaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiLPX3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:29:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82F12B61D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 15:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671233337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZraKQ8zpXaq21f6Xh7MkKwT51QM1mBosAn+IIPTlXH0=;
        b=XSEBkj+OCitMlgS2gwB+CMUYyG56T8Z5WYnbyXNL+2b+or+l+IlmXmZTSirF1PbIDaMEUi
        FHHRkPATunt3wKC3+On55MJ3zNMfexLSk5vfUsaf/5nCgNCN1kjhUeZq2gpCC+NHHB6a0Q
        ymVT1pLFdg1tHLvkkHBGZRWvYtldHP8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-XbPdoI-PO7yNn21_yWTLbg-1; Fri, 16 Dec 2022 18:28:56 -0500
X-MC-Unique: XbPdoI-PO7yNn21_yWTLbg-1
Received: by mail-qt1-f198.google.com with SMTP id bt4-20020ac86904000000b003a96b35e7a8so2381913qtb.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 15:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZraKQ8zpXaq21f6Xh7MkKwT51QM1mBosAn+IIPTlXH0=;
        b=dnnVfYs0dBr6eGPrx8Y5QBSbwT69NoLvMDLUu56sZiHmbwBwzTqq6Fr+Jr+eIqAnhP
         Rqvm01w7c1SXq7UR11dNoOA4WCoRPrZrJLeNlXvnUqdNAlNnPlwiwwAu0Z3Nv+ifWSOt
         1B03UKJs9dRSmOtjGQmoeV6uX80pmv6kmuYwOtd45538lyaAO+OtOnuVPanc03oT8Ouz
         UmL+2/syAolSWJFaDARJDYQh3aSe6tyB34Nl143/1aClqAW47ob+WfMRloYx5tn9icsE
         UAAKjfwO2UWcwv0Jwtc6tnwkA1ID6snvYdfp4ZzakwdDRNsO9RRRbxq+6LItkHKoVo9T
         Qp4g==
X-Gm-Message-State: ANoB5pkw6DA4Pr6mRFngDkrVGMk5tXQvere4EuQCjWcrUwJnIMDflSkT
        0+R8RnM8IkyV86wEe27LmcnbRlg1ftjjlrwHrCs+fHMRqIGWk8AT74s6otdtq9EtNaajdza2PdQ
        qM9PVJ/e4lA0qIeM5Hmw+efzZ
X-Received: by 2002:a05:6214:5848:b0:4c7:1c71:e7da with SMTP id ml8-20020a056214584800b004c71c71e7damr43264473qvb.17.1671233335922;
        Fri, 16 Dec 2022 15:28:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4JAVWjbkYBvXicruCl97xmCX2tyHqRd2/+2yW1r+Sod2aNzAhammkHTIOpCR2Pn7/S3J8BSA==
X-Received: by 2002:a05:6214:5848:b0:4c7:1c71:e7da with SMTP id ml8-20020a056214584800b004c71c71e7damr43264462qvb.17.1671233335708;
        Fri, 16 Dec 2022 15:28:55 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id z189-20020a3765c6000000b006f3e6933bacsm2349799qkb.113.2022.12.16.15.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 15:28:54 -0800 (PST)
From:   Eric Chanudet <echanude@redhat.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        Eric Chanudet <echanude@redhat.com>
Subject: [PATCH v3 3/4] arm64: dts: qcom: sa8295p-adp: use sa8540p-pmics
Date:   Fri, 16 Dec 2022 18:26:05 -0500
Message-Id: <20221216232606.2123341-4-echanude@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221216232606.2123341-1-echanude@redhat.com>
References: <20221216232606.2123341-1-echanude@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include the dtsi to use a single pmic descriptions.
Both sa8295p-adp and sa8540p-adp have the same spmi pmic apparently.

Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 79 +-----------------------
 1 file changed, 1 insertion(+), 78 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
index 84cb6f3eeb56..c8437efe8235 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -11,6 +11,7 @@
 #include <dt-bindings/spmi/spmi.h>
 
 #include "sa8540p.dtsi"
+#include "sa8540p-pmics.dtsi"
 
 / {
 	model = "Qualcomm SA8295P ADP";
@@ -260,84 +261,6 @@ &remoteproc_nsp1 {
 	status = "okay";
 };
 
-&spmi_bus {
-	pm8450a: pmic@0 {
-		compatible = "qcom,pm8150", "qcom,spmi-pmic";
-		reg = <0x0 SPMI_USID>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		rtc@6000 {
-			compatible = "qcom,pm8941-rtc";
-			reg = <0x6000>;
-			reg-names = "rtc", "alarm";
-			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
-			wakeup-source;
-		};
-
-		pm8450a_gpios: gpio@c000 {
-			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
-			reg = <0xc000>;
-			gpio-controller;
-			gpio-ranges = <&pm8450a_gpios 0 0 10>;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-	};
-
-	pm8450c: pmic@4 {
-		compatible = "qcom,pm8150", "qcom,spmi-pmic";
-		reg = <0x4 SPMI_USID>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pm8450c_gpios: gpio@c000 {
-			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
-			reg = <0xc000>;
-			gpio-controller;
-			gpio-ranges = <&pm8450c_gpios 0 0 10>;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-	};
-
-	pm8450e: pmic@8 {
-		compatible = "qcom,pm8150", "qcom,spmi-pmic";
-		reg = <0x8 SPMI_USID>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pm8450e_gpios: gpio@c000 {
-			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
-			reg = <0xc000>;
-			gpio-controller;
-			gpio-ranges = <&pm8450e_gpios 0 0 10>;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-	};
-
-	pm8450g: pmic@c {
-		compatible = "qcom,pm8150", "qcom,spmi-pmic";
-		reg = <0xc SPMI_USID>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pm8450g_gpios: gpio@c000 {
-			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
-			reg = <0xc000>;
-			gpio-controller;
-			gpio-ranges = <&pm8450g_gpios 0 0 10>;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-	};
-};
-
 &ufs_mem_hc {
 	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
 
-- 
2.38.1

