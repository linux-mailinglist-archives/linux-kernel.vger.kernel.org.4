Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60640706659
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjEQLO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjEQLOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:14:43 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7555A46BC
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:41 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9659e9bbff5so105167766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684322080; x=1686914080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAqmALiwc11sAnAJSge5XtvJDOci8R9bv0tfhhHhu0U=;
        b=Xtqjci4XXLDyaSfLmoL3GH9a66Wn20m9qX10IAhmV5YCbC9FqW/gSQhxvp8mMTJpNE
         OeovLhwFZuK2cGjdqe0dZkA9Ub46RgWo31XNE4W8793NsgsxRjrvggmNki0sdcC711fF
         f4VYa5bA9X8UtiOddbUZ+4s80EGBHLCOYPLlv7FjFz++siY4Rfl+xFnUnRq5tDfWMf88
         AcFqRubiMXgUBXyoKYD71Q1lzNzWT1TNX/S9RO0oqx8xKSTXTVnILq8W6YCY/mTaNHVz
         fV3YGEd2vKyHx/ryBmYY5Q105wjikO7EQ32VB9OLbL2lkz05+s6dOtVtyoXpk67lVD61
         iSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684322080; x=1686914080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAqmALiwc11sAnAJSge5XtvJDOci8R9bv0tfhhHhu0U=;
        b=ZeUpT5VZO5wc1IAFq1OUPGyCe9IevMK+kHH0IyQkZ5TTdKVQywwIdLbUVRcOY/xI0i
         FrcmGl6He55jmI5LEoltIUt+Q07iMgJzuhS8BB8oOHnYYLljfwiLuV4YIk+XIq6RVfwL
         zTUiWwfEGUNTfvgvqcWBBEgjCU3WzGnYwwKo8RLFXBy5t4DBMFVk34WnjZHJIX+9maj3
         PY4Ci2YaDEDDnmUnM5Zhlo5jAyzp5rCNOCl9ArcUKXARRdrZ3q5Y5hujitF6mvEFaMQ0
         bk7V4VqJVhq7ufO0RHUJN4jLMr4XK3R8Qx4hexbTlSyi33vBKJ4iuTaRezVGuq9yAn6Q
         J69g==
X-Gm-Message-State: AC+VfDwjvPtodLJvAqb4MWe6R7tcpGEyl3EjMedaRcOe4kx+5wkHuRAo
        hEFAyvVs8xkcg1mFwEwnysar5Q==
X-Google-Smtp-Source: ACHHUZ6HWoBfX2XrD7IXrL+hJZA8QoR0fr8+uZLTZShrjMYmoYmQnhgXL7NPlQyHhFag68Tv7SlmAQ==
X-Received: by 2002:a17:907:1614:b0:8a5:8620:575 with SMTP id hb20-20020a170907161400b008a586200575mr38600206ejc.3.1684322079941;
        Wed, 17 May 2023 04:14:39 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id ml18-20020a170906cc1200b0094f124a37c4sm12326880ejb.18.2023.05.17.04.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 04:14:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 02/12] ASoC: codecs: rt1316: do not store status in state container
Date:   Wed, 17 May 2023 13:14:06 +0200
Message-Id: <20230517111416.424420-2-krzysztof.kozlowski@linaro.org>
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
 sound/soc/codecs/rt1316-sdw.c | 5 +----
 sound/soc/codecs/rt1316-sdw.h | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt1316-sdw.c b/sound/soc/codecs/rt1316-sdw.c
index 2ee5e763e345..601b76320124 100644
--- a/sound/soc/codecs/rt1316-sdw.c
+++ b/sound/soc/codecs/rt1316-sdw.c
@@ -323,9 +323,6 @@ static int rt1316_update_status(struct sdw_slave *slave,
 {
 	struct  rt1316_sdw_priv *rt1316 = dev_get_drvdata(&slave->dev);
 
-	/* Update the status */
-	rt1316->status = status;
-
 	if (status == SDW_SLAVE_UNATTACHED)
 		rt1316->hw_init = false;
 
@@ -333,7 +330,7 @@ static int rt1316_update_status(struct sdw_slave *slave,
 	 * Perform initialization only if slave status is present and
 	 * hw_init flag is false
 	 */
-	if (rt1316->hw_init || rt1316->status != SDW_SLAVE_ATTACHED)
+	if (rt1316->hw_init || status != SDW_SLAVE_ATTACHED)
 		return 0;
 
 	/* perform I/O transfers required for Slave initialization */
diff --git a/sound/soc/codecs/rt1316-sdw.h b/sound/soc/codecs/rt1316-sdw.h
index e37121655bc1..dc1bfe40edd3 100644
--- a/sound/soc/codecs/rt1316-sdw.h
+++ b/sound/soc/codecs/rt1316-sdw.h
@@ -42,7 +42,6 @@ struct rt1316_sdw_priv {
 	struct snd_soc_component *component;
 	struct regmap *regmap;
 	struct sdw_slave *sdw_slave;
-	enum sdw_slave_status status;
 	struct sdw_bus_params params;
 	bool hw_init;
 	bool first_hw_init;
-- 
2.34.1

