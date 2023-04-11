Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2006DD0C7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjDKEXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjDKEXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:23:13 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1752D57;
        Mon, 10 Apr 2023 21:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681186989; x=1712722989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cuh+cpF2Dbk1u6YNouEfBinVXPTes5iWxZU0sb3auIQ=;
  b=jMhxbaYMOxIjOzIyXSxILRSiUCC3dUS1bkyGiA2gDaVFDOnzA1NUCr4a
   TWbhEhk/gKmVP0HfK0pyoWx8UN427/5NdUKmh+Yrtyzi5LLHF0goORLsK
   Bb4zwDzyPT5SslerckEqfH19tJyZuCNtSCoqj2z0W8685nuNutOoKsJfS
   MRAEvPxWaW7Jykoxcd0eDmHHzG9SfN4Ci4MrEj1VGFQo55NjYPUulicn5
   IN3eghm+LkZFEp0n+BtyDqq+QAzoRUdev/lhCcj7jhP5ZBQa7HLAzxt82
   qHy4U7sJyeqNaJFAUkdM476EJo4XAr5C6/wZCHanDhjdBf/8qaJkdg+l3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341010195"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="341010195"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 21:23:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="721045427"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="721045427"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by orsmga001.jf.intel.com with ESMTP; 10 Apr 2023 21:23:07 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>
Cc:     Ye Bin <yebin10@huawei.com>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v2 1/2] PM: hibernate: Turn snapshot_test into global variable
Date:   Tue, 11 Apr 2023 20:18:55 +0800
Message-Id: <198a54f0c749dcfc7e857fe33e13f514431ede24.1681186310.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1681186310.git.yu.c.chen@intel.com>
References: <cover.1681186310.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is need to check snapshot_test and open block device
in different mode, so as to avoid the race condition.

No functional changes intended.

Suggested-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/power/hibernate.c | 7 ++++++-
 kernel/power/power.h     | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 793c55a2becb..aa551b093c3f 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -64,6 +64,7 @@ enum {
 static int hibernation_mode = HIBERNATION_SHUTDOWN;
 
 bool freezer_test_done;
+bool snapshot_test;
 
 static const struct platform_hibernation_ops *hibernation_ops;
 
@@ -716,7 +717,6 @@ static int load_image_and_restore(void)
  */
 int hibernate(void)
 {
-	bool snapshot_test = false;
 	unsigned int sleep_flags;
 	int error;
 
@@ -744,6 +744,9 @@ int hibernate(void)
 	if (error)
 		goto Exit;
 
+	/* protected by system_transition_mutex */
+	snapshot_test = false;
+
 	lock_device_hotplug();
 	/* Allocate memory management structures */
 	error = create_basic_memory_bitmaps();
@@ -940,6 +943,8 @@ static int software_resume(void)
 	 */
 	mutex_lock_nested(&system_transition_mutex, SINGLE_DEPTH_NESTING);
 
+	snapshot_test = false;
+
 	if (swsusp_resume_device)
 		goto Check_image;
 
diff --git a/kernel/power/power.h b/kernel/power/power.h
index b4f433943209..b83c8d5e188d 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -59,6 +59,7 @@ asmlinkage int swsusp_save(void);
 
 /* kernel/power/hibernate.c */
 extern bool freezer_test_done;
+extern bool snapshot_test;
 
 extern int hibernation_snapshot(int platform_mode);
 extern int hibernation_restore(int platform_mode);
-- 
2.25.1

