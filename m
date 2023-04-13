Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559266E0CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjDMLku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDMLkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:40:49 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D56269D;
        Thu, 13 Apr 2023 04:40:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id gw13so8281808wmb.3;
        Thu, 13 Apr 2023 04:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681386046; x=1683978046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m66B/9uT9mWYOEyZbd8z/k+G4QiidL/7FmVJXlLVW/U=;
        b=hgm6xnGddWYrtgZzDQB8etna94nRQacYpeJTqaTBRs2X9wUyIBAYpdgqeicJdE8TV3
         b2yybhT0Thzptj/4EolAbcI84Be5Ya68gSXR7TSNBw85zqxkqtV52V52SMixWwVIYZD4
         N7W3NJJRg38lcIGqzC6RDslvpx2jTP/QrQk1w+lDugmlLzaM6KvBd6aA6vBiHZ/LRklo
         snZi8cpqcxE/Mv97b1pllp+Ybx6/907SOieY4D7n2p+jDiKb/UhfiRaogW+XdBLlEhTX
         4C3hnFfeljzvcCW3g7LQzBbDKi8cHqMXYEncETC4yMe2wuhK9v1fo2oBteMmY/XKXVgc
         8AQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681386046; x=1683978046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m66B/9uT9mWYOEyZbd8z/k+G4QiidL/7FmVJXlLVW/U=;
        b=NZcDund7P73yrIUNID9KB5VA7H2TOSpCfqf7SZ3U+m75kOLB0FoDIKik1YsvZjgt6f
         jgjJoT1tVrhv95IF6bgOTTyk9NndhYrOXiOYyE6r7eRUPFvilHtcooWHWDVbMR+GBu3O
         amACGdkG1Cmtgj8QtYapyNAw0isZNFSvC0STFIK3YydDXwfar+VhD3UKLJKkiVCTOmaC
         gab5GQxD2kgzhpsC2jMtoNtJbwQbPcOnLCJnALIZwpXtyle476WHLKEqtSbbNGXZJzGX
         dIo36+2o7uosbmoaqJmAu9MDb9KabUEZ8wOxLA+5oO/eq+EWmkusm24tcJ7PYODzmxk4
         H83w==
X-Gm-Message-State: AAQBX9duXRP12WxC0Ly1a7p83y6V6iiCL3VDhmjlmAo6RwCcqLhv/Fpa
        JhtgtFWHUc641kOc8Pz+4qc=
X-Google-Smtp-Source: AKy350Z0/BBlkEGZm1T98jo0jsnaWp676sBKuaybDgOTY4zFNt2PUX0gexC0vOrdHlBAzmmDMc2nCg==
X-Received: by 2002:a7b:c7d4:0:b0:3eb:39e0:3530 with SMTP id z20-20020a7bc7d4000000b003eb39e03530mr1517475wmk.41.1681386046105;
        Thu, 13 Apr 2023 04:40:46 -0700 (PDT)
Received: from localhost.localdomain (host81-136-160-130.in-addr.btopenworld.com. [81.136.160.130])
        by smtp.gmail.com with ESMTPSA id k15-20020a05600c1c8f00b003ede2c59a54sm5272515wms.37.2023.04.13.04.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 04:40:45 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] arm64: dts: renesas: rg2lc-smarc: Enable CRU, CSI support
Date:   Thu, 13 Apr 2023 12:40:16 +0100
Message-Id: <20230413114016.16068-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Enable CRU, CSI on RZ/G2LC SMARC EVK and tie the CSI to the OV5645 sensor
using Device Tree overlay.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile          |  1 +
 .../r9a07g044c2-smarc-cru-csi-ov5645.dtso     | 21 +++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044c2-smarc-cru-csi-ov5645.dtso

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index ebcbd66ba816..7114cbbd8713 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -79,6 +79,7 @@ dtb-$(CONFIG_ARCH_R9A07G043) += r9a07g043u11-smarc.dtb
 dtb-$(CONFIG_ARCH_R9A07G043) += r9a07g043-smarc-pmod.dtbo
 
 dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044c2-smarc.dtb
+dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044c2-smarc-cru-csi-ov5645.dtbo
 dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044l2-smarc.dtb
 dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044l2-smarc-cru-csi-ov5645.dtbo
 
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc-cru-csi-ov5645.dtso b/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc-cru-csi-ov5645.dtso
new file mode 100644
index 000000000000..f983bdd3ea30
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc-cru-csi-ov5645.dtso
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree overlay for the RZ/G2LC SMARC EVK with
+ * OV5645 camera connected to CSI and CRU enabled.
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
+
+#define OV5645_PARENT_I2C i2c0
+#include "rz-smarc-cru-csi-ov5645.dtsi"
+
+&ov5645 {
+	enable-gpios = <&pinctrl RZG2L_GPIO(0, 1) GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&pinctrl RZG2L_GPIO(5, 2) GPIO_ACTIVE_LOW>;
+};
-- 
2.25.1

