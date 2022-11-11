Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43ABE624F8C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 02:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiKKB3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 20:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKKB3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 20:29:48 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFD66175C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668130187; x=1699666187;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2pur3i1m7TU4lByzoWZ7E5DjI09dYrh2ZHxi79WNNow=;
  b=iHUv0F+vNFYpSEwsaVilEmf6uMoxihdiND0LoqaOBlFi/Wuj3fWf2cWN
   MfiXOW6K0u/zMx5BUHv/wVSLnSVPuo5IPrfXy3AVOL+R+slVlIGZKmwYj
   hNt0shyk2d1ZU1YK27OUGUXGaA7yVAO1BSOR3pd3a7EW1OT2EctlPXJgr
   WZyAifa4IhrJQzDnFUzAI9z4YIlTsI82/h/w8dtQ/0suNUOmaI5DZOwrg
   fnEGGV1s06iWUxw5kXl6W8IJZAcDZqSyIZEEfl+ohpgGxUpovWqPpKFsO
   YS8PHAXLpZAhmRBk4mbnZxQwvqSsApNu8bOA1gVg8VM7m7gd43A+ux3JJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="294847795"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="294847795"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 17:29:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="780003212"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="780003212"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 17:29:45 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 0/7] soundwire: intel: introduce hw_ops and move auxdevice handling to dedicated file
Date:   Fri, 11 Nov 2022 09:31:27 +0800
Message-Id: <20221111013135.38289-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds yet another set of cleanups
a) all the helpers are now exposed as hw_ops callbacks
b) the auxiliary device code is now completely generic.

This will allow for easier introduction of new hw_ops implementations in
the future without throwing away all the goodness of the auxiliary device
handling. Since there will be a tighter coupling with HDaudio, it's likely
that future hw_ops are implemented in the SOF driver directly.

Pierre-Louis Bossart (7):
  soundwire: intel: start using hw_ops
  soundwire: intel: add debugfs callbacks in hw_ops
  soundwire: intel: add register_dai callback in hw_ops
  soundwire: intel: add bus management callbacks in hw_ops
  soundwire: intel: add link power management callbacks in hw_ops
  soundwire: intel: add in-band wake callbacks in hw_ops
  soundwire: intel: split auxdevice to different file

 drivers/soundwire/Makefile          |   2 +-
 drivers/soundwire/intel.c           | 658 +--------------------------
 drivers/soundwire/intel.h           |  96 +++-
 drivers/soundwire/intel_auxdevice.c | 678 ++++++++++++++++++++++++++++
 drivers/soundwire/intel_auxdevice.h |  18 +
 drivers/soundwire/intel_init.c      |   2 +
 include/linux/soundwire/sdw_intel.h |  44 ++
 sound/soc/sof/intel/hda.c           |   2 +
 8 files changed, 853 insertions(+), 647 deletions(-)
 create mode 100644 drivers/soundwire/intel_auxdevice.c
 create mode 100644 drivers/soundwire/intel_auxdevice.h

-- 
2.25.1

