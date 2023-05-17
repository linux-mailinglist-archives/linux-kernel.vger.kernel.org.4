Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D66706661
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjEQLPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjEQLOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:14:48 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DDA61A4
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:44 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9659e9bbff5so105181766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684322084; x=1686914084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsBtC5TfGJN3p6qkzFAO4W1v8Rx/+dqGizHb8O0Kemg=;
        b=qT9Hm+viZyjnW7qF9Tzwr3hYeysA5pkm7FIUW8J6gLL8bgZy2Q3yNgT634YhZqiWXt
         k2MqRXHxAe+PmDwkPQUqE8iTWCPWWgWZ7Wrp9BSGk5BYbqOcg/HArsgi2gSe+eokW/uP
         iQwAHoCP7iIxVJnUnRHW5XQJz542/vhvdUCwqUSrfLrEQHWEZ5BSbEvKAJPBMGE/8A6f
         Vc6MBE0s/VAxY6GIBGVXRP+JaPbiASGjXUx4NRGq4FVtjNwFwDg7H+eaoVlSN/ht3ZUJ
         qubKLdGAGqj8EOn9uTpWMtNq0g5Hruw9Bog2kjlwZ3GWxs/IvHpul99eqw1y/f+zgmr8
         Dqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684322084; x=1686914084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsBtC5TfGJN3p6qkzFAO4W1v8Rx/+dqGizHb8O0Kemg=;
        b=GzOR8qelPNWGEPSoSUHqkrUcHO4TxTFBXZTHPnPxqVQGSk5GC2MLBEHX2SIlMnPTpk
         2WdjiEhF8HWSQ81ik+9ayC7nUDIy+Fybz5dprCxOYQuapwpp53bb0xDqbrYyuvy04J+s
         OxqK/ZNKxH4YxSwaehqbJt3WYxVMzxOu0PyATLn8rC5KYkg72QwTdDxJXocVUINRuYQM
         D8ozC69WH4p5iItLiXOUIfQDWe3l5/egqWjfCvJ5tub3RxTdaCMd0bpkSCm/LzlT2p+w
         hbr4TDr3VH8gi1mOIN9VG/L1HItaaEv5cdRzrdTWADHdDxF43cZyBD1G7K65/9Bd3i0O
         W5GA==
X-Gm-Message-State: AC+VfDxFxhc/wFV/+kSmFT2UlkLRXM7W5fKwrafDNmNo9oMAEvB80LKn
        T+LkT5bLscaqT1IJW4F4zyulnw==
X-Google-Smtp-Source: ACHHUZ7mlo6nRWUJn035zVTJntmQFAoQhlG3G9/1Y3edyg3inGAnP3I4evAsUjOZr5Yt9vQpd/Zwjg==
X-Received: by 2002:a17:907:5c7:b0:961:be96:b0e6 with SMTP id wg7-20020a17090705c700b00961be96b0e6mr34403065ejb.68.1684322084257;
        Wed, 17 May 2023 04:14:44 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id ml18-20020a170906cc1200b0094f124a37c4sm12326880ejb.18.2023.05.17.04.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 04:14:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 06/12] ASoC: codecs: rt711-sdca: do not store status in state container
Date:   Wed, 17 May 2023 13:14:10 +0200
Message-Id: <20230517111416.424420-6-krzysztof.kozlowski@linaro.org>
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
 sound/soc/codecs/rt711-sdca-sdw.c | 5 +----
 sound/soc/codecs/rt711-sdca.h     | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt711-sdca-sdw.c b/sound/soc/codecs/rt711-sdca-sdw.c
index 51f3335343e0..2c5eb28259dc 100644
--- a/sound/soc/codecs/rt711-sdca-sdw.c
+++ b/sound/soc/codecs/rt711-sdca-sdw.c
@@ -143,9 +143,6 @@ static int rt711_sdca_update_status(struct sdw_slave *slave,
 {
 	struct rt711_sdca_priv *rt711 = dev_get_drvdata(&slave->dev);
 
-	/* Update the status */
-	rt711->status = status;
-
 	if (status == SDW_SLAVE_UNATTACHED)
 		rt711->hw_init = false;
 
@@ -168,7 +165,7 @@ static int rt711_sdca_update_status(struct sdw_slave *slave,
 	 * Perform initialization only if slave status is present and
 	 * hw_init flag is false
 	 */
-	if (rt711->hw_init || rt711->status != SDW_SLAVE_ATTACHED)
+	if (rt711->hw_init || status != SDW_SLAVE_ATTACHED)
 		return 0;
 
 	/* perform I/O transfers required for Slave initialization */
diff --git a/sound/soc/codecs/rt711-sdca.h b/sound/soc/codecs/rt711-sdca.h
index 22076f268577..11d421e8ab2b 100644
--- a/sound/soc/codecs/rt711-sdca.h
+++ b/sound/soc/codecs/rt711-sdca.h
@@ -19,7 +19,6 @@ struct  rt711_sdca_priv {
 	struct regmap *regmap, *mbq_regmap;
 	struct snd_soc_component *component;
 	struct sdw_slave *slave;
-	enum sdw_slave_status status;
 	struct sdw_bus_params params;
 	bool hw_init;
 	bool first_hw_init;
-- 
2.34.1

