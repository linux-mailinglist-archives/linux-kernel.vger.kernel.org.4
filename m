Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8825F71A316
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbjFAPsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbjFAPr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:47:56 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E164413D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:47:53 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3515TBgv016524;
        Thu, 1 Jun 2023 10:47:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=bdWsE9aVcmlFMt82dUiPp2zt+xLfnmMuI7ekR9LlaWs=;
 b=SR1x4xhpDx3tVuwOtdtGYIT5lFVZp22J1/KKtHmwPNXQO7rX+i7GgMcdavKZGjRuk27W
 ephmVJys/HsnkC8vqEnmC3i3Yckd1p2MoY3b/FAhFVxlFp2NnVp+ow5izI7h16s+GSo0
 0DoNIr5IPAUjWv4CuW38NCl1zQAhmwizPODq87ZBUV6r8KZpeCzDqv/2PKi/PSztiJ8n
 VLEf/We9fLXrnGWlLflYk7hjpYttIwZOQX9SCD3DXk88UNTwpfV6KB4yF2+pYNnOXGou
 bVjiWHSFs9kwF7Wk2JTSEshk1PsFKSODrZ6R5w9HNRqYMh/Fl+zPwmKSsU4ECRoVBplP FA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3que9mxjyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 10:47:32 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 1 Jun
 2023 16:47:31 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 1 Jun 2023 16:47:31 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 38F0F468;
        Thu,  1 Jun 2023 15:47:31 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>, <perex@perex.cz>, <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v4 00/12] ALSA: hda: Adding support for CS35L56 on HDA systems
Date:   Thu, 1 Jun 2023 16:47:19 +0100
Message-ID: <20230601154731.3210572-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: q69MXZHl7QbP0KtaKI9fm4YYM2UcAGtl
X-Proofpoint-ORIG-GUID: q69MXZHl7QbP0KtaKI9fm4YYM2UcAGtl
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches adds support for using the CS35L56 boosted smart
amplifier on HDA systems. In these systems the CS35L56 audio is
routed through a HDA-to-I2S bridge codec.

This doesn't include the changes to the Realtek driver to actually hook
up the CS35L56 driver, because we don't yet have the QUIRK IDs to
associate it with. But we want to publish the driver now so that it is
available for bringing up hardware with the CS35L56.

The first 9 patches are moving code out of the ASoC driver and into the
shared library so that it can be shared with the HDA driver.

Patch #10 fixes missing #includes in the HDA headers so that the CS35L56
driver doesn't have to #include headers that it doesn't use.

Finally, #11 and #12 actually add the support for CS35L56 on HDA.

CHANGES SINCE V3
Patch 01:
- Fix double-free of IRQ caused by passing wrong cookie to devm_irq_free()
Patch 12:
- Fix memory leak of struct firmware object and firmware name strings.
- Find and open firmware files before taking the irq_lock mutex and pm_runtime.
- Don't bother executing the firmware loading code if no firmware files were
  found.

Richard Fitzgerald (4):
  ASoC: cs35l56: Move runtime suspend/resume to shared library
  ASoC: cs35l56: Move cs_dsp init into shared library
  ASoC: cs35l56: Move part of cs35l56_init() to shared library
  ALSA: hda: Fix missing header dependencies

Simon Trimmer (8):
  ASoC: cs35l56: Move shared data into a common data structure
  ASoC: cs35l56: Make cs35l56_system_reset() code more generic
  ASoC: cs35l56: Convert utility functions to use common data structure
  ASoC: cs35l56: Move utility functions to shared file
  ASoC: cs35l56: Make common function for control port wait
  ASoC: cs35l56: Make a common function to shutdown the DSP
  ALSA: hda: Add mute_hook to hda_component
  ALSA: hda/cs35l56: Add driver for Cirrus Logic CS35L56 amplifier

 include/sound/cs35l56.h           |   29 +-
 sound/pci/hda/Kconfig             |   31 +
 sound/pci/hda/Makefile            |    6 +
 sound/pci/hda/cs35l56_hda.c       | 1010 +++++++++++++++++++++++++++++
 sound/pci/hda/cs35l56_hda.h       |   48 ++
 sound/pci/hda/cs35l56_hda_i2c.c   |   69 ++
 sound/pci/hda/cs35l56_hda_spi.c   |   68 ++
 sound/pci/hda/hda_auto_parser.h   |    2 +
 sound/pci/hda/hda_component.h     |    1 +
 sound/pci/hda/hda_generic.h       |    3 +
 sound/soc/codecs/cs35l56-i2c.c    |   14 +-
 sound/soc/codecs/cs35l56-sdw.c    |   72 +-
 sound/soc/codecs/cs35l56-shared.c |  459 ++++++++++++-
 sound/soc/codecs/cs35l56-spi.c    |   10 +-
 sound/soc/codecs/cs35l56.c        |  648 ++++--------------
 sound/soc/codecs/cs35l56.h        |   15 +-
 16 files changed, 1893 insertions(+), 592 deletions(-)
 create mode 100644 sound/pci/hda/cs35l56_hda.c
 create mode 100644 sound/pci/hda/cs35l56_hda.h
 create mode 100644 sound/pci/hda/cs35l56_hda_i2c.c
 create mode 100644 sound/pci/hda/cs35l56_hda_spi.c

-- 
2.30.2

