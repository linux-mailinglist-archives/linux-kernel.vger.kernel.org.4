Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044436C8EAD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 14:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjCYNvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 09:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjCYNvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 09:51:39 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48C4113C9;
        Sat, 25 Mar 2023 06:51:38 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4PkL8l41mLz9sZ1;
        Sat, 25 Mar 2023 14:51:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1679752295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+cKn6+YIl/VFTeFPbxQYnCYTH6+Xg1WFAyiARcVV7g=;
        b=fdm4iIXtmCk+9spVcjN1TRpdNJWV1pWQRnaaapo9/HBcfpNviWSMA3JRMqCpzIWOgpcZ9R
        zpG/psAxzEcjmVIh/SThqTo2ZMnIT6ahH4/8RDSQhOLHkcLobVkdSEiFwgELfnnEp8zmnd
        bzmQlr1H57T+S262K9Q6HELviZOSQlUZdZvUEOHw+VUN3vxZ0GUC1DtW7r/wmwXybphYSk
        sIaBjWiu6RDFX/gthG+jNVppV8mniYXkTw2+gIVUk7ksMfNZqTF/2hi+0ORBXQiz9Ol6zx
        mpYy/IC8KgBwfjLD5+uprJQSDVaje9UXeV4XjLgtjGFKKFJwTqGOdA9N1TRfEg==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH 2/4] dts: arm64: qcom: sdm845: add SLPI FastRPC support
Date:   Sat, 25 Mar 2023 14:51:12 +0100
Message-Id: <20230325135114.21688-3-me@dylanvanassche.be>
In-Reply-To: <20230325135114.21688-1-me@dylanvanassche.be>
References: <20230325135114.21688-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PkL8l41mLz9sZ1
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm SDM845 SoC features a SLPI DSP which uses FastRPC through
an allocated memory region to load files from the host filesystem
such as sensor configuration files.

Add a FastRPC node at /dev/fastrpc-sdsp and a DMA region, similar to
downstream, to allow userspace to communicate with the SLPI via the
FastRPC interface for initializing the sensors on the SLPI.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 8dcfe6293762..5a6c7d00719b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -878,6 +878,14 @@ mdata_mem: mpss-metadata {
 			size = <0 0x4000>;
 			no-map;
 		};
+
+		fastrpc_mem: fastrpc {
+			compatible = "shared-dma-pool";
+			reusable;
+			alloc-ranges = <0 0x00000000 0 0xffffffff>;
+			alignment = <0 0x400000>;
+			size = <0 0x1000000>;
+		};
 	};
 
 	adsp_pas: remoteproc-adsp {
@@ -3344,6 +3352,22 @@ glink-edge {
 				label = "dsps";
 				qcom,remote-pid = <3>;
 				mboxes = <&apss_shared 24>;
+
+				fastrpc {
+					compatible = "qcom,fastrpc";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+					label = "sdsp";
+					qcom,non-secure-domain;
+					qcom,vmids = <0x3 0xF 0x5 0x6>;
+					memory-region = <&fastrpc_mem>;
+					qcom,assign-all-mem;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					compute-cb {
+						compatible = "qcom,fastrpc-compute-cb";
+					};
+				}
 			};
 		};
 
-- 
2.39.2

