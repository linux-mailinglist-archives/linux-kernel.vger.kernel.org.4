Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C468A728AF4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbjFHWLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjFHWLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:11:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71AA30CB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:11:13 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BCF7B6606F23;
        Thu,  8 Jun 2023 23:11:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686262272;
        bh=MDBZeXdHxayRyS4HwOUAnoANgtBHjjiq1WAz2EToM+0=;
        h=From:To:Cc:Subject:Date:From;
        b=WqhUYjWmCpd1dCEdct42PjQYQdjK/MTgTVFEqw9GlBGiPRn69tuZjalqGNMKov9gv
         xkEpE6yHOhOsmawys7tpxQNCy+uv18DLMQEy3EEsv99xR1zSvHPrnBvNu65h2v0b6W
         QSOQldd85Cep/F0wHfsRBlVnOIPkpJ7rObmGd3AblG5zOicd2Y8PFGQ7Nj/1W989Fj
         FjwfmDKR9ENXLfkuf9eTbjoNC6uHIjCfgvyCgoUh7t4JveaNegr4Q6/VZgfUG8yvpH
         r254Pw2exOXCdDGAyBsPAHo1zia+8AC8i/DlkBldMRds9F4VdDNE9i9VJElrX86lY7
         tvf0pouue6NdQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] Revert "ASoC: mediatek: mt8192-mt6359: Remove " Jack" from Headphone pin name"
Date:   Thu,  8 Jun 2023 18:10:48 -0400
Message-ID: <20230608221050.217968-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit cbbc0ec6dea09c815f1d1ef0abaf3f2ec89ff11f. That
commit removed the " Jack" suffix with the reasoning that it is
automatically added to the name of the kcontrol created, which is true,
but this name is also used to look for the DAPM widget that will be
toggled when the jack status is updated. Since the widget is still
called "Headphone Jack" the jack can't link to the widget and the
following error is shown:

mt8192_mt6359 sound: ASoC: DAPM unknown pin Headphone

It is not possible to also rename the headphone DAPM widget because its
name is used by a switch kcontrol, "Headphone Jack Switch", both to link
to the headphone widget and to assemble its name. This switch's name is
referenced in the upstream UCM file, so renaming it would break
userspace. Since the original commit didn't bring any benefit, besides
sparing a few CPU cycles, simply revert it.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index 4e0d5bf12b47..5e163e23a207 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -46,7 +46,7 @@ struct mt8192_mt6359_priv {
 /* Headset jack detection DAPM pins */
 static struct snd_soc_jack_pin mt8192_jack_pins[] = {
 	{
-		.pin = "Headphone",
+		.pin = "Headphone Jack",
 		.mask = SND_JACK_HEADPHONE,
 	},
 	{
-- 
2.41.0

