Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C346F9016
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 09:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjEFHcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 03:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjEFHcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 03:32:16 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33EC11B7B;
        Sat,  6 May 2023 00:32:06 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f4000ec71dso17630405e9.2;
        Sat, 06 May 2023 00:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683358325; x=1685950325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/p1ytnQh6YEGVhEhqDXJrPOG30ZOWl4FCmbFIXesQs=;
        b=bHsdH9QLBx95JODO+aI3BTZ9JpWH80AULgNrIwX35ln3QWMnNrfyonN+IEHO3a2qXT
         zQayMOl3UCEcpbg7SLIxbGxSaxH7wpxwpx3k6GfGLVqIOq34mTLj/N+WmeALlM/BV8QJ
         1Yg5TejIXbppSec1n7g550mo+9+Ow80CwC8KhpOwO5B33fezYPoOP1ue2+MnAAhZR7aN
         JYTD8eG2esMfafDyBkIrl8YCg2DAoQqQYOlOqcRt0aAiXAXbBP9eR0f06G21todRHxqn
         emMzyrfrkGuzCNT+6qaxL0Pc0Ktrb3COiRtiFN7x/LlK6Ftkp/pBQI9OGoIAW5IOERVy
         l0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683358325; x=1685950325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/p1ytnQh6YEGVhEhqDXJrPOG30ZOWl4FCmbFIXesQs=;
        b=MbJ39SrwMDx6Y0V+47CqUU1VwXu/V1pJGTCMRKNwHXbmZOqhGgkXBuLSnenGxklBRy
         jMHBKJTKTSnSgDaIWlQgDNt+Vih42lfK0tDfiR+kgy5CimlBLZhjQwCfuCn3iGIdxLrx
         B41IQXdqz9WsGKaIwOs64Q70ksea8pXQ02WNg1fQnQusDUD/K0bQ4TmxDsEYaqC+wToK
         njdQNU/vibBhZi0EN7NuQmbAkvAnZqqItbXFglSgbXoHEyuzHGwJBAJBiHg7GRZIydI+
         rv+EBF3Yqgj9p2M4k7ke3vmH5cV1RQFkOoFrj8m5L3r1vjxVSZXX47ykKdYKkqgFMdiL
         5tnw==
X-Gm-Message-State: AC+VfDzaqgevYnwcVfundZnREjXL2trrez6S+BC6OHjIosaUjnRdjgpm
        ih3L3fW2oMuMCiIaXH7/FiE=
X-Google-Smtp-Source: ACHHUZ6JTn71OUBh2OirtFdnyg6dCjdW09TDzjxul9OlyXa2r6klaU6in0h6LXx3WvVWtVJrCWb40w==
X-Received: by 2002:a7b:cb53:0:b0:3f2:53a5:d308 with SMTP id v19-20020a7bcb53000000b003f253a5d308mr2586133wmj.6.1683358324784;
        Sat, 06 May 2023 00:32:04 -0700 (PDT)
Received: from localhost.localdomain ([176.221.215.212])
        by smtp.gmail.com with ESMTPSA id q14-20020a7bce8e000000b003f182a10106sm10071944wmj.8.2023.05.06.00.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 00:32:04 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 1/6] dt-bindings: spi: sun6i: add DT bindings for Allwinner R329 SPI
Date:   Sat,  6 May 2023 10:30:09 +0300
Message-Id: <20230506073018.1411583-2-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230506073018.1411583-1-bigunclemax@gmail.com>
References: <20230506073018.1411583-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

Allwinner R329 SPI has two controllers, and the second one has helper
functions for MIPI-DBI Type C.

Add compatible strings for these controllers

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
index de36c6a34a0f..2c1b8da35339 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
@@ -21,6 +21,8 @@ properties:
     oneOf:
       - const: allwinner,sun6i-a31-spi
       - const: allwinner,sun8i-h3-spi
+      - const: allwinner,sun50i-r329-spi
+      - const: allwinner,sun50i-r329-spi-dbi
       - items:
           - enum:
               - allwinner,sun8i-r40-spi
-- 
2.39.2

