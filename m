Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F9F6FC6F0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbjEIMnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjEIMnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:43:08 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D91E525E;
        Tue,  9 May 2023 05:42:51 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f42b984405so5181575e9.3;
        Tue, 09 May 2023 05:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683636164; x=1686228164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LNn6nFKtK6r2VL4gNamF8ksWMIm4Y9cfvJCgSo1awo=;
        b=mEu7EgzD3/wxi5z97BM9R3EjmlIs19wq/1FfH07l2LsO5IkpZQ4l/tM4OlRkLZ9JDw
         eUL0X6Tvu1vXGGcximjiZvAuzwh4Vbh6GDqhOEVihYT257kztfihiZbhAbVgx/vo+/sp
         DixHzNs3pZSUgi7Vm67heH0Ykzl+/VLRxsVsVFoH+gAKnbxYr4Qdp5Nk3IYbBwnLSh6+
         whJXIpx7zZevmEWsn43U5IqzIFxtkMsFu4gaLq/xLA4EDTKn0kUnitRodUufZbcVQBG8
         zEG2G9YqY1tL7WV7VmKkGzrA6DXucS4JDQifN+Qs3bSgPpbTwF5T6bVSn4kzhxvI3+bn
         u4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683636164; x=1686228164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LNn6nFKtK6r2VL4gNamF8ksWMIm4Y9cfvJCgSo1awo=;
        b=NjzE9tPCTqJBBtZ6JgayL9CYXl5NFD6uGVk4UelHnv7jkbSwIb91qSVSwAuVo37pxS
         pLV5qJbTNaaPWA3eKIlZ2LZqz3uTvGLZ/Qkk0QU0XT2OS2QcI+hLC+WeRBKnWMaq/pJb
         itawMyp7XiGfOY1b5C9DYEcL4DanHVfpYDGuj9GqpVyD+Hl2oeIqrh+xilztfn22oE9J
         QiuA+owl8zEP7yFK4tonrwihFEu/YC3VQ0KrQMmsXMc/3TQxMT8WmU3RRkwxrEffv69x
         Hlifydk4XUNNgzN3gN7/IFgzLICb/7kLJjE52I9zI+sZ/lgakmTIAD8OZKN3AI+2u8Uz
         rSTA==
X-Gm-Message-State: AC+VfDz9qb9gJ+V2NruSKneqKRDFFVUBjTS28Bk/ybcN3NwJN/GtGz+p
        WqvYGi/4wnm66cOpu9IKafw=
X-Google-Smtp-Source: ACHHUZ5v4zQ40dlTx6mNXK3VeBezN6RIEaQg7NiPAb4m+jPXMkfP5lNtAmdu9LWsI8jYR7LsFZ/pgg==
X-Received: by 2002:a7b:cd99:0:b0:3f1:6757:6242 with SMTP id y25-20020a7bcd99000000b003f167576242mr9518973wmj.27.1683636164205;
        Tue, 09 May 2023 05:42:44 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d4ec2000000b003063a92bbf5sm14401481wrv.70.2023.05.09.05.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 05:42:43 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tsbogend@alpha.franken.de, paul@crapouillou.net
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v1 2/3] ASoC: ingenic: Add compatible string for X1000 SoC
Date:   Tue,  9 May 2023 13:42:37 +0100
Message-Id: <20230509124238.195191-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20230509124238.195191-1-aidanmacdonald.0x0@gmail.com>
References: <20230509124238.195191-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audio controller in the X1000 is similar to the JZ47xx SoCs.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 Documentation/devicetree/bindings/sound/ingenic,aic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/ingenic,aic.yaml b/Documentation/devicetree/bindings/sound/ingenic,aic.yaml
index c59a7cd9eaa9..d15c000f14e1 100644
--- a/Documentation/devicetree/bindings/sound/ingenic,aic.yaml
+++ b/Documentation/devicetree/bindings/sound/ingenic,aic.yaml
@@ -23,6 +23,7 @@ properties:
           - ingenic,jz4760-i2s
           - ingenic,jz4770-i2s
           - ingenic,jz4780-i2s
+          - ingenic,x1000-i2s
       - items:
           - const: ingenic,jz4725b-i2s
           - const: ingenic,jz4740-i2s
-- 
2.39.2

