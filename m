Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A85697D12
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbjBONXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbjBONXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:23:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019BF5593
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 05:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676467388; x=1708003388;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WUgNwUhbHaN9HZCnYj8+XtWA1iYsv49O9uBI9FvhwpY=;
  b=Tq9qBiRsOUg14CVe0EygwbCIpdRKvw4VLU61YtAa+SePYm+OPKhZbald
   RKiuMV6vDIhfTeEsQ77lZTId+K+boWTl1mQQEJZf53xVxbALol7f6IlFI
   +5yjNzerPAjWYO8ZWpLLjrCAutJ+eQp+uDfbhy4AxnGsvY5AnnGupospF
   pFttnMpekwrV7AraBpQRMyaaepTOgpd0+HVxpuPLRY+GCDnByVOpJei5g
   FeyMdOHaT//6pbXRHEgKDAGqugW0fWBkcE77hMcJBnl+23XtvJ2vLBysV
   QaSs9kOipnEcVaE+VHuynQEQBFixxyqclXwdmy/2JT3e2w5xnMf+YS3u7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="333563901"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="333563901"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:23:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="733281649"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="733281649"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 15 Feb 2023 05:23:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 56FC51A6; Wed, 15 Feb 2023 15:23:45 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH v1 1/1] ASoC: soc-ac97: Return correct error codes
Date:   Wed, 15 Feb 2023 15:23:43 +0200
Message-Id: <20230215132343.35547-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the switching to dev_err_probe(), during the conversion
of GPIO calls, the return code is passed is a paratemer to it.
At the same time a copy'n'paste mistake was made, so the wrong
variable has been taken for the error reporting. Fix this.

Fixes: 3ee0d39c50dc ("ASoC: soc-ac97: Convert to agnostic GPIO API")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/soc-ac97.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-ac97.c b/sound/soc/soc-ac97.c
index 40051f513c6a..4e4fe29ade50 100644
--- a/sound/soc/soc-ac97.c
+++ b/sound/soc/soc-ac97.c
@@ -336,12 +336,12 @@ static int snd_soc_ac97_parse_pinctl(struct device *dev,
 
 	cfg->sdata_gpio = devm_gpiod_get_index(dev, "ac97", 1, GPIOD_ASIS);
 	if (IS_ERR(cfg->sdata_gpio))
-		return dev_err_probe(dev, PTR_ERR(cfg->sync_gpio), "Can't find ac97-sdata gpio\n");
+		return dev_err_probe(dev, PTR_ERR(cfg->sdata_gpio), "Can't find ac97-sdata gpio\n");
 	gpiod_set_consumer_name(cfg->sdata_gpio, "AC97 link sdata");
 
 	cfg->reset_gpio = devm_gpiod_get_index(dev, "ac97", 2, GPIOD_ASIS);
 	if (IS_ERR(cfg->reset_gpio))
-		return dev_err_probe(dev, PTR_ERR(cfg->sync_gpio), "Can't find ac97-reset gpio\n");
+		return dev_err_probe(dev, PTR_ERR(cfg->reset_gpio), "Can't find ac97-reset gpio\n");
 	gpiod_set_consumer_name(cfg->reset_gpio, "AC97 link reset");
 
 	return 0;
-- 
2.39.1

