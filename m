Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69045E8B24
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 11:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbiIXJul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 05:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbiIXJud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 05:50:33 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E5AA74C2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 02:50:32 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b21so2182995plz.7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 02:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=cSyB+p+NH9fNrvnp1dRITZWO5DlTrkpIl0IbG2JZ8SE=;
        b=d6hRO9bxJ1ZjSbV/CM8zCrtOYWTHbkteregaj59xAYYqXQsh9Sumnhx2Eu/owrSCmQ
         VhvhC2IvEOUA4AxeEffeaULhAUZLSa2EOqKo7HrET4Th1v3nqpoWz+NugarXWBJVXy8p
         DDUfcfhp3EOUvyjuMuw++7mhiOTty7jfehROCgugYaIvl5E77ZGlgQkYpQzPBijcz14q
         H5xjezgPtvVJ0mdElm4hE9JWHHBNNRVmL9VC8Q2NmekeeYZOY54K4X+LEf+DgRSk54hm
         bCzm2RowfBUXsjFZqRE2mRuaQRDiGqdVDLhdkw0tBevmdaQysQJzxsGHD4vlkU7Pk3wK
         CaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=cSyB+p+NH9fNrvnp1dRITZWO5DlTrkpIl0IbG2JZ8SE=;
        b=OcdoQSH27Ku64TObYgqMX69/HMk4jIjay1TQwGSA3rFdisMB83OpDqMXI/0Jb4Utp5
         Jh8+XkDa6VQEpu1MP41LxsyGH6x6ZlYpJ3Gp1ZC9aLvUALxBvBxrg+CBqOC08/MFIGOx
         eo3NDLYea5WGpAR2GQcyKAcIb9r6v/8j2JYIh7XN4VlqKtNEXGhc0mAN26bq/G1NImjd
         8OnBezUzCoLu0qw3YBRL0Tep0S8RsUBTidpoPLSYT5rz5wHGFb3rHGVfHJQeYeFHlAlC
         79Mt486KCsJ6Tu1F2kijnT4e/Xih4Q/5xl8Rj19BLQZEAPTF8MT6mC7S2toNVqjnmCWl
         XjsA==
X-Gm-Message-State: ACrzQf1CA0Mzo7MeBA8yh/Ql0vGE5IxNEThsa2H5r1xgQO0AWpBOSmYD
        qrYdW6JmY1BEd8AG3Rt+PSI=
X-Google-Smtp-Source: AMsMyM5XmEsIHu+v0o9gcoHkJFwQJt+ppfY2jFOO/Jvrjnp0dVY87OczvkyH74GVLtL0QQ/gF9K+rw==
X-Received: by 2002:a17:90b:4b88:b0:202:cbab:980b with SMTP id lr8-20020a17090b4b8800b00202cbab980bmr14284036pjb.153.1664013031799;
        Sat, 24 Sep 2022 02:50:31 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id r11-20020a170902be0b00b00176c0e055f8sm7340223pls.64.2022.09.24.02.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 02:50:31 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Akihiko Odaki <akihiko.odaki@gmail.com>
Subject: [PATCH 1/2] ASoC: amd: acp3x-5682: Remove SND_JACK_LINEOUT
Date:   Sat, 24 Sep 2022 18:50:24 +0900
Message-Id: <20220924095025.7778-1-akihiko.odaki@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RT5682 only has a headset jack.

Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
---
 sound/soc/amd/acp3x-rt5682-max9836.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index 0543dda75b99..0bdd9c26dd22 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -87,7 +87,7 @@ static int acp3x_5682_init(struct snd_soc_pcm_runtime *rtd)
 	rt5682_dai_bclk = clk_get(component->dev, "rt5682-dai-bclk");
 
 	ret = snd_soc_card_jack_new(card, "Headset Jack",
-				SND_JACK_HEADSET | SND_JACK_LINEOUT |
+				SND_JACK_HEADSET |
 				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				SND_JACK_BTN_2 | SND_JACK_BTN_3,
 				&pco_jack);
-- 
2.37.3

