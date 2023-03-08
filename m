Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC206AFFD6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjCHHfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCHHff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:35:35 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FE63596;
        Tue,  7 Mar 2023 23:35:26 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id i34so62022523eda.7;
        Tue, 07 Mar 2023 23:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678260925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlkyO8OW+WgRQk2FFiUYUZ/IqArcuXEwbJRily5asgc=;
        b=gfFE6M8DHtIav5RU6MsJ3sTZtpxapVJLnD8kVuiiozcjPo1XQt7IOzULrdEeV6Ahgs
         iUWujv1S+BM7sNUt1+eH9PhUb48XhuuB2bfK+8kmt10oXE804Y0eJw4HShFnmVMJS+q0
         MZaeF+1WVM2fBRbuxRN7i9bC99UNr+pqarOQX6snESecTdHoQaZGuEMSR2YC8xViyjmZ
         z4mgfTI9lSSJv4a7kRoo+owwHnE5E+R0wnLHLm/2+RLks9ascL54EsewO0uHEOCegjF9
         AONbZtwPe9uWywrlVKLkJQqTCR0MwysL3in3OytvhQWFFAzP9Nl6LFWaIBnSY16qus/a
         f68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678260925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlkyO8OW+WgRQk2FFiUYUZ/IqArcuXEwbJRily5asgc=;
        b=HLz+vIj6JG9qkyCUwtxnRT8jzsO0b6dredg8X1qZVfGZDklCKowCvTY6AXmMtmQIX2
         Ls1cMDa3idSIBpzovrUfpJef+ID+Q+9w+Nk3vqhf0bDMDobz0OKM7BPjkY9zv2Lh/z1N
         T4EChRdccaRZaEDBryyBaTNbs5SHCfjiAdvqg5HaDdnMf7TbNzO0giU/vU77OmOvlBr3
         BLFWxuHRPGtGSwn0AH4HuXXd9iJoJ1LLLWWhoSXEzm+Y2SjuD9M3U0wd/8OIFEUjnnnf
         hxoOqSHfR622gabR4KDweyVQA3xNFBMQBr6NcQeMoETYgjJhvYWsA72BLQUrYIWvbSQA
         /b7Q==
X-Gm-Message-State: AO0yUKWDjjgcDXGIVUmhjp+TffG9PkV1e8Em3J6yCO8X2qHdQx7ttHmL
        kW0T38wD0duFjhDHUB2t8j8=
X-Google-Smtp-Source: AK7set8wJa4R62qf3wc3kdQ1c8vp1MPY3uW4wwyBLP60VdjYnr0RAEWRy/Eqj8agSppBc4asejUskw==
X-Received: by 2002:a17:907:2bde:b0:906:2b5c:7390 with SMTP id gv30-20020a1709072bde00b009062b5c7390mr15767615ejc.16.1678260925211;
        Tue, 07 Mar 2023 23:35:25 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id h15-20020a1709062dcf00b008dffda52d71sm7051880eji.124.2023.03.07.23.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 23:35:25 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v2 2/8] ASoC: tegra: Support coupled mic-hp detection
Date:   Wed,  8 Mar 2023 09:34:56 +0200
Message-Id: <20230308073502.5421-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230308073502.5421-1-clamor95@gmail.com>
References: <20230308073502.5421-1-clamor95@gmail.com>
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

This quirk is used for cases when there is GPIO which detects
any type of 3.5 Jack insertion and actual type of jack is defined
by other GPIO. 3.5 Jack GPIO generates interrupt and MIC GPIO
indicates type of Jack only if 3.5 Jack GPIO is active.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 sound/soc/tegra/tegra_asoc_machine.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/tegra/tegra_asoc_machine.c b/sound/soc/tegra/tegra_asoc_machine.c
index 78faa8bcae27..7b6d5d90c3a2 100644
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
2.37.2

