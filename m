Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F5A677F5C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjAWPQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjAWPQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:16:18 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4885D298D6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:54 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e3so11104293wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BwvE+hNvEbi3ArWOS8f6NLx2uaIY7bZqvMw2mZCRaeA=;
        b=iP7yJcRevVyIXBqtFdr8hEo7XcmhpyEew73i7qZ5pDFf2YalJlT2+2L6eMhUJPKvEB
         ovwZdiGMiIv7uBhdLnysOFAehO+EulwFagYEitdoBL9AkAqEgd1cFgB9gT/eestKUQYg
         w7Ck3PhCfTHh/WACyDzEbJ2Q2quXKiQXJYBBKOy43IZyd5nI/eBNt1pgH4zkGC7/42QC
         KJ5sfTXcaMRmSI/xfJR3TTZsUsSepu+y6JHCHrIqB1V/vFdRfEzRYqtt/Yyqm3qgdb6O
         EUz1eZvjq3SkzwQG0geGVu7RqHO5hfiCDuyeHFc5kCdZWLjhN3HxQ6o1uOJg7RaMyWA+
         Ws6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BwvE+hNvEbi3ArWOS8f6NLx2uaIY7bZqvMw2mZCRaeA=;
        b=qoxGYTkB1bconPMQsHyacSnY3J1rdUCydj65KsiccaLOMtUwjifSeimRM/McIjewTk
         I7C429R0NATR0COdw0Fb0s6VK5OyWfUt2kSh4UNRIzKZxvHMN/d3XcxlG5A62wS4cT1J
         UCGPph2uMNLDSM0fu0w20vlEIibftrxjj54jFgofZtzhyRUuHd+3nZh7kVsaVMY660pi
         G6YzJc6hn4aD6hL/W+6pwwTtIpJHolzovBW+DlM1KUgxJpGrGvH7sdxnhVcGXHyNx4xx
         +QJv6DHXirhvHa4LfxZIlZHfT/Ftwsx5QTkBIJRViSUsQ9i0NU0U0TbbCTzNisiSkqQ0
         GIRg==
X-Gm-Message-State: AFqh2kqmLNmx2t9NibDnfHjank3cd9R/FRV4X/rSUgG5uYWPVi8wmH8R
        uyVA5aROUhjaFEtR6q+Iy5A+kw==
X-Google-Smtp-Source: AMrXdXvXAYJQnmYXSlnTplV70kDVJMFqJYVHSyXubKFl1NGZUowmauCODREwVM5q7htLRxlMX1aihw==
X-Received: by 2002:adf:dc81:0:b0:2a1:328f:23aa with SMTP id r1-20020adfdc81000000b002a1328f23aamr22075523wrj.6.1674486947191;
        Mon, 23 Jan 2023 07:15:47 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bt19-20020a056000081300b002bdc3f5945dsm30422593wrb.89.2023.01.23.07.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:15:46 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <atenart@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: alpine: align UART node name with bindings
Date:   Mon, 23 Jan 2023 16:15:45 +0100
Message-Id: <20230123151545.369762-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings expect UART/serial node names to be "serial".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/alpine.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/alpine.dtsi b/arch/arm/boot/dts/alpine.dtsi
index 4be9887033f9..ff68dfb4eb78 100644
--- a/arch/arm/boot/dts/alpine.dtsi
+++ b/arch/arm/boot/dts/alpine.dtsi
@@ -126,7 +126,7 @@ pmu {
 				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		uart0: uart@fd883000 {
+		uart0: serial@fd883000 {
 			compatible = "ns16550a";
 			reg = <0x0 0xfd883000 0x0 0x1000>;
 			clock-frequency = <375000000>;
@@ -135,7 +135,7 @@ uart0: uart@fd883000 {
 			reg-io-width = <4>;
 		};
 
-		uart1: uart@fd884000 {
+		uart1: serial@fd884000 {
 			compatible = "ns16550a";
 			reg = <0x0 0xfd884000 0x0 0x1000>;
 			clock-frequency = <375000000>;
-- 
2.34.1

