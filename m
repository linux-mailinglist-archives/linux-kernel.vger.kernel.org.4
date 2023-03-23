Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D5D6C683E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjCWM0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjCWM0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:26:23 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C72F27D43
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:26:06 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Pj4HL6Q7Bz17MjC;
        Thu, 23 Mar 2023 20:22:54 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 20:26:02 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <sudeep.holla@arm.com>, <pierre.gondois@arm.com>,
        <palmer@rivosinc.com>, <linux-kernel@vger.kernel.org>
CC:     <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
        <yangyicong@hisilicon.com>
Subject: [PATCH] cacheinfo: Fix LLC is not exported through sysfs
Date:   Thu, 23 Mar 2023 20:25:28 +0800
Message-ID: <20230323122528.16691-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
 drivers/base/cacheinfo.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index f6573c335f4c..d65f169d36dd 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -473,6 +473,13 @@ int detect_cache_attributes(unsigned int cpu)
 		return ret;
 
 populate_leaves:
+	/*
+	 * If LLC is valid the cache leaves were already populated so just go to
+	 * update the cpu map.
+	 */
+	if (last_level_cache_is_valid(cpu))
+		goto update_cpu_map;
+
 	/*
 	 * populate_cache_leaves() may completely setup the cache leaves and
 	 * shared_cpu_map or it may leave it partially setup.
@@ -481,6 +488,7 @@ int detect_cache_attributes(unsigned int cpu)
 	if (ret)
 		goto free_ci;
 
+update_cpu_map:
 	/*
 	 * For systems using DT for cache hierarchy, fw_token
 	 * and shared_cpu_map will be set up here only if they are
-- 
2.24.0

