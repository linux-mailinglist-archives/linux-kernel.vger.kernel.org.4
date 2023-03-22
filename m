Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071D66C5211
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjCVRQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjCVRP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:15:57 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9655064863;
        Wed, 22 Mar 2023 10:15:25 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v4-20020a05600c470400b003ee4f06428fso2424553wmo.4;
        Wed, 22 Mar 2023 10:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679505324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7ykhArT1dO7P8wtmI92eo4c7KtPZI9w182/5+cB3T0=;
        b=WRZRU2SM9n1LfUj4SgTPfQczADC2pfvoIrOsNpBLTym2eOfmkTetb/WbGSla5kw2Wb
         SH5MIC2fFeScJg6T5FFAUOOLmRVW9xvl8Q3T3NKb3z/9wvPHO767nrdIbffRWMJFs7gW
         wT/kuTpn8GYdfY0sZ/dMTkq41DVusEkxfX6GxtG85O98ZP8xMHQog8aPs9fRfUvI5ZKB
         eGYcRz/Wn1cHhjey9jtWzQEEmZ/BT3b0HQTF9Tl88oofhiEgbyjFXr91+vRsLbsJpGXH
         /1FjjaLG5DnonKubV9rmbuCU8KzwH331gi2KuRjvLD2V+OMewqSa5i+GvgVv8x2zC8y+
         /mLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7ykhArT1dO7P8wtmI92eo4c7KtPZI9w182/5+cB3T0=;
        b=bhd0fNh0jDOMlGSC4F+p5igV8AUlGEPj2cXUwgdgqRfSSuUy9z+Li8cT0MbY/aWH5Z
         qInRVA+R1cWV3ubrDyKag6oEc0LDU234bnMFcP9b7MRlrM8Dpit9TFSyqJU4sDUWNDs5
         KOe2k/SNIdat6munC9VOuEBDO0eB/UDMN+repKwXNdHChp/Toq9qMvW4Uy8uHxosbQlD
         8P88GbKFjynb1E8I8croGjfub7+y8PPsWB0xNUcafIv6xs3MnVOP1Mk4KwBCbqS509la
         mfjsriXtIybO8XFqtn100ungjvbFWdogEplLdSPVdgAqdfF5J8gHxAoApoeYejYkL5/R
         kOhQ==
X-Gm-Message-State: AO0yUKWdzr3dMmjKhD8tF+ec4Dfdq9VGZ/WCU4d85npKQvxSwhNPZZ1J
        5WYRIqivh0suFC1OqEidwenpiJYvXedYjw==
X-Google-Smtp-Source: AK7set87ew2/mKWeShXTTW/YBbBJNR2zeGFV0CfuqLXhiJEU6tqFuyKcW+vFEoKHIbNUS8wRy1SzLA==
X-Received: by 2002:a05:600c:290:b0:3ee:6d88:774a with SMTP id 16-20020a05600c029000b003ee6d88774amr160734wmk.14.1679505323514;
        Wed, 22 Mar 2023 10:15:23 -0700 (PDT)
Received: from atlantis.lan (255.red-79-146-124.dynamicip.rima-tde.net. [79.146.124.255])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b003ee11ac2288sm8414333wmo.21.2023.03.22.10.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:15:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, p.zabel@pengutronix.de,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        william.zhang@broadcom.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/4] dt-bindings: reset: add BCM63268 timer reset definitions
Date:   Wed, 22 Mar 2023 18:15:13 +0100
Message-Id: <20230322171515.120353-3-noltari@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230322171515.120353-1-noltari@gmail.com>
References: <20230322171515.120353-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add missing timer reset definitions for BCM63268.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 v4: no changes
 v3: no changes
 v2: change commit title, as suggested by Stephen Boyd

 include/dt-bindings/reset/bcm63268-reset.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/reset/bcm63268-reset.h b/include/dt-bindings/reset/bcm63268-reset.h
index 6a6403a4c2d5..d87a7882782a 100644
--- a/include/dt-bindings/reset/bcm63268-reset.h
+++ b/include/dt-bindings/reset/bcm63268-reset.h
@@ -23,4 +23,8 @@
 #define BCM63268_RST_PCIE_HARD	17
 #define BCM63268_RST_GPHY	18
 
+#define BCM63268_TRST_SW	29
+#define BCM63268_TRST_HW	30
+#define BCM63268_TRST_POR	31
+
 #endif /* __DT_BINDINGS_RESET_BCM63268_H */
-- 
2.30.2

