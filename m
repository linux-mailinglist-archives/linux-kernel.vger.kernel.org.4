Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363AB707AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjERH2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjERH2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:28:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3430F2115
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:28:04 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-510b6a24946so3165038a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684394882; x=1686986882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1eT2t6FyxP9v83v8PrBLX9IzlgvVZW+pMXaKU/JtJI=;
        b=M8Z6vWY0wCGKAcqY9LaP8M36odcIRn0KCyKWNrqM5ddKXkyrIU91p680g/kzWZJm2w
         09b4ex46qbjwZSYSqaACstpD+I9r8FxtvIOG1XjHF+EETJZmimB0gy8lziYy3wmWV4ql
         viZEV65VAOX4zkrD/hQnwsW0GPCcMaqQ4h32e2qTlqsHBJ3smGTN38fbiGQfqkDthQ/H
         oUcxO2J04xq+u6rPLfZfVH9wO/byS1P5SNfQOBflWeKZo/WjWtkoZnV33IdBu2iVmxZP
         BhFufBFLBwHrli6CC+Mpz0HEzlIjFupoepTi6k1k9Wr+V2llmRdxJJJm4xDlGWhe2KIY
         KiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684394882; x=1686986882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1eT2t6FyxP9v83v8PrBLX9IzlgvVZW+pMXaKU/JtJI=;
        b=i53zL6B6+aJM1H41inT27zNkfSm/lonvOv3uK+7uRFNIdwMocTgadmyCz9uH5cKl48
         Kj3yjhRXEnYb1yFAzbmAucpmkj4pCKUr77MvdqkH931laSj4DLkm24LpaTf06Y8mNGkt
         JOw4IQBQAloCyNmB+pvpzUkluQcBkhhi5Jonuk2Vr7Sox16nk+KD9okFoX9/KfHaP9iZ
         1RFW/wNWXKfwgI2lkwhhtnn1E5sJTnRi8CN8xzT9P8q+fZA+nSt7IoE+HGwMiMeUb5GP
         S+9wrmcCZATUOyQmRciHKl8RFQYeuien13Jvmx8KjO8kXPWUn8O1j9Wen/KQwdO9XmW/
         LBTg==
X-Gm-Message-State: AC+VfDzeI4TGNNbaEDfV/m3DHYCP57Ku3rSMSciW2xCAYzaO3upU9F+S
        1B7Rl0nL8thDXTbZm2qUQYG0CA==
X-Google-Smtp-Source: ACHHUZ5ygHn4ldIoZ76oJhZdVGGwuW1NLDvZkJWMysRNSoLrD1RTw0zMlD9CIej5G8rxwodu/f9YUQ==
X-Received: by 2002:a17:907:a424:b0:96a:246b:c65d with SMTP id sg36-20020a170907a42400b0096a246bc65dmr27786016ejc.12.1684394882778;
        Thu, 18 May 2023 00:28:02 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a2b:c408:5834:f48e])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090669d100b00965aee5be9asm594241ejs.170.2023.05.18.00.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 00:28:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RESEND PATCH 05/12] ASoC: codecs: rt700: do not store status in state container
Date:   Thu, 18 May 2023 09:27:46 +0200
Message-Id: <20230518072753.7361-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518072753.7361-1-krzysztof.kozlowski@linaro.org>
References: <20230518072753.7361-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver in its update status callback stores Soundwire device status in
state container but it never uses it later.  Simplify the code a bit.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt700-sdw.c | 5 +----
 sound/soc/codecs/rt700.h     | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt700-sdw.c b/sound/soc/codecs/rt700-sdw.c
index 96fc5f36d0d0..ba7767bee07c 100644
--- a/sound/soc/codecs/rt700-sdw.c
+++ b/sound/soc/codecs/rt700-sdw.c
@@ -315,9 +315,6 @@ static int rt700_update_status(struct sdw_slave *slave,
 {
 	struct rt700_priv *rt700 = dev_get_drvdata(&slave->dev);
 
-	/* Update the status */
-	rt700->status = status;
-
 	if (status == SDW_SLAVE_UNATTACHED)
 		rt700->hw_init = false;
 
@@ -325,7 +322,7 @@ static int rt700_update_status(struct sdw_slave *slave,
 	 * Perform initialization only if slave status is present and
 	 * hw_init flag is false
 	 */
-	if (rt700->hw_init || rt700->status != SDW_SLAVE_ATTACHED)
+	if (rt700->hw_init || status != SDW_SLAVE_ATTACHED)
 		return 0;
 
 	/* perform I/O transfers required for Slave initialization */
diff --git a/sound/soc/codecs/rt700.h b/sound/soc/codecs/rt700.h
index 93c44005d38c..491774d207de 100644
--- a/sound/soc/codecs/rt700.h
+++ b/sound/soc/codecs/rt700.h
@@ -15,7 +15,6 @@ struct  rt700_priv {
 	struct regmap *regmap;
 	struct regmap *sdw_regmap;
 	struct sdw_slave *slave;
-	enum sdw_slave_status status;
 	struct sdw_bus_params params;
 	bool hw_init;
 	bool first_hw_init;
-- 
2.34.1

