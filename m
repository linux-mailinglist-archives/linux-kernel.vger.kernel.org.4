Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB58C67161B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjARIV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjARIUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:20:51 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE6839287;
        Tue, 17 Jan 2023 23:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674028092; x=1705564092;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V0/TXsQQWmEebWydvXYOMJFyW5Ah/NfVrzP/l74ZXew=;
  b=TLGw42hmOomx4Kgw8pFfOylDAVbHoWz5bDL5iKv5qoDNSI8ncjiiK1Pc
   szgNu0PsfXTs2V+FGZ3XD+uKFXyp11NbUcADRJoGUWSrFh3lq6PJHRe5i
   Va3spuHAGPNNfHo01axByiqgzLn+g7NhX0fDIA9dwALx2P2MNKY3n1ITT
   tWysx8HzU+rBXDHtiS4JKsUpPVtG0Ps1KfAn2zxNVm0X0R9YysyHsr8SI
   ZttQwaDU2XkOzbEBZcgfQlRx1RCMmwPFGEVCqb2anXqpa7ssEr/xKZVVc
   mi0TNi1kjov7FLyfcEK97gLUZ1x1WpXaWbHFXpsj+/84Dqb7NK+5YcfOn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="312800645"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="312800645"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 23:48:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="637171941"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="637171941"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 17 Jan 2023 23:48:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ECF4B256; Wed, 18 Jan 2023 09:48:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] iio: core: Replace iio_sysfs_match_string_with_gaps() by __sysfs_match_string()
Date:   Wed, 18 Jan 2023 09:48:27 +0200
Message-Id: <20230118074828.66155-1-andriy.shevchenko@linux.intel.com>
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

None of the current users is using gaps in the list of the items.
No need to have a specific function for that, just replace it by
library available __sysfs_match_string().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-core.c | 32 +-------------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 52e690f031cb..26e357f14db8 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -205,36 +205,6 @@ bool iio_buffer_enabled(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL_GPL(iio_buffer_enabled);
 
-/**
- * iio_sysfs_match_string_with_gaps - matches given string in an array with gaps
- * @array: array of strings
- * @n: number of strings in the array
- * @str: string to match with
- *
- * Returns index of @str in the @array or -EINVAL, similar to match_string().
- * Uses sysfs_streq instead of strcmp for matching.
- *
- * This routine will look for a string in an array of strings.
- * The search will continue until the element is found or the n-th element
- * is reached, regardless of any NULL elements in the array.
- */
-static int iio_sysfs_match_string_with_gaps(const char * const *array, size_t n,
-					    const char *str)
-{
-	const char *item;
-	int index;
-
-	for (index = 0; index < n; index++) {
-		item = array[index];
-		if (!item)
-			continue;
-		if (sysfs_streq(item, str))
-			return index;
-	}
-
-	return -EINVAL;
-}
-
 #if defined(CONFIG_DEBUG_FS)
 /*
  * There's also a CONFIG_DEBUG_FS guard in include/linux/iio/iio.h for
@@ -569,7 +539,7 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
 	if (!e->set)
 		return -EINVAL;
 
-	ret = iio_sysfs_match_string_with_gaps(e->items, e->num_items, buf);
+	ret = __sysfs_match_string(e->items, e->num_items, buf);
 	if (ret < 0)
 		return ret;
 
-- 
2.39.0

