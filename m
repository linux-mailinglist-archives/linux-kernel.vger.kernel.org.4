Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09017732EEA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345454AbjFPKiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345561AbjFPKfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:35:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91985FF5;
        Fri, 16 Jun 2023 03:29:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12BC5637B9;
        Fri, 16 Jun 2023 10:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CD1C433D9;
        Fri, 16 Jun 2023 10:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911325;
        bh=xcVet4QUYlmeBQFF0cY9pek2NTN+5js8BLGNsyiNVdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ia5sQImKew6rTWQqyc+GAxGlkSJP6KnrJorDICORf6s2yfMIfQGD8Mds2wOvhSneP
         hy66sOx77qHkIbXbnzz45ttKX8XjAjqkDhjJEzEHjBhP/xyrFG+tPzD7fkzjnPK6/m
         dRgX+MZhFG5CurHOdheYeN9e9EPdzWFWVWPdInNwDTDFsm5damgSicuW0UWyZNX5rL
         YrsDJkb4wyBJzn+018IUp30VsDUfABl3LUV1kVlkI9Y9Zd/dq733peEKKXJm5PQFYz
         hmi7O9ur8kVpjDrl1aC0VptwsnpgKL8e2AyJPFABleo1UrIyB/TpHlL8BsR1VeTTxT
         P+uBcXU69zAkg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Edson Juliano Drosdeck <edson.drosdeck@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, ckeepax@opensource.cirrus.com,
        SJLIN0@nuvoton.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 2/6] ASoC: nau8824: Add quirk to active-high jack-detect
Date:   Fri, 16 Jun 2023 06:28:35 -0400
Message-Id: <20230616102839.674283-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102839.674283-1-sashal@kernel.org>
References: <20230616102839.674283-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.286
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

From: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>

[ Upstream commit e384dba03e3294ce7ea69e4da558e9bf8f0e8946 ]

Add  entries for Positivo laptops: CW14Q01P, K1424G, N14ZP74G to the
DMI table, so that  active-high jack-detect will work properly on
these laptops.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Link: https://lore.kernel.org/r/20230529181911.632851-1-edson.drosdeck@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/nau8824.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 4f18bb272e929..0ecea65a80b46 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -1899,6 +1899,30 @@ static const struct dmi_system_id nau8824_quirk_table[] = {
 		},
 		.driver_data = (void *)(NAU8824_JD_ACTIVE_HIGH),
 	},
+	{
+		/* Positivo CW14Q01P */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
+			DMI_MATCH(DMI_BOARD_NAME, "CW14Q01P"),
+		},
+		.driver_data = (void *)(NAU8824_JD_ACTIVE_HIGH),
+	},
+	{
+		/* Positivo K1424G */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
+			DMI_MATCH(DMI_BOARD_NAME, "K1424G"),
+		},
+		.driver_data = (void *)(NAU8824_JD_ACTIVE_HIGH),
+	},
+	{
+		/* Positivo N14ZP74G */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
+			DMI_MATCH(DMI_BOARD_NAME, "N14ZP74G"),
+		},
+		.driver_data = (void *)(NAU8824_JD_ACTIVE_HIGH),
+	},
 	{}
 };
 
-- 
2.39.2

