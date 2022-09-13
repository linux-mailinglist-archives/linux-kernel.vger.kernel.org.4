Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0D05B7CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 23:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIMVX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 17:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiIMVXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 17:23:24 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1657276758
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 14:23:04 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bt10so22153945lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 14:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=IcnIgmMTd0DbyquQgMbmNfx9FsBF4BI9rV5mzK+kC9s=;
        b=Qik0HCAE4mWGdPhhl3Z4XxHZp2Fsh0qBqor3gfQ7RHj1oA6dc1TrGetu03nykh1gIs
         w+ofH7Fq69SEMBdJ6Ch4oIylIIktjNbYHlz/yjxBxzoJ4pRA+e6nMmQ4GUXJUYgi7fdO
         ZUY3CacnUYhm1obecq1Z183lWv5T5Jw0YJnsIXaiSMe7zocNkqyvQzKrIM4M7d88m2HQ
         IfJM1vEV597EU42uX81zY0iOXdGc5+/VGJG/4bp5uVAFNB1s5HEJw0Q0DB/s4FOosgez
         t5RMwiGNUr3quyrVSVMEYmfX6VB1rt+KlxCbBwURFi/6i0gclZ8xRNSu6UiGPjteEK2U
         6pPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IcnIgmMTd0DbyquQgMbmNfx9FsBF4BI9rV5mzK+kC9s=;
        b=jeSinMVbi4/7n9KBgr7MLWSpjOtVEdcZaHSRj4AgRxn4Wp3Qf2rFEL8TpnJIlMc9uE
         O6geGDnykkb/JH1UUMEIf6APuRqiCEOwxK0LsL/ydSE5LzsNRBqog/O2R6Xbnp/unMfU
         djY6+UVrjC3vNx6+yO0qsfnojuVsDdi89ModfeDzhc3NOMw8TZrWHK+9AT7ek6sKmLLz
         rj7Mqz/VtuFw1OfQYHYTZRiVSZBaRMlfXrJ7DsJpBL0lTBRq+boVtJqP7bAGCmJClZze
         u0N6rlpR4JDhiMbT51E62hl1hrD71rwlyFGhyRDvKkvBB/HieCcU8ZkP/3oHm/xQwMei
         sR/g==
X-Gm-Message-State: ACgBeo1KVVhOKCCGpCkZxMKZs+x4QvI6HgWBq9axhXUYmMYGLuVA8cuM
        +rYlRfZNZfpyZ7YOV/ngSuE=
X-Google-Smtp-Source: AA6agR7lqpwxdnlrp1g555khCJ+9y1Mn78ZuFzcawcY9GJzf7Jw2t+odgShu0RDTZclAju9cgeR/kw==
X-Received: by 2002:a19:e00d:0:b0:492:e5a5:588b with SMTP id x13-20020a19e00d000000b00492e5a5588bmr10452415lfg.243.1663104182075;
        Tue, 13 Sep 2022 14:23:02 -0700 (PDT)
Received: from localhost (95-31-185-216.broadband.corbina.ru. [95.31.185.216])
        by smtp.gmail.com with ESMTPSA id s28-20020a195e1c000000b004979da67114sm1964736lfb.255.2022.09.13.14.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 14:23:01 -0700 (PDT)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Li Chen <lchen@ambarella.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ASoC: sunxi: sun4i-codec: silence misleading error in probe
Date:   Wed, 14 Sep 2022 00:22:54 +0300
Message-Id: <20220913212256.151799-1-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <YyCqC2EypxnoJFk7@sirena.org.uk>
References: <YyCqC2EypxnoJFk7@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case when a codec device is probed before codec analog
controls, snd_soc_register_card() returns -EPROBE_DEFER, resulting in
a misleading error message

    sun4i-codec 1c22c00.codec: Failed to register our card

even if the device is probed successfully later. Use dev_err_probe()
to demote the above error to a debug message.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
changes in v2:
- rebase against current tree
- add Jernej's Acked-by

 sound/soc/sunxi/sun4i-codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 830beb38bf15..3a7075d03c23 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1804,7 +1804,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)

 	ret = snd_soc_register_card(card);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to register our card\n");
+		dev_err_probe(&pdev->dev, ret, "Failed to register our card\n");
 		goto err_assert_reset;
 	}

--
2.37.3
