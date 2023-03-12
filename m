Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF786B6435
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 10:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjCLJdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 05:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjCLJdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 05:33:17 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823CD211CD;
        Sun, 12 Mar 2023 01:33:16 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id e11so3881689ioe.3;
        Sun, 12 Mar 2023 01:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678613596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ss/4BRGrhm6+FoNff3JQmV9CH0Y2l6VI22WyegkG0eE=;
        b=ebv5CX9haG7RLtisEs27/Xrng5w3rG6DoCW5mU9VpNzRiFv/SuITns6TzNO3JzQXFZ
         vXxfIWd9/AOKCh9coIgP46OexCKUXgzJHXxD8JCrp6whNoM5LwJDsodtrag7bxZmSJHh
         rn38giC5cHBvgfvqfNHc6+brfAmTIA4o0HZX+7Wmrir4iBcoKv8R4MdxATWE8/Pj58QH
         zE6VXgjkVbuvJFF1wBxXGckk29UHBvWzD+dEAHwmtndlYHeba7O3XXKCkeg4E5VjRYEo
         oI7OUKsnwAwxxPQ/VKrnOPpfZznz47o90afU9o69z++ayMjyklufxnraVC5mWTRIJ/ba
         8xYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678613596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ss/4BRGrhm6+FoNff3JQmV9CH0Y2l6VI22WyegkG0eE=;
        b=05eIXodnpTgmfqrJzCeVMzcX+LfilauTGtPJPmmmz3l+Qq/rsQTiBP+H1Ka9noZh4s
         mQ6qFCE5+d/ri9tPFAPf1GwNGOSvszWXr0oTE9plBmoNMeRzSN3ryLpNEs6DxTMUzhD6
         dAJvuvwgIIifsuPYtwaBTrcd1nlsUMmd6RDc/ECEuBxQg3023OICCscOu9NDiuoL8DAw
         wzN2M0aqr7TaU2mSsOha0Epq5KmvUZeYz4HOLbkGuzJDAXaG4KOCeb1knnCgr2XiXpW+
         tjbUXlCKjiNDADlZnOi2GYeZvuxiMzBAHHGAxkHoiybwPIP8Eva6KLEXKTVX14bjfE5T
         7Qjg==
X-Gm-Message-State: AO0yUKXJJpyftUpq8LX54U/6lWyUhwaRbaSGAH0X8kyCxRDTZcXXWhD9
        V8X4SvL54/39lD3SzI33iEg=
X-Google-Smtp-Source: AK7set/rlcOKqPPt3Z9gxDhI4N5FB4sRLhNgYXXTmad6vj1teuCZEyBqpON4PEz6lNDvA2upu/tPTQ==
X-Received: by 2002:a6b:b40c:0:b0:74c:83ab:280c with SMTP id d12-20020a6bb40c000000b0074c83ab280cmr4490252iof.1.1678613596151;
        Sun, 12 Mar 2023 01:33:16 -0800 (PST)
Received: from JOEL-DESKTOP.. ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id r7-20020a6bfc07000000b00716eb44b97esm1585031ioh.27.2023.03.12.01.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 01:33:15 -0800 (PST)
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
To:     Caleb Connolly <caleb@connolly.tech>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jeff LaBundy <jeff@labundy.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Markuss Broks <markuss.broks@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Chris Morgan <macromorgan@hotmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Subject: [PATCH 5/5] arm64: dts: qcom: sdm845-shift-axolotl: update focaltech touchscreen properties
Date:   Sun, 12 Mar 2023 04:32:49 -0500
Message-Id: <20230312093249.1846993-6-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312093249.1846993-1-joelselvaraj.oss@gmail.com>
References: <20230312093249.1846993-1-joelselvaraj.oss@gmail.com>
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

The touchscreen nodes were added before the driver patches were merged.
Update the focaltech touchscreen properties to match with the upstreamed
focaltech driver. Also, the touchscreen used is in axolotl is fts5452
and not fts8719.

Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
---
 .../boot/dts/qcom/sdm845-shift-axolotl.dts      | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index b54e304abf71..39f59ee3612a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -473,21 +473,22 @@ zap-shader {
 &i2c5 {
 	status = "okay";
 
-	touchscreen@38 {
-		compatible = "focaltech,fts8719";
+	touchscreen: focaltech@38 {
+		compatible = "focaltech,fts5452";
 		reg = <0x38>;
-		wakeup-source;
+
 		interrupt-parent = <&tlmm>;
-		interrupts = <125 0x2>;
-		vdd-supply = <&vreg_l28a_3p0>;
-		vcc-i2c-supply = <&vreg_l14a_1p88>;
+		interrupts = <125 IRQ_TYPE_EDGE_FALLING>;
+
+		avdd-supply = <&vreg_l28a_3p0>;
+		vddio-supply = <&vreg_l14a_1p88>;
 
 		pinctrl-names = "default", "suspend";
 		pinctrl-0 = <&ts_int_active &ts_reset_active>;
 		pinctrl-1 = <&ts_int_suspend &ts_reset_suspend>;
 
-		reset-gpio = <&tlmm 99 GPIO_ACTIVE_HIGH>;
-		irq-gpio = <&tlmm 125 GPIO_TRANSITORY>;
+		reset-gpios = <&tlmm 99 GPIO_ACTIVE_LOW>;
+
 		touchscreen-size-x = <1080>;
 		touchscreen-size-y = <2160>;
 		focaltech,max-touch-number = <5>;
-- 
2.39.2

