Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325B7687EA8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjBBNZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjBBNZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:25:28 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC398F505
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 05:25:26 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so1410984wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 05:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jGFMCiguKGryaoAn0SNvBKZYZzpMv/Cxo3gmJXUAvU=;
        b=Q0nGlU4S0bSD/UX4rTKb0p3wqKbKyOL4iLlxMVELuyssyKPJHxIbINv7y0uqF87lEi
         ZyQASXlWFZuZ2n84IxePO1euYw1wLVE/lXlwdVTsqG21EHOgqEwmIX2E6GXgQ6wveN93
         NjLcaDBGVVe7HqYhnvMi1DH1taEOx4BfOWfVkPNldkNZSe3qGtKiaP+KeDzYLOTCZrRL
         k5O3W/iLXtsMYpow+OLbnzOxQwtpklkuiNE9iJEsnn9o03eIAbIlcaJa3tpMDFN03KTL
         s7ds8Zl3KBQwvFp/XtN7wGvwCVsG2dmoaTDq9V3fAReRa65QCE+qZDZ02qsvVJU19IuN
         8PCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jGFMCiguKGryaoAn0SNvBKZYZzpMv/Cxo3gmJXUAvU=;
        b=bDczJDbp1ostJ2zAtMRxiCAw//MNhWbkWnf8K/Lo0L8jN7MsrmBWdwIGpkFXYlZF3Q
         8Ns2YHTroY7GXImnjr7CDsJ3Sw5SMUTNvBDOZIc1Rz3H0NGyMvaBmUlNWO7nQ2k2Ofn7
         +l5u7yWVJNKmrIa7PdkJ9uXKQsUN2oa4zb+RDTcRqONO8F/UysTes44RWakmWIwAc8sN
         4hMfj1aLWftFJfeJTVD05PfEbtBJHB8rPIWW0xFXMEhFGX10un4OPWi71UWKSpSrbjO/
         /jy6GmTORht1Y5IulmumfgI0RnKB9v0v8ww0DgQV1++001NF+WUe0YDnI3jtT/iI6HtH
         iomA==
X-Gm-Message-State: AO0yUKWOZRL+U6vV96/K1aC6K58Qkrce9LmdUfIuvv3rp3otMm0D/muE
        zi4vnsc/JQbzxdTOt5MB9FwMFjtQ1udFco7b
X-Google-Smtp-Source: AK7set+UvAdQxq6+cg3WB7Mq/FbFIglThwiAUTflItZHlhvvfJIZFKQpUXyUhtVmRy7ECmM65o0qCw==
X-Received: by 2002:a05:600c:5113:b0:3d0:761b:f86 with SMTP id o19-20020a05600c511300b003d0761b0f86mr6077028wms.28.1675344324570;
        Thu, 02 Feb 2023 05:25:24 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id e22-20020a05600c449600b003db06224953sm4690943wmo.41.2023.02.02.05.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 05:25:24 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 8/8] arm64: dts: qcom: sm8550-mtp: Add USB PHYs and HC nodes
Date:   Thu,  2 Feb 2023 15:25:11 +0200
Message-Id: <20230202132511.3983095-9-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202132511.3983095-1-abel.vesa@linaro.org>
References: <20230202132511.3983095-1-abel.vesa@linaro.org>
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

Enable USB HC and PHYs nodes on SM8550 MTP board.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v3:
 * none

Changes since v2:
 * none

NOTE: This patch has been already merged. It is here only to provide
context for the rest of the patchset. There is a change with respect to
the clocks, but that will be sent as a separate/individual fix patch.

 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 265862d0e44f..03862132fe41 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -550,6 +550,28 @@ &ufs_mem_phy {
 	status = "okay";
 };
 
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "peripheral";
+};
+
+&usb_1_hsphy {
+	vdd-supply = <&vreg_l1e_0p88>;
+	vdda12-supply = <&vreg_l3e_1p2>;
+
+	status = "okay";
+};
+
+&usb_dp_qmpphy {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l3f_0p91>;
+
+	status = "okay";
+};
+
 &xo_board {
 	clock-frequency = <76800000>;
 };
-- 
2.34.1

