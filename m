Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4FF5F5AB8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 21:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiJETq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 15:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiJETqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 15:46:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1107D7B2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 12:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664999213; x=1696535213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zRWwRpbiOQOW4sxB9u223LEznth1SQbFoc8XekDB7xw=;
  b=YkNVhLHLhs++kqjg18TTyLnp6OwEP0wB6cno74780LJ8RETLTtudVNgt
   H/gpZQvl3ejoSshh4f/Zs6axMGOGAMFQTXYguq7tp31RQsJ9tyjrmFVGs
   afWipHdQe2M7y/Qt5ko05Wgt7RgSaMEHHHqcUw3YhUf5Onq2e2Vwo3HAR
   8HQeV5pOerUdktfhcl0bIUQnbNJPnjD0/kE4xnT3QfwoCM4FfjPlteu5M
   A2/gYYqIe94hElVGDGWoTk0S3NjzTRSh2ieNFRyHATcMUARR+cOWG33il
   cdYFUcZBNaAYJ+lwGoF2t6UqL6yXxn4nbdROIgSk/anJeWNIiFFzwWTVf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="304836274"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="304836274"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 12:46:52 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="693048468"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="693048468"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 12:46:52 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2] RAS: Fix the trace_show() function to output trace_count
Date:   Wed,  5 Oct 2022 12:46:44 -0700
Message-Id: <20221005194644.311204-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <Yz3KI5qY70rvJV63@zn.tnic>
References: <Yz3KI5qY70rvJV63@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The /sys/kernel/debug/ras/daemon_active file is used to indicate to some
kernel code whether there is a user mode consumer of RAS trace events
to decide whether to print to the console.

It looks like the intent was that reading the file would show the count
of tasks with the file open. But the code in the trace_show() function
is nonsense.

Add a seq_printf() to output the current value of the trace_count.

Fixes: d963cd95bea9 ("RAS, debugfs: Add debugfs interface for RAS subsystem")
Signed-off-by: Tony Luck <tony.luck@intel.com>
---

V2: Updated commit description based on feedback from Boris

 drivers/ras/debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
index 0d4f985afbf3..d67af5e08caf 100644
--- a/drivers/ras/debugfs.c
+++ b/drivers/ras/debugfs.c
@@ -15,7 +15,8 @@ EXPORT_SYMBOL_GPL(ras_userspace_consumers);
 
 static int trace_show(struct seq_file *m, void *v)
 {
-	return atomic_read(&trace_count);
+	seq_printf(m, "%d\n", atomic_read(&trace_count));
+	return 0;
 }
 
 static int trace_open(struct inode *inode, struct file *file)
-- 
2.37.3

