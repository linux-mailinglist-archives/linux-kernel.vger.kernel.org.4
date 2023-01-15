Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C72666B05F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 11:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjAOKcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 05:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjAOKcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 05:32:24 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2097.outbound.protection.outlook.com [40.92.98.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98580CDC2;
        Sun, 15 Jan 2023 02:32:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZ8HtHvdENvKMc5J2uIOfj4Kp6Y9foBxjCSsnlC+z5YkiZM474EfhC4ynpDqOfwt6LoxEtaMfgVN4foiwMLkR8ABS9xuZK2mIkEIpvhHIJl3N94/E66CHB6rp/ykaI4DFcbrYopML/eBt8bEAezOXg9fmviGBI4j5BHcjKYaC0EH8F/VH+cXtIMDHGuOGUtHbBxfqE1+iZfYMFrEdJm2nUTRyj1+YDd7yyDs3sJjEAeh64AzFtR1qglUpve4Fgp7k5A+ibRUjrAiktLnvxgV5LMF0eHXKwkkexksaJ2yUjUYtIOch3GCScFtJFW2HFS3G6gzqhv9vOUXblcaTFrZUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLVW6cpIN92RszWQGZf+N4nrJfbYAPQMEODlCfdC350=;
 b=LjxVsH0SpBJqfAMMHL59vCXKJk3432EvrjPZXM6v80cIVJj5BnqySzsDsuDeN98CtyI+a0DgK82z1xZx741FMU2C0MfAmLly5cGWv7bF51LtCPb75yc9JLgkTpwiqnJWVfMhwhqXvWCW4LneXWY01GUwwj0+XteXSTmpyJZSLFs6PFEwsZ4IsNWU5GpjaudyZklUBzlg9tS7xewXbRz6Yta0TkDiOnHCVCuK7MLT9Ru8qR8vKLpqGHw/4iWsJ8pOgDJRBBRvqPvYPm/2qA+9OfQLsu9AhBxSQ/ReGzJOeYrRrPuTNKz4zxlRzQ8BVvfyP/AUWJCWCOIyZfbZNGtf7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLVW6cpIN92RszWQGZf+N4nrJfbYAPQMEODlCfdC350=;
 b=XB6O5oayfLt/aCyhfvENUfXRRs5UXjrQhNIOoPIl2Ve771LGme7axgopdlHe+b7GcidylXFFuiHNgIuk+KyUaqLwx23U66ef4pJSttngh6J03L9kVgpf8DMWVF6vS3g123ugZn4cY9/hEa3LQLa1fgri7fIAUtc20KLwMX+pd0ZJGvvwUzckegoSHB7hRBghycr00mAMy5jsryus/WQXaiGOKT+mut+i5LWzS8k7NH4ZbiyltGhKk237CKW2JKEpSNS86sYwFMbqjcq7jvOmeGYBV1URn8kRPrFFbFWqK3GEOh1FOmdIzjOzrn92AxQuhnzcxLBRqqzcbdJG/nielQ==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by OS3P286MB2025.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Sun, 15 Jan
 2023 10:32:21 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605%4]) with mapi id 15.20.6002.012; Sun, 15 Jan 2023
 10:32:21 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     linkinjeon@kernel.org, sfrench@samba.org
Cc:     senozhatsky@chromium.org, tom@talpey.com, hyc.lee@gmail.com,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] ksmbd: replace rwlock with rcu for concurrenct access on conn list
Date:   Sun, 15 Jan 2023 18:32:06 +0800
Message-ID: <TYCP286MB23235FDD8102162698EF3154CAC09@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230115103209.146002-1-set_pte_at@outlook.com>
References: <20230115103209.146002-1-set_pte_at@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Ra10at4WNJIhZRyiO61Rfjy0xkteVbPIxa/XrE9qXao=]
X-ClientProxiedBy: TYAPR01CA0210.jpnprd01.prod.outlook.com
 (2603:1096:404:29::30) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20230115103209.146002-4-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|OS3P286MB2025:EE_
X-MS-Office365-Filtering-Correlation-Id: b32847a3-374f-40b3-3b1c-08daf6e3c8bc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mth2RSi214nePp7p+aChpl0eZQuO7BbteM2cExknauR0Ff27xfg8RHoRF3rc9Wza1H7Cerp1DK71TKlWOowM9vm4KX7kTDvlpzxJaFJd8wtk6ZBKk28M4397dNs2SVJPidGWnpD4QR9sjmO3SchxlX/OWFtejsNqjW0vo5uGVZrsARSbYr+sNCkHe1q2wQpO/VA4870587HNs03agII+ku/WVUv38XsoyrGclsOL+FkQ6C8Yv2GvHzZNHTRrlq53IIEIb4Y6aZj2l+NPIEfzoqY2jUDMgShGZRJCtEIJWNOVQKIK6Keji+FD4olZfyQocz56g6UhBO+e6o0Q3pQLvS7FDvStdFp979WK7h76oJMQ4cd45Yt60QTyN5GkBXWHGomtqUh39E/JNrF4Pcocq2JnGuznk85Vunu6s58Ce16+0soIomdd/42RX58ioLXX49NrcfPP2ogUEccTQZNPEcjstyUa61ehKErcV9zi2dO042NH9KM57PI1v0WcmsAKV+gA1a2Azl4zcUH8sMcd0SizhTw9irl1Lo5iQBDWHMZZqwxefOahLgfMaHiG4ehcWMRSS9eZYGs86OAg/8pSCdnN42j45/WojbX1UAJYLhk=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SIY1ldUY1Fpn35roPD/jBPhD9BjxbpTGS8nSLe2pEbNRCU3K3wq6C0k2/D0k?=
 =?us-ascii?Q?VFs2kJadCoT5cU4tR2LovnwMa4PjFMiODYArfNcQr6xyJ7kFVZwm0RxYCqvF?=
 =?us-ascii?Q?SCY5foqjL92ZcIilBOk9RcXggB7szJu8HZw0HN+QMi6x3aFUvelA4+tSaPZU?=
 =?us-ascii?Q?ty/axLFv7FVbxT5H95xh1jefsBHKAERsUPEnFLCOBjgL9tN8j+4GAIUDJ9td?=
 =?us-ascii?Q?M3geHJGgxs6WagPCkq06bM6kAv6cDGvXPWQGmM+4FbZDikCOqwdd4SBwPhoD?=
 =?us-ascii?Q?6pnRyFBh+Ta0E3j3xt0H++63t18n+qE/gVD5LC7DquNjGDP11GuvhJmm+gm0?=
 =?us-ascii?Q?bhvXnBFzM31RTgl3/DsR8GCNBjQ6HLO+CL/wwlUHnd6v22dZiN9sxTFpNbKJ?=
 =?us-ascii?Q?xq5Lep31GBUVlvmzapHc5FivW+3XKQGO6W4J4YirSi45uge3EOmh9wOjqpMA?=
 =?us-ascii?Q?10tH8ABXenol0oEWtvgRH/iSkEqb0PFHle8CmK0FjYlyJlUrsGqTQ+i0USBl?=
 =?us-ascii?Q?S1higiY/UUDdJPaQcZBp5bcSfu2Sn8SXadjuF0Rn1nmq8IOfKlC0k3+E3hjd?=
 =?us-ascii?Q?IzaJgSBChqzPp3+W/ZIpXma8tjAjrieXT4tuwh3VCs45UB7+i455X6fFgVdq?=
 =?us-ascii?Q?zTehzTxAh3zx48ryyrK0nwW+31THh5rceFKssqQ5Ukyndn5AeK6czLI6CmUk?=
 =?us-ascii?Q?dtghu8iY1Ek3vKT/56FNyC91d9NSJXWIlClBOds54s3LAk1+RtBbdskj6TWK?=
 =?us-ascii?Q?uBJBmEmarrYRme5y0ZBoN9/FJ0u2ke7yVeO8TQQaNo5DsjetsI5yYW5iUnr0?=
 =?us-ascii?Q?dVKs7YA6tgnYwBmk4jt+yCT2El85dbgftkh5EFDjKgU68/3XObfZ+q6ju/lr?=
 =?us-ascii?Q?HC/wd1AzwM6hx/OJog/Dzxre678B8ojphupyM8M+8n4N/sv7VPihydGRvMRj?=
 =?us-ascii?Q?iKT8F7x5kQW591B0YiUViN+ZUlODJKZp3r+zql8XYcPQmwGk45A87RUyI7Lp?=
 =?us-ascii?Q?ndTBav31jEbvsyRwZ8t/dMOOwCS8v1XIdhRZ5X5lm8LSaNmhuXmxrXwQsA4T?=
 =?us-ascii?Q?yDuyGxpx3aVlkPPUm7ISKlC9+57LUQfccG/peMbEnsjy/LdKofFmWoYhfwRo?=
 =?us-ascii?Q?44WipRd0wCl/v9CsBOg+fJAIOxUMC2JvLAKx0wsgkLNqndZ9aiz8fFz6epE2?=
 =?us-ascii?Q?JqKRmC9SclVK0ZQag1qiapVDb857y9U+GXSR7nPi3ufJxGF4copogKoIsSSF?=
 =?us-ascii?Q?AjEHLtOPcVAX1+ErcnKt1V2qsgnMXRB4BKU48gn7tkpTsVlk1zEmFZiFlbYT?=
 =?us-ascii?Q?PT4=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b32847a3-374f-40b3-3b1c-08daf6e3c8bc
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 10:32:21.4490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2025
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, racing protection on conn list is implemented as rwlock,
improve it by rcu primitive for its better performance.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 fs/ksmbd/connection.c | 30 +++++++++++++++---------------
 fs/ksmbd/connection.h |  1 -
 fs/ksmbd/smb2pdu.c    | 14 +++++++-------
 3 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index fd0a288af299..36d1da273edd 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -20,7 +20,7 @@ static DEFINE_MUTEX(init_lock);
 static struct ksmbd_conn_ops default_conn_ops;
 
 LIST_HEAD(conn_list);
-DEFINE_RWLOCK(conn_list_lock);
+DEFINE_SPINLOCK(conn_list_lock);
 
 /**
  * ksmbd_conn_free() - free resources of the connection instance
@@ -32,9 +32,9 @@ DEFINE_RWLOCK(conn_list_lock);
  */
 void ksmbd_conn_free(struct ksmbd_conn *conn)
 {
-	write_lock(&conn_list_lock);
-	list_del(&conn->conns_list);
-	write_unlock(&conn_list_lock);
+	spin_lock(&conn_list_lock);
+	list_del_rcu(&conn->conns_list);
+	spin_unlock(&conn_list_lock);
 
 	xa_destroy(&conn->sessions);
 	kvfree(conn->request_buf);
@@ -84,9 +84,9 @@ struct ksmbd_conn *ksmbd_conn_alloc(void)
 	spin_lock_init(&conn->llist_lock);
 	INIT_LIST_HEAD(&conn->lock_list);
 
-	write_lock(&conn_list_lock);
-	list_add(&conn->conns_list, &conn_list);
-	write_unlock(&conn_list_lock);
+	spin_lock(&conn_list_lock);
+	list_add_rcu(&conn->conns_list, &conn_list);
+	spin_unlock(&conn_list_lock);
 	return conn;
 }
 
@@ -95,15 +95,15 @@ bool ksmbd_conn_lookup_dialect(struct ksmbd_conn *c)
 	struct ksmbd_conn *t;
 	bool ret = false;
 
-	read_lock(&conn_list_lock);
-	list_for_each_entry(t, &conn_list, conns_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(t, &conn_list, conns_list) {
 		if (memcmp(t->ClientGUID, c->ClientGUID, SMB2_CLIENT_GUID_SIZE))
 			continue;
 
 		ret = true;
 		break;
 	}
-	read_unlock(&conn_list_lock);
+	rcu_read_unlock();
 	return ret;
 }
 
@@ -402,8 +402,8 @@ static void stop_sessions(void)
 	struct ksmbd_transport *t;
 
 again:
-	read_lock(&conn_list_lock);
-	list_for_each_entry(conn, &conn_list, conns_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(conn, &conn_list, conns_list) {
 		struct task_struct *task;
 
 		t = conn->transport;
@@ -413,12 +413,12 @@ static void stop_sessions(void)
 				    task->comm, task_pid_nr(task));
 		conn->status = KSMBD_SESS_EXITING;
 		if (t->ops->shutdown) {
-			read_unlock(&conn_list_lock);
+			rcu_read_unlock();
 			t->ops->shutdown(t);
-			read_lock(&conn_list_lock);
+			rcu_read_lock();
 		}
 	}
-	read_unlock(&conn_list_lock);
+	rcu_read_unlock();
 
 	if (!list_empty(&conn_list)) {
 		schedule_timeout_interruptible(HZ / 10); /* 100ms */
diff --git a/fs/ksmbd/connection.h b/fs/ksmbd/connection.h
index 3643354a3fa7..e41f33a2da7c 100644
--- a/fs/ksmbd/connection.h
+++ b/fs/ksmbd/connection.h
@@ -139,7 +139,6 @@ struct ksmbd_transport {
 #define KSMBD_TCP_PEER_SOCKADDR(c)	((struct sockaddr *)&((c)->peer_addr))
 
 extern struct list_head conn_list;
-extern rwlock_t conn_list_lock;
 
 bool ksmbd_conn_alive(struct ksmbd_conn *conn);
 void ksmbd_conn_wait_idle(struct ksmbd_conn *conn);
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 771e045c8d4a..c60cfb360f42 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6915,8 +6915,8 @@ int smb2_lock(struct ksmbd_work *work)
 
 		nolock = 1;
 		/* check locks in connection list */
-		read_lock(&conn_list_lock);
-		list_for_each_entry(conn, &conn_list, conns_list) {
+		rcu_read_lock();
+		list_for_each_entry_rcu(conn, &conn_list, conns_list) {
 			spin_lock(&conn->llist_lock);
 			list_for_each_entry_safe(cmp_lock, tmp2, &conn->lock_list, clist) {
 				if (file_inode(cmp_lock->fl->fl_file) !=
@@ -6932,7 +6932,7 @@ int smb2_lock(struct ksmbd_work *work)
 						list_del(&cmp_lock->flist);
 						list_del(&cmp_lock->clist);
 						spin_unlock(&conn->llist_lock);
-						read_unlock(&conn_list_lock);
+						rcu_read_unlock();
 
 						locks_free_lock(cmp_lock->fl);
 						kfree(cmp_lock);
@@ -6954,7 +6954,7 @@ int smb2_lock(struct ksmbd_work *work)
 				    cmp_lock->start > smb_lock->start &&
 				    cmp_lock->start < smb_lock->end) {
 					spin_unlock(&conn->llist_lock);
-					read_unlock(&conn_list_lock);
+					rcu_read_unlock();
 					pr_err("previous lock conflict with zero byte lock range\n");
 					goto out;
 				}
@@ -6963,7 +6963,7 @@ int smb2_lock(struct ksmbd_work *work)
 				    smb_lock->start > cmp_lock->start &&
 				    smb_lock->start < cmp_lock->end) {
 					spin_unlock(&conn->llist_lock);
-					read_unlock(&conn_list_lock);
+					rcu_read_unlock();
 					pr_err("current lock conflict with zero byte lock range\n");
 					goto out;
 				}
@@ -6974,14 +6974,14 @@ int smb2_lock(struct ksmbd_work *work)
 				      cmp_lock->end >= smb_lock->end)) &&
 				    !cmp_lock->zero_len && !smb_lock->zero_len) {
 					spin_unlock(&conn->llist_lock);
-					read_unlock(&conn_list_lock);
+					rcu_read_unlock();
 					pr_err("Not allow lock operation on exclusive lock range\n");
 					goto out;
 				}
 			}
 			spin_unlock(&conn->llist_lock);
 		}
-		read_unlock(&conn_list_lock);
+		rcu_read_unlock();
 out_check_cl:
 		if (smb_lock->fl->fl_type == F_UNLCK && nolock) {
 			pr_err("Try to unlock nolocked range\n");
-- 
2.25.1

