Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116A9748440
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjGEMd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjGEMdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:33:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DD7113
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 05:33:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB81661573
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 12:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BCBC61180;
        Wed,  5 Jul 2023 12:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688560389;
        bh=f6yTboHdDxAlYnmIQ62ZL53MjCiOLY54svw8nFvYa9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hftrEYWeSMZIfjIEg07Y6+0dHdPyzdBS2xzN7RS9Wr85NheRLLfBNEceT3aMvGVC7
         7VsXgQaoUle+/v3YCEBGdUlVAHb1nDUrxnWSIFIHT+WckFCaTA3mpAxEWWyoFHXtHS
         wYStwMUAypCluPlvQ32frttjV0TOja268wd5fu3gQ+TaOxcx1GcM1V2ZhUhftvZGg6
         YWtyZTjk1WzZcGbi1T7j5oI4XFvEpD46APG79mSiGT0jS+32s8Fda4Wn2F0sWRN+PT
         n2ZNotMGM+AOKg29dMtZmMAGl995QUpxi5HTIo3PF6aqOunw3Il7yMPKcLhDPa5BMF
         F00koUNwRkvEA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qH1hK-00084Q-2K;
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
Subject: [PATCH 8/8] ASoC: core: suppress probe deferral errors
Date:   Wed,  5 Jul 2023 14:30:18 +0200
Message-Id: <20230705123018.30903-9-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230705123018.30903-1-johan+linaro@kernel.org>
References: <20230705123018.30903-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suppress probe deferral error messages when probing link components to
avoid spamming the logs, for example, if a required component has not
yet been registered:

	snd-sc8280xp sound: ASoC: failed to instantiate card -517

Note that dev_err_probe() is not used as the card can be unbound and
rebound while the underlying platform device remains bound to its
driver.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/soc-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b48efc3a08d2..b9cb5c4e3685 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1988,8 +1988,10 @@ static int snd_soc_bind_card(struct snd_soc_card *card)
 	/* probe all components used by DAI links on this card */
 	ret = soc_probe_link_components(card);
 	if (ret < 0) {
-		dev_err(card->dev,
-			"ASoC: failed to instantiate card %d\n", ret);
+		if (ret != -EPROBE_DEFER) {
+			dev_err(card->dev,
+				"ASoC: failed to instantiate card %d\n", ret);
+		}
 		goto probe_end;
 	}
 
-- 
2.39.3

