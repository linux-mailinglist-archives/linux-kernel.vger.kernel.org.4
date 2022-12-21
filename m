Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86685652A40
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbiLUADl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbiLUADH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:03:07 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DAC1EEFD;
        Tue, 20 Dec 2022 16:03:06 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h10so13433043wrx.3;
        Tue, 20 Dec 2022 16:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awbhKbYqdDZxY2mihbijUFx+EfQkURzCbhYMpJ68hQ8=;
        b=KlMCQpPqtvHWQgSJQdmGVT+7pE/SitvLNZndFHphNMHWJK/zZqgKuge4RbTkb1o1ZH
         0LW5nSYurUxPhpqvSdV1gpOocSYFLfCY/V3oLIbpF3sTGP6+djqDaauRLnboDj8hgOy/
         UXm65S7PfCFTOviHgk5l+kwpzCrk5LUUFXSo/jc+z3E+JLk99aal/DY9v42jY6HV99WW
         fIKy1CJ0wqqow90Dt5q4AD/Pyfo5OC9U79NGKbYnIxKwW4YBALVcWN2gXx6x9uSOKso1
         WT3krOHiuOr0WtYVOJiLL6ohKhCyOs4ohNZsPxGhRWcfGsELMwXdrsPLQzHdRUuYLcaF
         2gJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awbhKbYqdDZxY2mihbijUFx+EfQkURzCbhYMpJ68hQ8=;
        b=EBCSCqASIY2k2WfqMe087KL1LH4L/SajeJX30CpgEMfQUqkkMXFdFEKVvyYN1KOsuv
         nPXGb1VjDmOBR6YOu1zQmFoCg7s1GjKN+FDng2zii0T59tXWOQyGjWH03RRQQ57sPdSf
         Jj81btG4cB7XO1yHsQdTNx4ZpVxyeedxuYJncxnQhllJD6HpjEhClDYYUu9MfHNVVH7F
         p+pZZ4gpqfmNuAlLxp6rzMigSVgQrNAMtJEN8q2Nr1X0c5Vg10tiZ4a31MPKuz0LrCGw
         x7ICGczs42IzTAA/e4MKVWKumQkp/Z3NsVCeBFU88iMMmjyC8MSs+geCm1fpkkOsfeLC
         QJvA==
X-Gm-Message-State: AFqh2kqdu8ca8pI0/14LhBKP5nj+eprPf22s/hRuDanSwB8LcLrRpRvD
        Ke4Xx1lJ+7k8L2xfzGoSSTU=
X-Google-Smtp-Source: AMrXdXuGZdQZlCDYdGWNJ63k7gmDEWAMJCSQe/wcIlsu9tQdMtNrukFmoPmXc22QLLx0cvDqeCm21A==
X-Received: by 2002:adf:e5cc:0:b0:269:2b79:4cce with SMTP id a12-20020adfe5cc000000b002692b794ccemr1645314wrn.65.1671580985286;
        Tue, 20 Dec 2022 16:03:05 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:1595:a48c:95a8:15e0])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b002362f6fcaf5sm13740150wrt.48.2022.12.20.16.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 16:03:04 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 8/9] arm64: dts: renesas: r9a07g043[u]: Update pinctrl node to handle GPIO interrupts
Date:   Wed, 21 Dec 2022 00:02:41 +0000
Message-Id: <20221221000242.340202-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Add required properties in pinctrl node to handle GPIO interrupts.

Note as IRQC is not enabled in RZ/Five the phandle for interrupt-parent
is added in RZ/G2UL specific dtsi so that RZ/Five pinctrl driver
continues without waiting for IRQC to probe.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1 -> v2
* No change
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi  | 2 ++
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 3f7d451b1199..c8a83e42c4f3 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -531,6 +531,8 @@ pinctrl: pinctrl@11030000 {
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-ranges = <&pinctrl 0 0 152>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
 			clocks = <&cpg CPG_MOD R9A07G043_GPIO_HCLK>;
 			power-domains = <&cpg>;
 			resets = <&cpg R9A07G043_GPIO_RSTN>,
diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index c6e25ad98011..a31cc54b8ed6 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -49,6 +49,10 @@ timer {
 	};
 };
 
+&pinctrl {
+	interrupt-parent = <&irqc>;
+};
+
 &soc {
 	interrupt-parent = <&gic>;
 
-- 
2.25.1

