Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35A56C96F0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjCZQr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjCZQr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:47:56 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790594C28
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:47:55 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t10so26415742edd.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679849274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d+t9quZI40H0SICIWubeZOL2PZ33/cypkKWWx+K52uk=;
        b=JxMvIUJymY0NKfVB/F/uMVb5FWt+KL1HfEmNopAn72YDZIgund07S7NAGaL/MpgwN+
         hKxdZmk4LlFQdYqKoFOOhdJQcZh+h4YeU2rWNsw+rQG+/rutThmyXqffqzcIyd5uuUFS
         j3KYU4BupFN/o22ClumZc/nypMne6wG60BZhQpOS9q7pQ/vsKUMKTd5onpTWWHpeTlnq
         M5561tYpHlNn7/Na0JR6TAdUZCRpXfoJjGfPwbXA4zfnu6OGTeKxrIYdeaQ9lj8k63eI
         8C9xFNinlslsZ6tCAtyY5MTQ1+tD4xHrtmie2ebjX0AV9OSSZJf3d8wzqfPlV5fmoa7l
         C73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679849274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+t9quZI40H0SICIWubeZOL2PZ33/cypkKWWx+K52uk=;
        b=HMprawzILYy3//0oLUbC+aD9iDEQTGX3+7C4CONeY4xqDMP4PXZNZF/IC6uKZ1OngW
         R1zOItAqoa9WBAwFs29m5U1VOinwiYwiF25Nqrpat5JgO8ULHJC5/HYBAx/HivicSFLw
         fPqPWgzSb+AOxL6FWxYvrqnZTHFf7EKUz+RWa7WPYnte5d8fyOGgCsM55Gb9tWwg9g+u
         DR3sBhYhYljggemFZqVWeFtYU3G6C5wk5SsFdzJcMmbVwLOpmt0kC71GrC0Ke/0L2gg3
         qhrK3nlNlkEvmqNbgA5ceOTh5Vqg5ntVA40iTYuPkiXosQUUvg/+rtfFhtwxMdpOAM6E
         6zYA==
X-Gm-Message-State: AAQBX9dhusPsRicytGNyWI2EOIREw0Q2gnDPALmFLDG0s7KyC2Wrgqi6
        vIrs/zXucbmNY7EtJh1tcnluPg==
X-Google-Smtp-Source: AKy350ZvBl+hiLf4EcOy+Xnugmi4VSxHZTjFBB5xT/Pg62Ee+OlYhDqqJRN25Uj/HQbYxzy11U4B3A==
X-Received: by 2002:a05:6402:5146:b0:502:1cae:8b11 with SMTP id n6-20020a056402514600b005021cae8b11mr10862531edd.23.1679849273974;
        Sun, 26 Mar 2023 09:47:53 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:eca3:3b8f:823b:2669])
        by smtp.gmail.com with ESMTPSA id u20-20020a50c054000000b004aeeb476c5bsm13559502edd.24.2023.03.26.09.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 09:47:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] riscv: dts: canaan: drop invalid spi-max-frequency
Date:   Sun, 26 Mar 2023 18:47:51 +0200
Message-Id: <20230326164751.104789-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spi-max-frequency is a property of SPI children, not the
controller:

  k210_generic.dtb: spi@50240000: Unevaluated properties are not allowed ('spi-max-frequency' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/riscv/boot/dts/canaan/k210.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
index 07e2e2649604..f87c5164d9cf 100644
--- a/arch/riscv/boot/dts/canaan/k210.dtsi
+++ b/arch/riscv/boot/dts/canaan/k210.dtsi
@@ -259,7 +259,6 @@ spi2: spi@50240000 {
 					 <&sysclk K210_CLK_APB0>;
 				clock-names = "ssi_clk", "pclk";
 				resets = <&sysrst K210_RST_SPI2>;
-				spi-max-frequency = <25000000>;
 			};
 
 			i2s0: i2s@50250000 {
-- 
2.34.1

