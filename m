Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E96D70A14F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjESVJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjESVJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:09:25 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435FDE40;
        Fri, 19 May 2023 14:09:22 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f13d8f74abso4257068e87.0;
        Fri, 19 May 2023 14:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684530560; x=1687122560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fgph3LS4pLGw0I7O6nZ7pygXe/8MJCvzAR/p+azXAfY=;
        b=HeTa9iVo1Tl/G0OAy3bTVLWiYiXWqZ29was/JRi4akoPmN5WrKU4boKnLmI8aibxUi
         qdZ72wazUiVMcgBnJvAifL0q79b88amjYa5wKIHpEYW54dh9MteNzz9Ss5QTeLP2qh3M
         BWLQuMZSVJovMUlAb7q9BFguF0XxXUPtOlOZkLOLP6jWGywdBLife11HoDbk1G69D6w7
         AWUq5Vxl6BsJFzl55O8zZ1yMjNGcbEK9fgS2tID9oFPO9hn5UNDHdDHm6IS8ccDD8nVL
         o6mX1EJFqGXt36y5wpoZs29jhLQ/xRe0PQKbXv1fyz8cSf8Phba15FNYZIjujxsNbgZa
         d7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684530560; x=1687122560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fgph3LS4pLGw0I7O6nZ7pygXe/8MJCvzAR/p+azXAfY=;
        b=DLFhTsA0gZoDc9kznq6LBUNU51avMd9EknTllEtMFvsGirrvLOma/FIpvEqwrRutuq
         1auOteVN5cFR7bZe6mK3KJiPSSX88xlrntEorz/wywpU8zWM2GofBiw977GwJtidapOQ
         0Nmph/URqngbSwnq9vFicc8p1M5F/GywA+rHjqV5+ZAiRDonNJ8rhpjsJCdJryCoWPEV
         97OXs0PYXURgxArM+bd+SzSYvB7yMyiqAhFaWF75FgQNqMLPE8gTdFffveLX3r01SCi4
         +OVwbKbxyfsbsnuAiOVDQu2gvdIeNjFmirjwqBSBu+e3Krc7iQI6Vrtg97lMGZkZseNh
         itxw==
X-Gm-Message-State: AC+VfDx15SmJyoo/VJ4i4ME335E+iTT8ANC7ykr5ZKzlEHT0avSPrIZA
        Nl5LiAkNDNjzmySLXNA0I8FlVy+3aWK2jA==
X-Google-Smtp-Source: ACHHUZ4iimSOWfmEqDIxad899sMlnIZG8XI9lBNAVhBk5RpRrZaAAkPftJTVwvGJtBsspxjH3skbKA==
X-Received: by 2002:a19:ee01:0:b0:4f2:5d05:f19d with SMTP id g1-20020a19ee01000000b004f25d05f19dmr1123709lfb.69.1684530560480;
        Fri, 19 May 2023 14:09:20 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id i14-20020ac2522e000000b004f3945751b2sm30043lfl.43.2023.05.19.14.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 14:09:20 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ARM: dts: qcom: apq8026-samsung-matisse-wifi: Add reboot-mode node
Date:   Sat, 20 May 2023 00:09:02 +0300
Message-Id: <20230519210903.117030-6-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519210903.117030-1-matti.lehtimaki@gmail.com>
References: <20230519210903.117030-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This enables userspace to signal the bootloader to go into the
bootloader or recovery mode.

The magic values can be found in both the downstream kernel and the LK
kernel (bootloader).

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 .../arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
index 91b860e24681..a05c41191efd 100644
--- a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
+++ b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
@@ -279,6 +279,16 @@ touchscreen@4a {
 	};
 };
 
+&imem {
+	status = "okay";
+
+	reboot-mode {
+		mode-bootloader = <0x77665500>;
+		mode-normal     = <0x77665501>;
+		mode-recovery   = <0x77665502>;
+	};
+};
+
 &rpm_requests {
 	regulators {
 		compatible = "qcom,rpm-pm8226-regulators";
-- 
2.34.1

