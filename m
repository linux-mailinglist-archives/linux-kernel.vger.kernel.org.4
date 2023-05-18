Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADD0707ACF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjERH2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjERH2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:28:02 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB842133
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:28:00 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-94a342f7c4cso318844766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684394879; x=1686986879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LC/zIc8X+SN3v3HkNtTVdt1UL4xSDxpH+q1cQ2DHdvs=;
        b=WP+J1VwSUrjRPf0WUHV5s4C8tvmBJHGuOzF1k5aWgcB+Mw3xKYuBhbCXu364BdOCwP
         2VDyyUqIYQB2hGqLRmtrHJqOENQpwdUYXOiEui9j2ebQGU1cL5VjZ0FTb1/kbr24Q6Np
         0kAN0HTBxFawRRBs36ejvFCGYOCWC14xl/3tSjX/YRbONRJgr4+2Aa3/W7ELX3uVPddk
         FACbZtF5IlbdDmQldf6ObNjB9PAe5niHMcjTthzN4iZCtNhmLie3vFqFlArzytN5XBp9
         vM+hvr9BLbJWMNy5YnSAybjVHoq8ftywfjwUrE7QTdpVYMawZcEQgVKEWoYor4GE53ci
         wyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684394879; x=1686986879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LC/zIc8X+SN3v3HkNtTVdt1UL4xSDxpH+q1cQ2DHdvs=;
        b=HwbfgLY5REV8ldYXzk827lwIljMfNmqBEaG4PdXRyrVmk7Hf7ZOp4s8SXdu4osIIMt
         59CN9msDaJZrCRZXfey9Pm9ky1byNTMi8+DKUCMaSptFWeHayns1fzFAkj9VouPqPwrZ
         y5py9gZUXnrlSTqZ0uvSBSlUUZ2F730KGFXzkKJOPB1mA6H5KaEfVAsdND10HjWheKwt
         7VzuCGLlslOSxAKWHLFHv6c49YFlgfqeNZC44MiyE6jWnSPhwvlJs4T5j+VyeqQ06XIB
         Y/qC1JANr8x7Wc7KQEB7fO8RnPQzBgLz+yMCL6yIGUphV1jJO//Lnc4D+ZDWUX6DrWW5
         L+sA==
X-Gm-Message-State: AC+VfDxcbb6AF97ikvsWhEYMSTqXVsQMmP6HO4S1LEeoAJQQUftz8oVU
        2Z7PfnIMutuYCXUldsf4g9Wpar2K1Dzpc+SQaxkBuA==
X-Google-Smtp-Source: ACHHUZ6bymIhEgJDfUzkeFREt4EtG+UMkBzeSiCgNymRaghAk/dTfP/cemBVaWPSj4Cv08e99FsHpQ==
X-Received: by 2002:a17:906:d54b:b0:94f:3980:bf91 with SMTP id cr11-20020a170906d54b00b0094f3980bf91mr46254817ejc.19.1684394879305;
        Thu, 18 May 2023 00:27:59 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a2b:c408:5834:f48e])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090669d100b00965aee5be9asm594241ejs.170.2023.05.18.00.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 00:27:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RESEND PATCH 02/12] ASoC: codecs: rt1316: do not store status in state container
Date:   Thu, 18 May 2023 09:27:43 +0200
Message-Id: <20230518072753.7361-3-krzysztof.kozlowski@linaro.org>
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

