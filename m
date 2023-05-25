Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F29471154C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242257AbjEYSme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242323AbjEYSmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:42:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4CD170D;
        Thu, 25 May 2023 11:38:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B114764918;
        Thu, 25 May 2023 18:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99DAC433D2;
        Thu, 25 May 2023 18:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039865;
        bh=JAtkvFZ0/2pDlmSFKy5Da72TvMQtgupm8Xn67ZxEypA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R7blsWeZmMkM9pURA2uF/C3cKiZ/RjwH38+z8jjELgfKUbTIqYtfX+ALfufG5JJU4
         mT5UxSNVgqGTIAlBcfAuHnZ9okCC6vAmdRIDqbM/j6NOIxTmRnuuBbT5FS0zvIfQ8D
         l50a0g+UNXdDeR+yRXtND99BEF9MkC5nJOQ86NvFrmoCFvKbyIopJd43iyzbqhheqh
         x3sdneKW9pXDZNgZEiKg+LTqh57bpMrJIlNK/X09IqavPmpIYzKwyvBRv/zSo0xO/a
         kHwH+If+QQO8spLTfM7IcaKkZNFTy6cR5e7aiuuJ5iLsovzNheGCZEPf+UW5xbi0wu
         UMCiJmAS+xijg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 28/57] ASoC: SOF: sof-client-probes: fix pm_runtime imbalance in error handling
Date:   Thu, 25 May 2023 14:35:38 -0400
Message-Id: <20230525183607.1793983-28-sashal@kernel.org>
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

[ Upstream commit bc424273c74c1565c459c8f2a6ed95caee368d0a ]

When an error occurs, we need to make sure the device can pm_runtime
suspend instead of keeping it active.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com
Link: https://lore.kernel.org/r/20230512103315.8921-4-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/sof-client-probes.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sof/sof-client-probes.c b/sound/soc/sof/sof-client-probes.c
index ddeabbb5580e1..1e521a9e34d27 100644
--- a/sound/soc/sof/sof-client-probes.c
+++ b/sound/soc/sof/sof-client-probes.c
@@ -441,12 +441,7 @@ static ssize_t sof_probes_dfs_points_read(struct file *file, char __user *to,
 
 	ret = sof_probes_points_info(cdev, &desc, &num_desc);
 	if (ret < 0)
-		goto exit;
-
-	pm_runtime_mark_last_busy(dev);
-	err = pm_runtime_put_autosuspend(dev);
-	if (err < 0)
-		dev_err_ratelimited(dev, "debugfs read failed to idle %d\n", err);
+		goto pm_error;
 
 	for (i = 0; i < num_desc; i++) {
 		offset = strlen(buf);
@@ -464,6 +459,13 @@ static ssize_t sof_probes_dfs_points_read(struct file *file, char __user *to,
 	ret = simple_read_from_buffer(to, count, ppos, buf, strlen(buf));
 
 	kfree(desc);
+
+pm_error:
+	pm_runtime_mark_last_busy(dev);
+	err = pm_runtime_put_autosuspend(dev);
+	if (err < 0)
+		dev_err_ratelimited(dev, "debugfs read failed to idle %d\n", err);
+
 exit:
 	kfree(buf);
 	return ret;
-- 
2.39.2

