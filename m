Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8040D668492
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240472AbjALUy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjALUwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:52:55 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F8914036;
        Thu, 12 Jan 2023 12:26:45 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id f34so30063734lfv.10;
        Thu, 12 Jan 2023 12:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xEQRHf7T4Vul5n6Ce/RnUDlp5mLsEbSbyDrbmEwnHo=;
        b=cm2msse98jfGPRW4vpsfInsH53I63essjWoNQVrWB7L6Jzw8XMeWR1p0hBC9erQXQX
         UxOQDrgLj4uzJ98C+lLCvFurHCW6QFiAZVEjqUPHqDWRkXP3lKGulKqZQ/DAzzI6siqF
         efdwLZfYtsxcmsAep8qGp2zIRSWGR8I/GwWNfuJyOga3Kp8+y6DuWIHld2NugFNhNDkb
         lut0ScqQROh+rhVnhSvLYkDpweWVWNv3tywhv8KbTtU4uEWbLhtA+AcuMynH+sHB5BU3
         BClJXwdH/itGaaE/eXHtJJYJBUTMcrD+I/1jG6JdSbGY3OR9OpMseECd6Jiv30hVAam+
         R16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xEQRHf7T4Vul5n6Ce/RnUDlp5mLsEbSbyDrbmEwnHo=;
        b=2VJHn+lIEhHiRGFSE/P4ZI1oFYDEYUu1GfojfN607k2PAYbRu4FhvFZhbf42FPgOSK
         c6qvqoAlykxXRfWfJbW6aFGRDGq8b42ZMz7GxfRK14f6g1Gay/UDgw9cCbrRKsRK6gA0
         CXxL+z7rNyTYw/D572fd+XCvfTmcWKWbOs5O59CS7luV8t2cMwK2Wr2DtkA917GH+31E
         2WN+8z1Yq4dhjPKnj+kGD0tyb2fC0WyMyHGNQ5ie773ILLdfWpFG6ibjiFXB+Qb3ZSvh
         0vKmmCLiFhLZQBhM1iuy5wqaiFdRHeivrE1Hj6leZ4tor0ppBrKXvPmDM3AUuOTIIxgT
         eMBA==
X-Gm-Message-State: AFqh2kp9bp4AihjQkn47soMRaC9vFQYXao0rUWx9EsCYV8kH5ugBDO+L
        5b0nb5GsthbMoPZ/B9emubLmyPhvrdadCA==
X-Google-Smtp-Source: AMrXdXt5zsT8oJfVbQch9r6wfFb4neXNL3AQjTtM9zX5zqxlPqvpeJzEu0j41t5pi+bq7Gt1X/ZX6w==
X-Received: by 2002:a05:6512:169e:b0:4ca:fa2d:2686 with SMTP id bu30-20020a056512169e00b004cafa2d2686mr24897368lfb.35.1673555203483;
        Thu, 12 Jan 2023 12:26:43 -0800 (PST)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id k6-20020a2eb746000000b00281350bb5fbsm2346731ljo.2.2023.01.12.12.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 12:26:42 -0800 (PST)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] ARM: dts: qcom: msm8226: Add smsm node
Date:   Thu, 12 Jan 2023 22:26:09 +0200
Message-Id: <20230112202612.791455-7-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112202612.791455-1-matti.lehtimaki@gmail.com>
References: <20230112202612.791455-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds smsm node for remoteproc cores.

Co-developed-by: Luca Weiss <luca@z3ntu.xyz>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 arch/arm/boot/dts/qcom-msm8226.dtsi | 36 +++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index 394662cbf282..2639167c8976 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -140,6 +140,42 @@ adsp_smp2p_in: slave-kernel {
 		};
 	};
 
+	smsm {
+		compatible = "qcom,smsm";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		qcom,ipc-1 = <&apcs 8 13>;
+		qcom,ipc-2 = <&apcs 8 9>;
+		qcom,ipc-3 = <&apcs 8 19>;
+
+		apps_smsm: apps@0 {
+			reg = <0>;
+			#qcom,smem-state-cells = <1>;
+		};
+
+		modem_smsm: modem@1 {
+			reg = <1>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		adsp_smsm: adsp@2 {
+			reg = <2>;
+			interrupts = <GIC_SPI 157 IRQ_TYPE_EDGE_RISING>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		wcnss_smsm: wcnss@7 {
+			reg = <7>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_EDGE_RISING>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.34.1

