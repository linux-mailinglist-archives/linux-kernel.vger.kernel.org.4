Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DB464E8D0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 10:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiLPJqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 04:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLPJqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 04:46:42 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88BF10B73
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 01:46:40 -0800 (PST)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4A937851FC;
        Fri, 16 Dec 2022 10:46:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671183998;
        bh=WOaRp1o2Jv3EJCkvPGwU9coZufEjr6sI22bltN9JL4k=;
        h=From:To:Cc:Subject:Date:From;
        b=rNGlylItoItOvElXqnnbH37EsM6DM9gINpC6+fj4W3IUHrZyi/8IUhN5tGxSlYzp7
         pNxdX1830iKdCZjGrk4HoC0NZfJtgSMGUzA032x4ZUdIo8QBqKUZQDtAiZdxj1X3wm
         +LJZy1+UFlaOvYqKSWqf1sdF5GGdje0ynQcrJwilfiSqRhAoh8eEVIHmpGC04YW6G6
         rOacsev2iK9KSz7zF7mzMFpVKJPzyE4xsackHi5YaJWdWahwa8bydVlP447moPwNSW
         Np2/Z3zulHY/Q9CTVYLEnY0Ar/V64JbJyvyTgQh+h1nthmPL3RUA7Z88HzVLazgSEq
         RrlVv7Oe5PKeg==
From:   Lukasz Majewski <lukma@denx.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Stephen Kitt <steve@sk2.org>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v3 1/3] ASoC: wm8940: Remove warning when no plat data present
Date:   Fri, 16 Dec 2022 10:46:22 +0100
Message-Id: <20221216094624.3849278-1-lukma@denx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lack of platform data in the contemporary Linux
shall not be the reason to display warnings to the
kernel logs.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

---
Changes for v2:
- None
Changes for v3:
- None
---
 sound/soc/codecs/wm8940.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index 8dac9fd88547..0b59020d747f 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -709,9 +709,7 @@ static int wm8940_probe(struct snd_soc_component *component)
 	if (ret < 0)
 		return ret;
 
-	if (!pdata)
-		dev_warn(component->dev, "No platform data supplied\n");
-	else {
+	if (pdata) {
 		reg = snd_soc_component_read(component, WM8940_OUTPUTCTL);
 		ret = snd_soc_component_write(component, WM8940_OUTPUTCTL, reg | pdata->vroi);
 		if (ret < 0)
-- 
2.20.1

