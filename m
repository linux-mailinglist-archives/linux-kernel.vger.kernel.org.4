Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4053B707AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjERH2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjERH2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:28:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA4F2686
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:28:09 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-510b6a249a8so2980969a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684394887; x=1686986887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qojvzkxpai9FaVqu5a3rsXDeVwEMlNrj9bbWfn2RUs4=;
        b=ekpuCluPIWtdcF+DlLdXQuBzWj2T3yqpK1eo5JOW9J+oC2TnU4Cu1/c3Qnl+cfxOMw
         QBDnMXqS5j84+cx64RCXvTyFPrrcphblozW0EG3ZzG2JV1guL8LrjNwOtLCGCRsvPZ8S
         OuE6Binws0/Z/JuQXY+w2aI57UE1CxV3oiLNa2MzgQJ+3uHfPm+vH/1bl6BXXzLkK2B4
         dNDXzwm6LPn9xO7B/LrYtwYKooOXnDsoQ89EboL03MI+GbDcdrNKo5x8aoUVPY0YphO2
         n+f3oAlZzVl0enXvl953TFLLYHfNmW0zKDx2Zi2aAEcCyaSPpaWJIiuvpWghqsooIe6l
         Ppxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684394887; x=1686986887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qojvzkxpai9FaVqu5a3rsXDeVwEMlNrj9bbWfn2RUs4=;
        b=hyNTmDCNfYTMNySdAtkfgXgsq+SHACnaQUcEzzBNLDuvR28315+Du058vyQ1vq+ULn
         hGp8n2t9Od8YGC6ym8nygn3rgfgzCkMWuuaqKVVrZ9jisCisgbp/zrQT/ZXq9id/XWaE
         S/NWCimkx573yg/uEW4rUeP5F6ck4k8uTSxazDHUuXYJ78w2DLjMOZ2YNxIS6jobXiCT
         nkXxc1IuzVGumu+CtdB89pk4Z4iQvZZdoC3/mTdjsq0O0rdYe+l4BqsCIDDLSWGVVT/i
         zTRd9JLdTPqQCKBc3X/h2MVqGVAJ0qIdsIE0C36y68myTM4nlcbPQcBsJ11ab6f/aT+e
         qYkg==
X-Gm-Message-State: AC+VfDz4p0mnMgruYzYPJgjaaEgHOGyzXtplVs5cU7d5+FFLf/+ziDgI
        YXBiUQij3MfKZ/JEYEksPEpW4A==
X-Google-Smtp-Source: ACHHUZ7SDfkB5r68xXymWzpYbDvg/6rwAIMLjQpgKOm1OMdIsaHCpDhTO5xEPRYHd2ZoKGeNEKYr8g==
X-Received: by 2002:a17:907:31cb:b0:95e:ce3b:a471 with SMTP id xf11-20020a17090731cb00b0095ece3ba471mr42167358ejb.55.1684394887570;
        Thu, 18 May 2023 00:28:07 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a2b:c408:5834:f48e])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090669d100b00965aee5be9asm594241ejs.170.2023.05.18.00.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 00:28:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RESEND PATCH 09/12] ASoC: codecs: rt712-sdca: do not store status in state container
Date:   Thu, 18 May 2023 09:27:50 +0200
Message-Id: <20230518072753.7361-10-krzysztof.kozlowski@linaro.org>
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
 sound/soc/codecs/rt712-sdca-sdw.c | 5 +----
 sound/soc/codecs/rt712-sdca.h     | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt712-sdca-sdw.c b/sound/soc/codecs/rt712-sdca-sdw.c
index 3f319459dfec..8f65516e7562 100644
--- a/sound/soc/codecs/rt712-sdca-sdw.c
+++ b/sound/soc/codecs/rt712-sdca-sdw.c
@@ -140,9 +140,6 @@ static int rt712_sdca_update_status(struct sdw_slave *slave,
 {
 	struct rt712_sdca_priv *rt712 = dev_get_drvdata(&slave->dev);
 
-	/* Update the status */
-	rt712->status = status;
-
 	if (status == SDW_SLAVE_UNATTACHED)
 		rt712->hw_init = false;
 
@@ -165,7 +162,7 @@ static int rt712_sdca_update_status(struct sdw_slave *slave,
 	 * Perform initialization only if slave status is present and
 	 * hw_init flag is false
 	 */
-	if (rt712->hw_init || rt712->status != SDW_SLAVE_ATTACHED)
+	if (rt712->hw_init || status != SDW_SLAVE_ATTACHED)
 		return 0;
 
 	/* perform I/O transfers required for Slave initialization */
diff --git a/sound/soc/codecs/rt712-sdca.h b/sound/soc/codecs/rt712-sdca.h
index c6a94a23f46e..ff79e03118ce 100644
--- a/sound/soc/codecs/rt712-sdca.h
+++ b/sound/soc/codecs/rt712-sdca.h
@@ -20,7 +20,6 @@ struct  rt712_sdca_priv {
 	struct regmap *mbq_regmap;
 	struct snd_soc_component *component;
 	struct sdw_slave *slave;
-	enum sdw_slave_status status;
 	struct sdw_bus_params params;
 	bool hw_init;
 	bool first_hw_init;
-- 
2.34.1

