Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A1D72B5D8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 05:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbjFLDPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 23:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbjFLDPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:15:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00502E77
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 20:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686539690; x=1718075690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n4WljQzl2VdpQPd3iTWOpWki7dTWlXg8XREKcKcC5Fk=;
  b=VhM5jSVwHyGGvU/BuoooMXq8qddrksl0178UsSlV6T22a2gVmrqET66R
   EK3jyXBksQRqIml/sUzbLFHsYOM+qlo6BkVVW8jS+1cOm2i9Qr8sbOzQr
   12JuTY4IbeRi9WvOAG8Cewx/1YuraU3ZIzwZ2ovRAevbjvwx64hTZEBhD
   pvhli5d6/mNBISgNhW4Yndu4KjtsE0clGECy20g5N7xWu8KjYzQijNQJL
   9/dkZ90n8p2WxD8AHI8BUhDycvI4Bfj4iZmJ0QASV7935DMXekLHAY2Og
   619hf7EOqf658zSQ+iFzSigNUFlYKB5g6avBi7xYuFCJHIqpLB6K+QAfw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="347578899"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="347578899"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 20:14:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="776191885"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="776191885"
Received: from brentlu-desktop.itwn.intel.com ([10.5.252.92])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jun 2023 20:14:47 -0700
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
Subject: [PATCH 02/12] ASoC: Intel: avs-dmic: remove redundant dapm routes
Date:   Mon, 12 Jun 2023 19:09:48 +0800
Message-Id: <20230612110958.592674-3-brent.lu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612110958.592674-1-brent.lu@intel.com>
References: <20230612110958.592674-1-brent.lu@intel.com>
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

Two routes "DMIC Rx<-Capture" and "DMIC WoV Rx<-Capture" are created
by snd_soc_dapm_connect_dai_link_widgets() automatically. Remove the
duplicate routes.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/avs/boards/dmic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/intel/avs/boards/dmic.c b/sound/soc/intel/avs/boards/dmic.c
index 90a921638572..c270646faf86 100644
--- a/sound/soc/intel/avs/boards/dmic.c
+++ b/sound/soc/intel/avs/boards/dmic.c
@@ -44,8 +44,6 @@ static const struct snd_soc_dapm_widget card_widgets[] = {
 
 static const struct snd_soc_dapm_route card_routes[] = {
 	{"DMic", NULL, "SoC DMIC"},
-	{"DMIC Rx", NULL, "Capture"},
-	{"DMIC WoV Rx", NULL, "Capture"},
 };
 
 static int avs_dmic_probe(struct platform_device *pdev)
-- 
2.34.1

