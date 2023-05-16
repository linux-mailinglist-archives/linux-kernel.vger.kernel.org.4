Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341DE70518F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjEPPGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbjEPPF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:05:59 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6874B8695
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:05:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-24df6bbf765so12122459a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684249540; x=1686841540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5pQrJTTCZJZZKPmjIiq+X+xkUImdFCCiZ3e7a6lOiY=;
        b=oxlwFFM7VIT+474vSuBUObLQisjQgPiVCBd3d1Lc8P7hsUaQufiN6YBpCF59zh1OPC
         eXm21kGgGlB6gDcfen1BgHo4X6ZRXPdRicMufbqPvp+/aR4uNB95YWVLj8jDGN3NmHE4
         FVQgQF7bt2BjVTHy+SFlTR58SXkA5iSb+eGXPfw5ADeQoDTHL9wms1BpebNMRi5tyRAK
         cvLdaf5rYYEjOKEOoC5snAdDCmLpF1/1H+iEJdV/QoxBD2F3vpoJzS+1BGK4b36zzfxO
         yEHquA3Ii5AtonZKrBpP9Wvi2qEsGKO8Tg1nWMFlLT0hy34Xv77+3s5md4vnbejWic7d
         P6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684249540; x=1686841540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5pQrJTTCZJZZKPmjIiq+X+xkUImdFCCiZ3e7a6lOiY=;
        b=INmipsijCrtdcOipZ/dpSKj6sFCR9ON6KjmHEgpcBYLN9GPaSmAqXG8jIjS2HqYBnK
         gehWk8GFGgGcb0aPelUfj667gX+MNJCWXqCVgriEATNs7OJL0fFfhER2htVJzPdiSe5G
         Y3UiPHKYzyovdcH2ocTh6QEZyO+0+k31CQPkb0p9I6FmeePRMyQFpSJdFK2fdwDqEdNu
         qAk5GHWR+X8PLkkGE/JYCHTWPBILipOuakL9CMFYNOM7L7UZPXrvJsWxh3WQe3K2qst1
         CikBTi7w4AouZ5vth8xQjH7y222LBWZTZRxf3BV8DRn90YkzABPL/DFiV2qbDvLM52IN
         H+nQ==
X-Gm-Message-State: AC+VfDzLyhGmgyA5vKvZG6FMpqcX0z63iqHF/2EPhtlItGOlmMJc1CZ1
        zuV/P/eGRc4rxSPH7NT7+8z/0A==
X-Google-Smtp-Source: ACHHUZ5sKmRFAHk2jFlMiCRrqV1LTt9359wEdaXN6/H3PTTMT3eTGunY7ExJe3vYW5BPMebYidx0fw==
X-Received: by 2002:a17:90a:9307:b0:24d:ef6a:dd0a with SMTP id p7-20020a17090a930700b0024def6add0amr35974432pjo.5.1684249540547;
        Tue, 16 May 2023 08:05:40 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:6bed:72cf:f5c9:ba94:6b85])
        by smtp.gmail.com with ESMTPSA id h1-20020a654801000000b005302682a668sm12817164pgs.17.2023.05.16.08.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 08:05:40 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org, kishon@kernel.org,
        vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dmitry.baryshkov@linaro.org
Subject: [PATCH v11 4/4] arm64: dts: qcom: qrb4210-rb2: Enable USB node
Date:   Tue, 16 May 2023 20:35:11 +0530
Message-Id: <20230516150511.2346357-5-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230516150511.2346357-1-bhupesh.sharma@linaro.org>
References: <20230516150511.2346357-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the USB controller and HS/SS PHYs on qrb4210-rb2 board.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index dc80f0bca767..eae3024ce003 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -222,6 +222,30 @@ &uart4 {
 	status = "okay";
 };
 
+&usb {
+	status = "okay";
+};
+
+&usb_dwc3 {
+	maximum-speed = "super-speed";
+	dr_mode = "peripheral";
+};
+
+&usb_hsphy {
+	vdd-supply = <&vreg_l4a_0p9>;
+	vdda-pll-supply = <&vreg_l12a_1p8>;
+	vdda-phy-dpdm-supply = <&vreg_l15a_3p128>;
+
+	status = "okay";
+};
+
+&usb_qmpphy {
+	vdda-phy-supply = <&vreg_l4a_0p9>;
+	vdda-pll-supply = <&vreg_l12a_1p8>;
+
+	status = "okay";
+};
+
 &xo_board {
 	clock-frequency = <19200000>;
 };
-- 
2.38.1

