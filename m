Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64BE5F9390
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 01:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiJIXgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 19:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiJIXgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 19:36:31 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF426301;
        Sun,  9 Oct 2022 16:08:01 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id j16so14655127wrh.5;
        Sun, 09 Oct 2022 16:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1k8ExoMgrE+90/H+Qb7B7JrKHLRNmY/hLhdAbvuUyE=;
        b=WaYUEZXDeGG+pRnum0F8XUyzTglhDgJumMaK6mqxk2OgXZRSg39P5ykguGnEH5EObj
         GzY3kVDD2G/BLV+6IFrRM2BSXHmvuY8X2//pPUwWH7H3o4rzgksEx/IHrMGG2jlIrnop
         jElgqKuZgYPkvMRSUQBsrlibNikj4EPYfhcgs3yGO6FEjLoIiPGtuV4TlM/L2FQwtJUb
         mNW3VtElfNshT2cK/QEBUs4zq9Qjvny4HGfxMroRZy8uJ0Ni8OZHQRPjBZ7r4bq4w0Qx
         ucclPOliGYsXYrx3vDm2DKDq3GV41x21e5PXZh5PyRggyew9Tf62+iwgDTPvVEQ/g3CC
         LLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1k8ExoMgrE+90/H+Qb7B7JrKHLRNmY/hLhdAbvuUyE=;
        b=aHjzTAnzApsx7wNbtm7wOMKms4oihDmKHVRVvNBuvJCAwFwAXhHkx8tnOAgN4ca5Md
         AvzlxX0NSN2xx5qeKaazN8xh5hi4pgGOoGMvD0VM1TPvwOOe5DIevhoTI8636i+e1uNu
         PRX3tGykdL5kZnBRr9/TbvF+zPf/T+TqmEO/SeTLy9rxM2J8TMIT/RqV3ENOvEaBA0ek
         zJRLx/9/VJ+ZsBu6F9Uld/lRiwuuI4IFKeN3vRC0a/OauKIGr++ibZDJQ5B29AgE3dwM
         E0eeJExjiUmWATxZm75JPbsgoRVTSZ5DoxJGXUgWvTe+5VIdlBvKoVGgsOW6vK/HBpF/
         bKZw==
X-Gm-Message-State: ACrzQf3li1s2iIldR2yVuZndZWUyr9wOAq7nWp6ObRaxKZJ0bsYU16Ek
        NAwu67rSFPlvGCoyx+JQhOo=
X-Google-Smtp-Source: AMsMyM4FZCJpgj1UrHoG5gIC4RReB0T1U7XDnLsp1tIzpDgY/qGNTdqFCvr+985hJo4NwGTGUU0XPA==
X-Received: by 2002:adf:dd8d:0:b0:22e:4675:86c9 with SMTP id x13-20020adfdd8d000000b0022e467586c9mr9326722wrl.643.1665356462907;
        Sun, 09 Oct 2022 16:01:02 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:e4:5cde:80ab:dfd4])
        by smtp.gmail.com with ESMTPSA id r16-20020adff710000000b0022afbd02c69sm7239689wrp.56.2022.10.09.16.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 16:01:02 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 4/5] arm64: dts: renesas: r9a07g054: Drop WDT2 node
Date:   Mon, 10 Oct 2022 00:00:43 +0100
Message-Id: <20221009230044.10961-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221009230044.10961-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221009230044.10961-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

WDT CH2 is specifically to check the operation of Cortex-M33 CPU and if
used from CA55 CPU would result in an unexpected behaviour. Hence drop
WDT2 node from RZ/V2L SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 358d4c34465f..7c7bbe377699 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -1000,21 +1000,6 @@ wdt1: watchdog@12800c00 {
 			status = "disabled";
 		};
 
-		wdt2: watchdog@12800400 {
-			compatible = "renesas,r9a07g054-wdt",
-				     "renesas,rzg2l-wdt";
-			reg = <0 0x12800400 0 0x400>;
-			clocks = <&cpg CPG_MOD R9A07G054_WDT2_PCLK>,
-				 <&cpg CPG_MOD R9A07G054_WDT2_CLK>;
-			clock-names = "pclk", "oscclk";
-			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "wdt", "perrout";
-			resets = <&cpg R9A07G054_WDT2_PRESETN>;
-			power-domains = <&cpg>;
-			status = "disabled";
-		};
-
 		ostm0: timer@12801000 {
 			compatible = "renesas,r9a07g054-ostm",
 				     "renesas,ostm";
-- 
2.25.1

