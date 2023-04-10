Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FBA6DC906
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjDJQCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjDJQCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:02:12 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2872171C;
        Mon, 10 Apr 2023 09:02:10 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-328990497e7so209815ab.1;
        Mon, 10 Apr 2023 09:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681142530; x=1683734530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WRbpW3m578x5MfQQ6H7U6/ppADfjexDu2jTLEQfa6Y=;
        b=fpWzPvsRs59pPJOjVNt3uOVg+XJI2QhYUCIsbOs8E+CZiPxXpQiGxWhJMUe5b44mmI
         F75WjKt2sZ7/5280GRSI3gp2pO2PT+BXTnGovyzJcxrc7gX1M69wvx2eIbpbEc3BvZQO
         s9gXhMXZCDwiLej8FD4Bah50C2F3PHiY9uRwV/JmAArvWG7mdsgdqpVtyz7VhfHtb4W6
         K9tZBlTeeaaaI6AbqfR+LUn5+kzhv+eJW6tfcMferXYuGOAGZv/rQQDFe1p8BR7EIwxQ
         QMSAJeLVuMhPZlRS7V9WCaNdO3fOpkjWA6dXgfV5Buko8pXC8j7KWuoTiJsjeEbrG0O+
         cQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681142530; x=1683734530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WRbpW3m578x5MfQQ6H7U6/ppADfjexDu2jTLEQfa6Y=;
        b=3DPTaCI7P/3CI9I/aOnehyeoJpDC2XLd7caBOFDJ6YfLhWUf/70YYBJZvxDrxDCrt7
         xJiGv2IVw92qfxovT1ALd3NqSyujyL2TLKfx93U1TRF8nnbJcWjzKDk6SePeyrucTV2v
         xs9YJrnvf7dG4dd9DDEsEY+j3BDbjlgdHrwlEeBsml9OCceIYnn3mKosljz2kyDt4Cw/
         wYVVN87kc8CXKL+eKQKdFz/fmhpNqCUUUQUpJsqGypH3mg2FSrhl3z3WoJPB9PbYUisc
         nlszogF0ecpTVzGR17b7OgGrHIQsXgYVW2cNnhjl2+flCysmUDt2gxenbwMo1xIi3aSg
         DxJw==
X-Gm-Message-State: AAQBX9eNEFluucTAj5IvT244HV4puuNopuc4YmYNedx+ZFpI+o33UwAj
        bh8cpm54sIOu6r/X1dULrj8=
X-Google-Smtp-Source: AKy350ZtDGhNGKQ9dSGRRaK2unA4PVBne5NvKZe0ZVg7cCZylzqjXjCSJM2YnzzOJMsbzTrMzCdZXA==
X-Received: by 2002:a05:6602:2a48:b0:759:485:41d with SMTP id k8-20020a0566022a4800b007590485041dmr4376547iov.0.1681142530192;
        Mon, 10 Apr 2023 09:02:10 -0700 (PDT)
Received: from JOEL-DESKTOP.. ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id c7-20020a5d9a87000000b00746041ecbf9sm3184435iom.39.2023.04.10.09.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 09:02:09 -0700 (PDT)
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
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Chris Morgan <macromorgan@hotmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Subject: [PATCH v2 4/5] arm64: dts: qcom: sdm845-xiaomi-beryllium-ebbg: introduce support for fts touchscreen
Date:   Mon, 10 Apr 2023 11:01:59 -0500
Message-Id: <20230410160200.57261-5-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230410160200.57261-1-joelselvaraj.oss@gmail.com>
References: <20230410160200.57261-1-joelselvaraj.oss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Poco F1 EBBG variant uses Focaltech FTS8719 touchscreen. Introduce
support for it.

Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
---
 .../dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
index 76931ebad065..f857ed3e2df4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
@@ -13,3 +13,29 @@ &display_panel {
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
+	touchscreen@38 {
+		compatible = "focaltech,fts8719";
+		reg = <0x38>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
+
+		vddio-supply = <&vreg_l14a_1p8>;
+
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&ts_int_default &ts_reset_default>;
+		pinctrl-1 = <&ts_int_sleep &ts_reset_sleep>;
+
+		touchscreen-size-x = <1080>;
+		touchscreen-size-y = <2246>;
+	};
+};
-- 
2.40.0

