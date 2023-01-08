Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D8E6614D5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 12:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjAHLoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 06:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjAHLoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 06:44:01 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DA6DF70
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 03:44:00 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id q64so5998410pjq.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 03:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K9nsM9ze7/IVAFeNx2iL5lzz62WyvKhiLwvesPkswPc=;
        b=JZNPMaVecw2wAD9otYPnQHFnTEF+Tu1oNbEjp5STAi+ECzfPFA8tIGA1EaSGNqEFrN
         q99Ew5DTqSFV+jxLC3M0ei6NrX7va83Dl5iMGSsI2y7CRsF9HRFz1yjOD6rUi2VVACUm
         +lha5iN9Gy5GpL/Orqm0pYrc3I/xgNghbMUdB4UhvbH1zjeCwwJQqeKAlQvTePXNYF8E
         OLQ1ArR9wP6GVMf8VAAirh5vi4NxEnIdFGll43fgy/tKoMSvOu7ySrizB65Zz/5xTSUz
         px2pPVv0AaRBhv+eEV4VoPXXz6fFjs0JHWI4d1Fkg+SZ4tt+hcdLQuEW3jSSvz26IkWo
         pgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K9nsM9ze7/IVAFeNx2iL5lzz62WyvKhiLwvesPkswPc=;
        b=tAFrERC4CEHxlqjzEsDzawRoqz44XCzBvJvnYyS6jE03+Ea5Cx9hO2Shpw7xmwiOJC
         l+fTFDVnZr6aOojzzmVtePQWWresMCfqh4qb8zwzxDU+psyBke3Sm3OVvMTcrovtCvYs
         kEBHdks2hablTwQty5ROvEKKsy6iIXJnsgGrJ9889i8UO0WDxqS7rEawLcy2u9xO+x8V
         dzl+9d5hnhzhVFmdfkJdD8SXUFOBIdkFRa1fXRE8BP2wg0d4ig49YptWkA8E8iTx0ye/
         45CAr+qYNU9x930ZfCG1Uxi4CaYPViwn0ejNCw57QpdOqmALnqFuWERxNJmsKhAXvlb3
         Ij+A==
X-Gm-Message-State: AFqh2kr+XKAJefexWxproIqfq1KmfZm25aFvL3UuWRZ+jja/aEZs7l9G
        zx1WU1dwcN1dDp7U4Cxud5uu6xL1umOv0rge/7Q=
X-Google-Smtp-Source: AMrXdXsNwzNBN2wYlF9q0MVzJwVapvLJ3KcrR9ulqvMDas5TSQuWTmnHqjbmnPNZCS5CFVDxoRNluw==
X-Received: by 2002:a17:90b:310f:b0:226:876c:4c57 with SMTP id gc15-20020a17090b310f00b00226876c4c57mr20464874pjb.39.1673178239277;
        Sun, 08 Jan 2023 03:43:59 -0800 (PST)
Received: from localhost.localdomain (36-226-16-237.dynamic-ip.hinet.net. [36.226.16.237])
        by smtp.gmail.com with ESMTPSA id j23-20020a17090a061700b002262fcd92desm5621521pjj.7.2023.01.08.03.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 03:43:58 -0800 (PST)
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Terry Cheong <htcheong@chromium.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Ryan Lee <ryan.lee.analog@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        David Lin <CTLIN0@nuvoton.com>, Brent Lu <brent.lu@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Patches Robot 
        <linux-patches-robot@chromeos-missing-patches.google.com.iam.gserviceaccount.com>,
        amadeuszx.slawinski@linux.intel.com, alsa-devel@alsa-project.org,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1] ASoC: nau8315: remove dependency on GPIOLIB
Date:   Sun,  8 Jan 2023 19:43:51 +0800
Message-Id: <20230108114351.539786-1-ajye_huang@compal.corp-partner.google.com>
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

commit dcc2c012c7691 ("ASoC: Fix gpiolib dependencies") removed a
series of unnecessary dependencies on GPIOLIB when the gpio was
optional.

A similar simplification seems valid for nau8315, so remove the
dependency as well. This will avoid the following warning

  WARNING: unmet direct dependencies detected for SND_SOC_NAU8315

   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] &&
                   GPIOLIB [=n]
   Selected by [y]:

     - SND_SOC_INTEL_SOF_NAU8825_MACH [=y] && SOUND [=y] && !UML &&
       SND [=y] && SND_SOC [=y] && SND_SOC_INTEL_MACH [=y] &&
       (SND_SOC_SOF_HDA_LINK [=y] || SND_SOC_SOF_BAYTRAIL [=n]) &&
       I2C [=y] && ACPI [=y] && SND_HDA_CODEC_HDMI [=y] &&
       SND_SOC_SOF_HDA_AUDIO_CODEC [=y] && (MFD_INTEL_LPSS [=n] ||
       COMPILE_TEST [=y])

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
---
 sound/soc/codecs/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index bbd401e52be1..e165addec25f 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1863,7 +1863,6 @@ config SND_SOC_MT6660
 
 config SND_SOC_NAU8315
 	tristate "Nuvoton Technology Corporation NAU8315 CODEC"
-	depends on GPIOLIB
 
 config SND_SOC_NAU8540
 	tristate "Nuvoton Technology Corporation NAU85L40 CODEC"
-- 
2.25.1

