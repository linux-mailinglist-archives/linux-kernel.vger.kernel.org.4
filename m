Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3135639BE2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 18:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiK0RJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 12:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiK0RJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 12:09:23 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E04DFC8;
        Sun, 27 Nov 2022 09:09:21 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id b12so13493390wrn.2;
        Sun, 27 Nov 2022 09:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuxgIdp0xqTuRzzoLY4mlfDBUIEbIXvI9sh1okauOJY=;
        b=pWIVrtE+bZyK95xZII6HnM1QCqdBwq+IIG8jf0RMxy9mIlPtKE2E26sGU86z8OWZTK
         A27ibDJKYn3VrYLJ12uLLTyujcIaOmWRxhe/AmW60EQmPi9dDEhpT97dblIR70xmp4pn
         L5D7+iIl2VI+BS/a1BmOAXiWPzkxlKfuvvBrI9wN9hO3NzatGcLeFAmL4z8xuNBsKhpz
         V08pHbFLUPS7fRY/oCGRf8jlvaVusCUcGWebidmdyui3zfgBK5GoJR3V5wLtr5N+vJzY
         8i3U0bhY6NyoZuvq8Q0RnHE611BpbcspaXR6TiZAM3NrpV6Fd2nxuEKjrMo5lsMbhdTT
         s6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuxgIdp0xqTuRzzoLY4mlfDBUIEbIXvI9sh1okauOJY=;
        b=XSRkoZqWJrIsxGgFDlic1wCt+10lS3e2Y5Dj6SSFm8SpZqVI/lryrJoBV9KkX0iIC0
         V5ybW7MEGbdfOX1pfuRosUXKAm0eWmDaZy3z2KyrT9RYkDzYRE6BXtAKoswFw8AGDO4n
         +atbzWyv1WuAD3nAXlUoPLbYuDU53Mxa4V2Tn6MJ/GAKjMcoLNlZkNhicwHQTxBsmvsW
         j5Z/+WC1o6DnI9EboXhXb1DgY91nm1NT5W/hXyHORnvUahUm2nk/zW2H1OXdbDe/iJNs
         ed5f1tc82ToRlmTYiwWFtQSzJ/5xW+AXXsuPD0CFny6UX+8DFqk+OqQD5n9lCYTPqeex
         l+Pg==
X-Gm-Message-State: ANoB5pmAAmRJtnwwCXIKBxoa9sdEyVmGDtxUixI0sq/CdzRSh8PW7nmf
        y0ISesUXKdxh8qOrXvKQfa9gQnra3JTDl6WKNJg=
X-Google-Smtp-Source: AA0mqf7+EiB7WO98d0txKip1y+2BqXjm3rTbhRGEd5/7rOcytRv8lxYyKcy8CxKK2672BJ5eyZLDIA==
X-Received: by 2002:a5d:4d8b:0:b0:241:bf7b:db5b with SMTP id b11-20020a5d4d8b000000b00241bf7bdb5bmr26740939wru.267.1669568960696;
        Sun, 27 Nov 2022 09:09:20 -0800 (PST)
Received: from david-ryuzu.fritz.box (ipbcc3aba7.dynamic.kabel-deutschland.de. [188.195.171.167])
        by smtp.googlemail.com with ESMTPSA id h17-20020a05600c315100b003cf483ee8e0sm17759967wmo.24.2022.11.27.09.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 09:09:20 -0800 (PST)
From:   David Wronek <davidwronek@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH 3/3] arm64: dts: qcom: sm8250-lenovo-j716f: Enable ADSP/CDSP/SLPI
Date:   Sun, 27 Nov 2022 18:08:58 +0100
Message-Id: <20221127170858.440040-4-davidwronek@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221127170858.440040-1-davidwronek@gmail.com>
References: <20221127170858.440040-1-davidwronek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabled the ADSP, CDSP and SLPI remoteprocs with a simple "okay".
Firmware needs to be provided by the Linux distribution, as it's signed
and needs to come from stock Android.

Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lenovo-j716f.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lenovo-j716f.dts b/arch/arm64/boot/dts/qcom/sm8250-lenovo-j716f.dts
index c493721ef664..33edeb6f3ef4 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lenovo-j716f.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lenovo-j716f.dts
@@ -76,6 +76,11 @@ vreg_s6c_0p88: smpc6-regulator {
 	};
 };
 
+&adsp {
+	status = "okay";
+	firmware-name = "qcom/sm8250/j716f/adsp.mbn";
+};
+
 &apps_rsc {
 	pm8150-rpmh-regulators {
 		compatible = "qcom,pm8150-rpmh-regulators";
@@ -434,6 +439,11 @@ vreg_l7f_1p8: ldo7 {
 	};
 };
 
+&cdsp {
+	status = "okay";
+	firmware-name = "qcom/sm8250/j716f/cdsp.mbn";
+};
+
 &gpi_dma0 {
 	status = "okay";
 };
@@ -515,6 +525,11 @@ &qupv3_id_2 {
 	status = "okay";
 };
 
+&slpi {
+	status = "okay";
+	firmware-name = "qcom/sm8250/j716f/slpi.mbn";
+};
+
 &tlmm {
 	gpio-reserved-ranges = <40 4>;
 };
-- 
2.38.1

