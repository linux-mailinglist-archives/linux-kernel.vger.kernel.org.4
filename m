Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F606B9864
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjCNO5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjCNO5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:57:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA06BA72B4;
        Tue, 14 Mar 2023 07:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678805854; x=1710341854;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wsWt0ajWiHIUCoESjiyIhbxqW6sgiOPv1o6XUe8cND8=;
  b=nak9xn6A6h9znMQG9MbzmkvslDX5LFOW2xY+cc3jGhH1agtQV/UZofBP
   39C7O7iQFubr+El6HnmDS7CUQjMLKdgUtffK3VRLC+LovBnNgsCKziPwF
   v9aK34mJDaHhGp1GH11dxp0BVc7tYJi/4NvWmPTHb167roZw4LWchpPSN
   pNlH6HrvCCGdUUXbPPC3WuZjXXsly1F5VYgSgAi2vD5OjR7SoMvrfitsX
   9zZv4h1VHH1aPxZmNIffjWcz/Bmosg34EOgkteSeb0Ul3cae7WTVWOeT1
   f/3O3xW8mVLM+oeBZ2vFjCvwZRKpvleHtY7sJ/T94L00rEB400LSAae6L
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="334929591"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="334929591"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 07:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="629063168"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="629063168"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 14 Mar 2023 07:57:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CF4C0209; Tue, 14 Mar 2023 16:58:16 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v1 1/1] scsi: fnic: Switch to use %ptTs
Date:   Tue, 14 Mar 2023 16:58:13 +0200
Message-Id: <20230314145813.66112-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use %ptTs instead of open-coded variant to print contents
of time64_t type in human readable form.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/scsi/fnic/fnic_trace.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_trace.c b/drivers/scsi/fnic/fnic_trace.c
index e03967463561..f3c3a26a1384 100644
--- a/drivers/scsi/fnic/fnic_trace.c
+++ b/drivers/scsi/fnic/fnic_trace.c
@@ -781,28 +781,21 @@ void copy_and_format_trace_data(struct fc_trace_hdr *tdata,
 				fnic_dbgfs_t *fnic_dbgfs_prt, int *orig_len,
 				u8 rdata_flag)
 {
-	struct tm tm;
 	int j, i = 1, len;
-	char *fc_trace, *fmt;
 	int ethhdr_len = sizeof(struct ethhdr) - 1;
 	int fcoehdr_len = sizeof(struct fcoe_hdr);
 	int fchdr_len = sizeof(struct fc_frame_header);
 	int max_size = fnic_fc_trace_max_pages * PAGE_SIZE * 3;
+	char *fc_trace;
 
 	tdata->frame_type = tdata->frame_type & 0x7F;
 
 	len = *orig_len;
 
-	time64_to_tm(tdata->time_stamp.tv_sec, 0, &tm);
-
-	fmt = "%02d:%02d:%04ld %02d:%02d:%02d.%09lu ns%8x       %c%8x\t";
-	len += scnprintf(fnic_dbgfs_prt->buffer + len,
-		max_size - len,
-		fmt,
-		tm.tm_mon + 1, tm.tm_mday, tm.tm_year + 1900,
-		tm.tm_hour, tm.tm_min, tm.tm_sec,
-		tdata->time_stamp.tv_nsec, tdata->host_no,
-		tdata->frame_type, tdata->frame_len);
+	len += scnprintf(fnic_dbgfs_prt->buffer + len, max_size - len,
+			 "%ptTs.%09lu ns%8x       %c%8x\t",
+			 &tdata->time_stamp.tv_sec, tdata->time_stamp.tv_nsec,
+			 tdata->host_no, tdata->frame_type, tdata->frame_len);
 
 	fc_trace = (char *)FC_TRACE_ADDRESS(tdata);
 
-- 
2.39.2

