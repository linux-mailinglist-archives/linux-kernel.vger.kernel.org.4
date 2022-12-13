Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7088264B2CA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbiLMJxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbiLMJxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:53:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530AB2604
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:53:41 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <r.czerwinski@pengutronix.de>)
        id 1p51yd-0000ec-M5; Tue, 13 Dec 2022 10:53:31 +0100
From:   Rouven Czerwinski <r.czerwinski@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     kernel@pengutronix.de, Marco Felsch <m.felsch@pengutronix.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: max98088: fix initial dai mute state
Date:   Tue, 13 Dec 2022 10:53:28 +0100
Message-Id: <20221213095328.122309-2-r.czerwinski@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221213095328.122309-1-r.czerwinski@pengutronix.de>
References: <20221213095328.122309-1-r.czerwinski@pengutronix.de>
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

According the datasheets [1], [2] the initial value of register
0x2f/0x31 (dai1/dai2) is 0x00 which means that dai is unmuted. So upon
the first playback request the register is not touched since it is
cached by regmap. But the device output keeps silent. After ending the
playback session the mute() callback updates the register. Now the 2nd
playback request updates the register again (-> unmute the device) and
now we can really hear the output signal.

I've checked the register initial value which is '0x00' so the driver is
correct. Accroding the above inspections it seems that the hardware does
not update the register correctly on power up because the output is
muted.

To fix that we need to explicit set the mute state. Now the first
playback request gets played correctly.

[1] https://datasheets.maximintegrated.com/en/ds/MAX98089.pdf
[2] https://datasheets.maximintegrated.com/en/ds/MAX98088.pdf

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 sound/soc/codecs/max98088.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 7f108e147355..c00d7726ac04 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1710,6 +1710,11 @@ static int max98088_probe(struct snd_soc_component *component)
        snd_soc_component_write(component, M98088_REG_1E_DAI2_IOCFG,
                M98088_S2NORMAL|M98088_SDATA);
 
+       snd_soc_component_update_bits(component, M98088_REG_2F_LVL_DAI1_PLAY,
+               M98088_DAI_MUTE_MASK, M98088_DAI_MUTE);
+       snd_soc_component_update_bits(component, M98088_REG_31_LVL_DAI2_PLAY,
+               M98088_DAI_MUTE_MASK, M98088_DAI_MUTE);
+
        max98088_handle_pdata(component);
 
 err_access:
-- 
2.38.1

