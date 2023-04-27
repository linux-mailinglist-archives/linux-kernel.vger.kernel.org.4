Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42AE6F0D6C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344012AbjD0Up5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344310AbjD0Upu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:45:50 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA5744A3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:45:49 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-505934ccc35so15618545a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1682628348; x=1685220348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2A7EdpRRw4uhUr29cHp9TanChHdCrYmggTLXrFrhPk=;
        b=hIxfVLSq+nmegxqmVyJw4MiJ83Xqb06fTI1IBsWQL4pGWYAnJTdpzju1aNI+zZuuwD
         xX5hlc5OhhvXhAJ28lcUTKhZpgp1fGOlxaPd7NsrEqXBWSv7t71UqARcnrEmMUdvbMrX
         ht0H7epNLh2eseqd5EQA6gI8DPVQZq+ED5daQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682628348; x=1685220348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2A7EdpRRw4uhUr29cHp9TanChHdCrYmggTLXrFrhPk=;
        b=dyc6i7oQNmH0709eK12rNXqSvXr6VS1DyRnM+eXf2uiiXlPnAlKj/cyf1M6Lc1JxB2
         bVRhOiDg79TGUOlKOEi8ePvybpBwWxm/S+wWVupLFf4eHmy/uASxzFmiO+RCQJyKHvVq
         7OUfTwWN5qJbj2PsfrQHfBFd9H4GynAq+TH+WdJYKxHVnNn2Vw7UdNFXOO1RNXSn0mdg
         pE1e7bOBerGaiUhXBfDRb94aAj3IEfBH4w7QAlCIic/wZfVtL7PQa3bs2+x33feqbUCl
         ttL87XmUQENFSdkDCQ9cFSD6DZ84ojL6KJ/v2hw1fX6h8KXYZj7xS8qggAhjBzW7diHU
         0NkA==
X-Gm-Message-State: AC+VfDwb20wMC9Yu6WnXKELBNZQJaEBcaW5coUpjD6/BI/o3g3CatsiY
        OhhgGmMEQbCkR/LU8P0HRbomdzM1zUsrWtoB7hppcw==
X-Google-Smtp-Source: ACHHUZ5pkrfEo97jWwEggqo9NSV1NaQsI4JAPpU1paNohPHEtxduAxt0kbk7S9GKgqHPZwm14QdW9g==
X-Received: by 2002:a17:907:9807:b0:94f:24d7:64d4 with SMTP id ji7-20020a170907980700b0094f24d764d4mr3007723ejc.37.1682628347769;
        Thu, 27 Apr 2023 13:45:47 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-5-99-194.retail.telecomitalia.it. [87.5.99.194])
        by smtp.gmail.com with ESMTPSA id s12-20020a170906bc4c00b00947ed087a2csm10171360ejv.154.2023.04.27.13.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 13:45:47 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 2/5] ARM: dts: stm32f429: put can2 in secondary mode
Date:   Thu, 27 Apr 2023 22:45:37 +0200
Message-Id: <20230427204540.3126234-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230427204540.3126234-1-dario.binacchi@amarulasolutions.com>
References: <20230427204540.3126234-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
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

This is a preparation patch for the upcoming support to manage CAN
peripherals in single configuration.

The addition ensures backwards compatibility.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 arch/arm/boot/dts/stm32f429.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index c9e05e3540d6..00bf53f99c29 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -387,6 +387,7 @@ can2: can@40006800 {
 			interrupt-names = "tx", "rx0", "rx1", "sce";
 			resets = <&rcc STM32F4_APB1_RESET(CAN2)>;
 			clocks = <&rcc 0 STM32F4_APB1_CLOCK(CAN2)>;
+			st,can-secondary;
 			st,gcan = <&gcan>;
 			status = "disabled";
 		};
-- 
2.32.0

