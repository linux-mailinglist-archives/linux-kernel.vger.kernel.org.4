Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD22A74500F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 20:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjGBSxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 14:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjGBSxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 14:53:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ED8137
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 11:53:10 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51d7f350758so4808982a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 11:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688323983; x=1690915983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AGR+gmEwpH8OpAM+s2Yo943Xz+OPgJSs9ljWlvL2KmA=;
        b=E3OBMzDkJphhRHjhbLI1UWgnDAD0k071R4U63r2UlqgzwjJ9kzGlv6XdCIjm7VF5m8
         zEkTcUmfVife8O3s0Vi5xOcSgNC2lnwVFHj2NCazrvdIzAtuVE5kTLU1DfY/Od0boN3T
         UeEtQSlkwXZUrwkIft6ezW6Lmqr3qgYpGmh8xjitGaH4qKMMqN09tiMwlTcn5M1MTEim
         s7TgJjXoSbSbDc5TE/fNcM47LFRFI6ACXfFlmIiHpcDiM4ytM6XEJdcAu1HJEDybk0iI
         bgWlxmROS4LpvCuqcvPN73tSmkq6+5nfFK3P6arajHjkVMT07iqnueYnaRJlJjahjgqI
         tKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688323983; x=1690915983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGR+gmEwpH8OpAM+s2Yo943Xz+OPgJSs9ljWlvL2KmA=;
        b=k12JNUGMHbwu/rZ7TOsKWIheXFVlREwF8RlSAN/ObBt9tsPyjtypaHf5AYigxZPYFV
         IO303qA0tRAEWfdIe44sqN1r9lyqbeKUVO4B4z4Kw1btYjKRUUwZNNe1nKyTtW7qA1CK
         stNH9lkjiyIOLJg1kDFZ5yVRIg6V0QqFM3Zo/N5n1iJlgPOrzO44VAM5gL6gnEML6PUQ
         7SOmFqSHBNggoTUNj9Q6xQ27yXe0287Zqu7ry9rbykS1dbD/eJqMim8OwsWW7TPkpW+q
         yetH309IVzYwz88GnxG1uFNszuaSWAoKmNsyRLlzbUbiwMXqLEalKn4Cu/bhCCajsV0k
         AjQQ==
X-Gm-Message-State: ABy/qLZZdjbJzWfhV6XSUeONQKeTFOLt+mLB8FhNkgWTOA7/pTGfZKBF
        Bos3LhIRN73foRZPQgLAQpkd7g==
X-Google-Smtp-Source: APBJJlGOQOExFqZtw+X3/bQt6Aef7O8fjpVmLAcgoZAiCoK44krLlc5NNQjWUVPE2kO9WFY93T4woA==
X-Received: by 2002:aa7:d7cc:0:b0:51a:5c1d:5c06 with SMTP id e12-20020aa7d7cc000000b0051a5c1d5c06mr5556137eds.42.1688323983111;
        Sun, 02 Jul 2023 11:53:03 -0700 (PDT)
Received: from krzk-bin.. ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id w14-20020a056402070e00b0051ddf53c623sm4336447edx.2.2023.07.02.11.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 11:53:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: marvell: minor whitespace cleanup around '='
Date:   Sun,  2 Jul 2023 20:53:01 +0200
Message-Id: <20230702185301.44505-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

The DTS code coding style expects exactly one space before and after '='
sign.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
index c9ce1010c415..8c61b027eb2c 100644
--- a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
@@ -144,7 +144,7 @@ i2c0: i2c@11000{
 				clocks = <&cnm_clock>;
 				clock-names = "core";
 				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
-				clock-frequency=<100000>;
+				clock-frequency = <100000>;
 
 				pinctrl-names = "default", "gpio";
 				pinctrl-0 = <&i2c0_pins>;
@@ -163,7 +163,7 @@ i2c1: i2c@11100{
 				clocks = <&cnm_clock>;
 				clock-names = "core";
 				interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
-				clock-frequency=<100000>;
+				clock-frequency = <100000>;
 
 				pinctrl-names = "default", "gpio";
 				pinctrl-0 = <&i2c1_pins>;
-- 
2.34.1

