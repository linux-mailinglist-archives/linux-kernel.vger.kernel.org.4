Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762CC6C708F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjCWSvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjCWSv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:51:29 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38322D178;
        Thu, 23 Mar 2023 11:51:27 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v4-20020a05600c470400b003ee4f06428fso1730643wmo.4;
        Thu, 23 Mar 2023 11:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679597486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=64169Vvyo0ZZgIoZU5qnXvhyXyFpGQgMQ4mYoA5/rdo=;
        b=MKFxTpTDbyIGV0lMr2M3rwEnb94MOqyxqpRVFxI2yBYnA4kjOcrkc9EjDt16ZRBRWy
         w5rSFgxczBz8qdrzN96STvHlDGVopIivS3LeEiZyg5DMAXizfrS1UIKc6qmJ4fDXrjHf
         AmdbAwv01aP9xSLohMK1BgqJu8jfpfjNztej4hUsOa8vY7m6Rg85LIjFATndeup4LuIV
         k88Dzo7+MtuBG8/0DT+aEoBoZe6Gd9boRLgSaZOHWpP6iPkX3UouDtTIJ+DBZk/TPrHk
         7hxXF5/EwdOZL63ZdZ6P7rTjoz/z4QN/9SHbaREcZS5iE+1GZy1wxUd//NOsYdWGQC+P
         impw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679597486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64169Vvyo0ZZgIoZU5qnXvhyXyFpGQgMQ4mYoA5/rdo=;
        b=gSRW/a5qZns7HqRnp50LI5jklMP2lah34hj7F8Z/SQmK5KsNeTazEXedj2tQ1ggy5z
         krWfJJ6W/kYTc7zuOVxX19Zk/EgATQtmLs+45RK+iNbAzRYmOOTlYtaYUQd8ehQAThDC
         YzWnm7mQPwB8FfNmKvnLyNLkOhh+h9wyCyiI51xOqJaXMU9Vp20qr2NXQEAChGq8iLDE
         PMBu60GJ1UehUiv5e27NIP8zP0TwjUevRBQPap57cklh4uNSn+OJtqb/vI2FHiwz3jCG
         iPKRrBEUcy9obfQVjKQBiWUt3dY1fjx2JLz4vPV2nEhEp6A4hEoSdQnFz+MW38NJjmJ2
         X+eQ==
X-Gm-Message-State: AO0yUKVWQWXdO60aRTx+pX7noKFyHyLdUl44FgjtkGexoP6/hMYkgnnU
        8LQIBVFnsHMac/6GUX1GbDc=
X-Google-Smtp-Source: AK7set8uRrPGJYJokclypVKb4nC0fwJfb6HDu06Bl+KrlXV0hSQ1uQBNDiwna2u1y3tUW3Bmkkxl1A==
X-Received: by 2002:a7b:c40b:0:b0:3ee:4ee:bf73 with SMTP id k11-20020a7bc40b000000b003ee04eebf73mr454458wmi.24.1679597485860;
        Thu, 23 Mar 2023 11:51:25 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:7448:a207:93a2:a1ed])
        by smtp.gmail.com with ESMTPSA id k11-20020a05600c0b4b00b003edef091b17sm2649323wmr.37.2023.03.23.11.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 11:51:24 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dt-bindings: timer: renesas: ostm: Document RZ/Five SoC
Date:   Thu, 23 Mar 2023 18:51:12 +0000
Message-Id: <20230323185112.13855-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The OSTM block on the RZ/Five SoC is identical to one found on the RZ/G2UL
SoC. "renesas,r9a07g043-ostm" compatible string will be used on the
RZ/Five SoC so to make this clear, update the comment to include RZ/Five
SoC.

No driver changes are required as generic compatible string
"renesas,ostm" will be used as a fallback on RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/timer/renesas,ostm.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
index 7207929e5cd6..8b06a681764e 100644
--- a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
@@ -23,7 +23,7 @@ properties:
       - enum:
           - renesas,r7s72100-ostm  # RZ/A1H
           - renesas,r7s9210-ostm   # RZ/A2M
-          - renesas,r9a07g043-ostm # RZ/G2UL
+          - renesas,r9a07g043-ostm # RZ/G2UL and RZ/Five
           - renesas,r9a07g044-ostm # RZ/G2{L,LC}
           - renesas,r9a07g054-ostm # RZ/V2L
       - const: renesas,ostm        # Generic
-- 
2.25.1

