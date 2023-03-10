Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8ED6B4D95
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjCJQu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjCJQuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:50:23 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C42119400;
        Fri, 10 Mar 2023 08:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678466849; x=1710002849;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=eyTEBx+P5LFmDblqHINk1Ff4ftWqw30rcM/wV51VRd4=;
  b=UvbRx/WdYp6JasE1wIiwTMgyaQUxPg8wXJb4B71+iMjWBCL56TACvZgE
   KYWj9XWnX2BQu7xpkv5+UmaNfvA9IiHybuqpbTrC+J+D9A25eHWs2YANa
   NiK6kAsCVkav1+BJpc6/ZNkgx5K7guUTEjxF5flQwfKRE4MgD9bhke6aI
   9dHMZHRSSGUjyomPqb7Oc5r3tm5jNhFx+yOyBdQHQRsUsr2TO5iSaoqBg
   0S2K6Yf6kkAolGjnJ4mTMe2cTem7LErjGAcx295nFs6NAfjaT5i6NmXwD
   d/2Eap9h4t/jaAxzyzjgfWRxB6bGL/iQjwPcghc0AD54Ms6OYp+4kl36R
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="320621147"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="320621147"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 08:45:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="677874311"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="677874311"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 10 Mar 2023 08:45:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 46BBC367; Fri, 10 Mar 2023 18:45:53 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] pktcdvd: Use DEFINE_SHOW_ATTRIBUTE() to simplify code
Date:   Fri, 10 Mar 2023 18:45:46 +0200
Message-Id: <20230310164549.22133-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230310164549.22133-1-andriy.shevchenko@linux.intel.com>
References: <20230310164549.22133-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE() helper macro to simplify the code.
No functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/pktcdvd.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index a53d21dbf2ab..2c5441303e55 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -504,24 +504,7 @@ static int pkt_seq_show(struct seq_file *m, void *p)
 			pd->write_congestion_on);
 	return 0;
 }
-
-static int pkt_debugfs_seq_show(struct seq_file *m, void *p)
-{
-	return pkt_seq_show(m, p);
-}
-
-static int pkt_debugfs_fops_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, pkt_debugfs_seq_show, inode->i_private);
-}
-
-static const struct file_operations debug_fops = {
-	.open		= pkt_debugfs_fops_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-	.owner		= THIS_MODULE,
-};
+DEFINE_SHOW_ATTRIBUTE(pkt_seq);
 
 static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
 {
@@ -531,8 +514,8 @@ static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
 	if (!pd->dfs_d_root)
 		return;
 
-	pd->dfs_f_info = debugfs_create_file("info", 0444,
-					     pd->dfs_d_root, pd, &debug_fops);
+	pd->dfs_f_info = debugfs_create_file("info", 0444, pd->dfs_d_root,
+					     pd, &pkt_seq_fops);
 }
 
 static void pkt_debugfs_dev_remove(struct pktcdvd_device *pd)
-- 
2.39.1

