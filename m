Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFB260CFD1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiJYPCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbiJYPB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:01:58 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B10119E00E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666710116; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=xRxva5kPtIk4AgmMh5Ah5qs16fLVraMoyg8JYmMcBno=;
        b=WoGntmFizqSg7uziAiWpH5vkz4ugrgLIaFQgV7uO5zGOHCikQwdp6kdWtXJudWr29Kg2fv
        0FOO4EOdIkiNYAuyYFzYnRntmv9oZDxReSLf5ZOI3t97XCm5YVt2MsrcJeEzu6GDYf+1u9
        +LKdo1Xbe7TwcFSdhU/0VIPsxSh6EhY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] ASoC: dapm: Don't use prefix for regulator name
Date:   Tue, 25 Oct 2022 16:01:49 +0100
Message-Id: <20221025150149.113129-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a component has a prefix, and uses a SND_SOC_DAPM_REGULATOR_SUPPLY,
the name of the regulator should not use the prefix, otherwise it won't
be properly matched in the DT/ACPI.

Fixes: 3caac759681e ("ASoC: soc-dapm.c: fixup snd_soc_dapm_new_control_unlocked() error handling")
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d515e7a78ea8..879cf1be67a9 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3645,7 +3645,7 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 
 	switch (w->id) {
 	case snd_soc_dapm_regulator_supply:
-		w->regulator = devm_regulator_get(dapm->dev, w->name);
+		w->regulator = devm_regulator_get(dapm->dev, widget->name);
 		if (IS_ERR(w->regulator)) {
 			ret = PTR_ERR(w->regulator);
 			goto request_failed;
-- 
2.35.1

