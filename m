Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1106994DD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjBPMxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjBPMxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:53:04 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C263410A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:53:03 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l2so1802104wry.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOlcxYbFV1QWfu0q4yI7Y8XhpMc15c4VHRcGdANSUSE=;
        b=vGywFXh9F/9t/qsH78rosSvNnut2PMCb0Rr2tiIPebqHzYdOlyFbdB2WyxqDxmcpCT
         gAtP6i/WYxYWUF2XNXreu9hMUsiU4I6UFwFQLRLhe2KNY/fAQuB3ET3ZqYY1K5kH2kYi
         96PfurybC3c88s07+0UZKNuY8+XIYyDAIOLzBiqNrCdLK1c30WPbt7IBNW1msA1dNnSl
         1tGoJNgOFELeSvLD1B3edfJRcT8Y/pw+rZzZw/pBu1dJHKftCF8ajgQ8z7s8hjA/egXE
         F7SQSMJ6ERJ1vfvmemiiglicQruruZUbR46RbdsZdn5GZXVvmUYR2r7LkgahmEhmCmHG
         dkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOlcxYbFV1QWfu0q4yI7Y8XhpMc15c4VHRcGdANSUSE=;
        b=2cLGFPglAIcAuWarRg2OLVE5CKIGyRpqk5bmKYhjj0VmUTXbwXCZGNvoF3UG+f2Fbj
         ELNnjWKZC2kvzJTTYzyF1lKChbO+kX6ZTfM0BChWuT+Z06Ukr6Z1CDx8ExItydw+6CBS
         UXoZzpqsFM70SS9+uY6mvwkBrz7ktrSyQDKMfNISOnXI2QeYy6hRVE+dYDHLJ3MvDezH
         msrCibUQss+aNB0M/SOwPAM7VwkEdkbxLSfL4xCcoDl2r08NQXPSzzsmjH5Hr7JOUkEh
         2rwnHikD+gCXFiQUcqkpZ7bd8VDzQQGaJ1kEmisvHVbsPj5DOa9QXPQpYWOmqSimDfXv
         ndLg==
X-Gm-Message-State: AO0yUKUGTpcE4z/tLvGgNGnd6PZ9u4lBLKaR+pN1ca6ER8v54JFRDu9i
        quQwB+NCICZDwIJ4dp6ma+DFSg==
X-Google-Smtp-Source: AK7set/k5C/fxcrmxqhk/K0SZwIXRY9xmR4qvAhJbJJstjG6jrsIC2EqYZxDfP/z5G4+e6SlOSrv6A==
X-Received: by 2002:a05:6000:120e:b0:2c5:63df:1171 with SMTP id e14-20020a056000120e00b002c563df1171mr5365114wrx.19.1676551981509;
        Thu, 16 Feb 2023 04:53:01 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7c5b:1160:db5d:72da])
        by smtp.gmail.com with ESMTPSA id h18-20020adffd52000000b002be5bdbe40csm1453292wrs.27.2023.02.16.04.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 04:53:01 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 1/9] arm64: dts: qcom: sa8775p: add the QUPv3 #2 node
Date:   Thu, 16 Feb 2023 13:52:49 +0100
Message-Id: <20230216125257.112300-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230216125257.112300-1-brgl@bgdev.pl>
References: <20230216125257.112300-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the second instance of the QUPv3 engine to the sa8775p.dtsi.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 565c1376073e..894c0662afb4 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -491,6 +491,19 @@ &clk_virt SLAVE_QUP_CORE_1 0>,
 			};
 		};
 
+		qupv3_id_2: geniqup@8c0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0x0 0x8c0000 0x0 0x6000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			clocks = <&gcc GCC_QUPV3_WRAP_2_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_2_S_AHB_CLK>;
+			clock-names = "m-ahb", "s-ahb";
+			iommus = <&apps_smmu 0x5a3 0x0>;
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@17a00000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0x17a00000 0x0 0x10000>,     /* GICD */
-- 
2.37.2

