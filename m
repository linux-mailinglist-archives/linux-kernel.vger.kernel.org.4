Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6B470254C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbjEOGuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjEOGuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:50:22 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3F28F
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684133421; x=1715669421;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1oo0XsT3nA10k1WbskK/cxU0CChuvZrvYt+c1bbAmtk=;
  b=eQnl5UmA3wSTu0VOmhEKBdlwCWMjbZtii/wSsBZh+J+x008of2ipJT3O
   3qk5ppAAMvKs3YqLI185NJaXg8uU7jULCt9JTQbAxAcFNAii/HLuKfT6i
   KPaFtzOBaqpftlkxk6XJJIU0DtXgSA0m+x5Ro2Ft1WYcGO/xNGQhwr1iJ
   vsDo6nDoED5O6EnWBy93psw2g43UR8gSgaawQnOd24SDhrb1udOshUvI0
   dglxEUVh0bsL6EFvwl8dSevZ66IXBarmu9szSnZuH2DUdVlnc9DrBVwAM
   x8slH+lMsD1fLk6Bor5j7tRCldHmoLdShRWtTGoTHiicKYKZX1k57Bfcj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="349966233"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="349966233"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694908559"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="694908559"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:18 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org,
        tiwai@suse.de
Cc:     linux-kernel@vger.kernel.org, vinod.koul@linaro.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 00/26] ASoC/soundwire: add support for ACE2.x
Date:   Mon, 15 May 2023 15:10:16 +0800
Message-Id: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series uses the abstraction added in past kernel cycles to provide
support for the ACE2.x integration. The existing SHIM and Cadence
registers are now split in 3 (SHIM, IP, SHIM vendor-specific), with some
parts also moved to the HDaudio Extended Multi link structures. Nothing
fundamentally different except for the register map.

This series only provides the basic mechanisms to expose SoundWire-based
DAIs. The PCI parts and DSP management will be contributed later, and the
DAI ops are now empty as well.

The change is mainly on SoundWire. It would be better to go through
SoundWire tree.

v2:
 - Some cleanup for free, trigger, hw_params callbacks before introducing
   ACE2.x callbacks.

Pierre-Louis Bossart (26):
  ASoC: SOF: Intel: shim: add enum for ACE 2.0 IP used in LunarLake
  soundwire: intel: add ACE2.x SHIM definitions
  soundwire: intel_ace2x: add empty new ops for LunarLake
  soundwire/ASOC: Intel: update offsets for LunarLake
  soundwire: intel/cadence: set ip_offset at run-time
  ASoC/soundwire: intel: pass hdac_bus pointer for link management
  soundwire: intel: add eml_lock in the interface for new platforms
  ASoC: SOF: Intel: hda: retrieve SoundWire eml_lock and pass pointer
  soundwire: intel_init: use eml_lock parameter
  soundwire: intel_ace2x: add debugfs support
  soundwire: intel_ace2x: add link power-up/down helpers
  soundwire: intel_ace2x: set SYNCPRD before powering-up
  soundwire: intel_ace2x: configure link PHY
  soundwire: intel_ace2x: add DAI registration
  soundwire: intel_ace2x: add sync_arm/sync_go helpers
  soundwire: intel_ace2x: use common helpers for bus start/stop
  soundwire: intel_ace2x: enable wake support
  soundwire: intel_ace2x: add check_cmdsync_unlocked helper
  soundwire: bus: add new manager callback to deal with peripheral
    enumeration
  soundwire: intel_ace2x: add new_peripheral_assigned callback
  soundwire: intel_ace2x: add pre/post bank switch callbacks
  ASoC: SOF/soundwire: re-add substream in params_stream structure
  soundwire: intel: remove .trigger callback implementation
  soundwire: intel: use substream for .trigger callback
  soundwire: intel: remove .free callback implementation
  soundwire: intel: use substream for .free callback

 drivers/soundwire/Makefile              |   3 +-
 drivers/soundwire/bus.c                 |   3 +
 drivers/soundwire/cadence_master.h      |   2 +
 drivers/soundwire/intel.c               |  54 +---
 drivers/soundwire/intel.h               |  16 +
 drivers/soundwire/intel_ace2x.c         | 393 ++++++++++++++++++++++++
 drivers/soundwire/intel_ace2x_debugfs.c | 147 +++++++++
 drivers/soundwire/intel_auxdevice.c     |  17 +
 drivers/soundwire/intel_init.c          |  21 +-
 include/linux/soundwire/sdw.h           |   3 +-
 include/linux/soundwire/sdw_intel.h     |  94 +++++-
 sound/soc/sof/intel/hda.c               |  33 +-
 sound/soc/sof/intel/shim.h              |   1 +
 13 files changed, 723 insertions(+), 64 deletions(-)
 create mode 100644 drivers/soundwire/intel_ace2x.c
 create mode 100644 drivers/soundwire/intel_ace2x_debugfs.c

-- 
2.25.1

