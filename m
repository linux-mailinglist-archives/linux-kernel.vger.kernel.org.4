Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5ECA6A77C4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCAXih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjCAXiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:38:05 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2798D22794
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677713884; x=1709249884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=F0R6+1IORr/b4JutI03SstHi+tgJzCauz5SrFc+e+nM=;
  b=jtr3N3+oSok7ZWbPmpBQZYkBvgXyje9ZUKB72q8ma/B8hyunUrkV+E1Q
   ULGBZf8OYLUqGIoUdYzNtqY5Tusg44Szw5lrvujLLjkO8o5P6Wztx69by
   OsOWr1+IP26oYYPheOYjp2xy2OItZ/ZJRd/Iccs8rdhoqRJAmUCxJW30y
   SJB/nrG5shgaFQkBHQnH0fC5HKcu0dXUB2Bf8p6k2Ekbf+jCVZya4RWv6
   RVVYEVODMlaSQvuVsqyDVMdD/gg8DIkRCvbr8f3zXzwhBU2pkfddhO7/e
   rKGjqpkfmUu5WDeWH8LuLYznBaioI/ilB+f7aWTk3TTP+9lPEDVuxJ7mY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420818743"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="420818743"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:37:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738826834"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="738826834"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2023 15:37:58 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Len Brown <len.brown@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v7 12/24] x86/hpet: Expose hpet_writel() in header
Date:   Wed,  1 Mar 2023 15:47:41 -0800
Message-Id: <20230301234753.28582-13-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230301234753.28582-1-ricardo.neri-calderon@linux.intel.com>
References: <20230301234753.28582-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow hpet_writel() to be used by other components (e.g.,
the HPET-based hardlockup detector), expose it in the HPET header file.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v6:
 * None

Changes since v5:
 * None

Changes since v4:
 * Dropped exposing hpet_readq() as it is not needed.

Changes since v3:
 * None

Changes since v2:
 * None

Changes since v1:
 * None
---
 arch/x86/include/asm/hpet.h | 1 +
 arch/x86/kernel/hpet.c      | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index ab9f3dd87c80..be9848f0883f 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -72,6 +72,7 @@ extern int is_hpet_enabled(void);
 extern int hpet_enable(void);
 extern void hpet_disable(void);
 extern unsigned int hpet_readl(unsigned int a);
+extern void hpet_writel(unsigned int d, unsigned int a);
 extern void force_hpet_resume(void);
 
 #ifdef CONFIG_HPET_EMULATE_RTC
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index c8eb1ac5125a..8303fb1b63a9 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -79,7 +79,7 @@ inline unsigned int hpet_readl(unsigned int a)
 	return readl(hpet_virt_address + a);
 }
 
-static inline void hpet_writel(unsigned int d, unsigned int a)
+inline void hpet_writel(unsigned int d, unsigned int a)
 {
 	writel(d, hpet_virt_address + a);
 }
-- 
2.25.1

