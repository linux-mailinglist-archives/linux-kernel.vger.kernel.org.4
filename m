Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD8E626A13
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiKLPPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLPPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:15:21 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F9C2D0;
        Sat, 12 Nov 2022 07:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668266120; x=1699802120;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7w9FJuInitetdnszaHj4UPSjYnaM0MxZY/ipUusdnWE=;
  b=l649lpxFpO76ETFqDu/YajIzIYhyh/lVikeA9okD8iMT6T1pCRjHtuoK
   dBBJytssIx82GtPj09VVWixmhfUmJ4oAOOWdD353HXI8uxgRGWCnvCnIo
   1RSUL+cLwIxvM38ze/ptx3ImkoBRVwLA1igIFMHXdoJQWHdP6A/KyFgSO
   EiFHKJ+ik+tW+nn0NiuO5fFPAQKulHOO0dNd1u5oyue4TxERjgrc9kjN6
   X0d2X/zUYIRJDNzAyWBpJoGPcYSxsNtVBURzKHg8AGLX/xLdiylIMenSu
   MTRVMHYeq8+YWd5U6oQcFnnPTPUjNZmB9Ndj6McCpDWWUe7hFZmuvQPbl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="373864310"
X-IronPort-AV: E=Sophos;i="5.96,159,1665471600"; 
   d="scan'208";a="373864310"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 07:15:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="762924419"
X-IronPort-AV: E=Sophos;i="5.96,159,1665471600"; 
   d="scan'208";a="762924419"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.57.165])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 07:15:18 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf/x86/intel/pt: Fix sampling using single range output
Date:   Sat, 12 Nov 2022 17:15:08 +0200
Message-Id: <20221112151508.13768-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deal with errata TGL052, ADL037 and RPL017 "Trace May Contain Incorrect
Data When Configured With Single Range Output Larger Than 4KB" by
disabling single range output whenever larger than 4KB.

Fixes: 670638477aed ("perf/x86/intel/pt: Opportunistically use single range output mode")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/events/intel/pt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 82ef87e9a897..42a55794004a 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1263,6 +1263,15 @@ static int pt_buffer_try_single(struct pt_buffer *buf, int nr_pages)
 	if (1 << order != nr_pages)
 		goto out;
 
+	/*
+	 * Some processors cannot always support single range for more than
+	 * 4KB - refer errata TGL052, ADL037 and RPL017. Future processors might
+	 * also be affected, so for now rather than trying to keep track of
+	 * which ones, just disable it for all.
+	 */
+	if (nr_pages > 1)
+		goto out;
+
 	buf->single = true;
 	buf->nr_pages = nr_pages;
 	ret = 0;
-- 
2.34.1

