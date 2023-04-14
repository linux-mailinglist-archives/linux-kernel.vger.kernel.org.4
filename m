Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA856E1AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 05:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjDNDOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 23:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNDOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 23:14:04 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0224826BE;
        Thu, 13 Apr 2023 20:14:02 -0700 (PDT)
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DK1BqS002015;
        Thu, 13 Apr 2023 20:14:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=proofpoint20171006;
 bh=kOWlrgWvXP/s+kHRs4Og4N+36HjoL1c9IoRufJv4b4M=;
 b=YopHdrb8Gw4QWGRan081hD0UaUi/857fw5xw5TLKr0GgjdRsVE1EJhM5Y251xfZeDWZA
 U4b1IB2WJV2eBhwc5de1dfUM9e4bYv2WmzFDFjvg6hXaOWw+3lncaOE45a8HsAT7NhUe
 pgE86rU16j5EmBwcvKpks+bBok5bVJ2LynXWrzMug9SryjGD+7HAKd8sOL+eQWOZvzdJ
 Gj4rweHj6dCvQqon6OyOKpOGI4ctw4TrOs7aIFMs1S28MQtfQGc/9GKgvmMEa+ARADJ4
 zO1OUZf9xEFig2gfpuaj17rKEyaJjQmUFGxwdkW8zUySqRSG40piHe0Rw9JRZRpmK5+B +Q== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3pu7t454kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 20:14:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iw3EofHD76KecRdO8Xh6gwauniO6N+tV17YCHqcmCnb3l9E6uVFgvcXjjwRkQ6mCERlCwEIbYC8cboFLPFNhXAvIYnjLDcIaUeJEjuzNRweCV6ZhSOSX9w3yB2xIIjFmCLpImH0Ac6aFnExShjLcKO5TQuNmZ3tIro638lMpFGc9hKbJaGvOMqaaaPbVgfl8y2nWWivAkallYuGgFcoM7ha8KBZdyBK+JHgiRPlp/7AfJ20RzfZFxL3ZCdlYizQNshaNPUkvuyNRkj6uRLMl4saEG/dBokwekQVw1aR6UKfcRq0Sao869gFAOegra9wMCm0OTRCyWXNNhFwHH7/YOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOWlrgWvXP/s+kHRs4Og4N+36HjoL1c9IoRufJv4b4M=;
 b=CG7QrqW9eTo0tViNb+JNwIc5WBv1JzxZgc1bSYJv3xAWx8XG+ziF5DGA//yfZyRvoGZmpHIu9FsLdJHy+hooRlPmPq2OIhM4GkLxXM0SXhazpvR8Jn3XFLVli2rmXlntkEKbaQS2RYtqUmJJiUhwI4TpOlS++O5W28RQhLtPHo5xxQffyUZ++UPSttwOLvWTZUDOVdzQICSYVfYZR0RQAsHhLc4URXqDC4MA8iDmr5EF+0G2X+rxjNh7QaJ745AUiaJG/Skk+v9SGCnuSq8F0MRll6MpuDsBzX2//M5eAay0+Xc+fvNXvyR8HnxZua4StteMoHtsCU2Ds4fSUj/AnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOWlrgWvXP/s+kHRs4Og4N+36HjoL1c9IoRufJv4b4M=;
 b=sYKicR4gPs4eKtnPlB3nWKwDssGDMduceID28MjrM1y5z8FYBjSdxX0KB+HBtyF+/Og8ZFAuIPAEf/CWfyRsF7mW1YZ2DEltUYr6g/1K4kxuok4QIBI/tkAJjfAWd2zTIFn3foxKrlXBWp4j06wVTVp+nVKF+Pv09I8Z8Befqnhi5rSUYQMgjy/nWZsTTDZU4EGBlP2ebslNtm26mMtmPGSNZextQyfoIOmy1iUdHQlGjM/SXHqB3oG61HRGAi6cga2amJRT+UMZNtdltOfrhz4j52tWLix5tnpdWPkpDhJK2zD2UR9+oGZ3lkSYGr7hMLr3OrSqPyGqomIG2ftrHQ==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by CH0PR02MB8076.namprd02.prod.outlook.com (2603:10b6:610:109::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 03:13:58 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 03:13:58 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     paul@paul-moore.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, audit@vger.kernel.org
Cc:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Subject: [PATCH] audit: use pid.is_auditd to make auditd_test_task() faster
Date:   Fri, 14 Apr 2023 03:13:25 +0000
Message-Id: <20230414031325.82840-1-eiichi.tsukata@nutanix.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0043.namprd02.prod.outlook.com
 (2603:10b6:a03:54::20) To CH0PR02MB8041.namprd02.prod.outlook.com
 (2603:10b6:610:106::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR02MB8041:EE_|CH0PR02MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 55383a4b-5c0d-4464-6dc1-08db3c964986
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bdI/ate2K22b6TYCZmWZEXwf8TG4+kdgIGc3qPT2Ka3asvvEFLHOYPwF0pFtgHPFN+nq2uuG4yOGfEAK8ZXYs0KMLY1JdXnyx5Rdz2AOMMCAf358m/nDCWstMkIOv+iZuqNI/cF4o7acryKX52F9tG1Tii9pwszWHWxUgZhT4bfQ2W4VNbuxhpJUqtCJZxbhjlV7eRRu+ujr1XadYgBbEH6zC63JlK96r+E0XwOEDrqSCe3W4qgZCet+aqtk2oZEX6o0d2KrRyg+rtu8zqzAratmx9wrQek/9doy+hDIDHlW4jR4geqfbc5OCYG8zEmmEHyr+anVIgfIxVcltt7gdMzyznZmfBrWUpHTT7EGgAevTxhxAiuekturPvCJX8LgMboSwdTCmDSrFwNLMciRqvmTvxITWOaEyTNs3N7yIDpDj/hDRatQ5xzZwHK1AOPi0xmTkxL/Znwz4BSelEufUqC2m4iHNpn1Jl8w102FEwWUsS9U5/ILbb0KojG9P+iFHtitAvD7LlyoayX/tmQno5nssEyrHiljVa8U/BaByRm1pODLgYqHfdktjp/LnUkI50uFk/i3WUAZiw5vHEvAGQoF5ks+vlA6v/y3+SdN1unoLDqWLaQ+v1aCLzeq9y5C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(2616005)(2906002)(36756003)(86362001)(38100700002)(38350700002)(41300700001)(83380400001)(52116002)(6666004)(66946007)(66556008)(6486002)(66476007)(316002)(4326008)(44832011)(8676002)(8936002)(5660300002)(478600001)(26005)(6512007)(1076003)(186003)(107886003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7IXW3WjW9OuyUf5PZLE4sYtLhO8qqDvhw9jSm3OhNtbF2fAHTKomEnoW731o?=
 =?us-ascii?Q?oGWqJUKE7xaG7xlGBA7D/gIfKl7DWbMNL47fs+wXSF+HbbzokaqH8DzTdNxu?=
 =?us-ascii?Q?S6kFkSETiM30+cH2mt3Tt1Q9QoLc3uH1/wgFtTowfUH8GxTUiotKpOHRkSbc?=
 =?us-ascii?Q?ouRaYihNY0cHMi5NGCGo/EzH3rULWME/xbQ1y6/PI41mRtH/vD4/7JmBnvCQ?=
 =?us-ascii?Q?lBtutuBjuMZhBAaulm/LyrQk5HVRlck6mzZVksZoZiyTM2oJ4N+nSpygtrlX?=
 =?us-ascii?Q?7QJdU8dmqU2W5imyzl7K7vzXdVuOLVDWRhEL8e5ldBQ9USrBF9XUwTy2Y3Dc?=
 =?us-ascii?Q?fAIszZ/w1JoBoRnpHzMOGyJLkoIP+AZspt+6fBzoaYhSRsfmSIWVj/d4/Ztx?=
 =?us-ascii?Q?XkXgxVqNUiCFOIFDtputroH7dlcGMT3YeWpCTbYPRW442io+tcR1v/klvnwc?=
 =?us-ascii?Q?qiXj5YLyK2HNWwQkultqjpElTP5ISubDqo+x3uLY2gO86ALcjZ7PFiTFIYOi?=
 =?us-ascii?Q?WZ5ekMVDRTu9Ug2GwUQ1Mb0kQ7VDLLuPnkHyjJZRfRdiekfBoHhil33b0abe?=
 =?us-ascii?Q?lcxQUOM6SxuhDoo7lkrFw1xnZCtQuKaRiTKxauBRqCXrImid7cgVeOmIw6Es?=
 =?us-ascii?Q?NedlVzpA9ca+rFBYePgP2JpfCaMpLu3e8dyhPFhP0+dUeIOajEYriV7VMVYT?=
 =?us-ascii?Q?Z+GcF1FdizgZWBHfpGSDL0Qqs7Ae6YneuTRRIHOFExNiofInxdWD3bRtoxhq?=
 =?us-ascii?Q?M1uCUcrm/wQ7OkZ7FVuxj35TgOtScBzBzQGab1lmx2LHBGz9zCjQJRNRu2TQ?=
 =?us-ascii?Q?iJqZJr0kdmxyB+Elo0gsuSdOMdEJ1kTsdQDR9rDRxoxfnsofhS7OMweV46JU?=
 =?us-ascii?Q?aQ3ScKI4n37gfh4N3rw63k429Z9BCdotMlfSCU2MIB/Pmy4LSKz6u3fymRt7?=
 =?us-ascii?Q?rlZAUCaIcpvsLoWRPfzkImpd0KkP52NPGfU2v5B5+yDAS2ZEYHayg2cP8J6J?=
 =?us-ascii?Q?v0hapybIXyoaOcZyuAzZtwRkkYd/p6k7wKN17zrxMoCyji0+JHHoN87Rq8yg?=
 =?us-ascii?Q?XBxwaP5KX7bjoH+mWlfqyaHBk4est/iHiICDcoWxpSCdI9lUMkRGtZJfJctb?=
 =?us-ascii?Q?raZKYyu28wHDWW7/4sPrr9p2zgPbhIOrbVjHAJ10BKWn+D/8ReTD39EBF24d?=
 =?us-ascii?Q?JlF+tchUWdWn02x2PAw6Duzv/h6kvfHKRWC3J3J+3VekpoyQz5PNl8SK8KkK?=
 =?us-ascii?Q?uzk5U7lE+E9DylVHwon1fui6vVmd1UIhpMRtbEBHQ9lD5mO36kvvXmYfuW5f?=
 =?us-ascii?Q?T7jxJw6W54wb8mzbjXcRx9wpJb1N74aVFukiibMpukXcDaN9PAllkDVvudwT?=
 =?us-ascii?Q?9rpWOOpv9Ulmz3MplxDJ2SFpwtSEB8blq+pOcRtgDMyjWLXU65Hk84QZQxV3?=
 =?us-ascii?Q?mLQ2hYPajElav16HTp6ofixkVvJyrye8NRLL95gbkUL3Z1YT1ArSf9oKNws8?=
 =?us-ascii?Q?kN+DMLA01UvIr1aJZWqfKm0Dch25gEiLmIsnxBH4LmJmEMU1Go56Y5UvZBLT?=
 =?us-ascii?Q?HlFYFmSBdLoj8iK2Vp8iURryFW40IwEAq2+WTKX7+KL+nwSbyCQyAPwWbCle?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55383a4b-5c0d-4464-6dc1-08db3c964986
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 03:13:58.1041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 986geEPGVh6gJwfVbh5VujXHlCu3dP9DDNZjQ9Hrvy8j8q3/ewFfsdOSlqul4woRBfHckMjXpvb1QpVDNKUGWxEr8tvu7IY9P3apmca4e1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8076
X-Proofpoint-GUID: -OKoMLTohLkCF7-pzYyk-v1xEIF3Ywem
X-Proofpoint-ORIG-GUID: -OKoMLTohLkCF7-pzYyk-v1xEIF3Ywem
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_18,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

auditd_test_task() is a hot path of system call auditing. This patch
introduces a new bit field "is_auditd" in pid struct which can be used
for faster check of registered audit daemon.

Benchmark
=========

Run the following command:

  dd if=/dev/zero of=/dev/null bs=1 count=5M

With rule:

  -a never,exit -F arch=b64 -S uname

Result:

  Base line    : 2.572 sec
  /w this patch: 2.412 sec (6.6% faster)

Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
---
 include/linux/pid.h |  4 ++++
 kernel/audit.c      | 22 ++--------------------
 kernel/audit.h      |  3 ++-
 kernel/pid.c        |  3 +++
 4 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 343abf22092e..5fe38e254c9a 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -68,6 +68,10 @@ struct pid
 	wait_queue_head_t wait_pidfd;
 	struct rcu_head rcu;
 	struct upid numbers[1];
+#ifdef CONFIG_AUDIT
+	/* registered audit daemon tgid */
+	unsigned is_auditd:1;
+#endif
 };
 
 extern struct pid init_struct_pid;
diff --git a/kernel/audit.c b/kernel/audit.c
index 9bc0b0301198..964d1a20c32d 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -208,26 +208,6 @@ struct audit_reply {
 	struct sk_buff *skb;
 };
 
-/**
- * auditd_test_task - Check to see if a given task is an audit daemon
- * @task: the task to check
- *
- * Description:
- * Return 1 if the task is a registered audit daemon, 0 otherwise.
- */
-int auditd_test_task(struct task_struct *task)
-{
-	int rc;
-	struct auditd_connection *ac;
-
-	rcu_read_lock();
-	ac = rcu_dereference(auditd_conn);
-	rc = (ac && ac->pid == task_tgid(task) ? 1 : 0);
-	rcu_read_unlock();
-
-	return rc;
-}
-
 /**
  * audit_ctl_lock - Take the audit control lock
  */
@@ -478,6 +458,7 @@ static void auditd_conn_free(struct rcu_head *rcu)
 	struct auditd_connection *ac;
 
 	ac = container_of(rcu, struct auditd_connection, rcu);
+	ac->pid->is_auditd = 0;
 	put_pid(ac->pid);
 	put_net(ac->net);
 	kfree(ac);
@@ -505,6 +486,7 @@ static int auditd_set(struct pid *pid, u32 portid, struct net *net)
 	if (!ac_new)
 		return -ENOMEM;
 	ac_new->pid = get_pid(pid);
+	ac_new->pid->is_auditd = 1;
 	ac_new->portid = portid;
 	ac_new->net = get_net(net);
 
diff --git a/kernel/audit.h b/kernel/audit.h
index c57b008b9914..aecf334a699f 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -214,7 +214,8 @@ extern bool audit_ever_enabled;
 
 extern void audit_log_session_info(struct audit_buffer *ab);
 
-extern int auditd_test_task(struct task_struct *task);
+/* Check to see if a given task is an audit daemon */
+#define auditd_test_task(tsk) task_tgid(tsk)->is_auditd
 
 #define AUDIT_INODE_BUCKETS	32
 extern struct list_head audit_inode_hash[AUDIT_INODE_BUCKETS];
diff --git a/kernel/pid.c b/kernel/pid.c
index 3fbc5e46b721..c0efaeee99a0 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -183,6 +183,9 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 
 	tmp = ns;
 	pid->level = ns->level;
+#ifdef CONFIG_AUDIT
+	pid->is_auditd = 0;
+#endif
 
 	for (i = ns->level; i >= 0; i--) {
 		int tid = 0;
-- 
2.39.2

