Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7BC6E30BE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjDOKoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjDOKoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:44:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397798A74
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:19 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94f32588c13so3180766b.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681555396; x=1684147396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6aFDy/SB7tnUF0+eQ7zFT5mQKFJQM8aVqeD2imV3VFQ=;
        b=YQEkWEK4VR8sC/8J0bTo0pPtA5ui12m+R4UvuHGj1HnX7Rq88fDAaf9QOhDXbO2yAl
         Y6icCppsb5LAK3+IWX2txT9xtOeV1PSM1x0ZjaEECRZGv7rhumJb1C0NS2R72MHLTkAR
         jPTKO7QHkfWTjn+Hn4iNlw0USmKQN6Hm1ppS5Frr3Th+IXX7yVfVF+GWUS2duwsg6Kff
         l8D54PAk2fKpq5bdHRy3Qb3qPcR2+/qzN+yNPOGqAPfIYen2Y6IwbRpwcuvMlgNQFaAI
         B/cc7Cu6MpxZELECRwgBqGcWbqXdBQ+lYVt2Jjqoo/NdkXCZbTgkzLK+YWQAjdY3NqAR
         W+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681555396; x=1684147396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aFDy/SB7tnUF0+eQ7zFT5mQKFJQM8aVqeD2imV3VFQ=;
        b=f4CPhgwUvJTfJDilecnE9x2NkA/oxuS2LM8APNmCQz/ZnTPeW/C82BYWL1a6xTMo4L
         BpDsKvPq2/eRUTh0smvBtyMKr/D8K8J1uDMT6EQ9ruL9UE3i5ThM8UdFgijO2QfvkCfV
         QMrf0d7ncM4oZUD5VqTdnYWrtAvVhJFYpocgv4EcTqVLzW8Bd4Hsl8xjq9qu1rrOiGL3
         X7b2/eXkfMAl/QTWS1ZCIgINFZzq0P7tx2A5nIu1M0mO6iddvTp6ZqHqi03eHxxqdcAF
         STdHnK7LNCbth4mwUENeE+WxcsO700oKAl5Z25WL3Mmj13TM/O99F2pgKecvt6ZRo6f3
         AHVg==
X-Gm-Message-State: AAQBX9fGnmkDpj8A1R+Pv1JC6PbGu92txAPhXQHUYPZpLHzblElHYIQV
        o8l+j0pJkGj/5yzYt9L/1ouiaA==
X-Google-Smtp-Source: AKy350Z43wpLjbwwzoveofc5k6ZjhabN/INplT3i3zKAYsqb/f/i29jvpuHEVTH+7+a/rogzU+ed3Q==
X-Received: by 2002:a05:6402:517b:b0:4c6:10a7:c422 with SMTP id d27-20020a056402517b00b004c610a7c422mr9151637ede.18.1681555396527;
        Sat, 15 Apr 2023 03:43:16 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a3bf:4ed:6c53:2a36])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7d48a000000b004fd1ee3f723sm3157481edr.67.2023.04.15.03.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:43:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 01/15] w1: ds2408: drop kerneldoc annotation
Date:   Sat, 15 Apr 2023 12:42:49 +0200
Message-Id: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop kerneldoc annotation from comment which is not a kerneldoc to fix:

  w1_ds2408.c:210: warning: This comment starts with '/**', but isn't a kernel-doc comment

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/w1/slaves/w1_ds2408.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/slaves/w1_ds2408.c b/drivers/w1/slaves/w1_ds2408.c
index ad102c577122..7fa911989193 100644
--- a/drivers/w1/slaves/w1_ds2408.c
+++ b/drivers/w1/slaves/w1_ds2408.c
@@ -206,7 +206,7 @@ static ssize_t output_write(struct file *filp, struct kobject *kobj,
 }
 
 
-/**
+/*
  * Writing to the activity file resets the activity latches.
  */
 static ssize_t activity_write(struct file *filp, struct kobject *kobj,
-- 
2.34.1

