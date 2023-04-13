Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847466E0E59
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjDMNRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDMNRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:17:23 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C22E188
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:17:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id s2so10951213wra.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1681391840; x=1683983840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9pQrW38n6jH3lAaxTQPjhAzjBmtv9LEC6ladjD0geM=;
        b=S7JJaJQUgf3JJMM3lkyNLH6OBAtESwaKX10aoRHX2UHUKIe7kHl71MFD9fMexZwcVm
         js9oqmJK84FHyccqwePq0s81Xs5Llc99VqL3yJa89LysqOxb1TZ+o3XkJccAr7UM5kHg
         uYE3J2LaMLkTIOlZ25D49b24vuz3tJIRIxgV9XhWFJ75pXshAWWjwVgi91cKDUm/QrTP
         a6NajHr9w2FG23SQm9u5M7KCsaQRpXgGnKAgUi+Aq/dVSLzNFaWS/L3gwCXtc1mnvZCX
         bWuEGGuYFy4SoBkZ/rla4B0v5bSJLjOwo7OhIiJXgHBsDJ7e4xKuw4iYhYHaWO/va+B9
         RYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681391840; x=1683983840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9pQrW38n6jH3lAaxTQPjhAzjBmtv9LEC6ladjD0geM=;
        b=SPiJZiukY9qRtQ33a/lC0IlVdB/64XRJgNpJ8jKCh/CBEh3dDqG3KC47VmJkUYq4qk
         jbCPO4AzSa8T8vHqWUH04n3hN8QYX7DfZVrELUq2asuR4AUx3H8q6kgdUxKC0QOTqkpU
         0otFFF9Q7GhiIx5TutkmNSwKIY112AuKohk5BzqE/K69T4uZbZskOoHIHW/hcnkcgbZC
         AD317s9uzlYI/Y1B9vUR2XW5cz8rnJBb8yPy2GeMfc3Nnalp4YRLMLjh7LxcykVhYeKJ
         SI4kQs88yUbZT/JtdUY2ti1WvvZV/6wBnny45x+Q2gsr/mEyrLeWn3CRjqvMjX0chRng
         WWWw==
X-Gm-Message-State: AAQBX9fRCbN2P3w8ZR+Wq/rVyyKvx2hqFAETd+Ze8m4qoxx36ZR42+Wz
        sqHTeT1fj2VuxI//7bFEqcJctrD607GLiKh8iWU=
X-Google-Smtp-Source: AKy350ZyvWh6DeTmvqd0RAb8r3WiahK7Z/XKVX0rCaM+oS4kQ7JeGN7DdSu52htk6753FAxZuxYjsQ==
X-Received: by 2002:adf:f04c:0:b0:2cf:e34c:a229 with SMTP id t12-20020adff04c000000b002cfe34ca229mr1797769wro.8.1681391840666;
        Thu, 13 Apr 2023 06:17:20 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:814c:fc8a:da02:39ad])
        by smtp.gmail.com with ESMTPSA id v3-20020a1cf703000000b003f04646838esm1796400wmh.39.2023.04.13.06.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 06:17:20 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Parikshit Pareek <quic_ppareek@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 4/4] arm64: dts: qcom: sa8775p: pmic: add the sdam_0 node
Date:   Thu, 13 Apr 2023 15:17:05 +0200
Message-Id: <20230413131705.3073911-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230413131705.3073911-1-brgl@bgdev.pl>
References: <20230413131705.3073911-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Parikshit Pareek <quic_ppareek@quicinc.com>

Introduce sdam_0 node, which is to be used via nvmem for power on
reasons during reboot. Add supported PoN reaons supported via sdam_0
node.

Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
index 5abdc239d3a6..49bf7b08f5b6 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
@@ -88,6 +88,14 @@ trip1 {
 			};
 		};
 	};
+
+	reboot_reason {
+		compatible = "nvmem-reboot-mode";
+		nvmem-cells = <&reboot_reason>;
+		nvmem-cell-names = "reboot-mode";
+		mode-recovery = <0x01>;
+		mode-bootloader = <0x02>;
+	};
 };
 
 &spmi_bus {
@@ -133,6 +141,19 @@ pmm8654au_0_gpios: gpio@8800 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		pmm8654au_0_sdam_0: nvram@7100 {
+			compatible = "qcom,spmi-sdam";
+			reg = <0x7100>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x7100 0x100>;
+
+			reboot_reason: reboot-reason@48 {
+				reg = <0x48 0x1>;
+				bits = <1 7>;
+			};
+		};
 	};
 
 	pmm8654au_1: pmic@2 {
-- 
2.37.2

