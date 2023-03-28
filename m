Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3966CB895
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjC1Hsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjC1Hs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:48:26 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD8DB6;
        Tue, 28 Mar 2023 00:48:20 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id B1DDEC0015;
        Tue, 28 Mar 2023 07:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679989699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1ra6y+AOsjCKVGVTCm8CNnJ9h/NXXUDD/iFVgjYHCHU=;
        b=MQn4hU2tWWgcFfc/lYVz46alWMi4ypGTDGnZvq81m+vukUZdyWIEkHZWIfrWbt0gqrTQFj
        OoOfhDckgDPQwkd+/0nLCF6xgmzbAYitDbvq/f3SVZ3TP9/RdLMD/GJBtZFSxhiWx/FJO4
        y85kDZ/A0Is5pbuNa3P/TQnEb7jm51HUgk938/hpk7WeK9epKa4P2qHn76AEUHuYQWBV8N
        nt/ks7lCz1k0pmhxf5BlkBYebxGv2CQe12PcMGpCxNbq6mfzPuk134/eRFhyP/8Nr0bAjB
        hDVHtLR6F1LWAxFJwZXbexjYKu434w2+WCwyyKo6+KfjhS4Y9nFRjkuSuHZKiQ==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 0/5] Add the Lantiq PEF2256 audio support
Date:   Tue, 28 Mar 2023 09:48:06 +0200
Message-Id: <20230328074811.594361-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for audio using the Lantiq PEF2256 framer.

The Lantiq PEF2256 is a framer and line interface component designed to
fulfill all required interfacing between an analog E1/T1/J1 line and the
digital PCM system highway/H.100 bus.

The first part of this series (patches 1 to 3) adds the Lantiq PEF2256
driver core.
The second part (patch 4) adds the audio support using the Lantiq
PEF2256 driver core.
The last patch adds myself as the PEF2256 maintainer.

The consumer/provider relation between the codec and the driver core
allows to use the PEF2256 framer for other purpose than audio support.

Compared to the previous iteration
  https://lore.kernel.org/linux-kernel/20230322134654.219957-1-herve.codina@bootlin.com/
This v4 series mainly:
  - Drops the of_match_ptr() usage
  - Fixes a kernel test robot error
  - Merge the codec sub-node binding into the pef2256 binding.
  - Use a more a complete DT example.

Best regards,
Herve Codina

Changes v3 -> v4
  - Patch 1
    Merge the codec sub-node description.
    Move the 'allOf' property after the 'required' property.
    Rework the example to be more complete.

  - Patches 2 and 5
    Drop of_match_ptr()

  - Patch 2
    Add 'depends on OF' as pinconf_generic_dt_node_to_map_pin() needs OF
    support to be compiled (error raised by the kernel test robot).

  - Patch 4
    Remove patch (merged in patch 1)

Changes v2 -> v3
  - Patch 1
    Remove unneeded 'allOf' and quotes.
    Add several 'additionalProperties: false'
    Fix example (node name, interrupts and reg properties)
    Replace the lantiq,sysclk-rate-hz property by sclkr and sclkx clocks.
    Define 'lantiq,frame-format' property in top level.
    Move to MFD

  - Patch 2
    Fix some #define.
    Compact the register accessor helpers.
    Rework pef2256_get_version().
    Merge v1.2 and v2.x GCM setup functions into one pef2256_setup_gcm().
    Update comments, avoid duplicates and change some conditionals.
    Remove the carrier spinlock and use atomic_t.
    Make exported symbol consistent and use EXPORT_SYMBOL_GPL.
    Remove the no more needed pef2256_get_byphandle() and
    devm_pef2256_get_byphandle().
    Replace the lantiq,sysclk-rate-hz property by sclkr and sclkx clocks.
    Move to MFD

  - Patch 4
    Remove, merged with patch 7

  - Patch 4 (patch 5 in v2)
    Update title and description.
    Remove incorrect SPI reference.
    Remove the 'lantiq,pef2256' phandle.
    Fix commit log

  - Patch 5 (patch 6 in v2)
    Remove devm_pef2256_get_byphandle().
    Fix commit log

  - Patch 6 (patch 7 in v2)
    Merge v2 patch 4. One entry only for PEF2256

Changes v1 -> v2
  - Patch 2
    Remove duplicate const qualifiers.
    Add HAS_IOMEM as a dependency

  - Patch 3
    Fix a "Block quote ends without a blank line; unexpected unindent"
    syntax issue.

Herve Codina (5):
  dt-bindings: mfd: Add the Lantiq  PEF2256 E1/T1/J1 framer
  mfd: Add support for the Lantiq PEF2256 framer
  Documentation: sysfs: Document the Lantiq PEF2256 sysfs entry
  ASoC: codecs: Add support for the Lantiq PEF2256 codec
  MAINTAINERS: Add the Lantiq PEF2256 driver entry

 .../sysfs-bus-platform-devices-pef2256        |   12 +
 .../bindings/mfd/lantiq,pef2256.yaml          |  270 ++++
 MAINTAINERS                                   |    9 +
 drivers/mfd/Kconfig                           |   17 +
 drivers/mfd/Makefile                          |    1 +
 drivers/mfd/pef2256.c                         | 1355 +++++++++++++++++
 include/linux/mfd/pef2256.h                   |   28 +
 sound/soc/codecs/Kconfig                      |   14 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/pef2256-codec.c              |  390 +++++
 10 files changed, 2098 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-devices-pef2256
 create mode 100644 Documentation/devicetree/bindings/mfd/lantiq,pef2256.yaml
 create mode 100644 drivers/mfd/pef2256.c
 create mode 100644 include/linux/mfd/pef2256.h
 create mode 100644 sound/soc/codecs/pef2256-codec.c

-- 
2.39.2

