Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CD66E375A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 12:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjDPKUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 06:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjDPKTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:19:36 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9296B1BE3;
        Sun, 16 Apr 2023 03:18:32 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94e53ef6815so265381366b.1;
        Sun, 16 Apr 2023 03:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681640311; x=1684232311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Deq7iuiEl1RFyBysVZfY7LGeNc11tLOLC+fdaC0CAMg=;
        b=ZAwt4HeI7zjFHJkplxlMJqzMttBg4MXXpiOfe9Mx+voSNjApPexnWf9uECiJ5Yl26Z
         ljMP/sqVqA1WmuJCGGf4iUWm0QxpbjJjTuBsLAkf2/z2fZahvgd2yhwHTf8brQIv3pH9
         YzjNwHThdfqX1s5uGL//gNzstTz4I0zZBjDesqKCzHURMRJpsU9CYAXSOTTxlflcRfAC
         7c5fcu7/rV7NLWHwe35UuqLChgWWbDavh1cUQfEhB5boPBfhYzI0Z38WBEYBMUArIOSI
         MCzjsxc0cCUgXe8RohOTFHSJMIx8FaWrvZf/hbdITR69cKMBxspbQmniQ35+PLB17jK1
         nzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681640311; x=1684232311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Deq7iuiEl1RFyBysVZfY7LGeNc11tLOLC+fdaC0CAMg=;
        b=a5QBK1q9jzMH1ueiZIiVp8VFrZRxnMP/n13FS6wHGQvFePjPYLcddstSXNE01WsDOu
         pDw3sF2g+s6Bae9OYWU6wnVqQz/vdTajodEep2kQcfmc6narHf+tYqv57mYUmXWOsubl
         /FOYo6TwNrK+GJ4LvjMqNdMg3J/5LBlUHU1uaeV5apJ2NhTE32MyMjqnrcy3iVmH7FVz
         Umcui43cpT+NtCUgqpqYfRpz3O3EDo+tOn5uDYI3Y+1axNgY8bibxKyHJomGAWH1d9U9
         5JTi/X7lrA+5C7+6ne/zM6UUy8PaLtWUjI/CsXK1CjOSC9KmUHvaZY8FPCIh3+UU/sbU
         /4Ng==
X-Gm-Message-State: AAQBX9eqLqZGVMv34POPGppOlqcU7LJlrzhyQrxE9iv7KOvI9j7H249W
        j6jE8zm9BkWPlPzlvCUVtDw=
X-Google-Smtp-Source: AKy350YkWFGDJqV0rBc+9gzlX9eokYwBBCkk2wU46o9VJLPhqhdapjAD8Blc2K/bSjtNuYp3e6wasw==
X-Received: by 2002:aa7:df0d:0:b0:4fd:29e4:ccfe with SMTP id c13-20020aa7df0d000000b004fd29e4ccfemr10155286edy.18.1681640310676;
        Sun, 16 Apr 2023 03:18:30 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id r20-20020a056402019400b0050476da5160sm4427443edv.45.2023.04.16.03.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 03:18:30 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH 11/12] dt-bindings: arm: samsung: Add Samsung Galaxy Tab3 family boards
Date:   Sun, 16 Apr 2023 12:16:23 +0200
Message-Id: <20230416101624.15866-12-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230416101624.15866-1-aweber.kernel@gmail.com>
References: <20230416101624.15866-1-aweber.kernel@gmail.com>
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

Add the compatible strings for the Samsung Galaxy Tab 3 8.0 series
of tablets.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 .../bindings/arm/samsung/samsung-boards.yaml           | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index deb2cf971871..4ee026e7f7ad 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -104,6 +104,16 @@ properties:
           - const: samsung,exynos4412
           - const: samsung,exynos4
 
+      - description: Samsung Tab3 family boards
+        items:
+          - enum:
+              - samsung,t310                    # Samsung Galaxy Tab 3 8.0 WiFi (SM-T310)
+              - samsung,t311                    # Samsung Galaxy Tab 3 8.0 3G (SM-T311)
+              - samsung,t315                    # Samsung Galaxy Tab 3 8.0 LTE (SM-T315)
+          - const: samsung,tab3
+          - const: samsung,exynos4212
+          - const: samsung,exynos4
+
       - description: Exynos5250 based boards
         items:
           - enum:
-- 
2.40.0

