Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB1467D135
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjAZQWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjAZQWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:22:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD623433C
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:22:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB7486189B
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F9FC4339B;
        Thu, 26 Jan 2023 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674750131;
        bh=SQ5jhsryjRdmabv2oRisOi9tQKyvrV7uZidDTYhHI+4=;
        h=From:To:Cc:Subject:Date:From;
        b=tKJBVZ/7CYeBmXjWhJfISoo9OgvN+nP8c6o/lEwoWCEA00cwyMVwJtPCKFZLxD0vl
         Q3FM+145xjx8ORpanpSKifs4LiSRp2gVje4g1u8R7jzd9R/OxVdORNc7YihRoj2aH7
         4EEOiRUoG0UHW1KE1FPzd+xK+f3OmhNXmuplTwjEhYb79YU4vDR3O6MnMhuUGgkBmE
         GO4HvXPRl52Nfck9OUn3XXgGUQ9Bt9Sst1W33Yzqj0yhiSxvRhkxBAooVp2d0GmD/n
         VjxsznI8CqNG3BA36PdUJCnyAL3v00x11Dz+cB8ZN3e63rdlKWwYtiHT4s0yktVKtt
         uN+xGm5XebOVw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Zheyu Ma <zheyuma97@gmail.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] ASoC: cs42l56: fix DT probe
Date:   Thu, 26 Jan 2023 17:21:24 +0100
Message-Id: <20230126162203.2986339-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

While looking through legacy platform data users, I noticed that
the DT probing never uses data from the DT properties, as the
platform_data structure gets overwritten directly after it
is initialized.

There have never been any boards defining the platform_data in
the mainline kernel either, so this driver so far only worked
with patched kernels or with the default values.

For the benefit of possible downstream users, fix the DT probe
by no longer overwriting the data.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: reword changelog
---
 sound/soc/codecs/cs42l56.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index 26066682c983..3b0e715549c9 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -1191,18 +1191,12 @@ static int cs42l56_i2c_probe(struct i2c_client *i2c_client)
 	if (pdata) {
 		cs42l56->pdata = *pdata;
 	} else {
-		pdata = devm_kzalloc(&i2c_client->dev, sizeof(*pdata),
-				     GFP_KERNEL);
-		if (!pdata)
-			return -ENOMEM;
-
 		if (i2c_client->dev.of_node) {
 			ret = cs42l56_handle_of_data(i2c_client,
 						     &cs42l56->pdata);
 			if (ret != 0)
 				return ret;
 		}
-		cs42l56->pdata = *pdata;
 	}
 
 	if (cs42l56->pdata.gpio_nreset) {
-- 
2.39.0

