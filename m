Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89830707AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjERH2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjERH2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:28:03 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27BC19BB
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:28:01 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-96622bca286so320664666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684394880; x=1686986880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJY+f/kyvGT80qDu/2YzrWbFWrXecvsPv92RJrnC6oM=;
        b=O9ourAIqiWUoA66Do64H+sF3x/mqeWBFY1RLtuUwyPqlqUUj+RaoCyPjATbGFzY6uP
         vv0n+QcH0YiWtYMVbl1DtrxKnskNmlVpnXcM2bELSuVYkIkwQyakVQiDdim2G6qCuZ1b
         LTF2tCNi+KHuG/hw6oFjAiK8qNLZebZYgeBnKvMH41x6m4T1LBtpxQF/ljm3QFHyRiHL
         lwwJMfNpG9gK6QGBkGC0iebrnNFhiQk8ThPZ+PMDWSxHwb1c5tpfQ6dsDevIxJgPybVS
         artNLQuSEdRZ6dsivfMk0624OjTfKDz7aKmjWmcOYrWkAVkDK0TrwPjDrlc42proM92w
         ofEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684394880; x=1686986880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJY+f/kyvGT80qDu/2YzrWbFWrXecvsPv92RJrnC6oM=;
        b=VO5W5YW0rmw8QPVOfqC+Sj26FZbZAE3HL7KmZizRrbLEH57V94aIdE5zf1okBrIxpo
         e585xNyIEoVQ8fGk7Y3OGwvkuBZ3xb+mPkcjkBEFS11YLB3YtSOh54eho5m5r2gh3a3f
         ZCJFdGXfLdScEZZsNMPXYxhbgoxf+b10SAb+yQKsuDfv0+ZHedBGRWNdAxZ2DLvSpr9f
         CJH0phB3q13wD5gyISTzhOTNGJbxxpDiJ/Aovj2byDJ7yM75Ae/9H3gUWY7ag/fop94Y
         yT3hTpSpxkSOYj2mAGjc4wGcwf8Xpg1VPszt3Pt0/lSrvqvoi9X8BH5E3DYw0fZXbMkl
         mzJQ==
X-Gm-Message-State: AC+VfDwOKr/+hl074cSWAKDcHpbWgGH0cf4HlimzQXbyvkitEhe2wFKC
        rep3YUSHWd4dVJ2oq8Hvw1UJfA==
X-Google-Smtp-Source: ACHHUZ4u5KhX1gbFbc1OQdpkGq4jRhdU94xrmSghEO85zLrbApdS3ipuJkXCJSa18RAmDtrB+J5qjA==
X-Received: by 2002:a17:906:ee82:b0:94f:1a23:2f1c with SMTP id wt2-20020a170906ee8200b0094f1a232f1cmr36770723ejb.50.1684394880586;
        Thu, 18 May 2023 00:28:00 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a2b:c408:5834:f48e])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090669d100b00965aee5be9asm594241ejs.170.2023.05.18.00.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 00:28:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RESEND PATCH 03/12] ASoC: codecs: rt1318: do not store status in state container
Date:   Thu, 18 May 2023 09:27:44 +0200
Message-Id: <20230518072753.7361-4-krzysztof.kozlowski@linaro.org>
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
 sound/soc/codecs/rt1318-sdw.c | 5 +----
 sound/soc/codecs/rt1318-sdw.h | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt1318-sdw.c b/sound/soc/codecs/rt1318-sdw.c
index 795accedc22c..3751d923611c 100644
--- a/sound/soc/codecs/rt1318-sdw.c
+++ b/sound/soc/codecs/rt1318-sdw.c
@@ -456,9 +456,6 @@ static int rt1318_update_status(struct sdw_slave *slave,
 {
 	struct  rt1318_sdw_priv *rt1318 = dev_get_drvdata(&slave->dev);
 
-	/* Update the status */
-	rt1318->status = status;
-
 	if (status == SDW_SLAVE_UNATTACHED)
 		rt1318->hw_init = false;
 
@@ -466,7 +463,7 @@ static int rt1318_update_status(struct sdw_slave *slave,
 	 * Perform initialization only if slave status is present and
 	 * hw_init flag is false
 	 */
-	if (rt1318->hw_init || rt1318->status != SDW_SLAVE_ATTACHED)
+	if (rt1318->hw_init || status != SDW_SLAVE_ATTACHED)
 		return 0;
 
 	/* perform I/O transfers required for Slave initialization */
diff --git a/sound/soc/codecs/rt1318-sdw.h b/sound/soc/codecs/rt1318-sdw.h
index 85918c184f16..86e83d63a017 100644
--- a/sound/soc/codecs/rt1318-sdw.h
+++ b/sound/soc/codecs/rt1318-sdw.h
@@ -88,7 +88,6 @@ struct rt1318_sdw_priv {
 	struct snd_soc_component *component;
 	struct regmap *regmap;
 	struct sdw_slave *sdw_slave;
-	enum sdw_slave_status status;
 	struct sdw_bus_params params;
 	bool hw_init;
 	bool first_hw_init;
-- 
2.34.1

