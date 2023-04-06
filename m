Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2134A6D9EDA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239841AbjDFReO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240068AbjDFRdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:33:52 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6176F5FF9;
        Thu,  6 Apr 2023 10:33:43 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4PspWS31nLz9sRs;
        Thu,  6 Apr 2023 19:33:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1680802420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mHTTg8gm9X7ACV+NiC4d1fZveFjBa1unkjpNfHPwNFc=;
        b=PfE+m9TwKc6nBad7D5ipq8j1H7DC8kgkLZfpCiOCo3WsmNmgtBWQCX4xEAYuv/hURuReAL
        58LqaAmJFwLDnFiAuWDGJeftgh9GioVdJRbM8FXdhlIWY3MSFPdkvUTSCL+GPjhiR+zx9j
        cDgMfXv1biFgjax8ygJ8anvtL8v0pQIKy8/qOuZvcE3NF4HYxbWsizYMUjYAr+KBcjF7+A
        ylUSNSkdppNT9kioKmzrqhDdJhETyUraHHFks9ZgNPgspCO4nsUMcKLP6R6wz57eRNoGwM
        EFTt7Hok+GuvqWSUMtBF5vhQAm7zR+/AKLedXQwru4jp4O3CMc66uw+kNd0zOg==
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
Subject: [PATCH v5 3/5] arm64: dts: qcom: sdm845: add SLPI FastRPC support
Date:   Thu,  6 Apr 2023 19:31:46 +0200
Message-Id: <20230406173148.28309-4-me@dylanvanassche.be>
In-Reply-To: <20230406173148.28309-1-me@dylanvanassche.be>
References: <20230406173148.28309-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PspWS31nLz9sRs
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
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 338a715d110a..dc4b553cbe2e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,videocc-sdm845.h>
 #include <dt-bindings/dma/qcom-gpi.h>
+#include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sdm845.h>
@@ -878,6 +879,14 @@ mdata_mem: mpss-metadata {
 			size = <0 0x4000>;
 			no-map;
 		};
+
+		fastrpc_mem: fastrpc {
+			compatible = "shared-dma-pool";
+			alloc-ranges = <0x0 0x00000000 0x0 0xffffffff>;
+			alignment = <0x0 0x400000>;
+			size = <0x0 0x1000000>;
+			reusable;
+		};
 	};
 
 	adsp_pas: remoteproc-adsp {
@@ -3358,6 +3367,23 @@ glink-edge {
 				label = "dsps";
 				qcom,remote-pid = <3>;
 				mboxes = <&apss_shared 24>;
+
+				fastrpc {
+					compatible = "qcom,fastrpc";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+					label = "sdsp";
+					qcom,non-secure-domain;
+					qcom,vmids = <QCOM_SCM_VMID_HLOS QCOM_SCM_VMID_MSS_MSA
+						      QCOM_SCM_VMID_SSC_Q6 QCOM_SCM_VMID_ADSP_Q6>;
+					memory-region = <&fastrpc_mem>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					compute-cb@0 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <0>;
+					};
+				};
 			};
 		};
 
-- 
2.39.2

