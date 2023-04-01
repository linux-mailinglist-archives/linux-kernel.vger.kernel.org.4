Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E2A6D2EF6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 09:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbjDAHwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 03:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjDAHwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 03:52:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E071D2FA;
        Sat,  1 Apr 2023 00:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680335541; x=1711871541;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a/YXkBYf71djBB8rDZkSEdiLjo6nNWgJccOZOVfbVsU=;
  b=ETN+c5FHXT1A73tcXpne+hVZ01VExzy1jqHW/NGAKrkjQQd0ZCNVSzgf
   D1DkBfQ1XmsHi9/oOYG2p6QVRitxRPFMnlxsXa+EOUitNUat6I+9PEtKU
   Er4DFbHSNzzJ7DimqFFzU3W7d3NYCjRozj6XTD7GxXTgal4szTW9TAQh0
   LMQycgVrbFuX2Fn2pb4FWtw8I938OJzlorl+fYXu32MQ+Zj37MoVOmH6F
   R5BRtY437HvRYKACYNdKQFax2vC7N/lfPMZv8m4Y7cf3e3T0y+wZN+QfM
   xgKRTIhzwQzuPXBH6VoNopwV00TCnJWABTEDBkepzJYBDAmxHYv+aHAgx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="369424953"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="369424953"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 00:52:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="1015103954"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="1015103954"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by fmsmga005.fm.intel.com with ESMTP; 01 Apr 2023 00:52:17 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>
Cc:     Ye Bin <yebin10@huawei.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Yifan Li <yifan2.li@intel.com>
Subject: [PATCH] PM: hibernate: Do not get block device exclusively in test_resume mode
Date:   Sat,  1 Apr 2023 23:48:32 +0800
Message-Id: <20230401154832.320999-1-yu.c.chen@intel.com>
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
 kernel/power/hibernate.c |  4 ++--
 kernel/power/power.h     |  2 +-
 kernel/power/swap.c      | 10 +++++++---
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 793c55a2becb..81287bfa7543 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -785,7 +785,7 @@ int hibernate(void)
 	unlock_device_hotplug();
 	if (snapshot_test) {
 		pm_pr_dbg("Checking hibernation image\n");
-		error = swsusp_check();
+		error = swsusp_check(true);
 		if (!error)
 			error = load_image_and_restore();
 	}
@@ -983,7 +983,7 @@ static int software_resume(void)
 		MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
 
 	pm_pr_dbg("Looking for hibernation image.\n");
-	error = swsusp_check();
+	error = swsusp_check(false);
 	if (error)
 		goto Unlock;
 
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

