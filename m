Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4D66DD0C9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjDKEX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjDKEX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:23:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7745C2722;
        Mon, 10 Apr 2023 21:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681187002; x=1712723002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iNsCeMH7AuoBioPIEJx2jiuo1QskSURMZ+m/FQDWG+w=;
  b=cX4dDzq9Kl98pLSkdom+KVugZAiriSyKjBMFCMlydk1KHYX48S+slFPd
   y76MI81Miibc/C1PJSNZVfkT1oxJfxThyhGeD943IR8AI5fxJtJWU52Rd
   d5Qv6yO1VggpDjHI3zjozffjgs8Xj95H3vAQgubpoLWJoAKuBvlFKG6V4
   ZnVWW5qYV42zp9/HTowFpb6seP3Wl2rCHjoGGVpYNlDI45n6q6/Dp49s0
   ri3BBFUhCxErpEpwxwabyvcmJSpQFp9DbtVa/DgHEgv1wOofcDZnU68Zp
   h0xtTlDrgarTVnlE+EfurU3fXqvTVgij55vE4YgoqkB4Ni78H7bwQeXJt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341010207"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="341010207"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 21:23:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="721045456"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="721045456"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by orsmga001.jf.intel.com with ESMTP; 10 Apr 2023 21:23:18 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>
Cc:     Ye Bin <yebin10@huawei.com>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>, Yifan Li <yifan2.li@intel.com>
Subject: [PATCH v2 2/2] PM: hibernate: Do not get block device exclusively in test_resume mode
Date:   Tue, 11 Apr 2023 20:19:13 +0800
Message-Id: <8f917ae09c7a09d1841824908107d6c79a6cd090.1681186310.git.yu.c.chen@intel.com>
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
Suggested-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/power/hibernate.c | 5 +++--
 kernel/power/swap.c      | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index aa551b093c3f..defc2257b052 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -688,18 +688,19 @@ static int load_image_and_restore(void)
 {
 	int error;
 	unsigned int flags;
+	fmode_t mode = snapshot_test ? FMODE_READ : (FMODE_READ | FMODE_EXCL);
 
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
index 36a1df48280c..0f699cd96a89 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1518,9 +1518,10 @@ int swsusp_check(void)
 {
 	int error;
 	void *holder;
+	fmode_t mode = snapshot_test ? FMODE_READ : (FMODE_READ | FMODE_EXCL);
 
 	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device,
-					    FMODE_READ | FMODE_EXCL, &holder);
+					    mode, &holder);
 	if (!IS_ERR(hib_resume_bdev)) {
 		set_blocksize(hib_resume_bdev, PAGE_SIZE);
 		clear_page(swsusp_header);
@@ -1547,7 +1548,7 @@ int swsusp_check(void)
 
 put:
 		if (error)
-			blkdev_put(hib_resume_bdev, FMODE_READ | FMODE_EXCL);
+			blkdev_put(hib_resume_bdev, mode);
 		else
 			pr_debug("Image signature found, resuming\n");
 	} else {
-- 
2.25.1

