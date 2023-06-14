Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D1672FAC6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243891AbjFNK0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbjFNKZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:25:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27EC30C7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:23:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOkkZP9BBtbOvwqX95RpbLoMuV9bmaqPNnKyzoAYY35uwvcP0hhsDr3t6lRG8NqoqtA8yTPK/bQ6ljh4pfhW7EJFiJnI8w5ZQv8PeNq1RhQcwb6fRMfa9qLFTn+JVFMliwWXAWBXJZsLjuau9PIX21HgvIuhLv0kyVlFr74EmRRCq4h81dEt3vS4Dhr3XqA16sKWZOh5hMY2Cy4TMbo0Zw4qkXt/5u4I2Og0RNg79a/3cYR4hE+wGnmaro/2he73W5Bafk2eOTm39v0WcNRqp1ypUaIXHZ5g3udRQaQoTuA4wDVthJ4bhCrcWzJrys4trWqnPrswDgp6SooJINAOng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8mttvNWRRqTk0Hs51ICDxomDvHYjjGsk7ns2B6R/Wo=;
 b=PdTy7v2xKIEzBB6aGt5rFTpZEgfQ7pKsU9fZCxZEKHYQx2iQP7sY+3giC0GPE7x1vFZnfUQeDMUutxZQF+f7K04vPQZOE17MsFE5/RczysH12+vWEoryjPursvDce6m8Zmo6bduAPVxHutThQ4+pP8MypjHfZEHJ/87pF0McZ0FqZiuQXrQEfnobuIuSwyrAQcpROkn82x1rYTKZGMhf77FNYzJMAy7kmpfmiDpO7JFksZoyQeVccqJZ0GWykrbNxI2AukotKnm8taFEA2bUtsb7wxR0lwT8JiD1H02gZ6kVtvmElnACfUC9cTdQbiomze/VbCPX7xv/IXJzslsg+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8mttvNWRRqTk0Hs51ICDxomDvHYjjGsk7ns2B6R/Wo=;
 b=1VrFIZxyHCzWzok0wfGwKDxO8PgfBpG1faMS/3BtQg3UmBv/g04/mFqXRzpE+fThUh3gasldlM8saVeVCYOUQnZCVcx4j1xkt537bhPbxe7OjzjEetPD7bk89Wk6d+qV/2TfxCdc/yRgXTwG3q9LkfDeZLqJ2rTEnEKRyaaqGF8=
Received: from CYZPR12CA0003.namprd12.prod.outlook.com (2603:10b6:930:8b::16)
 by SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 14 Jun
 2023 10:23:41 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:930:8b:cafe::60) by CYZPR12CA0003.outlook.office365.com
 (2603:10b6:930:8b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Wed, 14 Jun 2023 10:23:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 10:23:40 +0000
Received: from ethanolxb491host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 05:23:39 -0500
From:   Swapnil Sapkal <swapnil.sapkal@amd.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <iamjoonsoo.kim@lge.com>,
        <linux-kernel@vger.kernel.org>, <gautham.shenoy@amd.com>,
        <kprateek.nayak@amd.com>, <wyes.karny@amd.com>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [PATCH 2/2] sched/fair: Cleanup in migrate_degrades_locality() to improve readability
Date:   Wed, 14 Jun 2023 10:22:24 +0000
Message-ID: <20230614102224.12555-3-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614102224.12555-1-swapnil.sapkal@amd.com>
References: <20230614102224.12555-1-swapnil.sapkal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|SJ2PR12MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: 41445e9b-1dd1-4537-a9a6-08db6cc16c83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZQfDphimZybfZn5DoNzsJKTnLIYrPWWaglVlBHg3mslpmOf7lyJAVDCZbc90fK0Z0xGqd4RiEHwDx7rJHz98vO8+57IbxOPZeLgsM1J+NGVHtSjlEiV+tRdYO/krtkNbQo6fF97ZMX4vl4TH3qniwqs2qnpMMzUvblW4vYKiP7QYf6+yX9YxeFFm59NPgNlQdJcKchGGZJSv3q/E1yljoNmEqlSO6BI+Jlux+Q5AjOKCnPkVyxRjbdIimoUFP2idbPHZBhP2vBsZcjczuho8Pxh+3Io1TO6sZFcmdufw77Kw3p6Ha/pmA5RF580VzpZhoULCtEImoO1jpdGMxO50pgugukeZ1TjMvc2UBGAmDCno+fDbQ2aQbCiaw2qAm7siGwnJ29gWmx2ygdjsfBLl7hkqPIvJ0IYKlqMnvRTXym6B2coiGaV/ieD+Spz7c/Za8ZUSC+b3vFfoWUTzbMgs5EHViVUuCtlVl3cAFwVV9jJu/j3xIzfohJFGTAvq2oB8DHulp1zjK5QANGqri5zsuWahqkexEQ5BDW0Q3h4IOwZC6e+Joi/QZvGFjIEgWYoFzZ7G1Fe87pWnuBTrRD8JZAW+c5Kbx4id5lw2+mTiE785b9T34zKDebrJCrVrw/WBGUh0egHGDdW//lK+CbjFK/at5kAV8Zu4V5b8WzF/yw4lj/3dYc8Eyhbj6ovJcEMrIupZGPmv3R2aUGls6QXS9TRRKe1pU9KmrW9OVf6yAK40cbFaC0hElM5j6yqN7EhpQCwSvAoGQWyFfFCTYemjxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(336012)(40460700003)(2906002)(478600001)(426003)(2616005)(82310400005)(1076003)(26005)(36860700001)(47076005)(81166007)(86362001)(356005)(83380400001)(16526019)(82740400003)(186003)(7696005)(6666004)(70206006)(40480700001)(110136005)(7416002)(36756003)(4326008)(70586007)(5660300002)(44832011)(8676002)(8936002)(316002)(54906003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 10:23:40.7175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41445e9b-1dd1-4537-a9a6-08db6cc16c83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8739
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The migrate_degrades_locality() returns tristate value whether
the migration will improve locality, degrades locality or no
impact. Handle this return values with enum to improve the
readability.

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 kernel/sched/fair.c | 69 +++++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9a8e5dcbe7e6..06813ce5356e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8443,45 +8443,52 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 	return delta < (s64)sysctl_sched_migration_cost;
 }
 
+enum migration_impact {
+	/* if task migration is not affected by locality */
+	no_change = -1,
+
+	/* if task migration improves locality i.e migration preferred */
+	improves_locality = 0,
+
+	/* if task migration degrades locality */
+	degrades_locality = 1
+};
+
 #ifdef CONFIG_NUMA_BALANCING
-/*
- * Returns 1, if task migration degrades locality
- * Returns 0, if task migration improves locality i.e migration preferred.
- * Returns -1, if task migration is not affected by locality.
- */
-static int migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
+static enum migration_impact
+migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 {
 	struct numa_group *numa_group = rcu_dereference(p->numa_group);
 	unsigned long src_weight, dst_weight;
 	int src_nid, dst_nid, dist;
 
 	if (!static_branch_likely(&sched_numa_balancing))
-		return -1;
+		return no_change;
 
 	if (!p->numa_faults || !(env->sd->flags & SD_NUMA))
-		return -1;
+		return no_change;
 
 	src_nid = cpu_to_node(env->src_cpu);
 	dst_nid = cpu_to_node(env->dst_cpu);
 
 	if (src_nid == dst_nid)
-		return -1;
+		return no_change;
 
 	/* Migrating away from the preferred node is always bad. */
 	if (src_nid == p->numa_preferred_nid) {
 		if (env->src_rq->nr_running > env->src_rq->nr_preferred_running)
-			return 1;
+			return degrades_locality;
 		else
-			return -1;
+			return no_change;
 	}
 
 	/* Encourage migration to the preferred node. */
 	if (dst_nid == p->numa_preferred_nid)
-		return 0;
+		return improves_locality;
 
 	/* Leaving a core idle is often worse than degrading locality. */
 	if (env->idle == CPU_IDLE)
-		return -1;
+		return no_change;
 
 	dist = node_distance(src_nid, dst_nid);
 	if (numa_group) {
@@ -8492,14 +8499,14 @@ static int migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 		dst_weight = task_weight(p, dst_nid, dist);
 	}
 
-	return dst_weight < src_weight;
+	return (dst_weight < src_weight) ? degrades_locality : improves_locality;
 }
 
 #else
-static inline int migrate_degrades_locality(struct task_struct *p,
-					     struct lb_env *env)
+static inline enum migration_impact
+migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 {
-	return -1;
+	return no_change;
 }
 #endif
 
@@ -8509,7 +8516,7 @@ static inline int migrate_degrades_locality(struct task_struct *p,
 static
 int can_migrate_task(struct task_struct *p, struct lb_env *env, int *tsk_cache_hot)
 {
-	int degrades_locality;
+	enum migration_impact migration_impact;
 
 	lockdep_assert_rq_held(env->src_rq);
 
@@ -8578,18 +8585,30 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env, int *tsk_cache_h
 	if (env->flags & LBF_ACTIVE_LB)
 		return 1;
 
-	degrades_locality = migrate_degrades_locality(p, env);
-	if (degrades_locality == -1)
+	migration_impact = migrate_degrades_locality(p, env);
+
+	switch (migration_impact) {
+	case no_change:
 		*tsk_cache_hot = task_hot(p, env);
-	else
-		*tsk_cache_hot = degrades_locality;
+		break;
+
+	case degrades_locality:
+		*tsk_cache_hot = 1;
+		break;
+
+	case improves_locality:
+		*tsk_cache_hot = 0;
+		break;
+	}
+
+	if (!(*tsk_cache_hot))
+		return 1;
 
 	/*
-	 * Can migrate a hot task only after the attempts to reach balance
+	 * Can migrate a task only after the attempts to reach balance
 	 * without the task have exceeded the cache_nice_tries threshold.
 	 */
-	if (!(*tsk_cache_hot) ||
-		env->sd->nr_balance_failed > env->sd->cache_nice_tries)
+	if (env->sd->nr_balance_failed > env->sd->cache_nice_tries)
 		return 1;
 
 	schedstat_inc(p->stats.nr_failed_migrations_hot);
-- 
2.34.1

