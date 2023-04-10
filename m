Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326366DC8FD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjDJQCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjDJQCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:02:10 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2FA10A;
        Mon, 10 Apr 2023 09:02:09 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7606cf95ab8so2409839f.0;
        Mon, 10 Apr 2023 09:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681142528; x=1683734528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9ictD2ajD9aXjz9JmrkJpMZfRuHbVQYL0A7CbsNnNc=;
        b=L0fLmYfs89b7e3MvR/JvH7a6FImHGeWQGG61pNPCAusCb3rZ2paAyCK3TbEscqvQ7D
         NtJ1LPt9440rFoiU21j0Jclmq2oYdtJ5LSSzD41mTfLil7E9D3bLBlLwlOYdz4fbKUGA
         m3BK3UKy+IPwbkTkBxg3GKDWE9GyYLJtNFb2BTIdVtDm0rKil3IWLJ4O9D5tqStVVYXF
         astVQ1FnIEdiJh2bXkAxi9mivfQ5lXTnZK/62gAEKYYUbULAQKkrh2vtG+/XsyN8JTLr
         fk0oARiol7BxZ8qJuIFK5W0EX03Vtn0pTr97K1LTcFzE26C/Vs/7HKh/l7PLTTcZjWVf
         M4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681142528; x=1683734528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9ictD2ajD9aXjz9JmrkJpMZfRuHbVQYL0A7CbsNnNc=;
        b=Jhuth/o9LYKJ7oRNIHYq03jNUUd97xfABXYrKFgpuiRMfj5Zyux99RzfMTwKihRGfB
         iQqIIyGFBHJV1kb0rXEwhnpaq3C05tsCMKt468EnDWBd8K65o9jILNS702gcvcXgkIxH
         ReCaf51P1NrkofnIjZ4uekbCdcZVyhXE324jsgeuQ9sdAZtKt52vo9jw/R1kGd6Hgguf
         +MAHgte7LFdMWnoqx7kij1g4S484zpCBtg4LvnD9urVjVih8DPU1d0HlFrj2GIGyENUT
         IxqgsBzJptlWq6DOVzD7yRxszj1gAbXKzlJkcrkbuXGZYhK4b4TA7cCUtOSE5xSUNh9I
         lg3w==
X-Gm-Message-State: AAQBX9fwwgguIg71aQTbhT+72FRyKdqxHeyAOwjCRMeqoORVUdC5DoMc
        VJM9zmZVQzmHS207eqjdn+0=
X-Google-Smtp-Source: AKy350b3zYfAtKlvrYyAZoCOxYbFvXfoaU6UWjqsd56Hh28IsPQzAf4FqITYc486xxMzYiEHv4LJGw==
X-Received: by 2002:a05:6e02:13d2:b0:325:e46f:a028 with SMTP id v18-20020a056e0213d200b00325e46fa028mr4778451ilj.3.1681142528669;
        Mon, 10 Apr 2023 09:02:08 -0700 (PDT)
Received: from JOEL-DESKTOP.. ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id c7-20020a5d9a87000000b00746041ecbf9sm3184435iom.39.2023.04.10.09.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 09:02:08 -0700 (PDT)
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
Subject: [PATCH v2 3/5] arm64: dts: qcom: sdm845-xiaomi-beryllium-common: add touchscreen related nodes
Date:   Mon, 10 Apr 2023 11:01:58 -0500
Message-Id: <20230410160200.57261-4-joelselvaraj.oss@gmail.com>
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
index 5ed975cc6ecb..b580a32fdc3b 100644
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
 
@@ -481,6 +489,37 @@ sdc2_card_det_n: sd-card-det-n-state {
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
2.40.0

