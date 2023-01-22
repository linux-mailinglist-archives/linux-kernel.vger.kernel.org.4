Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561D76770E3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 18:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjAVRHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 12:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjAVRHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 12:07:39 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11012003.outbound.protection.outlook.com [52.101.63.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0951B55A;
        Sun, 22 Jan 2023 09:07:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDtSLlXXvQVfEV1gK6rToHprAtJN7ZvWiPAQrLj9UBGBp2ret2P/AaX1W8/HUZ/9wnwskwGEn/V0v1eV6v8Qimn9bU0nv5tTPYsaZ0HD41SSyxLIoBGgBWpAyCMVIYtWPPBjoDGiESCCpWJiIUz4NYNoVHN1GJvndhwNdySqJbtaRk69rb+LmoXSca3dFcqX5KFoQ+G8Vomixsvl7/oQA1nlgRQEkyFCnUp0cowgrwzW07nwZApO9gQb0lBGRR+pAoFBXRNywxEKCIU4flIu81DpqmK0EJCxuing81xgo+5n4bLCUOnSk9RWQOa2/Cb1JX3YB62oobwBcKOePVSbvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFoLdhfObTl7nJsHCOSs0v1zTfDsS6wMCzu59YkD/YM=;
 b=nnJz1ZfOuIUxGjyO3os6G7K28BmZNq00YN5YOcsNDaA46d3jcyxSCcmPnex5AbRpeDfEek5pSfHFNzMLSk6/C9Q4WFiib2KHqsDfqjfmYrCFQkyrgsNHhviIZNT/Xx4dLUk4g42Qo1ZRn1BEexcuAWsWZeMZCBEIYERXuTCDtXcPgiiwlHFuf2wfo0n+d4nTCvfiDpb1TaVEHQsZSDL0nLv2CwMNsbFGiSPHpm8ohVxwOdjlThgw+JZKj7XYfhop4B1TfAVFu0atygrx+DmaevMyj8wum1jEv1EOKywhn+i039A9Tivk80ZmC2N/DEOfimPTaKdXtK3tnxp3HzDSyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFoLdhfObTl7nJsHCOSs0v1zTfDsS6wMCzu59YkD/YM=;
 b=zjG0hcm2xAtAgU2auGxbqTslWI3BZPEQvAR1iXNXWIMKJu0oR2aqrDw9HKJO8VaE7MWw6AQ62HSZaVjXm5S0KdQGaPcNUoiW9ck15qKNizbuCBF6mdwpG362xAAjSknQpbbGHuquj+F7a5hSL0ohHWnpB6Gx0oeHBowfDE8xAU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MW4PR05MB9322.namprd05.prod.outlook.com (2603:10b6:303:1ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Sun, 22 Jan
 2023 17:07:31 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::e710:a9a8:3bc8:d0b0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::e710:a9a8:3bc8:d0b0%3]) with mapi id 15.20.6002.031; Sun, 22 Jan 2023
 17:07:31 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        chinglinyu@google.com, namit@vmware.com, srivatsab@vmware.com,
        srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH 2/8] eventfs: adding eventfs dir add functions
Date:   Sun, 22 Jan 2023 22:37:01 +0530
Message-Id: <1674407228-49109-2-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9e67f590-2446-4e87-ab95-08dafc9b25ea
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kMluHMUCWxRjHyvDwfmmM9hBiqPQFLRNobqY2XRLYCeFMogtuoJ+op465QXe6v2FIYD93OO5+eZmWy+65zxcwFKI1sKC9WRUHDkmyu3sVcSnKTfpWrUMdeKYVTo0OhkNZd7kpLGRjCuNRKZyskGxTJdtDLV5/Vp4qsBSTjhYfbegNroqcbtBVToAdtLzpKdqri9XQu3t9X1D2Q5QaxoD1N56WJ8+MgZqdz5bpBYmQWqFKo3ixmvvt2AlabJqou8/rSXu7cPPjHfzs03+24J2+k5aMdopOW0utlJ3B6u+6j0ka6uP6HlPnxlB6o8HAjLEjBS8j0FEziADmbxDiJyV/4YbrTIbrDiXKZTH0tWcW1RP8qU58s3UbGbWtz/qmQgLbSJKplpfccvM0q7bcYKABCli+LRFNC+yJuXHkoMLCMCwdTUhcr9ShHqInCTU39QSppOioxoX2A1EzrR1h1bjFrh+5W0u1Jj/uJtPYameWFiBbRw9M474bUvO0kUfo8VYfB6GuuWlT1g0BPjnNTsCZc3kuNiqgMyigSv4g/TuaiBJ3YygGGbocamGsbTCvjkw5oLfBVFc8rRYAKK5GJhtUAe6zRS4jDWwKV6+gQveGInAuVmu8v2EIqA3LE28gCQoaSNC/pT+px4XnhHSSDtfMqqflJmqeMlSi/JKnjDyeRTKSGbUcPqlt/rsFhMaX6oI22kbXZY8BWr9zEVGRLmOCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199015)(36756003)(8676002)(478600001)(2616005)(4326008)(66556008)(66476007)(6512007)(41300700001)(186003)(66946007)(26005)(2906002)(86362001)(83380400001)(6506007)(107886003)(316002)(6666004)(52116002)(6486002)(5660300002)(8936002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Od/1J922DSN3niyWy1ml8aSBtvwa51HBUu8ip8EQ8Npvyo5uDiFveulohfJ6?=
 =?us-ascii?Q?EJEDYjTC8tRHKgDRuCtFyMBjUYBqFeITjRsoANpeXTXzb96ReyZrRRg4X5V7?=
 =?us-ascii?Q?FDv83Zf277V4K+Mceu2uEy+0L+rbZFBdHb4d4odyshtF+mfqlF0AzBfVr2bw?=
 =?us-ascii?Q?2uPX7jf2NbIJ3FBZMYw00us4q4KR/ySbvqpcSqocyLMeDv10ts/nddiTmTzj?=
 =?us-ascii?Q?7KopMBkYLHK1WsX+zOakNvIRom8T4X/64ewzoPmC3p73ctEF71hvzUgSVnd+?=
 =?us-ascii?Q?WQ3pQtW1OBic+pxHTKcvRBMZhtUA88rSsR5zeP+xZN7g2HJBo2UYlgvyxB9/?=
 =?us-ascii?Q?iDZKOXpkmsGjGSmnOuuW/60xko4rNQpmsg8JCh98fvesaVGpNEc/i/jJYhy+?=
 =?us-ascii?Q?ifI/IU7YTTicotwrBt2nzkb/ckI9JusqNN0ji6j9Rtn7rjAq751XSlaW4mgE?=
 =?us-ascii?Q?R4O03gjehEXqfBxlFVfXTExHZa7rRK48dZw7YgR4QVx53Rg/zfgLMhCK9quz?=
 =?us-ascii?Q?T5/Xf8gdkDXVur+nVewYk90x34E0Yns1q+gBnzBioEzOS7tdG/CQdYFpsDni?=
 =?us-ascii?Q?Otjv6sZXj3w4j/ry4gsWKE75WOmiMbhBrmmBZd8NC6btcLItdZJA3rs7yinC?=
 =?us-ascii?Q?BbBRGlngDOXm9hC2CBYJlR1cNcfRfJdQ36E98BjLMNet7qxghXdOsEfwQyCg?=
 =?us-ascii?Q?0bkBe5K/XXmroOqsrYw+f7UHZbHcp7l42r/eAmg/dcAEMUAxR7gvi0Gm2wnV?=
 =?us-ascii?Q?xLnvHJazNn5PnAYvEjiXMDj8vwcW4XqD+AXbNzNaQs8R0vsf3CkIhMSmKY9K?=
 =?us-ascii?Q?/MQB2MIa9lY1k3vL6g+cYn/bqBtTtKdOI3JRWLVLvJekUwFf3LPcXpD58FF5?=
 =?us-ascii?Q?zsPww/W7vHSRuxoLk19H5tLUlwdS9HJcev40X+4136Zg8OChAiXKbk2wYHI4?=
 =?us-ascii?Q?vSe8C0X/QzryEImsh4JgK9HLRskmPneUclwUA+3lsfU0xUSLQc5JHpm6Hk8p?=
 =?us-ascii?Q?xDRsU3dyQq3lwuyfsqecJgp9WOrY9S8cjHFfdrpRvEzXiDYiDM81QNbkHL9w?=
 =?us-ascii?Q?cDjemNaM46Gel/gd138P1Fzn0mO9F8D0fVxGPfUioC1y0bmpk3KZ/VEAfs3y?=
 =?us-ascii?Q?VY56mj4lsrzpDEXrfxmlcFj55xbGGz5hCUCVaFTWLIpwgNLuDB5J6czmmW+3?=
 =?us-ascii?Q?D+ffkTY/RU3HsyjxaWWk63Kz0i1bxh9wWJoY26T288FuxHLJILSzDhnuo6Z8?=
 =?us-ascii?Q?Gp+A6Yeqycpeghav58+CgaopDiGVhxmDoXFqKFSx9I+Cu54iZgN8YWoPPQwp?=
 =?us-ascii?Q?ahbvhO5++LjigBwoNKTImPC1t3eNPexbQLyfRbLT/+ERxEws+SdzsUAqMUk/?=
 =?us-ascii?Q?7hLP1Pa8vn4ScHsWJ99G8B9aVhB+kcstfnWLrGaJWHZW080ba1XNGAjvaMVY?=
 =?us-ascii?Q?2qUMS3dsSzMQnsMad/A7HItmrfvnGgM74yby3X9kCmbeNaQmU93ObihzwzFZ?=
 =?us-ascii?Q?BQx5NMiWqQvWaDyxq7ONsHcV0+KeDXi9uqnnCbehso6OCgBGqsY7pVGj/ptZ?=
 =?us-ascii?Q?vx86b9iBz4vhDHdasY3pkW55NVcl/TxH7ihf9OYS?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e67f590-2446-4e87-ab95-08dafc9b25ea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2023 17:07:31.4800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NK9jDm2Flcbe4qGwZtgbi3L385Js0paeVanhpp8js7WCYAwHuE1H1ySH1VU0cskd0tkoplwdQIlDbVT1E7S3bA==
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

Adding eventfs_file structure which will hold properties of file or dir.

Adding following functions to add dir in eventfs:

eventfs_create_events_dir() will directly create events dir with-in
tracing folder.

eventfs_add_subsystem_dir() will adds the info of subsystem_dir to
eventfs and dynamically create subsystem_dir as and when requires.

eventfs_add_dir() will add the info of dir (which is with-in
subsystem_dir) to eventfs and dynamically create these dir as
and when requires.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/Makefile      |   1 +
 fs/tracefs/event_inode.c | 173 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/tracefs.h  |  26 +++++++
 3 files changed, 200 insertions(+)
 create mode 100644 fs/tracefs/event_inode.c

diff --git a/fs/tracefs/Makefile b/fs/tracefs/Makefile
index 7c35a28..73c56da 100644
--- a/fs/tracefs/Makefile
+++ b/fs/tracefs/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 tracefs-objs	:= inode.o
+tracefs-objs	+= event_inode.o
 
 obj-$(CONFIG_TRACING)	+= tracefs.o
 
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
new file mode 100644
index 0000000..ef3b435
--- /dev/null
+++ b/fs/tracefs/event_inode.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  event_inode.c - part of tracefs, a pseudo file system for activating tracing
+ *
+ *  Copyright (C) 2020-22 VMware Inc, author: Steven Rostedt (VMware) <rostedt@goodmis.org>
+ *  Copyright (C) 2020-22 VMware Inc, author: Ajay Kaher <akaher@vmware.com>
+ *
+ *  eventfs is used to show trace events with one set of dentries
+ *
+ *  eventfs stores meta-data of files/dirs and skip to create object of
+ *  inodes/dentries. As and when requires, eventfs will create the
+ *  inodes/dentries for only required files/directories. Also eventfs
+ *  would delete the inodes/dentries once no more requires but preserve
+ *  the meta data.
+ */
+#include <linux/fsnotify.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/security.h>
+#include <linux/tracefs.h>
+#include <linux/kref.h>
+#include "internal.h"
+
+static const struct file_operations eventfs_file_operations = {
+};
+
+const struct inode_operations eventfs_root_dir_inode_operations = {
+};
+
+/**
+ * eventfs_create_events_dir - create the trace event structure
+ * @name: a pointer to a string containing the name of the directory to
+ *        create.
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is NULL, then the
+ *          directory will be created in the root of the tracefs filesystem.
+ *
+ * This function creates the top of the trace event directory.
+ */
+struct dentry *eventfs_create_events_dir(const char *name, struct dentry *parent)
+{
+	struct dentry *dentry = tracefs_start_creating(name, parent);
+	struct eventfs_inode *ei;
+	struct tracefs_inode *ti;
+	struct inode *inode;
+
+	if (IS_ERR(dentry))
+		return dentry;
+
+	ei = kzalloc(sizeof(*ei), GFP_KERNEL);
+	if (!ei)
+		return ERR_PTR(-ENOMEM);
+	inode = tracefs_get_inode(dentry->d_sb);
+	if (unlikely(!inode)) {
+		kfree(ei);
+		tracefs_failed_creating(dentry);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	INIT_LIST_HEAD(&ei->e_top_files);
+
+	ti = get_tracefs(inode);
+	ti->flags |= TRACEFS_EVENT_INODE;
+	ti->private = ei;
+
+	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+	inode->i_op = &eventfs_root_dir_inode_operations;
+	inode->i_fop = &eventfs_file_operations;
+
+	/* directory inodes start off with i_nlink == 2 (for "." entry) */
+	inc_nlink(inode);
+	d_instantiate(dentry, inode);
+	inc_nlink(dentry->d_parent->d_inode);
+	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
+	return tracefs_end_creating(dentry);
+}
+
+/**
+ * eventfs_add_subsystem_dir - add eventfs subsystem_dir to list to create later
+ * @name: a pointer to a string containing the name of the file to create.
+ * @parent: a pointer to the parent dentry for this dir.
+ *
+ * This function adds eventfs subsystem dir to list.
+ * And all these dirs are created on the fly when they are looked up,
+ * and the dentry and inodes will be removed when they are done.
+ */
+struct eventfs_file *eventfs_add_subsystem_dir(const char *name, struct dentry *parent)
+{
+	struct eventfs_file *ef;
+	struct tracefs_inode *ti_parent;
+	struct eventfs_inode *ei_parent;
+
+	if (!parent)
+		return ERR_PTR(-EINVAL);
+
+	ti_parent = get_tracefs(parent->d_inode);
+	ei_parent = ti_parent->private;
+
+	ef = kzalloc(sizeof(*ef), GFP_KERNEL);
+	if (!ef)
+		return ERR_PTR(-ENOMEM);
+
+	ef->ei = kzalloc(sizeof(*ef->ei), GFP_KERNEL);
+	if (!ef->ei) {
+		kfree(ef);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	INIT_LIST_HEAD(&ef->ei->e_top_files);
+
+	ef->name = kstrdup(name, GFP_KERNEL);
+	if (!ef->name) {
+		kfree(ef);
+		kfree(ef->ei);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ef->mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+	ef->iop = &eventfs_root_dir_inode_operations;
+	ef->fop =  &eventfs_file_operations;
+	ef->dentry = NULL;
+	ef->created = false;
+	ef->d_parent = parent;
+
+	list_add_tail(&ef->list, &ei_parent->e_top_files);
+	return ef;
+}
+
+/**
+ * eventfs_add_dir - add eventfs dir to list to create later
+ * @name: a pointer to a string containing the name of the file to create.
+ * @eventfs_file: a pointer to the parent eventfs_file for this dir.
+ *
+ * This function adds eventfs dir to list.
+ * And all these dirs are created on the fly when they are looked up,
+ * and the dentry and inodes will be removed when they are done.
+ */
+struct eventfs_file *eventfs_add_dir(const char *name, struct eventfs_file *ef_parent)
+{
+	struct eventfs_file *ef;
+
+	if (!ef_parent)
+		return ERR_PTR(-EINVAL);
+
+	ef = kzalloc(sizeof(*ef), GFP_KERNEL);
+	if (!ef)
+		return ERR_PTR(-ENOMEM);
+
+	ef->ei = kzalloc(sizeof(*ef->ei), GFP_KERNEL);
+	if (!ef->ei) {
+		kfree(ef);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	INIT_LIST_HEAD(&ef->ei->e_top_files);
+
+	ef->name = kstrdup(name, GFP_KERNEL);
+	if (!ef->name) {
+		kfree(ef->ei);
+		kfree(ef);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ef->mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+	ef->iop = &eventfs_root_dir_inode_operations;
+	ef->fop =  &eventfs_file_operations;
+	ef->created = false;
+	ef->dentry = NULL;
+	ef->d_parent = NULL;
+
+	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
+	return ef;
+}
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 9991244..6983409 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -21,6 +21,32 @@ struct file_operations;
 
 #ifdef CONFIG_TRACING
 
+struct eventfs_inode {
+	struct list_head		e_top_files;
+};
+
+struct eventfs_file {
+	const char                      *name;
+	struct dentry                   *d_parent;
+	struct dentry                   *dentry;
+	struct list_head                list;
+	struct eventfs_inode            *ei;
+	const struct file_operations    *fop;
+	const struct inode_operations   *iop;
+	void                            *data;
+	umode_t                         mode;
+	bool                            created;
+};
+
+struct dentry *eventfs_create_events_dir(const char *name,
+					 struct dentry *parent);
+
+struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
+					       struct dentry *parent);
+
+struct eventfs_file *eventfs_add_dir(const char *name,
+				     struct eventfs_file *ef_parent);
+
 struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops);
-- 
2.7.4

