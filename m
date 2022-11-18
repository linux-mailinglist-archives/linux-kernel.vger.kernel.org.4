Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD70762F3DA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241450AbiKRLiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241638AbiKRLhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:37:54 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36429638F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 03:37:53 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id c1so7765741lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 03:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3mt4aslduK706Qp98iDLCILch28O0Le8Egwa1Tmvqt8=;
        b=HzKXiZ0ZbmZCn3ai4fVvgn8NVeP0CaNXASXbCFV0T3a9Nm7p3y0KdfnpsrT835i8AA
         unhl+WH1X5Rkr+R9frxgLjDB2cqff4QK7eyeFo+PFipbCVLQmoNhzWDIQAgV7Nyzx1qB
         VpdwjHnvRGyY5q8LpbnCD8HkxxYb7uu61DoczTUD2a8kSi5+eY5kPkEHxrtLRU+B6cEZ
         OtW4jKWGhzOeblaX/Zvj5/eDJ0dTKg4Do6yDdEP4eLBBybPDNNtLB+tDeDUyudwoafST
         BF4obwrEmIJrIRi2gaLDDcSjhhromkkaeBKX/LW0TQ+5+G7O6tdfEqakFu9QWkTbeeAY
         KSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mt4aslduK706Qp98iDLCILch28O0Le8Egwa1Tmvqt8=;
        b=v1wO8YeSTiHAZio56X1+eLrFuOR0V1he+9n/IxK4p8NJIkbDf92MZRiQZzW2j+4B9s
         d6NXCELAORy0hwIpFlEbPstvKt62s1lB4ESQX1ZswkNgBbgAn9bqsJdBZWUxvWTN7nzX
         CQ6sdPdAEGnkQTCZSbU1+6UEtdCIBEKd9d0UY5/H+fjo+e0ExLg3Q5AZNIk7cYJn03Kf
         Ziw8GotkdrqUmfujoqou4VR3MKMCtZ8Yd0BF0Dm5U+u7tuT3UtFX4a0MN37WjnNS6ABA
         E1Biy+TIsHZOOeVxwe9mBpJ42rX2wCaZq2GQ0lndsIs/+yJtOU/+/47R2k8wQxK3aAAF
         Jkhg==
X-Gm-Message-State: ANoB5pl3RQ1elmAJmKMgBPDGr/HjcxFtBqRKhklalRU1sD+p54e1fF2A
        vrweEumkN2WxdwmWtr45UR+2qfiT4pAbW3T9
X-Google-Smtp-Source: AA0mqf7VJP+Fhvc2f8Qt3aTz6xkpSv+0bDqfC1/Hlj2NHJVRjwSp6rwdvLmK3PGlkGjQpkM/sg8FMw==
X-Received: by 2002:a19:7107:0:b0:4a8:e955:77e7 with SMTP id m7-20020a197107000000b004a8e95577e7mr2166974lfc.573.1668771471497;
        Fri, 18 Nov 2022 03:37:51 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q5-20020a2e2a05000000b0027765fd616asm622483ljq.20.2022.11.18.03.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:37:50 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: qcom: sdx55-mtp: add MPSS remoteproc memory-region
Date:   Fri, 18 Nov 2022 12:37:47 +0100
Message-Id: <20221118113747.56700-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The MPSS PAS remoteproc bindings require memory-region.  The MPSS PAS
device node is disabled, but schema still asks for it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55-mtp.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55-mtp.dts b/arch/arm/boot/dts/qcom-sdx55-mtp.dts
index 9649c1e11311..6f8909731faf 100644
--- a/arch/arm/boot/dts/qcom-sdx55-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx55-mtp.dts
@@ -229,6 +229,10 @@ nand@0 {
 	};
 };
 
+&remoteproc_mpss {
+	memory-region = <&mpss_adsp_mem>;
+};
+
 &usb {
 	status = "okay";
 };
-- 
2.34.1

