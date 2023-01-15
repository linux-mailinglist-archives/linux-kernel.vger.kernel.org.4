Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581CB66B4D7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 00:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjAOXwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 18:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjAOXwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 18:52:42 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E6BB144B0;
        Sun, 15 Jan 2023 15:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6Kdns
        8GYJSH7/qcg+JAu7mDP1eEu3YchHfmHw7M6ZYU=; b=XA8nKhd+AtyWw/ybCvYq3
        GuOmRbu2f1c18kjeFFsEHE7OMoLwIFEL0ClBVA6avgNx2j/YNj1iLALISTscYoKq
        1WHq/1Yj6kNUGu1Yid7FEka9u/mp2xoDa49DPuVUGdLWDFMnJSb5UVTjXE7Vq/Ix
        FfBQ1WSCh9UWAeoYfzDtJU=
Received: from ubuntu20.04 (unknown [222.129.34.12])
        by zwqz-smtp-mta-g2-4 (Coremail) with SMTP id _____wAX_namkcRjMYQSAg--.3960S2;
        Mon, 16 Jan 2023 07:52:06 +0800 (CST)
From:   Vincent Wang <bhuwz@163.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vincent Wang <vincentwang3@lenovo.com>
Subject: [PATCH] cpufreq: Send CPUFREQ_CREATE_POLICY notification after the perf domain creation.
Date:   Mon, 16 Jan 2023 07:52:02 +0800
Message-Id: <20230115235202.24695-1-bhuwz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAX_namkcRjMYQSAg--.3960S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr45CFW7WFyrGw1fJr1DJrb_yoW8WF4fpF
        Wag3y0krW8JayDJa1jyF48ua4jyasru3y8G34UGw1FyrnxGF1Yg3WUGF1YkFyfGr4kCrWa
        yr1rXa17Ca1UCr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jq5lbUUUUU=
X-Originating-IP: [222.129.34.12]
X-CM-SenderInfo: pekx46i6rwjhhfrp/1tbiYwb33FaENWfF-gAAs1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

To avoid this issue, cpufreq notification should be sent after
the perf domain creation.

Signed-off-by: Vincent Wang <vincentwang3@lenovo.com>
---
 drivers/cpufreq/cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7e56a42750ea..af8836069398 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1430,9 +1430,6 @@ static int cpufreq_online(unsigned int cpu)
 			policy->max_freq_req = NULL;
 			goto out_destroy_policy;
 		}
-
-		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
-				CPUFREQ_CREATE_POLICY, policy);
 	}
 
 	if (cpufreq_driver->get && has_target()) {
@@ -1506,6 +1503,9 @@ static int cpufreq_online(unsigned int cpu)
 		 */
 		if (cpufreq_driver->register_em)
 			cpufreq_driver->register_em(policy);
+
+		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
+				CPUFREQ_CREATE_POLICY, policy);
 	}
 
 	ret = cpufreq_init_policy(policy);
-- 
2.25.1

