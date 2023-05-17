Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368E770665B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjEQLPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjEQLOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:14:47 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA352D7F
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-510bcd2d6b8so5691168a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684322082; x=1686914082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEOOEjR671HfmOXPgQqMUHzrdAM2unOi/T1lUcVo2j0=;
        b=AzaZ4guzFC7mjzLyKRvNGAUkMMT+3Wa2whIOYVnJeD+QyZ8EBww+DnbNc8pW9F8KvM
         RoEO4BMABU8T3j9OJeY7RXkgrFJO88Qc3bpF9ewu6lRPm01+JjTV7QXpBSOJo38+G8bp
         apympiZR1cjbuuKJFlidTumihU9/KGAQLnnSaSrQSiGNyPYssn1XKliSaqWAnHV21pwQ
         atF8ps54PE8dNWH2cPVxYzif9k97D77l9URcXuo+ehsuiyRzh0F5C97ifI6JIyvQj6w5
         SyOurd9nCf0A2D4c4Zw5WLOYPJ79xD5KufmjXXKv+Vzwwnbe+w/A0c4Ay9Jig7OrVISB
         VBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684322082; x=1686914082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEOOEjR671HfmOXPgQqMUHzrdAM2unOi/T1lUcVo2j0=;
        b=Efh7IC2ohCJtkcO1Aim1buPQGzOCCk336vQzP6xpt7bc66o/TVpbd69LF6uJVrGKGJ
         Sq7PAtP8ZYCQuuw/uQWJVtM55lZtn671cKXscV0tunmBfGmHWRvmrdgAUpJAAOjFo6r0
         hJuoKF/e3JMxhkzwp0gylSyZwB5BlP5cuMMUozAg5vrMijWuU2C98w/phjdf2eoAkudR
         iB+gvQTFCmvIhO6tJhlfI1ovU+NYzvvlu/HCOUFASINNZRP216iTkuQRhxi/zR7r0O/R
         4NotcpVhKIoAGRk7lJ96uGtAti5CBuK1WtGAQ3tJPKGDfU7/0dA3uMByAJnUL7B29GEf
         9HSw==
X-Gm-Message-State: AC+VfDwklY5aCvM2zRRvKDpx2g8rRjz69RvV/8BdP7tJmVFwLBYNWvHj
        yKGdRjKO7nSTNCbcXNvJRZoYcg==
X-Google-Smtp-Source: ACHHUZ59bqvno6jHhPiAuS2Tvt4ztbcI9pGqM5YYNJMWeveZwz+QiRkdhrj2byFPUKW1FIM+Mx3+Tw==
X-Received: by 2002:a17:907:3e21:b0:94f:2020:b5dd with SMTP id hp33-20020a1709073e2100b0094f2020b5ddmr1773127ejc.24.1684322082024;
        Wed, 17 May 2023 04:14:42 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id ml18-20020a170906cc1200b0094f124a37c4sm12326880ejb.18.2023.05.17.04.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 04:14:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 04/12] ASoC: codecs: rt5682: do not store status in state container
Date:   Wed, 17 May 2023 13:14:08 +0200
Message-Id: <20230517111416.424420-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517111416.424420-1-krzysztof.kozlowski@linaro.org>
References: <20230517111416.424420-1-krzysztof.kozlowski@linaro.org>
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

Driver in its update status callback stores Soundwire device status in
state container but it never uses it later.  Simplify the code a bit.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/rt5682-sdw.c | 5 +----
 sound/soc/codecs/rt5682.h     | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5682-sdw.c b/sound/soc/codecs/rt5682-sdw.c
index 6e3b5c5eced1..67404f45389f 100644
--- a/sound/soc/codecs/rt5682-sdw.c
+++ b/sound/soc/codecs/rt5682-sdw.c
@@ -500,9 +500,6 @@ static int rt5682_update_status(struct sdw_slave *slave,
 {
 	struct rt5682_priv *rt5682 = dev_get_drvdata(&slave->dev);
 
-	/* Update the status */
-	rt5682->status = status;
-
 	if (status == SDW_SLAVE_UNATTACHED)
 		rt5682->hw_init = false;
 
@@ -510,7 +507,7 @@ static int rt5682_update_status(struct sdw_slave *slave,
 	 * Perform initialization only if slave status is present and
 	 * hw_init flag is false
 	 */
-	if (rt5682->hw_init || rt5682->status != SDW_SLAVE_ATTACHED)
+	if (rt5682->hw_init || status != SDW_SLAVE_ATTACHED)
 		return 0;
 
 	/* perform I/O transfers required for Slave initialization */
diff --git a/sound/soc/codecs/rt5682.h b/sound/soc/codecs/rt5682.h
index d568c6993c33..301d1817f8f1 100644
--- a/sound/soc/codecs/rt5682.h
+++ b/sound/soc/codecs/rt5682.h
@@ -1440,7 +1440,6 @@ struct rt5682_priv {
 	bool disable_irq;
 	struct mutex calibrate_mutex;
 	struct sdw_slave *slave;
-	enum sdw_slave_status status;
 	struct sdw_bus_params params;
 	bool hw_init;
 	bool first_hw_init;
-- 
2.34.1

