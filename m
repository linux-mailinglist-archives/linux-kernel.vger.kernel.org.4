Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28CF73A853
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjFVSgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFVSgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:36:13 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0BF19AD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687458971; x=1718994971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VhBOr6U2D5NWmxrtLbRpTCwCo1J6kdCAEbXfowzEbFg=;
  b=dTvHcpapVde8XGR4tFu03bISH+oW1c9RncKLHrd0qVkDZf2196M06OTA
   TRGCTXngbfaFzYQnZwfXNdhTRxx5n/YZSjbKMr2ni9QAvNrNpWoHL9Q+9
   zHF73rsXjnDwLRPBVpwsH5/ODjpc3YSrxpvrqOyHr00Sh5HI91ARJBA07
   Wa1FW3gs2P0V/7m6hfz8poDVxKg43aOtfyz9EtKso8wDbfYQxCsArYgIm
   GyBC2BDFrcmMr7tumIkifWV/lDkj+oGeyc22317p6s/+pXuWtCzlwbyBn
   T40x+B5Q5DWpSDEc5zgzEJw/slDSh6o02KqvtQf8AuHIHkA9I9bYCR7B7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="350336481"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="350336481"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 11:36:10 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="749444243"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="749444243"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 22 Jun 2023 11:36:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 63136256; Thu, 22 Jun 2023 21:36:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 2/3] regmap: cache: Revert "Add 64-bit mode support"
Date:   Thu, 22 Jun 2023 21:36:12 +0300
Message-Id: <20230622183613.58762-3-andriy.shevchenko@linux.intel.com>
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

There is no support for 64-bit data size in regmap, so
there is no point to have it in regmap cache.

This reverts commit 8b7663de6e2bfe3c40e1846e1c4625f33d138757.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regcache.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 28bc3ae9458a..156490ab7f34 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -590,14 +590,6 @@ void regcache_set_val(struct regmap *map, void *base, unsigned int idx,
 		cache[idx] = val;
 		break;
 	}
-#ifdef CONFIG_64BIT
-	case 8: {
-		u64 *cache = base;
-
-		cache[idx] = val;
-		break;
-	}
-#endif
 	default:
 		BUG();
 	}
@@ -630,13 +622,6 @@ unsigned int regcache_get_val(struct regmap *map, const void *base,
 
 		return cache[idx];
 	}
-#ifdef CONFIG_64BIT
-	case 8: {
-		const u64 *cache = base;
-
-		return cache[idx];
-	}
-#endif
 	default:
 		BUG();
 	}
-- 
2.40.0.1.gaa8946217a0b

