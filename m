Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2E36D2F22
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 10:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjDAI7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 04:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDAI7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 04:59:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985234EC8;
        Sat,  1 Apr 2023 01:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680339569; x=1711875569;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Bc7ArXz/vWXFGr5BByH146n6s1vyUE41mjE6rULWOSY=;
  b=TD5EP3EQuPSsxLrl9IXmI4GVs79I+qFqh0kRkOIQa4lVnojlFU1ANBZV
   CdC2P2mKbn/0PW4+51gWF9NNhQ5r5tMbU32K+DKxdaGw3GgZ6lesqumXK
   C8ZZliM4Mw/Irx1Lh0NghJ6tHAtiio+0yz/ew6vYVDGKqSL57JH4HYO7n
   cRLV8QItCnA8McT50JLgm0I3+30mzeFLyDJ1f5FVdwnMAdGb5A4HWl+K3
   TFiAnkBVEdbBOQe2kD2C+mLCOo5ByGFbFy2vlb7vD/yW/zWxbmGN7fsWq
   OGtm+4AlHb2V2I1AR5hAqlEHbY3hiyrK9h7PsPaYemQgxRnS+sHoupu1Q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="343314041"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="343314041"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 01:59:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="635557538"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="635557538"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by orsmga003.jf.intel.com with ESMTP; 01 Apr 2023 01:59:26 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>
Cc:     Ye Bin <yebin10@huawei.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Yifan Li <yifan2.li@intel.com>
Subject: [PATCH] PM: hibernate: Do not get block device exclusively in test_resume mode
Date:   Sun,  2 Apr 2023 00:55:40 +0800
Message-Id: <20230401165540.322665-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The system refused to do a test_resume because it found that the
swap device has already been taken by someone else. Specificly,
the swsusp_check()->blkdev_get_by_dev(FMODE_EXCL) is supposed to
do this check.

Steps to reproduce:
 dd if=/dev/zero of=/swapfile bs=$(cat /proc/meminfo | 
       awk '/MemTotal/ {print $2}') count=1024 conv=notrunc
 mkswap /swapfile
 swapon /swapfile
 swap-offset /swapfile
 echo 34816 > /sys/power/resume_offset
 echo test_resume > /sys/power/disk
 echo disk > /sys/power/state

 PM: Using 3 thread(s) for compression
 PM: Compressing and saving image data (293150 pages)...
 PM: Image saving progress:   0%
 PM: Image saving progress:  10%
 ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
 ata1.00: configured for UDMA/100
 ata2: SATA link down (SStatus 0 SControl 300)
 ata5: SATA link down (SStatus 0 SControl 300)
 ata6: SATA link down (SStatus 0 SControl 300)
 ata3: SATA link down (SStatus 0 SControl 300)
 ata4: SATA link down (SStatus 0 SControl 300)
 PM: Image saving progress:  20%
 PM: Image saving progress:  30%
 PM: Image saving progress:  40%
 PM: Image saving progress:  50%
 pcieport 0000:00:02.5: pciehp: Slot(0-5): No device found
 PM: Image saving progress:  60%
 PM: Image saving progress:  70%
 PM: Image saving progress:  80%
 PM: Image saving progress:  90%
 PM: Image saving done
 PM: hibernation: Wrote 1172600 kbytes in 2.70 seconds (434.29 MB/s)
 PM: S|
 PM: hibernation: Basic memory bitmaps freed
 PM: Image not found (code -16)

This is because when using the swapfile as the hibernation storage,
the block device where the swapfile is located has already been mounted
by the OS distribution(usually been mounted as the rootfs). This is not
an issue for normal hibernation, because software_resume()->swsusp_check()
happens before the block device(rootfs) mount. But it is a problem for the
test_resume mode. Because when test_resume happens, the block device has
been mounted already.

Thus remove the FMODE_EXCL for test_resume mode. This would not be a
problem because in test_resume stage, the processes have already been
frozen, and the race condition described in
Commit 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
is unlikely to happen.

Fixes: 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
Reported-by: Yifan Li <yifan2.li@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/power/hibernate.c | 18 +++++++++++-------
 kernel/power/power.h     |  2 +-
 kernel/power/swap.c      | 10 +++++++---
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 793c55a2becb..f50456e72f0a 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -683,22 +683,26 @@ static void power_down(void)
 		cpu_relax();
 }
 
-static int load_image_and_restore(void)
+static int load_image_and_restore(bool safe)
 {
+	fmode_t mode = FMODE_READ;
 	int error;
 	unsigned int flags;
 
 	pm_pr_dbg("Loading hibernation image.\n");
 
+	if (!safe)
+		mode |= FMODE_EXCL;
+
 	lock_device_hotplug();
 	error = create_basic_memory_bitmaps();
 	if (error) {
-		swsusp_close(FMODE_READ | FMODE_EXCL);
+		swsusp_close(mode);
 		goto Unlock;
 	}
 
 	error = swsusp_read(&flags);
-	swsusp_close(FMODE_READ | FMODE_EXCL);
+	swsusp_close(mode);
 	if (!error)
 		error = hibernation_restore(flags & SF_PLATFORM_MODE);
 
@@ -785,9 +789,9 @@ int hibernate(void)
 	unlock_device_hotplug();
 	if (snapshot_test) {
 		pm_pr_dbg("Checking hibernation image\n");
-		error = swsusp_check();
+		error = swsusp_check(true);
 		if (!error)
-			error = load_image_and_restore();
+			error = load_image_and_restore(true);
 	}
 	thaw_processes();
 
@@ -983,7 +987,7 @@ static int software_resume(void)
 		MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
 
 	pm_pr_dbg("Looking for hibernation image.\n");
-	error = swsusp_check();
+	error = swsusp_check(false);
 	if (error)
 		goto Unlock;
 
@@ -1011,7 +1015,7 @@ static int software_resume(void)
 		goto Close_Finish;
 	}
 
-	error = load_image_and_restore();
+	error = load_image_and_restore(false);
 	thaw_processes();
  Finish:
 	pm_notifier_call_chain(PM_POST_RESTORE);
diff --git a/kernel/power/power.h b/kernel/power/power.h
index b4f433943209..66a7595ad3e7 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -173,7 +173,7 @@ extern int swsusp_swap_in_use(void);
 #define SF_HW_SIG		8
 
 /* kernel/power/hibernate.c */
-extern int swsusp_check(void);
+extern int swsusp_check(bool safe);
 extern void swsusp_free(void);
 extern int swsusp_read(unsigned int *flags_p);
 extern int swsusp_write(unsigned int flags);
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 36a1df48280c..1be0257da8ab 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1514,13 +1514,17 @@ int swsusp_read(unsigned int *flags_p)
  *      swsusp_check - Check for swsusp signature in the resume device
  */
 
-int swsusp_check(void)
+int swsusp_check(bool safe)
 {
+	fmode_t mode = FMODE_READ;
 	int error;
 	void *holder;
 
+	if (!safe)
+		mode |= FMODE_EXCL;
+
 	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device,
-					    FMODE_READ | FMODE_EXCL, &holder);
+					    mode, &holder);
 	if (!IS_ERR(hib_resume_bdev)) {
 		set_blocksize(hib_resume_bdev, PAGE_SIZE);
 		clear_page(swsusp_header);
@@ -1547,7 +1551,7 @@ int swsusp_check(void)
 
 put:
 		if (error)
-			blkdev_put(hib_resume_bdev, FMODE_READ | FMODE_EXCL);
+			blkdev_put(hib_resume_bdev, mode);
 		else
 			pr_debug("Image signature found, resuming\n");
 	} else {
-- 
2.25.1

