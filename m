Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB90E693A67
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 23:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjBLWJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 17:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBLWJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 17:09:29 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A568E3A2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 14:09:28 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h16so10369508wrz.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 14:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kuVlO+i53wZEGLDs4VE0wb6Kv/D3ZFKHSN/pP+HaO34=;
        b=Ov1FWYDjx785BvnGLnfe21+sXW+hRB8YPgRx0lBOAxM3HvLd3PCaCAdmt1SWTo6cw2
         SVXdIHtmwgVuc4oYieM8ZxfqmI4upcHxzXQ53eU21HwjVkhTckj8MQsnfQcfOly8lCZQ
         fCBvGqkFRgBlanIJE+8f4loy2Gi5FYIZ+M4WhLTkQoc+Yi5G2U0mCwaW9ail4ovKPnX2
         ICPhoe+aTxKO3SWH0T8qAUHxkDOvY3fHdsMfNTbPnNcldRdpMfKLGhkLrBcycIQ0Yt2c
         7qW7/Btp0aDG91732Iiurlj6LVR6DVdggMB3bAPp2y8irrWGYwweI5aTcshQUCat+8gg
         aaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kuVlO+i53wZEGLDs4VE0wb6Kv/D3ZFKHSN/pP+HaO34=;
        b=svb0UxTAnSpMtHLHcEEmyW+YixNN92aqQ2sCMnJF+a771wG2vgsuSnsgufWCEvIF/D
         uEBdILaf2SYzq+wnB9RPKXnZqvAGpJQvfiEocR813X8fK7YlyztJAXRySe475uF86tD/
         XsKiJ+UKmmCgznTp3NtZf1w1aM7K6nPkNwatpxl0rbzuvAY22P8TKHtazL6ACF7b9sWY
         QcfdJGZK4gAHb3WWRrmk1bHlzGcZhnneGZ5dXRmq3IkM5JW6KyGpa1gM1KVH5aNrzAFG
         E5NcEhxyMIQZxXyU4axc6+MIcnS9r8nSjTc3HS3T+qYKsEBtRBLQsd2HIDlp6Ws3tLRJ
         AXsw==
X-Gm-Message-State: AO0yUKXdEGJsV9XiOlZ7qTQLWgdGRyBvV/B+3eyApIPfTklAuV41FFzZ
        lqcVtp9C8z3q97YrLSeBk0pCQRX02Q4tyQ==
X-Google-Smtp-Source: AK7set86lVK48ULoHmlJx2sYbsZZGgjWn80e7L94dMOFoAEZynWgx7pm6OhaL7b7E5RaGDx3sUFjrw==
X-Received: by 2002:adf:dcd2:0:b0:2c5:5a68:958 with SMTP id x18-20020adfdcd2000000b002c55a680958mr251528wrm.33.1676239766773;
        Sun, 12 Feb 2023 14:09:26 -0800 (PST)
Received: from localhost ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with UTF8SMTPSA id k2-20020a5d6d42000000b002c4061a687bsm9148656wri.31.2023.02.12.14.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Feb 2023 14:09:26 -0800 (PST)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: ep93xx: ignore 0 Hz sysclk
Date:   Sun, 12 Feb 2023 23:09:23 +0100
Message-Id: <20230212220923.258414-1-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2458adb8f92a
("SoC: simple-card-utils: set 0Hz to sysclk when shutdown")
added a call to snd_soc_dai_set_sysclk() with 0 Hz frequency. Being
propagated further it causes a division by zero in clk-ep93xx driver:

Division by zero in kernel.
CPU: 0 PID: 52 Comm: aplay Tainted: G        W          6.2.0-rc4-... #1
Hardware name: Generic DT based system
 unwind_backtrace from show_stack+0x10/0x18
 show_stack from dump_stack_lvl+0x28/0x34
 dump_stack_lvl from __div0+0x10/0x1c
 __div0 from Ldiv0+0x8/0x1c
 Ldiv0 from ep93xx_mux_determine_rate+0x78/0x1d0
 ep93xx_mux_determine_rate from clk_core_round_rate_nolock+0x48/0xc8
 clk_core_round_rate_nolock from clk_core_set_rate_nolock+0x48/0x160
 clk_core_set_rate_nolock from clk_set_rate+0x30/0x8c
 clk_set_rate from ep93xx_i2s_set_sysclk+0x30/0x6c
 ep93xx_i2s_set_sysclk from snd_soc_dai_set_sysclk+0x3c/0xa4
 snd_soc_dai_set_sysclk from asoc_simple_shutdown+0xb8/0x164
 asoc_simple_shutdown from snd_soc_link_shutdown+0x44/0x54
 snd_soc_link_shutdown from soc_pcm_clean+0x78/0x180
 soc_pcm_clean from soc_pcm_close+0x28/0x40
 soc_pcm_close from snd_pcm_release_substream.part.0+0x3c/0x84
 snd_pcm_release_substream.part.0 from snd_pcm_release+0x40/0x88
 snd_pcm_release from __fput+0x74/0x278

There has been commit f1879d7b98dc ("ASoC: rockchip: ignore 0Hz sysclk"),
but it prepared by far not all drivers.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 sound/soc/cirrus/ep93xx-i2s.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index 982151330c89..f41712df7994 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -359,6 +359,8 @@ static int ep93xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai, int clk_id,
 
 	if (dir == SND_SOC_CLOCK_IN || clk_id != 0)
 		return -EINVAL;
+	if (!freq)
+		return 0;
 
 	return clk_set_rate(info->mclk, freq);
 }
-- 
2.39.1

