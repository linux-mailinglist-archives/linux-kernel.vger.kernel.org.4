Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C70A6912FB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 23:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjBIWLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 17:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBIWLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 17:11:32 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F1066ED1;
        Thu,  9 Feb 2023 14:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675980691; x=1707516691;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T4V7k7V2WFxCfD78viO3ITAvZg/skqanlFdtB/Z58dY=;
  b=UJYCS5e8pRX1DwkQZGTKprEC9dWdmsogGD728UCxeSbCnxry1BqMVZLI
   6c71GPtkIwbPXPCiMzjrJ1e18fkAmrJlYUsSQ+6+E41UHLqMn2bjPIzaA
   IuuehJAE+FtqRpzah5mbP9VYw3PGJcmZ82IJrBwzvOLZ5t2ejjZ8LpgE9
   d8goatD1zJnUMNlb6O8TSQRpEDIfZc4KxC4k7sSYnldHkSC9i6eAv+JS/
   uwHu3EizWyUCXdtDdv2iBdzgXvEo1HiKAcslCDxedaF8cgMD1jQifdx9d
   LBQ77b5C5VpqzGoNMXvTTmvFyjsp8zni5zwSuVAKNy8Ak3YIaPyMmHy+K
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="330272438"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="330272438"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 14:11:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="700244012"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="700244012"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 09 Feb 2023 14:11:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1367C1A6; Fri, 10 Feb 2023 00:12:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] media: i2c: imx290: Make use of get_unaligned_le24(), put_unaligned_le24()
Date:   Fri, 10 Feb 2023 00:12:05 +0200
Message-Id: <20230209221205.46573-1-andriy.shevchenko@linux.intel.com>
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

Since we have a proper endianness converters for LE 24-bit data use them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: dropped unrelated noise from the commit message (Laurent)
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

