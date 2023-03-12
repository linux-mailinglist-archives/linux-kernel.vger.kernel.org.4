Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8056E6B6430
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 10:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCLJdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 05:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCLJdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 05:33:15 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C28A20D0A;
        Sun, 12 Mar 2023 01:33:12 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id f14so3876074iow.5;
        Sun, 12 Mar 2023 01:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678613592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNRgd4NTRjQ+aLNKYtGdatvuO6DMSMslESmreJpN/xA=;
        b=qCbaq/WcCmVahRzTAmUrFXZfJ3PmeYye5Sd68iOPO77W2OayBObwQ2lf7/gdgcU+kJ
         XPGT3Jv97B94LG5WOrVkQai9B262VmL9+obxyHwkRmZQ1j43xSXjQk3KjO20LnA8PCrd
         xrhIhO6I+jor4tqKt4NqI3vs7ktMcvO0MO10dJAFCqLvwt3ER+VnMO8dH/y9O31UtHHr
         2tcWBV/Heqpm8242URpZTYRtfVmb9KGQxXIiyWoQ2Wv3xPfE2wPn+wjf6kgfKqcxSl1t
         qQncei1n7QdiJ549iYb7PesqrRlHCSVtb2twLJbkHq0y01nacukfm6nTazSEqixf3S/V
         MzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678613592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNRgd4NTRjQ+aLNKYtGdatvuO6DMSMslESmreJpN/xA=;
        b=insE/uwHOtlmJqLxSHXse3/lwEhAUnDcC/BK3luIAGn8Ix0ZCjJeG0tQiCqHqQaju4
         5KWJzOLERZKdgNgN39b8wsjcfQ4BsPHVK1P0v5/Po9gcDQgbcmVlnkEb8qUmM6CePkyj
         ryNgkuEObrnXX3THjO78piWoYOMT9kUQf/T4gkRhgepg3RBiZvOBRYt5doNrpAmVsdf1
         u25tP6Q1uEw91Y6Lu9TBXTILNkTszVXLR9dgHFoZuRZsWhdnQD9aMD81gXIHaEgka0Ht
         x1/rzHg36k2z1LSWmJaMXKiI/2pfNaI9GWaCiGAqA0rr7Wp4frHQaxetVlhApcSFtzD5
         VuqQ==
X-Gm-Message-State: AO0yUKU9o5EBNQVMmyWdlm1c/E+dBnflKgxhuFUTc+u7iyENM3K9G9nM
        /t4EqsiKZKqYnjM/J0A7b/M=
X-Google-Smtp-Source: AK7set8TT0yyqhpAPCnFp0XWp90qr0x8qc+KBNMbptwHFW5zfgGaJMZHgEClrjS4Zj0bT52FjvmnJg==
X-Received: by 2002:a6b:dd04:0:b0:74c:c1ba:91fa with SMTP id f4-20020a6bdd04000000b0074cc1ba91famr4781768ioc.0.1678613592292;
        Sun, 12 Mar 2023 01:33:12 -0800 (PST)
Received: from JOEL-DESKTOP.. ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id r7-20020a6bfc07000000b00716eb44b97esm1585031ioh.27.2023.03.12.01.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 01:33:12 -0800 (PST)
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
Subject: [PATCH 3/5] arm64: dts: qcom: sdm845-xiaomi-beryllium-common: add touchscreen related nodes
Date:   Sun, 12 Mar 2023 04:32:47 -0500
Message-Id: <20230312093249.1846993-4-joelselvaraj.oss@gmail.com>
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

Enable qupv3_id_1 and gpi_dma1 as they are required for configuring
touchscreen. Also add pinctrl configurations needed for touchscreen.
These are common for both the tianma and ebbg touchscreen variant.
In the subsequent patch, we will initially enable support for the focaltech
touchscreen used in the EBBG variant. This is done in preparation for that.

Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
---
 .../qcom/sdm845-xiaomi-beryllium-common.dtsi  | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index e0fda4d754fe..ecfd85bde966 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -270,6 +270,10 @@ &gmu {
 	status = "okay";
 };
 
+&gpi_dma1 {
+	status = "okay";
+};
+
 &gpu {
 	status = "okay";
 
@@ -368,6 +372,10 @@ &qupv3_id_0 {
 	status = "okay";
 };
 
+&qupv3_id_1 {
+	status = "okay";
+};
+
 &sdhc_2 {
 	status = "okay";
 
@@ -473,6 +481,37 @@ sdc2_card_det_n: sd-card-det-n-state {
 		function = "gpio";
 		bias-pull-up;
 	};
+
+	ts_int_default: ts-int-default-state {
+		pins = "gpio31";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-pull-down;
+		input-enable;
+	};
+
+	ts_reset_default: ts-reset-default-state {
+		pins = "gpio32";
+		function = "gpio";
+		drive-strength = <16>;
+		output-high;
+	};
+
+	ts_int_sleep: ts-int-sleep-state {
+		pins = "gpio31";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+		input-enable;
+	};
+
+	ts_reset_sleep: ts-reset-sleep-state {
+		pins = "gpio32";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
 };
 
 &uart6 {
-- 
2.39.2

