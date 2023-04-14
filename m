Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DF26E1DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjDNIQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjDNIPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:15:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39C0083F6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:15:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F9B94B3;
        Fri, 14 Apr 2023 01:16:24 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.19.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 684ED3F6C4;
        Fri, 14 Apr 2023 01:15:37 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
Subject: [PATCH v4 4/4] cacheinfo: Add use_arch[|_cache]_info field/function
Date:   Fri, 14 Apr 2023 10:14:52 +0200
Message-Id: <20230414081453.244787-5-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230414081453.244787-1-pierre.gondois@arm.com>
References: <20230414081453.244787-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cache information can be extracted from either a Device
Tree (DT), the PPTT ACPI table, or arch registers (clidr_el1
for arm64).

The clidr_el1 register is used only if DT/ACPI information is not
available. It does not states how caches are shared among CPUs.

Add a use_arch_cache_info field/function to identify when the
DT/ACPI doesn't provide cache information. Use this information
to assume L1 caches are privates and L2 and higher are shared among
all CPUs.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/base/cacheinfo.c  | 12 ++++++++++--
 include/linux/cacheinfo.h |  6 ++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index ea8f416852bd..8120ac1ddbe4 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -28,6 +28,9 @@ static DEFINE_PER_CPU(struct cpu_cacheinfo, ci_cpu_cacheinfo);
 #define per_cpu_cacheinfo_idx(cpu, idx)		\
 				(per_cpu_cacheinfo(cpu) + (idx))
 
+/* Set if no cache information is found in DT/ACPI. */
+static bool use_arch_info;
+
 struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu)
 {
 	return ci_cacheinfo(cpu);
@@ -40,7 +43,8 @@ static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 	 * For non DT/ACPI systems, assume unique level 1 caches,
 	 * system-wide shared caches for all other levels.
 	 */
-	if (!(IS_ENABLED(CONFIG_OF) || IS_ENABLED(CONFIG_ACPI)))
+	if (!(IS_ENABLED(CONFIG_OF) || IS_ENABLED(CONFIG_ACPI)) ||
+	    use_arch_info)
 		return (this_leaf->level != 1) && (sib_leaf->level != 1);
 
 	if ((sib_leaf->attributes & CACHE_ID) &&
@@ -343,6 +347,10 @@ static int cache_setup_properties(unsigned int cpu)
 	else if (!acpi_disabled)
 		ret = cache_setup_acpi(cpu);
 
+	// Assume there is no cache information available in DT/ACPI from now.
+	if (ret && use_arch_cache_info())
+		use_arch_info = true;
+
 	return ret;
 }
 
@@ -361,7 +369,7 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 	 * to update the shared cpu_map if the cache attributes were
 	 * populated early before all the cpus are brought online
 	 */
-	if (!last_level_cache_is_valid(cpu)) {
+	if (!last_level_cache_is_valid(cpu) && !use_arch_info) {
 		ret = cache_setup_properties(cpu);
 		if (ret)
 			return ret;
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 908e19d17f49..b91cc9991c7c 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -129,4 +129,10 @@ static inline int get_cpu_cacheinfo_id(int cpu, int level)
 	return -1;
 }
 
+#ifdef CONFIG_ARM64
+#define use_arch_cache_info()	(true)
+#else
+#define use_arch_cache_info()	(false)
+#endif
+
 #endif /* _LINUX_CACHEINFO_H */
-- 
2.25.1

