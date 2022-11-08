Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EF3620E56
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiKHLN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbiKHLNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:13:50 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CEA186EC;
        Tue,  8 Nov 2022 03:13:43 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j15so20418931wrq.3;
        Tue, 08 Nov 2022 03:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ji1uJ+VLtBXdsvcmViF94zHW4mvj6ILjubVPOBa2RGk=;
        b=FcEGwYjCjOAWlZBOIMa7ZQ4a0r7fjKHCjXGwv6eEgRptjbks2AcaLEjE4LXrZ6/cwR
         6fVi8OZK2w3hjePpvuZYFdSpywBj2bBLzGVnQYaqioLDYdLPmqY3peQsKsycb03l15Z8
         ZA4yGIGnf8jjE/EK6x+qdno7S0q67sTqlm63dD4vNUYtoJTvtCB0DaylSu9tLarF2hZ0
         Ff/DF28CFfw2W0nHpQBZyWA6x80H0IzIkILhxuH7GttHNZWRnfaRIZTXiyzwXmKjd7uw
         n7o73pWfkqcOudywpPZwp1fiJ3Dn7HkFMpDIoqwSatAioYA2JmzgoijK9zxDvEgvSzcJ
         n7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ji1uJ+VLtBXdsvcmViF94zHW4mvj6ILjubVPOBa2RGk=;
        b=1k5LjsQMqGbRhcqxHGpo1rTePtstXxkOv1c7/2tTA1JVbkbplpcVfYDTeOiXe8MU7c
         RD5MEx5Y8qJ0RddO/EdmXPCvD/OcicMox86svyWig5SbN/0kKSiiSfE8BDS2fJ8bXIyV
         eYJ2G+nTygvTKznariE29sWHeGgFkP6EZATvXe2wY8p3qoDAHJ9obJPnBfDKtw1gtXKo
         P7gp6BylqnOZ2QtDaFclDRMWDzngAbRak6pXmLJteZtATYmch25m2WlxvU6D/UaH1i6n
         eZHVJOBHY+iq+DVu69iS1/0VAshSfWGXljjHI8IxbWc4augprs1JCEhKfUWFoOlOUhF2
         68ZQ==
X-Gm-Message-State: ACrzQf2vY5QY+nrbDSpx2ZHKhuO3jKpw5PY1YAPwL+sAproNrIM4ikEu
        43kAHaFk6k9trnmd4IWmggQ=
X-Google-Smtp-Source: AMsMyM4l7Rfl+oM7BrNdp0vHXFkwDB6KbmzTO/A7TvXqqrdeNjv10bttLp2lz1DOqxrjbIbx1pUiEw==
X-Received: by 2002:adf:a45a:0:b0:236:9aa8:e675 with SMTP id e26-20020adfa45a000000b002369aa8e675mr35498723wra.407.1667906022008;
        Tue, 08 Nov 2022 03:13:42 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d420a000000b0023682011c1dsm9840843wrq.104.2022.11.08.03.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 03:13:41 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: tegra: Fix spelling mistake "fliter" -> "filter"
Date:   Tue,  8 Nov 2022 11:13:40 +0000
Message-Id: <20221108111340.115387-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in struct member fliter_structure.
Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/tegra/tegra210_mbdrc.c | 4 ++--
 sound/soc/tegra/tegra210_mbdrc.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/tegra/tegra210_mbdrc.c b/sound/soc/tegra/tegra210_mbdrc.c
index d786daa6aba6..eeacb1220268 100644
--- a/sound/soc/tegra/tegra210_mbdrc.c
+++ b/sound/soc/tegra/tegra210_mbdrc.c
@@ -54,7 +54,7 @@ static const struct tegra210_mbdrc_config mbdrc_init_config = {
 	.mode			= 0, /* Bypass */
 	.rms_off		= 48,
 	.peak_rms_mode		= 1, /* PEAK */
-	.fliter_structure	= 0, /* All-pass tree */
+	.filter_structure	= 0, /* All-pass tree */
 	.shift_ctrl		= 30,
 	.frame_size		= 32,
 	.channel_mask		= 0x3,
@@ -819,7 +819,7 @@ int tegra210_mbdrc_component_init(struct snd_soc_component *cmpnt)
 
 	regmap_update_bits(ope->mbdrc_regmap, TEGRA210_MBDRC_CFG,
 		TEGRA210_MBDRC_CFG_FILTER_STRUCTURE_MASK,
-		conf->fliter_structure <<
+		conf->filter_structure <<
 		TEGRA210_MBDRC_CFG_FILTER_STRUCTURE_SHIFT);
 
 	regmap_update_bits(ope->mbdrc_regmap, TEGRA210_MBDRC_CFG,
diff --git a/sound/soc/tegra/tegra210_mbdrc.h b/sound/soc/tegra/tegra210_mbdrc.h
index 4c48da0e1dea..76e443a7934e 100644
--- a/sound/soc/tegra/tegra210_mbdrc.h
+++ b/sound/soc/tegra/tegra210_mbdrc.h
@@ -199,7 +199,7 @@ struct tegra210_mbdrc_config {
 	unsigned int mode;
 	unsigned int rms_off;
 	unsigned int peak_rms_mode;
-	unsigned int fliter_structure;
+	unsigned int filter_structure;
 	unsigned int shift_ctrl;
 	unsigned int frame_size;
 	unsigned int channel_mask;
-- 
2.38.1

