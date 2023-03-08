Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BAE6B04CD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjCHKkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjCHKkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:40:20 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4A39C9AA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:40:19 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id t25-20020a1c7719000000b003eb052cc5ccso932864wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678272018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8KzYFaNC31XGy3z1a5fC/b9IAo0DBq/FXy8tjU946A=;
        b=iEiNPFrVRZgp6UeK76MKsr4LSlEfNy+RDadnfmcA0hqvRgWu/rRNg7FyLmAwMNtDvX
         W/Ktb3jSec+QnE25SRijY1oGalG4fY3Prlwv3iePD5GZOtfW3SeC43LOyEZn4fTaq1JH
         /xzfI4trKN8UMQ4kzTKuJAkP6Ne+CE/Wk2xZgOagJ/EVAuhX03HXIfx2sCll6ADWN+qQ
         v+BPeMqPp/jVnAGtS8JN6l2iTCzxv2p0MTJE3ndBQ+cvFNTMyvlxxLnC8WtIwUYF0ehy
         x/lLfnMUG7n2cwrtlcoKq8ozLX8d2D+wewDk8kE/iFLk9w0sLmO72EDnRyL2e5+t2qC1
         2HfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678272018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8KzYFaNC31XGy3z1a5fC/b9IAo0DBq/FXy8tjU946A=;
        b=pPiEuRu9kpcGauZgXSyvct26Y96vCTAkIEQ08PIAGZ//kZRl28Fh6FM751Wz78v+qB
         7sj8Vep2A/c8ffehwPVQmF0DM/mLlYmrEFQcgw1UHqEAjns3fP5UUqhSafYDNvxQY2VU
         JTaJC/osuO8MLbr9Ze9u1IeKqlvoAiBbrFe0YtnWXnfyuAM4fTrkmLsjnx8Mh9CoYsMM
         +39svhsmjMmcYpR6dqgJV+Os8aWE7U8uPgErvH7xVs/rvGMMU1UK7LMjdtLRAvFNa5BA
         FvnW+vfHBfZwmEW44lBVt6oKOxp2gwRfwb5lHA+H7V5PnK0P8ABp+67sINhpIk0GJfdF
         qopw==
X-Gm-Message-State: AO0yUKWm6eyiDUZIMA42hdWqOPfaLFFNDRxcoOkh+oFsm0DBraNAkUAL
        xAMtZhS+YaV0AbgES4/usp1DwA==
X-Google-Smtp-Source: AK7set8JlMSJJAkZIH01wjnaoBY+0ByHFrbLviRcPTx3bd4/mTymDWbmGcSXlkT6ZbdDyEOn+b2izQ==
X-Received: by 2002:a05:600c:1908:b0:3eb:39c3:8844 with SMTP id j8-20020a05600c190800b003eb39c38844mr16229922wmq.12.1678272017760;
        Wed, 08 Mar 2023 02:40:17 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2326:fd4c:82e3:7e07])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c444700b003eb0d6f48f3sm20664135wmn.27.2023.03.08.02.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 02:40:17 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 4/9] arm64: dts: qcom: sa8775p-ride: enable i2c18
Date:   Wed,  8 Mar 2023 11:40:04 +0100
Message-Id: <20230308104009.260451-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230308104009.260451-1-brgl@bgdev.pl>
References: <20230308104009.260451-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This enables the I2C interface on the sa8775p-ride development board.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index a538bb79c04a..5fdce8279537 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -13,6 +13,7 @@ / {
 
 	aliases {
 		serial0 = &uart10;
+		i2c18 = &i2c18;
 	};
 
 	chosen {
@@ -20,6 +21,13 @@ chosen {
 	};
 };
 
+&i2c18 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&qup_i2c18_default>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
@@ -37,6 +45,13 @@ qup_uart10_default: qup-uart10-state {
 		pins = "gpio46", "gpio47";
 		function = "qup1_se3";
 	};
+
+	qup_i2c18_default: qup-i2c18-state {
+		pins = "gpio95", "gpio96";
+		function = "qup2_se4";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
 };
 
 &uart10 {
-- 
2.37.2

