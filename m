Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEAE6C5EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCWF3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCWF3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:29:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8F820050
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679549391; x=1711085391;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9WAW0zepnYSbfRRjixmplrT7V+yloxeDYYdsHsolz/4=;
  b=EZD+AHcw/5XWfUXVly0ZTq8Cl+c2h0iUf54H1cs/Ekblkg5c2j5Nou6I
   n9JcxDrE7wdVC/xD4GJ3noMLixUSVcGKYwMYFqgtUF5L2hBajK/e2AkKC
   DtHi9MP8ylyo0c+r5uPRFVPoYLdaLp7p9XLlPf1MuBuTpuG3G0KTGQhDb
   sPluE2HpgwiUFQLJPSYfj6VAiioP4YDsIAP64GiU2hZmy6lMe7pcJraL6
   OeAT3OHX3bG9C87vMaoX3xvnxTW9ylEMLx19N2uucKfCwpru7CywF5r+s
   B4cqL70qsVRUJz1os0ZlNfNO468TrtfuiF1ipuLth2Atm/EiTOaoEZGoq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327779265"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="327779265"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:29:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675566983"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="675566983"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:29:48 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        tiwai@suse.de
Subject: [PATCH 00/20] ASoC/soundwire: add support for ACE2.x
Date:   Thu, 23 Mar 2023 13:44:32 +0800
Message-Id: <20230323054452.1543233-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Pierre-Louis Bossart (20):
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

 drivers/soundwire/Makefile              |   3 +-
 drivers/soundwire/bus.c                 |   3 +
 drivers/soundwire/cadence_master.h      |   2 +
 drivers/soundwire/intel.h               |  16 +
 drivers/soundwire/intel_ace2x.c         | 390 ++++++++++++++++++++++++
 drivers/soundwire/intel_ace2x_debugfs.c | 147 +++++++++
 drivers/soundwire/intel_auxdevice.c     |  17 ++
 drivers/soundwire/intel_init.c          |  21 +-
 include/linux/soundwire/sdw.h           |   3 +-
 include/linux/soundwire/sdw_intel.h     |  88 ++++++
 sound/soc/sof/intel/hda.c               |  31 +-
 sound/soc/sof/intel/shim.h              |   1 +
 12 files changed, 711 insertions(+), 11 deletions(-)
 create mode 100644 drivers/soundwire/intel_ace2x.c
 create mode 100644 drivers/soundwire/intel_ace2x_debugfs.c

-- 
2.25.1

