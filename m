Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148B46504BA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 22:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiLRVU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 16:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiLRVU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 16:20:26 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA02658C;
        Sun, 18 Dec 2022 13:20:24 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bf43so11095490lfb.6;
        Sun, 18 Dec 2022 13:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FiMFRphXpXu6yzsGT8LSwyasJh3aAqFkYcsSKQFk/tA=;
        b=OHZUj7IVQC/KvuwDdKIL/1YK/0lRyKiGJumrfvliR4zkMYP0ctf4ATsHWT7TRg5Kdl
         4yvCxs6RlqnrTobKlldc4m1Gd/hXxzV6+OT3QGkhHinQC7i33yntqRDAqni70cq0HU6O
         3GMBzdhEeC5fnSFaT60QJyblotxY/VT+Yjp6y83nP6QrUoSek+0btbDFYLEL7LauvmpX
         vmm420lEq2UrrWseIMsrjiMdRc9Mz2QC9JvY5TrIxXfaLobfLWYQ2WOdHknJIdEt8BQv
         3dqKw4RF86YP6id93G8xFze9EjqW1lgF+UUFpdZUwdgW9xrR56LjeN+HAns8fsF5vIGW
         aKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FiMFRphXpXu6yzsGT8LSwyasJh3aAqFkYcsSKQFk/tA=;
        b=VPYSvykgVPecMEysgnePrfMyr8x/sF5Nr9w7OMgbkw7ftPxJhiafRhvV+RXG563ryx
         fQparNscOO1gPJj4YncbT46dYQJSZqE5rr4YthjHfjF0LOu1Of63cST45tBExAnfVkAO
         +i7g/IzOSsMuyjQLRPkJrzhmaWN8GkEH7yYP0oLB0vryoSUAbLpZDjeYp1weRMNNdvHa
         CqB3ipQ078wu035EE5AqdCpJ7bsWXIciThwZYDxNYBNIqkqkmCNqN6DfCJhmnrQwonwz
         KDElgM9+BSRdcBLo5SGaT97mbeEwTZILbWHF7oPNt2ZV4Z3iWeWBis4wuyhVhAi6cSiX
         /sIA==
X-Gm-Message-State: ANoB5plKA7wRMZ0zDscZddkOd+//OPEnizzgaUt+GFlmWTUXsrHD0p1T
        0CS6Xp4P0zQtf4yj+Hy1OR3BHYLQRPjZGQ==
X-Google-Smtp-Source: AA0mqf7UyuzCYgwxPfYLGNi7bpMbMKAkbEFE4j259nJQZiwT8rTc7zQuMbe/TrQoY6SKIcaVYyd6Tg==
X-Received: by 2002:ac2:44a4:0:b0:4b5:8504:7072 with SMTP id c4-20020ac244a4000000b004b585047072mr10003575lfm.14.1671398422371;
        Sun, 18 Dec 2022 13:20:22 -0800 (PST)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id c21-20020a056512325500b004b56d00b2d1sm916229lfr.285.2022.12.18.13.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 13:20:21 -0800 (PST)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: qcom: apq8026-samsung-matisse-wifi: Enable ADSP
Date:   Sun, 18 Dec 2022 23:19:57 +0200
Message-Id: <20221218211957.118473-1-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Configure the reserved memory for ADSP and enable it.
Delete nodes with reference to label.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
Changes in v2:
  - Delete nodes with reference to label
---
 .../arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
index 1c52337af560..15b9590ba07b 100644
--- a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
+++ b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
@@ -9,6 +9,9 @@
 #include "qcom-msm8226.dtsi"
 #include "qcom-pm8226.dtsi"
 
+/delete-node/ &adsp_region;
+/delete-node/ &smem_region;
+
 / {
 	model = "Samsung Galaxy Tab 4 10.1";
 	compatible = "samsung,matisse-wifi", "qcom,apq8026";
@@ -133,7 +136,7 @@ wcnss@d200000 {
 			no-map;
 		};
 
-		adsp@d900000 {
+		adsp_region: adsp@d900000 {
 			reg = <0x0d900000 0x1800000>;
 			no-map;
 		};
@@ -143,7 +146,6 @@ venus@f100000 {
 			no-map;
 		};
 
-		/delete-node/ smem@3000000;
 		smem_region: smem@fa00000 {
 			reg = <0x0fa00000 0x100000>;
 			no-map;
@@ -169,6 +171,10 @@ rmtfs@fd80000 {
 	};
 };
 
+&adsp {
+	status = "okay";
+};
+
 &blsp1_i2c2 {
 	status = "okay";
 
-- 
2.34.1

