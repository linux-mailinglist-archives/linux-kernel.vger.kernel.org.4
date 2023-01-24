Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E950679EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbjAXQkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbjAXQkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:40:04 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E94746A3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:40:00 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so11392313wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9X8Ucbf6sRwlUnn/8vBIIf3X5AUVXDo3mvuuIk6r0o=;
        b=Hekbhkge6JdDOnAucugsOX9pzI/aFw6Jo38Suz1gg8qj9+FE2PR8rStCUCJBvAWUo/
         ft4B5epJsuIvQb/TKOnQQfFyq3GSMZNRpdOLVHVaE+6PXkaq+0ObMSxzu4itvLQvSqtJ
         wyjqfUBWkRcVBJXxaJKx0nmrxaM2+Fs47JyLR3iw8HQY6NFk6hqhfEfq79ro/WR9SA4p
         +QLechW8H7DNl/1JmDDIIVNYWb9m1/MSXYpN609QygZPcMB306OTkICxzSFICCeSpd5a
         xcnA0h4UEKOpwSKLYwk8HVWmZOZNKb4hT+LynuHabx+9a6N6VxWIZmCoRHm1kmCW9yzS
         Jy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9X8Ucbf6sRwlUnn/8vBIIf3X5AUVXDo3mvuuIk6r0o=;
        b=jgTlhWUWmzNTI6cQ+YTBP/GG/bWS1I09d8LMGYr9BTdc2+oHzD3BT9Ft8qhJx7R94k
         l+shdoZi6arua1jO0bqcOoTdGHFARnfARtoLqqU7Wr1yXmDyfrVcew7RPITumlE2cxTa
         fksslT2OxUAHe1amGMOHL0Bx+ShuCDn+OcfzuzjWE3OBaZ3UV9lLW0cbMAfplmIuhSbv
         NuP5rSRspH9SFl/mOWHmFWwH+LbGZfxozBjx7IhGaUcOhN7+klblXW6BsmGAdaa2dXxu
         UDmzLHQwIJZtzX8gBp26iE1l13mHwGx685sylEt2hHFkRKQhfk3DcXLljgLIFvXb18GN
         bSwA==
X-Gm-Message-State: AFqh2koJpxFiRdzWvkCpwiuEOg3fJcNUqztLZ/nRzXSbb4r4fsvRS6zp
        54FSEu7gSbvsYi+JAWFD/awXNg==
X-Google-Smtp-Source: AMrXdXt3sM9Ukk5z/BxKYw61KeZj4A9AedI7C5vzHWTUGQt3/b6pDwSGVspfWegeP6N9bzaP07qt3A==
X-Received: by 2002:a05:600c:3582:b0:3d3:5c21:dd94 with SMTP id p2-20020a05600c358200b003d35c21dd94mr25595559wmq.9.1674578399087;
        Tue, 24 Jan 2023 08:39:59 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h20-20020a1ccc14000000b003dafbd859a6sm13477147wmb.43.2023.01.24.08.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 08:39:58 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] ASoC: codecs: wsa88xx: remove unneeded includes
Date:   Tue, 24 Jan 2023 17:39:53 +0100
Message-Id: <20230124163953.345949-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124163953.345949-1-krzysztof.kozlowski@linaro.org>
References: <20230124163953.345949-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded includes from wsa881x and wsa883x drivers.  The drivers
do not reference anything from the headers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wsa881x.c | 3 ---
 sound/soc/codecs/wsa883x.c | 4 ----
 2 files changed, 7 deletions(-)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index d142ca9f2fb6..f709231b1277 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -5,10 +5,7 @@
 #include <linux/bitops.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
-#include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index de3f4b9b0dba..c609cb63dae6 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -4,16 +4,12 @@
  */
 
 #include <linux/bitops.h>
-#include <linux/debugfs.h>
-#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_gpio.h>
-#include <linux/of_platform.h>
-#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/printk.h>
 #include <linux/regmap.h>
-- 
2.34.1

