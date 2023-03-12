Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F3D6B6434
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 10:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCLJd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 05:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjCLJdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 05:33:16 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E8621968;
        Sun, 12 Mar 2023 01:33:15 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id m22so3878585ioy.4;
        Sun, 12 Mar 2023 01:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678613594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvTfQiKFBDSd/zMX2HWGSslwfM105BMRxBBQeK2kOrA=;
        b=ayEoh0xkYSoNvrw0GH8ZX5AuVZsRFJYnuCRj0btSWErNXboa63Xo1hK0e+19TFnMtZ
         SzZh528PwNAp3Z2QwHxtfi+sYcBOS6QBhtaH62ZkziKPLRFmJo/9Iim2Q/c2z0rLaQ3f
         8YANTkunQ+JBnVFF2eE6L0uuCjk/Mu2ucBjp2mDuuQkhRRVw/C702zIdzbo3JZa8uGjC
         htooRB5GVUHsiQM41nu95N+EXXgWU3/m8Z4dbKEB46zVUjX/AI3b2QhUFO+CzEN07caX
         pLcBG5dfMPXPFTR3AxZAIL1O8b4sm+rm5qW2bZ7geHjpJ3qxYg/Z8ZV6PHCk3zea8dhZ
         QLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678613594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvTfQiKFBDSd/zMX2HWGSslwfM105BMRxBBQeK2kOrA=;
        b=tsIQ5LjOVWAO00ckF0c3iB/Gj2PHlSdDUBjP9mJxAVLg2+QvCsqGHuKPmaaF4bLv/5
         SOrcQiLfNQCCSLlTDrxdWfJuuzRKJj4rCfKBwB1hqT6V3HCHx+kPj+hkQqfJCVXKxIDN
         JgGuGFXQdb8LEokAtqv2qRtQtFmmIaGgGsxhzK+GBycag1J3F4f3l/Mrr8tySDT9P6F+
         UQS+jInYPVqEoQhL8OOy+m7WpKp48mDS2wgdsqEFBdpxfX+UJJvYbV3SF1ZOyQZirg2A
         IFAldiw7wTXk0/sBOyKEMFd/UhN2s2cHbgKBYlcFWJz2PY9Zt/9uYVuTssO6YOmBCRNp
         jDVw==
X-Gm-Message-State: AO0yUKVnxQSjXHsiDd0lg2GLvmEa8YqqyKcaFnIRfGfuT4/n0OohLWh1
        F+UN+z4ETOWjUt91MwFWB6c=
X-Google-Smtp-Source: AK7set/ZWn7P3400g15huY8EMBFQuB2wqeKtx8/NdwiOJ4nPeMX0YNehCXK+OH69Oyy2gKAqLEFezQ==
X-Received: by 2002:a5d:9297:0:b0:74c:99e8:7f44 with SMTP id s23-20020a5d9297000000b0074c99e87f44mr3985500iom.2.1678613594221;
        Sun, 12 Mar 2023 01:33:14 -0800 (PST)
Received: from JOEL-DESKTOP.. ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id r7-20020a6bfc07000000b00716eb44b97esm1585031ioh.27.2023.03.12.01.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 01:33:13 -0800 (PST)
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
Subject: [PATCH 4/5] arm64: dts: qcom: sdm845-xiaomi-beryllium-ebbg: introduce support for fts touchscreen
Date:   Sun, 12 Mar 2023 04:32:48 -0500
Message-Id: <20230312093249.1846993-5-joelselvaraj.oss@gmail.com>
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

The Poco F1 EBBG variant uses Focaltech FTS touchscreen. Introduce
support for it.

Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
---
 .../dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
index 76931ebad065..a23be4c8e1bb 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
@@ -13,3 +13,30 @@ &display_panel {
 	compatible = "ebbg,ft8719";
 	status = "okay";
 };
+
+&i2c14 {
+	status = "okay";
+
+	dmas =  <&gpi_dma1 0 6 QCOM_GPI_I2C>,
+		<&gpi_dma1 1 6 QCOM_GPI_I2C>;
+	dma-names = "tx", "rx";
+
+	touchscreen: focaltech@38 {
+		compatible = "focaltech,fts8719";
+		reg = <0x38>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <31 IRQ_TYPE_EDGE_RISING>;
+
+		vddio-supply = <&vreg_l14a_1p8>;
+
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&ts_int_default &ts_reset_default>;
+		pinctrl-1 = <&ts_int_sleep &ts_reset_sleep>;
+
+		reset-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
+
+		touchscreen-size-x = <1080>;
+		touchscreen-size-y = <2246>;
+		focaltech,max-touch-number = <10>;
+	};
+};
-- 
2.39.2

