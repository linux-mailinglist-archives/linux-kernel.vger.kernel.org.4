Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0DF715CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjE3LVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjE3LVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:21:08 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257B9E8;
        Tue, 30 May 2023 04:21:06 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3909756b8b1so1442319b6e.1;
        Tue, 30 May 2023 04:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685445665; x=1688037665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZAcV0XNcMwrhSLLa6b9f3EOQQtrnYuiRx8TP1TjfRs=;
        b=q5+FzL0bPNCscQLgbG5qP397449sMQM06sM1URLamdujhkCEyPJPRIvVYu0izRkAQE
         +5kkaNJyYSzZeI2vm4N7Sax7llgUQIW6hxlX5CLP/2A0r7h9B67RdjDqEgT6mFZC/hKh
         KucA3MtGbzMwnAkbIolfd/f/9+DrEVnlKYJ8jg024dYqMNX8U6+CAP8mf1Lg81yrlbZT
         G6ulBgxDGTnQq6YoD7j75PAaf3IqhKiFXSgw8QHbgo5RnYctQQMLgqOSTaLNoX3fPHGb
         LXx6L8H1BWoINUOhwGNOuMM2lS7hIMMQB3gkLeTUfhUuWP2+/N69cBLDBm7556IeD3rv
         ZH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685445665; x=1688037665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZAcV0XNcMwrhSLLa6b9f3EOQQtrnYuiRx8TP1TjfRs=;
        b=Kv8cuejAwcMPG78CpyXyko6K5geFbto+RywzypFlSLQEfUorNO1UwLMeVsh279MiTu
         9TYn1APcD2OV3POi8EvqXz6XlMspSb+Lqrt0kFu+mVgg6GwS7mhpBxBoCwbkOZiv1Ua/
         uE6gTCur8lilp0eV442+ae5MpHbJ9MqfIepUfdSDVfM6oUQLlK4kYPmu9XXmPH1RFMpb
         Tf80UxBadhW4PyQ32nFBctFRugIxFc+1eBLJ5u+pzA/WRMiXERYYZuXAAkyEAnto+5fT
         SWN5a3/hp2ciba2nS0dsUd71mVGb77aEAWm6gxOSu0fk2GRJgUmWBGIefpPzNPTSo7OT
         CgZQ==
X-Gm-Message-State: AC+VfDw6TNkbvNC0BO/6DO+deKRg9XmQPavpQBHpvd5WyoapC2qyrZHp
        lkMz/zXtjpTurXeS34NCNAZr/bvNb+s=
X-Google-Smtp-Source: ACHHUZ5Cu+qH+LAnGrvdDaNMQ2BwkspOHGM162mOCOgRwL3FKMJ/A11CHnMxdYWdt8SZPoqYCRl7Tg==
X-Received: by 2002:aca:705:0:b0:398:937:6011 with SMTP id 5-20020aca0705000000b0039809376011mr861717oih.20.1685445664899;
        Tue, 30 May 2023 04:21:04 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:a5e7:c9e9:bb20:39c1])
        by smtp.gmail.com with ESMTPSA id co17-20020a0566383e1100b003c4e02148e5sm634363jab.53.2023.05.30.04.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 04:21:04 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     biju.das.jz@bp.renesas.com, marek.vasut+renesas@gmail.com,
        cstevens@beaconembedded.com, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [RFC 3/3] arm64: dts: renesas: r8a774a1: Add GPU Node
Date:   Tue, 30 May 2023 06:20:49 -0500
Message-Id: <20230530112050.5635-3-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530112050.5635-1-aford173@gmail.com>
References: <20230530112050.5635-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the 3dge and ZG clocks now available, the generic GPU node can
be added.  Until proper firmware is made, it is not usable.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
This is based on the assumption that the Rogue 6250 could use
generic driver [1] and firmware [2] being implemebted by the Mesa group
and others.  In practice, the firmware isn't really compatible since
the 6250 in the RZ/G2M appears to be a different variant.

[1] - https://gitlab.freedesktop.org/frankbinns/powervr/-/tree/powervr-next
[2] - https://gitlab.freedesktop.org/frankbinns/linux-firmware/-/tree/powervr/powervr

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index c21b78685123..7e5816113a3c 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -226,6 +226,27 @@ extalr_clk: extalr {
 		clock-frequency = <0>;
 	};
 
+	gpu_opp_table: opp-table {
+		compatible = "operating-points-v2";
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <830000>;
+		};
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <830000>;
+		};
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <830000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <830000>;
+		};
+	};
+
 	/* External PCIe clock - can be overridden by the board */
 	pcie_bus_clk: pcie_bus {
 		compatible = "fixed-clock";
@@ -2347,6 +2368,18 @@ gic: interrupt-controller@f1010000 {
 			resets = <&cpg 408>;
 		};
 
+		gpu@fd000000 {
+			compatible = "img,powervr-series6xt";
+			reg = <0 0xfd000000 0 0x40000>;
+			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 112>, <&cpg CPG_MOD 112>,<&cpg CPG_MOD 112>;
+			clock-names = "core", "mem", "sys";
+			interrupt-names = "gpu";
+			operating-points-v2 = <&gpu_opp_table>;
+			power-domains = <&sysc R8A774A1_PD_3DG_B>;
+			resets = <&cpg 112>;
+		};
+
 		pciec0: pcie@fe000000 {
 			compatible = "renesas,pcie-r8a774a1",
 				     "renesas,pcie-rcar-gen3";
-- 
2.39.2

