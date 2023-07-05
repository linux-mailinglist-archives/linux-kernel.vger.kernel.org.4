Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6EF74843D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjGEMdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjGEMdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:33:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71FF136
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 05:33:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2AB661562
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 12:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E10C433BD;
        Wed,  5 Jul 2023 12:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688560389;
        bh=dSIi6iSQrZcwHBgwfGJF2PaWQmJdlHaoNoR7kIW6AWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LzN+lNYV2vZg4H9gENrrC6S4iEtnSjbuaAMDlT4SwILg4/z7V0Qdovnpeu/pzfK1M
         Q+ctGGcaD8nzUIpSHwHh1cpUp8W583nWBufO0LIC2VlZ072W/pJrIFrcb57wuRcpIp
         5hge0sli/lraHNXfY4ziya9+OgNzXr5AQZixhA0IMTrCUF+/kDet7QlBhgz6xPm9fP
         +K5gaSo9nnbpC1iMMGVniPOvenW1gy7BsF6+0c9S4wnj5t6Jn8lbVguA3fiTygfAZF
         CQSDcs5a9Rkh98cNY2jFSoQWUClevB4HqouDDW9LrtRHe7Rbtk0dwCKu3omSzAbWcC
         rMeLgQpNmPD/A==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qH1hK-00084M-25;
        Wed, 05 Jul 2023 14:33:30 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 7/8] ASoC: topology: suppress probe deferral errors
Date:   Wed,  5 Jul 2023 14:30:17 +0200
Message-Id: <20230705123018.30903-8-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230705123018.30903-1-johan+linaro@kernel.org>
References: <20230705123018.30903-1-johan+linaro@kernel.org>
MIME-Version: 1.0
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

Suppress probe deferral error messages when loading topologies and
creating frontend links to avoid spamming the logs when a component has
not yet been registered:

    snd-sc8280xp sound: ASoC: adding FE link failed
    snd-sc8280xp sound: ASoC: topology: could not load header: -517

Note that dev_err_probe() is not used as the topology component can be
probed and removed while the underlying platform device remains bound to
its driver.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/soc-topology.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index d0aca6b9058b..696c9647debe 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1751,7 +1751,8 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
 
 	ret = snd_soc_add_pcm_runtimes(tplg->comp->card, link, 1);
 	if (ret < 0) {
-		dev_err(tplg->dev, "ASoC: adding FE link failed\n");
+		if (ret != -EPROBE_DEFER)
+			dev_err(tplg->dev, "ASoC: adding FE link failed\n");
 		goto err;
 	}
 
@@ -2514,8 +2515,11 @@ static int soc_tplg_process_headers(struct soc_tplg *tplg)
 			/* load the header object */
 			ret = soc_tplg_load_header(tplg, hdr);
 			if (ret < 0) {
-				dev_err(tplg->dev,
-					"ASoC: topology: could not load header: %d\n", ret);
+				if (ret != -EPROBE_DEFER) {
+					dev_err(tplg->dev,
+						"ASoC: topology: could not load header: %d\n",
+						ret);
+				}
 				return ret;
 			}
 
-- 
2.39.3

