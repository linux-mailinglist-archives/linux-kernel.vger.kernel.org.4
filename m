Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205EE72C420
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjFLMaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjFLMaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:30:00 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EAC1AD;
        Mon, 12 Jun 2023 05:29:56 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686572995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=p4tcOdHX+ungtSgc31Cpu7UkGmJ60srYPCpwdKdyR2A=;
        b=jDQ9H2B05hirZBSuJyug3dIWqyPrUunC1IAyDPWNpsUzpreBIhWKQn+nGG/aegcS65R+6C
        GudUQH0K9QQEhxRscRm2LFI2zruqmLWFkSEL4JYw7A0Nn7vD2GI6/oTcAGKKvpwTycenyu
        1qpcPQiEySFlk62Kz2XbXqR9NQJ5Bu0MAxw1WdSlYlgSgPxz09e2uX7r4UxFNmCUinpiKt
        oBGH7eHRmCzyzhpA17b2alNTf4sTZwiQqmvmBsRmciPHiAO8nAapYkWaHT22aHvOoqzAFU
        V0ruqXLDab7VpS2Ub+vKeadi3UUX6N2crrEpVpxJfV0VGSFy2eSfn5RoKTWPdQ==
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 2573B240015;
        Mon, 12 Jun 2023 12:29:51 +0000 (UTC)
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 00/12] Add support for IIO devices in ASoC
Date:   Mon, 12 Jun 2023 14:29:14 +0200
Message-Id: <20230612122926.107333-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several weeks ago, I sent a series [1] for adding a potentiometer as an
auxiliary device in ASoC. The feedback was that the potentiometer should
be directly handled in IIO (as other potentiometers) and something more
generic should be present in ASoC in order to have a binding to import
some IIO devices into sound cards.

The series related to the IIO potentiometer device is already applied.

This series introduces audio-iio-aux. Its goal is to offer the binding
between IIO and ASoC.
It exposes attached IIO devices as ASoC auxiliary devices and allows to
control them through mixer controls.

On my system, the IIO device is a potentiometer and it is present in an
amplifier design present in the audio path.

Compare to the previous iteration
  https://lore.kernel.org/linux-kernel/20230523151223.109551-1-herve.codina@bootlin.com/
This v3 series mainly:
 - Reworks/Simplifies some IIO code.
 - Reworks/Simplified the audio-iio-aux driver.
 - Removes an already applied patch.

Best regards,
Hervé

[1] https://lore.kernel.org/linux-kernel/20230203111422.142479-1-herve.codina@bootlin.com/
[2] https://lore.kernel.org/linux-kernel/20230421085245.302169-1-herve.codina@bootlin.com/

Changes v2 -> v3
  - Patches 1, 2
    No changes.

  - Patch 3, 4
    Add 'Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>'.

  - Patch 5 (new in v3)
    Removed the 'unused' variable and check the null pointer when used.

  - Patch 6 (new in v3)
    Introduce {min,max}_array().

  - Patch 7 (new in v3)
    Use max_array() in iio_channel_read_max().

  - Patch 8 (new in v3)
    Replace a FIXME comment by a TODO one.

  - Patch 9 (patch 5 in v2)
    Removed the 'unused' variable and check the null pointer when used.
    Use min_array().
    Remplace a FIXME comment by a TODO one.

  - Patch 10 (patch 6 in v2)
    Convert existing macros to return a compound litteral instead of
    adding a new helper.

  - Patch 11 (patch 7 in v2)
    Remove the file name from the C file header.
    Use directly converted DAPM macros.
    Replace <linux/module.h> by <linux/mod_devicetable.h>.
    Add <linux/platform_device.h>.
    Be sure that min <= max. Swap values if it is not the case.
    Move the bool structure member after the int ones.
    Remove unneeded assignements.
    Use dev_err_probe() when relevant.
    Use str_on_off().
    Use static_assert() instead of BUILD_BUG_ON().
    Remove unneeded comma and blank line.
    Use device_property_*() instead of the OF API.

  - patch 8 available in v2 removed as already applied

  - Patch 12 (patch 9 in v2)
    Use devm_add_action_or_reset().
    Call simple_populate_aux() from simple_parse_of().

Changes v1 -> v2
  - Patch 1
    Rename simple-iio-aux to audio-iio-aux
    Rename invert to snd-control-invert-range
    Remove the /schemas/iio/iio-consumer.yaml reference
    Remove the unneeded '|' after description

  - Patch 2 (new in v2)
    Introduce the simple-audio-card additional-devs subnode

  - Patch 3 (new in v2)
    Check err before switch() in iio_channel_read_max()

  - Patch 4 (new in v2)
    Fix raw reads and raw writes documentation

  - Patch 5 (patch 2 in v1)
    Check err before switch() in iio_channel_read_min()
    Fix documentation

  - Patch 6 (path 3 in v1)
    No changes

  - Patch 7 (patch 4 in v1)
    Rename simple-iio-aux to audio-iio-aux
    Rename invert to snd-control-invert-range
    Remove the mask usage from audio_iio_aux_{get,put}_volsw helpers
    Use directly PTR_ERR() in dev_err_probe() parameter
    Remove the '!!' construction
    Remove of_match_ptr()

  - Patch 8 (new in v2)
    Add a missing of_node_put() in the simple-card driver

  - Patch 9 (new in v2)
    Handle additional-devs in the simple-card driver

Herve Codina (12):
  ASoC: dt-bindings: Add audio-iio-aux
  ASoC: dt-bindings: simple-card: Add additional-devs subnode
  iio: inkern: Check error explicitly in iio_channel_read_max()
  iio: consumer.h: Fix raw values documentation notes
  iio: inkern: Remove the 'unused' variable usage in
    iio_channel_read_max()
  minmax: Introduce {min,max}_array()
  iio: inkern: Use max_array() to get the maximum value from an array
  iio: inkern: Replace a FIXME comment by a TODO one
  iio: inkern: Add a helper to query an available minimum raw value
  ASoC: soc-dapm.h: Convert macros to return a compound litteral
  ASoC: codecs: Add support for the generic IIO auxiliary devices
  ASoC: simple-card: Handle additional devices

 .../bindings/sound/audio-iio-aux.yaml         |  64 ++++
 .../bindings/sound/simple-card.yaml           |  53 +++
 drivers/iio/inkern.c                          |  84 ++++-
 include/linux/iio/consumer.h                  |  37 +-
 include/linux/minmax.h                        |  26 ++
 include/sound/soc-dapm.h                      | 138 +++++---
 sound/soc/codecs/Kconfig                      |  12 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/audio-iio-aux.c              | 334 ++++++++++++++++++
 sound/soc/generic/simple-card.c               |  46 ++-
 10 files changed, 726 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/audio-iio-aux.yaml
 create mode 100644 sound/soc/codecs/audio-iio-aux.c

-- 
2.40.1

