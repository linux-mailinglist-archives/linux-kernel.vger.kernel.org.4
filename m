Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2956CBAF8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjC1J3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjC1J2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:28:53 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A790659B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:28:49 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso11847752pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679995729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuEDYxPh1iqRLp/0Giai1ZnY3ruEMo64qCfhktsCtAU=;
        b=Bna4dcnjysLL0bcaRAvM3Xbv7qkf/tbSF5JvaQh9JBonwOssho353RcyEQ+7+PBdCq
         liHUSu4DF9wUclqe8xIfeWPCOGWXhpwY7LzGclJE42HafSOmoUimcuMeH3jTK/uzdKUb
         zYR0cilGv/LCMiXvuIj2EDH7FjYlAVgyOmFVze7ZgjMqLcWQkzRpjNT6JcQ1mZvBcm7B
         Ea6lv2xhn9NPMR/rITkdK3tuTqgumz6m3WzF0925IYIYckBWRNOOdtRUw0whHiGjLL0o
         CZ4EoGNlqL+FJI3DCOsVVvhzqfI7fg/BBZ7UCugL15IwQ2hUBb22ldBCRiZUGgaQ0DUs
         xClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679995729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuEDYxPh1iqRLp/0Giai1ZnY3ruEMo64qCfhktsCtAU=;
        b=Qcg85Zzy/rNytsVxPDbWrr9OgdYYgaLsWt+6zcunD/3jtPTBeiHVEZUMJFtYDZcXgD
         OObn2XTEri2Vs8okven7O1fp1FoZaVR4MJFcxuao4t95DXyXJVNFxl2EeMAkivUah/cK
         FLvHtg/3IXOvypzj5ILk1iQGBpwR86kft9PjKZIhjXWRTvaPTBPOf3Kr2/skxG/eV8wy
         8rw2XwRKBhP6Z9rxh3PV23DWSbKc1/CAcL2y0tM4NzsdMIAQLBLtcY/09OBi91gLXcTA
         7RRPKdPqaq9fg32Y3r8WehmL3kRHBflZC0/SVrAs6BxWtmJ4VNwF2oqLSNKYwT3uS7oB
         IStg==
X-Gm-Message-State: AO0yUKV6wC+LrE6PC94J+uHRSa9PA+A/o/i0TG2Kt3Lj6Q5yMmBS0lCo
        cx42fytZuKdQ3Su0zDV34iHemw==
X-Google-Smtp-Source: AK7set/zxXxWY6gq5tqqe3NXj9QJk02/C2Nsm57TMBv0A3hcDMEMX1MWnZKK23bo1WkbO+fsswwuPw==
X-Received: by 2002:a05:6a20:671f:b0:d8:f312:b3b with SMTP id q31-20020a056a20671f00b000d8f3120b3bmr12843229pzh.3.1679995728630;
        Tue, 28 Mar 2023 02:28:48 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:449a:10df:e7c1:9bdd:74f0])
        by smtp.gmail.com with ESMTPSA id a24-20020aa78658000000b005a8bc11d259sm21261518pfo.141.2023.03.28.02.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 02:28:48 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
Subject: [PATCH v3 5/9] arm64: dts: qcom: sm6115: Add Crypto Engine support
Date:   Tue, 28 Mar 2023 14:58:11 +0530
Message-Id: <20230328092815.292665-6-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230328092815.292665-1-bhupesh.sharma@linaro.org>
References: <20230328092815.292665-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add crypto engine (CE) and CE BAM related nodes and definitions to
'sm6115.dtsi'.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 2a51c938bbcb..ebac026b4cc7 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -650,6 +650,28 @@ usb_hsphy: phy@1613000 {
 			status = "disabled";
 		};
 
+		cryptobam: dma-controller@1b04000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0x0 0x01b04000 0x0 0x24000>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			num-channels = <8>;
+			qcom,num-ees = <2>;
+			iommus = <&apps_smmu 0x94 0x11>,
+				 <&apps_smmu 0x96 0x11>;
+		};
+
+		crypto: crypto@1b3a000 {
+			compatible = "qcom,sm6115-qce", "qcom,sm8150-qce", "qcom,qce";
+			reg = <0x0 0x01b3a000 0x0 0x6000>;
+			dmas = <&cryptobam 6>, <&cryptobam 7>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x94 0x11>,
+				 <&apps_smmu 0x96 0x11>;
+		};
+
 		qfprom@1b40000 {
 			compatible = "qcom,sm6115-qfprom", "qcom,qfprom";
 			reg = <0x0 0x01b40000 0x0 0x7000>;
-- 
2.38.1

