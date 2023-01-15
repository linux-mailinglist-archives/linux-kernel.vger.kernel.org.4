Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B386A66B05B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 11:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjAOKcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 05:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjAOKcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 05:32:23 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2097.outbound.protection.outlook.com [40.92.98.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A496BC16B;
        Sun, 15 Jan 2023 02:32:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUtS0bepUHxrIe1SpVHrepYAa7FqTmblJvfkgtKN5NOHF4ibbakk0hcnar+jY8hm+EmjQSeo5rarkK74wGMjFalE5cMpBGLs9OyAA+L31UQC6gcGObKPBv4jAOkjz+2HfLeJchE9k/bvHIcBmJum9ZONvWEpFLYMLvOOYtcjOwDL0dkdML800rVYn02zqyZxpcRDtfH6XltFZKd4xW2hS5LL5Fx+8vu0sFCKPvhl8pB8PgDG06k9QZcYMt75yGkuhXzshuZ3aa4u+y6+N7yvMTSEtpcgPN3uZBgLnIXsRnZdrn9J1V+2SfU7cPNT2KnZfKlZF32jZyRJV547a5r89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/z5IhOIPXlG5Tpw7qq8tOb5ZzZF8eAXGh4FcWVVGQ4=;
 b=Tx6RApHgBfFrXbgDlPqUVELVdRgF1fGNr5r6JWyImYRT/oT5LDZiSZMLJwyfDBda7FQK+gLuZG2DkziOXsBzQQ5enZw25OcSdyTMYPGzCmNyDw8AXd/eslyNp5Eaot3J5crVpnIO+wpWPjvs77sWSpPgB7XuTDJ9P5PBrzsgVKJHD4zoY7mLHQyo/1hT6r0g427qHZmcV0uqH0+72elKDpH58PZ7ALb9zLx2iUSdpPgQhrbjTJ4rd9ugUwAzAvRAvXiBbAGyhk2Pc8DBlpI/veFFTy+BU1SGY8rfKPYEZBsK8E8Rs7mDbBJseduATYQ6PwZTEg4YNva0APYN+OrbRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/z5IhOIPXlG5Tpw7qq8tOb5ZzZF8eAXGh4FcWVVGQ4=;
 b=Yebh6Bti0XrLK8+ydDTxuR7gaqi3TnhyYHC2KS3/uPE2Kgxm0brmagf2lywJOoUz0RrTRgo1VxueeddAdJ//pV3LD7stQtsUdRtsqIIom8hgFoPNwYpzrLttrn0692+vhndM5unr/1OKzmieYby/ytT0UJBC+6ONDCDfg6wRq/hVO6w6LMdP2LzbieRyUVcWnFSN/UY6y+/N04KAqFe82UzaoYpb13WKsIwlskzQxVop05R8R/8c/PVNbnY/5R88fg0BaXvTFhtN0efUWbtpqXk4PpdUOoF1q7Puw5E+my80YwpjP4wmq6u0RNT3VA5YyeOhEj8KuOXTiSgamwqnLw==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by OS3P286MB2025.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Sun, 15 Jan
 2023 10:32:20 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605%4]) with mapi id 15.20.6002.012; Sun, 15 Jan 2023
 10:32:20 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     linkinjeon@kernel.org, sfrench@samba.org
Cc:     senozhatsky@chromium.org, tom@talpey.com, hyc.lee@gmail.com,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] ksmbd: Implements sess->rpc_handle_list as xarray
Date:   Sun, 15 Jan 2023 18:32:05 +0800
Message-ID: <TYCP286MB23231B47E3C465464DB3BEC9CAC09@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230115103209.146002-1-set_pte_at@outlook.com>
References: <20230115103209.146002-1-set_pte_at@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [EdmPNEYwTS/yCGMCV7L4MtMVsF/Kc7EzOaVbGLojHmk=]
X-ClientProxiedBy: TYAPR01CA0210.jpnprd01.prod.outlook.com
 (2603:1096:404:29::30) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20230115103209.146002-3-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|OS3P286MB2025:EE_
X-MS-Office365-Filtering-Correlation-Id: 4db69377-ec9a-4aad-d839-08daf6e3c7ec
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MD3OLuawmpKAwR2XgCiNISZTQoldvNp+SMKSMjLYDW5VnGJv9Ify+ZU+8zJ7EXxXV4VWkPDqHCMguDKOYOHHpAdf/twcqeFsVYZ79/vfvOU170kb9qQLp0jXFXORkEK8UytuHnnJ3OCNCAVRJTwpDWygdWEWNzsi+6ntRAzVkJOJGyi7LDPfjeSBFfhFjCzePpaiK60r2hzOmFGEMiSZ0U4RKFTTJRKj8xxsW9e4ETmXKbJo6xDE8ul7r+KzhsZH1pZTmnuSmmiUbhK1o1ldOfuFEpAKucJMQyfPZIGkYtWucrVxRJiCy/raGHRIyh2pH7C+5Xwqe8bGPTm46CGBSKyL46qsjnw0FnMwdsYBk53cUAXePWd5ChUh2VSWBZg0RmBFnwTF1suSzIx9wvY5dnpwt2swlFLwaPbJRzeoueYcB+MgLGI0H5SRRkzptXd5dEfyz6P3f/V7LR3+Qt/9qZe68x/DwvQqzfEX/AS32P8Y1kVexlbCqdZchLKYkoqczV4e+PVts4jMIwhsMu03rBVW0xF0KkLnb43i7m40iSSuElpYkZMkzI98BB3pv5LpOTA83QNnwrzTmvSD8rYkROERTDsdct/KIJc93KvuLww=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2BAy2MlV7RiR/TQSzCJNSBWisuD8G98ZNDpLcNEVpaO6ipcIc9KDlz/Diw8n?=
 =?us-ascii?Q?CQq+AunXj7OhSMXdTjH6qMUwon860I5PqTS3bRCNa1PdnUXGCjMFRXQHI+5E?=
 =?us-ascii?Q?MAKJGXhn5bn4+DJ6KsXzOrMqnBdRcJEQ2Jn58XcM05GTtB5KNs28cyrgZD+D?=
 =?us-ascii?Q?RyeAtGHETLQik5pld/7yD1KvS+/3MI6ECbrzXy0TX2yt1mYK2sDA0uhkXJ4i?=
 =?us-ascii?Q?l4IzZDX+MFPY2zABJha+8x68chFKWwmQBEpTa3onvXUT9kyGOlkX45SJHAmB?=
 =?us-ascii?Q?6X0GAbmz4WEX61dEskTVrGP/2XDmKKDVy4g09KQpNMefzBVKXqAXNl/UTux3?=
 =?us-ascii?Q?O1KU905ulqtoqQjoUD9+VyegHB6AncqxH2YtEQUsHFLbfya9BkchfHP1qQvU?=
 =?us-ascii?Q?isrw78prazzMkCTG6vYbUEAe6MkBrkZQqVQMHeVETS2/y6qzfOHb1EpzK3cU?=
 =?us-ascii?Q?A+Gk8RD0u8oJ/QrurEkc0On0a0irBBD61zfqND5e9VrHkE/AHPG+Xsip8s8r?=
 =?us-ascii?Q?uuPsOxqbaYRi4EshovOHpXGQRB7Wcch8PpwLKKPDfJnIsdTlgG1VSep0+2a6?=
 =?us-ascii?Q?TwllSBlP9c1M6p5LA14sL0ailefVwUwVL/FzPqYVckqWx37DFRiLnA74MC1U?=
 =?us-ascii?Q?keXrgFPKKDOHiwrg5q96fsb3H6B04RWgHTcyNQyRJgE0cW3jMSCOYbJEUnjC?=
 =?us-ascii?Q?QXztqqDQuiZQtECvYaUoPSh1rUMUq4uAFDIyzIKsoGCDPSpchP81ycn0o6md?=
 =?us-ascii?Q?+NlJkUjXqmAPCSphFNoEdk8FyuGSqpcbaV2F6oak/C65NCmKNCmrXmYXWthL?=
 =?us-ascii?Q?+yrQ3TKjUr8oIB7A25uXtIPNdh18YYoiBPzCCiFGI0MlOEWL0yLDmmaJpM8O?=
 =?us-ascii?Q?O8DSFG466f3bdlFgM8Z052nBke73sOOl9G7atMgOVoKmngAg/sUwpJE1Q3tB?=
 =?us-ascii?Q?fYdePphJQYi567ZwVgiaQ66C4vJgUHxre7WIWRwkBS2gInKwFZGW1XtfEG2r?=
 =?us-ascii?Q?6p5oieQevXNpu/U1AD3OXxmmpKIAefO5XxhF4SIBNdulCDi9boCDDMyEQN85?=
 =?us-ascii?Q?0WS2cmXpG/fEOgRTq2CARwZ+QooqCZZaI7mR5c9NnRLfZzIYcSsX993ew9t/?=
 =?us-ascii?Q?vkscGTcSdZcFnm+b0mPW5C6kz0WvMBskFCK78f0cPxucuo4x8HwlTNAPLpf5?=
 =?us-ascii?Q?imLogvFh6n5kYbdyHiMlS9gFhJFNFn0tbOVJk/MjUe+3FPA6avd251HjzduH?=
 =?us-ascii?Q?huQ1DnbroR5gd1o9Rb+P2Ki+cumHMzBotzK1KKAITO0Mittb7uJt4epGQlrG?=
 =?us-ascii?Q?lZg=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db69377-ec9a-4aad-d839-08daf6e3c7ec
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 10:32:20.1511
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

For some ops on rpc handle:
1. ksmbd_session_rpc_method(), possibly on high frequency.
2. ksmbd_session_rpc_close().

id is used as indexing key to lookup channel, in that case,
linear search based on list may suffer a bit for performance.

Implements sess->rpc_handle_list as xarray.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 fs/ksmbd/mgmt/user_session.c | 37 ++++++++++++++----------------------
 fs/ksmbd/mgmt/user_session.h |  2 +-
 2 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/fs/ksmbd/mgmt/user_session.c b/fs/ksmbd/mgmt/user_session.c
index a2b128dedcfc..1ca2aae4c299 100644
--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -25,7 +25,6 @@ static DECLARE_RWSEM(sessions_table_lock);
 struct ksmbd_session_rpc {
 	int			id;
 	unsigned int		method;
-	struct list_head	list;
 };
 
 static void free_channel_list(struct ksmbd_session *sess)
@@ -58,15 +57,14 @@ static void __session_rpc_close(struct ksmbd_session *sess,
 static void ksmbd_session_rpc_clear_list(struct ksmbd_session *sess)
 {
 	struct ksmbd_session_rpc *entry;
+	long index;
 
-	while (!list_empty(&sess->rpc_handle_list)) {
-		entry = list_entry(sess->rpc_handle_list.next,
-				   struct ksmbd_session_rpc,
-				   list);
-
-		list_del(&entry->list);
+	xa_for_each(&sess->rpc_handle_list, index, entry) {
+		xa_erase(&sess->rpc_handle_list, index);
 		__session_rpc_close(sess, entry);
 	}
+
+	xa_destroy(&sess->rpc_handle_list);
 }
 
 static int __rpc_method(char *rpc_name)
@@ -102,13 +100,13 @@ int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name)
 
 	entry = kzalloc(sizeof(struct ksmbd_session_rpc), GFP_KERNEL);
 	if (!entry)
-		return -EINVAL;
+		return -ENOMEM;
 
-	list_add(&entry->list, &sess->rpc_handle_list);
 	entry->method = method;
 	entry->id = ksmbd_ipc_id_alloc();
 	if (entry->id < 0)
 		goto free_entry;
+	xa_store(&sess->rpc_handle_list, entry->id, entry, GFP_KERNEL);
 
 	resp = ksmbd_rpc_open(sess, entry->id);
 	if (!resp)
@@ -117,9 +115,9 @@ int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name)
 	kvfree(resp);
 	return entry->id;
 free_id:
+	xa_erase(&sess->rpc_handle_list, entry->id);
 	ksmbd_rpc_id_free(entry->id);
 free_entry:
-	list_del(&entry->list);
 	kfree(entry);
 	return -EINVAL;
 }
@@ -128,24 +126,17 @@ void ksmbd_session_rpc_close(struct ksmbd_session *sess, int id)
 {
 	struct ksmbd_session_rpc *entry;
 
-	list_for_each_entry(entry, &sess->rpc_handle_list, list) {
-		if (entry->id == id) {
-			list_del(&entry->list);
-			__session_rpc_close(sess, entry);
-			break;
-		}
-	}
+	entry = xa_erase(&sess->rpc_handle_list, id);
+	if (entry)
+		__session_rpc_close(sess, entry);
 }
 
 int ksmbd_session_rpc_method(struct ksmbd_session *sess, int id)
 {
 	struct ksmbd_session_rpc *entry;
 
-	list_for_each_entry(entry, &sess->rpc_handle_list, list) {
-		if (entry->id == id)
-			return entry->method;
-	}
-	return 0;
+	entry = xa_load(&sess->rpc_handle_list, id);
+	return entry ? entry->method : 0;
 }
 
 void ksmbd_session_destroy(struct ksmbd_session *sess)
@@ -327,7 +318,7 @@ static struct ksmbd_session *__session_create(int protocol)
 	set_session_flag(sess, protocol);
 	xa_init(&sess->tree_conns);
 	xa_init(&sess->ksmbd_chann_list);
-	INIT_LIST_HEAD(&sess->rpc_handle_list);
+	xa_init(&sess->rpc_handle_list);
 	sess->sequence_number = 1;
 
 	ret = __init_smb2_session(sess);
diff --git a/fs/ksmbd/mgmt/user_session.h b/fs/ksmbd/mgmt/user_session.h
index 44a3c67b2bd9..b6a9e7a6aae4 100644
--- a/fs/ksmbd/mgmt/user_session.h
+++ b/fs/ksmbd/mgmt/user_session.h
@@ -52,7 +52,7 @@ struct ksmbd_session {
 	struct xarray			ksmbd_chann_list;
 	struct xarray			tree_conns;
 	struct ida			tree_conn_ida;
-	struct list_head		rpc_handle_list;
+	struct xarray			rpc_handle_list;
 
 	__u8				smb3encryptionkey[SMB3_ENC_DEC_KEY_SIZE];
 	__u8				smb3decryptionkey[SMB3_ENC_DEC_KEY_SIZE];
-- 
2.25.1

