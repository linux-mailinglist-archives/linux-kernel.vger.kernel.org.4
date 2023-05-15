Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08AE702673
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239761AbjEOHwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjEOHwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:52:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C279E76
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 00:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684137152; x=1715673152;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SiCBDBnlz88gKGLR73uUCWFOWyCRfe4txr9qACADick=;
  b=iK0dDyeE7/IsaBANPNL5Zz0glSoC4QwiCchAdzi2I1CwNAd+y6NztTp5
   iZfg9Uo96DcAKGCKxztCKWfyEHmO4C7eiiZg1RWZbQiDpX4He/TapP7cy
   Q6vHmMD2go5mDmb3EDiwsQgFqF/LSIPfjHrjHouFu2ORpIavANdm0SJoX
   AcIt435T+ADTS2wip/aL6AJtQjUPDKUXuY1FCLC6fzg2cSQ84OSwyFPeE
   PtC5rdJgYzGKaPnBCyUUGLtq5Jyo+30v3kT1eItWme8cSjOAHfmAALnwc
   YsO71ZBjExrWKn3269GqpxMq/b11dDWb4C8IwsHN3Q2T4idlY19plR6vJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="335676055"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="335676055"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 00:52:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="731550650"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="731550650"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 00:52:30 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH] soundwire: intel: read AC timing control register before updating it
Date:   Mon, 15 May 2023 16:13:01 +0800
Message-Id: <20230515081301.12921-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Song <chao.song@linux.intel.com>

Start from ACE1.x, DOAISE is added to AC timing control
register bit 5, it combines with DOAIS to get effective
timing, and has the default value 1.

The current code fills DOAIS, DACTQE and DODS bits to a
variable initialized to zero, and updates the variable
to AC timing control register. With this operation, We
change DOAISE to 0, and force a much more aggressive
timing. The timing is even unable to form a working
waveform on SDA pin on Meteorlake.

This patch uses read-modify-write operation for the AC
timing control register access, thus makes sure those
bits not supposed and intended to change are not touched.

Signed-off-by: Chao Song <chao.song@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 238acf5c97a9..8cd2c73ac66f 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -260,7 +260,7 @@ static void intel_shim_init(struct sdw_intel *sdw)
 {
 	void __iomem *shim = sdw->link_res->shim;
 	unsigned int link_id = sdw->instance;
-	u16 ioctl = 0, act = 0;
+	u16 ioctl = 0, act;
 
 	/* Initialize Shim */
 	ioctl |= SDW_SHIM_IOCTL_BKE;
@@ -281,6 +281,7 @@ static void intel_shim_init(struct sdw_intel *sdw)
 
 	intel_shim_glue_to_master_ip(sdw);
 
+	act = intel_readw(shim, SDW_SHIM_CTMCTL(link_id));
 	u16p_replace_bits(&act, 0x1, SDW_SHIM_CTMCTL_DOAIS);
 	act |= SDW_SHIM_CTMCTL_DACTQE;
 	act |= SDW_SHIM_CTMCTL_DODS;
-- 
2.25.1

