Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B616E09E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDMJPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjDMJPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:15:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D149E93F4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:15:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CEF2D75;
        Thu, 13 Apr 2023 02:15:51 -0700 (PDT)
Received: from pierre123.nice.arm.com (pierre123.nice.arm.com [10.34.100.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E46F13F6C4;
        Thu, 13 Apr 2023 02:15:04 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Will Deacon <will@kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
Subject: [PATCH v3 2/4] cacheinfo: Check cache properties are present in DT
Date:   Thu, 13 Apr 2023 11:14:32 +0200
Message-Id: <20230413091436.230134-3-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230413091436.230134-1-pierre.gondois@arm.com>
References: <20230413091436.230134-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a Device Tree (DT) is used, the presence of cache properties is
assumed. Not finding any is not considered. For arm64 platforms,
cache information can be fetched from the clidr_el1 register.
Checking whether cache information is available in the DT
allows to switch to using clidr_el1.

init_of_cache_level()
\-of_count_cache_leaves()
will assume there a 2 cache leaves (L1 data/instruction caches), which
can be different from clidr_el1 information.

cache_setup_of_node() tries to read cache properties in the DT.
If there are none, this is considered a success. Knowing no
information was available would allow to switch to using clidr_el1.

Fixes: de0df442ee49 ("cacheinfo: Check 'cache-unified' property to count cache leaves")
Reported-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/all/20230404-hatred-swimmer-6fecdf33b57a@spud/
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/base/cacheinfo.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index c5d2293ac2a6..06de9a468958 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -78,6 +78,9 @@ bool last_level_cache_is_shared(unsigned int cpu_x, unsigned int cpu_y)
 }
 
 #ifdef CONFIG_OF
+
+static bool of_check_cache_nodes(struct device_node *np);
+
 /* OF properties to query for a given cache type */
 struct cache_type_info {
 	const char *size_prop;
@@ -205,6 +208,11 @@ static int cache_setup_of_node(unsigned int cpu)
 		return -ENOENT;
 	}
 
+	if (!of_check_cache_nodes(np)) {
+		of_node_put(np);
+		return -ENOENT;
+	}
+
 	prev = np;
 
 	while (index < cache_leaves(cpu)) {
@@ -229,6 +237,25 @@ static int cache_setup_of_node(unsigned int cpu)
 	return 0;
 }
 
+static bool of_check_cache_nodes(struct device_node *np)
+{
+	struct device_node *next;
+
+	if (of_property_present(np, "cache-size")   ||
+	    of_property_present(np, "i-cache-size") ||
+	    of_property_present(np, "d-cache-size") ||
+	    of_property_present(np, "cache-unified"))
+		return true;
+
+	next = of_find_next_cache_node(np);
+	if (next) {
+		of_node_put(next);
+		return true;
+	}
+
+	return false;
+}
+
 static int of_count_cache_leaves(struct device_node *np)
 {
 	unsigned int leaves = 0;
@@ -260,6 +287,9 @@ int init_of_cache_level(unsigned int cpu)
 	struct device_node *prev = NULL;
 	unsigned int levels = 0, leaves, level;
 
+	if (!of_check_cache_nodes(np))
+		goto err_out;
+
 	leaves = of_count_cache_leaves(np);
 	if (leaves > 0)
 		levels = 1;
-- 
2.25.1

