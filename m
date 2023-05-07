Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F6A6F9902
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 16:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjEGOsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 10:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjEGOsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 10:48:15 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F84513C28
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 07:48:12 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bceaf07b8so6886785a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 07:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683470890; x=1686062890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wplxTHTVB9HUbrWkpWAx80baJV0+a3dgBkqhq/tTrmc=;
        b=z3tcJabPZmqgYOsepbBPE9X732VUJN4dtEFcCBLwiAJeBcMBSXvVw6An53aUI1eoyg
         FbybVNty4XwpQAk8tD5o2Mdc+b/mWukTpSIZbNddQSQLz5LRMNLaLNwlrxiAy/6QNxHw
         u//n967Hlk/50EZ3Fd1+cARF1fWfGEoWPceaaFWgfK78SO2YyZJ9dL0d8XWn3Z90dk7q
         zrhhYwL5fQkarFBrzcHpLFiHSn5UIwaORzgXyLRb4bnRgt3Za/aGQOosImHiYTSEdUQC
         FDr3teKGDnJG0DB2QP9LoMDC/+UqU5q1OMUceFuQc5cnJ6Y/o7/u6NwvJbGt+bz5/0Lq
         rPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683470890; x=1686062890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wplxTHTVB9HUbrWkpWAx80baJV0+a3dgBkqhq/tTrmc=;
        b=M4tzbtcrlXc9sjGFjJ8Bi2Txy8J1VG4H8J+GHYjJx5I3miXTyfUd6FtFZN/UIz5BUb
         MPTyvcHkmHhVAKqdztyVv/zsaJE5+ET8Ozpn6pbbgKUfqU26fvi5DYCCpdDY44hoLO0u
         Duoyq/b+/fcaWcz6or+ktkr8Jpq7zHHF7LVIBzQXhQwCNqInjxxT+EHMTGo2tr7AkwQ9
         kW9CopiTcmhv1M94G/Qj85LlpBTeat6dFulqWA9ZQ/Mb1zGJSNUyHLMwmAerEgzSMAcK
         VvXnNlrrDQ6+qNxKlPxua1cIE2kQAXaxSmbVzvexVxX6k7CxSGek1KpRHrxFNOhxnuPp
         i5cQ==
X-Gm-Message-State: AC+VfDxYLn+UztXcGLzxj/GfOchZZABQ5SnI7CS3iQOB348T9nS8oHwn
        OGs0/U7pd5Vz41wct1owRELA3Olhq1ddoIjPHBnP/g==
X-Google-Smtp-Source: ACHHUZ5aZq3T+cKaBVve2ZSIlJTcikeOnFMzoxYFpV8zPQHL6HeFofj6o/3qbh7GbO6bfb6uKIPjTQ==
X-Received: by 2002:a17:907:971d:b0:966:d59a:4ba6 with SMTP id jg29-20020a170907971d00b00966d59a4ba6mr57178ejc.43.1683470890593;
        Sun, 07 May 2023 07:48:10 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:1757:b51a:9965:e81])
        by smtp.gmail.com with ESMTPSA id t2-20020a1709067c0200b00965c529f103sm3659685ejo.86.2023.05.07.07.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 07:48:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] gpio: davinci: correct non-kerneldoc comment
Date:   Sun,  7 May 2023 16:48:07 +0200
Message-Id: <20230507144807.193009-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop kerneldoc annotation from regular comment to fix:

  gpio-davinci.c:716: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpio/gpio-davinci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index aaaf61dc2632..3063e57a4174 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -712,7 +712,7 @@ static struct platform_driver davinci_gpio_driver = {
 	},
 };
 
-/**
+/*
  * GPIO driver registration needs to be done before machine_init functions
  * access GPIO. Hence davinci_gpio_drv_reg() is a postcore_initcall.
  */
-- 
2.34.1

