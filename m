Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440185F5834
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiJEQRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiJEQQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:16:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4574C7E002
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 09:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664986614; x=1696522614;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rYRwGdwzt3B42VGLzCzhptdfzDfQfwdNQ8dGGnTWNDk=;
  b=i7l/CvMlS2HBznMhEx5Bvw0dynNy3qf92whNqk2+30pnEncKQYFIyLC9
   PNTfFYc2oeiwLh49aWViA3ZJ3awC7CLXxf5z2RSkDIbg9IQ+j6xHBHUbb
   rsX4xWVXkswIzoJVj3snYTJ4uydduEQov2cAk5Zw8rUJAwrpAMR6o39fM
   6VN8pZ9IKBJDZDvLXsv+bw2h63ZJ6h4qGcI9VivllxBOkaI3S6XXe/D5e
   JH72AZx3qnnpgsubn9zHBR5Akn6gMUD4x10Ttz60vI75WbU48sFk2930a
   q9PUYgSjAj4vaNe2RhXCiJ30AFfmuwpHUcLLjSWpqN449NwuiNXsOv9vp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="282914724"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="282914724"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 09:16:53 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="953219597"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="953219597"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 09:16:53 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] RAS: Fix the trace_show() function to output trace_count
Date:   Wed,  5 Oct 2022 09:16:45 -0700
Message-Id: <20221005161645.309068-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The /sys/kernel/debug/ras/daemon_active is used to indicate to some
kernel code whether there is a user mode consumer of RAS trace events
to decide whether to print to the console.

The intent was that reading daemon_active would give the same indication
to users. But the code is broken and does not display anything.

Add a seq_printf() to output the current value of the trace_count.

Fixes: d963cd95bea9 ("RAS, debugfs: Add debugfs interface for RAS subsystem")
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
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

