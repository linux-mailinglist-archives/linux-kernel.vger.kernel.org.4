Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3F6707ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjERH2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjERH17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:27:59 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E9A19B5
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:27:58 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-510d6e1f1b2so2699409a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684394877; x=1686986877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YaMbqKLIRk9uu0W+O1MKIWCGt/ANzy+JnOLOsBMnmMA=;
        b=d2ZscMnfBdkDvEdeZLpee450DeBX/+FfgbcS+tqZLb/sXioIryO9K9up6dSvxWvzXa
         CZIuhRQRaFzOHa7wkBZsM7i9QQigkDK4h5I1aHN/v0syOsFlWvnKXE6NSf5Vq9V7hQVY
         EP0yiGHSF7+SdRYP2djSjnZs1tEPKRvdKkKz3jMV/T5gCyeCVXZCpSFG6Xdbt0gzf1nj
         jbgZbZrwXo1/R4omcGB97d1FKqd59tCMFTkxz/Nh/j6NFPY0B7lPM8wRFqfaMfwBpm5L
         oRUjEe9EexnkW1VUwDY/DqhiAUovB3aMKgeOdH7o/SUSyDY2Uaebj0BkPQ64NAuMPESC
         qrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684394877; x=1686986877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YaMbqKLIRk9uu0W+O1MKIWCGt/ANzy+JnOLOsBMnmMA=;
        b=PCHSDfJc99ADBaKoBAAbl2Y0oERjmdKEWkuQvm8JK4K8zJX6fVIv4oakskCY0KQIq+
         5PbzRHV4KdjMvHbAW9mKfg63BalOkdUZiOWNQDjXZHFNvSCnsRbI1NIZ7TYTZSrHr4lR
         DeR6x0imeBIDBd8okSpabLyJ4OJgWKcE/CYrdYLeMHcdJbdNDQZ8wz1WGRzcAEsdE4CQ
         a1wMpi6eFepx5hqxUdMDG8urx1FQzXBJEdlOt7jHaiuanV90Zj6Z8yOH954GnGMmFmsd
         2xQ3xIWRehrDIo9J952mlvis2FZH+Pju6eSdZBEVQWAmr3eb/XAhGSHVgIjRSx0NdnDz
         SCLw==
X-Gm-Message-State: AC+VfDyNkqvXdVJJudBzv3PwxkUG1aubcrwCYwGW2U1QgHvjLgGkj/Li
        qMjTXWjbw89vnkowLU2Ntf4wmcnL1scwTxFYbkbYsw==
X-Google-Smtp-Source: ACHHUZ5SE+z7zBbyAA7sZJdfWN2AeIZzPJouJZzS41SDb9nbTXRDYA40EWH6G3vpDYL09eoqmSlZRA==
X-Received: by 2002:a17:907:3f25:b0:969:edf8:f73b with SMTP id hq37-20020a1709073f2500b00969edf8f73bmr32752432ejc.60.1684394876834;
        Thu, 18 May 2023 00:27:56 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a2b:c408:5834:f48e])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090669d100b00965aee5be9asm594241ejs.170.2023.05.18.00.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 00:27:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH 00/12] ASoC: codecs: do not store status in state containe
Date:   Thu, 18 May 2023 09:27:41 +0200
Message-Id: <20230518072753.7361-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Hi,

Resend due to missing cover letter, so adding per-series tags was
not possible.

Added Rb tag.

Best regards,
Krzysztof

Krzysztof Kozlowski (12):
  ASoC: codecs: rt1308: do not store status in state container
  ASoC: codecs: rt1316: do not store status in state container
  ASoC: codecs: rt1318: do not store status in state container
  ASoC: codecs: rt5682: do not store status in state container
  ASoC: codecs: rt700: do not store status in state container
  ASoC: codecs: rt711-sdca: do not store status in state container
  ASoC: codecs: rt711: do not store status in state container
  ASoC: codecs: rt712-sdca-dmic: do not store status in state container
  ASoC: codecs: rt712-sdca: do not store status in state container
  ASoC: codecs: rt715-sdca: do not store status in state container
  ASoC: codecs: rt715: do not store status in state container
  ASoC: codecs: rt722-sdca: do not store status in state container

 sound/soc/codecs/rt1308-sdw.c      | 5 +----
 sound/soc/codecs/rt1308-sdw.h      | 1 -
 sound/soc/codecs/rt1316-sdw.c      | 5 +----
 sound/soc/codecs/rt1316-sdw.h      | 1 -
 sound/soc/codecs/rt1318-sdw.c      | 5 +----
 sound/soc/codecs/rt1318-sdw.h      | 1 -
 sound/soc/codecs/rt5682-sdw.c      | 5 +----
 sound/soc/codecs/rt5682.h          | 1 -
 sound/soc/codecs/rt700-sdw.c       | 5 +----
 sound/soc/codecs/rt700.h           | 1 -
 sound/soc/codecs/rt711-sdca-sdw.c  | 5 +----
 sound/soc/codecs/rt711-sdca.h      | 1 -
 sound/soc/codecs/rt711-sdw.c       | 5 +----
 sound/soc/codecs/rt711.h           | 1 -
 sound/soc/codecs/rt712-sdca-dmic.c | 5 +----
 sound/soc/codecs/rt712-sdca-dmic.h | 1 -
 sound/soc/codecs/rt712-sdca-sdw.c  | 5 +----
 sound/soc/codecs/rt712-sdca.h      | 1 -
 sound/soc/codecs/rt715-sdca-sdw.c  | 5 +----
 sound/soc/codecs/rt715-sdca.h      | 1 -
 sound/soc/codecs/rt715-sdw.c       | 4 +---
 sound/soc/codecs/rt715.h           | 1 -
 sound/soc/codecs/rt722-sdca-sdw.c  | 5 +----
 sound/soc/codecs/rt722-sdca.h      | 1 -
 24 files changed, 12 insertions(+), 59 deletions(-)

-- 
2.34.1

