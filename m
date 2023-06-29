Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E65741E14
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 04:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjF2CQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 22:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjF2CQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:16:47 -0400
X-Greylist: delayed 373 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Jun 2023 19:16:46 PDT
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895A710D7;
        Wed, 28 Jun 2023 19:16:46 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 75EE61A0D8D;
        Thu, 29 Jun 2023 04:10:32 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3E24D1A0D8C;
        Thu, 29 Jun 2023 04:10:32 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7BE20181D0E5;
        Thu, 29 Jun 2023 10:10:30 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/6] Add audio support in v4l2 framework
Date:   Thu, 29 Jun 2023 09:37:47 +0800
Message-Id: <1688002673-28493-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audio signal processing has the requirement for memory to
memory similar as Video.

This patch is to add this support in v4l2 framework, defined
new buffer type V4L2_BUF_TYPE_AUDIO_CAPTURE and
V4L2_BUF_TYPE_AUDIO_OUTPUT, defined new format v4l2_audio_format
for audio case usage.

The created audio device is named "/dev/audioX".

And add memory to memory support for two kinds of i.MX ASRC
module


Shengjiu Wang (6):
  media: v4l2: Add audio capture and output support
  ASoC: fsl_asrc: define functions for memory to memory usage
  ASoC: fsl_easrc: define functions for memory to memory usage
  ASoC: fsl_asrc: Add memory to memory driver
  ASoC: fsl_asrc: enable memory to memory function
  ASoC: fsl_easrc: enable memory to memory function

 .../media/common/videobuf2/videobuf2-v4l2.c   |   4 +
 drivers/media/v4l2-core/v4l2-dev.c            |  17 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  52 ++
 include/media/v4l2-dev.h                      |   2 +
 include/media/v4l2-ioctl.h                    |  34 +
 include/uapi/linux/videodev2.h                |  19 +
 sound/soc/fsl/Kconfig                         |  13 +
 sound/soc/fsl/Makefile                        |   2 +
 sound/soc/fsl/fsl_asrc.c                      | 175 +++-
 sound/soc/fsl/fsl_asrc.h                      |   2 +
 sound/soc/fsl/fsl_asrc_common.h               |  54 ++
 sound/soc/fsl/fsl_asrc_m2m.c                  | 878 ++++++++++++++++++
 sound/soc/fsl/fsl_asrc_m2m.h                  |  48 +
 sound/soc/fsl/fsl_easrc.c                     | 255 ++++-
 sound/soc/fsl/fsl_easrc.h                     |   6 +
 15 files changed, 1557 insertions(+), 4 deletions(-)
 create mode 100644 sound/soc/fsl/fsl_asrc_m2m.c
 create mode 100644 sound/soc/fsl/fsl_asrc_m2m.h

-- 
2.34.1

