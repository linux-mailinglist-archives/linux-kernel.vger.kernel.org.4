Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A78E62526D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiKKEZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKKEZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:25:05 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3BD6828E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668140704; x=1699676704;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RFpURshL9pTlSR+fmXELrO+573EoTkI2OXbk3OCrDsg=;
  b=msVVO9Goi5OB63qxTSVhY5Me+ASx9tdLuBsqWxrbufcuY6n08vjcgu7r
   dQDTRmKu9CoKgxVYkDWJ5ts5PIJ/vtJcSo3IiOLDfNwiQFTzeZqDLFz1S
   fSnXNOsaxsJUc2VtYYyNV1veYSo9EQrovfbjgHKxVFAoo3fametLK/ZrW
   w21D+0U0uRx4jeAgB404lC2Dc/yQBYy4rkapOUsq0EuazTwkMhLCa3WNC
   EL7ymYNwvHPI6XsOnNtHr2QSkqllenCl/SuiSm4oyQsEsekzxrFG7/v7+
   rbsHur8oCjUONzdzbGAM3jBsMMcBT57nnRK5e65Qj4+TeT8fPzDkSmKTq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="397816273"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="397816273"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 20:25:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="588440633"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="588440633"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 20:25:02 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
        bard.liao@intel.com
Subject: [PATCH 0/8] ASoC/soundwire: revisit interrupt and lcount handling
Date:   Fri, 11 Nov 2022 12:26:45 +0800
Message-Id: <20221111042653.45520-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code in drivers/soundwire/intel_init.c is hardware-dependent and the
code does not apply to new generations starting with MeteorLake. Refactor
and clean-up the code to make this intel_init.c hardware-agnostic and
move all hardware-dependencies in the SOF driver using chip descriptors.

The ASoC patches are dependent on some patches that are applied to ASoC
tree recently. So, this series won't apply to SoundWire tree. @Vinod Could
you Ack if it looks good to you, and lets go through ASoC tree?

Pierre-Louis Bossart (8):
  soundwire: intel_init: remove useless interrupt enablement in
    interrupt thread
  ASoC: SOF: Intel: hda: add per-chip enable_sdw_irq() callback
  ASoC: SOF: Intel: mtl: factor interrupt enable/disable interrupt
    functions
  ASoC: SOF: Intel: mtl: move SoundWire interrupt enabling to callback
  ASoC: SOF: Intel: hda: add callback to check SoundWire lcount
    information
  soundwire: intel_init: remove sdw_intel_enable_irq()
  soundwire: intel_init: remove check on number of links
  ASoC: SOF: Intel: hda: read multi-link capabilities earlier

 drivers/soundwire/intel_init.c      |  37 --------
 include/linux/soundwire/sdw_intel.h |   2 -
 sound/soc/sof/intel/cnl.c           |   4 +
 sound/soc/sof/intel/hda.c           |  63 ++++++++++++-
 sound/soc/sof/intel/hda.h           |  12 +++
 sound/soc/sof/intel/icl.c           |   2 +
 sound/soc/sof/intel/mtl.c           | 131 +++++++++++-----------------
 sound/soc/sof/intel/shim.h          |   2 +
 sound/soc/sof/intel/tgl.c           |   8 ++
 9 files changed, 139 insertions(+), 122 deletions(-)

-- 
2.25.1

