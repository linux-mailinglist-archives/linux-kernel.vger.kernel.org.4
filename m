Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED7A60313A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiJRQ7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiJRQ7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:59:18 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B20ED9B2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666112355; x=1697648355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8L7Kzq1+x/vIL40N0kqvIsFh/ZGsBTQNt2/eP3b/BVg=;
  b=cF/4MPLohsjiBlru8VQgmqyE5/2OdpGhJ0bNmGLb/ZdSATuGN3VJcsuM
   yQi3wUsqhf29MzUDIv2XynhbCUpAGjCCPUtf2SO97XXjWgOmDZYA+cvS2
   7CDNF9Z8UQPvKLpF5jvgDySOQ30qyGiA3TETJMFCl1GykK//LD2YjwL0d
   wxwG6J+OeyYcpp8U2flAZkKSjZJ22Fn8ww33jVTwsR0YLCrbGYc77UHJ7
   pz/QGfV8co5zxp+7vxj2UbmObQYbth5RXy1C3eWitsO2tLGYdxABZpJZ1
   bV2LDMDnzmVcpePDhGGVbRKGynV3/ktbnkAbs1Sk0fKNIDzoNLxmAv376
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="370364126"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="370364126"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 09:59:07 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="771301491"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="771301491"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 09:59:07 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3] RAS: Fix return value from show_trace()
Date:   Tue, 18 Oct 2022 09:59:00 -0700
Message-Id: <20221018165900.109029-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <Y066BV4jiRMxgjYV@agluck-desk3.sc.intel.com>
References: <Y066BV4jiRMxgjYV@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/filesystems/seq_file.rst describes the possible return
values from a "show()" function used by single_open().

show_trace() returns the value of "trace_count" this could be interpreted
as "SEQ_SKIP", or just confuse the calling function.

Change to just return "0" to avoid confusing anyone reading this code
and possibly using as a template. Reading "daemon_active" was never
an intended use case.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---
V3: Boris: "let's keep this effort minimal and only address valid use
cases"
---
 drivers/ras/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
index 0d4f985afbf3..f0a6391b1146 100644
--- a/drivers/ras/debugfs.c
+++ b/drivers/ras/debugfs.c
@@ -15,7 +15,7 @@ EXPORT_SYMBOL_GPL(ras_userspace_consumers);
 
 static int trace_show(struct seq_file *m, void *v)
 {
-	return atomic_read(&trace_count);
+	return 0;
 }
 
 static int trace_open(struct inode *inode, struct file *file)
-- 
2.37.3

