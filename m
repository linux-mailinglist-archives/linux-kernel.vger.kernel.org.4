Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543476EC157
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 19:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjDWRZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 13:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjDWRZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 13:25:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30B310DC
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 10:25:41 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-2fa0ce30ac2so3293506f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 10:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1682270740; x=1684862740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6edtHrRUhMOVgTrX/B7WTyKMw10ZM0V+1t1+5ZMKBJE=;
        b=JADuU+heM2MwZW61nEJP7BxXxJ+uBDr7C7gBiY+1WKF53GSrll27l31QhAAv//vNCR
         MyIIGRdjzcwFduWH0m5lY+8JVthfsqqXnx2kdG91PzmYiJzR0ew21vv1f8YkRcg+udXY
         2gynCLOKAD0aiNiUmStVQHwLXFIDDuKHPct+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682270740; x=1684862740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6edtHrRUhMOVgTrX/B7WTyKMw10ZM0V+1t1+5ZMKBJE=;
        b=XrYVdh8w4nb3Pcb2sPLLXm3ZeGtHBaEJR4M/3eC70NHP/B2wa4CkIDz83aeydKJghr
         tnLj10VXePw/aWkIM3X1V574FjJLB7c2q9xqQ5++S2IVSyY8YD1hpeNLePg8xHLR97Lh
         IhTdBc4vZoBXUfFCxiPZVW8hLMFPmQpQZwlSs1s0aQ7ZORUicDb5jqhRzXGlBgZxDHMo
         roP6L82o28CqUskq/ZF/PfyNoX+mJwrRKHqD8x4qZGPtTLUrwvsagICL4dER87EpZN2z
         k0wpWkvlrc1DcMaAi5cgrqc8PAgZxVap4s2EIzxr+Emn6tqKSY7FZHSlJjAyW7e3GUGS
         ju+g==
X-Gm-Message-State: AAQBX9dRSdafZlDdrmT6KSY3l3Uf2wLfqswp/4cagH8Yf8WWTTjq90Ez
        sTuGPk+GOUuhfzAnujNZ5C4XAD9/H44xeUbDy+eMVg==
X-Google-Smtp-Source: AKy350aVRAXW4ATQqNQqvDdR+BpDs/g0j3TnW8XRhPkWLSn+glwqdMA7cgWlU85pvQIpoYnPzL9ovQ==
X-Received: by 2002:adf:e28b:0:b0:2f8:24f7:cc4a with SMTP id v11-20020adfe28b000000b002f824f7cc4amr7634427wri.57.1682270740105;
        Sun, 23 Apr 2023 10:25:40 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([37.159.119.249])
        by smtp.gmail.com with ESMTPSA id j32-20020a05600c1c2000b003f173987ec2sm13511653wms.22.2023.04.23.10.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 10:25:39 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 1/4] dt-bindings: mfd: stm32f7: add binding definition for CAN3
Date:   Sun, 23 Apr 2023 19:25:25 +0200
Message-Id: <20230423172528.1398158-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230423172528.1398158-1-dario.binacchi@amarulasolutions.com>
References: <20230423172528.1398158-1-dario.binacchi@amarulasolutions.com>
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

Add binding definition for CAN3 peripheral.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 include/dt-bindings/mfd/stm32f7-rcc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/mfd/stm32f7-rcc.h b/include/dt-bindings/mfd/stm32f7-rcc.h
index a90f3613c584..8d73a9c51e2b 100644
--- a/include/dt-bindings/mfd/stm32f7-rcc.h
+++ b/include/dt-bindings/mfd/stm32f7-rcc.h
@@ -64,6 +64,7 @@
 #define STM32F7_RCC_APB1_TIM14		8
 #define STM32F7_RCC_APB1_LPTIM1		9
 #define STM32F7_RCC_APB1_WWDG		11
+#define STM32F7_RCC_APB1_CAN3		13
 #define STM32F7_RCC_APB1_SPI2		14
 #define STM32F7_RCC_APB1_SPI3		15
 #define STM32F7_RCC_APB1_SPDIFRX	16
-- 
2.32.0

