Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C038D6D0BF3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjC3QyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjC3Qxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:53:53 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2F4EB6C;
        Thu, 30 Mar 2023 09:53:42 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4PnTyW117gz9sxt;
        Thu, 30 Mar 2023 18:53:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1680195219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DJMlDYTEyZMoHy7ddCUlUChH74G+JU2iSWGTmKQqo+M=;
        b=N70FlUmkzpGdLtb4sCzInMwZ+3Pn2B146YXQhW7SEuX7b8D4ht6UU0q84/RcRalDAy4zkf
        +i30rIDZX5FgXlc5X0fU5z3wOdov5BYY2hAGxnOw1Xhh8LMZlE3Qd2kdG6nPddR9/VG0UZ
        qnN40geJACXNrzSdQmmfDfAfO3dIEiXUd9BIBseZnz41SPZM3fnwygxkXRrfTije7lPDWU
        87a9kqyXGIOXWnXVUAjAEXROXZcO5FkO55uxUdOxQpPa6t764K970WDIAvOqnJUCgGlXlJ
        dSKdqGvXnVLjrwPP+tvWYNwrVz4ELw/51+DjqU04X/Kum4eimMN9OTJcGHZmRg==
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
Subject: [PATCH v3 2/4] dts: arm64: qcom: sdm845: add SLPI FastRPC support
Date:   Thu, 30 Mar 2023 18:53:20 +0200
Message-Id: <20230330165322.118279-3-me@dylanvanassche.be>
In-Reply-To: <20230330165322.118279-1-me@dylanvanassche.be>
References: <20230330165322.118279-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PnTyW117gz9sxt
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
index 3b547cb7aeb8..8ea4944f3ad6 100644
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

