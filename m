Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E48B6758F0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjATPoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjATPoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:44:08 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D5559264;
        Fri, 20 Jan 2023 07:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674229447; x=1705765447;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oBVSJGdmqluJ+m0kpxYQdXUIQZYypRK6F57krHn+9Cs=;
  b=LVhdOo43ck4HjZ8K7sa6VjjR/sf/qeAD5nK1IOTcOqW741LcPgsuztJP
   4s7RuWtrC4gt9D5C4D+QfGhV6Ct42fCaQNIacOWYcfpEgwT/8jj4K7YGV
   FNPpJVSACLKedwMxEFmzCXNbMUTtZGCPzxJGmneGha+Rz21qVqdwT3sF7
   pSCb4m+m79DKHAb3PmuRvMerA6vuXIEAfyOD4aSppGXO6oWZVHfnGffeg
   lo/tPDQgGjAALOroCFGb2i4gNLY+ApMoQK90vEHPC+bxTaRYiz03w7O02
   mWt4OrJRmk1CcRajMzYfFd6+7LF/NFJ9Iw4nvxLs5tJ+cynfiFhsqTAHS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="390114958"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="390114958"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 07:44:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="989427700"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="989427700"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 20 Jan 2023 07:44:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E7A85368; Fri, 20 Jan 2023 17:44:39 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/5] usb: fotg210-hcd: use sysfs_emit() to instead of scnprintf()
Date:   Fri, 20 Jan 2023 17:44:33 +0200
Message-Id: <20230120154437.22025-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
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

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/fotg210/fotg210-hcd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/fotg210/fotg210-hcd.c b/drivers/usb/fotg210/fotg210-hcd.c
index 7bd1e8f3080d..46752a75c428 100644
--- a/drivers/usb/fotg210/fotg210-hcd.c
+++ b/drivers/usb/fotg210/fotg210-hcd.c
@@ -4686,14 +4686,11 @@ static ssize_t uframe_periodic_max_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct fotg210_hcd *fotg210;
-	int n;
 
 	fotg210 = hcd_to_fotg210(bus_to_hcd(dev_get_drvdata(dev)));
-	n = scnprintf(buf, PAGE_SIZE, "%d\n", fotg210->uframe_periodic_max);
-	return n;
+	return sysfs_emit(buf, "%d\n", fotg210->uframe_periodic_max);
 }
 
-
 static ssize_t uframe_periodic_max_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
-- 
2.39.0

