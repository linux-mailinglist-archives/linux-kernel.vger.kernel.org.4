Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE705F93C4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 01:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiJIXpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 19:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiJIXok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 19:44:40 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8A04199F;
        Sun,  9 Oct 2022 16:16:23 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g1so14288978lfu.12;
        Sun, 09 Oct 2022 16:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSnKs0zKiN+ItvIpVEFcwhPejaXQcH+vaJ+axtSNRYA=;
        b=WpLlvWsTU9DQy/fHX4L578cEdOecpJI3SAEDtO95Ke1gWFx4VNRLzH/5w1DK6Sgna9
         YuJ99aoQJANags/XhUF+V6fTdPSOCf8fIPw+17wpHMtDQG2AgRvVcyis7jRKOpfKAslL
         GPMBZZHeQ543hYH3oGWIP9Cf5OQf6RTcAGX0msqFmCU6tgHHfKxyTPR955RE0R711u2T
         q/qBTMwuDJ/kt2+NDkvvTFnvgyXHLRirbKHTe7ZTsqi3onkmvHPs5Oem9pheJpr6c4rj
         9v7YBAQ8SoiCdjRUiy2x0bl3RIGRFTCxC2KIPhxHcDsD7iW6hwHtsWRKPXFsaCDhIRUC
         Ilhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSnKs0zKiN+ItvIpVEFcwhPejaXQcH+vaJ+axtSNRYA=;
        b=kTmBGnWAaViSYVZK+rypqM3k/8RnNC65VgjF9CAt3T1156Ij6WnucL3UEjMJ1O6QFc
         uvSbyjZF1TvUawoZIzuT6apEkdcFKxO1HhvMCoJR0dPB4XCX9WWo4b6+YzVQXgivrkna
         PeLPADTVoVkTpVW/X+V8vD7kOIW3Zwmisvh9Gigy/Reibr6gWjd9MgT3zRsQgqTv2zTp
         NBo9f8ZBoTlyQN39Aeejrcu5Tq6GZ1qIVSP/tjft4lEB9OMT6sy9MAxDrPbWvf85UjMp
         Wzn9PcBJYASsTw3U92XERgu4LbLEAFx6pKeYp4Sv5M8FFIkFc0bX6FqgccfQKYRD8Db6
         imBw==
X-Gm-Message-State: ACrzQf14KKOfe20gHWM7Yih6yIyv6sX5013hdSVFMKEQ1ApkieT15U5u
        MDfkNb8+Ya2YQNgPt51RiZ9rY/14VeOtSA==
X-Google-Smtp-Source: AMsMyM48dKtxGsLdUbiAwPcvmczwRpmVgjGpgAkGC/va6UYs5oIhnp68pJ1r5wfr6ox2dyVcXcFmmA==
X-Received: by 2002:adf:cf0a:0:b0:22e:3f43:a5f7 with SMTP id o10-20020adfcf0a000000b0022e3f43a5f7mr9737278wrj.634.1665356461865;
        Sun, 09 Oct 2022 16:01:01 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:e4:5cde:80ab:dfd4])
        by smtp.gmail.com with ESMTPSA id r16-20020adff710000000b0022afbd02c69sm7239689wrp.56.2022.10.09.16.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 16:01:01 -0700 (PDT)
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
Subject: [PATCH 3/5] arm64: dts: renesas: r9a07g044: Drop WDT2 node
Date:   Mon, 10 Oct 2022 00:00:42 +0100
Message-Id: <20221009230044.10961-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
WDT2 node from RZ/G2L SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 2283d4fb8736..c606d9ef5991 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -994,21 +994,6 @@ wdt1: watchdog@12800c00 {
 			status = "disabled";
 		};
 
-		wdt2: watchdog@12800400 {
-			compatible = "renesas,r9a07g044-wdt",
-				     "renesas,rzg2l-wdt";
-			reg = <0 0x12800400 0 0x400>;
-			clocks = <&cpg CPG_MOD R9A07G044_WDT2_PCLK>,
-				 <&cpg CPG_MOD R9A07G044_WDT2_CLK>;
-			clock-names = "pclk", "oscclk";
-			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "wdt", "perrout";
-			resets = <&cpg R9A07G044_WDT2_PRESETN>;
-			power-domains = <&cpg>;
-			status = "disabled";
-		};
-
 		ostm0: timer@12801000 {
 			compatible = "renesas,r9a07g044-ostm",
 				     "renesas,ostm";
-- 
2.25.1

