Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76ED69B05E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjBQQPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjBQQOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:14:32 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632B0711AC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:14:30 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HFgnU3014021;
        Fri, 17 Feb 2023 10:14:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=F+dsDHEU5Sdrumj0dlGMpDecJC4UrDNmYuQpDZmDbiA=;
 b=PXxvX5orBXGZurS/SQg3f3xCHPEvIjGi4jkZ3Lr6D28lQeYKlLEKSLkIrHNmznIbXRX/
 IGLui6qD29GdMR6WRgUiDSIr6IM6UKBpZDbknIfacEjHOg7DIZtYCe69jygL8N0qJlpr
 VI0F0makVsBr8XQVnrdTIfmHqQfZTLsHw05qYSfMlW0B094BXVt9NDrhwlKogkicKrDb
 OyDKXh4+Hx2HLGEyuhRcMPDbVsobWD2xaPwPlejbHVuKwlUJpoA353chQcL6e+6E5aNo
 0gzdZ/CHRcC2qiY71ziQk7ehKdaz/JG7523zDrltBrJkzANlpM/gUalZuSemPlb8MYNP zQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3nrm8wm7t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 10:14:11 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Fri, 17 Feb
 2023 10:14:10 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Fri, 17 Feb 2023 10:14:10 -0600
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2769E45;
        Fri, 17 Feb 2023 16:14:10 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>,
        <cezary.rojewski@intel.com>, <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <kai.vehmanen@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 00/10] ASoC: Initial support for Cirrus Logic CS35L56
Date:   Fri, 17 Feb 2023 16:14:00 +0000
Message-ID: <20230217161410.915202-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: PbOFLCyzbstWCN1voV9HEeBQBOa2gmiY
X-Proofpoint-ORIG-GUID: PbOFLCyzbstWCN1voV9HEeBQBOa2gmiY
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

Patch #8 adds the ASoC driver.

Patches #9 and #10 add support for this to the Intel sof_sdw
machine driver.

Richard Fitzgerald (3):
  ASoC: cs35l56: Add driver for Cirrus Logic CS35L56
  ASoC: Intel: sof_sdw: Add support for Cirrus Logic CS35L56
  ASoC: Intel: soc-acpi: Add CS35L56 Soundwire to TGL

Simon Trimmer (7):
  firmware: cs_dsp: Introduce no_core_startstop for self-booting DSPs
  ASoC: wm_adsp: Use no_core_startstop to prevent creating preload
    control
  firmware: cs_dsp: Support DSPs that don't require firmware download
  ASoC: wm_adsp: Support DSPs that don't require firmware download
  ASoC: wm_adsp: Expose the DSP boot work actions as wm_adsp_power_up()
  ASoC: wm_adsp: Add support for loading bin files without wmfw
  ASoC: wm_adsp: Simplify the logging of requested firmware files

 MAINTAINERS                                   |    2 +
 drivers/firmware/cirrus/cs_dsp.c              |   17 +-
 include/linux/firmware/cirrus/cs_dsp.h        |    1 +
 include/sound/cs35l56.h                       |  266 +++
 sound/soc/codecs/Kconfig                      |   34 +
 sound/soc/codecs/Makefile                     |   10 +
 sound/soc/codecs/cs35l56-i2c.c                |   83 +
 sound/soc/codecs/cs35l56-sdw.c                |  525 ++++++
 sound/soc/codecs/cs35l56-shared.c             |  387 +++++
 sound/soc/codecs/cs35l56-spi.c                |   81 +
 sound/soc/codecs/cs35l56.c                    | 1451 +++++++++++++++++
 sound/soc/codecs/cs35l56.h                    |   77 +
 sound/soc/codecs/wm_adsp.c                    |   63 +-
 sound/soc/codecs/wm_adsp.h                    |    3 +
 sound/soc/intel/boards/Kconfig                |    1 +
 sound/soc/intel/boards/Makefile               |    1 +
 sound/soc/intel/boards/sof_sdw.c              |    7 +
 sound/soc/intel/boards/sof_sdw_common.h       |    7 +
 sound/soc/intel/boards/sof_sdw_cs35l56.c      |  115 ++
 .../intel/common/soc-acpi-intel-tgl-match.c   |   57 +
 20 files changed, 3172 insertions(+), 16 deletions(-)
 create mode 100644 include/sound/cs35l56.h
 create mode 100644 sound/soc/codecs/cs35l56-i2c.c
 create mode 100644 sound/soc/codecs/cs35l56-sdw.c
 create mode 100644 sound/soc/codecs/cs35l56-shared.c
 create mode 100644 sound/soc/codecs/cs35l56-spi.c
 create mode 100644 sound/soc/codecs/cs35l56.c
 create mode 100644 sound/soc/codecs/cs35l56.h
 create mode 100644 sound/soc/intel/boards/sof_sdw_cs35l56.c

-- 
2.30.2

