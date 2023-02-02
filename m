Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171DB688194
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjBBPTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjBBPTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:19:11 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD12692C25;
        Thu,  2 Feb 2023 07:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675351136; x=1706887136;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XPtZMEGcQAaazFq43vly0rUfFz9SXA0R2yb5TWeDZj8=;
  b=PkldrLm6Ldlvjg37oi3xmPcjtkYWkVUqQvnvQbOeaAv0EgGCtonUQHUg
   D2z7v6RbXSbJLT1ZxfUVv37Ump3E2GRAyqPmbkyYbDB6wI6KHwBEu5nL7
   fmUh8FGjdbAaJrAynyjMh24hnMZMSmZxQzM2LHrhCZ2Niw7SoSSvdVZt0
   YnBf81s1EcoRh5ULwF5Tlv/7LTiYhL2k0K3de7/LSQURMgvxjIiz69AyW
   aA6oUv+LRENCY0GOHleHufkQxlMZeVFw8zzrtFAlxfmZCiSVA/ek4viP/
   x+X6RNMpYiNURLGMpz/9Jq9VCoAoUsCSSKKBc9/epl2xmWiiKmkXb3auq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="355811919"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="355811919"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 07:17:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="665320924"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="665320924"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 02 Feb 2023 07:17:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C5E0D332; Thu,  2 Feb 2023 17:17:47 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?J=C3=B3=20=C3=81gila=20Bitsch?= <jgilab@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] usb: gadget: configfs: Use memcpy_and_pad()
Date:   Thu,  2 Feb 2023 17:17:36 +0200
Message-Id: <20230202151736.64552-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of zeroing some memory and then copying data in part or all of it,
use memcpy_and_pad().
This avoids writing some memory twice and should save a few cycles.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/gadget/configfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 1346b330b358..0ee47e4c22cb 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -909,8 +909,7 @@ static ssize_t webusb_landingPage_store(struct config_item *item, const char *pa
 
 	mutex_lock(&gi->lock);
 	// ensure 0 bytes are set, in case the new landing page is shorter then the old one.
-	memset(gi->landing_page, 0, sizeof(gi->landing_page));
-	memcpy(gi->landing_page, page, l);
+	memcpy_and_pad(gi->landing_page, sizeof(gi->landing_page), page, l, 0);
 	mutex_unlock(&gi->lock);
 
 	return len;
-- 
2.39.1

