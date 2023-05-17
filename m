Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1538A706667
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjEQLP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjEQLOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:14:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D102D4E
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:48 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-965a68abfd4so105666466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684322087; x=1686914087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XA3XbezCgMB9jc3ic4kluul6uNj+0DU/xxzeFgKHBE=;
        b=Q18UZ1h8k0fFvwih1EOsNVJXAjQsdHXNFlqphn0hwbg48vgVEor0zN78LCEayppAZf
         ODLE6k/+kOXM86OJ7nPnn6kgKgT3iAVFA/CrP4Ss+joOCpD2pmqp78mGWJ/8Xf8pSCa+
         uGZKeHASaKnoKcS+giX3EI1tr2Uj6i15udXE9GApmffv9qgpfeoBg4AZKgU0xbwdRFq0
         Cw9uMa+TyjssV2P1Ua1UuJps5Uelyr8p5kM1kTaB8KjBkwyvUlQ7XG0yQUTXHCTLIU3h
         QxQB0lrj058pFXy6HUFeEHjxwqJE5T6EonVtsO7nM/I1lSYV8orCpoVgQtVisN5rQnI8
         JopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684322087; x=1686914087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XA3XbezCgMB9jc3ic4kluul6uNj+0DU/xxzeFgKHBE=;
        b=H3m/SMecfrRRlDg+/DoKSK4/FEaoBfeKW2q1K9ysdYg2XOhg+gQK0cajqSU4A0+t7P
         EwpYIPeML2TqM4vWvAOkxKo37FfS0zfJClDt9Uq5RQKuDHnoD8zA1X01wS44TNd++utn
         D9CPpmTh/CW0itIujJdt+rt0bug5fVSsbdjRQcSy/x2NDVnypsxXArD8VizMmvRUEk3Z
         XgZ+g84tE+PkyFu9/ylquXL+GN26ti6AmxTpQ5xbw9VtaAibCv0U6Qqg7qPKGGyjSeKP
         P0+3maOyvzDXGx4k+hFMT4+PUso4nbRk50UA86uHfio+nA48rj503Faxjc4Eo/7dPleK
         53xQ==
X-Gm-Message-State: AC+VfDy6xOaaN8FIXbCXKHnQdMn82UHsc7OeLg6kuI2hsdUK6nJfS0ZK
        QgGpHWAyxkV2RKqw8AKAircGNw==
X-Google-Smtp-Source: ACHHUZ68BtJy2sMkNQIbg/Wtsj1k/B1TxsFqCJyZxOarUMUtFl7IHdShMhfk+H0m0bLuqGRG3za2DA==
X-Received: by 2002:a17:907:72c7:b0:969:f677:11c8 with SMTP id du7-20020a17090772c700b00969f67711c8mr25495472ejc.45.1684322087476;
        Wed, 17 May 2023 04:14:47 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id ml18-20020a170906cc1200b0094f124a37c4sm12326880ejb.18.2023.05.17.04.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 04:14:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 09/12] ASoC: codecs: rt712-sdca: do not store status in state container
Date:   Wed, 17 May 2023 13:14:13 +0200
Message-Id: <20230517111416.424420-9-krzysztof.kozlowski@linaro.org>
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

