Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4BD607FFC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJUUlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiJUUkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:40:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301CD98370;
        Fri, 21 Oct 2022 13:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666384800; x=1697920800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sr0b38xXZ200FAk2bInFJdfJNKcjZ4q1uNqY7iCbQH8=;
  b=Bmbxgweg1QwBJ/TXvIdRzNgRDoW8TApnKfSu8zRPVCt56UdqD9bIbFtB
   +27uxEGzAJpjsYyZfnEGEUt07VKnwe2g9+y36NHH5auNCWdT7NYXvuS1e
   2dJe1+k2ZizI8QpwL5sfH8l83VYfiJQk7VqIbtHjZgoLiomVikaBUfJIB
   +jDYtPZECo/JIgL8/DcGeeeoKPU2qk+seXE6PHpXUXuhp2WtPxeHAtoxa
   9ye1Nuz3gU3NXYsluvwKmNf3KtKAVR2RW15/eKEE3zwNd9Qe45nteZSy+
   XB3j7pnmHH6C4Y6V8DD7xzSh1xATmGmG8banrwISfTBpi+uuKdEUswKLs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="369161187"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="369161187"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:35:36 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="735701033"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="735701033"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:35:36 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com
Subject: [PATCH 11/14] platform/x86/intel/ifs: Remove reload sysfs entry
Date:   Fri, 21 Oct 2022 13:34:10 -0700
Message-Id: <20221021203413.1220137-12-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221021203413.1220137-1-jithu.joseph@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reload sysfs entry is replaced by current_batch, drop it.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/sysfs.c | 28 --------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
index 766cee651bd6..e077910c5d28 100644
--- a/drivers/platform/x86/intel/ifs/sysfs.c
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -87,33 +87,6 @@ static ssize_t run_test_store(struct device *dev,
 
 static DEVICE_ATTR_WO(run_test);
 
-/*
- * Reload the IFS image. When user wants to install new IFS image
- */
-static ssize_t reload_store(struct device *dev,
-			    struct device_attribute *attr,
-			    const char *buf, size_t count)
-{
-	bool res;
-	int rc;
-
-	if (kstrtobool(buf, &res))
-		return -EINVAL;
-	if (!res)
-		return count;
-
-	if (down_interruptible(&ifs_sem))
-		return -EINTR;
-
-	rc = ifs_load_firmware(dev);
-
-	up(&ifs_sem);
-
-	return (rc == 0) ? count : rc;
-}
-
-static DEVICE_ATTR_WO(reload);
-
 /*
  * Display currently loaded IFS image version.
  */
@@ -135,7 +108,6 @@ static struct attribute *plat_ifs_attrs[] = {
 	&dev_attr_details.attr,
 	&dev_attr_status.attr,
 	&dev_attr_run_test.attr,
-	&dev_attr_reload.attr,
 	&dev_attr_image_version.attr,
 	NULL
 };
-- 
2.25.1

