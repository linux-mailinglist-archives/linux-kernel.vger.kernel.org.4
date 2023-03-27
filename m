Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F016CA4EE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjC0Mya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjC0Mxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:53:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D269544B4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:53:34 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q19so5614903wrc.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1679921613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYNa0jgyigOb3tpiANMB3XSz00l/mRdfB4P8rKzPX6Y=;
        b=QQSZ68UnwqIriBeygjmiEv57UqO3B5qJj67XKpduNTxu5dqP2GZMaQbgJcQAO/9l4Y
         Ula4B7A8Q7CZWSROlsXe5dahzlYooQ9h0gogN1vsFzA/ueLLxWKEZlU+ntdyFvZzFM6U
         JGfWpoEVJVZP/Gf3P6sRnqhqVR2TyRQNh783jZygOYmKIHiNg0yet7Pp+wN8BBewZ1dU
         hnpqzaDGN6rBxe8rgGhW+5nL23logymVqKCDbaWHGmq/yXuM1bcyFNF96q+Du8LGWjr2
         KfzJB6CWAoCvw+vqDi6hSCxeDFlnPsSOX1NGOgjj1oISIQBzsMM1+fleVd6UbjIdotKw
         7pUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679921613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mYNa0jgyigOb3tpiANMB3XSz00l/mRdfB4P8rKzPX6Y=;
        b=QVAPE3m2mihqFyi6vslb6nbPDtI4YmZ8MdV1yfxXbAfC5WTkOsYYBUAoBGEgSddQEZ
         wKJf2k1wZZYTd0rK+ET+VzHyoh64orLD1iQKGNweO/Chm49MXYU76IZPI7SntSNI7D/h
         BzMlgD0iRAAwgu9DAICkMx+vq3/74XUHiL5jn0AOtX0YckDPPqcWtNDFnaDbWBPcJruq
         5IL8ZKI8qS3aKFBO/1vt6KgMRvcyb+gTyJPgnjCaTqRIzmIYa93IDKVySzrem+hmMzWd
         yXH5wyieFOCPRlbscAKJuj53aXH6FbC/qxt20P5wzpAfPoMrmGXgkGwWEgtwInSyENyb
         Gkcg==
X-Gm-Message-State: AAQBX9dk2USJQ29IFE30GpPTzAMWKbWi3AHVpGFqruJAKzJMzE9noqQA
        K45e9dWpzUBra2q1DFNV60lJTQ==
X-Google-Smtp-Source: AKy350ZpdD60ftBG/ysIV9tsx46gFHPch4LkCxYc4AzfiKIZTKU/E5YVnHTMSi6++9zW5UX+/WJYYw==
X-Received: by 2002:a5d:538a:0:b0:2cf:f454:95d2 with SMTP id d10-20020a5d538a000000b002cff45495d2mr8824775wrv.12.1679921613360;
        Mon, 27 Mar 2023 05:53:33 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:313d:a304:2790:a949])
        by smtp.gmail.com with ESMTPSA id q25-20020a1ce919000000b003ee58e8c971sm13572220wmc.14.2023.03.27.05.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 05:53:33 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 15/18] arm64: dts: qcom: sa8775p-ride: set gpio-line-names for PMIC GPIOs
Date:   Mon, 27 Mar 2023 14:53:13 +0200
Message-Id: <20230327125316.210812-16-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230327125316.210812-1-brgl@bgdev.pl>
References: <20230327125316.210812-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Set line names for GPIO lines exposed by PMICs on sa8775p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 51 +++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index b7ee4cc676b5..a0d2024a69df 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -32,6 +32,57 @@ &i2c18 {
 	status = "okay";
 };
 
+&pmm8654au_0_gpios {
+	gpio-line-names = "DS_EN",
+			  "POFF_COMPLETE",
+			  "UFS0_VER_ID",
+			  "FAST_POFF",
+			  "DBU1_PON_DONE",
+			  "AOSS_SLEEP",
+			  "CAM_DES0_EN",
+			  "CAM_DES1_EN",
+			  "CAM_DES2_EN",
+			  "CAM_DES3_EN",
+			  "UEFI",
+			  "ANALOG_PON_OPT";
+};
+
+&pmm8654au_1_gpios {
+	gpio-line-names = "PMIC_C_ID0",
+			  "PMIC_C_ID1",
+			  "UFS1_VER_ID",
+			  "IPA_PWR",
+			  "",
+			  "WLAN_DBU4_EN",
+			  "WLAN_EN",
+			  "BT_EN",
+			  "USB2_PWR_EN",
+			  "USB2_FAULT";
+};
+
+&pmm8654au_2_gpios {
+	gpio-line-names = "PMIC_E_ID0",
+			  "PMIC_E_ID1",
+			  "USB0_PWR_EN",
+			  "USB0_FAULT",
+			  "SENSOR_IRQ_1",
+			  "SENSOR_IRQ_2",
+			  "SENSOR_RST",
+			  "SGMIIO0_RST",
+			  "SGMIIO1_RST",
+			  "USB1_PWR_ENABLE",
+			  "USB1_FAULT",
+			  "VMON_SPX8";
+};
+
+&pmm8654au_3_gpios {
+	gpio-line-names = "PMIC_G_ID0",
+			  "PMIC_G_ID1",
+			  "GNSS_RST",
+			  "GNSS_EN",
+			  "GNSS_BOOT_MODE";
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
-- 
2.37.2

