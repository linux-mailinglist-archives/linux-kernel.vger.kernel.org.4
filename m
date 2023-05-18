Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BF8707AD4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjERH2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjERH2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:28:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34A519BB
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:28:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96b0235c10bso308531166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684394885; x=1686986885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZcG0tmVXg695NcraCbh92aOOhRlMkU+haSPEq2t8Oc=;
        b=kqlVceO0GYGYsCRODhYZpkuyquIG9tGnV+eKMqZNHFtn5bmjaMeQNDmIEqV0/Srk4J
         qJh6FxhAkoM/SFU4Z6Vn3DviBh6qiMGUMcmO0yhXb7904wb7AsJwj9qdDcAI0sj6G7Tk
         rkz1/gHrydVt9UQsmYxqM9fnoPZzxZ2bbw77m2s1NFmbTpwIgq4C1ofrJFtY+6TD0CVY
         53l4rvZ741mvTSAubv2RZuEtlXizhMLlHnuAMUFyN6C1NxdTCB5ILVcXRhpy5B9wvhGL
         QJGpb3ruBj9ZST7urHEaiU24IU0IAFqBZbmUBZNo4+xHihGhTZ8zd8L+tJZ+mML264E7
         aP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684394885; x=1686986885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZcG0tmVXg695NcraCbh92aOOhRlMkU+haSPEq2t8Oc=;
        b=LU7DR6tEz8DfUJuhfrm8i5bhZWra2tYl+mC1o7IMxLdzV6kfQ5mbgXq9hRb2c8x330
         B+GOa9syw1oA1Vt5C5DqNKgcV6Lj4+Fn60O5TBkcd7S4C8EJe3O37CQ+eD6TaO3wUEnB
         tMwZ/emgpCzefR5T99PC4Uc1rZJo4ur1rpDPinGgYCGwwSGDaHUtG3X6vfzNzsOFPiAO
         CbG26cCSk8J9iLbE+fjZbtB/z2UZa4eYVbKZhPN6osFRwoUirUJ+VHaUl5UpmGxzrAG8
         W7i47DPZAaqQ/HSQKtveFT2ac6e1CexhW5EVMEcqysG/Zf2X+juVAgZ0iUsVc6EI+/ZB
         aFSA==
X-Gm-Message-State: AC+VfDzW1MTyFqDIwDnCDbR8bY9uQyO0r2fF/8b6R/yqO0uSTeaZse8m
        Y3BDIE/hN+A0M0RnKc+bBjjUcQ==
X-Google-Smtp-Source: ACHHUZ7pRjddpTaqA+rNwwqWdUkP3ix36JOQEr5MtBnN2+HAoHp+/Fm52aUqp3PwSgtFo4Tme5DiVw==
X-Received: by 2002:a17:907:9405:b0:957:12a6:a00f with SMTP id dk5-20020a170907940500b0095712a6a00fmr38215544ejc.21.1684394885268;
        Thu, 18 May 2023 00:28:05 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a2b:c408:5834:f48e])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090669d100b00965aee5be9asm594241ejs.170.2023.05.18.00.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 00:28:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RESEND PATCH 07/12] ASoC: codecs: rt711: do not store status in state container
Date:   Thu, 18 May 2023 09:27:48 +0200
Message-Id: <20230518072753.7361-8-krzysztof.kozlowski@linaro.org>
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

