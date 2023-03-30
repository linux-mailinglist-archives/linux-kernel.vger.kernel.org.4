Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2666D0186
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjC3Kne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjC3Kn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:43:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52498699
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680173008; x=1711709008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CDN8ZE/1vjjcivVa5naMdgZ0tYuSIPBlqDkTp4fXFOE=;
  b=LX6PrKnKVL8xkZzJLAA+f6mI7z0dj+c1K0wgBzJX9CWRZ6a8uaNcuHI5
   iCmZPmJXwt463U0dq6Yo/08ig5/i8njWEgqNJ4sb6MiHA3GwHmEc4Zagc
   nPhAR8d9bIO+o27U21oHvo5LnEZl5xCl+pnRfNimuIER07PbKifpu+0he
   dCh4zJzn9rArGjgs7ANfc7Q3mKDvMBHxkRoxiFjugnCt8ZGMFv6/HVnH5
   iSDgbaKMCYdGWiM3RcbOiPZVPCLdKawEbLUpUhbiy5OvgMSQNB02qPxep
   qLoBFeAYfswMRQ56GVBrEzKeRLLJcmY2s67Tq/5XO8/Vzz6Wtm/zKCUeT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="406096373"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="406096373"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 03:43:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="687197245"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="687197245"
Received: from unknown (HELO localhost) ([10.237.66.160])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 03:43:26 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        jani.nikula@intel.com, Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Gow <davidgow@google.com>
Subject: [PATCH 2/4] log2: have is_power_of_2() support bigger types than unsigned long
Date:   Thu, 30 Mar 2023 13:42:41 +0300
Message-Id: <20230330104243.2120761-3-jani.nikula@intel.com>
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

is_power_of_2() does not work properly for e.g. u64 in 32-bit
builds. Choose an unsigned long long version if the argument is bigger
than unsigned long.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: David Gow <davidgow@google.com>
Link: https://lore.kernel.org/r/20230329065532.2122295-2-davidgow@google.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 include/linux/log2.h | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/log2.h b/include/linux/log2.h
index 19e773116ae3..4027d1eecd7f 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -35,6 +35,18 @@ int __ilog2_u64(u64 n)
 
 #define __IS_POWER_OF_2(n) ((n) != 0 && (((n) & ((n) - 1)) == 0))
 
+static inline __attribute__((const))
+bool __is_power_of_2_ull(unsigned long long n)
+{
+	return __IS_POWER_OF_2(n);
+}
+
+static inline __attribute__((const))
+bool __is_power_of_2(unsigned long n)
+{
+	return __IS_POWER_OF_2(n);
+}
+
 /**
  * is_power_of_2() - check if a value is a power of two
  * @n: the value to check
@@ -43,11 +55,10 @@ int __ilog2_u64(u64 n)
  * *not* considered a power of two.
  * Return: true if @n is a power of 2, otherwise false.
  */
-static inline __attribute__((const))
-bool is_power_of_2(unsigned long n)
-{
-	return __IS_POWER_OF_2(n);
-}
+#define is_power_of_2(n)						\
+	__builtin_choose_expr(sizeof(n) > sizeof(unsigned long),	\
+			      __is_power_of_2_ull(n),			\
+			      __is_power_of_2(n))
 
 /**
  * __roundup_pow_of_two() - round up to nearest power of two
-- 
2.39.2

