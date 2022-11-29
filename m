Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E9D63C208
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbiK2OLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbiK2OKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:10:16 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D668C5EFA7;
        Tue, 29 Nov 2022 06:10:10 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id x66so13798009pfx.3;
        Tue, 29 Nov 2022 06:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBA40M/jf7iW7dWiX7G42nvg49ZSKMGIJyGQgzCsnPU=;
        b=SgtKAAorY7XnakOpyX4HtaOGDIoD7CS9X3TT3yasROFE3IXidNc7lI2FgfUvNzYdQS
         n83h8ZINTMmxIMPHZiS3D2iq0ZwhsqmczmnEKs+vwhhtfQHlLQE0VaL4F9tF/FI+ABN6
         45vlUnhbH3t79TZxaiRv7gAXaOqr4XLQ5K7EP29yqwmrcL3BZwXnYzlGVcA74c4tCjmY
         S1ZZw3ym0HqCAekXACX7oitQE0tmJYJ75EGHIZvpEekupiAbo39mF/NVBverKMYS7xGM
         A+R/UluQGlsVia3fkGvBoktT4r+7hMV5wE5MFwMDjq1VwGaNVf+kW/O2lT15rbieZh4k
         ce3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBA40M/jf7iW7dWiX7G42nvg49ZSKMGIJyGQgzCsnPU=;
        b=6Eig2Z4cM5O8ON4hMeI7NgumvVBnemSY54Faby+IsL8Vj600q5gcmG5pAiUIzanESr
         dcQdjhB2rfPijRot2YzVr3t2ZM9Bo092vVsbShOJA55mXg8kEeFMXVPF49/nX08FfXA1
         Ydoug1Ca6BLTwEQJKCBkks0/XOWrqyPfoN7PDm81Kg+mtZKCJHODs1YCb0pgQx3y33JZ
         0KS8Uoxrf7qVAAZ+UNvKtB3zbMuyOTQuE8UXEBJ20nbKl/gXbqnY/023DnI2BqWzfEvi
         HoDFafIZ4zqPfVZi6Av924TzuXP1JirHvRfmXXvDRGhVx2hfOLnCbqDprsmYN4Uwarx7
         SxsA==
X-Gm-Message-State: ANoB5pksoBH8BCeLoZq/4spETDcmEkT8FP5uNFiV0+ZgY86QaOwmbzjS
        mO3ZNWLu0H0eaDJ3taIJJagJKLFjUy0=
X-Google-Smtp-Source: AA0mqf4ODFr+y6ZZXfIoDmYuJXEo/sKdmGcS5SD3icoCkpTIgpdFqw/Tv81k0hw6fxaZi8dzKtkAQg==
X-Received: by 2002:a63:d74b:0:b0:450:3ae9:2590 with SMTP id w11-20020a63d74b000000b004503ae92590mr33728380pgi.410.1669731010120;
        Tue, 29 Nov 2022 06:10:10 -0800 (PST)
Received: from guoguo-omen.scut.edu.cn ([2401:c080:1400:4da2:5400:3ff:feb4:7578])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902710500b0017854cee6ebsm10932342pll.72.2022.11.29.06.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 06:10:09 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: add an entry for WorldSemi
Date:   Tue, 29 Nov 2022 22:09:53 +0800
Message-Id: <20221129140955.137361-2-gch981213@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221129140955.137361-1-gch981213@gmail.com>
References: <20221129140955.137361-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WorldSemi is well-known for their WS2812B individually-addressable
RGB LEDs on the market.

Add a vendor prefix for it.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 10c178d97b02..32274d894664 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1462,6 +1462,8 @@ patternProperties:
     description: Wondermedia Technologies, Inc.
   "^wobo,.*":
     description: Wobo
+  "^worldsemi,.*":
+    description: WorldSemi Co., Limited
   "^wanchanglong,.*":
     description: Wanchanglong Electronics Technology（SHENZHEN）Co.，Ltd.
   "^x-powers,.*":
-- 
2.38.1

