Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D736C4E00
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjCVOkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjCVOj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:39:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F01E60417
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679495966; x=1711031966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nx51SpraYhWhakBAvwZOoAwXLoCLgSQssS6ASOeGoTw=;
  b=WLtfgnFvk61N0JK5V547On91RTdTA31k1wF8/e3Jg02z+E+9pI2/erlb
   ddtHevC4sNsdr5bkXNPjUEHFvxgBWoi+tiYKAittvbQ4QAHMChsvknlSf
   VQ/kb9UMqzEQEs7Cg5fqd7jNoHJZhS5ls0trZBC85jLvIhHVudHUlU0A3
   t/d4mIitxyY4CaNtdG8sLlHsuBWVATgz8pDeZMAeZ+K6gPhaIQ8BUyo6z
   QdBYN23bWlXu/YPEUu5s565OtX3nr4+z5deG1tlo4XqQwo1KbH9RNH11f
   5rKonsJERRpj8nu096/QlG6SWLdel8Xlh7KBAQAaJvVKrVq4PJHKyL1Dy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="319622135"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="319622135"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:39:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="856116431"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="856116431"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 22 Mar 2023 07:39:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F2061A0D; Wed, 22 Mar 2023 16:40:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v1 11/14] extcon: Remove dup device name in the message and unneeded error check
Date:   Wed, 22 Mar 2023 16:40:02 +0200
Message-Id: <20230322144005.40368-12-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device name is already printed with dev_err(), no need to repeat.
The device pointer itself is not supposed to be an error point, drop
that check.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 32e96cb49067..0e04ea185c26 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1367,9 +1367,8 @@ void extcon_dev_unregister(struct extcon_dev *edev)
 	list_del(&edev->entry);
 	mutex_unlock(&extcon_dev_list_lock);
 
-	if (IS_ERR_OR_NULL(get_device(&edev->dev))) {
-		dev_err(&edev->dev, "Failed to unregister extcon_dev (%s)\n",
-				dev_name(&edev->dev));
+	if (!get_device(&edev->dev)) {
+		dev_err(&edev->dev, "Failed to unregister extcon_dev\n");
 		return;
 	}
 
-- 
2.40.0.1.gaa8946217a0b

