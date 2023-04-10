Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E63B6DCD8E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 00:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjDJWjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 18:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDJWjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 18:39:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B14C1BDB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 15:39:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v6so5687860wrv.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 15:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681166346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNwzE4KtIR7VA8WEdFR1Y325MnwjNn/HP5LmgOvBXjw=;
        b=F+gsdJ8fCjBl/In9VkEjngqOT7Yuy4rIlgNTgygFtjvwflyMXmqET1mjhlBYH4h/hK
         UapCpXSmCP5mAkgUJkJ9xtllBixS1M7NeDhQJzNyzoakQgm7T49tE4pNAEm1YTrWbn8f
         i0L9R2NTth5sj0N2S1NoFjUb4Z+83LqH5dScPFvzIIZIAZ+zcbO/S2lhE1DNKnh3e/rt
         G4WcjnxgSToUUhOPlLr1ZtKawVIYKB1ltq9/PZyILVBqdYT+bQr+5IjeCwCazzV9C+Rn
         HRkjTJ9HhANlIzvKd3TacCbtXRJAs59ZcBBTdJnMu/joEG4yIQZ5+6rigL2hvk2P84Lz
         pBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681166346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNwzE4KtIR7VA8WEdFR1Y325MnwjNn/HP5LmgOvBXjw=;
        b=yLXtieJtkaztUXlZG/NE2pRRgWis8r9tG9gvJRbiAbrZgM6gIXaV9caU0KhpIsjKvx
         F3f0YaXoEpbK1xt7Tp8ubBPZfJl/HJ5lh3l+X0Mcm4YkGL3nV1buuC0W7D+V6JBD69cC
         TcFN7bJiIj/ZaJBKAjLmlQaGCncmU44Z0xV9IKBE87DWMrCiSpWPDQLdksLVz8j5rF+t
         4ZyyVWvM0eU8RbKJ10jh3XyWUQHfTdtfkxHSw4OzNSV/PUPNsoK6cdZaex/XMT4fCrTt
         Bo8FpE6EO0VRTAY5np1tc40BLEF1p5ekgq2ewVZtkj5rdziMYVejOMZEPtzAqbOaXO8o
         +SHg==
X-Gm-Message-State: AAQBX9dGUfmfkyputgbWGZtux9JnQbQZgYUT1RwFALzi5slGgafgXtIP
        6lI3Lpk8I1TK2l1U6heTbmU=
X-Google-Smtp-Source: AKy350Y/Jw0fJS5n1ttIDBcdNXFNA0aKae15RlsyioYA7N5Vk0r0ouA/4vMJ+EkD1ObVbRm/7DG4ew==
X-Received: by 2002:adf:f3cf:0:b0:2d5:2c7b:bc5f with SMTP id g15-20020adff3cf000000b002d52c7bbc5fmr8960195wrp.58.1681166345763;
        Mon, 10 Apr 2023 15:39:05 -0700 (PDT)
Received: from localhost ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with UTF8SMTPSA id m8-20020adffe48000000b002c55521903bsm12862966wrs.51.2023.04.10.15.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 15:39:05 -0700 (PDT)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        David Rhodes <david.rhodes@cirrus.com>,
        James Schulman <james.schulman@cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 1/3] ASoC: ep93xx: i2s: move enable call to startup callback
Date:   Tue, 11 Apr 2023 00:39:00 +0200
Message-Id: <20230410223902.2321834-2-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230410223902.2321834-1-alexander.sverdlin@gmail.com>
References: <20230410223902.2321834-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make startup/shutdown callbacks symmetric to avoid clock subsystem warnings
(reproduced with "aplay --dump-hw-params" + ctrl-c):

WARNING: CPU: 0 PID: 102 at drivers/clk/clk.c:1048 clk_core_disable
lrclk already disabled
CPU: 0 PID: 102 Comm: aplay Not tainted 6.2.0-rc4 #1
Hardware name: Generic DT based system
 ...
 clk_core_disable from clk_core_disable_lock
 clk_core_disable_lock from ep93xx_i2s_shutdown
 ep93xx_i2s_shutdown from snd_soc_dai_shutdown
 snd_soc_dai_shutdown from soc_pcm_clean
 soc_pcm_clean from soc_pcm_close
 soc_pcm_close from snd_pcm_release_substream.part.0
 snd_pcm_release_substream.part.0 from snd_pcm_release
 snd_pcm_release from __fput
 __fput from task_work_run
 ...

WARNING: CPU: 0 PID: 102 at drivers/clk/clk.c:907 clk_core_unprepare
lrclk already unprepared
CPU: 0 PID: 102 Comm: aplay Tainted: G        W          6.2.0-rc4 #1
Hardware name: Generic DT based system
 ...
 clk_core_unprepare from clk_unprepare
 clk_unprepare from ep93xx_i2s_shutdown
 ep93xx_i2s_shutdown from snd_soc_dai_shutdown
 snd_soc_dai_shutdown from soc_pcm_clean
 soc_pcm_clean from soc_pcm_close
 soc_pcm_close from snd_pcm_release_substream.part.0
 snd_pcm_release_substream.part.0 from snd_pcm_release
 snd_pcm_release from __fput
 __fput from task_work_run
 ...

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 sound/soc/cirrus/ep93xx-i2s.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index 200d18060f7c..bbbb1065b2f1 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -209,6 +209,16 @@ static int ep93xx_i2s_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+static int ep93xx_i2s_startup(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
+{
+	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
+
+	ep93xx_i2s_enable(info, substream->stream);
+
+	return 0;
+}
+
 static void ep93xx_i2s_shutdown(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
@@ -349,7 +359,6 @@ static int ep93xx_i2s_hw_params(struct snd_pcm_substream *substream,
 	if (err)
 		return err;
 
-	ep93xx_i2s_enable(info, substream->stream);
 	return 0;
 }
 
@@ -398,6 +407,7 @@ static int ep93xx_i2s_resume(struct snd_soc_component *component)
 #endif
 
 static const struct snd_soc_dai_ops ep93xx_i2s_dai_ops = {
+	.startup	= ep93xx_i2s_startup,
 	.shutdown	= ep93xx_i2s_shutdown,
 	.hw_params	= ep93xx_i2s_hw_params,
 	.set_sysclk	= ep93xx_i2s_set_sysclk,
-- 
2.40.0

