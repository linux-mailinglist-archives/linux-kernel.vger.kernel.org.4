Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939C56E30C4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjDOKoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjDOKoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:44:06 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6E74EF4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:27 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-504ea515d6fso3384612a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681555404; x=1684147404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItnFwDfcwsqeS2QehC4MzuWbNu7xUa/nTNiku0cT6q8=;
        b=zeV7LuBrZkIjBK7n40U3u33EVUV8ktgLJgumBB/CXtFsUTLE98GXhp9rXGaDxxWW43
         2bNss8gDD2OxajnwJdmBav5Mu5b1XPqwgfZ5uWfKqjQitDidTummuAQkl6TXF8yJXraT
         HvWlNqhSfodkzfdRLg3dHpK8BRaBopDgLd5NqFCGfr51pA20dGUkWDzW0ON4wto5O1uR
         DVu/3yMRDhAheB6FUP546DdkOM5wG/Pv+zx8pt3s3UzPaHqLR79F4G1ChmT2tNw0ZLWL
         ke3sdlZBqJxrSu2VlZaaX1TBJOMqiuJ4jUxlE9pHJstvOpIcxy+1t2BAwxVZLW1qK2up
         7pXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681555404; x=1684147404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItnFwDfcwsqeS2QehC4MzuWbNu7xUa/nTNiku0cT6q8=;
        b=GDcV9GmuxEBDTEE1qNZgoGnV+8g49tUJlz40owfzeQsTqVMl1dYt/7ZtT9GSt1h0Sk
         stazrGOdcv6Tg0sbinF5tkJ3j1rl5uUaN2uWQ8qoBIAPj6g/2oO/GnJJHcgKb7J14L7k
         SJSUXvgOrskohFgd8v+/U4N9yOkJhuOjSXeEfOsd/RAaE7glrvXXk9FQgDzWiZ//9d5e
         GA4zOuc2F0yU0YUE2Umlqo4MMn9CftIjYWMXzgQXioYd7X3vs03mD25EevqR7RU/3zJN
         x3bdkfQ3ewov6OOgSjn+1KfEnAs2WZjrjF+BSngACf0Ve9XHTUmlGEKW+ajAPCiSDlB8
         CUXg==
X-Gm-Message-State: AAQBX9ddCYNESdP2y86fPldfBegfF6FxlT9i2YlquCGOlwRXaDg/tExY
        p0/2iy6/3z0a5Qs8IMw9rYodgQ==
X-Google-Smtp-Source: AKy350bPRbufNSuY7GUQjKnVdZFyy9yhi/blBYi5kJOs+vNjjp0jCuOVqYlC340a/TPCzmSIT5S1Yw==
X-Received: by 2002:a05:6402:1156:b0:506:8838:45cc with SMTP id g22-20020a056402115600b00506883845ccmr2817127edw.6.1681555404418;
        Sat, 15 Apr 2023 03:43:24 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a3bf:4ed:6c53:2a36])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7d48a000000b004fd1ee3f723sm3157481edr.67.2023.04.15.03.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:43:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/15] w1: ds2482: drop unnecessary header
Date:   Sat, 15 Apr 2023 12:42:56 +0200
Message-Id: <20230415104304.104134-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
References: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
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

linux/delay.h is already included, so drop asm header to also fix
checkpatch:

  WARNING: Use #include <linux/delay.h> instead of <asm/delay.h>

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/w1/masters/ds2482.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index 90c0a33747db..7e915b71045d 100644
--- a/drivers/w1/masters/ds2482.c
+++ b/drivers/w1/masters/ds2482.c
@@ -15,7 +15,6 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
-#include <asm/delay.h>
 
 #include <linux/w1.h>
 
-- 
2.34.1

