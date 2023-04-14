Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9486E6E1B02
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 06:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjDNEOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 00:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjDNEOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 00:14:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78414210B;
        Thu, 13 Apr 2023 21:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681445678; x=1712981678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cuh+cpF2Dbk1u6YNouEfBinVXPTes5iWxZU0sb3auIQ=;
  b=bv9IsDIIwzXNAeSTi7h/Cifk/N6LvATgmgHVh6YjKZkPPxPQkQg2DUuQ
   +f6lua8AKRQtyhGOuv9JrXToeAj8zL+pODSO9eyB61NxU4RGssbgGzJ+7
   PZlFAoPIToh2kzXYSgLQYJ596Bkp5p1ZE1YUXHk00ZjaEkxg8IvcG9f/W
   arVMS19HYnazKf6AktlI7LqNmkqoTo1ealAFztjFzDoD3nHawWanP0bTS
   3U8jq8aSCIKW71EXdRCiQMooMBNJPe2kqu7lmUbor9CMDJUZ4VieNvAAH
   t8cuImj7XVd9QyzqQIbQxIr2ya4uLgb0yiB93UpWavFXS1F8eC2sj6kW8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="333142652"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="333142652"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 21:14:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="935863717"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="935863717"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by fmsmga006.fm.intel.com with ESMTP; 13 Apr 2023 21:14:35 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>
Cc:     Ye Bin <yebin10@huawei.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Yifan Li <yifan2.li@intel.com>, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v3 1/2] PM: hibernate: Turn snapshot_test into global variable
Date:   Fri, 14 Apr 2023 20:10:26 +0800
Message-Id: <5235527bde72c568fb26d268cf3091e8ce080306.1681443714.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1681443714.git.yu.c.chen@intel.com>
References: <cover.1681443714.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

