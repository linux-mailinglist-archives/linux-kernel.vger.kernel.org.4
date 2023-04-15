Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B87B6E2E72
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 04:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjDOCDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 22:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjDOCCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 22:02:43 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210DC83D3;
        Fri, 14 Apr 2023 19:02:42 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54f8b687a06so1581127b3.0;
        Fri, 14 Apr 2023 19:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681524161; x=1684116161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfFLYwoRbIcS+5n1zFSGq1E+iP2KHQOy5/Vbet45Gu4=;
        b=g/VYV2yqnH2eA0lEeYtVv85WVktmO9HxBMfNW7J4AQ16iR7EJE4Hi3vJTo7C/x7zMo
         usfA55rBiBVMwtJcRm8avc1L+Q6WT9Nc8Oe8AJN9zOmfH0hiIA8U+cCdS3ku4gHvVTTo
         WfpXhMQxgWrUwWEFVGhpEcirALG7LCfwniOKRzVc1TYlQOBPsoWaZnb66b1ZwvHSM5c6
         MtvkqICCDlYW4EXUSPZ58vwbUHP0O5kKYIX7GzAVdNG4hHxZRxss/9c3csUFgc/EshwH
         D5BljrSYJBTCk7SqDUyV1rzZ8THD+PVsn6SIDciGuKHwcYmQgnXjJuToVof8PUaEwD+z
         0kIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681524161; x=1684116161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfFLYwoRbIcS+5n1zFSGq1E+iP2KHQOy5/Vbet45Gu4=;
        b=beuyYd9Jifd8LXgEAUqMTJDChNHnVBXcr820W3SvstwgtjU0jTDdPfOqYQwHlTct1M
         kurnswYEvE/9HORrsVNxIhV8zAZhGSVttutsjdd6Rm/VfNnhwWm/UwV3gySGf19mlAQt
         fTldk853qSEvO0ltK6WuHKzkdNT8D71QU3JxgZTt9gc2TmQ+tLWvcO2dL63Pcd5us9DK
         z55lgvGBluoM25VmaYmmgO4oE81FNTHcm/1J1n0/8EZhg17lN8IDUlgak/DpcmAFaXK+
         8LqCQHSJE+Nl+pmOCZAgRym5JaDOhvMNmD4i+L7EAOhhzD8EpGZjAV0LW7b2MbrLFjjX
         6KmQ==
X-Gm-Message-State: AAQBX9e8CjOubDBj6bR/4hP02sMqBT3i3qEXdIGE4KchNdr+u/nsCTwf
        IHQ0F1xSePRK67yTxoDio/A=
X-Google-Smtp-Source: AKy350Z34NCtOeyDltAA+YqPY7xdtbn3jTq23ob5FORw1LL+hPAy4r721FNIfl2gkhYLEAIW28ad6Q==
X-Received: by 2002:a81:1252:0:b0:54f:dc9b:c994 with SMTP id 79-20020a811252000000b0054fdc9bc994mr3789942yws.1.1681524161272;
        Fri, 14 Apr 2023 19:02:41 -0700 (PDT)
Received: from JOEL-DESKTOP.. ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id 68-20020a810a47000000b00545a081847fsm1593607ywk.15.2023.04.14.19.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 19:02:41 -0700 (PDT)
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
        Markuss Broks <markuss.broks@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Subject: [PATCH v3 5/5] arm64: dts: qcom: sdm845-shift-axolotl: update focaltech touchscreen properties
Date:   Fri, 14 Apr 2023 21:02:22 -0500
Message-Id: <20230415020222.216232-6-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230415020222.216232-1-joelselvaraj.oss@gmail.com>
References: <20230415020222.216232-1-joelselvaraj.oss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 .../boot/dts/qcom/sdm845-shift-axolotl.dts     | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index b54e304abf71..70286e53e000 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -474,23 +474,21 @@ &i2c5 {
 	status = "okay";
 
 	touchscreen@38 {
-		compatible = "focaltech,fts8719";
+		compatible = "focaltech,fts5452";
 		reg = <0x38>;
-		wakeup-source;
-		interrupt-parent = <&tlmm>;
-		interrupts = <125 0x2>;
-		vdd-supply = <&vreg_l28a_3p0>;
-		vcc-i2c-supply = <&vreg_l14a_1p88>;
 
-		pinctrl-names = "default", "suspend";
+		interrupts-extended = <&tlmm 125 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&tlmm 99 GPIO_ACTIVE_LOW>;
+
+		avdd-supply = <&vreg_l28a_3p0>;
+		vddio-supply = <&vreg_l14a_1p88>;
+
 		pinctrl-0 = <&ts_int_active &ts_reset_active>;
 		pinctrl-1 = <&ts_int_suspend &ts_reset_suspend>;
+		pinctrl-names = "default", "suspend";
 
-		reset-gpio = <&tlmm 99 GPIO_ACTIVE_HIGH>;
-		irq-gpio = <&tlmm 125 GPIO_TRANSITORY>;
 		touchscreen-size-x = <1080>;
 		touchscreen-size-y = <2160>;
-		focaltech,max-touch-number = <5>;
 	};
 };
 
-- 
2.40.0

