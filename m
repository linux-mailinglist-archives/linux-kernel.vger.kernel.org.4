Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CD56ED9D2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 03:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjDYBZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 21:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjDYBZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 21:25:32 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2098.outbound.protection.outlook.com [40.107.94.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD485277;
        Mon, 24 Apr 2023 18:25:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBOPn7AQzM2VT9DMEy6Mtx6cSaXzn/g58O3Ce80BWzHIv20APjIeUG7bEEJK1Dmj8mUZu5gAFXG+kuSX2CXVu283ZgxYEySp7t/Hp6H2kpD2MRzfBk7diJsSLW3hbPwWmQ5z0K72UnO+3coDmcWP5ILJnhXaVvsG7aQ/1utASfP6/PsIREOoIQ7IwyU16StcrY5299IwiJKgaZ84uWbbBGjaMgtqp9FPZfJGN6lil6UVnHlaqZpWoQH9dYA1sjas5Cvr0/C8dp1hcKsHMRjCFSMGG3dFK5m8Jeigoaoakvkhkc8ZUR3KBfHwXsOieAdA+w2/iI1wzT50RV8HPUU+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6q5c72Jrgt5P2R4yQPkxvPxG3XQdl8DHTOaVBkzjAZU=;
 b=YqthZqy44OpkwwSEDpAi6v3nvJiAHW3WW6GD96nYkrvvWTEukz9DBuCW+s7GeTCFroLACnpycaROSok0xDGemg8dGq1fhnUu0SIkvrR+FCQ2cFBIvBiFgGsqGxUNJcArfeBm63+/JQL6AQD3WtoiSip3ig5evJvEZGVQlqxPTvaH2I/zHvKa4doTJ4fcdvp0ypzbALKL5FnB0sK+vbSdenOLNYiDsVLSoRPhAu6gFK4e1Imif0ALqZQ8HWcuFcRYLKGLKYQ3jOnh+Z1vTPxBhZ45qoQcbwJmGUBgiDqjPIHT096b53Zzn/nIXTgsUE/xrNCHdy1N2hGcf4dGIXZCJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6q5c72Jrgt5P2R4yQPkxvPxG3XQdl8DHTOaVBkzjAZU=;
 b=DUjNJuxnf//25Fd95TneOXtNb7xcfEthbTitH4ikntpzIx+6pZDDr91L7jE53/kNPspVU9fBr7rw94NpofKOl4DyHUE/NklfemU7ChK0TQ5BD0oxxEro6cBKIR9/XN5YfulKqGKxqFIqxLwx/0M/Fl/TLtcfu5cPi1Duc/JUNig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 DM6PR01MB4635.prod.exchangelabs.com (2603:10b6:5:6c::20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.18; Tue, 25 Apr 2023 01:25:26 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::e0ea:cb46:91ef:f961]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::e0ea:cb46:91ef:f961%2]) with mapi id 15.20.6340.019; Tue, 25 Apr 2023
 01:25:25 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com,
        Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH] sched: add ttwu_migration counter
Date:   Tue, 25 Apr 2023 09:22:34 +0800
Message-Id: <20230425012234.15388-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR11CA0017.namprd11.prod.outlook.com
 (2603:10b6:610:54::27) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|DM6PR01MB4635:EE_
X-MS-Office365-Filtering-Correlation-Id: fe586241-37c7-4e0b-83f6-08db452bf234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kv5bQvJXTSkxjYx+ucuqTxGuTejFoXecCR2iwA7JvepmbHhciEyvgEK9QBACZ+3WlAJFGF/kyzrWs0uj1waGusDafvnTmgef/7147G9u1owvwwywB/G1x0SRnGEn5mRjdn8HyG4o+OkZ3zqX0djrPsSb1CxO2VVWEQGRICdW/Ce4cg+yt8E64m0WFwFNZqwFlveFeKIZNhs7dfMFr9rTB3L/etiy3YnUdmKn6Ks/LsmGleNn4B2Gs7FqnZ80ATmGq5uO4jsmNVPtibfo0mhPdk0u2O5AGjWiz2qWx0MMOVqaEE5V8ilZvkQFjGXROPXgGvAaFGNunkY7FPcyutxJxhN5NKwuVlzh0ULwnd242B3mP2ek1eBnIokRS909OUf1ULZjDeMjvdLSHa+oJml7+OzVhky970dAZRzArfENDg61mpsBhFmi8MnsVnF49KTOKYytPWg1Rw0kYyjyzGXo9rxn7ARramYFUPVJx52KQ/619GY0tNZWynN6agW7DN0c3Em/ywD9eh/VzzbyITI5HWND8gOKYzhWj3cSE1zHoqDY/yVLl3O9gZAUSG5nfqKJ//BQRlSRDW5h8P6LSrRtpCtjfDRSzVZCI61rQu0cu9aI8pnrKiqc+R1h3+ehCbPZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39850400004)(366004)(396003)(376002)(451199021)(478600001)(316002)(4326008)(66476007)(66556008)(66946007)(6916009)(7416002)(41300700001)(38350700002)(2906002)(8936002)(8676002)(5660300002)(38100700002)(2616005)(6512007)(6506007)(1076003)(26005)(86362001)(186003)(107886003)(6666004)(83380400001)(52116002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f3TJp9Xxd7VHd+Rulu6ulPfDJR9XBzeooZWeDzeF9+I6AMaMu6u3Pqq2nzyq?=
 =?us-ascii?Q?9Hk8vd1HJG3XjSLbKS76mhulBysC/IhAVIRcUN8fdlmolzKFsCPFUV6EyXoo?=
 =?us-ascii?Q?wIeJj3iPgrDdupnMfVcIWwso1Ss2vJWyjx9Zb9gRpcxFHZ/kEQZ4Exvw8xGK?=
 =?us-ascii?Q?6V2J4L0pSMh3v/Rp6TXYmKyhnbJUlumZEqLF20HCGKc+NxCrTvpKZf1aoMxl?=
 =?us-ascii?Q?BprG6I/HUw0JhzvsAgOsCo45f2oV4P777ymkHXzxhdMGizizoAmz4WXUSOJ6?=
 =?us-ascii?Q?Fb0Plv4uf8nYk5rlpYO/v6CFVxRADvoNykgrqTWwXyo8gvQdKE7f6ipY6m7u?=
 =?us-ascii?Q?fAZlY8j7boYskNu9ux4w2+IrNSX5bayijrfcx6btRetY3OIerqS9JqbxaMGj?=
 =?us-ascii?Q?dUFHlHRcXJ/ne0rvjK8bJAQzneO2X0vy0upD7fMCFUh7iY+AzOYUjG1VGyO2?=
 =?us-ascii?Q?pYqvYqrCeQe+HK6XKYajJU7RnCIlF5YL6FaT3fHOE12+2aXLz5vfIQKlsB/Z?=
 =?us-ascii?Q?8j/nO1vxQAljz9QkeT0Sn7LXnt7DVkQT3CHQtt8G5+MPWvTs/ZL8Vd67Ac1w?=
 =?us-ascii?Q?W0SFtpcgBrFEnkDCi27AQGGfzlQ7CapnV/DzpZZaHG4jgtF0uGng+dSTLG3G?=
 =?us-ascii?Q?qKnUXfj9wSBVRxuWyxFkZR4cmXjuxkj9we4jy//OnhFbdIcyKZ0AA3ba6EHo?=
 =?us-ascii?Q?sk798axUqGxGn/SObakzkL18jYjlhkaua3+Buin5HDU0SxT7IKOyY+a1FYaK?=
 =?us-ascii?Q?T9O57ZCExHu2Og6mOrtsOv+rYlcp6lS9g/fd6/3H2PCbr8KYiWYBVJaM0RFd?=
 =?us-ascii?Q?1NlbGcT2CDexOJW9P0IZHPm+ikHczlfSttUsIh0L2n5CHAQX+ioh2ZYCg0aD?=
 =?us-ascii?Q?AdGxZBlfYoQkYukPgWTucGuEzIM+nUFYPT4dSuhJs2n3qexTklkvlCEPxaVY?=
 =?us-ascii?Q?xPiAUKsKdunRqnuIQWq3Qnh3yiVDtxuaATI1w7woJMAz/vCU4r8G9aXzaT7K?=
 =?us-ascii?Q?o/if98FsvRJH8ItASvQ1DzMscO6kxnELrGkutFFRKAb7B3SD7jwLAEBS54zx?=
 =?us-ascii?Q?YOw1X3H1zLDbM1X6ocVpLZGJwqfA3tQjgivKuc9uPAnyQxpqIYapt4hCXwwy?=
 =?us-ascii?Q?+zfP/DnzQEqVpWDV4e8WZUwZc7Z7A0DxvWOjJvSQHmTgYzUol+J8pIFp0CA6?=
 =?us-ascii?Q?nSF0rmw8lUPJd0ZtYduqm+FOc82O5BiZkH/kZChHqKI6cyjQDgy+EH+ZKYHu?=
 =?us-ascii?Q?WIlFtaM4qc759rYKjV9cN2ctbAlSub70PBY7UeR8XUdT4+JkYR8SMushG/nw?=
 =?us-ascii?Q?SNwJMg0FBY1cODS0gNWXT4F7eK/sCLDsWmIZCK3m2tlkzCEuFtZtUa2dGegU?=
 =?us-ascii?Q?3/6nSK05e2KY6JpltfGC80XOV2DxmJVMUKxHiPO6SnvyctSE2E+lWLjOsyDf?=
 =?us-ascii?Q?Hdo58qDM75q1L8NkpBdtyuyb3bUoDLlEDmvG0AXurKlzgjCSF4zXIMlDqibi?=
 =?us-ascii?Q?kDRd1spGpYRhqdDMRWzpkwyZrGHSALOiIkVV9i50z1Xow/9V4Q9awL6WdsYJ?=
 =?us-ascii?Q?lrorllJeOwbXvY6QjSccFk1funJAVqYICA4Mn89taQjhgQOBQFqo2R/vTw0d?=
 =?us-ascii?Q?weiRl5lAI3826HesmxZ6tKU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe586241-37c7-4e0b-83f6-08db452bf234
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 01:25:25.7016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UKLRaLrb/b1AD8d/Fii7uogOyDsqKeKNWL7aaAK+FDN9i1m+q7Hk1WgxvVmGLpi6poFr/Ic4AhyI2t4h1i8gjlacRTVLkE7HcO3BOOAV2p2CMEKQu9krHmCMUhjAabZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4635
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It maybe involve three CPUs in the try_to_wake_up(), for example:
	Current CPU:	#0
	task_cpu(p):    #1
        Target CPU :    #?  <-- get by select_task_rq()

ttwu_local: record times try_to_wake_up() was called to wake up
            the local cpu.
	1.) Note ttwu_local also includes some migrations, such as a task is
       	    migrated from CPU #1 to Target CPU #0.

ttwu_wake_remote: record times in this domain try_to_wake_up() awoke
            a task that last ran on a different cpu in this domain.
	1.) Part of the migrations are recorded in ttwu_wake_remote, such as
            a task is migrated from CPU #1 to Target CPU #2.
	2.) If a task is put in CPU #1 wake_list, the ttwu_wake_remote will
            record it too.

Current try_to_wake_up() schedstat does not have a migration counter.
And we cannot get the migration number from the ttwu_local, ttwu_count
and ttwu_wake_remote correctly.

But we really want to know the try_to_wake_up migration number for
analyzing some benchmark tests.

This patch adds the ttwu_migration counter to record the migrations.
Put it at the end, do not break some tools.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 Documentation/scheduler/sched-stats.rst | 4 +++-
 kernel/sched/core.c                     | 4 ++++
 kernel/sched/debug.c                    | 1 +
 kernel/sched/sched.h                    | 1 +
 kernel/sched/stats.c                    | 5 +++--
 5 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/scheduler/sched-stats.rst b/Documentation/scheduler/sched-stats.rst
index 03c062915998..3220dbe220d5 100644
--- a/Documentation/scheduler/sched-stats.rst
+++ b/Documentation/scheduler/sched-stats.rst
@@ -36,7 +36,7 @@ to write their own scripts, the fields are described here.
 
 CPU statistics
 --------------
-cpu<N> 1 2 3 4 5 6 7 8 9
+cpu<N> 1 2 3 4 5 6 7 8 9 10
 
 First field is a sched_yield() statistic:
 
@@ -61,6 +61,8 @@ Next three are statistics describing scheduling latency:
         nanoseconds)
      9) # of timeslices run on this cpu
 
+Next new item for try_to_wake_up() statistics:
+     10) # of times try_to_wake_up() was called to do the task migration.
 
 Domain statistics
 -----------------
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e0fc8f7c7487..f0038c103843 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4288,11 +4288,15 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 
 	cpu = select_task_rq(p, p->wake_cpu, wake_flags | WF_TTWU);
 	if (task_cpu(p) != cpu) {
+		struct rq *rq = this_rq();
+
 		if (p->in_iowait) {
 			delayacct_blkio_end(p);
 			atomic_dec(&task_rq(p)->nr_iowait);
 		}
 
+		schedstat_inc(rq->ttwu_migration);
+
 		wake_flags |= WF_MIGRATED;
 		psi_ttwu_dequeue(p);
 		set_task_cpu(p, cpu);
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 0b2340a79b65..f0fd4e2795c9 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -809,6 +809,7 @@ do {									\
 		P(sched_goidle);
 		P(ttwu_count);
 		P(ttwu_local);
+		P(ttwu_migration);
 	}
 #undef P
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 060616944d7a..48b552f6b87f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1123,6 +1123,7 @@ struct rq {
 	/* try_to_wake_up() stats */
 	unsigned int		ttwu_count;
 	unsigned int		ttwu_local;
+	unsigned int		ttwu_migration;
 #endif
 
 #ifdef CONFIG_CPU_IDLE
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 857f837f52cb..5651d4c0a63f 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -133,12 +133,13 @@ static int show_schedstat(struct seq_file *seq, void *v)
 
 		/* runqueue-specific stats */
 		seq_printf(seq,
-		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu",
+		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu %u",
 		    cpu, rq->yld_count,
 		    rq->sched_count, rq->sched_goidle,
 		    rq->ttwu_count, rq->ttwu_local,
 		    rq->rq_cpu_time,
-		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount);
+		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount,
+		    rq->ttwu_migration);
 
 		seq_printf(seq, "\n");
 
-- 
2.39.2

