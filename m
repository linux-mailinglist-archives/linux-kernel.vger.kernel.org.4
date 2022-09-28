Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7BF5EDE4F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbiI1N5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiI1N51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:57:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E8852814;
        Wed, 28 Sep 2022 06:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664373447; x=1695909447;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yJ6+49HFr+oDLMxfyQGefKBQ8j0Hnt0G1q40J+YPBGE=;
  b=Esw9uKvS5W+Q7bX9McUQZsx8wmHsKGBJMsOdS5/jmPG/HaWMDOpbXFIW
   y8naaZRw0SLhwhsnX5HgP6KDh5AlKc/YdQvqD/nTxrJ3b4xz6wIMAAC6U
   Ig3pkQLyjYO5Najq+qKCOJsNAHdJcspjiMfSVHl5N0Yadw7x4aCpsdCj9
   j01huV00ZNlXqThYZEfFwePob37AfVArJwgLsytwJclRaqPHoMxZ3H5It
   Nn0QDyeX1biXd5iO4v6oynbPm8A9P1SEu16bexBl/uxxU30rY45CjHblu
   JxiUCGZEF7dNKziGafnSrv4OMAjB8ulxyg8Yj+4hx4swdvrknhL4Hxrpd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="302518541"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="302518541"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 06:57:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="621930496"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="621930496"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 28 Sep 2022 06:57:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E6C33101; Wed, 28 Sep 2022 16:57:43 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/1] docs: filesystems: sysfs: Make text and code for ->show() consistent
Date:   Wed, 28 Sep 2022 16:57:41 +0300
Message-Id: <20220928135741.54919-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation says that ->show() should only use sysfs_emit() or
sysfs_emit_at(), but example keeps outdated code. Update the code to
be consistent.

Fixes: 2efc459d06f1 ("sysfs: Add sysfs_emit and sysfs_emit_at to format sysfs output")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/filesystems/sysfs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystems/sysfs.rst
index 004d490179f3..8bba676b1365 100644
--- a/Documentation/filesystems/sysfs.rst
+++ b/Documentation/filesystems/sysfs.rst
@@ -263,7 +263,7 @@ A very simple (and naive) implementation of a device attribute is::
     static ssize_t show_name(struct device *dev, struct device_attribute *attr,
 			    char *buf)
     {
-	    return scnprintf(buf, PAGE_SIZE, "%s\n", dev->name);
+	    return sysfs_emit(buf, "%s\n", dev->name);
     }
 
     static ssize_t store_name(struct device *dev, struct device_attribute *attr,
-- 
2.35.1

