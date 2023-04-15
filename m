Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115716E2E6E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 04:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjDOCCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 22:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjDOCCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 22:02:42 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5719F6EBB;
        Fri, 14 Apr 2023 19:02:40 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54fdf7cd390so861467b3.1;
        Fri, 14 Apr 2023 19:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681524159; x=1684116159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRYjuOFtFMXh2I5E0ogIAK80X8pJ9UuA0I2DICP2Jj0=;
        b=q01K+eavqhDqxmY6O3BnpLDHn84NHxAp+tp0X8w9NK7oh+Lj2KjIt73m0fPerVAENl
         /Uztms3HzIthZVeDhJRMKKXsspVsuOMtsP8T3s3VDx8/elFoL+vag34muSYMdC/6EcQ9
         1OCNMROTMc6xjBYNsPCauStERIwOslyNStFOsd2vnnU6wQoHw/60+a7+/5c3GPHsjGur
         vX2MENVj4M0xOixn59z3bAbm+0NGCuXLqHmUV17uZ4tV9fup0eSN70xXWl7XQ/nNMarQ
         TKZMOm8Da/lvKz1p13+py1FzBnrZUu64086DtWrvAYfw9B/ysCstwpVjDw0TaAvGgw6x
         nm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681524159; x=1684116159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRYjuOFtFMXh2I5E0ogIAK80X8pJ9UuA0I2DICP2Jj0=;
        b=PZLn4XqXSBs1gLKwy8c44eevi5lu750WjzDvGpq/eB8f5R0Q0nseSu3a6/vg0Lacfd
         jMpXpR3/Rum6JZd5YhQ1xAAp1sek35+s/Pb45pGLVOnI0//w9NwTfrO8LiWkZZQM/Pfj
         7ym/qp6opHJu0Zk4hEioWNtMcZ3BlOcXkPy5dipzgGZLETSfM++EbUvDNgN0L9tEJWQQ
         IGjYQhwX66idyFPLZD2q5V47DO1MmsVyE65ZgUSekQQ1HOnJTzjBh+XU3lc+teoOzfgz
         iCUGxa+QraA/Pg+/PsCiHoQaOZB9WR/k88GDNm18StR909KH1RsjughEuGQqoTLAo8y3
         nXBg==
X-Gm-Message-State: AAQBX9fIvXsL1bp6G3jeEoNEj2mwQ2HU9KMD1D+vPPsmpruSb9L7KKdV
        ZL7sLEL9W7ZsDnreIA45Hr4=
X-Google-Smtp-Source: AKy350awlC76WlaWGXoFsIWVKz+9gED652/3+5wnud2dqYq54YV7SBAVZb8Nes9TMvuZTsIIJQkmdg==
X-Received: by 2002:a81:130e:0:b0:54c:c7a:5c8a with SMTP id 14-20020a81130e000000b0054c0c7a5c8amr3738074ywt.1.1681524159319;
        Fri, 14 Apr 2023 19:02:39 -0700 (PDT)
Received: from JOEL-DESKTOP.. ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id 68-20020a810a47000000b00545a081847fsm1593607ywk.15.2023.04.14.19.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 19:02:39 -0700 (PDT)
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
Subject: [PATCH v3 4/5] arm64: dts: qcom: sdm845-xiaomi-beryllium-ebbg: introduce support for fts touchscreen
Date:   Fri, 14 Apr 2023 21:02:21 -0500
Message-Id: <20230415020222.216232-5-joelselvaraj.oss@gmail.com>
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

The Poco F1 EBBG variant uses Focaltech FTS touchscreen. Introduce
support for it.

Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
---
 .../dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
index 76931ebad065..26e77979cdab 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
@@ -13,3 +13,24 @@ &display_panel {
 	compatible = "ebbg,ft8719";
 	status = "okay";
 };
+
+&i2c14 {
+	status = "okay";
+
+	touchscreen@38 {
+		compatible = "focaltech,fts8719";
+		reg = <0x38>;
+
+		interrupts-extended = <&tlmm 31 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
+
+		vddio-supply = <&vreg_l14a_1p8>;
+
+		pinctrl-0 = <&ts_int_default &ts_reset_default>;
+		pinctrl-1 = <&ts_int_sleep &ts_reset_sleep>;
+		pinctrl-names = "default", "sleep";
+
+		touchscreen-size-x = <1080>;
+		touchscreen-size-y = <2246>;
+	};
+};
-- 
2.40.0

