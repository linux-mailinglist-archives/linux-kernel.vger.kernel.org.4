Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12EE5B3A07
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiIINy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiIINyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:54:45 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDB95FCC;
        Fri,  9 Sep 2022 06:54:39 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1662731675; bh=vvgm+GqZsmNcWfwWCumfisqYaU3KbPkkcPy5f1+JRsw=;
        h=From:To:Cc:Subject:Date;
        b=ik+mdjObq086ky4rULYWxtQ2Myx3k5g3QjA05uzvdcWTyisZsJXvfIy8VSneJwOVu
         jKHxKkeGroY6LtViBsL1/1mkDu8Qls/mDEx6P/fGMSOOrSqopSxeoNHbjDXw0rMCLs
         WBrTKlv2dagBj+RpfKz6s88bzz5LWebeWdkFrumI=
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Matt Flax <flatmax@flatmax.com>,
        - <patches@opensource.cirrus.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: [PATCH 00/10] Support for CS42L83 on Apple machines
Date:   Fri,  9 Sep 2022 15:53:24 +0200
Message-Id: <20220909135334.98220-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

there's a CS42L83 headphone jack codec found in Apple computers (in the
recent 'Apple Silicon' ones as well as in earlier models, one example
[1]). The part isn't publicly documented, but it appears almost
identical to CS42L42, for which we have a driver in kernel. This series
adapts the CS42L42 driver to the new part, and makes one change in
anticipation of a machine driver for the Apple computers.

Patch 1 adds new compatible to the cs42l42 schema.

Patches 2 to 7 are taken from Richard's recent series [2] adding
soundwire support to cs42l42. They are useful refactorings to build on
in later patches, and also this way our work doesn't diverge. I made
one fix: I added a call of common_remove at the end of i2c_probe should
the cs42l42_init call fail (both before and after the split to
cs42l42-i2c.c). Also s/Soundwire/SoundWire/ in the changelogs.

Patch 8 exports some regmap-related symbols from cs42l42.c so they can
be used to create cs42l83 regmap in cs42l83-i2c.c later.

Patch 9 is the cs42l83 support proper.

Patch 10 implements 'set_bclk_ratio' on the cs42l42 core. This will be
called by the upcoming ASoC machine driver for 'Apple Silicon' Macs.
(We have touched on this change to be made in earlier discussion, see
 [3] and replies.)

Best,
Martin

[1] https://www.ifixit.com/Teardown/MacBook+Pro+13-Inch+Touch+Bar+2018+Teardown/111384
[2] https://lore.kernel.org/alsa-devel/20220819125230.42731-1-rf@opensource.cirrus.com/T/#mc05cc6898be2c23fe2e7c8bb4ea4e4a00c1912a7
[3] https://lore.kernel.org/asahi/8961DDD2-93FF-4A18-BCA2-90FCE298F517@cutebit.org/


Martin Povišer (5):
  ASoC: dt-bindings: cs42l42: Add 'cs42l83' compatible
  ASoC: cs42l42: Split probe() and remove() into stages
  ASoC: cs42l42: Export regmap elements to the core namespace
  ASoC: cs42l83: Extend CS42L42 support to new part
  ASoC: cs42l42: Implement 'set_bclk_ratio'

Richard Fitzgerald (5):
  ASoC: cs42l42: Add bitclock frequency argument to cs42l42_pll_config()
  ASoC: cs42l42: Use cs42l42->dev instead of &i2c_client->dev
  ASoC: cs42l42: Split cs42l42_resume into two functions
  ASoC: cs42l42: Pass component and dai defs into common probe
  ASoC: cs42l42: Split I2C identity into separate module

 .../bindings/sound/cirrus,cs42l42.yaml        |   1 +
 MAINTAINERS                                   |   1 +
 include/sound/cs42l42.h                       |   1 +
 sound/soc/codecs/Kconfig                      |  15 +-
 sound/soc/codecs/Makefile                     |   6 +-
 sound/soc/codecs/cs42l42-i2c.c                | 112 ++++++++
 sound/soc/codecs/cs42l42.c                    | 256 +++++++++---------
 sound/soc/codecs/cs42l42.h                    |  24 +-
 sound/soc/codecs/cs42l83-i2c.c                | 248 +++++++++++++++++
 9 files changed, 538 insertions(+), 126 deletions(-)
 create mode 100644 sound/soc/codecs/cs42l42-i2c.c
 create mode 100644 sound/soc/codecs/cs42l83-i2c.c

-- 
2.33.0

