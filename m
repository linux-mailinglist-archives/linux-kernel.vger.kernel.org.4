Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F75D5F94C4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 02:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiJJAG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 20:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiJJAGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 20:06:01 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AB5B7E2;
        Sun,  9 Oct 2022 16:39:47 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bu30so14709232wrb.8;
        Sun, 09 Oct 2022 16:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCmeO7eLk7Whj4sq2p+anE/GFIH3HaIi9Zm1K77Z+rg=;
        b=YXMp2No1KMvGGEPZK6KQaNiIjfAofBWJ5USAaNhtLGkAntPhwZyJEqK28+ncwOjEgj
         ScclSiAhexUImXCc8XYOgenKmamBpyrehyDiuO226gIgxo4/SNHxrfWerTgYoz9TAVii
         +IKi+i4wEkCzhElkafxZSom4PEysChAWT3CAmp8XrOKIOvW3qv3TY8v7b9yPNaM3eS7k
         /fU/B8EhNTjxaF4OEOpugNOjWp+Ijwd4KzJ0+joR22xGQ5Arx7ikjw/w96fRfXcbkkG5
         w8bGdny/bYz2MPsNJrr9kNv8ewY4ru0UIJ3BPKuNtZn4qhil0CZUu+KJLdmXtqoXQ8vl
         scPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCmeO7eLk7Whj4sq2p+anE/GFIH3HaIi9Zm1K77Z+rg=;
        b=D9la5c/dSKwOH8EzUU3cm8mVCGSm68rH71fBQZSLU3btgKL+6n389MTXR7GJ/TejBl
         MlRUtWmih6vjsFprflQzBed5f+4jtm2/gFLWpfTIoLmUHYM0l0Pql44C5EHAf1kwmvT7
         +aqdCVyrCLaWs9rrCrhOKZuVJGyaFn7QwKpfST5IaM/BXEwrJi6A1O/pi8LT3ooVBze6
         ggEoRmgMXgp8sdZC5whump8G+HgDnIkmYNOPvv0QVW3BoBtaMzJwYG4KFtxVBTQ0B2St
         TrKoyv5I2pdIjl+yyJNwqZ5pmU4xpOWNYBOVvIq5GM1Vk1AGq3qV3+6ocRVMxpY4KAVc
         zqXQ==
X-Gm-Message-State: ACrzQf1Te+OGEJyjmEusaVKBt6vQs+Gl3cZz58wt440GsilBZ1NM1Dr2
        sE8IH78KCLCDZKOPNh7MCFY+alFNb6RXFA==
X-Google-Smtp-Source: AMsMyM46cs4TZTGyY/4e5N8zP8tZWw/LX45Qb+GnvhI8U42wAfPoeZjCr4pa5K4R/PluiFky39v+Bg==
X-Received: by 2002:adf:d1cc:0:b0:22e:6371:65ad with SMTP id b12-20020adfd1cc000000b0022e637165admr9812976wrd.326.1665356463914;
        Sun, 09 Oct 2022 16:01:03 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:e4:5cde:80ab:dfd4])
        by smtp.gmail.com with ESMTPSA id r16-20020adff710000000b0022afbd02c69sm7239689wrp.56.2022.10.09.16.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 16:01:03 -0700 (PDT)
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
Subject: [PATCH 5/5] arm64: dts: renesas: r9a07g043: Drop WDT2 node
Date:   Mon, 10 Oct 2022 00:00:44 +0100
Message-Id: <20221009230044.10961-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221009230044.10961-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221009230044.10961-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

WDT CH2 is specifically to check the operation of Cortex-M33 CPU and if
used from CA55 CPU would result in an unexpected behaviour. Hence drop
WDT2 node from RZ/G2UL SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 689aa4ba416b..c1fb29de2fa4 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -820,21 +820,6 @@ wdt0: watchdog@12800800 {
 			status = "disabled";
 		};
 
-		wdt2: watchdog@12800400 {
-			compatible = "renesas,r9a07g043-wdt",
-				     "renesas,rzg2l-wdt";
-			reg = <0 0x12800400 0 0x400>;
-			clocks = <&cpg CPG_MOD R9A07G043_WDT2_PCLK>,
-				 <&cpg CPG_MOD R9A07G043_WDT2_CLK>;
-			clock-names = "pclk", "oscclk";
-			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "wdt", "perrout";
-			resets = <&cpg R9A07G043_WDT2_PRESETN>;
-			power-domains = <&cpg>;
-			status = "disabled";
-		};
-
 		ostm0: timer@12801000 {
 			compatible = "renesas,r9a07g043-ostm",
 				     "renesas,ostm";
-- 
2.25.1

