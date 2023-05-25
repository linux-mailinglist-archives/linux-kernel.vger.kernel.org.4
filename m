Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5392E7115AF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242363AbjEYSm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242361AbjEYSmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:42:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AACF10E6;
        Thu, 25 May 2023 11:39:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4A67648BB;
        Thu, 25 May 2023 18:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F6FC4339E;
        Thu, 25 May 2023 18:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039863;
        bh=q7vcfc16PjA+NkG7H7TNTKpVXqNCV7v7kYLgjKHgNIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aP+LjEe4jj1ZdO9YVwcjOy3eK98RpDFGojDUF5gfsfodd5+WsGI9O+cl8sh7K1X1G
         1fYZYFjp696Rtupdsyv0EDRdcNam7NeR0xURUQIs1cJVAjFIsnkFNA0C/GfqvyUdnf
         QhSmTuIjlSUvYORqadkvEMfZNulMd4vEScMYDY7t0CYZSyc/DBblc7UCWhWsPkLqJY
         uPqtO6k4NkTXdLKX/QfneCnF4qkO8R3gC0TmSuC+O7Z6jUQlrFGcGVoRK0KSDpsM0x
         mN2vFEcT5/4LETdpGXdRW0dkpX7PJAaZVESxcaNcaXSC0K3QzI932FaK1QqwnJ2GyP
         mLIbeJJWsa6RA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 27/57] ASoC: SOF: pcm: fix pm_runtime imbalance in error handling
Date:   Thu, 25 May 2023 14:35:37 -0400
Message-Id: <20230525183607.1793983-27-sashal@kernel.org>
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

[ Upstream commit da0fe8fd515a471d373acc3682bfb5522cca4d55 ]

When an error occurs, we need to make sure the device can pm_runtime
suspend instead of keeping it active.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com
Link: https://lore.kernel.org/r/20230512103315.8921-3-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/pcm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 14571b821ecac..be6f38af37b5d 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -619,16 +619,17 @@ static int sof_pcm_probe(struct snd_soc_component *component)
 				       "%s/%s",
 				       plat_data->tplg_filename_prefix,
 				       plat_data->tplg_filename);
-	if (!tplg_filename)
-		return -ENOMEM;
+	if (!tplg_filename) {
+		ret = -ENOMEM;
+		goto pm_error;
+	}
 
 	ret = snd_sof_load_topology(component, tplg_filename);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(component->dev, "error: failed to load DSP topology %d\n",
 			ret);
-		return ret;
-	}
 
+pm_error:
 	pm_runtime_mark_last_busy(component->dev);
 	pm_runtime_put_autosuspend(component->dev);
 
-- 
2.39.2

