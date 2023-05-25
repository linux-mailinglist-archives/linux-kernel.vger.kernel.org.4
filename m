Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B297116DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243081AbjEYS5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243246AbjEYSy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:54:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AAB44B4;
        Thu, 25 May 2023 11:46:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C3D66491B;
        Thu, 25 May 2023 18:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51501C433EF;
        Thu, 25 May 2023 18:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040242;
        bh=4bhTm7PBxHSblzpN5rEwaZBvDvGv0Z2niSBZkR66B+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V6heRpsGlLADz7D+T+Tmq+TDDBgnkDR4tgzlv82zyXY3klXIetZxVJ+3Y6+BkPKF1
         IrZJAx6+eWfsXFGJMM1qZtA9WizvXomCQXdsjMLp30hQmhOElISG83ZWAxD3PWMy5Q
         TgmPo36IhwKI7+2DK1AzCxtuRsHwoMgxafCn94nffUBCyRsEE68Ui9saIrbwHL/K4j
         sgmJKOqzhmmzs6ytTJayRjDB0L51t8qWcGsmfojbJW2mdbjbdWPvYCuqw/BkpN2DRT
         r5Z86bi1QIqWXHpDANnU1Z+qbfFHqRrOdm4lK+Kohk/pHARrjCRs9HypYAb1/FDMe8
         LgYm/MdiWJq7w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>,
        Sasha Levin <sashal@kernel.org>, lars@metafoo.de,
        nuno.sa@analog.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 03/27] ASoC: ssm2602: Add workaround for playback distortions
Date:   Thu, 25 May 2023 14:43:29 -0400
Message-Id: <20230525184356.1974216-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525184356.1974216-1-sashal@kernel.org>
References: <20230525184356.1974216-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paweł Anikiel <pan@semihalf.com>

[ Upstream commit f63550e2b165208a2f382afcaf5551df9569e1d4 ]

Apply a workaround for what appears to be a hardware quirk.

The problem seems to happen when enabling "whole chip power" (bit D7
register R6) for the very first time after the chip receives power. If
either "output" (D4) or "DAC" (D3) aren't powered on at that time,
playback becomes very distorted later on.

This happens on the Google Chameleon v3, as well as on a ZYBO Z7-10:
https://ez.analog.com/audio/f/q-a/543726/solved-ssm2603-right-output-offset-issue/480229
I suspect this happens only when using an external MCLK signal (which
is the case for both of these boards).

Here are some experiments run on a Google Chameleon v3. These were run
in userspace using a wrapper around the i2cset utility:
ssmset() {
        i2cset -y 0 0x1a $(($1*2)) $2
}

For each of the following sequences, we apply power to the ssm2603
chip, set the configuration registers R0-R5 and R7-R8, run the selected
sequence, and check for distortions on playback.

  ssmset 0x09 0x01 # core
  ssmset 0x06 0x07 # chip, out, dac
  OK

  ssmset 0x09 0x01 # core
  ssmset 0x06 0x87 # out, dac
  ssmset 0x06 0x07 # chip
  OK

  (disable MCLK)
  ssmset 0x09 0x01 # core
  ssmset 0x06 0x1f # chip
  ssmset 0x06 0x07 # out, dac
  (enable MCLK)
  OK

  ssmset 0x09 0x01 # core
  ssmset 0x06 0x1f # chip
  ssmset 0x06 0x07 # out, dac
  NOT OK

  ssmset 0x06 0x1f # chip
  ssmset 0x09 0x01 # core
  ssmset 0x06 0x07 # out, dac
  NOT OK

  ssmset 0x09 0x01 # core
  ssmset 0x06 0x0f # chip, out
  ssmset 0x06 0x07 # dac
  NOT OK

  ssmset 0x09 0x01 # core
  ssmset 0x06 0x17 # chip, dac
  ssmset 0x06 0x07 # out
  NOT OK

For each of the following sequences, we apply power to the ssm2603
chip, run the selected sequence, issue a reset with R15, configure
R0-R5 and R7-R8, run one of the NOT OK sequences from above, and check
for distortions.

  ssmset 0x09 0x01 # core
  ssmset 0x06 0x07 # chip, out, dac
  OK

  (disable MCLK)
  ssmset 0x09 0x01 # core
  ssmset 0x06 0x07 # chip, out, dac
  (enable MCLK after reset)
  NOT OK

  ssmset 0x09 0x01 # core
  ssmset 0x06 0x17 # chip, dac
  NOT OK

  ssmset 0x09 0x01 # core
  ssmset 0x06 0x0f # chip, out
  NOT OK

  ssmset 0x06 0x07 # chip, out, dac
  NOT OK

Signed-off-by: Paweł Anikiel <pan@semihalf.com
Link: https://lore.kernel.org/r/20230508113037.137627-8-pan@semihalf.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/ssm2602.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 501a4e73b185b..06f382c794b26 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -67,6 +67,18 @@ static const struct reg_default ssm2602_reg[SSM2602_CACHEREGNUM] = {
 	{ .reg = 0x09, .def = 0x0000 }
 };
 
+/*
+ * ssm2602 register patch
+ * Workaround for playback distortions after power up: activates digital
+ * core, and then powers on output, DAC, and whole chip at the same time
+ */
+
+static const struct reg_sequence ssm2602_patch[] = {
+	{ SSM2602_ACTIVE, 0x01 },
+	{ SSM2602_PWR,    0x07 },
+	{ SSM2602_RESET,  0x00 },
+};
+
 
 /*Appending several "None"s just for OSS mixer use*/
 static const char *ssm2602_input_select[] = {
@@ -577,6 +589,9 @@ static int ssm260x_component_probe(struct snd_soc_component *component)
 		return ret;
 	}
 
+	regmap_register_patch(ssm2602->regmap, ssm2602_patch,
+			      ARRAY_SIZE(ssm2602_patch));
+
 	/* set the update bits */
 	regmap_update_bits(ssm2602->regmap, SSM2602_LINVOL,
 			    LINVOL_LRIN_BOTH, LINVOL_LRIN_BOTH);
-- 
2.39.2

