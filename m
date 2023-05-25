Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FA4711452
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241943AbjEYShG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241977AbjEYSgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:36:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B421FC9;
        Thu, 25 May 2023 11:35:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1E046145F;
        Thu, 25 May 2023 18:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1020C433D2;
        Thu, 25 May 2023 18:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039647;
        bh=hJg46VfbTWxIwGTGG7h6AktdrZprwQtapsxWqyAjKFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tf6HnR8Mnux8LnCEJlsaH0qc5u4BtM3WOwbUBnLC3yruO0AEzN+Ed2Bq4gxzYDewR
         LBzs6XrDX9OuSj2wm6zcpK9nyAZf2H8RvrNGfa7rJwJLQBQKRBKeL6oP1XYC1PTECT
         WWz+XvuhoCqIKm8Gd9SP8FboPPaNFeE85MKhkesntqdQwQJcJqGa1GJgoY/lERGn90
         kE0MeqpGFJ8Lf1TESoW+sRdPBUJpwJrgsx36djWiu6iKamq6IxNQNP+e8kkqwl2ltl
         BvrEAQ6FjY59woaSYsvpQ8njgTnvPbDWje7FzD6UxGQKXBcAkcpA9wcNvBKNluaVSg
         KSnvPsETNcLRw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.3 34/67] ASoC: SOF: pm: save io region state in case of errors in resume
Date:   Thu, 25 May 2023 14:31:11 -0400
Message-Id: <20230525183144.1717540-34-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183144.1717540-1-sashal@kernel.org>
References: <20230525183144.1717540-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

[ Upstream commit 171b53be635ac15d4feafeb33946035649b1ca14 ]

If there are failures in DSP runtime resume, the device state will not
reach active and this makes it impossible e.g. to retrieve a possible
DSP panic dump via "exception" debugfs node. If
CONFIG_SND_SOC_SOF_DEBUG_ENABLE_DEBUGFS_CACHE=y is set, the data in
cache is stale. If debugfs cache is not used, the region simply cannot
be read.

To allow debugging these scenarios, update the debugfs cache contents in
resume error handler. User-space can then later retrieve DSP panic and
other state via debugfs (requires SOF debugfs cache to be enabled in
build).

Reported-by: Curtis Malainey <cujomalainey@chromium.org
Link: https://github.com/thesofproject/linux/issues/4274
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com
Reviewed-by: Curtis Malainey <cujomalainey@chromium.org
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com
Link: https://lore.kernel.org/r/20230512104638.21376-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/pm.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/pm.c b/sound/soc/sof/pm.c
index 85412aeb1ca16..40f392efd8246 100644
--- a/sound/soc/sof/pm.c
+++ b/sound/soc/sof/pm.c
@@ -159,7 +159,7 @@ static int sof_resume(struct device *dev, bool runtime_resume)
 		ret = tplg_ops->set_up_all_pipelines(sdev, false);
 		if (ret < 0) {
 			dev_err(sdev->dev, "Failed to restore pipeline after resume %d\n", ret);
-			return ret;
+			goto setup_fail;
 		}
 	}
 
@@ -173,6 +173,18 @@ static int sof_resume(struct device *dev, bool runtime_resume)
 			dev_err(sdev->dev, "ctx_restore IPC error during resume: %d\n", ret);
 	}
 
+setup_fail:
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_ENABLE_DEBUGFS_CACHE)
+	if (ret < 0) {
+		/*
+		 * Debugfs cannot be read in runtime suspend, so cache
+		 * the contents upon failure. This allows to capture
+		 * possible DSP coredump information.
+		 */
+		sof_cache_debugfs(sdev);
+	}
+#endif
+
 	return ret;
 }
 
-- 
2.39.2

