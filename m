Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73BC6FAD2F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbjEHLcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbjEHLbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:31:46 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6B03D209
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:31:02 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f00d41df22so28208382e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 04:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1683545460; x=1686137460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhrKh4Q91sZcDX0gh+ihiUBjUKwTDAbt/DVIKMwpD58=;
        b=lUUfpAeVYiOp9sTbu7V2dri2yipImnljXZO7JnejQP6OpjQt/zWkyKihYCsVro6o7l
         S6UoN+QxuZHfcuwgC7cHr0l/mHxbd8R51UUYxQf7lq+3B8QRTTEtR79Gd3vqBdR4HjB7
         ORczo3vCzMS1X9nxfzh1q1ueq1vL4qovPEgx3aNxeJfYNfBk1PQw9qUyEttYkaCKijrP
         v0ilfSf5XaV/Tm0RaeID6+sTVhfZhWbnJXFaWc1G/55u9fKVa4vyaX0iqEkIWDQzRaPH
         a7LMrAUfDUv92d6hkbLrHXZSZTHomOqJ8DxpjfGweDH2J38eBlSoyQkC7btL/t9C4adM
         xudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683545460; x=1686137460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhrKh4Q91sZcDX0gh+ihiUBjUKwTDAbt/DVIKMwpD58=;
        b=BPikLsMElbE8s4jFZ9w1WA2pCNV0b2nEGH8hfBPyyOKh1oRvbd7jqm0hFndtgjW/W1
         rN8sAWkpfCJ/2CwWiD/lom1Cbx+ZX7I1Pf78lkZVPNHnXCHorDIDP/EKQnWRmUczRWmq
         iftTodj74JSNzE2tzh1hOlYM7h9bOFMu8dLc96rhYPC1DNCzFer39e2JilePA29/Cmmu
         riGy3ANRzraknod6/x/uhwdfzl5/StxEKYkRASdrhpGDfBM8AoYBoIgNozHh2lSKBf2U
         /3L0y4DrjZK5mfA/CYttzB2gPzeQ6vgh/C4L3vdDSd6PdPWY7/ZpsIrz9gw1lP79PFJF
         M+sA==
X-Gm-Message-State: AC+VfDzlA+rT4fAe1Zk6brVqxY4CbBgtA2ligtPUD3+VengaXCOicVjo
        cX9pbAXni9E4lVuUmlac56Lh2g==
X-Google-Smtp-Source: ACHHUZ4C5KbrYUeGkSphmYDewWuv94QqJjr9H/rTtEfQLFyPH78jorLDZ2/w5tdPPZSc1PQ/QXjNPg==
X-Received: by 2002:a2e:8e3a:0:b0:2a9:d4f0:6 with SMTP id r26-20020a2e8e3a000000b002a9d4f00006mr2845808ljk.17.1683545460507;
        Mon, 08 May 2023 04:31:00 -0700 (PDT)
Received: from panikiel.office.semihalf.net ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id k8-20020a2e2408000000b002a8b9353338sm1144406ljk.117.2023.05.08.04.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 04:31:00 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com,
        amstan@chromium.org,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH v2 6/7] ARM: dts: chameleonv3: Add Chameleon v3 audio
Date:   Mon,  8 May 2023 13:30:36 +0200
Message-ID: <20230508113037.137627-7-pan@semihalf.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230508113037.137627-1-pan@semihalf.com>
References: <20230508113037.137627-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dts nodes for i2s, audio codec, and simple-audio-card devices.

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
---
 .../boot/dts/socfpga_arria10_chameleonv3.dts  | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts b/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
index f0483ef46a36..a69819e26144 100644
--- a/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
+++ b/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
@@ -15,6 +15,61 @@ aliases {
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 	};
+
+	soc {
+		i2s0: i2s@c0060300 {
+			compatible = "google,chv3-i2s";
+			reg = <0xc0060300 0x100>,
+			      <0xc0060f00 0x10>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+			#sound-dai-cells = <0>;
+		};
+
+		i2s1: i2s@c0060400 {
+			compatible = "google,chv3-i2s";
+			reg = <0xc0060400 0x100>,
+			      <0xc0060f10 0x10>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			#sound-dai-cells = <0>;
+		};
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "chv3-audio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		simple-audio-card,dai-link@0 {
+			reg = <0>;
+			cpu {
+				sound-dai = <&i2s0>;
+			};
+			codec {
+				sound-dai = <&chv3_codec>;
+			};
+		};
+
+		simple-audio-card,dai-link@1 {
+			reg = <1>;
+			format = "i2s";
+			cpu {
+				sound-dai = <&i2s1>;
+			};
+			codec {
+				sound-dai = <&ssm2603>;
+				bitclock-master;
+				frame-master;
+				system-clock-frequency = <22579200>;
+				mclk-fs = <512>;
+			};
+		};
+	};
+
+	chv3_codec: audio-codec {
+		compatible = "google,chv3-codec";
+		#sound-dai-cells = <0>;
+	};
 };
 
 &gmac0 {
@@ -39,6 +94,7 @@ &i2c0 {
 	ssm2603: audio-codec@1a {
 		compatible = "adi,ssm2603";
 		reg = <0x1a>;
+		#sound-dai-cells = <0>;
 	};
 };
 
-- 
2.40.1.521.gf1e218fcd8-goog

