Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D687B6243B8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiKJN5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiKJN5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:57:37 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FC6289;
        Thu, 10 Nov 2022 05:57:36 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N7NcR5ZDMzJnVv;
        Thu, 10 Nov 2022 21:54:31 +0800 (CST)
Received: from dggpeml500005.china.huawei.com (7.185.36.59) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 21:57:34 +0800
Received: from huawei.com (10.175.112.125) by dggpeml500005.china.huawei.com
 (7.185.36.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 21:57:33 +0800
From:   Yongqiang Liu <liuyongqiang13@huawei.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>, <tobin@kernel.org>
CC:     <zhangxiaoxu5@huawei.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: Init completion before kobject_init_and_add()
Date:   Thu, 10 Nov 2022 14:23:07 +0000
Message-ID: <20221110142307.981883-1-liuyongqiang13@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500005.china.huawei.com (7.185.36.59)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cpufreq_policy_alloc(), it will call uninitialed completion in
cpufreq_sysfs_release() when kobject_init_and_add() fails. And
that will cause a crash such as the following page fault in complete:

BUG: unable to handle page fault for address: fffffffffffffff8
[..]
RIP: 0010:complete+0x98/0x1f0
[..]
Call Trace:
 kobject_put+0x1be/0x4c0
 cpufreq_online.cold+0xee/0x1fd
 cpufreq_add_dev+0x183/0x1e0
 subsys_interface_register+0x3f5/0x4e0
 cpufreq_register_driver+0x3b7/0x670
 acpi_cpufreq_init+0x56c/0x1000 [acpi_cpufreq]
 do_one_initcall+0x13d/0x780
 do_init_module+0x1c3/0x630
 load_module+0x6e67/0x73b0
 __do_sys_finit_module+0x181/0x240
 do_syscall_64+0x35/0x80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fixes: 4ebe36c94aed ("cpufreq: Fix kobject memleak")
Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 69b3d61852ac..7e56a42750ea 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1207,6 +1207,7 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	if (!zalloc_cpumask_var(&policy->real_cpus, GFP_KERNEL))
 		goto err_free_rcpumask;
 
+	init_completion(&policy->kobj_unregister);
 	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
 				   cpufreq_global_kobject, "policy%u", cpu);
 	if (ret) {
@@ -1245,7 +1246,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	init_rwsem(&policy->rwsem);
 	spin_lock_init(&policy->transition_lock);
 	init_waitqueue_head(&policy->transition_wait);
-	init_completion(&policy->kobj_unregister);
 	INIT_WORK(&policy->update, handle_update);
 
 	policy->cpu = cpu;
-- 
2.25.1

