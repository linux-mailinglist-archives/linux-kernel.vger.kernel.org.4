Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC006C4C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjCVNrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjCVNrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:47:12 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7365848B;
        Wed, 22 Mar 2023 06:47:08 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id B255D20002;
        Wed, 22 Mar 2023 13:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679492827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=T+MhMxWN1EUNsUGAqTUd7ORZBQVY4DIgA/LbY8h2In0=;
        b=d9eFJ8qIFHG3s/7lo5O1t9AiUIXS/4ZUEyfp+tzQ9976UAktovkfqzEGD8xOn/fzTqL4CG
        5y3SCAp6cYVxYtVIIefgvvUQreBEwopg5RWMI7l5oFV5068w9x1EMCbrjy6upqRKlMy1Z9
        ZBFpQmLTkZK8u+ovPmMkl7xFlcad7OjB9r//PoFz2IYHrVF1+5I0LPiYjg56gn5vfALPf1
        amWGAmOYhCq6IoRW5IKeDorbZIHUCojBhwaqeMRayWjLPQldSnPmx7vzDnVIGMdCJeorqA
        WTYhOG4JBD2bUGOBMjvqTF9SeDfaQmRkBpDlaAEiMseeQ0MKPN+Q1I4DPvfkpQ==
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
Subject: [PATCH v3 0/6] Add the Lantiq PEF2256 audio support
Date:   Wed, 22 Mar 2023 14:46:48 +0100
Message-Id: <20230322134654.219957-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

The first part of this series (patches 1 to 4) adds the Lantiq PEF2256
driver core.
The second part (patches 5 to 7) adds the audio support using the Lantiq
PEF2256 driver core.

The consumer/provider relation between the codec and the driver core
allows to use the PEF2256 framer for other purpose than audio support.

Compared to the previous iteration
  https://lore.kernel.org/linux-kernel/20230316122741.577663-1-herve.codina@bootlin.com/
This v3 series mainly:
  - takes into account pef2256.c modifications suggested by Christophe.
  - fixes binding
  - Moves to MFD.
  - Merges MAINTAINERS entries

Best regards,
Herve Codina

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

Herve Codina (6):
  dt-bindings: mfd: Add the Lantiq  PEF2256 E1/T1/J1 framer
  mfd: Add support for the Lantiq PEF2256 framer
  Documentation: sysfs: Document the Lantiq PEF2256 sysfs entry
  dt-bindings: sound: Add support for the Lantiq PEF2256 codec
  ASoC: codecs: Add support for the Lantiq PEF2256 codec
  MAINTAINERS: Add the Lantiq PEF2256 driver entry

 .../sysfs-bus-platform-devices-pef2256        |   12 +
 .../bindings/mfd/lantiq,pef2256.yaml          |  205 +++
 .../bindings/sound/lantiq,pef2256-codec.yaml  |   54 +
 MAINTAINERS                                   |   10 +
 drivers/mfd/Kconfig                           |   16 +
 drivers/mfd/Makefile                          |    1 +
 drivers/mfd/pef2256.c                         | 1355 +++++++++++++++++
 include/linux/mfd/pef2256.h                   |   28 +
 sound/soc/codecs/Kconfig                      |   14 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/pef2256-codec.c              |  390 +++++
 11 files changed, 2087 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-devices-pef2256
 create mode 100644 Documentation/devicetree/bindings/mfd/lantiq,pef2256.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
 create mode 100644 drivers/mfd/pef2256.c
 create mode 100644 include/linux/mfd/pef2256.h
 create mode 100644 sound/soc/codecs/pef2256-codec.c

-- 
2.39.2

