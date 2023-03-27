Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2906CA2FD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjC0MAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjC0MAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:00:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01E883A90
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:00:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E520B1042;
        Mon, 27 Mar 2023 05:01:18 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.19.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8BAAF3F663;
        Mon, 27 Mar 2023 05:00:31 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Radu Rendec <rrendec@redhat.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Gavin Shan <gshan@redhat.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] cacheinfo: Add use_arch[|_cache]_info field/function
Date:   Mon, 27 Mar 2023 13:59:51 +0200
Message-Id: <20230327115953.788244-4-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230327115953.788244-1-pierre.gondois@arm.com>
References: <20230327115953.788244-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 arch/arm64/kernel/cacheinfo.c |  5 +++++
 drivers/base/cacheinfo.c      | 20 ++++++++++++++++++--
 include/linux/cacheinfo.h     |  2 ++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index c307f69e9b55..b6306cda0fa7 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -96,3 +96,8 @@ int populate_cache_leaves(unsigned int cpu)
 	}
 	return 0;
 }
+
+bool use_arch_cache_info(unsigned int cpu)
+{
+	return true;
+}
diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 5b0edf2d5da8..c6266ccc2df5 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -40,8 +40,9 @@ static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 	 * For non DT/ACPI systems, assume unique level 1 caches,
 	 * system-wide shared caches for all other levels.
 	 */
-	if (!(IS_ENABLED(CONFIG_OF) || IS_ENABLED(CONFIG_ACPI)))
-		return (this_leaf->level != 1) || (sib_leaf->level != 1);
+	if (!(IS_ENABLED(CONFIG_OF) || IS_ENABLED(CONFIG_ACPI)) ||
+	    this_leaf->use_arch_info)
+		return (this_leaf->level != 1) && (sib_leaf->level != 1);
 
 	if ((sib_leaf->attributes & CACHE_ID) &&
 	    (this_leaf->attributes & CACHE_ID))
@@ -330,6 +331,11 @@ int __weak cache_setup_acpi(unsigned int cpu)
 	return -ENOTSUPP;
 }
 
+bool __weak use_arch_cache_info(unsigned int cpu)
+{
+	return false;
+}
+
 unsigned int coherency_max_size;
 
 static int cache_setup_properties(unsigned int cpu)
@@ -349,6 +355,7 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *this_leaf, *sib_leaf;
 	unsigned int index, sib_index;
+	bool use_arch_info = false;
 	int ret = 0;
 
 	if (this_cpu_ci->cpu_map_populated)
@@ -361,6 +368,12 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 	 */
 	if (!last_level_cache_is_valid(cpu)) {
 		ret = cache_setup_properties(cpu);
+		// Possibility to rely on arch specific information.
+		if (ret && use_arch_cache_info(cpu)) {
+			use_arch_info = true;
+			ret = 0;
+		}
+
 		if (ret)
 			return ret;
 	}
@@ -370,6 +383,9 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 
 		this_leaf = per_cpu_cacheinfo_idx(cpu, index);
 
+		if (use_arch_info)
+			this_leaf->use_arch_info = true;
+
 		cpumask_set_cpu(cpu, &this_leaf->shared_cpu_map);
 		for_each_online_cpu(i) {
 			struct cpu_cacheinfo *sib_cpu_ci = get_cpu_cacheinfo(i);
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 908e19d17f49..bcbb8bd5759a 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -66,6 +66,7 @@ struct cacheinfo {
 #define CACHE_ALLOCATE_POLICY_MASK	\
 	(CACHE_READ_ALLOCATE | CACHE_WRITE_ALLOCATE)
 #define CACHE_ID		BIT(4)
+	bool use_arch_info;
 	void *fw_token;
 	bool disable_sysfs;
 	void *priv;
@@ -82,6 +83,7 @@ struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
 int init_cache_level(unsigned int cpu);
 int init_of_cache_level(unsigned int cpu);
 int populate_cache_leaves(unsigned int cpu);
+bool use_arch_cache_info(unsigned int cpu);
 int cache_setup_acpi(unsigned int cpu);
 bool last_level_cache_is_valid(unsigned int cpu);
 bool last_level_cache_is_shared(unsigned int cpu_x, unsigned int cpu_y);
-- 
2.25.1

