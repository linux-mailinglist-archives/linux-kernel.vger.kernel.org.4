Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162376C4EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjCVPEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjCVPEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:04:02 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA0E62D86;
        Wed, 22 Mar 2023 08:03:59 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u5so19527299plq.7;
        Wed, 22 Mar 2023 08:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679497439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVuE/KdB52Fv12L10avqPxG+Z7+2Fxn7eCeCj4YCgks=;
        b=gAdN6V0m1/WKX8BWasLhb4j7JcNU+J6iZUQtsraQGHhqRCwd3FRziCk2TDWv6cvK5V
         3GTAjMV6f1aubOwzqxH2tSfCBaV6ojJ37srGonP9MJ9H2ezc1OV3UM5L6d0ivxIG4PoE
         eJza9F+7C3aYGCZisF0INpk0ILlKdFiu+iAvcK6PxmnsaoPGYiLOydZkH8JvrlEeajFn
         QHzo9gg9db8YvCjLcFiU2QYoKvl9Byi8IcB2HIhqS6vOysgjsD5pY2ks7kKeWCcRMIl0
         n3gbEByCpVEJInaZPf2+CVBBqabHfmcY4hq7KLADK6w1xWkYjVw59PiBPUhmQnz/Iqf4
         QXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679497439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVuE/KdB52Fv12L10avqPxG+Z7+2Fxn7eCeCj4YCgks=;
        b=0CwCGSP/uVt6aBzOE40zrjWc5vea5Hc/kVBZQSnEPtI/QO13zy79FaRgxgYrWRW2vY
         RfR6dGKSlLXpFcFRTFd14HNYeFCRGu+OUCnUzjtBCNj0Ote7TSmZx+7XojSV7/vnK+9A
         lxx5qDkC2nNCNT1ho/hK/czDTwHW4xxMZW18tosrzLe813LSD+DZUYebgvXNzQkmLYqx
         +AUQohaDEgWwsv6aRBOy+J0KEtM+GXSyZWWZpZsVInbDkClg7uoxvbK2TLOudKTk+xnc
         iRCk9lG3RLNfPGUrARk1PuudU1XmG+p9FooOVcBDEbZmdUzUlpBmWFcRrwanSX7+j4ny
         1ikQ==
X-Gm-Message-State: AO0yUKU1erkY9Te1JuvW67FtVC8mNl6cttVIEpXVT/3Gc01XC5VLEV0G
        p/86+O31TMdKB8Wkskvu6X0=
X-Google-Smtp-Source: AK7set/urypxV7piFe0JFwAaPcAQSUe1Pc5g3bmOjTzF4j44op6L0gZvgOK7i0tu5TA1aWkeKjw6Yw==
X-Received: by 2002:a17:902:fa87:b0:1a1:b174:836c with SMTP id lc7-20020a170902fa8700b001a1b174836cmr2619096plb.16.1679497438997;
        Wed, 22 Mar 2023 08:03:58 -0700 (PDT)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id o7-20020a635d47000000b0050fb4181e8bsm2761238pgm.40.2023.03.22.08.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 08:03:58 -0700 (PDT)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH 3/4] arm64: dts: qcom: sm8250-xiaomi-elish-boe: Add Xiaomi Mi Pad 5 Pro BOE variant
Date:   Wed, 22 Mar 2023 23:03:19 +0800
Message-Id: <20230322150320.31787-3-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322150320.31787-1-lujianhua000@gmail.com>
References: <20230322150320.31787-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Xiaomi Mi Pad 5 Pro BOE variant. The BOE variant
uses BOE Technology panel.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile              |  2 +-
 .../boot/dts/qcom/sm8250-xiaomi-elish-boe.dts  | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 1a29403400b7..808f46947661 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -183,7 +183,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx203.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx206.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-xiaomi-elish.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-xiaomi-elish-boe.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-microsoft-surface-duo2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-mtp.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
new file mode 100644
index 000000000000..8b2ae39950ff
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023 Jianhua Lu <lujianhua000@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "sm8250-xiaomi-elish-common.dtsi"
+
+/ {
+	model = "Xiaomi Mi Pad 5 Pro (BOE)";
+	compatible = "xiaomi,elish", "qcom,sm8250";
+};
+
+&display_panel {
+	compatible = "xiaomi,elish-boe-nt36523";
+	status = "okay";
+};
-- 
2.39.2

