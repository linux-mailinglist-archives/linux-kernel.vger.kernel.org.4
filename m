Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79356745D8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjASWXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjASWWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:22:07 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0F9613D8;
        Thu, 19 Jan 2023 14:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674166062; x=1705702062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5S3BuqC24+NJu2M0zXACS9Pp/HfCry1iDRW8QTKi5vo=;
  b=iMxw66YZnG/H+UMdCgf3JqDp9XlKYAMeDSoVxtNbAjyzr8vLd4LJrhWL
   x1E4ibYFUPpbGDTHcPQVfRiWkkGetM8sJSLRjL36+Qjru3nvE8m/01ydI
   65tzKduX4u+khKacsZ63eckn6aZD+5c5cUt40Eodo/yI2ZDCyrFDock1g
   4ksmE/B5IMdk2c0abspo7CSALwy9RzJSxi4jF44naghyOW7XTLNdG8X05
   LehkUNaa2SKenMaCmzYMnFm7wCuuzPmbnJZL53imwLM0ZmuroAYL2Fnef
   EaLj4SjNDMX9h1m5yth+2p2qnAykpAQBv8fFpSFVn3w//0CKUk548ECOc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="323130642"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="323130642"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 14:07:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="784226638"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="784226638"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 19 Jan 2023 14:07:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 35AE092; Fri, 20 Jan 2023 00:08:15 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/9] pktcdvd: replace sscanf() by kstrtoul()
Date:   Fri, 20 Jan 2023 00:08:02 +0200
Message-Id: <20230119220809.5518-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119220809.5518-1-andriy.shevchenko@linux.intel.com>
References: <20230119220809.5518-1-andriy.shevchenko@linux.intel.com>
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

The checkpatch.pl warns: "Prefer kstrto<type> to single variable sscanf".
Fix the code accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/block/pktcdvd.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 0ec8dc8ee5ed..ad4336ae9927 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -236,15 +236,16 @@ static ssize_t congestion_off_store(struct device *dev,
 				    const char *buf, size_t len)
 {
 	struct pktcdvd_device *pd = dev_get_drvdata(dev);
-	int val;
+	int val, ret;
 
-	if (sscanf(buf, "%d", &val) == 1) {
-		spin_lock(&pd->lock);
-		pd->write_congestion_off = val;
-		init_write_congestion_marks(&pd->write_congestion_off,
-					&pd->write_congestion_on);
-		spin_unlock(&pd->lock);
-	}
+	ret = kstrtoint(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	spin_lock(&pd->lock);
+	pd->write_congestion_off = val;
+	init_write_congestion_marks(&pd->write_congestion_off, &pd->write_congestion_on);
+	spin_unlock(&pd->lock);
 	return len;
 }
 static DEVICE_ATTR_RW(congestion_off);
@@ -266,15 +267,16 @@ static ssize_t congestion_on_store(struct device *dev,
 				   const char *buf, size_t len)
 {
 	struct pktcdvd_device *pd = dev_get_drvdata(dev);
-	int val;
+	int val, ret;
 
-	if (sscanf(buf, "%d", &val) == 1) {
-		spin_lock(&pd->lock);
-		pd->write_congestion_on = val;
-		init_write_congestion_marks(&pd->write_congestion_off,
-					&pd->write_congestion_on);
-		spin_unlock(&pd->lock);
-	}
+	ret = kstrtoint(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	spin_lock(&pd->lock);
+	pd->write_congestion_on = val;
+	init_write_congestion_marks(&pd->write_congestion_off, &pd->write_congestion_on);
+	spin_unlock(&pd->lock);
 	return len;
 }
 static DEVICE_ATTR_RW(congestion_on);
-- 
2.39.0

