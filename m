Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395415E674B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiIVPiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiIVPiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:38:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4186EB101
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:38:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 893C6B83883
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8550AC433C1;
        Thu, 22 Sep 2022 15:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663861085;
        bh=ufTHqER2911AjYAjMI2Z0KIjReSirktao0U7lSgkAFg=;
        h=From:To:Cc:Subject:Date:From;
        b=KO4xsI2KK5bFenWW+4r39VBMr1Bx5tD3DORVZPNTiKCRfMRI6M9jYitKlvFUepFsl
         M6IvNWersrjSY07tAN5fgeUTzoLy2WAikvtTL1PZFNrV25tIXMzreVk+MMZOL6XbfK
         4NZSp0VmJhZqfaENWZA4arD/aqSpcNeUUAZH/rhp1MvQXytQz8+dad0jXhUd8OQMbM
         5yWnSlPQOGI3oazB+75J3ujWyFgmBIUsJ7GBlwuTI9k4vcy6QIHTPJLURqjAWHcb7C
         +6Y6jWLDRq2mPwsKTunYf+W2AWzu8KmMZW4M/2b1PPUtcyi6NXkcC2nEnGcU5dRWBq
         fB7++30FBkxAA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH -next] ASoC: Intel: sof_da7219_mx98360a: Access num_codecs through dai_link
Date:   Thu, 22 Sep 2022 08:37:52 -0700
Message-Id: <20220922153752.336193-1-nathan@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 3989ade2d1e7 ("ASoC: soc.h: remove num_cpus/codecs"), the
following build error occurs:

  sound/soc/intel/boards/sof_da7219_max98373.c:198:27: error: no member named 'num_codecs' in 'struct snd_soc_pcm_runtime'
          for (j = 0; j < runtime->num_codecs; j++) {
                          ~~~~~~~  ^
  1 error generated.

This conversion was missed by the aforementioned change. Do it now to
fix the build error.

Fixes: 3989ade2d1e7 ("ASoC: soc.h: remove num_cpus/codecs")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 sound/soc/intel/boards/sof_da7219_max98373.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_da7219_max98373.c b/sound/soc/intel/boards/sof_da7219_max98373.c
index 34cf849a8344..e048e789e633 100644
--- a/sound/soc/intel/boards/sof_da7219_max98373.c
+++ b/sound/soc/intel/boards/sof_da7219_max98373.c
@@ -195,7 +195,7 @@ static int ssp1_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *runtime = asoc_substream_to_rtd(substream);
 	int ret, j;
 
-	for (j = 0; j < runtime->num_codecs; j++) {
+	for (j = 0; j < runtime->dai_link->num_codecs; j++) {
 		struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(runtime, j);
 
 		if (!strcmp(codec_dai->component->name, MAXIM_DEV0_NAME)) {

base-commit: a921986f445ad611b441c8ee7749dc6dfc770481
-- 
2.37.3

