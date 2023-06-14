Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CC1712693
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243462AbjEZM3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbjEZM3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:29:17 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F432198
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:29:13 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QC7FGs007721;
        Fri, 26 May 2023 07:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=zbeX20arXQtFL1Oe3E/Iquzv2uaKy2zZxXDCKuIdoAI=;
 b=lfnwCFB4qbLJV8esbbskxfwmtRR6x9XxW1QznShscd9Tb3lqJ104jc1Tm5glLHgRXLr9
 kPriZcrNnjoIevMSfvqQloNjKNq3tTYdX3P8Vxgy2pTFq2YzCuzmBzSQa4iWGuyJNHnf
 6Zo+uUpvsEufaqNyb0DOne8e6H++XjcOnUXxCLbRGeqEHYLd6QyrK67Jdc2jn+OShebs
 wXthAuU+ksLAqFI1y7fRKxUP45Rcldy93Yre6QsV49SUgNGKkFx45kLxWeDm7dxHL2s6
 DkhZzyXRXZgMGvlcEnmSSy+BzAbm1X0GjcMUPjIYzCKWIgyR4CQ6Ft0uBD8RAPWZfj6K WQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3qsde8k66v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 07:28:56 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 26 May
 2023 07:28:54 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 26 May 2023 07:28:54 -0500
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.166])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 636B411A8;
        Fri, 26 May 2023 12:28:54 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>, <broonie@kernel.org>, <perex@perex.cz>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 00/12] ALSA: hda: Adding support for CS35L56 on HDA systems
Date:   Fri, 26 May 2023 13:28:40 +0100
Message-ID: <20230526122852.4552-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bYQkcU_a5WKwe3nTPf_ZRlMnfsE3DBRp
X-Proofpoint-GUID: bYQkcU_a5WKwe3nTPf_ZRlMnfsE3DBRp
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

CHANGES SINCE V2
All in patch #12:
- Add __maybe_unused to runtime suspend/resume callbacks to prevent build
  error if CONFIG_PM is not defined
- Removed __maybe_unused from system suspend/resume functions
- Change i2c .probe_new to .probe
- Removed unnecessary returns in cs35l56_hda_create_controls()
- Change if (ret != 0) to if (ret)

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

 include/sound/cs35l56.h           |  29 +-
 sound/pci/hda/Kconfig             |  31 +
 sound/pci/hda/Makefile            |   6 +
 sound/pci/hda/cs35l56_hda.c       | 990 ++++++++++++++++++++++++++++++
 sound/pci/hda/cs35l56_hda.h       |  48 ++
 sound/pci/hda/cs35l56_hda_i2c.c   |  69 +++
 sound/pci/hda/cs35l56_hda_spi.c   |  68 ++
 sound/pci/hda/hda_auto_parser.h   |   2 +
 sound/pci/hda/hda_component.h     |   1 +
 sound/pci/hda/hda_generic.h       |   3 +
 sound/soc/codecs/cs35l56-i2c.c    |  14 +-
 sound/soc/codecs/cs35l56-sdw.c    |  72 +--
 sound/soc/codecs/cs35l56-shared.c | 459 +++++++++++++-
 sound/soc/codecs/cs35l56-spi.c    |  10 +-
 sound/soc/codecs/cs35l56.c        | 648 ++++---------------
 sound/soc/codecs/cs35l56.h        |  15 +-
 16 files changed, 1873 insertions(+), 592 deletions(-)
 create mode 100644 sound/pci/hda/cs35l56_hda.c
 create mode 100644 sound/pci/hda/cs35l56_hda.h
 create mode 100644 sound/pci/hda/cs35l56_hda_i2c.c
 create mode 100644 sound/pci/hda/cs35l56_hda_spi.c

-- 
2.30.2

