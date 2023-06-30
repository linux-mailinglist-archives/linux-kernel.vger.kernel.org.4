Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F73A743D74
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjF3O1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjF3O1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:27:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26B33AAD
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 07:27:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C44761769
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 14:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB857C433C8;
        Fri, 30 Jun 2023 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688135238;
        bh=d1TV3UMh6xoeemuKnST1bo2dXdckO3q+r8QUrL0X6V0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jcldJ0KIiGOHCLdh9VVbIIOMTDdsd6uLObALf9+N/4QXztMgUhpnzo07D6JSEprGM
         ysVwMdU2PImvgsB5pqYjIvXZMsmeeULwOILdMeIoJXSwnjfIErW6dM4eX1nbNAAJXY
         V9JcWcfAE4AfzWdwEc1M4M77rRKpZVqIQwUz3MiMlfa2v7hLL3SFBbvGoiSa+xN5H5
         OfzWVaRpKNjExA124iP9Ph2a1ewcq91hqNWwCiKAMNmSwWeO7QJdoOU5wS78uBPvXy
         fzqKb+BQ2096laCMex5jcQuh3ulVn45f94C2JgpZgoQgM6iNWghg5jSYM2fyJqS3/W
         W3WQTNgRXUdWg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qFF5p-0001OU-GP; Fri, 30 Jun 2023 16:27:25 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 4/5] ASoC: codecs: wcd934x: demote impedance printk
Date:   Fri, 30 Jun 2023 16:27:16 +0200
Message-Id: <20230630142717.5314-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230630142717.5314-1-johan+linaro@kernel.org>
References: <20230630142717.5314-1-johan+linaro@kernel.org>
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

Demote the MBHC impedance measurement printk, which is only needed
for development and debugging, to debug level.

While at it, fix the capitalisation of "ohm" and add the missing space
before the opening parenthesis.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/wcd934x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index c0d1fa36d841..9d724b5710f7 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -2683,7 +2683,7 @@ static inline void wcd934x_mbhc_get_result_params(struct wcd934x_codec *wcd934x,
 	else if (x1 < minCode_param[noff])
 		*zdet = WCD934X_ZDET_FLOATING_IMPEDANCE;
 
-	dev_info(wcd934x->dev, "%s: d1=%d, c1=%d, x1=0x%x, z_val=%d(milliOhm)\n",
+	dev_dbg(wcd934x->dev, "%s: d1=%d, c1=%d, x1=0x%x, z_val=%di (milliohm)\n",
 		__func__, d1, c1, x1, *zdet);
 ramp_down:
 	i = 0;
-- 
2.39.3

