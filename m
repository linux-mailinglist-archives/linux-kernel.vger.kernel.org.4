Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8269617719
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiKCHFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiKCHE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:04:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B530E264F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 00:04:56 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N2vrg3XH7zHvWk;
        Thu,  3 Nov 2022 15:04:35 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 15:04:54 +0800
Received: from huawei.com (10.67.174.169) by dggpemm500001.china.huawei.com
 (7.185.36.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 15:04:54 +0800
From:   Chen Lifu <chenlifu@huawei.com>
To:     <benh@kernel.crashing.org>, <mpe@ellerman.id.au>,
        <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
        <nick.child@ibm.com>, <zhengzucheng@huawei.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <chenlifu@huawei.com>
Subject: [PATCH v3 -next] powerpc/powermac: Fix symbol not declared warnings
Date:   Thu, 3 Nov 2022 15:01:22 +0800
Message-ID: <20221103070122.340773-1-chenlifu@huawei.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. ppc_override_l2cr and ppc_override_l2cr_value are only used in
    l2cr_init() function, remove them and used *l2cr directly.
2. has_l2cache is not used outside of the file, so mark it static and
    do not initialise statics to 0.

Fixes the following warning:

arch/powerpc/platforms/powermac/setup.c:73:5: warning: symbol
'ppc_override_l2cr' was not declared. Should it be static?
arch/powerpc/platforms/powermac/setup.c:74:5: warning: symbol
'ppc_override_l2cr_value' was not declared. Should it be static?
arch/powerpc/platforms/powermac/setup.c:75:5: warning: symbol
'has_l2cache' was not declared. Should it be static?

Signed-off-by: Chen Lifu <chenlifu@huawei.com>
---
 arch/powerpc/platforms/powermac/setup.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 04daa7f0a03c..cb9a3290849a 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -68,13 +68,11 @@
 
 #include "pmac.h"
 
 #undef SHOW_GATWICK_IRQS
 
-int ppc_override_l2cr = 0;
-int ppc_override_l2cr_value;
-int has_l2cache = 0;
+static int has_l2cache;
 
 int pmac_newworld;
 
 static int current_root_goodness = -1;
 
@@ -234,26 +232,21 @@ static void __init l2cr_init(void)
 
 		for_each_of_cpu_node(np) {
 			const unsigned int *l2cr =
 				of_get_property(np, "l2cr-value", NULL);
 			if (l2cr) {
-				ppc_override_l2cr = 1;
-				ppc_override_l2cr_value = *l2cr;
 				_set_L2CR(0);
-				_set_L2CR(ppc_override_l2cr_value);
+				_set_L2CR(*l2cr);
+				pr_info("L2CR overridden (0x%x), "
+					"backside cache is %s\n",
+					*l2cr, ((*l2cr) & 0x80000000) ?
+					"enabled" : "disabled");
 			}
 			of_node_put(np);
 			break;
 		}
 	}
-
-	if (ppc_override_l2cr)
-		printk(KERN_INFO "L2CR overridden (0x%x), "
-		       "backside cache is %s\n",
-		       ppc_override_l2cr_value,
-		       (ppc_override_l2cr_value & 0x80000000)
-				? "enabled" : "disabled");
 }
 #endif
 
 static void __init pmac_setup_arch(void)
 {
-- 
2.37.1

