Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5C071743E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 05:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbjEaDP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 23:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbjEaDPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 23:15:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAED188
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 20:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685502934; x=1717038934;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/VL76X1WW1uKCaAq0pPGpA4itNI1rlmGDz9p+rE4p1w=;
  b=Z8gFSqa/t1VFM6vrfo1By2Ua7EGYL9Ot54iUZ98RfZCvkUJoEr8A1UtO
   +uPBOoDoQvSE/DY3JOZ2b+zkfl4HLV4Do+oE7asgUuaeN17Q5+wy7ZPoi
   MyhHeURhtvyI/+iHkUMcEw9N4Irc8BAtoZ6H9P90ha0Ol9BVNzGFhSFLj
   QHTrxzr479mjIsAHahpSgtXWno2ChxcqyfFaSRSkCmxm2orXrvCJxAfZ8
   rBX97Ial1w+u8/ivA+2RDvrnKLvFSz+7rWzqHA05fZFa/uGxTVv+k4TgJ
   tAKD1+wbdhylnBhrk2YKF3Ud1h+E6kmBQqiqHEoayxld9gkq+VT17mnOK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="357507644"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="357507644"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 20:15:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="739769457"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="739769457"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 20:15:32 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 0/4] soundwire: allow for more than 8 devices, keep IDA for wake-capable devices
Date:   Wed, 31 May 2023 11:37:32 +0800
Message-Id: <20230531033736.792464-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series suggests a hybrid strategy for device number allocation, where
only wake-capable devices use a system-unique Device Number which will be
used on LunarLake to handle wake-ups using the HDaudio WAKEEN and WAKESTS.

Pierre-Louis Bossart (4):
  soundwire: add enum to control device number allocation
  soundwire: introduce SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY
  soundwire: extend parameters of new_peripheral_assigned() callback
  soundwire: intel_auxdevice: use SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY

 drivers/soundwire/bus.c             | 28 ++++++++++++++++++++++------
 drivers/soundwire/intel_auxdevice.c | 26 ++++++++++++++++++++++----
 include/linux/soundwire/sdw.h       | 24 ++++++++++++++++++++++--
 3 files changed, 66 insertions(+), 12 deletions(-)

-- 
2.25.1

