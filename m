Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD9565B795
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 23:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbjABWTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 17:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjABWSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 17:18:33 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C6E6427;
        Mon,  2 Jan 2023 14:18:32 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so21840598wms.2;
        Mon, 02 Jan 2023 14:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KKXFZ+lMwBLHZLuoEGCnH0Bp3cLI14BPpyhMMdZsrM=;
        b=K93PXgelRS6sMyH08JX/576Wzd+dQ/EIovgEkXhTHgJwJJ+fxcJpcZoxUNWVluMfPP
         cFnHiiUFN2nvtr5sTW5GD+nUyKITRJTRb1GdzDWPAUJtaNYPFDJ8jnLQNt/KbXTmj2tI
         p+0eN69MiwFTI3dZsJZ/ONH9HvB7TWEvCCtLz0JgkwmSgZMEeAKgLzeQhSijNpgSWum1
         0ybKzoDFjANcH3eQFllMhqkQQuTDzr7HmsjDZo9m05Nt7j3p+bHOLP5SU6ygmee0VaEB
         OK+npeIv+kyKSflmYWL4yc+tiCjK20d3/RpZsU3UF0TL/MvkWFpYconpBlILGo8DpNFe
         QmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KKXFZ+lMwBLHZLuoEGCnH0Bp3cLI14BPpyhMMdZsrM=;
        b=XEHWTYQQAGMBs0284qkDFKme80//iVYxvyVPh8cRu3+eT9ygP/8jB/46oBaKKvOzn6
         ZKQ+JkgpUuYQ7OGlnkV5wMzxzl33GCtPZAA5DI89WHh4HzHEZxUR3WIect5j8SAwLv/v
         d91B8I8yHxgSQxWM10YQmk80gUMMHd9ygR0j9E9qv1zcV7sRpvRn3yw7u+f1nEON5aE2
         5ExwRn3Qmhm3fr3C3n6GAw4H63QUrVBPuK2y1He/fNA9CKNVgXvVv0wkBlkOcG8cAmWa
         3ax02Gi9MSyq54iqQvH9E7IFuIKTq2Sp+tDfuRQWB0LdW/7WuCvnWFZaqvK+90bbRFt+
         pbUA==
X-Gm-Message-State: AFqh2kqjVfkaz3k450jYGp9mafBKOs2ok+2rrOJDdrSfjaULo7vX9sYP
        MkWKnz6mNpRiyHDeQojVxokfB6/NsCW8/7d9
X-Google-Smtp-Source: AMrXdXsdvkyZkVXi24HxKo43L2aPcD3YvyIvQSm3GH10bc/SR/A4ELS/QGVPRjbOT8qld1oFu1i0Yw==
X-Received: by 2002:a05:600c:1e1d:b0:3cf:b07a:cd2f with SMTP id ay29-20020a05600c1e1d00b003cfb07acd2fmr28855642wmb.37.1672697911184;
        Mon, 02 Jan 2023 14:18:31 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:8a7:e535:b020:566a])
        by smtp.gmail.com with ESMTPSA id n14-20020adfe34e000000b002366dd0e030sm29872463wrj.68.2023.01.02.14.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 14:18:30 -0800 (PST)
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
Subject: [PATCH v3 5/6] arm64: dts: renesas: r9a07g043[u]: Update pinctrl node to handle GPIO interrupts
Date:   Mon,  2 Jan 2023 22:18:14 +0000
Message-Id: <20230102221815.273719-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230102221815.273719-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230102221815.273719-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v2 -> v3
* No change

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
index 4ebf7335cdb9..9d854706ada5 100644
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

