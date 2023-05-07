Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D218C6F9609
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjEGAjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjEGAht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:37:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876002ABDA;
        Sat,  6 May 2023 17:36:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EC8C6147C;
        Sun,  7 May 2023 00:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD21C433EF;
        Sun,  7 May 2023 00:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683419679;
        bh=40z2ZpojbXuP6tB3+OAoSZu6KHvjy/jbjRj5UZ9K8Nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZNTKFka9EdHMVSU7XZnt6Iue1iFrugPRhIeoDqYX9MM3Lz/Wdnxh5PnGBRVa79f0J
         ijFiohs2UAT5wCpUlITOX174WlNWv9S3Yc5DfNt11Aiev4w7Du657eR/PiAi0sRxnm
         4AwLCZqFqvOgWW+lsCMwnZdckRqushA4d7CW0Nr/MRxQ7PyEb+Xg7JE2mboRZdvBGK
         vgGqS35IEq/e/yBDeC2REO3RhyY1vVJXZiiOKFFX/JRe0SsCnEwRwCLFm5km1ENGiY
         t8yme+5yU2aFtJLNKw6pIuwC9QE589KnmT6/d16yCR92QTCEYbPQRN8DdFg4nsmfE+
         qTtrQcYTcoHPg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, jiapeng.chong@linux.alibaba.com,
        ion@agorria.com, robh@kernel.org, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/19] ASoC: tegra: Support coupled mic-hp detection
Date:   Sat,  6 May 2023 20:34:03 -0400
Message-Id: <20230507003417.4077259-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507003417.4077259-1-sashal@kernel.org>
References: <20230507003417.4077259-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Svyatoslav Ryhel <clamor95@gmail.com>

[ Upstream commit eb0b8481c2e03a5ae01f6bea60b42109bd12b6fe ]

This quirk is used for cases when there is GPIO which detects
any type of 3.5 Jack insertion and actual type of jack is defined
by other GPIO. 3.5 Jack GPIO generates interrupt and MIC GPIO
indicates type of Jack only if 3.5 Jack GPIO is active.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Link: https://lore.kernel.org/r/20230308073502.5421-3-clamor95@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/tegra/tegra_asoc_machine.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/tegra/tegra_asoc_machine.c b/sound/soc/tegra/tegra_asoc_machine.c
index 78faa8bcae274..7b6d5d90c3a2d 100644
--- a/sound/soc/tegra/tegra_asoc_machine.c
+++ b/sound/soc/tegra/tegra_asoc_machine.c
@@ -51,6 +51,17 @@ static struct snd_soc_jack_gpio tegra_machine_headset_jack_gpio = {
 };
 
 /* Mic Jack */
+static int coupled_mic_hp_check(void *data)
+{
+	struct tegra_machine *machine = (struct tegra_machine *)data;
+
+	/* Detect mic insertion only if 3.5 jack is in */
+	if (gpiod_get_value_cansleep(machine->gpiod_hp_det) &&
+	    gpiod_get_value_cansleep(machine->gpiod_mic_det))
+		return SND_JACK_MICROPHONE;
+
+	return 0;
+}
 
 static struct snd_soc_jack tegra_machine_mic_jack;
 
@@ -183,8 +194,15 @@ int tegra_asoc_machine_init(struct snd_soc_pcm_runtime *rtd)
 			return err;
 		}
 
+		tegra_machine_mic_jack_gpio.data = machine;
 		tegra_machine_mic_jack_gpio.desc = machine->gpiod_mic_det;
 
+		if (of_property_read_bool(card->dev->of_node,
+					  "nvidia,coupled-mic-hp-det")) {
+			tegra_machine_mic_jack_gpio.desc = machine->gpiod_hp_det;
+			tegra_machine_mic_jack_gpio.jack_status_check = coupled_mic_hp_check;
+		};
+
 		err = snd_soc_jack_add_gpios(&tegra_machine_mic_jack, 1,
 					     &tegra_machine_mic_jack_gpio);
 		if (err)
-- 
2.39.2

