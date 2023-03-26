Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A406C9690
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjCZQDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjCZQDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:03:37 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE124230
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:03:33 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x3so26184258edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1679846612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuawNslRJtsC33cN3DASsrMzq8m1GQBJdWGYFmYOzJw=;
        b=lm3usrJkrAsmIhY5NhxHKhUVY5xUCinMtwbqhn383BjqiHdbGRd+y3qyw6p/5o8zGn
         /25+rfBhNPrTFBc6jkGaApquPi3VtarQ9Pr0oxUwkEqeRYowCvfPSP0MkFaviaf1wCT+
         RwqPIidVdZv/z0EgNinYnkCBWsjFY3po5PUp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679846612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuawNslRJtsC33cN3DASsrMzq8m1GQBJdWGYFmYOzJw=;
        b=wVAZGZdcmcadNoQZrksborldfZT+NuoFT+hMl9yiqYjFRhRiwbAlqaJcvEc7qwQZQ2
         jcT0mRVl3ERGg0mkfsdUlmAZ/F/fMw5XxrMcXWJaB+8zZFcrI2MTi2CwiIPjx20RWW6T
         40HVJX8VBdMtpN5YjSe6lonVlbh6xnWFYYnQgKIBFNvwZMBZ1xGrF51PRGkWjlXdHlaH
         aZx/r0Bts5ed9dnqSjrRMY3U5yAxip5ZwFkGnUpmj6LHNq/lNERbz3jmJx+Pr+LMhIZE
         g1Ouo1mmykA5tox8lGiLQOukc4ySDIMpV0I1gsmBiYibXeXbq952dfhlTFkPuU6V998/
         oH+w==
X-Gm-Message-State: AAQBX9ejIxuIIsmPyhOiMw0OIi9DzoXob+nIe/O3HMIivd/sI9+yL4rm
        3tEi8c0ndl6F+2/RfhtuMEBb608QxHIek/iyWU8DIw==
X-Google-Smtp-Source: AKy350as+tRi3BA2dhFLxdS81jN8x1lgcW9Ng7ynZMWjcriz1sp/xBC13Ft0sKPnwfNlqdzjcrknuQ==
X-Received: by 2002:a17:907:1c09:b0:930:f953:9608 with SMTP id nc9-20020a1709071c0900b00930f9539608mr13785177ejc.0.1679846612122;
        Sun, 26 Mar 2023 09:03:32 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-0-102-254.retail.telecomitalia.it. [87.0.102.254])
        by smtp.gmail.com with ESMTPSA id m2-20020a50d7c2000000b00501fc87352fsm6869333edj.13.2023.03.26.09.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 09:03:31 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        michael@amarulasolutions.com,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v8 1/5] dt-bindings: arm: stm32: add compatible for syscon gcan node
Date:   Sun, 26 Mar 2023 18:03:21 +0200
Message-Id: <20230326160325.3771891-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230326160325.3771891-1-dario.binacchi@amarulasolutions.com>
References: <20230326160325.3771891-1-dario.binacchi@amarulasolutions.com>
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

Since commit ad440432d1f9 ("dt-bindings: mfd: Ensure 'syscon' has a
more specific compatible")
It is required to provide at least 2 compatibles string for syscon node.
This patch documents the new compatible for stm32f4 SoC to support
global/shared CAN registers access for bxCAN controllers.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Acked-by: Rob Herring <robh@kernel.org>

---

(no changes since v5)

Changes in v5:
- Add Rob Herring's Acked-by tag.

 .../devicetree/bindings/arm/stm32/st,stm32-syscon.yaml          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
index b2b156cc160a..ad8e51aa01b0 100644
--- a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
@@ -20,6 +20,7 @@ properties:
               - st,stm32-syscfg
               - st,stm32-power-config
               - st,stm32-tamp
+              - st,stm32f4-gcan
           - const: syscon
       - items:
           - const: st,stm32-tamp
@@ -42,6 +43,7 @@ if:
       contains:
         enum:
           - st,stm32mp157-syscfg
+          - st,stm32f4-gcan
 then:
   required:
     - clocks
-- 
2.32.0

