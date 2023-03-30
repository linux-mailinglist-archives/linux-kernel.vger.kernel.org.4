Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A506D0183
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjC3Kn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjC3KnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:43:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD6676A6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680173004; x=1711709004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rdSW/H5+AU0HO+4e5kx9qkcnfmfjqVwpnHUDyzvoCLY=;
  b=Ym7zahwvQ1kMWdm+IHN3uqQlT3TmP9Gag+XzcsVh8tY0Ocy/jx4WLGFt
   A4/ubKEh92Dq+4YFJpbQzxlAUBFOLEurPL9dZQ+9TQokYb7vA1Lld9lWB
   TskbjLiZz1UResWhL5lG9eF9hpvVLBRf+y+kXXFFx4kSUNpvVmsGTIWmK
   kU1cfNs9oL2PBwiXxH9H2nZ4KNKwzdIWvEquSL+i1WgtZEf6UawHJ7d6o
   6j0ScRrFdMD8eD63OZHPOObSuDKHSiX9z5RX+aqrcIlfOIsbqHMQ3U46G
   abhd/UwOZJKCuIYE04S0LmVA8JvzrugQa2g+MySxjp9nbYqkshBZTvj+/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="406096350"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="406096350"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 03:43:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="687197239"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="687197239"
Received: from unknown (HELO localhost) ([10.237.66.160])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 03:43:22 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        jani.nikula@intel.com, Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Gow <davidgow@google.com>
Subject: [PATCH 1/4] log2: add helper __IS_POWER_OF_2()
Date:   Thu, 30 Mar 2023 13:42:40 +0300
Message-Id: <20230330104243.2120761-2-jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330104243.2120761-1-jani.nikula@intel.com>
References: <20230330104243.2120761-1-jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper to avoid duplication in the subsequent changes.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: David Gow <davidgow@google.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 include/linux/log2.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/log2.h b/include/linux/log2.h
index 9f30d087a128..19e773116ae3 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -33,6 +33,8 @@ int __ilog2_u64(u64 n)
 }
 #endif
 
+#define __IS_POWER_OF_2(n) ((n) != 0 && (((n) & ((n) - 1)) == 0))
+
 /**
  * is_power_of_2() - check if a value is a power of two
  * @n: the value to check
@@ -44,7 +46,7 @@ int __ilog2_u64(u64 n)
 static inline __attribute__((const))
 bool is_power_of_2(unsigned long n)
 {
-	return (n != 0 && ((n & (n - 1)) == 0));
+	return __IS_POWER_OF_2(n);
 }
 
 /**
-- 
2.39.2

