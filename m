Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54A8668490
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239644AbjALUyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbjALUwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:52:55 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC64140DF;
        Thu, 12 Jan 2023 12:26:49 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id e13so20617099ljn.0;
        Thu, 12 Jan 2023 12:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXlB/bZiimr5FYAvYPtyx+e44PGlouVF773DQKNVaAE=;
        b=KkNSzQzfA67TmwsfbdAVs4WCGiyC7+LCSt0akDNM6nST42U9p4eWyU5nxyF/Qe647y
         48Xy1KR32rxinmxaSUnvlrM5oYRyz0iVfeQVYFOhSFSsqISaz7pk8mJAmisNM4xYKuIl
         Ue6iub+ZjFtQG1ze/Pl3LANYD5HOBRrLjtYvba3e9DInEfQiYOV1qx3HAG2oiJ6mY/99
         FitUMIESDy+gSk313GfxIji0M+9sHk6Z8Ne6OQ05p+B1QBVVPgjVO+zVKwUCV3pu1dJP
         MI3Lr5OKrjTz9WSwNQTiPkVqzhidjSnfgRESh9rSg7Yy6bHb5ZNrddlks1oMrSpDq8at
         MiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXlB/bZiimr5FYAvYPtyx+e44PGlouVF773DQKNVaAE=;
        b=2HCvLEfw5r8gAeEM2gBGARBUj1rlRAKsGsDwSRnKbE0nPcCIoa+TN0OS9GnwHJhF9T
         1k3gVUAA2KIZhLuAfJs3AFmVgRXb6UzSqm7PToGQwUhxTGE3XPLvhsPrJjVGy46WmzP/
         D0YVMjReiRV5gInFDg5cqdgsVnknJ1fgN6olD1ULSm533viTiWmYsNj4LfZVxmlcGefd
         yz/zH9mQcnkh+8UfKUHk6HTcy9IvYuQeoztD8JgiEIW3aNfnIXmxY4OgeU9uo+E1OTVw
         zVvaSrakVlz1+bvR1rV1JydYxL70hBg1rcBUEuj969sCaPRTY/DdTV+NA3oYqiunmr1w
         muAA==
X-Gm-Message-State: AFqh2kqzGoMpj90sxeyT7xz7i8tDu+z5jpIJHZVfhOv9xN64trTwRlz8
        sMm5UrooCw8+3WwOps2QUcKueL0+u2eldg==
X-Google-Smtp-Source: AMrXdXuogxge0UTiQ6Eh6++mppOLta2QqwMJDQujvMwpoT1NLDmXmSsdCOmytdHi8wYTIY6TyInaqA==
X-Received: by 2002:a2e:a989:0:b0:285:91da:54d1 with SMTP id x9-20020a2ea989000000b0028591da54d1mr5382629ljq.37.1673555207747;
        Thu, 12 Jan 2023 12:26:47 -0800 (PST)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id k6-20020a2eb746000000b00281350bb5fbsm2346731ljo.2.2023.01.12.12.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 12:26:47 -0800 (PST)
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
Subject: [PATCH 8/8] ARM: dts: qcom: apq8026-samsung-matisse-wifi: Enable modem
Date:   Thu, 12 Jan 2023 22:26:11 +0200
Message-Id: <20230112202612.791455-9-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112202612.791455-1-matti.lehtimaki@gmail.com>
References: <20230112202612.791455-1-matti.lehtimaki@gmail.com>
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

Enable modem remoteproc on samsung,matisse-wifi.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 .../boot/dts/qcom-apq8026-samsung-matisse-wifi.dts  | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
index 91b860e24681..c84ae3e2a602 100644
--- a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
+++ b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
@@ -10,6 +10,8 @@
 #include "qcom-pm8226.dtsi"
 
 /delete-node/ &adsp_region;
+/delete-node/ &mba_region;
+/delete-node/ &mpss_region;
 /delete-node/ &smem_region;
 
 / {
@@ -165,12 +167,12 @@ framebuffer@3200000 {
 			no-map;
 		};
 
-		mpss@8400000 {
+		mpss_region: mpss@8400000 {
 			reg = <0x08400000 0x1f00000>;
 			no-map;
 		};
 
-		mba@a300000 {
+		mba_region: mba@a300000 {
 			reg = <0x0a300000 0x100000>;
 			no-map;
 		};
@@ -279,6 +281,13 @@ touchscreen@4a {
 	};
 };
 
+&modem {
+	mx-supply = <&pm8226_l3>;
+	pll-supply = <&pm8226_l8>;
+
+	status = "okay";
+};
+
 &rpm_requests {
 	regulators {
 		compatible = "qcom,rpm-pm8226-regulators";
-- 
2.34.1

