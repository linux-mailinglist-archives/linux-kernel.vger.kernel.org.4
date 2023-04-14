Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776436E1B04
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 06:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjDNEPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 00:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDNEOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 00:14:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90862524B;
        Thu, 13 Apr 2023 21:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681445688; x=1712981688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dsi8NCRi2VJpWEZHMlW1fz/LRYWvxDuxdrK0U2M3dMA=;
  b=IQFo4SIaFAKSDP/D9a1qoTmkwiaHDj3xzBfwSDvT6VJTc24oUpIonaLH
   m88TcR+nQw5Zufwys9vy4dm4iWuUStsaJX0e3g89pAoFOWWDPucUPECYp
   HgVLOcXqh1uzVl5ZiC3JCvPM8NQia68+5VcMOkKeqGTdxbKfN+FCadZVW
   uC5HHVMw3nQSjEQLD3eV5Yi41GoZlFyTnIMTtRK/oCgp5qpR9UwLE/KKk
   Cg8nF1fOQ78ocFUbGI11vZU+/6FDclXYD65AsBQj/67rrXt5UqJDrfrbR
   WY8mFVYFNE71MsBi5LGDqyqj5rFbRwdMKNefLqXoQ6rv6UXVoDj+9KMZ2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="333142697"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="333142697"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 21:14:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="935863770"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="935863770"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by fmsmga006.fm.intel.com with ESMTP; 13 Apr 2023 21:14:45 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>
Cc:     Ye Bin <yebin10@huawei.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Yifan Li <yifan2.li@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Wendy Wang <wendy.wang@intel.com>
Subject: [PATCH v3 2/2] PM: hibernate: Do not get block device exclusively in test_resume mode
Date:   Fri, 14 Apr 2023 20:10:42 +0800
Message-Id: <7d9e20406c9309abfc077f776881f810c1e6122a.1681443714.git.yu.c.chen@intel.com>
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

The system refused to do a test_resume because it found that the
swap device has already been taken by someone else. Specifically,
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
by the OS distribution(usually mounted as the rootfs). This is not
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
Suggested-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Tested-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Tested-by: Wendy Wang <wendy.wang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/power/hibernate.c | 8 ++++++--
 kernel/power/swap.c      | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index aa551b093c3f..30d1274f03f6 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -688,18 +688,22 @@ static int load_image_and_restore(void)
 {
 	int error;
 	unsigned int flags;
+	fmode_t mode = FMODE_READ;
+
+	if (snapshot_test)
+		mode |= FMODE_EXCL;
 
 	pm_pr_dbg("Loading hibernation image.\n");
 
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
 
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 36a1df48280c..92e41ed292ad 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1518,9 +1518,13 @@ int swsusp_check(void)
 {
 	int error;
 	void *holder;
+	fmode_t mode = FMODE_READ;
+
+	if (snapshot_test)
+		mode |= FMODE_EXCL;
 
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

