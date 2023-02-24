Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFE56A1E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjBXPdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjBXPdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:33:21 -0500
X-Greylist: delayed 648 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Feb 2023 07:33:17 PST
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BF4199DC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 07:33:17 -0800 (PST)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1677252796; bh=YGinMNYfBj9tPJ7INLC5xM+c2L7Uf1eMU3rGvaMeVic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gvMicpRvMrcnvujo94b4P//HAZMsJSPEX6dUJTNPmGGqMUvLcOG0uoWY7QssQm5zC
         6wMeg0oEXLabG9bZ+kMeiqnh9j0qrnKtUCbbXc7CJIf4oMyewt/MEqHeLXSkZHSzD4
         0cM9EHBJ/VR3jl6vcqO+oLVgQsO4r5vJDLkTc81U=
To:     =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ASoC: apple: mca: Improve handling of unavailable DMA channels
Date:   Fri, 24 Feb 2023 16:33:02 +0100
Message-Id: <20230224153302.45365-3-povik+lin@cutebit.org>
In-Reply-To: <20230224153302.45365-1-povik+lin@cutebit.org>
References: <20230224153302.45365-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we fail to obtain a DMA channel, don't return a blanket -EINVAL,
instead return the original error code if there's one. This makes
deferring work as it should. Also don't print an error message for
-EPROBE_DEFER.

Fixes: 4ec8179c212f ("ASoC: apple: mca: Postpone requesting of DMA channels")
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/apple/mca.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/apple/mca.c b/sound/soc/apple/mca.c
index aea08c7b2ee8..64750db9b963 100644
--- a/sound/soc/apple/mca.c
+++ b/sound/soc/apple/mca.c
@@ -950,10 +950,17 @@ static int mca_pcm_new(struct snd_soc_component *component,
 		chan = mca_request_dma_channel(cl, i);
 
 		if (IS_ERR_OR_NULL(chan)) {
+			mca_pcm_free(component, rtd->pcm);
+
+			if (chan && PTR_ERR(chan) == -EPROBE_DEFER)
+				return PTR_ERR(chan);
+
 			dev_err(component->dev, "unable to obtain DMA channel (stream %d cluster %d): %pe\n",
 				i, cl->no, chan);
-			mca_pcm_free(component, rtd->pcm);
-			return -EINVAL;
+
+			if (!chan)
+				return -EINVAL;
+			return PTR_ERR(chan);
 		}
 
 		cl->dma_chans[i] = chan;
-- 
2.33.0

