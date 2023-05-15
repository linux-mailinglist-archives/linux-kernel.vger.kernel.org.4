Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654A7702565
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbjEOGwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240298AbjEOGwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:52:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7589826A1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684133511; x=1715669511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SbHuuXPdMaBgfOruu1bZggLsJuDVCwmXsFFke6IavfA=;
  b=f8nvBV/cox3pzavCbuJ3tJVc39Ag23i/StR2+B4Buw8xWX97pSjQi0/H
   eBfjEBJS8mZa9wvRwrXSx/I+6EtSWot73Jyhgy/QJL10u3zRDuG+kvqUe
   u4HHpvd//jHYaU4MfDLFTu4H6sns0fF0Q64qzMGJXfDsdMOn+nUHd/FYr
   ySNyGvLmLU5VXi/BVQ5WOUtjMjIEpPJopiOnJ8GE1IGxMrDs0tpDzaThH
   c3mFXGxEZwj50sRa0VpQzFZPPoI7IV0k0r7iXSC3PU8vr+3Exp8QOcHI/
   0lhmGta2N9Whg16ZZ+xPhuxmKlSg91hlRsNvk2MYVLz/jVQ/BWemuWeAk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="349966491"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="349966491"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:51:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694908759"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="694908759"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:51:01 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org,
        tiwai@suse.de
Cc:     linux-kernel@vger.kernel.org, vinod.koul@linaro.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 18/26] soundwire: intel_ace2x: add check_cmdsync_unlocked helper
Date:   Mon, 15 May 2023 15:10:34 +0800
Message-Id: <20230515071042.2038-19-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
References: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

This is the last callback needed for all bus management routines on
new hardware. Same concept as before, just different register.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index fe950b3ea3bc..a12fee8a5bfa 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -186,6 +186,11 @@ static int intel_sync_go(struct sdw_intel *sdw)
 	return ret;
 }
 
+static bool intel_check_cmdsync_unlocked(struct sdw_intel *sdw)
+{
+	return hdac_bus_eml_sdw_check_cmdsync_unlocked(sdw->link_res->hbus);
+}
+
 /*
  * DAI operations
  */
@@ -366,6 +371,7 @@ const struct sdw_intel_hw_ops sdw_intel_lnl_hw_ops = {
 	.sync_arm = intel_sync_arm,
 	.sync_go_unlocked = intel_sync_go_unlocked,
 	.sync_go = intel_sync_go,
+	.sync_check_cmdsync_unlocked = intel_check_cmdsync_unlocked,
 };
 EXPORT_SYMBOL_NS(sdw_intel_lnl_hw_ops, SOUNDWIRE_INTEL);
 
-- 
2.25.1

