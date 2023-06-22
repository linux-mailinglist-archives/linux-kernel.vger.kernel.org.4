Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D2D73A855
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjFVSgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjFVSgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:36:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9FC19AD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687458974; x=1718994974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qn2u2RLCbFdVZN4ikKWKM/l5/WyZM/ASxv2X1EZTXOc=;
  b=Yao3QxLJvaQKLeYW1dEdEjR9c41oFFzt5enN7dTXETPknELbQb/xxkFy
   iH2WxnrUhBwwo1+HBiayW69STMi6GWgD4U0s0oo3IunnJNXlknLVXAPXH
   T2ll+6n3ZjqJQmVOns2HiznNwT+lPlCgfL9dlwezWRzQMSr+ayp2HFpVq
   0yTUWu8THxIh+2qjnwuSfx9uRkIBueFsQV1yVslCraYFStuYduIXwNtUT
   h2kYfW8cZ+Gj0wN41zr+42g+kAHnUGvsTkkoDUDBEoZL20mpdLYLYqM+L
   PLkUgOT9wBp81/sisfIDHRPVKQeLjEJLtscPW3DW+c6ntLgGLhLWYAS9F
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="350336495"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="350336495"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 11:36:10 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="749444246"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="749444246"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 22 Jun 2023 11:36:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5D521241; Thu, 22 Jun 2023 21:36:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/3] regmap: Revert "add 64-bit mode support" and Co.
Date:   Thu, 22 Jun 2023 21:36:11 +0300
Message-Id: <20230622183613.58762-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230622183613.58762-1-andriy.shevchenko@linux.intel.com>
References: <20230622183613.58762-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With unsigned int type we never ever can pass 64-bit value.
Remove never properly worked code.

Note, there are no users in kernel for this size of register
offsets or data.

This reverts commit afcc00b91f1865f6d0bbdb687dd642ce8a3c3c9e.

Also revert other 64-bit code excerpts in the regmap implementation
that had been induced by the false impression made by the above
mentioned change that there is a support of that data size.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap.c | 122 -----------------------------------
 1 file changed, 122 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 89a7f1c459c1..8b37451fa931 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -311,26 +311,6 @@ static void regmap_format_32_native(void *buf, unsigned int val,
 	memcpy(buf, &v, sizeof(v));
 }
 
-#ifdef CONFIG_64BIT
-static void regmap_format_64_be(void *buf, unsigned int val, unsigned int shift)
-{
-	put_unaligned_be64((u64) val << shift, buf);
-}
-
-static void regmap_format_64_le(void *buf, unsigned int val, unsigned int shift)
-{
-	put_unaligned_le64((u64) val << shift, buf);
-}
-
-static void regmap_format_64_native(void *buf, unsigned int val,
-				    unsigned int shift)
-{
-	u64 v = (u64) val << shift;
-
-	memcpy(buf, &v, sizeof(v));
-}
-#endif
-
 static void regmap_parse_inplace_noop(void *buf)
 {
 }
@@ -411,40 +391,6 @@ static unsigned int regmap_parse_32_native(const void *buf)
 	return v;
 }
 
-#ifdef CONFIG_64BIT
-static unsigned int regmap_parse_64_be(const void *buf)
-{
-	return get_unaligned_be64(buf);
-}
-
-static unsigned int regmap_parse_64_le(const void *buf)
-{
-	return get_unaligned_le64(buf);
-}
-
-static void regmap_parse_64_be_inplace(void *buf)
-{
-	u64 v =  get_unaligned_be64(buf);
-
-	memcpy(buf, &v, sizeof(v));
-}
-
-static void regmap_parse_64_le_inplace(void *buf)
-{
-	u64 v = get_unaligned_le64(buf);
-
-	memcpy(buf, &v, sizeof(v));
-}
-
-static unsigned int regmap_parse_64_native(const void *buf)
-{
-	u64 v;
-
-	memcpy(&v, buf, sizeof(v));
-	return v;
-}
-#endif
-
 static void regmap_lock_hwlock(void *__map)
 {
 	struct regmap *map = __map;
@@ -1005,24 +951,6 @@ struct regmap *__regmap_init(struct device *dev,
 		}
 		break;
 
-#ifdef CONFIG_64BIT
-	case 64:
-		switch (reg_endian) {
-		case REGMAP_ENDIAN_BIG:
-			map->format.format_reg = regmap_format_64_be;
-			break;
-		case REGMAP_ENDIAN_LITTLE:
-			map->format.format_reg = regmap_format_64_le;
-			break;
-		case REGMAP_ENDIAN_NATIVE:
-			map->format.format_reg = regmap_format_64_native;
-			break;
-		default:
-			goto err_hwlock;
-		}
-		break;
-#endif
-
 	default:
 		goto err_hwlock;
 	}
@@ -1086,28 +1014,6 @@ struct regmap *__regmap_init(struct device *dev,
 			goto err_hwlock;
 		}
 		break;
-#ifdef CONFIG_64BIT
-	case 64:
-		switch (val_endian) {
-		case REGMAP_ENDIAN_BIG:
-			map->format.format_val = regmap_format_64_be;
-			map->format.parse_val = regmap_parse_64_be;
-			map->format.parse_inplace = regmap_parse_64_be_inplace;
-			break;
-		case REGMAP_ENDIAN_LITTLE:
-			map->format.format_val = regmap_format_64_le;
-			map->format.parse_val = regmap_parse_64_le;
-			map->format.parse_inplace = regmap_parse_64_le_inplace;
-			break;
-		case REGMAP_ENDIAN_NATIVE:
-			map->format.format_val = regmap_format_64_native;
-			map->format.parse_val = regmap_parse_64_native;
-			break;
-		default:
-			goto err_hwlock;
-		}
-		break;
-#endif
 	}
 
 	if (map->format.format_write) {
@@ -2160,9 +2066,6 @@ static int regmap_noinc_readwrite(struct regmap *map, unsigned int reg,
 	u8 *u8p;
 	u16 *u16p;
 	u32 *u32p;
-#ifdef CONFIG_64BIT
-	u64 *u64p;
-#endif
 	int ret;
 	int i;
 
@@ -2182,13 +2085,6 @@ static int regmap_noinc_readwrite(struct regmap *map, unsigned int reg,
 		if (write)
 			lastval = (unsigned int)u32p[val_count - 1];
 		break;
-#ifdef CONFIG_64BIT
-	case 8:
-		u64p = val;
-		if (write)
-			lastval = (unsigned int)u64p[val_count - 1];
-		break;
-#endif
 	default:
 		return -EINVAL;
 	}
@@ -2226,11 +2122,6 @@ static int regmap_noinc_readwrite(struct regmap *map, unsigned int reg,
 			case 4:
 				pr_cont("%x", u32p[i]);
 				break;
-#ifdef CONFIG_64BIT
-			case 8:
-				pr_cont("%llx", u64p[i]);
-				break;
-#endif
 			default:
 				break;
 			}
@@ -2438,11 +2329,6 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 			case 4:
 				ival = *(u32 *)(val + (i * val_bytes));
 				break;
-#ifdef CONFIG_64BIT
-			case 8:
-				ival = *(u64 *)(val + (i * val_bytes));
-				break;
-#endif
 			default:
 				ret = -EINVAL;
 				goto out;
@@ -3207,9 +3093,6 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 		for (i = 0; i < val_count * val_bytes; i += val_bytes)
 			map->format.parse_inplace(val + i);
 	} else {
-#ifdef CONFIG_64BIT
-		u64 *u64 = val;
-#endif
 		u32 *u32 = val;
 		u16 *u16 = val;
 		u8 *u8 = val;
@@ -3225,11 +3108,6 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 				goto out;
 
 			switch (map->format.val_bytes) {
-#ifdef CONFIG_64BIT
-			case 8:
-				u64[i] = ival;
-				break;
-#endif
 			case 4:
 				u32[i] = ival;
 				break;
-- 
2.40.0.1.gaa8946217a0b

