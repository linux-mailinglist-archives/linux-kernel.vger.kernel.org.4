Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0136745E4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjASWYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjASWWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:22:10 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE2794301;
        Thu, 19 Jan 2023 14:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674166064; x=1705702064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Nb+PfTy4Kttk4m28YbXbR4pIOx0SX9GnTAgxRBpkEM=;
  b=bL9kKZMhKK7c8wNIP7QJFuNzH+zzPaZzIl4YMNyg6b62P1yA0XLfObqc
   MvqOz0B0Qf44Jaq/qrmNXIOCDshBBjfjWfQwsy3EC35XkT0PZqFoOnTMx
   uDK1HxkgrHiYLLL2vBTMJhNzft73EhD2N3f3hzclwjKPkTe7n6C90th0W
   58+LBVt41wQWMiOUOtsUNQKWLSlEQxkYyiW91/k0FPrRuR67OiuOMRmKA
   CkBUjemM+60HXuzyRKQwaoFLxajbs4gZdzOc0tcormirxq08sFrEGSzBB
   ks++lHyTex25VUbRzUt1I2OboLFhz7WBAZhye6q+/NYas5dlLJsOlqY9B
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="305114121"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="305114121"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 14:07:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="637879324"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="637879324"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 19 Jan 2023 14:07:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7D1C5488; Fri, 20 Jan 2023 00:08:15 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 8/9] pktcdvd: Get rid of redundant 'else'
Date:   Fri, 20 Jan 2023 00:08:08 +0200
Message-Id: <20230119220809.5518-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119220809.5518-1-andriy.shevchenko@linux.intel.com>
References: <20230119220809.5518-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the snippets like the following

	if (...)
		return / goto / break / continue ...;
	else
		...

the 'else' is redundant. Get rid of it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/block/pktcdvd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 340e953e3888..22048739a245 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -958,25 +958,25 @@ static int pkt_set_segment_merging(struct pktcdvd_device *pd, struct request_que
 {
 	struct device *ddev = disk_to_dev(pd->disk);
 
-	if ((pd->settings.size << 9) / CD_FRAMESIZE
-	    <= queue_max_segments(q)) {
+	if ((pd->settings.size << 9) / CD_FRAMESIZE <= queue_max_segments(q)) {
 		/*
 		 * The cdrom device can handle one segment/frame
 		 */
 		clear_bit(PACKET_MERGE_SEGS, &pd->flags);
 		return 0;
-	} else if ((pd->settings.size << 9) / PAGE_SIZE
-		   <= queue_max_segments(q)) {
+	}
+
+	if ((pd->settings.size << 9) / PAGE_SIZE <= queue_max_segments(q)) {
 		/*
 		 * We can handle this case at the expense of some extra memory
 		 * copies during write operations
 		 */
 		set_bit(PACKET_MERGE_SEGS, &pd->flags);
 		return 0;
-	} else {
-		dev_err(ddev, "cdrom max_phys_segments too small\n");
-		return -EIO;
 	}
+
+	dev_err(ddev, "cdrom max_phys_segments too small\n");
+	return -EIO;
 }
 
 static void pkt_end_io_read(struct bio *bio)
-- 
2.39.0

