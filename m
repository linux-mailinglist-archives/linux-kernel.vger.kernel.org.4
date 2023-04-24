Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FE66DEC6B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjDLHTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjDLHTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:19:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12A165B8E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:18:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 385EED75;
        Wed, 12 Apr 2023 00:19:22 -0700 (PDT)
Received: from pierre123.nice.arm.com (pierre123.nice.arm.com [10.34.100.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 24A793F73F;
        Wed, 12 Apr 2023 00:18:36 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Will Deacon <will@kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
Subject: [PATCH v2 3/3] cacheinfo: Add use_arch[|_cache]_info field/function
Date:   Wed, 12 Apr 2023 09:18:06 +0200
Message-Id: <20230412071809.12670-4-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230412071809.12670-1-pierre.gondois@arm.com>
References: <20230412071809.12670-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/base/cacheinfo.c  | 15 +++++++++++++--
 include/linux/cacheinfo.h | 11 +++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 6749dc6ebf50..49dbb4357911 100644
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
@@ -349,6 +350,7 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *this_leaf, *sib_leaf;
 	unsigned int index, sib_index;
+	bool use_arch_info = false;
 	int ret = 0;
 
 	if (this_cpu_ci->cpu_map_populated)
@@ -361,6 +363,12 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 	 */
 	if (!last_level_cache_is_valid(cpu)) {
 		ret = cache_setup_properties(cpu);
+		if (ret && use_arch_cache_info()) {
+			// Possibility to rely on arch specific information.
+			use_arch_info = true;
+			ret = 0;
+		}
+
 		if (ret)
 			return ret;
 	}
@@ -370,6 +378,9 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 
 		this_leaf = per_cpu_cacheinfo_idx(cpu, index);
 
+		if (use_arch_info)
+			this_leaf->use_arch_info = true;
+
 		cpumask_set_cpu(cpu, &this_leaf->shared_cpu_map);
 		for_each_online_cpu(i) {
 			struct cpu_cacheinfo *sib_cpu_ci = get_cpu_cacheinfo(i);
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 908e19d17f49..853f5d97f1dc 100644
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
@@ -129,4 +130,14 @@ static inline int get_cpu_cacheinfo_id(int cpu, int level)
 	return -1;
 }
 
+static inline bool
+use_arch_cache_info(void)
+{
+#if defined(CONFIG_ARM64)
+	return true;
+#else
+	return false;
+#endif
+}
+
 #endif /* _LINUX_CACHEINFO_H */
-- 
2.25.1

