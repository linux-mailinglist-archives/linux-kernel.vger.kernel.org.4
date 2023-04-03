Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF706D40D8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjDCJlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjDCJkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:40:45 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED73E10416
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:40:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eg48so114682560edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 02:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680514819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FSiRdzM/Hcoj6ys0IYZsAKkIeh1yNctbREvv/DtXe/Q=;
        b=ZkP/A1aIjm21E8JZo1mu1+sp7Ulo4zuCCCic25C+tfwXK4nhe8HvwFY8AdF7OFv6qv
         HZGBrI1kL03OdoBRRa0Ow7Mkbm6dbZwpcV7cgrd/xhgl5xGQEw+Iggd0OVcSqPABZyvo
         +2Rlm7RZwYfFDhsYdCnb716yXk2iAcNWo324ioXxcAa6nOux98c45dq5uGz/6lJMzG9e
         fJ0/iPiZUhMBVcrjG4quz71pwtXUZFc3SGkr/g3yXwzhIXrBlz8xHIvM7KUNDvUiEFwj
         3a2vVV0i97CA++/FsNr6FGWpeNZZ0MJ70pglo5If1HEI1QUAmccUaq9VKAqdFUO8Yx33
         cTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680514819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FSiRdzM/Hcoj6ys0IYZsAKkIeh1yNctbREvv/DtXe/Q=;
        b=IUjazsgozDVhGDIpyEyF+kHLoaxwZF4TfVNapgr9Z/HZY60jPEqBZMKs62G2D04ZIG
         GJ8bM0cWZaPA614uCZRwVnIB9Zw0d/XYqtZOEhIFkXFXyxrXXtcsxIzCcKicjjx1PpZ9
         6OANNGJ1xFvnn8T7aFKqPVWkp/asDaUgyEupTJg5H5azTaKRp4EyMpLyk9YUv192/zu2
         9/Q3h71H3F16NgfkBfee+4HI+6o0ph8TJ/yQfOnraLC8lriZO6R2cGuXcm4LlnukCvp+
         bdeSDDE9PBhLmPAl68Dhk5AgiPNewj8uZ2FjDzPSWWEPDhqkRfMhk22wZZDwpRvu4dcn
         z9ng==
X-Gm-Message-State: AAQBX9e1Qa42x1HFkU/nPYMDNr/wDeAjixzT6wPMjp13NZjVX7Wx/0ta
        OskTsPYQZedtu7a3riaKMpOBUw==
X-Google-Smtp-Source: AKy350bnFDoaDvJBvx9QtkqlucDG4g1KZb+aUGo2QU0ZaPEWeT85ScjK+bX/MK6H7RqwWFElVS4TTg==
X-Received: by 2002:a17:907:7788:b0:932:c1e2:9984 with SMTP id ky8-20020a170907778800b00932c1e29984mr33858694ejc.58.1680514819387;
        Mon, 03 Apr 2023 02:40:19 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id l24-20020a170906079800b00930d22474dbsm4311244ejc.97.2023.04.03.02.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 02:40:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH] clocksource/drivers/exynos_mct: explicitly return 0 for shared timer
Date:   Mon,  3 Apr 2023 11:40:17 +0200
Message-Id: <20230403094017.9556-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a shared timers, the mct_init_dt() should not initialize the clock
even with global comparator.  This is not an error, thus the function
should simply return 0, not 'ret'.

This also fixes smatch warning:

  drivers/clocksource/exynos_mct.c:635 mct_init_dt() warn: missing error code? 'ret'

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/202304021446.46XVKag0-lkp@intel.com/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index bfd60093ee1c..ef8cb1b71be4 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -677,17 +677,17 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 	if (ret)
 		return ret;
 
 	/*
 	 * When the FRC is shared with a main processor, this secondary
 	 * processor cannot use the global comparator.
 	 */
 	if (frc_shared)
-		return ret;
+		return 0;
 
 	return exynos4_clockevent_init();
 }
 
 
 static int __init mct_init_spi(struct device_node *np)
 {
 	return mct_init_dt(np, MCT_INT_SPI);
-- 
2.34.1

