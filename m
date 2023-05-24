Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B1170F4DB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbjEXLNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbjEXLNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:13:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D1D184
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684926800; x=1716462800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KPu+Z5pRjn3fh7neqH+is0rz0f3wQ9W+ZJzp1UiPaJs=;
  b=GT15OCMFxe3r6Wso4RRbRxIkPpVSq3fwkrZsioGTTNjxOIFxLy2HLGeg
   kTpEApZsxEi/Uk19ANymI8UOvLFn594b8KN9CjNCw2gn9MFQiwPFgqQhx
   byB8IBmHr+VbGE1/RtHcQl0kHoY9k+yft5ABvq9gbSxqel/k2GbhHUbqY
   DTPUGciEeROKhDJe8x5+npMizRQugmEBM9ufqP1bnYvlp4XqQ5LAuE2GS
   S/e/jEfjnN6cyiRv32wZ+J0c/t34u6cY6LGbHNdp8PJo9Sw7aiGQjzFgd
   AVCdmi9Qm9FgoMV6CEZiDhF54f0ph+122gavplU12nup61b4HkenUnOLb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="333156291"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="333156291"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 04:13:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="878621192"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="878621192"
Received: from mtkaczyk-devel.igk.intel.com ([10.102.105.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 04:12:59 -0700
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     arnd@arndb.de
Cc:     andriy.shevchenko@intel.com, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com
Subject: [PATCH v2 1/2] misc: enclosure: remove get_active callback
Date:   Wed, 24 May 2023 13:12:30 +0200
Message-Id: <20230524111231.14506-2-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230524111231.14506-1-mariusz.tkaczyk@linux.intel.com>
References: <20230524111231.14506-1-mariusz.tkaczyk@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callback is not used, remove it. Leave possibility to read cached
ecomp->active value.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
---
 drivers/misc/enclosure.c  | 4 +---
 include/linux/enclosure.h | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/misc/enclosure.c b/drivers/misc/enclosure.c
index 1b010d9267c9..59704fdb962a 100644
--- a/drivers/misc/enclosure.c
+++ b/drivers/misc/enclosure.c
@@ -534,11 +534,9 @@ static ssize_t set_component_status(struct device *cdev,
 static ssize_t get_component_active(struct device *cdev,
 				    struct device_attribute *attr, char *buf)
 {
-	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
 
-	if (edev->cb->get_active)
-		edev->cb->get_active(edev, ecomp);
+	/* The value of ecomp->active may have been updated by edev->cb->set_active(). */
 	return sysfs_emit(buf, "%d\n", ecomp->active);
 }
 
diff --git a/include/linux/enclosure.h b/include/linux/enclosure.h
index 1c630e2c2756..8d09c6d07bf1 100644
--- a/include/linux/enclosure.h
+++ b/include/linux/enclosure.h
@@ -62,8 +62,6 @@ struct enclosure_component_callbacks {
 	int (*set_fault)(struct enclosure_device *,
 			 struct enclosure_component *,
 			 enum enclosure_component_setting);
-	void (*get_active)(struct enclosure_device *,
-			   struct enclosure_component *);
 	int (*set_active)(struct enclosure_device *,
 			  struct enclosure_component *,
 			  enum enclosure_component_setting);
-- 
2.26.2

