Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C536770E5
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 18:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjAVRHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 12:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjAVRHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 12:07:44 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11012003.outbound.protection.outlook.com [52.101.63.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D4BAD31;
        Sun, 22 Jan 2023 09:07:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLYn9CSVPfbXPR3w0fI842O7t4Jc5JhDKAlN0iw34fojFLpBe6iEZn8KggkDLxJnoNPeTyKp5sw47XRezspLjbMP4jQWu2mNXhmAV83deCYKbnJn2Fzt5AbHlxcVDuCOaFiEWwpWFyUd/ny9Ed4l0vcu/Om0vbrDfRo+EqOoJvTlw1jYTJ30BIt3+sFaXD2+MXM1PHrUANDPP/dfIeb3BTMtM849PB/KGK8HU0hseDl9Rybz0+YoOAKRuhK7TilsDICbhDhiYuS+NZ0qoNhnY8/jg4SNZ5YH37UPUT1KmAyeP663w4hFLOpDgEBu5u8Z3McwV7ZHAOZfE5zVY6s+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfcd1wBT3ZdZtwiJ0ROpaSaeazj8fSJNBjMNY4QMyII=;
 b=fpvyLnAxct35EGoIjwNFixUKAI0QQpHIDU6F1iozbJ0vRk4nCV2nW/jw1k7NSH+wg8epOYSTXj6zZPzSjjUEa/lb6DT2GWy7ish4OoaIBX8a6oGqWIp5SWJ6jFRk+CAQX0AyI11w78W+F/4lf69O4xzcL37jlnZfWZq5P0b0yHpFhY3m7pZ/URKAAC2vSPqH0iIJdSGjae70BJvp3FxVisLnvo9uZ3SsQcykhci2IpOJT4VqlE89GKn1MATW8MWePvY3PRbw9rCs7OuJf4TUEOhD8moeHbNUIYawEy0awA1wpXuAYEYSTVNNB82YpFJoCN0u8WCCdwQLHq3DJpyxYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfcd1wBT3ZdZtwiJ0ROpaSaeazj8fSJNBjMNY4QMyII=;
 b=hzZJ1XyXDev68RnjaWg4ANbiONobdhWRr5Ty+0cNS9ZQnC2TCznqxibkyCsoDVH3JbJf6Hs0zBih1VwQJiUcAgv0QX/gJ8K4tNuNdPptGMV7YSwG9Kug2F/3h9kvleg6/7nb6fZW88ncmtrfm9UPB50YIhrf+PNwwlm26BzVLis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MW4PR05MB9322.namprd05.prod.outlook.com (2603:10b6:303:1ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Sun, 22 Jan
 2023 17:07:34 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::e710:a9a8:3bc8:d0b0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::e710:a9a8:3bc8:d0b0%3]) with mapi id 15.20.6002.031; Sun, 22 Jan 2023
 17:07:34 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        chinglinyu@google.com, namit@vmware.com, srivatsab@vmware.com,
        srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH 5/8] eventfs: adding functions to create eventfs files and directories
Date:   Sun, 22 Jan 2023 22:37:04 +0530
Message-Id: <1674407228-49109-5-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 941b4f42-33c8-4314-b94d-08dafc9b279c
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XprIsvCxxe1Dq4jd5Nz2s2el42md8685ZAqvSgwpWMDd4DnAtcdXujDUFUckLULkSjcZbS/3tLiGAOw3X7NpZ0rOb3Raahu1qmBJ9Iq/ztE1dr+4dgNkUcvV4iYg1EMfMxZeJHiXimSUw1ifLCtcMPdUDCCFvFoQ2z4pB6B38ZTcDCOT6d2XArTwktGthwPqxSk/F7/Un89UL4w5PYgmf2uXgKV/RS760asImRCtLX2DqkJIXhL68JAs8vTGdraOaQKiPQSVPLN1lM3VGOv3ivRcwQoCDwP8BVzhmfkwqJ466hlWe7Q9rZJkrI1/DGfhP2Uq1a3zhtugt8DMVUWyJTxfSzDWGgsN0n7lzigjkCwbyzjn76rRpZlDWLD2Os78T/hVJd6fkjNKB1zgHkf+8UdSDTPcItJWHIyg+WcAxehdxsMDMBmTpK+zzk6mVWM37TEu5ICcGt3XUGimHdF7meyu5jnJTH7nF7yzmX/b552OR8gAAS+CO9EM/vPPdbhbkTDC+zKeW+o8DnYQ11fhSdpOWed/t851ocIumLQVW0YcDj0OXo/d7gRoei/ftnsY5nkSDENZEWgsJ5+nWYBp6JN0FxfbQNw8N0cqJjd3INUkUcqKfTcprn/lJwTOsE7QGbvxsaXmUpKA2N1zna7vhFxZ/JmtA8Ry0Lh7qjj7mKRAKE5a1WFLnkkyEvetocZOZ37unfTk35JErGZrjfYYiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199015)(36756003)(8676002)(478600001)(2616005)(4326008)(66556008)(66476007)(6512007)(41300700001)(186003)(66946007)(26005)(2906002)(86362001)(83380400001)(6506007)(107886003)(316002)(6666004)(52116002)(6486002)(5660300002)(8936002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Svz/LjoKRODvq6kYz3R19IQxqmJuj4xkoMpZDPNUB2IVNO5DQswx/RHz/rs?=
 =?us-ascii?Q?nYjnbZihe4cIqjRfhWK8TaDv3StvxdOQj2dhwGUs1BB25K9rD5Kg9eyv4t6S?=
 =?us-ascii?Q?gYQpDXqzoQIc2MhFe7vn40CPcBRJayqzS3dRgUXYYYnmyymhuq75yCtISSKL?=
 =?us-ascii?Q?8fEo/Rkk2IUh3oKM4syyyZB2w1Kl45OCxVE39FbhmlnK49ti2Ql7lTba4eC9?=
 =?us-ascii?Q?PUlaixrECEFbhuQGGBpBQgelXDS0j2I7lk+pBU1TrxMTCniXOM4GjoyyrkIg?=
 =?us-ascii?Q?0m2cCVdLyv9g4J1dKh/Vd5HHRzWpQsMnN4GdFbQFM7qrJM2W6Td4974oHB0k?=
 =?us-ascii?Q?L3Ct01Qdc/M+25srgEXlFD5lkkTSjPD7nFs1Zp8HYAPcBrdKry8rzPHl8qsI?=
 =?us-ascii?Q?skIASw6fSn0fKmLTZOcr1LZbCTMu2F5Z2nIKHFk4h654tDX2KfkcwGRRmOv/?=
 =?us-ascii?Q?maX1NstxxFJKSEglWe+pNQocYnNuIcdulVdlIkIWAu5wruYgpg0C2nNdnipo?=
 =?us-ascii?Q?BKMQFxYaNJC8225FLelU2Xq5lvjphTNqos65gLZ50cOe3jBMFs88raREsfer?=
 =?us-ascii?Q?n7j7wNIogQYkP28yf0oIO/ccSLUNM6IdsNepFOrfP2gMv/fOVos4fFYbqvn3?=
 =?us-ascii?Q?rIiKLIH/p++HwJjL2A6h5Lz88Zo42+aDnk8CCVssU3GcpssXKn2n98fXJkce?=
 =?us-ascii?Q?YcZJ+BlbfA1VDo6jy0yjFCLLw45AolAi4Zw3EahmH3mprK87b/r61JIqhEEn?=
 =?us-ascii?Q?dtqQT5D6+Y1omRe/h62pMqpbTzQ8ZTBQNQ98X5CNbYNIXMC1+g0bMP/e3jTD?=
 =?us-ascii?Q?9XSClADAvTeYox0tzj8xbTE+AvalvZz3lmHGJoc3pumhjpclo2nPFC7Vrzwo?=
 =?us-ascii?Q?ziZ19IWZc/7nl481Sxsr062xqEuubu5NDrKLK7vYzOunMIHdkzlrY5Xypdr+?=
 =?us-ascii?Q?nd95fpRElXctfY01Pjs/3CfhriL8wQQc/Oqdm1b5m7j9rsOB0Q5wSVNvMJik?=
 =?us-ascii?Q?nwg9cqpBojgkBJAr+39DyQd6RabiMnYdZAeuUanZ64+aoQlZ8YfkeVh+Fem+?=
 =?us-ascii?Q?bX6PT2Qqh5L2cX7eUo99vpkGOhk2fIjk3UpJtohURTOdThzZtcQxb9Mou1To?=
 =?us-ascii?Q?16AUH5qAH84xEAMLg9+MVeIVrGOeADB1clHKZpWJBLOUi+J8N0Tw32Dp0zBf?=
 =?us-ascii?Q?sZYn6lmp6qnNIord9XHhUUGAfpMSAqrmf6IQT5K8UZQapwBwJrgFUcd5s2ZC?=
 =?us-ascii?Q?jQuU3QUCdZcMgsEP4mHL3hc6bL4jUaccglXxxeg4ew6bZOWUyLQ6eHZtR0C6?=
 =?us-ascii?Q?+GTkt5Nz4A72hJuEfuSTHmDrwdlHhPyubNesibkS4zWEBnKtFTdhKVa4oa1Q?=
 =?us-ascii?Q?V60okFEvmF00Gqb/ZlRqNV3/w5uCV4I9uDOXZo4ziREkB5yRCw2gFoeI/EfB?=
 =?us-ascii?Q?sGV133uaagovwV4rWp3fS10KYzlfLSx5LIQGKYEz9v56w0W3oVofb6/Oj5MM?=
 =?us-ascii?Q?R4mWojyB7o1jI4RkbDgJveF/kWMT1t8ga5cgo14+wPzurHs4uA6un1upQGjc?=
 =?us-ascii?Q?bspBdPRotkHrS/Hn8dkwbLSzRXzqSwNclPKp5I+b?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941b4f42-33c8-4314-b94d-08dafc9b279c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2023 17:07:34.3715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JV8sP5rYu9hhnET97cbOzAfm1baSOLOEQwD9NLe/FNNiei40ghhpE8DvybwwG/N+aXQv1YlQBvDaDwlZJI+kxQ==
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

Adding eventfs_create_file(), eventfs_create_dir()
to create file, dir at runtime as and when requires.

These function will be called either from lookup
of inode_operations or open of file_operations.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/event_inode.c | 137 ++++++++++++++++++++++++++++++++++++++++++++++-
 fs/tracefs/inode.c       |  47 ++++++++++++++++
 include/linux/tracefs.h  |   6 +++
 3 files changed, 189 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 4d47da0..28866c0 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -21,6 +21,141 @@
 #include <linux/kref.h>
 #include "internal.h"
 
+/**
+ * eventfs_create_file - create a file in the tracefs filesystem
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is NULL, then the
+ *          file will be created in the root of the tracefs filesystem.
+ * @data: a pointer to something that the caller will want to get to later
+ *        on.  The inode.i_private pointer will point to this value on
+ *        the open() call.
+ * @fops: a pointer to a struct file_operations that should be used for
+ *        this file.
+ *
+ * This is the basic "create a file" function for tracefs.  It allows for a
+ * wide range of flexibility in creating a file.
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the tracefs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, %NULL will be returned.
+ *
+ * If tracefs is not enabled in the kernel, the value -%ENODEV will be
+ * returned.
+ */
+struct dentry *eventfs_create_file(const char *name, umode_t mode,
+				   struct dentry *parent, void *data,
+				   const struct file_operations *fop,
+				   bool anon)
+{
+	struct tracefs_inode *ti;
+	struct dentry *dentry;
+	struct inode *inode;
+
+	if (security_locked_down(LOCKDOWN_TRACEFS))
+		return NULL;
+
+	if (!(mode & S_IFMT))
+		mode |= S_IFREG;
+
+	if (WARN_ON_ONCE(!S_ISREG(mode)))
+		return NULL;
+
+	dentry = eventfs_start_creating(name, parent);
+
+	if (IS_ERR(dentry))
+		return dentry;
+
+	inode = tracefs_get_inode(dentry->d_sb);
+	if (unlikely(!inode))
+		return eventfs_failed_creating(dentry);
+
+	inode->i_mode = mode;
+	inode->i_fop = fop;
+	inode->i_private = data;
+
+	ti = get_tracefs(inode);
+	ti->flags |= TRACEFS_EVENT_INODE;
+
+	if (anon)
+		d_instantiate_anon(dentry, inode);
+	else
+		d_instantiate(dentry, inode);
+
+	fsnotify_create(dentry->d_parent->d_inode, dentry);
+	return eventfs_end_creating(dentry);
+}
+
+/**
+ * eventfs_create_dir - create a dir in the tracefs filesystem
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is NULL, then the
+ *          file will be created in the root of the tracefs filesystem.
+ * @data: a pointer to something that the caller will want to get to later
+ *        on.  The inode.i_private pointer will point to this value on
+ *        the open() call.
+ * @fop: a pointer to a struct file_operations that should be used for
+ *        this dir.
+ * @iop: a pointer to a struct inode_operations that should be used for
+ *        this dir.
+ *
+ * This is the basic "create a dir" function for eventfs.  It allows for a
+ * wide range of flexibility in creating a dir.
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the tracefs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, %NULL will be returned.
+ *
+ * If tracefs is not enabled in the kernel, the value -%ENODEV will be
+ * returned.
+ */
+struct dentry *eventfs_create_dir(const char *name, umode_t mode,
+				  struct dentry *parent, void *data,
+				  const struct file_operations *fop,
+				  const struct inode_operations *iop,
+				  bool anon)
+{
+	struct tracefs_inode *ti;
+	struct dentry *dentry;
+	struct inode *inode;
+
+	if (security_locked_down(LOCKDOWN_TRACEFS))
+		return NULL;
+
+	WARN_ON(!S_ISDIR(mode));
+
+	dentry = eventfs_start_creating(name, parent);
+
+	if (IS_ERR(dentry))
+		return dentry;
+
+	inode = tracefs_get_inode(dentry->d_sb);
+	if (unlikely(!inode))
+		return eventfs_failed_creating(dentry);
+
+	inode->i_mode = mode;
+	inode->i_op = iop;
+	inode->i_fop = fop;
+	inode->i_private = data;
+
+	ti = get_tracefs(inode);
+	ti->flags |= TRACEFS_EVENT_INODE;
+
+	inc_nlink(inode);
+	if (anon)
+		d_instantiate_anon(dentry, inode);
+	else
+		d_instantiate(dentry, inode);
+	inc_nlink(dentry->d_parent->d_inode);
+	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
+	return eventfs_end_creating(dentry);
+}
+
 static const struct file_operations eventfs_file_operations = {
 };
 
@@ -86,9 +221,9 @@ struct dentry *eventfs_create_events_dir(const char *name, struct dentry *parent
  */
 struct eventfs_file *eventfs_add_subsystem_dir(const char *name, struct dentry *parent)
 {
-	struct eventfs_file *ef;
 	struct tracefs_inode *ti_parent;
 	struct eventfs_inode *ei_parent;
+	struct eventfs_file *ef;
 
 	if (!parent)
 		return ERR_PTR(-EINVAL);
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 015b7b8..6d950d1 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -451,6 +451,53 @@ struct dentry *tracefs_end_creating(struct dentry *dentry)
 	return dentry;
 }
 
+struct dentry *eventfs_start_creating(const char *name, struct dentry *parent)
+{
+	struct dentry *dentry;
+	int error;
+
+	error = simple_pin_fs(&trace_fs_type, &tracefs_mount,
+			      &tracefs_mount_count);
+	if (error)
+		return ERR_PTR(error);
+
+	/*
+	 * If the parent is not specified, we create it in the root.
+	 * We need the root dentry to do this, which is in the super
+	 * block. A pointer to that is in the struct vfsmount that we
+	 * have around.
+	 */
+	if (!parent)
+		parent = tracefs_mount->mnt_root;
+
+	if (unlikely(IS_DEADDIR(parent->d_inode)))
+		dentry = ERR_PTR(-ENOENT);
+	else
+		dentry = lookup_one_len(name, parent, strlen(name));
+
+	if (!IS_ERR(dentry) && dentry->d_inode) {
+		dput(dentry);
+		dentry = ERR_PTR(-EEXIST);
+	}
+
+	if (IS_ERR(dentry))
+		simple_release_fs(&tracefs_mount, &tracefs_mount_count);
+
+	return dentry;
+}
+
+struct dentry *eventfs_failed_creating(struct dentry *dentry)
+{
+	dput(dentry);
+	simple_release_fs(&tracefs_mount, &tracefs_mount_count);
+	return NULL;
+}
+
+struct dentry *eventfs_end_creating(struct dentry *dentry)
+{
+	return dentry;
+}
+
 /**
  * tracefs_create_file - create a file in the tracefs filesystem
  * @name: a pointer to a string containing the name of the file to create.
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index b02cbba..52201f3 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -38,6 +38,12 @@ struct eventfs_file {
 	bool                            created;
 };
 
+struct dentry *eventfs_start_creating(const char *name, struct dentry *parent);
+
+struct dentry *eventfs_failed_creating(struct dentry *dentry);
+
+struct dentry *eventfs_end_creating(struct dentry *dentry);
+
 struct dentry *eventfs_create_events_dir(const char *name,
 					 struct dentry *parent);
 
-- 
2.7.4

