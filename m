Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8E76770E9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 18:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjAVRIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 12:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjAVRIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 12:08:07 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11012003.outbound.protection.outlook.com [52.101.63.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC24126EE;
        Sun, 22 Jan 2023 09:07:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8ugY3d/xroG5esZm9hCwsKpl2JBkfGvuS8cESE/58s71TbqJ2pp/Rnfz+K5XFvamKCGFZCP87Z94GjBxHiSL/ctb0dmtzfNSvCOu57CeDPY3WDK8WH95vb9Fsc6gSbsjquf1oEUqdaVw5i2Jlad7IV7X2p+wdPYG9oE1yo8gU5b8pC/PvuFWXZ8HJWOJt+nbwE8Mr7Vn1dT9HR+2RuM65kwSOqgkR/be25QwH2MrPcQZXuSsrKiUx/gqyvBoeWZhHn6Z6VZyOxdx5klwoQUA5ubj7va7DhAe1m0O3G/asZ6ojtiHAH34JfJqusD21jaiMxoDI74JOMwrDVp47xfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXZMDF8bnMkUbDpMzT7eWhMiDEY+Fcv0O10N/nhU984=;
 b=H2mE/5SphUzVlGAyd9OgVqsyeNZvNikEnJde/zIH9tsFx6AJ4hK+XcezaNmGMIKC61ne5NFBAPN4Zhayn1twCBfQOYyu/w28GZT2diCk3g6OfAMWUtqv8I7MgYqa/D4dnZE6suioPJ5L0wPc0JTFZEkVHm4bskJ9z9zTASCoikNyYHwZuYBY9D94TRpiJSIQcvaWGueod7qvXL6ID1bpl2BeP1N4rMmDRnWrglwZf1ypo4fbXO+1agZseAgwliescZaTQS6t3exrNIC2Obf8JmSGamzGPaXgQRTwgQ6OM6U/ivtt5nROd24ZekfnqC5bmAZUyjsKWmKgkBV7OWOFrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXZMDF8bnMkUbDpMzT7eWhMiDEY+Fcv0O10N/nhU984=;
 b=sxdRRXQV9aTd/AMPT10nKpHuhAmUGJ+F9tbWWuUSdszzC8m/NoTBbqgQ0bcT9K9Y4AQZhTCFYBKKqncPb54aVEQnaRvkt3+7SvznN/UYmw36iHqS2Byav38eaLTU4gCdOLXbTW/t3KLsvhFx+ixW0IfUFgDWzQDg90KSrju+bx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MW4PR05MB9322.namprd05.prod.outlook.com (2603:10b6:303:1ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Sun, 22 Jan
 2023 17:07:37 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::e710:a9a8:3bc8:d0b0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::e710:a9a8:3bc8:d0b0%3]) with mapi id 15.20.6002.031; Sun, 22 Jan 2023
 17:07:37 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        chinglinyu@google.com, namit@vmware.com, srivatsab@vmware.com,
        srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH 8/8] eventfs: moving tracing/events to eventfs
Date:   Sun, 22 Jan 2023 22:37:07 +0530
Message-Id: <1674407228-49109-8-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1674407228-49109-1-git-send-email-akaher@vmware.com>
References: <1674407228-49109-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:a03:332::19) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|MW4PR05MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b7aafc8-6cfb-4577-b204-08dafc9b295a
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Gad1UteF6BsLvJzcc7RyZy9jBechqmWa4oh5Hjm++v+Ul5mdEMS1MrMufnYm+y2U5eTO4firkNRC+epYYoBN3PFYLW3Kr38hpoUfNJ+dZtfxnygHerXCu7jAI/dfcQHJ1EEKb6/uParEeiYf+M4dLwl9mqGIwQmfis9GFrUiTCt5EAQbQkr9f2Hwq0ft2QZHV2/1ow8t0yrii2SAsa4Pr1F7c9ZeNL2BmM2ydD4qUk8V8CfF5T1znGNCvcjdHYzel3fdK8lcx1bW14Tnk9ofUwdOMalt/dtkM4yVtmZuOGSG+S/nP/5ijSKGNkRMceJtTMsPUH/x1XZh/R7MKVz7n9704Gc62vKezZYFTa/Ip7bEORLjI0oyA8CB03JmUJmN+2tY4eCKtKwq7KyxwyVntpMMduRrf5XqUwpU/GF8A4BbQVkSxZpUzeuqofW5EoQ6tP95+PxAtGaM3d9wv4Iax8rrAS4ld7mCaYdrd7X9pp7upAOe0fYOTWk8lkuy12ypl/SZQCqBD6sj9gHE2PteGeTBti0IslxBfPyVl+PiN+9tvdCnO3h4yESwEdweJyoGvIZ/9pP9Im/GCuKlqcBaMZ5pNY01G2xDLh6947mS/vcnsBl6XymOjXE9+t0ap/E9EOS1bwd9V/TfupXVXJtnlmCMZljOOP7Tfy+Bv1FHDuYf7KYv6VEvv6JMMKCM/9xQ7jREch6dlQ+/BRI1T4D+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199015)(36756003)(8676002)(478600001)(2616005)(4326008)(66556008)(66476007)(6512007)(41300700001)(186003)(66946007)(26005)(2906002)(86362001)(83380400001)(6506007)(107886003)(316002)(6666004)(52116002)(6486002)(5660300002)(8936002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l2j5hCA1ww9oXQiU/kM7TzoGe6GnLB6z9Z8bF7S0rvKbhcWKj8zEzKIaac4g?=
 =?us-ascii?Q?CbhO4EmhjCqMN33DNC3Rmrf9b4i/3Tm2q5y9JPG3QIp0N01JNvUgXuDjVo8k?=
 =?us-ascii?Q?Df7DlCRA1lL4/1P4kKbe3VUNpsX2uPy/bUsYsO1D1ZD/ey+XGQJjNIljsnoz?=
 =?us-ascii?Q?PK/GW/Z9AMtl7Yvc1fLaKLScD2w9RwBMGSjFqj4zT65SvIc7TjnQSYR+H1C0?=
 =?us-ascii?Q?ai0vzphVY261YJQq5gKAXd6NJrPxyfv27ZNOoa4OLOdO6oN7eUT4GTj9jwCL?=
 =?us-ascii?Q?Iok/vVD1EGEu57U31gu17zZGtzhhGNCdVicMFHiwZxtNXoIL8ZK/c4oTJrzj?=
 =?us-ascii?Q?vpOFUsAFOKs4Uq4x2tME07NJ9q4EUpjvoh8UCr+uq74hRV7L4i5yOjQ01i0V?=
 =?us-ascii?Q?u71YUsYBx1te/ETKmNXc2CEsDrZkcUaew6dnafuls60IrhYb4ndLzpY5r1ue?=
 =?us-ascii?Q?oJrS9FmzhFD9nmRVUuzGfQwEXtxt8u8QWWp/68r3O2bP2t56sgxNeRcNcZ24?=
 =?us-ascii?Q?AXFK7tuYuBhJf0ZIExCHXUJQRylgA+63tC/B8AUzqHqEl8pfhx3tKaPaKAhv?=
 =?us-ascii?Q?ooIsUXEkVKUJKBycukzIly5Wlc6GoDbC0IcPb3ij9YRxik2uVuDsJp3Kojsx?=
 =?us-ascii?Q?fsZiLzX/x9YJY1lVhBpEduYz/77SPI0Z6tJWA0a5YTsDl5GcRJ+vj5aFPHYo?=
 =?us-ascii?Q?dE+RMwBI+olfRnhtbifF8wthKC9EeWDHGc6+gqi/liuCvRdHDNwaOqQRD0av?=
 =?us-ascii?Q?MqHSujjoDVY74JxURQDGAMO7HBOn2n4U3DDpMQzR8UzHMJMmHZztSPKdrIYK?=
 =?us-ascii?Q?oV+EDKqZ9d6O1UbZGu5go6sh1LT91ciDLQqEg5CeqQ/wpH9rFpKEBAdJPNtJ?=
 =?us-ascii?Q?8DIyD1cpCaFb/J0WEya8VeKMYwpiqHfOv27DgXSKBPnvSrAz1//Yzme7kx3G?=
 =?us-ascii?Q?hqZ9aRsqIFFomloNZm2z9SHt0npu0hLyxFvQ7Lbb1YfiYz+a4br9uqk3jQQZ?=
 =?us-ascii?Q?lSJzd/QMEOjdJycDO2Sx/rB7WMq9AxnAVmygE8rSS8Ktt26a2PwHR0Ec8JrN?=
 =?us-ascii?Q?afWVOY9z5uxrUpneyJ981xMoV5Kpgj/Y51vvoqaakVm0t1MB+3MnoEhfzwu4?=
 =?us-ascii?Q?os2z8ByYT8AGj1pENy1M9w+RY/4nGZATiKDlJRHzHBh40UJ2U3xmTCfXxd9o?=
 =?us-ascii?Q?0YSIQotmyIAILJWaUHWzMBwG2b/bl589puoIKq4Cvo05HvCa0/XL8+VKtbh8?=
 =?us-ascii?Q?Ew57hDgaGfsDBPBL4BuPRKtf8Dm1r42GUY7P3UpiKx7ZM3Cy24ODBjQb0agt?=
 =?us-ascii?Q?3vkV+FIfT8YA8j5ok3YxdAlcZb3A5Rr2rzleEa2LR2/WS84IgCUHkiNoaS4r?=
 =?us-ascii?Q?xN6nZRgSDp3683XpBpXq9/T5iKcfJog5u2C4PZa26AEDTMMBEGzLQXg9ExtU?=
 =?us-ascii?Q?cEPUkVIEt4wI0RF2io/nj2g2FJj6xMu6Xx0NJp6J8+K9qb2cJkGjIAqkpJDg?=
 =?us-ascii?Q?QLIb2ImPlfwCGTdwBSKULmt0/CaPgQeidGGgRyMMGiSmYyiS3xVhzeL7nyDV?=
 =?us-ascii?Q?H1xOjogQxizQB9qE+BYqgvAFGi0CmmEb+/UavIwd?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7aafc8-6cfb-4577-b204-08dafc9b295a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2023 17:07:37.2942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fSD3B+sKD52gA7+z37eoJMCQVAtM/x+uvAwhxwRCAjRH+lBaDI4IGgbCed0g1KtdnIVXc54ix7+f3oq6DapNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB9322
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Till now /sys/kernel/debug/tracing/events is a part of tracefs,
with-in this patch creating 'events' and it's sub-dir as eventfs.
Basically replacing tracefs calls with eventfs calls for 'events'.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/inode.c           | 18 +++++++++++++
 include/linux/trace_events.h |  1 +
 kernel/trace/trace.h         |  2 +-
 kernel/trace/trace_events.c  | 64 +++++++++++++++++++++++---------------------
 4 files changed, 54 insertions(+), 31 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 8fdbd81..44b4344 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -374,6 +374,23 @@ static const struct super_operations tracefs_super_operations = {
 	.show_options	= tracefs_show_options,
 };
 
+static void tracefs_dentry_iput(struct dentry *dentry, struct inode *inode)
+{
+	struct tracefs_inode *ti;
+
+	if (!dentry || !inode)
+		return;
+
+	ti = get_tracefs(inode);
+	if (ti && ti->flags & TRACEFS_EVENT_INODE)
+		eventfs_set_ef_status_free(dentry);
+	iput(inode);
+}
+
+const struct dentry_operations tracefs_dentry_operations = {
+	.d_iput = tracefs_dentry_iput,
+};
+
 static int trace_fill_super(struct super_block *sb, void *data, int silent)
 {
 	static const struct tree_descr trace_files[] = {{""}};
@@ -396,6 +413,7 @@ static int trace_fill_super(struct super_block *sb, void *data, int silent)
 		goto fail;
 
 	sb->s_op = &tracefs_super_operations;
+	sb->s_d_op = &tracefs_dentry_operations;
 
 	tracefs_apply_options(sb, false);
 
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 4342e99..0a810ab 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -634,6 +634,7 @@ struct trace_event_file {
 	struct list_head		list;
 	struct trace_event_call		*event_call;
 	struct event_filter __rcu	*filter;
+	struct eventfs_file             *ef;
 	struct dentry			*dir;
 	struct trace_array		*tr;
 	struct trace_subsystem_dir	*system;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index e46a492..97d2e35 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1302,7 +1302,7 @@ struct trace_subsystem_dir {
 	struct list_head		list;
 	struct event_subsystem		*subsystem;
 	struct trace_array		*tr;
-	struct dentry			*entry;
+	struct eventfs_file             *ef;
 	int				ref_count;
 	int				nr_events;
 };
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 33e0b4f..b441f6a 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -973,7 +973,8 @@ static void remove_subsystem(struct trace_subsystem_dir *dir)
 		return;
 
 	if (!--dir->nr_events) {
-		tracefs_remove(dir->entry);
+		if (dir->ef)
+			eventfs_remove(dir->ef);
 		list_del(&dir->list);
 		__put_system_dir(dir);
 	}
@@ -994,7 +995,8 @@ static void remove_event_file_dir(struct trace_event_file *file)
 
 		tracefs_remove(dir);
 	}
-
+	if (file->ef)
+		eventfs_remove(file->ef);
 	list_del(&file->list);
 	remove_subsystem(file->system);
 	free_event_filter(file->filter);
@@ -2277,13 +2279,13 @@ create_new_subsystem(const char *name)
 	return NULL;
 }
 
-static struct dentry *
+static struct eventfs_file *
 event_subsystem_dir(struct trace_array *tr, const char *name,
 		    struct trace_event_file *file, struct dentry *parent)
 {
 	struct event_subsystem *system, *iter;
 	struct trace_subsystem_dir *dir;
-	struct dentry *entry;
+	int res;
 
 	/* First see if we did not already create this dir */
 	list_for_each_entry(dir, &tr->systems, list) {
@@ -2291,7 +2293,7 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 		if (strcmp(system->name, name) == 0) {
 			dir->nr_events++;
 			file->system = dir;
-			return dir->entry;
+			return dir->ef;
 		}
 	}
 
@@ -2315,8 +2317,8 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 	} else
 		__get_system(system);
 
-	dir->entry = tracefs_create_dir(name, parent);
-	if (!dir->entry) {
+	dir->ef = eventfs_add_subsystem_dir(name, parent);
+	if (IS_ERR(dir->ef)) {
 		pr_warn("Failed to create system directory %s\n", name);
 		__put_system(system);
 		goto out_free;
@@ -2331,22 +2333,22 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 	/* the ftrace system is special, do not create enable or filter files */
 	if (strcmp(name, "ftrace") != 0) {
 
-		entry = tracefs_create_file("filter", TRACE_MODE_WRITE,
-					    dir->entry, dir,
+		res = eventfs_add_file("filter", TRACE_MODE_WRITE,
+					    dir->ef, dir,
 					    &ftrace_subsystem_filter_fops);
-		if (!entry) {
+		if (res) {
 			kfree(system->filter);
 			system->filter = NULL;
 			pr_warn("Could not create tracefs '%s/filter' entry\n", name);
 		}
 
-		trace_create_file("enable", TRACE_MODE_WRITE, dir->entry, dir,
+		eventfs_add_file("enable", TRACE_MODE_WRITE, dir->ef, dir,
 				  &ftrace_system_enable_fops);
 	}
 
 	list_add(&dir->list, &tr->systems);
 
-	return dir->entry;
+	return dir->ef;
 
  out_free:
 	kfree(dir);
@@ -2399,6 +2401,7 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 {
 	struct trace_event_call *call = file->event_call;
 	struct trace_array *tr = file->tr;
+	struct eventfs_file *ef_subsystem = NULL;
 	struct dentry *d_events;
 	const char *name;
 	int ret;
@@ -2408,26 +2411,26 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 	 * then the system would be called "TRACE_SYSTEM".
 	 */
 	if (strcmp(call->class->system, TRACE_SYSTEM) != 0) {
-		d_events = event_subsystem_dir(tr, call->class->system, file, parent);
-		if (!d_events)
+		ef_subsystem = event_subsystem_dir(tr, call->class->system, file, parent);
+		if (!ef_subsystem)
 			return -ENOMEM;
 	} else
 		d_events = parent;
 
 	name = trace_event_name(call);
-	file->dir = tracefs_create_dir(name, d_events);
-	if (!file->dir) {
+	file->ef = eventfs_add_dir(name, ef_subsystem);
+	if (IS_ERR(file->ef)) {
 		pr_warn("Could not create tracefs '%s' directory\n", name);
 		return -1;
 	}
 
 	if (call->class->reg && !(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE))
-		trace_create_file("enable", TRACE_MODE_WRITE, file->dir, file,
+		eventfs_add_file("enable", TRACE_MODE_WRITE, file->ef, file,
 				  &ftrace_enable_fops);
 
 #ifdef CONFIG_PERF_EVENTS
 	if (call->event.type && call->class->reg)
-		trace_create_file("id", TRACE_MODE_READ, file->dir,
+		eventfs_add_file("id", TRACE_MODE_READ, file->ef,
 				  (void *)(long)call->event.type,
 				  &ftrace_event_id_fops);
 #endif
@@ -2443,27 +2446,27 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 	 * triggers or filters.
 	 */
 	if (!(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE)) {
-		trace_create_file("filter", TRACE_MODE_WRITE, file->dir,
+		eventfs_add_file("filter", TRACE_MODE_WRITE, file->ef,
 				  file, &ftrace_event_filter_fops);
 
-		trace_create_file("trigger", TRACE_MODE_WRITE, file->dir,
+		eventfs_add_file("trigger", TRACE_MODE_WRITE, file->ef,
 				  file, &event_trigger_fops);
 	}
 
 #ifdef CONFIG_HIST_TRIGGERS
-	trace_create_file("hist", TRACE_MODE_READ, file->dir, file,
+	eventfs_add_file("hist", TRACE_MODE_READ, file->ef, file,
 			  &event_hist_fops);
 #endif
 #ifdef CONFIG_HIST_TRIGGERS_DEBUG
-	trace_create_file("hist_debug", TRACE_MODE_READ, file->dir, file,
+	eventfs_add_file("hist_debug", TRACE_MODE_READ, file->ef, file,
 			  &event_hist_debug_fops);
 #endif
-	trace_create_file("format", TRACE_MODE_READ, file->dir, call,
+	eventfs_add_file("format", TRACE_MODE_READ, file->ef, call,
 			  &ftrace_event_format_fops);
 
 #ifdef CONFIG_TRACE_EVENT_INJECT
 	if (call->event.type && call->class->reg)
-		trace_create_file("inject", 0200, file->dir, file,
+		eventfs_add_file("inject", 0200, file->ef, file,
 				  &event_inject_fops);
 #endif
 
@@ -3616,21 +3619,22 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 {
 	struct dentry *d_events;
 	struct dentry *entry;
+	int error = 0;
 
 	entry = trace_create_file("set_event", TRACE_MODE_WRITE, parent,
 				  tr, &ftrace_set_event_fops);
 	if (!entry)
 		return -ENOMEM;
 
-	d_events = tracefs_create_dir("events", parent);
-	if (!d_events) {
+	d_events = eventfs_create_events_dir("events", parent);
+	if (IS_ERR(d_events)) {
 		pr_warn("Could not create tracefs 'events' directory\n");
 		return -ENOMEM;
 	}
 
-	entry = trace_create_file("enable", TRACE_MODE_WRITE, d_events,
+	error = eventfs_add_top_file("enable", TRACE_MODE_WRITE, d_events,
 				  tr, &ftrace_tr_enable_fops);
-	if (!entry)
+	if (error)
 		return -ENOMEM;
 
 	/* There are not as crucial, just warn if they are not created */
@@ -3643,11 +3647,11 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 			  &ftrace_set_event_notrace_pid_fops);
 
 	/* ring buffer internal formats */
-	trace_create_file("header_page", TRACE_MODE_READ, d_events,
+	eventfs_add_top_file("header_page", TRACE_MODE_READ, d_events,
 				  ring_buffer_print_page_header,
 				  &ftrace_show_header_fops);
 
-	trace_create_file("header_event", TRACE_MODE_READ, d_events,
+	eventfs_add_top_file("header_event", TRACE_MODE_READ, d_events,
 				  ring_buffer_print_entry_header,
 				  &ftrace_show_header_fops);
 
-- 
2.7.4

