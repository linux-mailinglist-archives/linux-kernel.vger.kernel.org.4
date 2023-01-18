Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC9E6712EF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 06:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjARFDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 00:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjARFDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 00:03:21 -0500
X-Greylist: delayed 906 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Jan 2023 21:03:15 PST
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC27F5142D;
        Tue, 17 Jan 2023 21:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=tlkYc
        HL+mRM3my7PDBxqnuZOPrQXNYZeNk/a8GwpYdg=; b=YHf+pD0a2qcAaY1G90ryJ
        iCuGLnkLN2ZKGYLd7OhEAMkeX5p1WlNI9TviNV65OkSFC05nj/0QzJRFz0Zw1j+s
        FZsvpNxVlQIqdAYpwruCfzs4khJ32Gj5SZccDn73c11MTOavRme+hZZSlnWlZjsD
        MxIKI8gXBYk8Frlk1n408c=
Received: from ubuntu20.04 (unknown [222.129.34.12])
        by zwqz-smtp-mta-g4-0 (Coremail) with SMTP id _____wB31sroecdjkCcWAw--.3910S2;
        Wed, 18 Jan 2023 12:47:37 +0800 (CST)
From:   Vincent Wang <bhuwz@163.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org, lukasz.luba@arm.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vincent Wang <vincentwang3@lenovo.com>
Subject: [PATCH v2] cpufreq: Register with perf domain before
Date:   Wed, 18 Jan 2023 12:47:33 +0800
Message-Id: <20230118044733.29391-1-bhuwz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB31sroecdjkCcWAw--.3910S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4UWw1UCw4UJF1UWFWDtwb_yoW5WFWfpF
        Wag39Yyr4vqFZFyw47Aa18ua4Fg3Z7JFW2krW5G34Fyr1DGF10g3WxWFy5CFyfKr1kAFWj
        yr1Yqa47Ca1UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jyCJQUUUUU=
X-Originating-IP: [222.129.34.12]
X-CM-SenderInfo: pekx46i6rwjhhfrp/1tbiYxz63FaENYJzxgABsI
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Wang <vincentwang3@lenovo.com>

We found the following issue during kernel boot on android phone:

[    1.325272][    T1] cpu cpu0: EM: created perf domain
[    1.329317][    T1] cpu cpu4: EM: created perf domain
[    1.337597][   T76] pd_init: no EM found for CPU7
[    1.350849][    T1] cpu cpu7: EM: created perf domain

pd init for cluster2 is executed in a kworker thread and
is earlier than the perf domain creation for cluster2.

pd_init() is called from the cpufreq notification of
CPUFREQ_CREATE_POLICY in cpufreq_online(), which is earlier
than that cpufreq_driver->register_em() is called.

To avoid this issue, register with perf domain should be
earlier than the notification is sent.

Signed-off-by: Vincent Wang <vincentwang3@lenovo.com>
---
v1 -> v2:  based on Rafael's comment, adjust the order of
regitster perf domain. But I think it's no need to be in
advance to the initialization of frequency QoS.

Change the description of this patch.

 drivers/cpufreq/cpufreq.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7e56a42750ea..a715c8323897 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1431,6 +1431,24 @@ static int cpufreq_online(unsigned int cpu)
 			goto out_destroy_policy;
 		}
 
+		/*
+		 * Register with the energy model before
+		 * blocking_notifier_call_chain() is called for
+		 * CPUFREQ_CREATE_POLICY, which will result in rebuilding of the
+		 * sched domains in update_topology_flags_workfn().
+		 *
+		 * Register with the energy model before
+		 * sched_cpufreq_governor_change() is called, which will result
+		 * in rebuilding of the sched domains, which should only be done
+		 * once the energy model is properly initialized for the policy
+		 * first.
+		 *
+		 * Also, this should be called before the policy is registered
+		 * with cooling framework.
+		 */
+		if (cpufreq_driver->register_em)
+			cpufreq_driver->register_em(policy);
+
 		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 				CPUFREQ_CREATE_POLICY, policy);
 	}
@@ -1493,19 +1511,6 @@ static int cpufreq_online(unsigned int cpu)
 		write_lock_irqsave(&cpufreq_driver_lock, flags);
 		list_add(&policy->policy_list, &cpufreq_policy_list);
 		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
-
-		/*
-		 * Register with the energy model before
-		 * sched_cpufreq_governor_change() is called, which will result
-		 * in rebuilding of the sched domains, which should only be done
-		 * once the energy model is properly initialized for the policy
-		 * first.
-		 *
-		 * Also, this should be called before the policy is registered
-		 * with cooling framework.
-		 */
-		if (cpufreq_driver->register_em)
-			cpufreq_driver->register_em(policy);
 	}
 
 	ret = cpufreq_init_policy(policy);
-- 
2.25.1

