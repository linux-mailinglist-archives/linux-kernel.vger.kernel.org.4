Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310EB7266E2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjFGRNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjFGRNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:13:34 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1271FDA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:13:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-977c72b116fso739994066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 10:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686158010; x=1688750010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hDf6g1xuCxpSvIAHAS6C9lv2xYoCaofaCj9iSWocDbE=;
        b=mesdMvC4th0od7bqihmQfQzjPowmtJzZB4XhjAl3kQV8k4C8mxHSZ6hfvHRX1uyLUo
         IKHdCJS+j7AtHL2PUGrVtNyKJ23ZGhrNllKyGSboVFCMUaHemjqm3O+CkLRvbmRJBIrS
         jX7iPRWMHZO4HYOpBF46kyL9nBWzA6oKcdZ+iCOss/270kQkrsZd9oCy1nNk385vydkg
         owA3lHuLhe8wt4qOUxHJbTLQV8aSPXvjY/Cdf7J2UF9QAyYJt2gBdds6eE0iPvaZYoBj
         16qEP9Yd2M6uriH9Pq8XBMtPk9xkAyVjwAmCjZfIA8mgE9caQbAyvkc2RZp2tsZD88h+
         lkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686158010; x=1688750010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDf6g1xuCxpSvIAHAS6C9lv2xYoCaofaCj9iSWocDbE=;
        b=cOxlyEMUYHv6acTphwimkaSRTwTQ25QfTk6zMKr0jSDNlvxsdg/WaAgDyAPkP5MzmK
         NQDWYiguYSVW3WNy0qqP1ESICiT45RAoHzeigs0KjUlrAJ5JBiamNxDaITSOfgdxdXbO
         bcNt9nBRcIX7vw8CQBaZmPr48o7Ju8r0l4xYAmbJH4MInES+7WgOn1d5r8i3/fUQUmcs
         o6+nMXRS8RIKHobcJ+ncAW7UNgnjdFNMk47HszWgDmoFTAcyzX/+UjN1Z8nCqfAK+QLX
         NoO39KOlQpsH8VgMkAO8J0o639sv+M5435KXboQEsNtBCPnu212hUNNQkT1pJxYYBp5G
         KwZw==
X-Gm-Message-State: AC+VfDxnun75VjJWaNfjpEwqMJRgil9Jo30/k5eEi7ghR+6miSdNlEgl
        pKI0ohIsSx9W7mT/Vo6BTn7bBA==
X-Google-Smtp-Source: ACHHUZ4eRbnbnRgq6PTEJhKylTurSxl9ZJzOQ30XkHFDVitSR12i1HSqPBn+BHiuZbDtPx66/cdl2g==
X-Received: by 2002:a17:907:7282:b0:973:ca9c:3e2b with SMTP id dt2-20020a170907728200b00973ca9c3e2bmr7177793ejc.25.1686158009810;
        Wed, 07 Jun 2023 10:13:29 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id k9-20020a170906578900b00978868cb24csm838861ejq.144.2023.06.07.10.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 10:13:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: codecs: wsa883x: use existing define instead of raw value
Date:   Wed,  7 Jun 2023 19:13:26 +0200
Message-Id: <20230607171326.179527-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Use existing define for WSA883X_GLOBAL_PA_ENABLE instead of hard-coded
value, just like in other places in this driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wsa883x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index c609cb63dae6..5c1cfceb2956 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -1334,7 +1334,8 @@ static int wsa883x_digital_mute(struct snd_soc_dai *dai, int mute, int stream)
 					      WSA883X_DRE_GAIN_EN_MASK,
 					      WSA883X_DRE_GAIN_FROM_CSR);
 		snd_soc_component_write_field(component, WSA883X_PA_FSM_CTL,
-					      WSA883X_GLOBAL_PA_EN_MASK, 1);
+					      WSA883X_GLOBAL_PA_EN_MASK,
+					      WSA883X_GLOBAL_PA_ENABLE);
 
 	}
 
-- 
2.34.1

