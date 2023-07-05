Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD09748438
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjGEMdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjGEMdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:33:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD049116;
        Wed,  5 Jul 2023 05:33:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F65E6155C;
        Wed,  5 Jul 2023 12:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8159FC433C8;
        Wed,  5 Jul 2023 12:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688560389;
        bh=wvD6bbrOokxfZPO0DaokGurW5X0rMNd0E3gL+SAwNDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OrzrAs3Kf3NwkB6zPJMgq32SprJp3/GoftKi8agEkCoOfEhjQKP0Av4nA7LIClKjp
         71dxk/K3PUdH7D6lRX+QH6zwbbJpjrQP170yTK+y/4bj9wKaeLuX7pMVRjhRiisRSc
         SLkCpvjzO5D4lTIJ46WiwdD/ZYU3uC+tv1hZTf9o5/1MNqlDgciP897QSq3pPMwfK0
         OResP1n/XRy2Q5dSSgR9wUwsKPPUpAr8BF2fUlRqHedDhpPQMQxl8jviYASKcv0sY8
         JuzseHo230TbjSJGImzoAQSKFvumw1kwW2MLo7Vu5uKTi43q+QvZ6WpTIY2+0y1WGY
         D6uGCn/oSzVSg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qH1hK-00084C-10;
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
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 3/8] ASoC: codecs: wcd938x: fix missing clsh ctrl error handling
Date:   Wed,  5 Jul 2023 14:30:13 +0200
Message-Id: <20230705123018.30903-4-johan+linaro@kernel.org>
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

Allocation of the clash control structure may fail so add the missing
error handling to avoid dereferencing an error pointer.

Fixes: 8d78602aa87a ("ASoC: codecs: wcd938x: add basic driver")
Cc: stable@vger.kernel.org	# 5.14
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/wcd938x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index faa15a5ed2c8..2e342398d027 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3106,6 +3106,10 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 						 WCD938X_ID_MASK);
 
 	wcd938x->clsh_info = wcd_clsh_ctrl_alloc(component, WCD938X);
+	if (IS_ERR(wcd938x->clsh_info)) {
+		pm_runtime_put(dev);
+		return PTR_ERR(wcd938x->clsh_info);
+	}
 
 	wcd938x_io_init(wcd938x);
 	/* Set all interrupts as edge triggered */
-- 
2.39.3

