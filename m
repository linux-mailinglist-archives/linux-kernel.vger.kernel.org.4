Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103F168EDF1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjBHL3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjBHL3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:29:30 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D904458BB;
        Wed,  8 Feb 2023 03:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675855768; x=1707391768;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YOp7/xwpRbM1HsVxkj/oLzcILyXmsT17xldYoQVlStc=;
  b=kRt+Z2N+rjZe0ARRu5Nejljik/nGcBgG9gY9/ckKcc1MqHwZj8AvJZ60
   9rdbLwxPZlybM5U0tSb/b4zPVYM8qKh7s/XfBUnX5T1QzsUoQsuSkzDwO
   wJ0F91YOa5NFsHcprLcLYZegItvbxNv+nFlUXOA4fwy5IncrhF8OV+c8s
   VE355WGJNSdJo7p3TbjvZBiAypGrEyiyJJPP1tEvjg/Pdo4xpP5p4AC0/
   9V4kam4naacH0CTObwEFu3PG11S4huJzWfWucmBbX/DW5QdDcTbbfL06O
   YRpfW3vdXdLbn7YpLZIzASkzctMCzQPTrZHIQJT1NqdusazrL7lQ0DuWk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="394364469"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="394364469"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 03:29:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="735909089"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="735909089"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 08 Feb 2023 03:29:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3EE231A6; Wed,  8 Feb 2023 13:29:59 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] media: i2c: imx290: Make use of get_unaligned_le24(), put_unaligned_le24()
Date:   Wed,  8 Feb 2023 13:29:57 +0200
Message-Id: <20230208112957.15563-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

Since we have a proper endianness converters for LE 24-bit data use
them. While at it, format the code using switch-cases as it's done
for the rest of the endianness handlers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/i2c/imx290.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index 49d6c8bdec41..330098a0772d 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -16,6 +16,9 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+
+#include <asm/unaligned.h>
+
 #include <media/media-entity.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
@@ -466,18 +469,20 @@ static int __always_unused imx290_read(struct imx290 *imx290, u32 addr, u32 *val
 		return ret;
 	}
 
-	*value = (data[2] << 16) | (data[1] << 8) | data[0];
+	*value = get_unaligned_le24(data);
 	return 0;
 }
 
 static int imx290_write(struct imx290 *imx290, u32 addr, u32 value, int *err)
 {
-	u8 data[3] = { value & 0xff, (value >> 8) & 0xff, value >> 16 };
+	u8 data[3];
 	int ret;
 
 	if (err && *err)
 		return *err;
 
+	put_unaligned_le24(value, data);
+
 	ret = regmap_raw_write(imx290->regmap, addr & IMX290_REG_ADDR_MASK,
 			       data, (addr >> IMX290_REG_SIZE_SHIFT) & 3);
 	if (ret < 0) {
-- 
2.39.1

