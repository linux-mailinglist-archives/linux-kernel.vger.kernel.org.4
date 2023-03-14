Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9546B9E86
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjCNSbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjCNSbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:31:12 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EC74D2B1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:31:02 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m18-20020a05600c3b1200b003ed2a3d635eso3099050wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678818660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8nHWyzUWcNj5TqUmFIPsDI0BuBBPY0f4zCvTASv7fA=;
        b=DaEQJEwR30p7XMMxEdDxMWvcOsfbSnFt0B0M+znt0v1EulXSk9WQGZlMXJx0BmyRiw
         xm8BWMQ6cP0bBFl4cUmaq7MAOgB34+AB8T6yxhvcBipg9tuKR4wnXBZ8rE9RXt3abjt7
         KBXhoLMjcSU33h07HHP8HkOFKNn9LcwuW56fhuzMZ1mkivWjflCAyx7Mrcl7OCTaCn0s
         J+MI07uUYB4Fiu0qB+Olo0K7lOuYYg+wVLnoQcqwvhIlSYr7hCezeGfJLRq1DPGzTXZn
         9VTaf7xdTx+1MaqKOge9T1pKKi5xX9ECPno/XcCSL8H91b+WotVvXwI3yCylHcXdKaNd
         9S+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678818660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8nHWyzUWcNj5TqUmFIPsDI0BuBBPY0f4zCvTASv7fA=;
        b=zG5RulbEVewwE/REcnCQZaGWCk2Ni+IMPwJInEB9fypWESqbV1jFSuzcexWXb6gbcf
         z+CTyS7odnO9yCOt7hfVPA1MiC9UbIC6mdqFOi/869E7bs1qCjZS0/9biDW9jE1u/Ve9
         sAK81wvObC/WmylIgDPwGYAx1vrwOykf0chkacYl0KN3QPX4YEYuia05F07y0E6tpOPy
         cddeW5X4Js2C2q2AUz3qJnSJn2erbbtU2KmT5z1q0dwgxXft2UDQS61CUddDUAlc4bEr
         5YQqXd1yd5gXSfbj7ZISdqchJigDUmeKuCxhwnM3kBqa6ygsrjy5UyKggmNtMTJccn1I
         rXZA==
X-Gm-Message-State: AO0yUKVHwkzI2lIbOMgQ59rWUK0Pzimd0cZaU8Ss1pbnN7Zyzo+8q53Q
        h+V/3Xkx5ef95z305QEq7/EuZw==
X-Google-Smtp-Source: AK7set8yLUZp61bF9a/A9A1CuUZehWQDsoqDetDxnDjscJjrxYdgo5bVd3wClgVQWgRxpH75eXD0rQ==
X-Received: by 2002:a05:600c:5492:b0:3db:8de:6993 with SMTP id iv18-20020a05600c549200b003db08de6993mr11996731wmb.4.1678818660433;
        Tue, 14 Mar 2023 11:31:00 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:fd14:bd52:b53b:d94c])
        by smtp.gmail.com with ESMTPSA id k28-20020a05600c1c9c00b003e209b45f6bsm4083938wms.29.2023.03.14.11.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:31:00 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 07/14] arm64: dts: qcom: sa8775p: add the Power On device node
Date:   Tue, 14 Mar 2023 19:30:36 +0100
Message-Id: <20230314183043.619997-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314183043.619997-1-brgl@bgdev.pl>
References: <20230314183043.619997-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the PON node to PMIC #0 for sa8775p platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
index 77e2515a7ab9..5d73212fbd16 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
@@ -12,6 +12,13 @@ pmk8775_0: pmic@0 {
 		reg = <0x0 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+		pmk8775_0_pon: pon@1200 {
+			compatible = "qcom,pmk8350-pon";
+			reg = <0x1200>, <0x800>;
+			mode-recovery = <0x1>;
+			mode-bootloader = <0x2>;
+		};
 	};
 
 	pmk8775_1: pmic@2 {
-- 
2.37.2

