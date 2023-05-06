Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5FF6F902E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 09:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjEFHdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 03:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjEFHdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 03:33:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0BE12085;
        Sat,  6 May 2023 00:32:44 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f4000ec6ecso26353205e9.0;
        Sat, 06 May 2023 00:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683358362; x=1685950362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+gJSA9KlwYKmHRtBzH4uVO77NzvF1saoblSPNiiNsM=;
        b=qA6gUHbwstdpIjn8F6SxFuw2gF8TnBRl6Utbnn5nKnIN1dc6yiW4Kggxs98iH2B2TI
         LIgMeQP0wpeR8uxOcHWEjOqO77jW8dOatD34+yk+VMpZcpGU/1coDkwpM1qXi5NcoaPw
         VfLOVfsZUEF2u+BG3NieHGrpjmKzmDwjn7mGfjfV8IVOChpF1/rxMRj4Gm3vY908feCA
         rl3hcqWY++Wx1lJjkJXwE+yzZMH/9xGkNTcbxMjLZUwflRdT/E70DUE1HsaQ2vO3NuFn
         i3LoscS9nH6gBh0ONq9B5djETjhbT62hU/7C53l3PWjKXHVH3ELC4cu4Ibnav2HpyVa6
         wN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683358362; x=1685950362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+gJSA9KlwYKmHRtBzH4uVO77NzvF1saoblSPNiiNsM=;
        b=P+hhlNwYSeihmVGI2aIksHfnoHf6JBmOJNFbZQXu0jS7iJkLEii3sGSsjVk7UFVn4E
         QwQPV34gUwFwlcgQxbDKRHqCP3FZ0kNSd4RZ7SCzHpySI3C9fFGmc3D1Dc4LyngMN0uM
         ZJFCUo8U6/1D8TXijsIQe2FtWYx+FqgUmhzD501pZxoPqfL5MG1iOb/5pNOZkZEzzD+z
         EXunPKTeX9oS42nFQPitKLYg7NfjIVx4wHRWdM6XlNT09GYavQefbV+1gVP11dPwevDP
         axNWaeKlqv3L/Jycx+fvBsvB6Oqrw0s0gFcODTirKkXVtE5TDMZkKd4WVjDS/gUkovhC
         CGyw==
X-Gm-Message-State: AC+VfDxBjmU0BJG88VcAaorFDuOQBsNl5hhzG2rAAgs+8a7pO3XyrzzR
        h+ATCgMSVPblsLEfpvZar+c=
X-Google-Smtp-Source: ACHHUZ6VgW5RfMKlfXefD5nobAzpG2CP/3myjrgVEXnND0iEFu+mWT1BCJgrUUE+j5IM/f/vxmW0fg==
X-Received: by 2002:a7b:c8c3:0:b0:3f1:8aaa:c212 with SMTP id f3-20020a7bc8c3000000b003f18aaac212mr2828550wml.33.1683358362207;
        Sat, 06 May 2023 00:32:42 -0700 (PDT)
Received: from localhost.localdomain ([176.221.215.212])
        by smtp.gmail.com with ESMTPSA id q14-20020a7bce8e000000b003f182a10106sm10071944wmj.8.2023.05.06.00.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 00:32:41 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Mark Brown <broonie@kernel.org>,
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
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 5/6] dt-bindings: spi: sun6i: add DT bindings for Allwinner D1/R528/T113s SPI
Date:   Sat,  6 May 2023 10:30:13 +0300
Message-Id: <20230506073018.1411583-6-bigunclemax@gmail.com>
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

Allwinner D1/R528/T113s SPI has the same as R329 controllers

Add compatible string for this controller

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml      | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
index 2c1b8da35339..164bd6af9299 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
@@ -30,6 +30,10 @@ properties:
               - allwinner,sun50i-h616-spi
               - allwinner,suniv-f1c100s-spi
           - const: allwinner,sun8i-h3-spi
+      - items:
+          - enum:
+              - allwinner,sun20i-d1-spi
+          - const: allwinner,sun50i-r329-spi
 
   reg:
     maxItems: 1
-- 
2.39.2

