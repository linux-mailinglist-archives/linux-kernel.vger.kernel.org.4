Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E5E6B7C65
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjCMPuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjCMPun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:50:43 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A538E6A408
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:50:27 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D5bF4A000339;
        Mon, 13 Mar 2023 10:50:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=KUfQ6GcH3lWPczqeS3uNxeSaXBxGISrBhuo1nu75FLg=;
 b=fPfj4CqabP90AqWSxF8RpoNgHGnLCFBlaWX0aZpt0m00WXP9cavigHJrBRkAwJ879TT3
 AnPRE3cXCOuOV3yOFRMDOxNq8FsWRCYXOqQ25PI8IMQR5j5vr9eGhtFsTJIaBtfqDLll
 efhveAbRQTN9sjUwSfNWmmpcge1I+qnBkDTu9q/JjMWUqXV1gkk3ThyGxg82jDWiB3Pl
 t6bkra9m0d3tLWcVobY/fy2hWL/mKvhPlBVc8nECZKaCB0PQW4o3Wap29GlzPzz2zzWx
 NIt+QadGZRpBut7bi90fX8A8gI6F5fcB/qdc0uivX6BsIbIsjTmvLHPUASMx4GFLzibW ig== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3p8pxvb6hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 10:50:05 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 13 Mar
 2023 10:50:04 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 13 Mar 2023 10:50:04 -0500
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.92])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DF6C311AB;
        Mon, 13 Mar 2023 15:50:03 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>
CC:     <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 0/8]  ASoC: Initial support for Cirrus Logic CS35L56
Date:   Mon, 13 Mar 2023 15:49:47 +0000
Message-ID: <20230313154955.4268-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: NaiokJsNiYk2GZDLmG0X-GgRimUKvyR_
X-Proofpoint-GUID: NaiokJsNiYk2GZDLmG0X-GgRimUKvyR_
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CS35L56 is a high-performance boosted mono audio amplifier.
Supported control interfaces are I2C, SPI or SoundWire.
Supported audio interfaces are I2S/TDM or SoundWire.

The CS35L56 has a self-booting firmware in ROM, with the ability
to patch the firmware and/or apply tunings.
Patches #1 to #7 add support to cs_dsp and wm_adsp for self-booting
firmware and the ability to apply a .bin file without having to
apply a .wmfw.

Changes since v1:
- Check for error when getting pm_runtime in cs35l56_irq().
- Use SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK instead of the old define.
- Re-word two comments in cs35l56-sdw.c.
- Add an comment explaining the wait for init_completion in
  cs35l56_dsp_work().
- Omit patches to Intel machine driver. These will be done as a
  separate thread.

Richard Fitzgerald (1):
  ASoC: cs35l56: Add driver for Cirrus Logic CS35L56

Simon Trimmer (7):
  firmware: cs_dsp: Introduce no_core_startstop for self-booting DSPs
  ASoC: wm_adsp: Use no_core_startstop to prevent creating preload
    control
  firmware: cs_dsp: Support DSPs that don't require firmware download
  ASoC: wm_adsp: Support DSPs that don't require firmware download
  ASoC: wm_adsp: Expose the DSP boot work actions as wm_adsp_power_up()
  ASoC: wm_adsp: Add support for loading bin files without wmfw
  ASoC: wm_adsp: Simplify the logging of requested firmware files

 MAINTAINERS                            |    1 +
 drivers/firmware/cirrus/cs_dsp.c       |   17 +-
 include/linux/firmware/cirrus/cs_dsp.h |    1 +
 include/sound/cs35l56.h                |  266 +++++
 sound/soc/codecs/Kconfig               |   34 +
 sound/soc/codecs/Makefile              |   10 +
 sound/soc/codecs/cs35l56-i2c.c         |   83 ++
 sound/soc/codecs/cs35l56-sdw.c         |  528 +++++++++
 sound/soc/codecs/cs35l56-shared.c      |  390 +++++++
 sound/soc/codecs/cs35l56-spi.c         |   81 ++
 sound/soc/codecs/cs35l56.c             | 1461 ++++++++++++++++++++++++
 sound/soc/codecs/cs35l56.h             |   77 ++
 sound/soc/codecs/wm_adsp.c             |   63 +-
 sound/soc/codecs/wm_adsp.h             |    3 +
 14 files changed, 2999 insertions(+), 16 deletions(-)
 create mode 100644 include/sound/cs35l56.h
 create mode 100644 sound/soc/codecs/cs35l56-i2c.c
 create mode 100644 sound/soc/codecs/cs35l56-sdw.c
 create mode 100644 sound/soc/codecs/cs35l56-shared.c
 create mode 100644 sound/soc/codecs/cs35l56-spi.c
 create mode 100644 sound/soc/codecs/cs35l56.c
 create mode 100644 sound/soc/codecs/cs35l56.h

-- 
2.30.2

