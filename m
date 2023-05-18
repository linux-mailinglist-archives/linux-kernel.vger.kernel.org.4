Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5139B707ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjERH2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjERH2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:28:00 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9D519BB
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:27:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-510ddeab704so1210579a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684394878; x=1686986878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY4US8j109ap8g7iJPTxaqGh/0KFUvHJ6e/HWa50JR0=;
        b=VdCXcIJz3zJr+Z194kctgRAjtWQyZ8oKgT3cqsKr2mbtExnmGXiP6sq1k6ff7pm/cB
         /2TbXgKWQfA5/hdwYF5YeQPaNdZAM6GBNHvIztoou8hegf3uUbCwiCQxBQX7becb0J6M
         lSzA5ZWORuBJMzq9QGt1+2CoYD/6tUMsrMb+62zbEZTlWDdZp4urjE1QejdtIqapndS6
         J/0dwAFwWXC1PxLwiryYg76queLaMNfzQKhH1j10QGIqdXI/u+qvtIS2ObSyuWofmM4x
         Rj4fm6iHvvf27XCjbs63mUYGm8d37NdEiWizcFIZBEva1cii+s7v/DLYuB2hA1gu/0bl
         GaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684394878; x=1686986878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY4US8j109ap8g7iJPTxaqGh/0KFUvHJ6e/HWa50JR0=;
        b=jzvEjT9scgvkrCk9hWUAP8UeZ0qA+Fh6DsUMyVPN9ihUBLY/lseCtq/bY+ZaXgt6SB
         Os4yZqrA21KMwAUvRIAqLYJ/NBEgSzHBYxY+1h3D1bDLTrN4b3PifB2JZ9Idcu6KhMdj
         YFYj/PusOljJab0VmoUutH7YPrmwR3/F5UW8jowaSwfys7pVJKiD5jfOab8GkE7qfQCB
         lHBLRuiMEvffuS8aMr+2qIm9hgObhIMhzuSoDdnDWrNQ2rD8fjIj0rkrsHuTfdWO1858
         p9NNJJ4O00oB3AksgqFT8tBz9cdF7yyfY2doXQZhag8REdwjGlcgqWRMap2pWrHVLmGI
         BY2Q==
X-Gm-Message-State: AC+VfDxftscLBdyNsAJbKkTvZOW+9nz9VJgZ8Fkr2DH/V0M2AxOaJdip
        reLsqLHi2fOB7RDHlYH4jDjHvA==
X-Google-Smtp-Source: ACHHUZ54EI6Z2Sgw4IUl4GkQXP2DPVdI/bOYfBxdQhdJbWUdQ69lrxWikweBVU6nlqSvZnHHhpQn9w==
X-Received: by 2002:a17:907:1ca8:b0:96a:bfc:7342 with SMTP id nb40-20020a1709071ca800b0096a0bfc7342mr32079981ejc.62.1684394878057;
        Thu, 18 May 2023 00:27:58 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a2b:c408:5834:f48e])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090669d100b00965aee5be9asm594241ejs.170.2023.05.18.00.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 00:27:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RESEND PATCH 01/12] ASoC: codecs: rt1308: do not store status in state container
Date:   Thu, 18 May 2023 09:27:42 +0200
Message-Id: <20230518072753.7361-2-krzysztof.kozlowski@linaro.org>
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
 sound/soc/codecs/rt1308-sdw.c | 5 +----
 sound/soc/codecs/rt1308-sdw.h | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt1308-sdw.c b/sound/soc/codecs/rt1308-sdw.c
index 1797af824f60..313e97c94532 100644
--- a/sound/soc/codecs/rt1308-sdw.c
+++ b/sound/soc/codecs/rt1308-sdw.c
@@ -304,9 +304,6 @@ static int rt1308_update_status(struct sdw_slave *slave,
 {
 	struct  rt1308_sdw_priv *rt1308 = dev_get_drvdata(&slave->dev);
 
-	/* Update the status */
-	rt1308->status = status;
-
 	if (status == SDW_SLAVE_UNATTACHED)
 		rt1308->hw_init = false;
 
@@ -314,7 +311,7 @@ static int rt1308_update_status(struct sdw_slave *slave,
 	 * Perform initialization only if slave status is present and
 	 * hw_init flag is false
 	 */
-	if (rt1308->hw_init || rt1308->status != SDW_SLAVE_ATTACHED)
+	if (rt1308->hw_init || status != SDW_SLAVE_ATTACHED)
 		return 0;
 
 	/* perform I/O transfers required for Slave initialization */
diff --git a/sound/soc/codecs/rt1308-sdw.h b/sound/soc/codecs/rt1308-sdw.h
index 04ff18fa18e2..f816c73e247e 100644
--- a/sound/soc/codecs/rt1308-sdw.h
+++ b/sound/soc/codecs/rt1308-sdw.h
@@ -159,7 +159,6 @@ struct rt1308_sdw_priv {
 	struct snd_soc_component *component;
 	struct regmap *regmap;
 	struct sdw_slave *sdw_slave;
-	enum sdw_slave_status status;
 	struct sdw_bus_params params;
 	bool hw_init;
 	bool first_hw_init;
-- 
2.34.1

