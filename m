Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A10732B02
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245591AbjFPJFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjFPJFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:05:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7330A3592
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:02:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D195D614F1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4186AC433C0;
        Fri, 16 Jun 2023 09:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686906157;
        bh=42cOD8sz+eZUMd05BlQRxt1PSMlj4opjLa8x0yA5QWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJXuogqaG3pv8w5YBkzuy6w/IMARU40BcnF+lxrWkGc/JB4SdZjvJJOcZdkV4p2Ik
         vu0A4ay0HhMJPCfnUvyg5jEWm9IyaNmk9Syv+COU4crsF5D984lMHNJo/n3vdnSoen
         y9sT1rAPEjXpIkhFkx8r02RxTDNh6ACIptapPE7+7Muf8D6GKpV18zNnrYtzCltXU9
         /MkJd0fXODF6REfxs6R5/SnxPtIAobq/BQec2KAeJojrAjtzE+DNjLOQxiiUTFrUL6
         iawgZ8PNzdctrsWcXopE0hKxjHT3hgio17OiHDV0Xdou4BaNHXH3FikiJMX8IRpYs3
         dpahOeAN2yxCA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yingkun Meng <mengyingkun@loongson.cn>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ASoC: loongson: fix compile testing on 32-bit
Date:   Fri, 16 Jun 2023 11:00:40 +0200
Message-Id: <20230616090156.2347850-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616090156.2347850-1-arnd@kernel.org>
References: <20230616090156.2347850-1-arnd@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

DIV_ROUND_CLOSEST() does not work on 64-bit variables when building for
a 32-bit target:

ld.lld: error: undefined symbol: __udivdi3
>>> referenced by loongson_i2s.c
>>>               sound/soc/loongson/loongson_i2s.o:(loongson_i2s_hw_params) in archive vmlinux.a

Use DIV_ROUND_CLOSEST_ULL() instead.

Fixes: d24028606e764 ("ASoC: loongson: Add Loongson ASoC Sound Card Support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/loongson/loongson_i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/loongson/loongson_i2s.c b/sound/soc/loongson/loongson_i2s.c
index f73b6d6f16c23..b919f0fe83615 100644
--- a/sound/soc/loongson/loongson_i2s.c
+++ b/sound/soc/loongson/loongson_i2s.c
@@ -89,7 +89,7 @@ static int loongson_i2s_hw_params(struct snd_pcm_substream *substream,
 		bclk_ratio = DIV_ROUND_CLOSEST(sysclk,
 					       (bits * chans * fs * 2)) - 1;
 		mclk_ratio = clk_rate / sysclk;
-		mclk_ratio_frac = DIV_ROUND_CLOSEST(((u64)clk_rate << 16),
+		mclk_ratio_frac = DIV_ROUND_CLOSEST_ULL(((u64)clk_rate << 16),
 						    sysclk) - (mclk_ratio << 16);
 
 		regmap_read(i2s->regmap, LS_I2S_CFG, &val);
-- 
2.39.2

