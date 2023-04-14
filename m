Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18ADB6E251B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjDNOD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjDNODs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:03:48 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DA9E60
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:03:05 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id r9so5221317ljp.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1681480974; x=1684072974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YA5l458OG2xTSndJtJKAZvkZUt5Wi8ebzINtZE34dg=;
        b=m3EUEris+Gszu2c+E8GGw6gGzpt4sDNj107p2ZIilXUFmbTbGsKLm6NdlOpQpptIUX
         N4Qq7fKgJ3NbBQfGSO/Y2l9AXqga816Fb33t7GdzoycHpBzJi0BPR+Im58EHuYePTr6K
         35qfsSB/ws4Q1yFa4Mq8SFyn4LPeWPvhJRHe+T0wrel5WDLLUzplMShn5K6uIirBp2Q0
         2QU3tAnK7/4Wls5/mUAMlPpLRAjT3/jrwlbR8R7vYexFu+KGiUFTzVpY41YACjeaziR0
         mnRcRfK/RHRl3paL2KBQ3tG2yGWJlybKfJsDKRb+2XagAOqcQx51qVWjGhX2UP5NiqV6
         6Tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681480974; x=1684072974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YA5l458OG2xTSndJtJKAZvkZUt5Wi8ebzINtZE34dg=;
        b=RdIl9WpbV/v9Kl7mWEQWuUy1VAsx5in666vPMhIlmRnhgABPWosLHWgMqUbITRKGyh
         gj3o1fWEBO1+ASE3SIZx/jFN/eYGnw1UulfRbHJuU3DWWza2trirJOlvNuzwsSRQq89K
         ZIM8MGR1RX8toDnXC5W3u010g1w86jzYHfg/cROTa5vB/ZoHM1KiEHLnnN4LgKXiMtqN
         f9lNNTPlMu6JZYSLlbJNABttIJ/R9veV/+0UMFq7pL3I2OG6ITUtUjJIlaMc5l2g5XJ2
         mU/NXgCRgIqbPzBkuOoV4WoJWr/LLn77jWsJWtJ4X6TdhUlMsfvQ6xptAPfoge3oEEgh
         yHbQ==
X-Gm-Message-State: AAQBX9epSoa/FDPrPGUIezALMzTm87vu3BtHV6Qrxs+CHhst3F6hzxv4
        xbMgafe7p673sTGo8GyMLuNJvQ==
X-Google-Smtp-Source: AKy350YAbEsWVjeiiZRye1QbGqhGM+1HTvCZL1EsMT7NMasjE6Bie7EA43J69Wcu8qE2YMAwAr66iw==
X-Received: by 2002:a2e:880a:0:b0:2a8:a573:aed5 with SMTP id x10-20020a2e880a000000b002a8a573aed5mr1333306ljh.27.1681480973763;
        Fri, 14 Apr 2023 07:02:53 -0700 (PDT)
Received: from panikiel.roam.corp.google.com (staticline-31-182-201-26.toya.net.pl. [31.182.201.26])
        by smtp.gmail.com with ESMTPSA id 15-20020a2eb2cf000000b002a76e2dedbcsm828684ljz.139.2023.04.14.07.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:02:53 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH 9/9] ARM: dts: chameleonv3: Add ssm2603 mute gpio
Date:   Fri, 14 Apr 2023 16:02:03 +0200
Message-ID: <20230414140203.707729-10-pan@semihalf.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230414140203.707729-1-pan@semihalf.com>
References: <20230414140203.707729-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ssm2603 mute pin is connected to a gpio expander. Add this
connection to the devicetree.

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
---
 arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts b/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
index c75f41058196..81e83ce0f8e7 100644
--- a/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
+++ b/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
@@ -3,6 +3,7 @@
  * Copyright 2022 Google LLC
  */
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
 #include "socfpga_arria10_mercury_aa1.dtsi"
 
 / {
@@ -67,6 +68,7 @@ &i2c0 {
 	ssm2603: audio-codec@1a {
 		compatible = "adi,ssm2603";
 		reg = <0x1a>;
+		mute-gpios = <&u80 0 GPIO_ACTIVE_LOW>;
 	};
 };
 
-- 
2.40.0.634.g4ca3ef3211-goog

