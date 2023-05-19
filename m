Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DD7709FA7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjESTG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjESTGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:06:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A3510FC;
        Fri, 19 May 2023 12:06:35 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96f5685f902so226394366b.2;
        Fri, 19 May 2023 12:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684523194; x=1687115194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoiF8G9Su5Au1q+xAlyfAZ9zrwZD9VyRtnMMrJygBro=;
        b=KeNG10ieA7D2EeGNEIIhVMsiUPWBZQ6FZkLl7/eNk00j2FTsZECjFRuQ3UL190Y+Dt
         A0amcIYrZZB50phLh31Re2iq71u7b5R2HzoHVKATVQ/M81efZ5AAirVN5H9zfBwMvSoZ
         OCxdiyyMchzDXUkJghHtAPlhfddxQMvP2YFSgtIlmp3G7WUzsuoUcAwuDwzZxhF2VLQf
         ttybHw0crpQ6sHLp1sZVkDKVN6B/T9oNPkNzDbOGrcFJpiPk0MzcRRU4dOmjwh5MPVFV
         GfLhUz8knnn+xjv5U+odhsQp2A9ZowXTlPNI7biFBSi4rUo+BkLvTesyO6cyvUD+xunf
         yh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684523194; x=1687115194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FoiF8G9Su5Au1q+xAlyfAZ9zrwZD9VyRtnMMrJygBro=;
        b=AzZzoZrEh/tYPloXMKtxI7zqFFWMyprF6AcQaR2un11iVxrdB8FPozC2bX3YGUX11B
         w6Ba/FmZ7H28+oMld6LFbHgl6cpyS0aVUOFIJaWwPGRz5AXIndMxhIj5MHZscs9vunam
         N9Qju9arwVkMEFOBO6iDYo1vM4wgl0q/DZBOWW5vMiQ+MNwcOb9cIifnmojDsGkR3Sv2
         xAhROlA4o3Lin8oY/O7OzSeTMjqNiYvxiHjPE3CBFuW4JzLCYq0Okv3deOpi3/PHWr16
         zsZm8VOPOrHhUinqtpO99/AMEp/UCqZeJWRpzpcOxV/eDigeLaRN+Q47wZYSmtloEb0m
         nM0Q==
X-Gm-Message-State: AC+VfDzGuBNOdaXNqjIOue+4pLY4A+/zt5todRuxRKohuSN3A5NF1kJt
        C0o4EX/UC5ZA4U5miLEUhaE4GUerVBA=
X-Google-Smtp-Source: ACHHUZ4wm6BeiL+mgp+txFVQb0ZcCQgL7XwjHq+ebYpqiLsJbjaZs/YOAyo3Xt/Zwu4JpG2uxlxb0Q==
X-Received: by 2002:a17:907:1c1a:b0:96a:6c1:20a4 with SMTP id nc26-20020a1709071c1a00b0096a06c120a4mr3145679ejc.56.1684523194162;
        Fri, 19 May 2023 12:06:34 -0700 (PDT)
Received: from localhost.my.domain (83.11.222.198.ipv4.supernova.orange.pl. [83.11.222.198])
        by smtp.gmail.com with ESMTPSA id q1-20020a17090609a100b0094f1b8901e1sm2624244eje.68.2023.05.19.12.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 12:06:33 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH 2/3] ARM: dts: s3c64xx: Fix some typos in comments
Date:   Fri, 19 May 2023 21:06:24 +0200
Message-Id: <20230519190625.7844-3-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519190625.7844-1-aweber.kernel@gmail.com>
References: <20230519190625.7844-1-aweber.kernel@gmail.com>
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

Change 'specfic' to 'specific'.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 arch/arm/boot/dts/s3c6400.dtsi | 2 +-
 arch/arm/boot/dts/s3c6410.dtsi | 2 +-
 arch/arm/boot/dts/s3c64xx.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/s3c6400.dtsi b/arch/arm/boot/dts/s3c6400.dtsi
index 8c28e8a0c824..7cc785a63866 100644
--- a/arch/arm/boot/dts/s3c6400.dtsi
+++ b/arch/arm/boot/dts/s3c6400.dtsi
@@ -5,7 +5,7 @@
  * Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
  *
  * Samsung's S3C6400 SoC device nodes are listed in this file. S3C6400
- * based board files can include this file and provide values for board specfic
+ * based board files can include this file and provide values for board specific
  * bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
diff --git a/arch/arm/boot/dts/s3c6410.dtsi b/arch/arm/boot/dts/s3c6410.dtsi
index a766d6de696c..13e9cc69b8a8 100644
--- a/arch/arm/boot/dts/s3c6410.dtsi
+++ b/arch/arm/boot/dts/s3c6410.dtsi
@@ -5,7 +5,7 @@
  * Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
  *
  * Samsung's S3C6410 SoC device nodes are listed in this file. S3C6410
- * based board files can include this file and provide values for board specfic
+ * based board files can include this file and provide values for board specific
  * bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
diff --git a/arch/arm/boot/dts/s3c64xx.dtsi b/arch/arm/boot/dts/s3c64xx.dtsi
index c03df6355500..0b59135ffe88 100644
--- a/arch/arm/boot/dts/s3c64xx.dtsi
+++ b/arch/arm/boot/dts/s3c64xx.dtsi
@@ -6,7 +6,7 @@
  *
  * Samsung's S3C64xx SoC series device nodes are listed in this file.
  * Particular SoCs from S3C64xx series can include this file and provide
- * values for SoCs specfic bindings.
+ * values for SoCs specific bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
  * S3C64xx SoCs. As device tree coverage for S3C64xx increases, additional
-- 
2.40.1

