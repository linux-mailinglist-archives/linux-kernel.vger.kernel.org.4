Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F27635AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbiKWKzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbiKWKzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:55:02 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE48513182E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:43:55 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so994802wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PkEz/VWpHMBPTsS9RzibPZDWez5N0jos1ZT5P8gtSA=;
        b=vdKXNz0pkRcukOZMeDJiCx8BMz5uJP4UzdchlBoQv/Swegezr56hQSsSaJiRZKXglm
         N1wBnuvCJyTRfvzUgr6C/KkEKQ+TARM2/tz3qBJ5pTj7ili+DFR4SE5Ju9QTTQ3K/D2B
         eQERrYDqngkCJPZZJ/dueo0/812ce0i3toqcx8QEtE5NpWweEcc0qaYsOqtVev12QEzx
         70fAQilpXCQAzb2EyNLCp/53UjnkE5ra8VyTKCXktAs+82i3REjWxe5S+Mp0ZUWlGK8q
         XwWJPkajVv689E8LdV6YWfAcnaRdxQRtzVdeL3PIiuJgLQT24xM7nVfOI+IqPxD6Fhqr
         s4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PkEz/VWpHMBPTsS9RzibPZDWez5N0jos1ZT5P8gtSA=;
        b=C8HBbVM604JpUo+OkJFWTXxi+Y9CYrTqYy29gWxlxcoJY8leIy3m0izebIEzU1nqht
         3AdGx+ZPFS3zK4OOoVqbzj6/aI7OAPh9E+nzrHt8HaNvik5yURcBLb3D/VMXSkyLsAzW
         eqKB/xv1/uRRZzXSihwlwqbLHP5hQ6p8sGfKY+fQPFNSfB0rs1j7VUhaTU9pn8Qa5a+i
         9BSv2tr3XkY2/aeISEapRHU2gn/42RyKQ4afsG43UCSVtC08zBrQuMeheWEj8PW2cIuq
         8fjucqrHGuoWvqnVRKGh5FNB9eSG7i6PTwEz1OEoEDYb7LYx8U59+vD2tSf7Qo5/614g
         Ghtg==
X-Gm-Message-State: ANoB5pnVyRIT/sXpQE+u1kHH+xgrOKdZmFpQ1enH1DX3Zod0biAeTN/l
        5WHiMPzWw+WN01I3aSEKrZAREQ==
X-Google-Smtp-Source: AA0mqf7yEyQ9rns+namquLlGTeY3gSsWsmFVsL7i1CTP1lEyXflyHWazWS1M6elzH7hRqHVmzL/Vjw==
X-Received: by 2002:a05:600c:5406:b0:3d0:21f6:43ec with SMTP id he6-20020a05600c540600b003d021f643ecmr8806838wmb.162.1669200234479;
        Wed, 23 Nov 2022 02:43:54 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id v14-20020a5d4b0e000000b002416e383e1csm16526863wrq.25.2022.11.23.02.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 02:43:54 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     agross@kernel.org, andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 1/3] arm64: dts: qcom: sc8280xp: add gpr node
Date:   Wed, 23 Nov 2022 10:43:40 +0000
Message-Id: <20221123104342.26140-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123104342.26140-1-srinivas.kandagatla@linaro.org>
References: <20221123104342.26140-1-srinivas.kandagatla@linaro.org>
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

Add GPR node along with APM(Audio Process Manager) and PRM(Proxy
resource Manager) audio services.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 39 ++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index be72b1f7ad61..e8b6f67b928e 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/thermal/thermal.h>
 
@@ -1626,6 +1627,44 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 
 				label = "lpass";
 				qcom,remote-pid = <2>;
+
+				gpr {
+					compatible = "qcom,gpr";
+					qcom,glink-channels = "adsp_apps";
+					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
+					qcom,intents = <512 20>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					q6apm: service@1 {
+						compatible = "qcom,q6apm";
+						reg = <GPR_APM_MODULE_IID>;
+						#sound-dai-cells = <0>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+						q6apmdai: dais {
+							compatible = "qcom,q6apm-dais";
+							iommus = <&apps_smmu 0x0c01 0x0>;
+						};
+
+						q6apmbedai: bedais {
+							compatible = "qcom,q6apm-lpass-dais";
+							#sound-dai-cells = <1>;
+						};
+					};
+
+					q6prm: service@2 {
+						compatible = "qcom,q6prm";
+						reg = <GPR_PRM_MODULE_IID>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+						q6prmcc: clock-controller {
+							compatible = "qcom,q6prm-lpass-clocks";
+							clock-controller;
+							#clock-cells = <2>;
+						};
+					};
+				};
 			};
 		};
 
-- 
2.25.1

