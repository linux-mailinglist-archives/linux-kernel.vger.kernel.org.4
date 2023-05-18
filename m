Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96AE707AD5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjERH2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjERH2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:28:08 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91EA2101
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:28:07 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96a9c44ec4bso177403666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684394886; x=1686986886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAnyusDSWoWYoHl8ExRyZExxONPzTQENQiwitAy+Yow=;
        b=fGc0R2lAtf83BfVI6TvwcDj2bdZJTVJZqt4QHboCsxtKA0NQJfBqJqUxxJDCmQfDql
         VSahfgrHD3mnGLxahg7xk8X1YbExxhcUrrUW5INaUyBgR74rNCJBZqO9i0Sc93LZeXlF
         V8YFqCJzT/ulYdMA/4oqonmaURd3fn96NaHWKQkzNHj3o+Y+Yovm01/Is22QDfnv2Xxv
         +mxn/yVHYCknBOQFhLTivV5OP7w8wUsSB7npWly5VaKDSsoSIIKF+sK2JnVpJfhudJ0f
         55/vf049iXJOBbjzw+10+Xsfwj/gP5WpRR8lOyYqV0q++J2sJGDarPcLSHPr3S3epPbk
         CBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684394886; x=1686986886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAnyusDSWoWYoHl8ExRyZExxONPzTQENQiwitAy+Yow=;
        b=ZM2yuskNlQ0LMx3otV00oLnC+LWrCdUvZFYFUPekEC7FMRy5/CoeD2J/md7mW785BU
         7Ie5dSjrAYifetmbKhAcKL+wFcRl3Lyb3SfezXm0R8xYOAfKMwIFSptagznwbTZvR9HP
         TjeAU+9+hfjCb6pZDwgwqrDtLAAfWQArBMlGehWpZg27khm7AICpUfS7uUIV8j7lPL9z
         LLCuSpti77nUo637X+eS3zk5HMCN9cONfybkNE/+EVDlpraXNVy/0FCUQ+5lpZqM2Mwl
         k16gmu7nd5OSdIoKl3SFzrI8GKFB5EGPPgiPMG4rrdOtUmnblTgazzakFyAiudNjnkCy
         GEIA==
X-Gm-Message-State: AC+VfDximMcYGSwUks9lGAE7O4xk+OJzmRj5y71CfVP3LmnCN9+zHMDH
        h6FUrhvhGUbqoc2yNtjcZ30KXA==
X-Google-Smtp-Source: ACHHUZ7A6J5q3lKRmQdoRE77X3+XkJxZpq6vCwemsAeRMtFaxdKJGUtSy7k0o4X3f46sQBZJ573Usw==
X-Received: by 2002:a17:907:96a1:b0:94f:236b:9e3a with SMTP id hd33-20020a17090796a100b0094f236b9e3amr4762971ejc.3.1684394886350;
        Thu, 18 May 2023 00:28:06 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a2b:c408:5834:f48e])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090669d100b00965aee5be9asm594241ejs.170.2023.05.18.00.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 00:28:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RESEND PATCH 08/12] ASoC: codecs: rt712-sdca-dmic: do not store status in state container
Date:   Thu, 18 May 2023 09:27:49 +0200
Message-Id: <20230518072753.7361-9-krzysztof.kozlowski@linaro.org>
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
 sound/soc/codecs/rt712-sdca-dmic.c | 5 +----
 sound/soc/codecs/rt712-sdca-dmic.h | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt712-sdca-dmic.c b/sound/soc/codecs/rt712-sdca-dmic.c
index 09807b6d6353..847198e6c07e 100644
--- a/sound/soc/codecs/rt712-sdca-dmic.c
+++ b/sound/soc/codecs/rt712-sdca-dmic.c
@@ -803,9 +803,6 @@ static int rt712_sdca_dmic_update_status(struct sdw_slave *slave,
 {
 	struct rt712_sdca_dmic_priv *rt712 = dev_get_drvdata(&slave->dev);
 
-	/* Update the status */
-	rt712->status = status;
-
 	if (status == SDW_SLAVE_UNATTACHED)
 		rt712->hw_init = false;
 
@@ -813,7 +810,7 @@ static int rt712_sdca_dmic_update_status(struct sdw_slave *slave,
 	 * Perform initialization only if slave status is present and
 	 * hw_init flag is false
 	 */
-	if (rt712->hw_init || rt712->status != SDW_SLAVE_ATTACHED)
+	if (rt712->hw_init || status != SDW_SLAVE_ATTACHED)
 		return 0;
 
 	/* perform I/O transfers required for Slave initialization */
diff --git a/sound/soc/codecs/rt712-sdca-dmic.h b/sound/soc/codecs/rt712-sdca-dmic.h
index 74c29677c251..110154e74efe 100644
--- a/sound/soc/codecs/rt712-sdca-dmic.h
+++ b/sound/soc/codecs/rt712-sdca-dmic.h
@@ -16,7 +16,6 @@ struct  rt712_sdca_dmic_priv {
 	struct regmap *mbq_regmap;
 	struct snd_soc_component *component;
 	struct sdw_slave *slave;
-	enum sdw_slave_status status;
 	struct sdw_bus_params params;
 	bool hw_init;
 	bool first_hw_init;
-- 
2.34.1

