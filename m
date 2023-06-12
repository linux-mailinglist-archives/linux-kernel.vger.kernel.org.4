Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C6372B5DC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 05:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbjFLDQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 23:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbjFLDO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:14:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F96CE72
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 20:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686539685; x=1718075685;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8gPCuDqBxy3w2rRnM7UsFSCqZxJx21nsM66FiPsiHcs=;
  b=g6fEjtj4vLbsRl44zLSsLNY/TvzhGAtrsPgYDJzAd9Mi1WRKME4eT8DT
   pHZnHKIKvFP2CbJbB1lrPOoVAm7xujbUCIJI2VwvE11Lrr2g2zsDOTDc1
   B3WHGzZw0g+VogKgyULaw4S3DTRfSMMtKkRw57y652fZQdAWuzNAPtGMd
   DEh1zjKytRwKDVCakqU1JzkUbx1HRTkW9Gicij8rO0u55mrbNKz6FPhla
   ncuIQUeOYgjXeuoD08T6zZBeO0WqGPtpLZlvU8r2+uhzytaAnqVUCOaHp
   ZVgOKpTDGoOM1nafWPXKJYHs4e1rnqAt/9A0/4XfhtJ4kA8NVnxR7DkMH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="347578872"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="347578872"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 20:14:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="776191865"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="776191865"
Received: from brentlu-desktop.itwn.intel.com ([10.5.252.92])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jun 2023 20:14:41 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Brent Lu <brent.lu@intel.com>, linux-kernel@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 00/12] ASoC: Intel: avs: remove redundant dapm routes
Date:   Mon, 12 Jun 2023 19:09:46 +0800
Message-Id: <20230612110958.592674-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series remove redundant dapm routes declared in multiple machine
drivers. These routes will be created by snd_soc_dapm_connect_dai_link_widgets()
during soundcard initialization. Following is the kernel log from a KBL
chromebook nocturne.

dmic:
[   13.773455] avs_dmic avs_dmic: connected DAI link dmic-codec:Capture -> dmic-platform:DMIC Rx
[   13.773460] avs_dmic avs_dmic: connected DAI link dmic-codec:Capture -> dmic-platform:DMIC WoV Rx

max98373:
[   14.079536] avs_max98373 avs_max98373.1: connected DAI link avs_max98373.1-platform:ssp0 Tx -> i2c-MX98373:00:Right HiFi Playback
[   14.079545] avs_max98373 avs_max98373.1: connected DAI link i2c-MX98373:00:Right HiFi Capture -> avs_max98373.1-platform:ssp0 Rx
[   14.079550] avs_max98373 avs_max98373.1: connected DAI link avs_max98373.1-platform:ssp0 Tx -> i2c-MX98373:01:Left HiFi Playback
[   14.079554] avs_max98373 avs_max98373.1: connected DAI link i2c-MX98373:01:Left HiFi Capture -> avs_max98373.1-platform:ssp0 Rx

hdaudio:
[   14.094818] avs_hdaudio avs_hdaudio.2: connected DAI link hdaudioB0D2-platform:hdaudioB0D2-cpu0 Tx -> hdaudioB0D2:HDMI 0 Playback
[   14.094824] avs_hdaudio avs_hdaudio.2: connected DAI link hdaudioB0D2-platform:hdaudioB0D2-cpu1 Tx -> hdaudioB0D2:HDMI 1 Playback
[   14.094828] avs_hdaudio avs_hdaudio.2: connected DAI link hdaudioB0D2-platform:hdaudioB0D2-cpu2 Tx -> hdaudioB0D2:HDMI 2 Playback


Brent Lu (12):
  ASoC: Intel: avs-da7219: remove redundant dapm routes
  ASoC: Intel: avs-dmic: remove redundant dapm routes
  ASoC: Intel: avs-hdaudio: remove redundant dapm routes
  ASoC: Intel: avs-max98357a: remove redundant dapm routes
  ASoC: Intel: avs-max98373: remove redundant dapm routes
  ASoC: Intel: avs-max98927: remove redundant dapm routes
  ASoC: Intel: avs-nau8825: remove redundant dapm routes
  ASoC: Intel: avs-rt274: remove redundant dapm routes
  ASoC: Intel: avs-rt286: remove redundant dapm routes
  ASoC: Intel: avs-rt298: remove redundant dapm routes
  ASoC: Intel: avs-rt5682: remove redundant dapm routes
  ASoC: Intel: avs-ssm4567: remove redundant dapm routes

 sound/soc/intel/avs/boards/da7219.c    | 45 ++----------------
 sound/soc/intel/avs/boards/dmic.c      |  2 -
 sound/soc/intel/avs/boards/hdaudio.c   | 65 +-------------------------
 sound/soc/intel/avs/boards/max98357a.c | 39 ++--------------
 sound/soc/intel/avs/boards/max98373.c  | 45 ++----------------
 sound/soc/intel/avs/boards/max98927.c  | 45 ++----------------
 sound/soc/intel/avs/boards/nau8825.c   | 45 ++----------------
 sound/soc/intel/avs/boards/rt274.c     | 45 ++----------------
 sound/soc/intel/avs/boards/rt286.c     | 45 ++----------------
 sound/soc/intel/avs/boards/rt298.c     | 45 ++----------------
 sound/soc/intel/avs/boards/rt5682.c    | 45 ++----------------
 sound/soc/intel/avs/boards/ssm4567.c   | 57 ++--------------------
 12 files changed, 31 insertions(+), 492 deletions(-)

-- 
2.34.1

