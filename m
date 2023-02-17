Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B7269AC3A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjBQNPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBQNPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:15:46 -0500
Received: from exchange.fintech.ru (e10edge.fintech.ru [195.54.195.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD3939B86
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 05:15:41 -0800 (PST)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 17 Feb
 2023 16:15:33 +0300
Received: from KANASHIN1.fintech.ru (10.0.253.125) by Ex16-01.fintech.ru
 (10.0.10.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 17 Feb
 2023 16:15:33 +0300
From:   Natalia Petrova <n.petrova@fintech.ru>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
CC:     Natalia Petrova <n.petrova@fintech.ru>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <lvc-project@linuxtesting.org>
Subject: [PATCH] skl-topology_3627: using sprintf changed to snprintf
Date:   Fri, 17 Feb 2023 16:15:30 +0300
Message-ID: <20230217131530.486962-1-n.petrova@fintech.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.253.125]
X-ClientProxiedBy: Ex16-01.fintech.ru (10.0.10.18) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use snprintf instead of sprintf to avoid buffer overflow.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 2d744ecf2b98 ("ASoC: Intel: Skylake: Automatic DMIC format configuration according to information from NHLT")
Signed-off-by: Natalia Petrova <n.petrova@fintech.ru>
---
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index e06eac592da1..ac06926e651d 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -3660,7 +3660,7 @@ static int skl_tplg_complete(struct snd_soc_component *component)
 
 		se = (struct soc_enum *)kcontrol->private_value;
 		texts = dobj->control.dtexts;
-		sprintf(chan_text, "c%d", mach->mach_params.dmic_num);
+		snprintf(chan_text, sizeof(chan_text), "c%d", mach->mach_params.dmic_num);
 
 		for (i = 0; i < se->items; i++) {
 			if (strstr(texts[i], chan_text)) {
-- 
2.34.1

