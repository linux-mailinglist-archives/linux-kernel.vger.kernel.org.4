Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95ECF66CE5B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbjAPSGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjAPSFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:05:20 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5162E0D9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 09:52:07 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m21so41684966edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 09:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuawNslRJtsC33cN3DASsrMzq8m1GQBJdWGYFmYOzJw=;
        b=IsPu9qMd42kSD40SCQ9Fi7QyXCwIlj/By2JmmXKMk5ztpv+s7NDmWOxQ89zMMgDPF2
         CwvhY0dj5ukEWCnE5DGgpDNocrxRwj3rqSBPeJ9Ycq+HBI+O0ybYHz9Kp0xriQ43ekUP
         J2gqQEw9DUo80K6VU46YkNtsuER9DuHGBoy6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuawNslRJtsC33cN3DASsrMzq8m1GQBJdWGYFmYOzJw=;
        b=wrRp5eZiXOme1+80h1MlZtj7ub1Kfo6zkB+yh5CUsivUA4tAwrAHwLfe5jf870YlO7
         dq2ijDVaGN1frx5kOcBxASiBksOpZPLV02Q6nzljLBtWOhSrwkn096eYmpUk4tJfhese
         bFQXJQz+NGecLBxjUFl1mvZ60DVR8XBo3LFiyGglA3hlvzgXfESU9ervljdroG2w0u4C
         izrTXHFIQRBGwOjRzfrlZdJpHLtPqcFUPCg6Aqqvrae4Tab/7jhQfII/gwk/3cejLPEy
         q9zzudKT7R5EE07tb6Ks9zCK/jehA0xOHCaTnSmLMtOqKSq1Dhg1Urlz9bx0lgqR6931
         6whw==
X-Gm-Message-State: AFqh2kqXoc48aiK7FtgelekQxP3HErf70kH+/nUVdCU+haoLBgirKwkf
        16CdulveCLNnq2dAZm78Yu7yepdFu+xBaPkZ
X-Google-Smtp-Source: AMrXdXur8S23m3ID7vP1dEixFgYQMqyKqPsLtX7xtLrQSRE/CtFRXBaQPX1K3MZrCIKX1TE+meg6mA==
X-Received: by 2002:a05:6402:548f:b0:49c:1fe4:9efc with SMTP id fg15-20020a056402548f00b0049c1fe49efcmr65450edb.40.1673891526165;
        Mon, 16 Jan 2023 09:52:06 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.. (mob-5-90-75-145.net.vodafone.it. [5.90.75.145])
        by smtp.gmail.com with ESMTPSA id fd7-20020a056402388700b00483dd234ac6sm11490723edb.96.2023.01.16.09.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 09:52:05 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        michael@amarulasolutions.com, Rob Herring <robh@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v7 1/5] dt-bindings: arm: stm32: add compatible for syscon gcan node
Date:   Mon, 16 Jan 2023 18:51:48 +0100
Message-Id: <20230116175152.2839455-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230116175152.2839455-1-dario.binacchi@amarulasolutions.com>
References: <20230116175152.2839455-1-dario.binacchi@amarulasolutions.com>
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

