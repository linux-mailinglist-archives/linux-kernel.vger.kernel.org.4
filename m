Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B9E6CADD4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjC0Sso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjC0Ssg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:48:36 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0717B173C;
        Mon, 27 Mar 2023 11:48:34 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4PlhfR2gpbz9slF;
        Mon, 27 Mar 2023 20:48:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1679942911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EIxYTRkWdFJzwZh6BFhtloQnwXCEz34/zKyQod3D784=;
        b=NqZ9lQCzcg1y1zaoCxrDmE28FPiQ6vPVZ9Lvtevm6SnCn1P7xdwNmRKuUmpYQxf4v6SqGU
        2IrpXjaHyYr0DTN2SEKuJ6WRZibBowy7QwTQGfCfytiw33U+/JX0XJKk6N1EeKMkho9VTS
        y0oHEB+6DfbJ5hOs/odorGBDTXDIkbW945egaedihmusjwrkI2zp1dlDAmofDlnr0RHNwi
        9n9+i3ok3l8RLdcbN/kcblWoNz9Jft8gnqg8Vf+nqb310uL9U4ZmWeLiqnOE3WsTnTy9PW
        mDMWZ3Z1+YvDcjnRnF7y34+YYqDIeLIBbfELcflirMjZn4nDNlZA5W8/Ud+5ZQ==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH v2 3/5] dts: arm64: qcom: sdm845: add SLPI FastRPC support
Date:   Mon, 27 Mar 2023 20:48:09 +0200
Message-Id: <20230327184811.499553-4-me@dylanvanassche.be>
In-Reply-To: <20230327184811.499553-1-me@dylanvanassche.be>
References: <20230327184811.499553-1-me@dylanvanassche.be>
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
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 3b547cb7aeb8..7412ea938765 100644
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
@@ -3344,6 +3352,21 @@ glink-edge {
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
+					compute-cb {
+						compatible = "qcom,fastrpc-compute-cb";
+					};
+				};
 			};
 		};
 
-- 
2.39.2

