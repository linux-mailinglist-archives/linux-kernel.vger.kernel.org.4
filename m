Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B776CBE13
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjC1LuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjC1Lt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:49:59 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DAA8A6E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:49:54 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Pm7FB5VHCz17PdD;
        Tue, 28 Mar 2023 19:46:38 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 19:49:52 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <sudeep.holla@arm.com>, <pierre.gondois@arm.com>,
        <palmer@rivosinc.com>, <linux-kernel@vger.kernel.org>
CC:     <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
        <yangyicong@hisilicon.com>
Subject: [PATCH v2] cacheinfo: Fix LLC is not exported through sysfs
Date:   Tue, 28 Mar 2023 19:49:15 +0800
Message-ID: <20230328114915.33340-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

After entering 6.3-rc1 the LLC cacheinfo is not exported on our ACPI
based arm64 server. This is because the LLC cacheinfo is partly reset
when secondary CPUs boot up. On arm64 the primary cpu will allocate
and setup cacheinfo:
init_cpu_topology()
  for_each_possible_cpu()
    fetch_cache_info() // Allocate cacheinfo and init levels
detect_cache_attributes()
  cache_shared_cpu_map_setup()
    if (!last_level_cache_is_valid()) // not valid, setup LLC
      cache_setup_properties() // setup LLC

On secondary CPU boot up:
detect_cache_attributes()
  populate_cache_leaves()
    get_cache_type() // Get cache type from clidr_el1,
                     // for LLC type=CACHE_TYPE_NOCACHE
  cache_shared_cpu_map_setup()
    if (!last_level_cache_is_valid()) // Valid and won't go to this branch,
                                      // leave LLC's type=CACHE_TYPE_NOCACHE

The last_level_cache_is_valid() use cacheinfo->{attributes, fw_token} to
test it's valid or not, but populate_cache_leaves() will only reset
LLC's type, so we won't try to re-setup LLC's type and leave it
CACHE_TYPE_NOCACHE and won't export it through sysfs.

This patch tries to fix this by not re-populating the cache leaves if
the LLC is valid.

Fixes: 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
Change since v1:
- Get rid of the goto label, per Pierre
Link: https://lore.kernel.org/all/20230323122528.16691-1-yangyicong@huawei.com/

 drivers/base/cacheinfo.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index f6573c335f4c..f3903d002819 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -474,12 +474,18 @@ int detect_cache_attributes(unsigned int cpu)
 
 populate_leaves:
 	/*
-	 * populate_cache_leaves() may completely setup the cache leaves and
-	 * shared_cpu_map or it may leave it partially setup.
+	 * If LLC is valid the cache leaves were already populated so just go to
+	 * update the cpu map.
 	 */
-	ret = populate_cache_leaves(cpu);
-	if (ret)
-		goto free_ci;
+	if (!last_level_cache_is_valid(cpu)) {
+		/*
+		 * populate_cache_leaves() may completely setup the cache leaves and
+		 * shared_cpu_map or it may leave it partially setup.
+		 */
+		ret = populate_cache_leaves(cpu);
+		if (ret)
+			goto free_ci;
+	}
 
 	/*
 	 * For systems using DT for cache hierarchy, fw_token
-- 
2.24.0

