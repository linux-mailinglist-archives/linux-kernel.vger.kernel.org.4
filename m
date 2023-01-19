Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485806745E9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjASWYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjASWWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:22:12 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2014A1016;
        Thu, 19 Jan 2023 14:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674166069; x=1705702069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D0afb+O5KOonQ7n+AOXMGSDsyQMMe2+F9rSUtTnjekg=;
  b=TVjUOfdXegaCTR6i+ol95XE8QnvBvsZ7ZG174/kku+DH8LESTZc/MT4i
   Xfpy4WMKxLUXsYOgXDqhmy4OvVgchpAE+kr0ytLmXlIPAgba+K+an4fRC
   XzjgOtEKACQolppXehVZ70DyNXn4q+UOoxxS05vypMfYr+nOvn8HG74NF
   T+9aKw8ZE/nCVRH+xoVGhxebMvT69i6FNzamJk7cZ2qEB97lTezo2G3Fg
   bN+EB3V0y6kSAh6mkWx/bz7rv8MDp5xMlNxTzrugYa302vtfANArUkqkg
   O3he3nwNlaT4GlkjP4qp8UJe2eBm0uNgOwTToxczzS2faD8n+X/zWlk4c
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="323130667"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="323130667"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 14:07:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="784226650"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="784226650"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 19 Jan 2023 14:07:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 64F813DF; Fri, 20 Jan 2023 00:08:15 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 6/9] pktcdvd: Use DEFINE_SHOW_ATTRIBUTE() to simplify code
Date:   Fri, 20 Jan 2023 00:08:06 +0200
Message-Id: <20230119220809.5518-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119220809.5518-1-andriy.shevchenko@linux.intel.com>
References: <20230119220809.5518-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE() helper macro to simplify the code.
No functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
2.39.0

