Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995B266B05A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 11:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjAOKc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 05:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjAOKcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 05:32:22 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2097.outbound.protection.outlook.com [40.92.98.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0B2CDC2;
        Sun, 15 Jan 2023 02:32:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNymLNCiGEc8vHZHt+pLzXCPIQkAj2tjvupXd5vVv2N5fhoID6wtqMLilB1bm8GmZwkjz3oBnG20N+cRYeVPpzLu2P/Ar/c8qnhh2+/O/ExjgFAbNKqczdzpFD52En32wJHdKM31Ri5uNHUjvIwKZXK1TzPCVqkMpZw7iGDQ/uQEkxOgLEnhtFjQn6L2n/NNaCg37sV4KJM3GVu9QXcdxk0gzUv/AOeCdIYfWXzXVcmW79pW5YW6eBdpP8D6NITt4bV+TXpiyAL70laGPLEClsWMDJMiHvbyEoxsVIhIZN3jHTM9jBQbwfc42XwX27Dy88/jgrzr5sJQC2KWUhQpTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bCwXQROHXsw8VYvL5v6AwzG2CGy/x/ZiC0wL0JZbLU=;
 b=bIUEILg4heRl67xANwrWIicmUJ927vm4afg5QfFMLC3pA2Y0uYlTtsR8h+89UpMQ26rxiWKukpSAImqzLHnS/tTqZjxuvtdL7mf/SuJLvmGfva3+HCBnewTfrCPcO7buPXu7hWC7bXBuxW+hckw3nzvQbUXoak779MwRMEIPl+YBebkzseZT1DTQOtDGxKbhN6aqHcqQuGegujtDBn6BeAD/gbzkDgqP0vXzqB3b9ma566tJ8ThuboftCltUGK9GjfzvszIDvvYJcsU+YTKZ8egNImY3vZ2U+fvKY6yOSLMPPiIbmr/uCzB4ahGzipNIWA69H2nzGhUHGUEa1eRA4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bCwXQROHXsw8VYvL5v6AwzG2CGy/x/ZiC0wL0JZbLU=;
 b=HtOv+DBJNy4CIGhSM+5lsPTpGdUjCDBCjwqgTln8SWDes+BGLe3YhJZ9glpOCY+EnpB7gMDGeJ4AMq8UWi5Z6Gy1+t4U3Y3NkSjurZuFIKuwpU/XSiT9pnxoM2c8BDIFwsQzi/wANKc0TUHrwtCopD6BT7RW0AyecJNnCXoqtNH1Jomt2zkEpdx67ETvnGuN0OnkRiCDzqHooWKKVskMB0EMUll28Cy3g85xJ9dOyh1SeDHM82bqzrq3oKAZMUUBvnp3NwZ+ums5OSTIDUgWu/SNcvPJto5ENfU342EbIlng0liOKmyTBw51D7mQqK8EhfGzGv69hKQXNMg/0UdAuQ==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by OS3P286MB2025.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Sun, 15 Jan
 2023 10:32:18 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605%4]) with mapi id 15.20.6002.012; Sun, 15 Jan 2023
 10:32:18 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     linkinjeon@kernel.org, sfrench@samba.org
Cc:     senozhatsky@chromium.org, tom@talpey.com, hyc.lee@gmail.com,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] ksmbd: Implements sess->ksmbd_chann_list as xarray
Date:   Sun, 15 Jan 2023 18:32:04 +0800
Message-ID: <TYCP286MB2323634A443AA87EE5768018CAC09@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230115103209.146002-1-set_pte_at@outlook.com>
References: <20230115103209.146002-1-set_pte_at@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [d7LqBg5C+xsn7ZcKt51vzaRYyK0so46QxmVWZm5BlJ0=]
X-ClientProxiedBy: TYAPR01CA0210.jpnprd01.prod.outlook.com
 (2603:1096:404:29::30) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20230115103209.146002-2-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|OS3P286MB2025:EE_
X-MS-Office365-Filtering-Correlation-Id: 08094b11-7137-4ed4-7dab-08daf6e3c712
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3yWdVFZ8laLo6bCijX4InFwEZli2FLOkju5xJUVfzi0rx1SRZHNnF96yM0n+tKM6qLh+iJZaB/WGMmNDZ7azSnm2+zvIKoZ4w134448rH7TKw5oz+BqkhNTc7aUkKSlLBYVov286UjkypviARlTYrvGvZurflOt5abshtpYNyvQRu1AJ2YjkWmRaUcOBoDsmUrJC7nZ7fMiiflX7VjkLdHIIGImx/s7twZ2rv4oMsv2yVOwBGUftGL7LGEl7mf+2dT/JZRcNB6MhdgnUYwkrudB19IB3s0vksNob9DvHGaHq+4M00Dq/gJQneO8hejWA2gl3HniINkN3P+LKEehV4HvgiHHHYUOcnvoSmBhGtxxvJniWjrxKDV+ZMZxggkXc254iyxzfOQ85wB9IWNHIJB65TKWUtgkxHyyrmNAj+897d0omVUzMKjNW1mEflG+rkQ6Ir8GJ6OgVgcpB9VDUUTlLu3dbWvIe2luLKrIKpcUaufJM2r4iuBJxwl4bYjXmtW09CnpqNHCGaZJkOLSEOQiVj/Tiu88QTPd9h4YwUZJIJlN7xO+zoMzJc+diaQcI+8p/QJBnPkKWrDk5wSNdU7OzR8Rd0UQKYEkUUJs7pz0=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qVRSJOnFHo+Ar4/bIZFRinpn/6itWDsFyWDkzoRHyeQWTuf4CBeFhBSb/ygo?=
 =?us-ascii?Q?EJFuTBvVj0AbRU+cpRKaRJyizJh1d1zYgqmr4tbR0qZoRZkGfoyZGTevmgCe?=
 =?us-ascii?Q?Sm7ovX4Zwf0wWr5Dg0HI9BuGuKVhFkX8bc24ijTg9FdFkuEn3kHfv4PYnkpt?=
 =?us-ascii?Q?2ACJKIrVJ3wALPfFwRjqm6gGNAAufp3PAkIdlSB/hytidEsJpzXDdTfVc6E/?=
 =?us-ascii?Q?2rrx7nwwm/8T+jzJjrBSpvA+GSDW1ln3wsm4g8S0sojtyc2KCko8I6wDCFwQ?=
 =?us-ascii?Q?EAsejo1+6CAHCg6tkBuhlugtnUNIXGgQCNEiwdADraSaXTmaX4w1OfrLCIus?=
 =?us-ascii?Q?mrhVKLMrVzQOKb2brs82JoUH6EJ9HAJc9+qcDuRI2px23GM2D4f1HIt9PUFK?=
 =?us-ascii?Q?rwX3jaHXRm8BodR0kzi1FPJ4qJjlnASUWMfgHAQuX+EQlo9Q6LVf+kahNU3V?=
 =?us-ascii?Q?W7Pq3ait2A6+dZRPcXjxZ1GhooJwVMziJf3fS5MaTXDt1hIIHIMPx4xwqoQL?=
 =?us-ascii?Q?eTRYF6vVgri9qbbKf0E3AwI3sJ+gupPl7e9Vx2VQmDBLb+LGW9xlcKadt1dk?=
 =?us-ascii?Q?eLQM5i+oH6lsnIxZ6nm6fsQ2RvZAwtq/wzDfGEpnA8chL9d3CzvB35MDvnCp?=
 =?us-ascii?Q?SBL28kUMyvzFhdXjocxQQxMfLTQcWRduiQ5x66SIt1pErJgOqzxlA3gB+hqH?=
 =?us-ascii?Q?ozyu85zfIbkJ6EyCeG44NvryTWLUZXV0DmkBpKW1QODL0nT866FoNA8RbB7Z?=
 =?us-ascii?Q?W+nIJiq9cvqSWj1xYQn6XbAGQssXYK+QqxVGhaB/sY3/+aGTxQbm/lilfbUd?=
 =?us-ascii?Q?D8/+jWScrj8zbt/clh7mHgojhEd7tvfvCPuTFTRWVcGpds0qJUWKOZpl/+Ya?=
 =?us-ascii?Q?rzlxrralN+SJVRw5jJeA6Fb4h/vznT40B3k9SQVafMpi/uK99eD2AKu8qQ0V?=
 =?us-ascii?Q?tlRPFFFNWgY7VT+ugV2NN4ZUzazRVD7iJyYE2N1ulJQ5BsEd1jjqZ/1VLYjj?=
 =?us-ascii?Q?gIMKzy3e+iHamJ+WaX9j8kFu3J4EOJ2UzEny+nigWBIsaWISI6vHE/TV6n4/?=
 =?us-ascii?Q?broSYX/0IQpGesbVKD6pqWOUm4feIyYHHHH+KgwppGc/12wbNLCzICMQZdu8?=
 =?us-ascii?Q?wi55midd5rJe0sZhvXjUFAJRCk6TVL7JmwvZfu7DBxUB1LEVae+BoPcEpg5Y?=
 =?us-ascii?Q?vJ33p2KVFqqKFmtZDeL6lEn7dUPs/WYz5dBd94Sb0xl7PWUV3MK7d2Ti/OhN?=
 =?us-ascii?Q?Kfo3gykEODHMVDCYeafeLHUiQ4frOIpR9OjidkV+Rrtkr1CehEjnH+ucumq0?=
 =?us-ascii?Q?KTY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08094b11-7137-4ed4-7dab-08daf6e3c712
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 10:32:18.7514
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

For some ops on channel:
1. lookup_chann_list(), possibly on high frequency.
2. ksmbd_chann_del().

Connection is used as indexing key to lookup channel, in that case,
linear search based on list may suffer a bit for performance.

Implements sess->ksmbd_chann_list as xarray.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 fs/ksmbd/mgmt/user_session.c | 61 ++++++++++++++----------------------
 fs/ksmbd/mgmt/user_session.h |  4 +--
 fs/ksmbd/smb2pdu.c           | 34 +++-----------------
 3 files changed, 30 insertions(+), 69 deletions(-)

diff --git a/fs/ksmbd/mgmt/user_session.c b/fs/ksmbd/mgmt/user_session.c
index 92b1603b5abe..a2b128dedcfc 100644
--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -30,15 +30,15 @@ struct ksmbd_session_rpc {
 
 static void free_channel_list(struct ksmbd_session *sess)
 {
-	struct channel *chann, *tmp;
+	struct channel *chann;
+	unsigned long index;
 
-	write_lock(&sess->chann_lock);
-	list_for_each_entry_safe(chann, tmp, &sess->ksmbd_chann_list,
-				 chann_list) {
-		list_del(&chann->chann_list);
+	xa_for_each(&sess->ksmbd_chann_list, index, chann) {
+		xa_erase(&sess->ksmbd_chann_list, index);
 		kfree(chann);
 	}
-	write_unlock(&sess->chann_lock);
+
+	xa_destroy(&sess->ksmbd_chann_list);
 }
 
 static void __session_rpc_close(struct ksmbd_session *sess,
@@ -190,21 +190,15 @@ int ksmbd_session_register(struct ksmbd_conn *conn,
 
 static int ksmbd_chann_del(struct ksmbd_conn *conn, struct ksmbd_session *sess)
 {
-	struct channel *chann, *tmp;
-
-	write_lock(&sess->chann_lock);
-	list_for_each_entry_safe(chann, tmp, &sess->ksmbd_chann_list,
-				 chann_list) {
-		if (chann->conn == conn) {
-			list_del(&chann->chann_list);
-			kfree(chann);
-			write_unlock(&sess->chann_lock);
-			return 0;
-		}
-	}
-	write_unlock(&sess->chann_lock);
+	struct channel *chann;
+
+	chann = xa_erase(&sess->ksmbd_chann_list, (long)conn);
+	if (!chann)
+		return -ENOENT;
 
-	return -ENOENT;
+	kfree(chann);
+
+	return 0;
 }
 
 void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
@@ -234,7 +228,7 @@ void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
 	return;
 
 sess_destroy:
-	if (list_empty(&sess->ksmbd_chann_list)) {
+	if (xa_empty(&sess->ksmbd_chann_list)) {
 		xa_erase(&conn->sessions, sess->id);
 		ksmbd_session_destroy(sess);
 	}
@@ -320,6 +314,9 @@ static struct ksmbd_session *__session_create(int protocol)
 	struct ksmbd_session *sess;
 	int ret;
 
+	if (protocol != CIFDS_SESSION_FLAG_SMB2)
+		return NULL;
+
 	sess = kzalloc(sizeof(struct ksmbd_session), GFP_KERNEL);
 	if (!sess)
 		return NULL;
@@ -329,30 +326,20 @@ static struct ksmbd_session *__session_create(int protocol)
 
 	set_session_flag(sess, protocol);
 	xa_init(&sess->tree_conns);
-	INIT_LIST_HEAD(&sess->ksmbd_chann_list);
+	xa_init(&sess->ksmbd_chann_list);
 	INIT_LIST_HEAD(&sess->rpc_handle_list);
 	sess->sequence_number = 1;
-	rwlock_init(&sess->chann_lock);
-
-	switch (protocol) {
-	case CIFDS_SESSION_FLAG_SMB2:
-		ret = __init_smb2_session(sess);
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
 
+	ret = __init_smb2_session(sess);
 	if (ret)
 		goto error;
 
 	ida_init(&sess->tree_conn_ida);
 
-	if (protocol == CIFDS_SESSION_FLAG_SMB2) {
-		down_write(&sessions_table_lock);
-		hash_add(sessions_table, &sess->hlist, sess->id);
-		up_write(&sessions_table_lock);
-	}
+	down_write(&sessions_table_lock);
+	hash_add(sessions_table, &sess->hlist, sess->id);
+	up_write(&sessions_table_lock);
+
 	return sess;
 
 error:
diff --git a/fs/ksmbd/mgmt/user_session.h b/fs/ksmbd/mgmt/user_session.h
index 8934b8ee275b..44a3c67b2bd9 100644
--- a/fs/ksmbd/mgmt/user_session.h
+++ b/fs/ksmbd/mgmt/user_session.h
@@ -21,7 +21,6 @@ struct ksmbd_file_table;
 struct channel {
 	__u8			smb3signingkey[SMB3_SIGN_KEY_SIZE];
 	struct ksmbd_conn	*conn;
-	struct list_head	chann_list;
 };
 
 struct preauth_session {
@@ -50,8 +49,7 @@ struct ksmbd_session {
 	char				sess_key[CIFS_KEY_SIZE];
 
 	struct hlist_node		hlist;
-	rwlock_t			chann_lock;
-	struct list_head		ksmbd_chann_list;
+	struct xarray			ksmbd_chann_list;
 	struct xarray			tree_conns;
 	struct ida			tree_conn_ida;
 	struct list_head		rpc_handle_list;
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 38fbda52e06f..771e045c8d4a 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -74,14 +74,7 @@ static inline bool check_session_id(struct ksmbd_conn *conn, u64 id)
 
 struct channel *lookup_chann_list(struct ksmbd_session *sess, struct ksmbd_conn *conn)
 {
-	struct channel *chann;
-
-	list_for_each_entry(chann, &sess->ksmbd_chann_list, chann_list) {
-		if (chann->conn == conn)
-			return chann;
-	}
-
-	return NULL;
+	return xa_load(&sess->ksmbd_chann_list, (long)conn);
 }
 
 /**
@@ -595,6 +588,7 @@ static void destroy_previous_session(struct ksmbd_conn *conn,
 	struct ksmbd_session *prev_sess = ksmbd_session_lookup_slowpath(id);
 	struct ksmbd_user *prev_user;
 	struct channel *chann;
+	long index;
 
 	if (!prev_sess)
 		return;
@@ -608,10 +602,8 @@ static void destroy_previous_session(struct ksmbd_conn *conn,
 		return;
 
 	prev_sess->state = SMB2_SESSION_EXPIRED;
-	write_lock(&prev_sess->chann_lock);
-	list_for_each_entry(chann, &prev_sess->ksmbd_chann_list, chann_list)
+	xa_for_each(&prev_sess->ksmbd_chann_list, index, chann)
 		chann->conn->status = KSMBD_SESS_EXITING;
-	write_unlock(&prev_sess->chann_lock);
 }
 
 /**
@@ -1519,19 +1511,14 @@ static int ntlm_authenticate(struct ksmbd_work *work)
 
 binding_session:
 	if (conn->dialect >= SMB30_PROT_ID) {
-		read_lock(&sess->chann_lock);
 		chann = lookup_chann_list(sess, conn);
-		read_unlock(&sess->chann_lock);
 		if (!chann) {
 			chann = kmalloc(sizeof(struct channel), GFP_KERNEL);
 			if (!chann)
 				return -ENOMEM;
 
 			chann->conn = conn;
-			INIT_LIST_HEAD(&chann->chann_list);
-			write_lock(&sess->chann_lock);
-			list_add(&chann->chann_list, &sess->ksmbd_chann_list);
-			write_unlock(&sess->chann_lock);
+			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, GFP_KERNEL);
 		}
 	}
 
@@ -1606,19 +1593,14 @@ static int krb5_authenticate(struct ksmbd_work *work)
 	}
 
 	if (conn->dialect >= SMB30_PROT_ID) {
-		read_lock(&sess->chann_lock);
 		chann = lookup_chann_list(sess, conn);
-		read_unlock(&sess->chann_lock);
 		if (!chann) {
 			chann = kmalloc(sizeof(struct channel), GFP_KERNEL);
 			if (!chann)
 				return -ENOMEM;
 
 			chann->conn = conn;
-			INIT_LIST_HEAD(&chann->chann_list);
-			write_lock(&sess->chann_lock);
-			list_add(&chann->chann_list, &sess->ksmbd_chann_list);
-			write_unlock(&sess->chann_lock);
+			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, GFP_KERNEL);
 		}
 	}
 
@@ -8409,14 +8391,11 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 	if (le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
 		signing_key = work->sess->smb3signingkey;
 	} else {
-		read_lock(&work->sess->chann_lock);
 		chann = lookup_chann_list(work->sess, conn);
 		if (!chann) {
-			read_unlock(&work->sess->chann_lock);
 			return 0;
 		}
 		signing_key = chann->smb3signingkey;
-		read_unlock(&work->sess->chann_lock);
 	}
 
 	if (!signing_key) {
@@ -8476,14 +8455,11 @@ void smb3_set_sign_rsp(struct ksmbd_work *work)
 	    le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
 		signing_key = work->sess->smb3signingkey;
 	} else {
-		read_lock(&work->sess->chann_lock);
 		chann = lookup_chann_list(work->sess, work->conn);
 		if (!chann) {
-			read_unlock(&work->sess->chann_lock);
 			return;
 		}
 		signing_key = chann->smb3signingkey;
-		read_unlock(&work->sess->chann_lock);
 	}
 
 	if (!signing_key)
-- 
2.25.1

