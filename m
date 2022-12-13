Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C5664B2C9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbiLMJxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbiLMJxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:53:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003F72604
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:53:37 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <r.czerwinski@pengutronix.de>)
        id 1p51yc-0000eF-QL; Tue, 13 Dec 2022 10:53:30 +0100
From:   Rouven Czerwinski <r.czerwinski@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     kernel@pengutronix.de, Marco Felsch <m.felsch@pengutronix.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: max98088: fix dai1/2_hw_params access
Date:   Tue, 13 Dec 2022 10:53:27 +0100
Message-Id: <20221213095328.122309-1-r.czerwinski@pengutronix.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: r.czerwinski@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Felsch <m.felsch@pengutronix.de>

According the reference manuals [1], [2] updating register 0x14/1c
should only be done after #shdn bit is set to 0.

[1] https://datasheets.maximintegrated.com/en/ds/MAX98089.pdf
[2] https://datasheets.maximintegrated.com/en/ds/MAX98088.pdf

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 sound/soc/codecs/max98088.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 405ec16be2b6..7f108e147355 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -977,6 +977,8 @@ static int max98088_dai1_hw_params(struct snd_pcm_substream *substream,
 
        rate = params_rate(params);
 
+       snd_soc_component_update_bits(component, M98088_REG_51_PWR_SYS, M98088_SHDNRUN, 0);
+
        switch (params_width(params)) {
        case 16:
                snd_soc_component_update_bits(component, M98088_REG_14_DAI1_FORMAT,
@@ -990,8 +992,6 @@ static int max98088_dai1_hw_params(struct snd_pcm_substream *substream,
                return -EINVAL;
        }
 
-       snd_soc_component_update_bits(component, M98088_REG_51_PWR_SYS, M98088_SHDNRUN, 0);
-
        if (rate_value(rate, &regval))
                return -EINVAL;
 
@@ -1047,6 +1047,8 @@ static int max98088_dai2_hw_params(struct snd_pcm_substream *substream,
 
        rate = params_rate(params);
 
+       snd_soc_component_update_bits(component, M98088_REG_51_PWR_SYS, M98088_SHDNRUN, 0);
+
        switch (params_width(params)) {
        case 16:
                snd_soc_component_update_bits(component, M98088_REG_1C_DAI2_FORMAT,
@@ -1060,8 +1062,6 @@ static int max98088_dai2_hw_params(struct snd_pcm_substream *substream,
                return -EINVAL;
        }
 
-       snd_soc_component_update_bits(component, M98088_REG_51_PWR_SYS, M98088_SHDNRUN, 0);
-
        if (rate_value(rate, &regval))
                return -EINVAL;
 
-- 
2.38.1

