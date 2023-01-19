Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4B7672DA6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 01:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjASAqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 19:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjASAp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 19:45:56 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916CC5EF9B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 16:45:47 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so170071wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 16:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYPo2FbkiHdzbtMewybrOKTKwlH2GhbuDdA9lAKrTQ4=;
        b=nA6KpyGkMPz1cujrE0wpDXMx60aI3SyHAJRBmL8Sz/OnfBUyeFdM67bXhXIJ/FoQOZ
         As65JD0s0B3WhWYVQcLVYsy+mtzhI6McTxMvByB7qMhCTvstfWxlc1MYRjgQatfWymyt
         oMChIvbxMGXfs6r7RHZvhXKKoerX6xJg5+jAQQb/YUn25dEX/BJP56lbXFdyu2mzBKaC
         Bw5gqhn7o09eSCSWEZWAAxFPsPjusKw3bWxtX9lUuivX7aFwsV2cVby5oDrBQQz3grJv
         UmibH03/r1GZTsRa1AokP7lASgNPuUf9Ud7DsMnU/WGFFpsw7vCc0XlM02Np/xH7QTfL
         tlxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYPo2FbkiHdzbtMewybrOKTKwlH2GhbuDdA9lAKrTQ4=;
        b=cf8RmDsk+O/S+lHtSRxVlu4NsENSScPuK1pnD+L7+DoufStuXt43duNvhBVchPchrH
         3+Oh/aXLPrpQ55mQehsqZSrik1akO9SKd3prLrZDbrABgm+lmmBz4xrO1Yt82MRLM+PH
         9ShzVYxdCKTJos6FjW6Z/FEuVvM5DEGFAtzIt3xomtxpdtnhlO0UKJ4SN+db3NVBnXaR
         WYEl2FUM1Zbb7wmMc+fZL8KrNZhQRVYivtpgpalYVw4lnEBbj7MCUWY6w55xUjScW28U
         tUrmT2ejJF5kycwoRYHr3gyH9goeF+bP/egeOXgAqhFmrx8AT8YrGJkX2DrJyoP4Kdvw
         O74Q==
X-Gm-Message-State: AFqh2kra1xAqiuCxoKBg0WK9QwQaB/jHMFf6U0Hf2s/XZvGE5hTicGAM
        dJKQ5VrVIOHLNsk45r8hTM7/zQ==
X-Google-Smtp-Source: AMrXdXsvEPUJSj6iWYfWLqwUtbUU4tKRhMysWUUWqKU7EwR2GvIvxK0ihLJ3dGZE1PZVifyXl033SQ==
X-Received: by 2002:a05:600c:4f92:b0:3cf:88c3:d008 with SMTP id n18-20020a05600c4f9200b003cf88c3d008mr16961492wmq.28.1674089146169;
        Wed, 18 Jan 2023 16:45:46 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c3b1000b003dafadd2f77sm3870491wms.1.2023.01.18.16.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 16:45:45 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] arm64: dts: qcom: sm8550-mtp: Add USB PHYs and HC nodes
Date:   Thu, 19 Jan 2023 02:45:33 +0200
Message-Id: <20230119004533.1869870-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230119004533.1869870-1-abel.vesa@linaro.org>
References: <20230119004533.1869870-1-abel.vesa@linaro.org>
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

Enable USB HC and PHYs nodes on SM8550 MTP board.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index b69ded9c4b57..219001473f79 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -447,6 +447,28 @@ &ufs_mem_phy {
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

