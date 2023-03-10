Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053FE6B4D9C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCJQvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjCJQuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:50:32 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D99F13482E;
        Fri, 10 Mar 2023 08:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678466861; x=1710002861;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=j3a+pSqIIQuyILIQAWllEvax3sYCFju0/icmipo/1ho=;
  b=FsvkistmTxCntSOFdc6juR9mWg2jlI5GGitVf63ApKTl64g/8nUgJb5N
   Ejk8F9lbOXEhpne3397J945UMs5lJ1tEd6aWCGOXUrx2i4E9euQqHJR6j
   xYq8xq3Mpy+zpI8GQNmFfhL5v5CLrDAQC2uEfdWFm8BnFxXLtHLccZyAv
   CWwDfI05f5YXL/wqFJIO7Mr8YHKITV0dc2D0djIMXn4w3RWPeJLKZpik2
   9M/Q7Fq8U7X6Vq1w0Okbt7soVKhRTD7+457MQL11JjSZWrWD99w4Kfoay
   iY/nLNW/Of5nK7KReo9M3wUrEjkCaQLXITpygIBAt8kF1OuCwkF2xGvSC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="320621156"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="320621156"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 08:45:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="746778639"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="746778639"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2023 08:45:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6000B3CB; Fri, 10 Mar 2023 18:45:53 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] pktcdvd: Get rid of redundant 'else'
Date:   Fri, 10 Mar 2023 18:45:48 +0200
Message-Id: <20230310164549.22133-9-andriy.shevchenko@linux.intel.com>
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

In the snippets like the following

	if (...)
		return / goto / break / continue ...;
	else
		...

the 'else' is redundant. Get rid of it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
2.39.1

