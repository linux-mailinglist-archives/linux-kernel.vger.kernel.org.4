Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1416072FACB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbjFNK04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244128AbjFNKZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:25:03 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120062953
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:23:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCYijIeafbeuKTFhe7499lsrg1jhf1v8Xt4sD2ijv2WA5xxiaXwGXsRq2iMTvfGtxj7n2JC9YwpcE/6KBb55CxiIWq2IzjAY+ZVOQ0RsqE61ol3ig6+ysJUfnImOVjki9VzwNBM8oTWeT0JAZS0xiVCYOjNI/FJHaNtQ/tVJjnlDDrg1Olb862uXi5JRr4Nm5nsiBBGqqHZiKrxElmhkFqUic4n9eXMPL/yilyUIUwUj7qvmx4O1KfwVYIExDGqLjpRjPThLQ9lFareSnN6QJE5LfnNL3goURKrVySqmEagM0dcE8mMvwMDqAHlnuGXzxDlRZzSyIJG84XgbfWRhmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dgt0QWMx5bd0v4vd0jbJgZA6l9c/8LIhFFS9l8EzmUw=;
 b=ZE8ge1OOts4TzM8CPRCvU2h+2Q4xh14FA0AtRkn8zJ+0EkXEHpoHo73sWdUbPlArLFGuBenQkxe88f9wsEikvhn4GcVVxqvylTdU9nuiqkCmoeQwfNjPn+FFmZBJx5rFDT7+acQpmijC1lg+YTyt2c4vyIr4CJ83Jba1AynwvL0oYfhFcp8mrZwwg4KqLGqzUGvnG8ue9Nq/CbuFqqWVLRjvCi/g8eniyKIADgbTcx2YzCzxsqU1MbQpKjf7hzSU7++IWzawshBPbJCkzJxlfwaeraz1o9vz4EJl9i1FekkgSDI6aNldUcMMJjpnKLgfjsAmbJoy/8nHsd2Ei1KiGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dgt0QWMx5bd0v4vd0jbJgZA6l9c/8LIhFFS9l8EzmUw=;
 b=2ED10C8JXwOYKSJnPWfUD6aqI52gdexif4n74d/V6Y5IkDn2KshSRxYmNeVrSYvgHKx7ek/BDwTOH+zkMixix0OZ8zDozGN5QCKpLM44u8tHwgDrvXThTF7J5dxhKJI5aqUCQNqCMoyIPJHAbj4J+UDtISBsSPM8jiHnudVMZzE=
Received: from DS7PR05CA0089.namprd05.prod.outlook.com (2603:10b6:8:56::6) by
 SA3PR12MB9106.namprd12.prod.outlook.com (2603:10b6:806:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Wed, 14 Jun
 2023 10:23:18 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:8:56:cafe::d2) by DS7PR05CA0089.outlook.office365.com
 (2603:10b6:8:56::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.23 via Frontend
 Transport; Wed, 14 Jun 2023 10:23:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 10:23:18 +0000
Received: from ethanolxb491host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 05:23:16 -0500
From:   Swapnil Sapkal <swapnil.sapkal@amd.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <iamjoonsoo.kim@lge.com>,
        <linux-kernel@vger.kernel.org>, <gautham.shenoy@amd.com>,
        <kprateek.nayak@amd.com>, <wyes.karny@amd.com>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [PATCH 1/2] sched/fair: Fix value reported by hot tasks pulled in /proc/schedstat
Date:   Wed, 14 Jun 2023 10:22:23 +0000
Message-ID: <20230614102224.12555-2-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|SA3PR12MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: d35ed990-bf44-456a-38e2-08db6cc15f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FtLUoLG0trDqSRv0z+Z2sxxxIedH+vLkDc0gAd5hW24h5Wig3YboCRutc4mualdqZuDqGGg65DnSQBxid2IfaId1QNqEL5TUPatX/XcwzxaFqLlFEutA8R68KnTSCRhrxeghCQlpXFLpEJdWYUsddhyxbcTdXfa3RBQIC1O4bjFsaVpQahUiVqTvh4sYgBCDLTJLKhxc3ugmNsYn61BB9IeaNPoJcd/vv2Xk7PYnRwYpoArYC4j24ekdGrMLxeiojF+oj96gPY+Qb85ILOKk5O+i0kFC/EhUs1Un4GCZv3MVzDoVWOohJfxMGA5EeEhuMaLewvsItRDEIvFZPk0MHApzQLIBFkduqs2lDB5lLM41ycFsVsxY54zrFJJkLnyxbGyUNm7Iq81efsLZcevylylDo/Uf8GJLZMjYqXU9DM7lBftQgo1fwqOQYcUSRMlloKdqv97WB7/VTdZgp4Ps/iq647m566cBipBBXjLd6vLYU9u4J6RbMvC0FYhHPLEERbk9S9zZC92zNboo8zybr9ncm0EaNJlhgT4696x3QIs6GYNP4CGNi8m3SvEy04wBcfOEeLFxIXURAKFGzzPBfzRx7GVuM8O3a46XMX50yA0YKDNQ3HQGN2kBo+ywn6xeefdc5PeFvQDg5zxnUwaZbtrwZ6HLU5sLmtJdOSnbJU5676ndm0powZIrSZcLc0nYLGxG4n12S/gRYjV/VKQs050bXZlvQhCWoac0qrxuWB9sRNwn9JBqQelOLAicvT8f
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(26005)(478600001)(16526019)(36756003)(1076003)(186003)(40480700001)(6666004)(40460700003)(7696005)(2906002)(316002)(41300700001)(44832011)(86362001)(356005)(81166007)(82310400005)(8676002)(5660300002)(82740400003)(8936002)(7416002)(110136005)(426003)(336012)(54906003)(47076005)(83380400001)(2616005)(70586007)(70206006)(4326008)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 10:23:18.1087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d35ed990-bf44-456a-38e2-08db6cc15f0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9106
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

In /proc/schedstat, lb_hot_gained reports the number hot tasks pulled
during load balance. This value is incremented in can_migrate_task()
if the task is migratable and hot. After incrementing the value,
load balancer can still decide not to migrate this task leading to wrong
accounting. Fix this by incrementing stats when hot tasks are detached.
This issue only exits in detach_tasks() where we can decide to not
migrate hot task even if it is migratable. However, in detach_one_task(),
we migrate it unconditionally.

Fixes: d31980846f96 ("sched: Move up affinity check to mitigate useless redoing overhead")
Reported-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 kernel/sched/fair.c | 47 +++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 373ff5f55884..9a8e5dcbe7e6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8507,9 +8507,9 @@ static inline int migrate_degrades_locality(struct task_struct *p,
  * can_migrate_task - may task p from runqueue rq be migrated to this_cpu?
  */
 static
-int can_migrate_task(struct task_struct *p, struct lb_env *env)
+int can_migrate_task(struct task_struct *p, struct lb_env *env, int *tsk_cache_hot)
 {
-	int tsk_cache_hot;
+	int degrades_locality;
 
 	lockdep_assert_rq_held(env->src_rq);
 
@@ -8578,18 +8578,19 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if (env->flags & LBF_ACTIVE_LB)
 		return 1;
 
-	tsk_cache_hot = migrate_degrades_locality(p, env);
-	if (tsk_cache_hot == -1)
-		tsk_cache_hot = task_hot(p, env);
+	degrades_locality = migrate_degrades_locality(p, env);
+	if (degrades_locality == -1)
+		*tsk_cache_hot = task_hot(p, env);
+	else
+		*tsk_cache_hot = degrades_locality;
 
-	if (tsk_cache_hot <= 0 ||
-	    env->sd->nr_balance_failed > env->sd->cache_nice_tries) {
-		if (tsk_cache_hot == 1) {
-			schedstat_inc(env->sd->lb_hot_gained[env->idle]);
-			schedstat_inc(p->stats.nr_forced_migrations);
-		}
+	/*
+	 * Can migrate a hot task only after the attempts to reach balance
+	 * without the task have exceeded the cache_nice_tries threshold.
+	 */
+	if (!(*tsk_cache_hot) ||
+		env->sd->nr_balance_failed > env->sd->cache_nice_tries)
 		return 1;
-	}
 
 	schedstat_inc(p->stats.nr_failed_migrations_hot);
 	return 0;
@@ -8598,10 +8599,15 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 /*
  * detach_task() -- detach the task for the migration specified in env
  */
-static void detach_task(struct task_struct *p, struct lb_env *env)
+static void detach_task(struct task_struct *p, struct lb_env *env, int tsk_cache_hot)
 {
 	lockdep_assert_rq_held(env->src_rq);
 
+	if (tsk_cache_hot == 1) {
+		schedstat_inc(env->sd->lb_hot_gained[env->idle]);
+		schedstat_inc(p->stats.nr_forced_migrations);
+	}
+
 	deactivate_task(env->src_rq, p, DEQUEUE_NOCLOCK);
 	set_task_cpu(p, env->dst_cpu);
 }
@@ -8620,10 +8626,12 @@ static struct task_struct *detach_one_task(struct lb_env *env)
 
 	list_for_each_entry_reverse(p,
 			&env->src_rq->cfs_tasks, se.group_node) {
-		if (!can_migrate_task(p, env))
+		int tsk_cache_hot = 0;
+
+		if (!can_migrate_task(p, env, &tsk_cache_hot))
 			continue;
 
-		detach_task(p, env);
+		detach_task(p, env, tsk_cache_hot);
 
 		/*
 		 * Right now, this is only the second place where
@@ -8665,6 +8673,8 @@ static int detach_tasks(struct lb_env *env)
 		return 0;
 
 	while (!list_empty(tasks)) {
+		int tsk_cache_hot = 0;
+
 		/*
 		 * We don't want to steal all, otherwise we may be treated likewise,
 		 * which could at worst lead to a livelock crash.
@@ -8690,7 +8700,7 @@ static int detach_tasks(struct lb_env *env)
 
 		p = list_last_entry(tasks, struct task_struct, se.group_node);
 
-		if (!can_migrate_task(p, env))
+		if (!can_migrate_task(p, env, &tsk_cache_hot))
 			goto next;
 
 		switch (env->migration_type) {
@@ -8742,7 +8752,7 @@ static int detach_tasks(struct lb_env *env)
 			break;
 		}
 
-		detach_task(p, env);
+		detach_task(p, env, tsk_cache_hot);
 		list_add(&p->se.group_node, &env->tasks);
 
 		detached++;
@@ -8766,6 +8776,9 @@ static int detach_tasks(struct lb_env *env)
 
 		continue;
 next:
+		if (tsk_cache_hot == 1)
+			schedstat_inc(p->stats.nr_failed_migrations_hot);
+
 		list_move(&p->se.group_node, tasks);
 	}
 
-- 
2.34.1

