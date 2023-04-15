Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6317D6E2E6D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 04:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjDOCCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 22:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjDOCCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 22:02:39 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC3D59EE;
        Fri, 14 Apr 2023 19:02:38 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-54f0bb9cb5aso2042597b3.0;
        Fri, 14 Apr 2023 19:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681524157; x=1684116157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+k6/HWFvrBSAMHaAZKtCLz3aH8Bzj4+yG94o53ig8Ws=;
        b=lbMIvQminlUtIFTdUVAQlZ+p3hgaCZqHMeTT3nySBbURV+jlxZox448ZrTcBGYwCs2
         XNC+f6s6Zm1jOUDvcipdl6Os9BBV2KXTAk7ZpWw8/EkkT13WYxT2EqOfyZMgIzaj7Wlu
         Z+HNL15CUfWWGIfaBxN1XDs9TYFQI18wJ8i4MFvvjza17FvXZPBiXMWqCKfMKySDGTVE
         h7Q34gCNx/hPl7vsvjXTeCEGpIlWbXewJxchmtO6ui/1qnUWBFG4Cwr35FSmGSHoKsV+
         u0dSJG3Gr88vvhdLRGFNTDWgjTBTyht0ewZT+2kxVE5Cg/xbuCpR1mv/XefbsCDnA7ol
         umnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681524157; x=1684116157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+k6/HWFvrBSAMHaAZKtCLz3aH8Bzj4+yG94o53ig8Ws=;
        b=koq0MZXQvGX843EmN2bkGOTYIaDPA1giDVIIHcX0VNCveH2VnOTaA23hrY/gnKr9yp
         eVFtuPZlQxWQvHR3Rk//ood+Pb7xACZ3ZUXiN/mDd4hvJvKkLMmTPfIh4OzJdNSp1aPk
         BtCfca2mq9D/59KPmPnTyndK1Vu5XVSOk6my/SusFuMAQIEcYa7+HvTle58FlMTvA39u
         g2xjgR5QNfu6jj/2sQPZmUVXq4CKALSInuWqzxda61dzndagNKSAtfD5YDyQfBTIYvKi
         oSjjKaahzGLPFmgy0QgnWuVXBw57jaOh6D3Gz60DRl/jm3vCMOf5p0bYQITYYG51rMO4
         OJDQ==
X-Gm-Message-State: AAQBX9cUix2/RVPrshEbmLwOW/p35Nk6BOK3t+JigKyIQ8MOTolIFBRD
        zHIe69iikmTCPY238n9ufFE=
X-Google-Smtp-Source: AKy350Y/S5kSuo1z5WOZNbHW1iWIU/U90BLjVvXRsptE5L9df0RJ1udCUF281F2gswQLMNPF51dZ6Q==
X-Received: by 2002:a81:7853:0:b0:54f:8a61:d859 with SMTP id t80-20020a817853000000b0054f8a61d859mr4482158ywc.5.1681524157446;
        Fri, 14 Apr 2023 19:02:37 -0700 (PDT)
Received: from JOEL-DESKTOP.. ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id 68-20020a810a47000000b00545a081847fsm1593607ywk.15.2023.04.14.19.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 19:02:37 -0700 (PDT)
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
Subject: [PATCH v3 3/5] arm64: dts: qcom: sdm845-xiaomi-beryllium-common: add touchscreen related nodes
Date:   Fri, 14 Apr 2023 21:02:20 -0500
Message-Id: <20230415020222.216232-4-joelselvaraj.oss@gmail.com>
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

Enable qupv3_id_1 and gpi_dma1 as they are required for configuring
touchscreen. Also add pinctrl configurations needed for touchscreen.
These are common for both the tianma and ebbg touchscreen variant.
In the subsequent patch, we will initially enable support for the focaltech
touchscreen used in the EBBG variant. This is done in preparation for that.

Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
---
 .../qcom/sdm845-xiaomi-beryllium-common.dtsi  | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index 5ed975cc6ecb..b34ba46080ce 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -268,6 +268,10 @@ &gmu {
 	status = "okay";
 };
 
+&gpi_dma1 {
+	status = "okay";
+};
+
 &gpu {
 	status = "okay";
 
@@ -376,6 +380,10 @@ &qupv3_id_0 {
 	status = "okay";
 };
 
+&qupv3_id_1 {
+	status = "okay";
+};
+
 &sdhc_2 {
 	status = "okay";
 
@@ -481,6 +489,35 @@ sdc2_card_det_n: sd-card-det-n-state {
 		function = "gpio";
 		bias-pull-up;
 	};
+
+	ts_int_default: ts-int-default-state {
+		pins = "gpio31";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-pull-down;
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
2.40.0

