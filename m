Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE3467E33E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjA0L2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjA0L20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:28:26 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6D878ADD;
        Fri, 27 Jan 2023 03:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674818829; x=1706354829;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JG73C6HLxgRYzOPAld+BfeRoEIwbS9sLX9ctvZGPeLM=;
  b=H0K5FOoe4iyazL+asZex1R1ra8AdcbBZ+1fDwyt7jhY/mXU5eOKNFNml
   zr7eXLo6xXozXNka8CliR18h2ppBYTBhP1JKbbVXAfnu0J3bniNsKkmcJ
   QGEU1/LXydUo0ukYhLzRhFF6DtdA/GG4XrXxhsVQdyya0uAvXo5iS0bLU
   dgEVgbeSs+PGy2XV7aWwZGwD69rrNCxIFCl6me+JSiFI5R32X8+pMUASc
   H/w9M3X2Wgt59OxjXwqW0H58uSUzqSWW1YIX2UqzgcpJa12anfjT5uobM
   a40n3I+QMotXyZ/egM5HvYbtujyting+FSNplh1EUT7xEhOBcJ9WytYyj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="315020387"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="315020387"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 03:26:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="665216227"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="665216227"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jan 2023 03:26:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1C8E6152; Fri, 27 Jan 2023 13:27:18 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?J=C3=B3=20=C3=81gila=20Bitsch?= <jgilab@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] usg: gadget: Move validation out of lock in webusb_bcdVersion_store()
Date:   Fri, 27 Jan 2023 13:26:38 +0200
Message-Id: <20230127112638.84806-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
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

Validation has nothing to do with any protected data,
move it out of the lock and make code neater.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/gadget/configfs.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 63dc15b4f6d8..1346b330b358 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -836,19 +836,15 @@ static ssize_t webusb_bcdVersion_store(struct config_item *item,
 	if (ret)
 		return ret;
 
-	mutex_lock(&gi->lock);
-
 	ret = is_valid_bcd(bcdVersion);
 	if (ret)
-		goto out;
+		return ret;
 
+	mutex_lock(&gi->lock);
 	gi->bcd_webusb_version = bcdVersion;
-	ret = len;
-
-out:
 	mutex_unlock(&gi->lock);
 
-	return ret;
+	return len;
 }
 
 static ssize_t webusb_bVendorCode_show(struct config_item *item, char *page)
-- 
2.39.0

