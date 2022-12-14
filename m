Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1732B64C928
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbiLNMjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238280AbiLNMjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:39:24 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7150E1EEDA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:38:07 -0800 (PST)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 3F7BC85104;
        Wed, 14 Dec 2022 13:38:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671021485;
        bh=/73in4YIE8G8CYnWx0Er3I9VVvTCTYIHLYd83My0KlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y1lyj8rztDUuWEwQvfddAazUNzjyPhv/ZgvWDuX5GQCWDOp3PCgGI1rbRYGxFtsu3
         QFYHzd4roZ/kNz6LwXfmJv6YvE9wvRQEaiFKwoyJSfyU+3zN1s2YEbUWAt+KOYvhuc
         p2mLHdtMOFJm+vKFyvwyosBmLApcxNNTYfdJXbq27gvmh28aKAAC9xvLAxQu1R4lOa
         KwtLykZhJc4yy4EkrM5J7pJhwy3eajOTRDufW6MFXFyXy8mydRkMRjWvPLc2jvIa7Y
         TXL9iGNDHv3M1/z9mz7N11xQIAYC/aqtuDglNmpI74DZ5bR2ySJ0qMeT14c2euyYcu
         147ezol8DSALQ==
From:   Lukasz Majewski <lukma@denx.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Stephen Kitt <steve@sk2.org>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 1/4] ASoC: wm8940: Remove warning when no plat data present
Date:   Wed, 14 Dec 2022 13:37:40 +0100
Message-Id: <20221214123743.3713843-2-lukma@denx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221214123743.3713843-1-lukma@denx.de>
References: <20221214123743.3713843-1-lukma@denx.de>
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

