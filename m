Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A5E71177E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241430AbjEYTf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241866AbjEYTfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:35:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A623919D;
        Thu, 25 May 2023 12:34:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11960648DA;
        Thu, 25 May 2023 18:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49E1C4339C;
        Thu, 25 May 2023 18:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039861;
        bh=mfi9pA8TtpQSlQKzzbalZaPXkKkmtsGD+l1SjdXJ0yA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oOalC8pTrezl1fpTlq6y5iYo6AMQM+1OmVczjERQ88yJIFXOWoa7S3neSt33hp4Mk
         IiD/FebM+oMGJjFSSqHh0vqVMAfk/aQyF4Ry+uk5pFPcXbTYaUTfqP0yWoU79zrXsr
         5GsJr4OjIlVE1ikhEVnQ10vZ+dICBm3lztSNwgDkFiW9/CuzGiGOI6Dln88LQiOASV
         9S/Zeeg/lwXkla5CG2trgbXFapSgeD6me5GVBIEEvvwvD+uqCdVFRK0E84lxUkdunx
         VNqtmZ2RT8hqjyrjbC+u/8c08TEOaHNrtKxF8FI+y/QZWZ3mzqVW4055WXpETXVjsD
         4oJjyMeQ0snaw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 26/57] ASoC: SOF: debug: conditionally bump runtime_pm counter on exceptions
Date:   Thu, 25 May 2023 14:35:36 -0400
Message-Id: <20230525183607.1793983-26-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183607.1793983-1-sashal@kernel.org>
References: <20230525183607.1793983-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 3de975862f985f1c9e225a0d13aa3d501373f7c3 ]

When a firmware IPC error happens during a pm_runtime suspend, we
ignore the error and suspend anyways. However, the code
unconditionally increases the runtime_pm counter. This results in a
confusing configuration where the code will suspend, resume but never
suspend again due to the use of pm_runtime_get_noresume().

The intent of the counter increase was to prevent entry in D3, but if
that transition to D3 is already started it cannot be stopped. In
addition, there's no point in that case in trying to prevent anything,
the firmware error is handled and the next resume will re-initialize
the firmware completely.

This patch changes the logic to prevent suspend when the device is
pm_runtime active and has a use_count > 0.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com
Link: https://lore.kernel.org/r/20230512103315.8921-2-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
index ade0507328af4..5042312b1b98d 100644
--- a/sound/soc/sof/debug.c
+++ b/sound/soc/sof/debug.c
@@ -437,8 +437,8 @@ void snd_sof_handle_fw_exception(struct snd_sof_dev *sdev, const char *msg)
 		/* should we prevent DSP entering D3 ? */
 		if (!sdev->ipc_dump_printed)
 			dev_info(sdev->dev,
-				 "preventing DSP entering D3 state to preserve context\n");
-		pm_runtime_get_noresume(sdev->dev);
+				 "Attempting to prevent DSP from entering D3 state to preserve context\n");
+		pm_runtime_get_if_in_use(sdev->dev);
 	}
 
 	/* dump vital information to the logs */
-- 
2.39.2

