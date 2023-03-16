Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC73F6BCF66
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjCPM2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjCPM16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:27:58 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656366BC33;
        Thu, 16 Mar 2023 05:27:56 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 912291BF212;
        Thu, 16 Mar 2023 12:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678969675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cgavJDYqAWGIAp5BiGO9sOYQn1s1K0nDOa7y/oa06lI=;
        b=kMNJwkwIWZUd7PR2gbTggNSgppd16lsjL+yAZAM8MK4iF2tOS36r8ycPhRxaTtXPHIbPFK
        RQyOBUb9F8XD/2yMd15f0nL3zH/y+6BkZEiYMMwaOsCTnfCVDqvJLMfsDc1tFAj1lKsk0o
        XQyMBYB6XvhMUJzbmPjc10eCZC33esiGpr8nB/eoqC/Ub1kAl75uZJ1fn0dpCw8lqI1XCs
        O7lJo7ose6FEBRT3TdXhn/H08Fy2+RVJdgDlb9oeNAWPu8hPNtlMPTHnH9xPN9rwtdWRuG
        2wi4g60ZR9y9pTuJNfX1L28f2PthKs6C3lYTEMYtC9VFLrWFGOmE7yQv2QPFsA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 0/7] Add the Lantiq PEF2256 audio support
Date:   Thu, 16 Mar 2023 13:27:34 +0100
Message-Id: <20230316122741.577663-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

This v2 series fixes issues raised by the kernel test robot
  - devm_platform_ioremap_resource symbol undefined
  - duplicate const qualifier
  - Block quote ends without a blank line

Best regards,
Herve Codina

Changes v1 -> v2
  - Patch 2
    Remove duplicate const qualifiers.
    Add HAS_IOMEM as a dependency

  - Patch 3
    Fix a "Block quote ends without a blank line; unexpected unindent"
    syntax issue.

Herve Codina (7):
  dt-bindings: misc: Add the Lantiq  PEF2466 E1/T1/J1 framer
  drivers: misc: Add support for the Lantiq PEF2256 framer
  Documentation: sysfs: Document the Lantiq PEF2256 sysfs entry
  MAINTAINERS: Add the Lantiq PEF2256 driver entry
  dt-bindings: sound: Add support for the Lantiq PEF2256 codec
  ASoC: codecs: Add support for the Lantiq PEF2256 codec
  MAINTAINERS: Add the Lantiq PEF2256 ASoC codec entry

 .../sysfs-bus-platform-devices-pef2256        |   12 +
 .../bindings/misc/lantiq,pef2256.yaml         |  190 +++
 .../bindings/sound/lantiq,pef2256-codec.yaml  |   57 +
 MAINTAINERS                                   |   15 +
 drivers/misc/Kconfig                          |   17 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/pef2256.c                        | 1441 +++++++++++++++++
 include/linux/pef2256.h                       |   36 +
 sound/soc/codecs/Kconfig                      |   14 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/pef2256-codec.c              |  395 +++++
 11 files changed, 2180 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-devices-pef2256
 create mode 100644 Documentation/devicetree/bindings/misc/lantiq,pef2256.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
 create mode 100644 drivers/misc/pef2256.c
 create mode 100644 include/linux/pef2256.h
 create mode 100644 sound/soc/codecs/pef2256-codec.c

-- 
2.39.2

