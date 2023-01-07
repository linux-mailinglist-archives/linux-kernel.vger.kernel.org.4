Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6116A6610AD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 18:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjAGR7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 12:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjAGR7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 12:59:42 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C3932E9D
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 09:59:41 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9so5055512pll.9
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 09:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iWqmgQf0ITiBcZh6JNhizBnvL7irlNgfSV2PoqtxyOw=;
        b=wMIOyxfyvHuC8e5Aj6CB86Nw70h9LBzXvBV1QA9bp/cj6fSM7QyfknVz52mhPEPidk
         a1zsQzUy5Qq7BA4Ks65U5UYG+sp3s+EBb25I2XDJ2dcahqqjpM60S5LbDLZfRpx2MeFU
         W7nfaCWOroj4S4MucO++lqXNHZVD+7BdFUnEzq659JgK4gdHmWhnogPQqXUkmUxBgp5a
         Ua/h1lO+/UUDk4aU/llV3Dk9KtpcdmChz7iAN5oZkUagA7INeCQhFf3pz9/QqMnZ5Gww
         FlwN4i2TSMyEqfdVC6acojXTwY3qO43cpWjfuEQnQa2sYVZKFU4f/Vp8pm576XC0SbMc
         5nLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iWqmgQf0ITiBcZh6JNhizBnvL7irlNgfSV2PoqtxyOw=;
        b=CJ3y24KA2NbCf/xm8MJUTyg4Vl+Nma7oMEKB+2IjbdiwdXmPo3hlHaOhKHxpIAx0sw
         jU0rbHZT+2S3OSMcQSHGIP3OgFApFqie9h1Csc4wrG6ZX09G67FjKNiU/UxL3Q03HAPY
         T0GNEoRdgApWcwHfzJtSyJ7jM90EcEGw+Zbu+m1WLF19bAMN0ETl8QjuplPGOOH/Rzor
         ZmtGJIibwV5vJ5ynJbxs4qrWVIdUuBy1Q8lsZ82kzzuYMU4IPPBmAwF6v9FyhcIlh4BY
         KH6KJsRS8NtRxNLTYxdEdP3kB5meZkTqqE/gFMpFWvgxsW5Pot0xCeI30Ti3mcliHRiS
         yyNA==
X-Gm-Message-State: AFqh2kp6j20VzbjNaJ8KTD7/x7QlS1BEK1Mnl70jHuOoKyu7h/K9pFTX
        N8t3mXv6RhBH80aMZ85+DeID2Gnx/YsOtE+2UmE=
X-Google-Smtp-Source: AMrXdXtVpHJdVOh4RfHSJOx0P/jtbPc2ZkMWo8tGt2ZaF7BG1czvecWZCiKuu3acIhIcAZwpeKeMbg==
X-Received: by 2002:a05:6a20:1a84:b0:a7:89fd:884c with SMTP id ci4-20020a056a201a8400b000a789fd884cmr66257655pzb.11.1673114380551;
        Sat, 07 Jan 2023 09:59:40 -0800 (PST)
Received: from localhost.localdomain (36-226-16-237.dynamic-ip.hinet.net. [36.226.16.237])
        by smtp.gmail.com with ESMTPSA id g84-20020a625257000000b00580978caca7sm3102886pfb.45.2023.01.07.09.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 09:59:39 -0800 (PST)
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        tongjian <tongjian@huaqin.corp-partner.google.com>,
        linux-mediatek@lists.infradead.org,
        "chunxu . li" <chunxu.li@mediatek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH v1] ASoC: mediatek: mt8186-rt5682: primary_codec_init() warn: missing error code? 'ret'
Date:   Sun,  8 Jan 2023 01:59:33 +0800
Message-Id: <20230107175933.12973-1-ajye_huang@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function primary_codec_init() should return 0 if dmic_sel is null.

Here is the warning message reported by 0-DAY CI Kernel Test Service.

smatch warnings:
primary_codec_init() warn: missing error code? 'ret'
...
2022-11-02  141       if (!priv->dmic_sel) {
2022-11-02  142               dev_info(card->dev, "dmic_sel is null\n");
2022-11-02 @143               return ret;

return -EIVNAL;?  return 0;?

2022-11-02  144       }

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>

---
 sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
index af44e331dae8..b333950aa3c3 100644
--- a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
@@ -140,7 +140,7 @@ static int primary_codec_init(struct snd_soc_pcm_runtime *rtd)
 
 	if (!priv->dmic_sel) {
 		dev_info(card->dev, "dmic_sel is null\n");
-		return ret;
+		return 0;
 	}
 
 	ret = snd_soc_dapm_new_controls(&card->dapm, dmic_widgets,
-- 
2.25.1

