Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6295EC187
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiI0Lf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiI0LfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:35:12 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8815E7E33E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:35:03 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1664278499; bh=E6uzsBYVZvDKj1HzGMPEUTFj/LsUV+qoai7hTKUpGS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TdnRyzkTL3T68jSbosljBlber57jYv7P01BI8UvAXOC/timh4FZIMdsfcRwDjUkoW
         uiLpHwrOe5hrIhtZD0QT2MtkDQl0eSgop2twqhkwRi1Chq3aYOcwpmY2Jp1BQ26N08
         aeHZf/OjIVEdY9CBrfyJX2ZSatY6bPwumdHRtAX8=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH 2/3] ASoC: apple: mca: Remove stale release of DMA channels
Date:   Tue, 27 Sep 2022 13:34:25 +0200
Message-Id: <20220927113426.49724-2-povik+lin@cutebit.org>
In-Reply-To: <20220927113426.49724-1-povik+lin@cutebit.org>
References: <20220927113426.49724-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 4ec8179c212f ("ASoC: apple: mca: Postpone requesting of DMA
channels") shuffled around with the requesting and releasing of DMA
channels. It left behind stale release calls from within
apple_mca_release, remove those now.

Fixes: 4ec8179c212f ("ASoC: apple: mca: Postpone requesting of DMA channels")
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/apple/mca.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/apple/mca.c b/sound/soc/apple/mca.c
index 75925bfcf754..7ca653987b78 100644
--- a/sound/soc/apple/mca.c
+++ b/sound/soc/apple/mca.c
@@ -970,18 +970,11 @@ static const struct snd_soc_component_driver mca_component = {
 
 static void apple_mca_release(struct mca_data *mca)
 {
-	int i, stream;
+	int i;
 
 	for (i = 0; i < mca->nclusters; i++) {
 		struct mca_cluster *cl = &mca->clusters[i];
 
-		for_each_pcm_streams(stream) {
-			if (IS_ERR_OR_NULL(cl->dma_chans[stream]))
-				continue;
-
-			dma_release_channel(cl->dma_chans[stream]);
-		}
-
 		if (!IS_ERR_OR_NULL(cl->clk_parent))
 			clk_put(cl->clk_parent);
 
-- 
2.33.0

