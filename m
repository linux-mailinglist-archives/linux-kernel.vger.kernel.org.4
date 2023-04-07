Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24686DB106
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjDGQyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjDGQye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:54:34 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB2DC144;
        Fri,  7 Apr 2023 09:54:31 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id q16so55132785lfe.10;
        Fri, 07 Apr 2023 09:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680886470; x=1683478470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktJMg05n6GOaL8XM13kdY9cBe1CBvoQ4/ZC5LzH85fg=;
        b=f0TrzevfBLxSt7EtNx1NswbcVI+uXpO+wx857eRHxEghtlgrIPS0QIcDfCls53NBmt
         kgPgq3IH3wbq2LNoBNAD6xPhVeAl6lk8npvjMvsJhJ76JOlpENcTAf9zbGDNSUgC3VZu
         2rztPrkoopcmgT8dVLwUbVJJC5gaFIoYNfG+6Uy7nNU2yZ1gm1S8q9d7SsPa3S3B3m4v
         Q0LKT4t+e/IYYW+EvWus0VCcLLwxz/wNuJGLGUZOCdmDV/EybBlVRqEMF86QeCErJ7/0
         LuX1fh5gQHqtfz2EmF2UcriJhaxj7mP2C6lkR/4doXw3jJ6ZQbuTKb2rXNPe7Mx9pIfY
         jkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680886470; x=1683478470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktJMg05n6GOaL8XM13kdY9cBe1CBvoQ4/ZC5LzH85fg=;
        b=JxcH421rZJIvLaf/KEKwYA+pgwGTC3lDNJNGlHQSA0iV3q/EjxZdfvSEF7KU3U4iX4
         OzpuTPZE/ySxxObvZgEEnVtbF7AUQQwxP/U0V3S6HD40I1//DZOM4VWAPSTibWpVs0Xg
         18EK/ygOBezOzkEqCnVQAy3z1nN4hx5QnYY2nw8nvl0Y7RqH+VxtxyqQC5jQJ7BUxW2x
         O1SGcFtUxG4nShjFr/5dHytyLgvO3XJmgj2wX15jkEA7RggVfky+tTxzBCBY3iLjCaTQ
         xmRN/0W+pICRru/1ux/L5r0x/jZSg6PZfzTAtwqVYxZTo2vYflRiFOE/kdnYB89vIkO7
         /5SA==
X-Gm-Message-State: AAQBX9eKYu1mXNexKOapbGQ8SrFaiG4p6pLtpV+GVCpAzgMtazQG9Nn+
        SzHqqoQ/kqXSLOwTjob3NCBep/G3BUJAdQ==
X-Google-Smtp-Source: AKy350ZGRmKJUxe3n4Dx2SocA+O69ZU6/K6EwbwWEmZlz2dKGLV0EMlhlxtX2TtHoiyEuF0H+uvk8w==
X-Received: by 2002:ac2:50c3:0:b0:4eb:1048:1285 with SMTP id h3-20020ac250c3000000b004eb10481285mr910839lfm.47.1680886469664;
        Fri, 07 Apr 2023 09:54:29 -0700 (PDT)
Received: from localhost.localdomain (byy157.neoplus.adsl.tpnet.pl. [83.30.44.157])
        by smtp.gmail.com with ESMTPSA id c3-20020ac25303000000b004db297957e8sm781712lfh.305.2023.04.07.09.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 09:54:29 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: MSM8953: Add lpass nodes
Date:   Fri,  7 Apr 2023 18:53:44 +0200
Message-Id: <20230407165345.42800-4-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230407165345.42800-1-a39.skl@gmail.com>
References: <20230407165345.42800-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for remoteproc, smp2p and smsm in preparation
for audio support on this platform.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 141 ++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 257b1946372c..855595cbb09b 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -6,6 +6,9 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,apr.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -326,6 +329,30 @@ rpmpd_opp_turbo: opp9 {
 		};
 	};
 
+	smp2p-adsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <443>, <429>;
+
+		interrupts = <GIC_SPI 291 IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&apcs 10>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <2>;
+
+		smp2p_adsp_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_adsp_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	smp2p-modem {
 		compatible = "qcom,smp2p";
 		qcom,smem = <435>, <428>;
@@ -1532,6 +1559,120 @@ frame@b128000 {
 				status = "disabled";
 			};
 		};
+
+		lpass: remoteproc@c200000 {
+			compatible = "qcom,msm8953-adsp-pil";
+			reg = <0x0c200000 0x100>;
+
+			interrupts-extended = <&intc 0 293 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "xo";
+
+			power-domains = <&rpmpd MSM8953_VDDCX>;
+			power-domain-names = "cx";
+
+			memory-region = <&adsp_fw_mem>;
+
+			qcom,smem-states = <&smp2p_adsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			smd-edge {
+				interrupts = <GIC_SPI 289 IRQ_TYPE_EDGE_RISING>;
+
+				label = "lpass";
+				mboxes = <&apcs 8>;
+				qcom,smd-edge = <1>;
+				qcom,remote-pid = <2>;
+
+				apr {
+					compatible = "qcom,apr-v2";
+					qcom,smd-channels = "apr_audio_svc";
+					qcom,apr-domain = <APR_DOMAIN_ADSP>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					q6core: service@3 {
+						reg = <APR_SVC_ADSP_CORE>;
+						compatible = "qcom,q6core";
+					};
+
+					q6afe: service@4 {
+						compatible = "qcom,q6afe";
+						reg = <APR_SVC_AFE>;
+						q6afedai: dais {
+							compatible = "qcom,q6afe-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+
+							dai@16 {
+								reg = <PRIMARY_MI2S_RX>;
+								qcom,sd-lines = <0 1>;
+							};
+							dai@20 {
+								reg = <TERTIARY_MI2S_TX>;
+								qcom,sd-lines = <0 1>;
+							};
+							dai@127 {
+								reg = <QUINARY_MI2S_RX>;
+								qcom,sd-lines = <0>;
+							};
+						};
+
+						q6afecc: clock-controller {
+							compatible = "qcom,q6afe-clocks";
+							#clock-cells = <2>;
+						};
+					};
+
+					q6asm: service@7 {
+						compatible = "qcom,q6asm";
+						reg = <APR_SVC_ASM>;
+						q6asmdai: dais {
+							compatible = "qcom,q6asm-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+
+							dai@0 {
+								reg = <0>;
+								direction = <Q6ASM_DAI_RX>;
+							};
+							dai@1 {
+								reg = <1>;
+								direction = <Q6ASM_DAI_TX>;
+							};
+							dai@2 {
+								reg = <2>;
+								direction = <Q6ASM_DAI_RX>;
+							};
+							dai@3 {
+								reg = <3>;
+								direction = <Q6ASM_DAI_RX>;
+								is-compress-dai;
+							};
+						};
+					};
+
+					q6adm: service@8 {
+						compatible = "qcom,q6adm";
+						reg = <APR_SVC_ADM>;
+						q6routing: routing {
+							compatible = "qcom,q6adm-routing";
+							#sound-dai-cells = <0>;
+						};
+					};
+				};
+			};
+		};
 	};
 
 	thermal-zones {
-- 
2.25.1

