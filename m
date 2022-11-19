Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2887630C9D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 07:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiKSGtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 01:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiKSGtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 01:49:06 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAA218366
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 22:49:05 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NDkks0sWvz15Md2;
        Sat, 19 Nov 2022 14:48:37 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 14:49:02 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <benh@kernel.crashing.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] powerpc: Fix potential memory leak in icp_native_map_one_cpu()
Date:   Sat, 19 Nov 2022 14:45:56 +0800
Message-ID: <20221119064556.83237-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before return error, it has allocated memory by kasprintf() and save it
in @rname, may cause a memory leak issue, fix it.

Fixes: 0b05ac6e2480 ("powerpc/xics: Rewrite XICS driver")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 arch/powerpc/sysdev/xics/icp-native.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index edc17b6b1cc2..126230206350 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -239,6 +239,7 @@ static int __init icp_native_map_one_cpu(int hw_id, unsigned long addr,
 	if (!request_mem_region(addr, size, rname)) {
 		pr_warn("icp_native: Could not reserve ICP MMIO for CPU %d, interrupt server #0x%x\n",
 			cpu, hw_id);
+		kfree(rname);
 		return -EBUSY;
 	}
 
@@ -248,6 +249,7 @@ static int __init icp_native_map_one_cpu(int hw_id, unsigned long addr,
 		pr_warn("icp_native: Failed ioremap for CPU %d, interrupt server #0x%x, addr %#lx\n",
 			cpu, hw_id, addr);
 		release_mem_region(addr, size);
+		kfree(rname);
 		return -ENOMEM;
 	}
 	return 0;
-- 
2.17.1

