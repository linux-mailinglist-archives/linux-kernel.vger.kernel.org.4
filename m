Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CD2706665
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjEQLPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjEQLOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:14:49 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D683355A6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:46 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-510bcd2d6b8so5691597a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684322086; x=1686914086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAU6nE7Iv32gPNvrQJaHKSe4IIom2DPSRL0YbepC1JY=;
        b=dJ/PmlpbNmfHmuYdjH3uO1ElApNK26oJ6na+aMD1yfJb05UDsLjz0xzUQTE/abm0yF
         zbx6naNOO2gKrAAsT5hyVVuz+j8ikJ/doxEQfVfSDF/ljofMQWyaBDeE9u14oK62/Wg/
         xSIAetdKH2r59SbWqeWex5CKGvgTBS+G52EYglrZnOGuq2IENBj4Zwqrl/aLWic6zaTR
         0NIY3KBh7oR+Z1I6Gxv/gf2kMRHJkoQGBahe4Y8/aVsAb7rBDD9/A+yas/Ild289fXk8
         EfK+Znx5j8oBJa9m6rR/Oo4lqtGuzB5qoV2RwqJcdqyxLiOMlxeuo0sWGQY4pjqC/RCT
         Ro5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684322086; x=1686914086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAU6nE7Iv32gPNvrQJaHKSe4IIom2DPSRL0YbepC1JY=;
        b=DKCmTzZvwgJLOamQRHx5dSibh8YXLhs0fbF192+CgLSpujqscSZmMqy3LKeSRmvMf4
         5a7Bk+8jgJul3CIdlGTpMFN45QuUQOdemTJApNOvWzU2DCPQghTkyDuWootVCqCTbIC1
         iglkpeU0/GaupltGNeLA4ApBDKMf6L5dQx3QLbN5rbzamKPXmG8Na6Gu/+mu7nYLcDG9
         BXjYRvURp8HqALnPtdQfKS3VYA09rkikNjfa5vwiv3UpnWaXBW8SFwjlh8q8vNFLk1wa
         KB036P/1+8nyBXD+jcgBVKdQWsxm6sIIwsL7Qs3KMTSp8zYxsqndQUGo7B5kFEO4zY4D
         hDwg==
X-Gm-Message-State: AC+VfDzcz6P01J4AVqdSNYCDXG7UekOe+2bBH3/8yY6cyrd7BMsh+tAs
        FBxVg09s9VbG+j3PJ6j0pGe08w==
X-Google-Smtp-Source: ACHHUZ62iLS7FU6ngzK688zw4Cj+axv3xqRuHEDoRc8fnW0FTcROJc2cF0ZL0r8I9am/kqhPnH+4GA==
X-Received: by 2002:a17:907:6da0:b0:959:b757:e49 with SMTP id sb32-20020a1709076da000b00959b7570e49mr1997236ejc.1.1684322086159;
        Wed, 17 May 2023 04:14:46 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id ml18-20020a170906cc1200b0094f124a37c4sm12326880ejb.18.2023.05.17.04.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 04:14:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 08/12] ASoC: codecs: rt712-sdca-dmic: do not store status in state container
Date:   Wed, 17 May 2023 13:14:12 +0200
Message-Id: <20230517111416.424420-8-krzysztof.kozlowski@linaro.org>
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

