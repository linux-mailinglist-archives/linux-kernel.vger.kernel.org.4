Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0DD7251A9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 03:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbjFGBoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 21:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240556AbjFGBoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 21:44:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC701FE0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 18:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686102228; x=1717638228;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oak0LJhMLWtP9UoshEOtnO5xklZAVt1BPVezT+IWuFw=;
  b=VoKaPitEcePYoZJ3P7av0GoEyTx9HNCsKInnIyFzq33Cn8aQvABT/op3
   +BPQFsSe/xAY3crzKzehGLWJ04u9CP1Sc7O1TaMJwyZ2jAhmbc8Gpbkoy
   Lo1ui8FT21QtGD/JP7JQ6i8HF0uKqAMny30T0eiXURoLJna5oi2w6Bk8y
   Xt3ivmUxxcwJ8+iX0bMElCwsPQvQCvkLAvbR2/HYoZ8+6ckePgfa7bqbK
   3dyXCPkXMWkcDQblrcufxRM/hRQi2d7BL7nlErndRHo7QHTVb2ncsk3/H
   JTn6KelGSBaJVv6TBRAT7zCWYW4nlua+F4TRvDEH9PKhz1ySCizz3y1aD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="359314355"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="359314355"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 18:43:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="742396227"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="742396227"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 18:43:44 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH] soundwire: debugfs: Add missing SCP registers
Date:   Wed,  7 Jun 2023 10:06:32 +0800
Message-Id: <20230607020632.1030309-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uday M Bhat <uday.m.bhat@intel.com>

SCP registers needs to be updated to accommodate additional
register entries as per the Soundwire 1.2 specification.

Signed-off-by: Uday M Bhat <uday.m.bhat@intel.com>
Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/debugfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
index c3a1a359ee5c..d1553cb77187 100644
--- a/drivers/soundwire/debugfs.c
+++ b/drivers/soundwire/debugfs.c
@@ -86,10 +86,17 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
 
 	/* SCP registers */
 	ret += scnprintf(buf + ret, RD_BUF - ret, "\nSCP\n");
-	for (i = SDW_SCP_INT1; i <= SDW_SCP_BANKDELAY; i++)
+	for (i = SDW_SCP_INT1; i <= SDW_SCP_BUS_CLOCK_BASE; i++)
 		ret += sdw_sprintf(slave, buf, ret, i);
 	for (i = SDW_SCP_DEVID_0; i <= SDW_SCP_DEVID_5; i++)
 		ret += sdw_sprintf(slave, buf, ret, i);
+	for (i = SDW_SCP_FRAMECTRL_B0; i <= SDW_SCP_BUSCLOCK_SCALE_B0; i++)
+		ret += sdw_sprintf(slave, buf, ret, i);
+	for (i = SDW_SCP_FRAMECTRL_B1; i <= SDW_SCP_BUSCLOCK_SCALE_B1; i++)
+		ret += sdw_sprintf(slave, buf, ret, i);
+	for (i = SDW_SCP_PHY_OUT_CTRL_0; i <= SDW_SCP_PHY_OUT_CTRL_7; i++)
+		ret += sdw_sprintf(slave, buf, ret, i);
+
 
 	/*
 	 * SCP Bank 0/1 registers are read-only and cannot be
-- 
2.25.1

