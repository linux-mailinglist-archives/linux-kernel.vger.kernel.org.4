Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80C4707ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjERH27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjERH2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:28:35 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709BB2D70
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:28:12 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-965fc25f009so300513566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684394891; x=1686986891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIwJNTzxhNUSrbT0TXBGuXZECsHlorjZtBHAk3OzfKw=;
        b=oM+RXRYewHu4bLBr2ElIoV0dqPvtWyZM0qOHY/GFfmSdVrPTj24HiN13Hh7N8TAeni
         J5WYZxY71PrQQyURr3ZcPaKy25fwgtH9gFwJn5xRfVV+YN7j8Yg1IIVxxp/wI9aXf5Y8
         n2GPRztj+HYrJ4tRS4qSrFvEZytlLMWMzvtkAIU4+gnpOMjkrAzXJUiw8D3OFvqdXkOp
         Y9C4Mjs64P8/DSnrbXzRNoMWa7x8uyymebiZANZSmRclRig3M6WKiWX9Mfv3q1gq3q16
         ZpCP+MgXPKH2V0022YfM/aj/MxtPC8Jv9fMliQBdeYJP4QhbMx7ox+z3jhylUoAfhJZn
         fbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684394891; x=1686986891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIwJNTzxhNUSrbT0TXBGuXZECsHlorjZtBHAk3OzfKw=;
        b=NR767v+Tc0kJp6bpDyb0TAfKvNvZLUBxtjdnzJRzCbVHGtNOxMY6cw6t0EiZjSlNwP
         28fjWPvySwyxnXyVIqeB4koeMI08by/Bx49ppXXzaoxI4XX5lEpUxgi0POJtr3fDnDqL
         3utEPG4iITiSahTGjtOIeK6C3x7mmdh3fcaorqhkjdVjhB/FCzlJ7/VQAE/2UkbufBtu
         bxwDFhD2Y9fLdp41BEHKeBeyiXyy7uR9Bv0hL5W5C5OYuRI3YDWJKGHtDWbCJOlepM0x
         FfMv49lhgOAGME9FhuYRYsKwxRSMIhhOAOqAzxS2nKSaNlug0sDi5kmxGNrJIkqU/yjG
         Qkew==
X-Gm-Message-State: AC+VfDxArXNZFIrdXOAg9rJWhxpehYOrjUBBbaIyMmadZWH0z0tEn7H3
        p3QtT/Rwc92LZjNB1JQ9C899Jw==
X-Google-Smtp-Source: ACHHUZ5OyqRsRWc7zyUbnXlZEEMWIsRGekh6wkroEH6t7iYe7O1fvVzQsYjovW9n9PSXNsvSM3Ws0A==
X-Received: by 2002:a17:906:58d5:b0:969:9fd0:7cee with SMTP id e21-20020a17090658d500b009699fd07ceemr33147092ejs.10.1684394890980;
        Thu, 18 May 2023 00:28:10 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a2b:c408:5834:f48e])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090669d100b00965aee5be9asm594241ejs.170.2023.05.18.00.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 00:28:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RESEND PATCH 12/12] ASoC: codecs: rt722-sdca: do not store status in state container
Date:   Thu, 18 May 2023 09:27:53 +0200
Message-Id: <20230518072753.7361-13-krzysztof.kozlowski@linaro.org>
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
 sound/soc/codecs/rt722-sdca-sdw.c | 5 +----
 sound/soc/codecs/rt722-sdca.h     | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt722-sdca-sdw.c b/sound/soc/codecs/rt722-sdca-sdw.c
index 0a791a14215e..bfb2dac6bfee 100644
--- a/sound/soc/codecs/rt722-sdca-sdw.c
+++ b/sound/soc/codecs/rt722-sdca-sdw.c
@@ -163,9 +163,6 @@ static int rt722_sdca_update_status(struct sdw_slave *slave,
 {
 	struct rt722_sdca_priv *rt722 = dev_get_drvdata(&slave->dev);
 
-	/* Update the status */
-	rt722->status = status;
-
 	if (status == SDW_SLAVE_UNATTACHED)
 		rt722->hw_init = false;
 
@@ -188,7 +185,7 @@ static int rt722_sdca_update_status(struct sdw_slave *slave,
 	 * Perform initialization only if slave status is present and
 	 * hw_init flag is false
 	 */
-	if (rt722->hw_init || rt722->status != SDW_SLAVE_ATTACHED)
+	if (rt722->hw_init || status != SDW_SLAVE_ATTACHED)
 		return 0;
 
 	/* perform I/O transfers required for Slave initialization */
diff --git a/sound/soc/codecs/rt722-sdca.h b/sound/soc/codecs/rt722-sdca.h
index 5bc6184d09aa..44af8901352e 100644
--- a/sound/soc/codecs/rt722-sdca.h
+++ b/sound/soc/codecs/rt722-sdca.h
@@ -20,7 +20,6 @@ struct  rt722_sdca_priv {
 	struct regmap *mbq_regmap;
 	struct snd_soc_component *component;
 	struct sdw_slave *slave;
-	enum sdw_slave_status status;
 	struct sdw_bus_params params;
 	bool hw_init;
 	bool first_hw_init;
-- 
2.34.1

