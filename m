Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492CB706663
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjEQLPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjEQLOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:14:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9785940C1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-96b4ed40d97so96283066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684322085; x=1686914085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orOtZCSMdy0LOUQiF3GDNtFNR/PCT+bEnkKVYg6k6GY=;
        b=hIdANJjDwebuLejzh1gdqt+267DcEVSuEXFFfZttIJwmQVKZZhGt5sC81zWStiXcRj
         VkXD93TUaA6p5/xnMn+t1KsA2k9XWbfzDLmphIbNyQCMePhqmJwZ0QIctyh5cwm8q4wy
         jpGo6s5Hd6p6eKRAO0ltyCLM8otD/mS7+HaUb4FFNTthYyMbM30oBOfYkgfq+MXolgz5
         OrfMgBCLybw5ytMdkTg+It68qT+icGoIHEi0KynM6uNo5zrHoHcKNS540jcbGu4+XgBj
         KS6QniH0sv0gGfn4aAtNBHezfiPEI5b6LpAL/hI7ksQoRcMW9Z2nBnGJkQPfI8i5ovSr
         ydYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684322085; x=1686914085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orOtZCSMdy0LOUQiF3GDNtFNR/PCT+bEnkKVYg6k6GY=;
        b=WqHVI0RueI8VsOcDwxKZEypvmCCchHmrO8QfRjZuTROx4XniXtWcizrFf6u0yd+oKI
         xvoS8wmvGCLVdBJuQl/px2QeSsRbXiEXOKaF8Et0Rf8ni2qASrlgjMwVz6txM9yC2x96
         /oZTmWKYEFSATctQTk+oc6cWy5KKipy5yRoYC7ZRg4WsjS3eFav4qkiEFef/F/V/emwS
         z5cdjDP56Q6Uj3lCPnR/Bs75rcPzkkGZ4FK1T09bF+818i3YP8nDOrqKMNih4KO0M3+1
         mD0td0wlV4yFKTwzIEQcQX6h/gcuuk4ko0FdVTGin0Bq6GSAQvv2kw97fvdEW3f72bEN
         Rr2Q==
X-Gm-Message-State: AC+VfDzVxvU2N4Ko6vf/ZnNYNWg72a6273h2etpwZ8zoIEXiLIHMzLWy
        AIPviKAM9GJ+YT7+s7ZSpXv8Ag==
X-Google-Smtp-Source: ACHHUZ59InEiEFagluPob/jRCVm/OnOiFjG4/CRAJ+B+r/pybagONxCqHhmhRqrqagLoPDquLlcEYA==
X-Received: by 2002:a17:907:7e86:b0:969:b2e2:4f3b with SMTP id qb6-20020a1709077e8600b00969b2e24f3bmr31186355ejc.51.1684322085181;
        Wed, 17 May 2023 04:14:45 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id ml18-20020a170906cc1200b0094f124a37c4sm12326880ejb.18.2023.05.17.04.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 04:14:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 07/12] ASoC: codecs: rt711: do not store status in state container
Date:   Wed, 17 May 2023 13:14:11 +0200
Message-Id: <20230517111416.424420-7-krzysztof.kozlowski@linaro.org>
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
 sound/soc/codecs/rt711-sdw.c | 5 +----
 sound/soc/codecs/rt711.h     | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt711-sdw.c b/sound/soc/codecs/rt711-sdw.c
index 4fe68bcf2a7c..b8ed3c6236d8 100644
--- a/sound/soc/codecs/rt711-sdw.c
+++ b/sound/soc/codecs/rt711-sdw.c
@@ -319,9 +319,6 @@ static int rt711_update_status(struct sdw_slave *slave,
 {
 	struct rt711_priv *rt711 = dev_get_drvdata(&slave->dev);
 
-	/* Update the status */
-	rt711->status = status;
-
 	if (status == SDW_SLAVE_UNATTACHED)
 		rt711->hw_init = false;
 
@@ -329,7 +326,7 @@ static int rt711_update_status(struct sdw_slave *slave,
 	 * Perform initialization only if slave status is present and
 	 * hw_init flag is false
 	 */
-	if (rt711->hw_init || rt711->status != SDW_SLAVE_ATTACHED)
+	if (rt711->hw_init || status != SDW_SLAVE_ATTACHED)
 		return 0;
 
 	/* perform I/O transfers required for Slave initialization */
diff --git a/sound/soc/codecs/rt711.h b/sound/soc/codecs/rt711.h
index b31351f11df9..491e357191f9 100644
--- a/sound/soc/codecs/rt711.h
+++ b/sound/soc/codecs/rt711.h
@@ -15,7 +15,6 @@ struct  rt711_priv {
 	struct regmap *sdw_regmap;
 	struct snd_soc_component *component;
 	struct sdw_slave *slave;
-	enum sdw_slave_status status;
 	struct sdw_bus_params params;
 	bool hw_init;
 	bool first_hw_init;
-- 
2.34.1

