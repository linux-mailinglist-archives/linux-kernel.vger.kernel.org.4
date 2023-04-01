Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A206F6D32E1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 19:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjDARft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 13:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDARfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 13:35:44 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050:0:465::102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C82B443;
        Sat,  1 Apr 2023 10:35:42 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Ppkp32z4Dz9sdM;
        Sat,  1 Apr 2023 19:35:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1680370539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=89+6K5+dVh1rTgHK8yIcdKeIjnxl4WNbv71lKIaqsj0=;
        b=pEh8pqHcDFh18aR1HJrl4bhFuJmxk60BiaRkdRqduKqBbdoiuX01KlT44t65eEJuZE37m9
        gWBLmMZDO5VjRhNRGrQJlj+djddQP7VWE0iYigKFRSPY53rF43rl8tCFo32jb58dePwWQu
        3j2qQm6GKRj2l0lHFViaWtoy9KdzJeOr5fMnqjcVqmXUxsclctZoUZQRVfdAQ3La8MBUtD
        KBvpTi8kGISeaB2dFwcUSamwgkzq/bHTGTRriAb53u3V6NvGP+1xEOjDK1mXQnKfThB773
        6l2jiWP8p38u33ivO+pnJR+zV4MHknvo15QNObjA/pOl9qwbRH3KU1wnipWluA==
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
Subject: [PATCH v4 2/6] dts: arm64: qcom: sdm845: add SLPI FastRPC support
Date:   Sat,  1 Apr 2023 19:35:19 +0200
Message-Id: <20230401173523.15244-3-me@dylanvanassche.be>
In-Reply-To: <20230401173523.15244-1-me@dylanvanassche.be>
References: <20230401173523.15244-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 338a715d110a..1f25a7f4e02b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -878,6 +878,14 @@ mdata_mem: mpss-metadata {
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
@@ -3358,6 +3366,22 @@ glink-edge {
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

