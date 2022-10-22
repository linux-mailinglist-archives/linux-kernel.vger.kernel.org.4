Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B11C608F28
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 21:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJVTN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 15:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiJVTNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 15:13:34 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BB3176B8A;
        Sat, 22 Oct 2022 12:13:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v1so9653525wrt.11;
        Sat, 22 Oct 2022 12:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvKXzpxFzZWAwh4ulfZ9nH6QQVrhwgz8YLgYLKE7oQk=;
        b=Mk32tiD+7lGM2PB2KBnwrwRs/5pG1IM2VWwXn+K1X6q+vW0rzntqHq9asZQRoo4Lgu
         xpPq180y9ajoqHiSIw0RZuV1Jb7inx+Uxtaj42O5pNtCga+OsbxRmM7GF3ID7PVGg+fH
         RZ/wecg6JaLqAIxZc8jwWP3koFUs6X4AeeDZmuR9egW6QaxA3cJdiToK5kH1bFQ4wfhq
         bKpkxSF4VlzukSPq3CNgo1Bq0AqRR13XagfzPvLe+wC/NkzTCymBnuC8OYehqcw2EksS
         M0xfBrJnVjTGfZ09pIuL/B7T42kEZThfIBaoYfGtH6kc8YWsDWvMyoTks+h36yORRDnP
         iBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvKXzpxFzZWAwh4ulfZ9nH6QQVrhwgz8YLgYLKE7oQk=;
        b=4qFCYsZXZWWzppThtAWVpWIVxPOMRO9Dq1Uc87ahhOWUTrwoSc8NQZ3cRnn6rUTVdc
         R7n74mNjQFtoE9JrTmrOXWptetN7CJ+AG1GatYaGViGbjMp/n1vwaNUruXKjXKoFejDg
         vIvwOeIbht0HWkpBmET0IU9RVayCW2jOZfeuVnPo0viYT2Z09YyUy96KJrM/qEVdXgj9
         d4VbXkYicsUksA9YIDQgTcMZ3PsmXeFhTadOqahUovY2vY0RNxR438K/a72rlxRREKfv
         +JI8VFTaoA0ffZXW/reiOoWcS/8t5kzh/jPt5nXHzOS7OHv2GwNFsuzMHAsw9FrKmGMf
         aoIA==
X-Gm-Message-State: ACrzQf2FDOlR2go0DAqV07bD6sFv63EcxrXnImk7iZI0mbZ2yz7o58w+
        v8Lc7rh3j6cFZqfQvy5+qnE=
X-Google-Smtp-Source: AMsMyM4ZgiMk56yHI2oeiWzNd5O/Bb+8ZyfhfgGtlPvoGmNJ0BN1+6zyBptA05Wp39LxFyKTH4gDQQ==
X-Received: by 2002:a5d:5691:0:b0:22c:db35:7939 with SMTP id f17-20020a5d5691000000b0022cdb357939mr15694848wrv.102.1666466010555;
        Sat, 22 Oct 2022 12:13:30 -0700 (PDT)
Received: from localhost (94.197.1.68.threembb.co.uk. [94.197.1.68])
        by smtp.gmail.com with ESMTPSA id j16-20020adfea50000000b00228d6bc8450sm26311735wrn.108.2022.10.22.12.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 12:13:30 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 7/9] ASoC: jz4740-i2s: Support continuous sample rate
Date:   Sat, 22 Oct 2022 20:13:06 +0100
Message-Id: <20221022191308.82348-8-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221022191308.82348-1-aidanmacdonald.0x0@gmail.com>
References: <20221022191308.82348-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2S controller on JZ47xx SoCs doesn't impose restrictions on
sample rate and the driver doesn't make any assumptions about it,
so the DAI should advertise a continuous sample rate range.

Acked-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index fd35a8a51f60..201368f828ff 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -390,13 +390,13 @@ static struct snd_soc_dai_driver jz4740_i2s_dai = {
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_48000,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
 		.formats = JZ4740_I2S_FMTS,
 	},
 	.capture = {
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_48000,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
 		.formats = JZ4740_I2S_FMTS,
 	},
 	.symmetric_rate = 1,
@@ -426,13 +426,13 @@ static struct snd_soc_dai_driver jz4770_i2s_dai = {
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_48000,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
 		.formats = JZ4740_I2S_FMTS,
 	},
 	.capture = {
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_48000,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
 		.formats = JZ4740_I2S_FMTS,
 	},
 	.ops = &jz4740_i2s_dai_ops,
-- 
2.38.1

