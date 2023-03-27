Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5516CAFB9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjC0UQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjC0UQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:16:49 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AD030E5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:16:48 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id o14so4432112ioa.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1679948207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naF6lvSQb9TRc8Fh22LBxD4avClkKSEDkyx9CDmChC0=;
        b=CxSVI6/XYwWD1PMufblibS7y0Jl3dfs4ZwMdKkJFfdb6WmW7yVJffiah3hYVF5VaDZ
         M5g3fL/txQlETgSWwwXvtjv8LPmDpoHAu/vhSjKeJjtfcceikIoTr+YeObcooC+tZP2c
         iW/vA9JTskbIaRD5v2OLWtM9aaRF2TZB75q/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679948207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naF6lvSQb9TRc8Fh22LBxD4avClkKSEDkyx9CDmChC0=;
        b=xDKP0cN47Yx+XU/JqiX5ddhM79wtmfDMsqUH3HwUhTqXfFHX8O4OcHJW/ktXfLPJW/
         qrE9I3BoKhgHBKzsnmjBJWr8HDstOPRv08th5XPb17SVbwmqWfU7vQr9yCRX/ElV9qNI
         iJHmIgptMDUL8nwRetzFGC6B+6zsRo36TzMdc1fG6EdwpMQ92JOgxE64gUB0qDzJqHv9
         EreWVs7j2ibw3mgO0pHQp/dNDL8hrdgtyKZEHXxCjwDaAilrJwgavaFzMYnWADMX5kk3
         rZJ5bD2F6Q/RZv1Mj0JUrqKtDVFKN9ute+QiviqXKZ25FTXlXin+TiCj1dPPc644F+fL
         tJ4w==
X-Gm-Message-State: AO0yUKX+V6k7lZqMHUYJU+XBOxCXBeQHG0KNNiWgIe38k2xiA0qw2Z89
        8J697j9r7voRC2EjNvi6k19lIkBnL539uANbcW14TA==
X-Google-Smtp-Source: AK7set8BKUE0k2yqKIwOZ7LQxWzIh8H8MHkfhDWKLbsA5N7LFJXFTP9lyZONEBlLhRe5TuBLZmPYng==
X-Received: by 2002:a05:6602:408b:b0:758:9e69:13f1 with SMTP id bl11-20020a056602408b00b007589e6913f1mr13224545iob.9.1679948207250;
        Mon, 27 Mar 2023 13:16:47 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (host-87-0-102-254.retail.telecomitalia.it. [87.0.102.254])
        by smtp.gmail.com with ESMTPSA id u26-20020a02b1da000000b003a958f51423sm5594759jah.167.2023.03.27.13.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:16:46 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        michael@amarulasolutions.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v9 1/5] dt-bindings: arm: stm32: add compatible for syscon gcan node
Date:   Mon, 27 Mar 2023 22:16:26 +0200
Message-Id: <20230327201630.3874028-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230327201630.3874028-1-dario.binacchi@amarulasolutions.com>
References: <20230327201630.3874028-1-dario.binacchi@amarulasolutions.com>
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
more specific compatible") it is required to provide at least 2 compatibles
string for syscon node.
This patch documents the new compatible for stm32f4 SoC to support
global/shared CAN registers access for bxCAN controllers.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes in v9:
- Fix commit description formatting. No semantic changes have been made.

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

