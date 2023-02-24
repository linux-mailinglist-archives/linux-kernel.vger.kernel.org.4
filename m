Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CE96A1E99
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjBXPdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBXPdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:33:20 -0500
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A9015882
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 07:33:17 -0800 (PST)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1677252795; bh=FNC6kTd6Z6n+zN6leJIOos4elgBgrZXAAOuIqFvhYUs=;
        h=From:To:Cc:Subject:Date;
        b=kH/TERxBETkz5SQRy/I6aJG4HrBNKpNvVhyYy2/SApa1r7qVGO8CKPOi0NtrKdgdK
         qVcyGffZTorEc3HsQWZnLIZDqdFj8fluDyIPvtHzD+pK8ZtIxw45SPqFmKyuJEM5pn
         R/chzDUc7u81R+uFsei6GAZT4kAD214iYUwJ8eRU=
To:     =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ASoC: apple: mca: Fix final status read on SERDES reset
Date:   Fri, 24 Feb 2023 16:33:00 +0100
Message-Id: <20230224153302.45365-1-povik+lin@cutebit.org>
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

From within the early trigger we are doing a reset of the SERDES unit,
but the final status read is on a bad address. Add the missing SERDES
unit offset in calculation of the address.

Fixes: 3df5d0d97289 ("ASoC: apple: mca: Start new platform driver")
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/apple/mca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/apple/mca.c b/sound/soc/apple/mca.c
index 24381c42eb54..9cceeb259952 100644
--- a/sound/soc/apple/mca.c
+++ b/sound/soc/apple/mca.c
@@ -210,7 +210,7 @@ static void mca_fe_early_trigger(struct snd_pcm_substream *substream, int cmd,
 			   SERDES_CONF_SOME_RST);
 		readl_relaxed(cl->base + serdes_conf);
 		mca_modify(cl, serdes_conf, SERDES_STATUS_RST, 0);
-		WARN_ON(readl_relaxed(cl->base + REG_SERDES_STATUS) &
+		WARN_ON(readl_relaxed(cl->base + serdes_unit + REG_SERDES_STATUS) &
 			SERDES_STATUS_RST);
 		break;
 	default:
-- 
2.33.0

