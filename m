Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCCA66AE0F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 22:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjANVIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 16:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjANVIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 16:08:17 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2EC9EDA
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 13:08:13 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so27667807pjj.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 13:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dX9vpUuJim4tgDsy1o2ntPEfYHflg+J2zhoKMTHo15g=;
        b=ynRlIi/0sg8OF74zvERIwLq3h4atwqMiFQ3GffxzHd7IURQKpidbh4hveHUmXRAT9U
         UBmjNf64A/I6KE7OLJy85Vx2QQUXjsUYxJRtbggktyNOaPgK2GHhR4HtO64Qyyj1bUqE
         63Fn6x1XB/5Oe9+c4Jq3FsWDVoxLm64hUfX+TbWLV/sMXskdbbLy0B3H/sDGLFXJ3pSq
         ojdf1yjxhCQuVxe70YzfpzoQrcZWK419oiDQPI7ee8/+SCaTr4vdswoPuQU5llyFBiqS
         XmOPWNwZMg2j1WCuQl3QV2uwRUcZ9Aq+Y9wRaCNMRGW1JPsFq2OZ9D4fW/o+PaFRIMoO
         cfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dX9vpUuJim4tgDsy1o2ntPEfYHflg+J2zhoKMTHo15g=;
        b=oH1KGLYZtl3S5gWsX0Rn0nFzGguhnXPIKsdjxKe0UDfBp4leeKGMOAABrmzEkqbxDM
         whhZ10X3WXBEcVW2qXsFgQrngQSRh2NsNWVoqPX9JiC6A2XYG3VwO/BfVy0OJJDgjiaE
         VTjuqvMAxa78skIs7RUXHmebUem+l17WSoOoHBqEckZvxVhBQSmx6awMHpUeA5MUfImZ
         JwcarXB0fdJa+a9DsgC55HyANBnUmZu2uc50JaC9po2+hqvbx0N/xaEwB43Gzh1bvLw1
         Z5XooYSZnwCmmCxumf83deUWUpFTmX7+7b0nUwp2110VE/UcP9d5rMn7ageivi7EH9JI
         AUSA==
X-Gm-Message-State: AFqh2krIOgyvGQPO1GpYBG8ibZmVu2/vGGc+K6iqY8Yr0tFZs7cWCzeU
        PIjt/U5yD2Z/9RPBAfsf9Gg/BQ==
X-Google-Smtp-Source: AMrXdXv0ZXkP75G5RNMRhnYRIeBkPC9K0w9twXbaqbBitP4dCZ8bn9fwJ9iz3BoaGkyL+GJq5+GQXQ==
X-Received: by 2002:a17:902:b18a:b0:194:87fe:c8f9 with SMTP id s10-20020a170902b18a00b0019487fec8f9mr1270417plr.38.1673730492712;
        Sat, 14 Jan 2023 13:08:12 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c60:63d3:2d69:9f71:187e:f085])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090264d600b001708c4ebbaesm3204283pli.309.2023.01.14.13.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 13:08:12 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sm6115: Add debug related nodes
Date:   Sun, 15 Jan 2023 02:37:54 +0530
Message-Id: <20230114210754.353912-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
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

Add dtsi nodes related to coresight debug units such
as cti, etm, etr, funnel(s), replicator(s), etc. for
Qualcomm sm6115 SoC.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 612 +++++++++++++++++++++++++++
 1 file changed, 612 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 478c5d009272..5067910b18ab 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1237,6 +1237,618 @@ dispcc: clock-controller@5f00000 {
 			#power-domain-cells = <1>;
 		};
 
+		cti0: cti@8010000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x08010000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti1: cti@8011000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x08011000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti2: cti@8012000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x08012000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti3: cti@8013000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x08013000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti4: cti@8014000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x08014000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti5: cti@8015000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x08015000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti6: cti@8016000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x08016000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti7: cti@8017000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x08017000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti8: cti@8018000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x08018000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti9: cti@8019000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x08019000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti10: cti@801a000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x0801a000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti11: cti@801b000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x0801b000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti12: cti@801c000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x0801c000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti13: cti@801d000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x0801d000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti14: cti@801e000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x0801e000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti15: cti@801f000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x0801f000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		replicator@8046000 {
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg = <0x08046000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					replicator_out: endpoint {
+						remote-endpoint = <&etr_in>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					replicator_in: endpoint {
+						remote-endpoint = <&etf_out>;
+					};
+				};
+			};
+		};
+
+		etf@8047000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x08047000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+
+			in-ports {
+				port {
+					etf_in: endpoint {
+						remote-endpoint = <&merge_funnel_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					etf_out: endpoint {
+						remote-endpoint = <&replicator_in>;
+					};
+				};
+			};
+		};
+
+		etr@8048000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x08048000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+
+			in-ports {
+				port {
+					etr_in: endpoint {
+						remote-endpoint = <&replicator_out>;
+					};
+				};
+			};
+		};
+
+		stm@8002000 {
+			compatible = "arm,coresight-stm", "arm,primecell";
+			reg = <0x08002000 0x1000>,
+			      <0x0e280000 0x180000>;
+			reg-names = "stm-base", "stm-stimulus-base";
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					stm_out: endpoint {
+						remote-endpoint = <&funnel_in0_in>;
+					};
+				};
+			};
+		};
+
+		funnel@8041000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x08041000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					funnel_in0_out: endpoint {
+						remote-endpoint = <&merge_funnel_in0>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					funnel_in0_in: endpoint {
+						remote-endpoint = <&stm_out>;
+					};
+				};
+			};
+		};
+
+		funnel@8042000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x08042000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					funnel_in1_out: endpoint {
+						remote-endpoint = <&merge_funnel_in1>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					funnel_in1_in: endpoint {
+						remote-endpoint = <&funnel_apss1_out>;
+					};
+				};
+			};
+		};
+
+		funnel@8045000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x08045000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					merge_funnel_out: endpoint {
+						remote-endpoint = <&etf_in>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					merge_funnel_in0: endpoint {
+						remote-endpoint = <&funnel_in0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					merge_funnel_in1: endpoint {
+						remote-endpoint = <&funnel_in1_out>;
+					};
+				};
+			};
+		};
+
+		etm@9040000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x09040000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			cpu = <&CPU0>;
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					etm0_out: endpoint {
+						remote-endpoint = <&funnel_apss0_in0>;
+					};
+				};
+			};
+		};
+
+		etm@9140000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x09140000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			cpu = <&CPU1>;
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					etm1_out: endpoint {
+						remote-endpoint = <&funnel_apss0_in1>;
+					};
+				};
+			};
+		};
+
+		etm@9240000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x09240000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			cpu = <&CPU2>;
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					etm2_out: endpoint {
+						remote-endpoint = <&funnel_apss0_in2>;
+					};
+				};
+			};
+		};
+
+		etm@9340000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x09340000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			cpu = <&CPU3>;
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					etm3_out: endpoint {
+						remote-endpoint = <&funnel_apss0_in3>;
+					};
+				};
+			};
+		};
+
+		etm@9440000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x09440000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			cpu = <&CPU4>;
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					etm4_out: endpoint {
+						remote-endpoint = <&funnel_apss0_in4>;
+					};
+				};
+			};
+		};
+
+		etm@9540000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x09540000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			cpu = <&CPU5>;
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					etm5_out: endpoint {
+						remote-endpoint = <&funnel_apss0_in5>;
+					};
+				};
+			};
+		};
+
+		etm@9640000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x09640000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			cpu = <&CPU6>;
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					etm6_out: endpoint {
+						remote-endpoint = <&funnel_apss0_in6>;
+					};
+				};
+			};
+		};
+
+		etm@9740000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x09740000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			cpu = <&CPU7>;
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					etm7_out: endpoint {
+						remote-endpoint = <&funnel_apss0_in7>;
+					};
+				};
+			};
+		};
+
+		funnel@9800000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x09800000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					funnel_apss0_out: endpoint {
+						remote-endpoint = <&funnel_apss1_in>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					funnel_apss0_in0: endpoint {
+						remote-endpoint = <&etm0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					funnel_apss0_in1: endpoint {
+						remote-endpoint = <&etm1_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					funnel_apss0_in2: endpoint {
+						remote-endpoint = <&etm2_out>;
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+					funnel_apss0_in3: endpoint {
+						remote-endpoint = <&etm3_out>;
+					};
+				};
+
+				port@4 {
+					reg = <4>;
+					funnel_apss0_in4: endpoint {
+						remote-endpoint = <&etm4_out>;
+					};
+				};
+
+				port@5 {
+					reg = <5>;
+					funnel_apss0_in5: endpoint {
+						remote-endpoint = <&etm5_out>;
+					};
+				};
+
+				port@6 {
+					reg = <6>;
+					funnel_apss0_in6: endpoint {
+						remote-endpoint = <&etm6_out>;
+					};
+				};
+
+				port@7 {
+					reg = <7>;
+					funnel_apss0_in7: endpoint {
+						remote-endpoint = <&etm7_out>;
+					};
+				};
+			};
+		};
+
+		funnel@9810000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x09810000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					funnel_apss1_out: endpoint {
+						remote-endpoint = <&funnel_in1_in>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					funnel_apss1_in: endpoint {
+						remote-endpoint = <&funnel_apss0_out>;
+					};
+				};
+			};
+		};
+
 		apps_smmu: iommu@c600000 {
 			compatible = "qcom,sm6115-smmu-500", "qcom,smmu-500", "arm,mmu-500";
 			reg = <0x0c600000 0x80000>;
-- 
2.38.1

