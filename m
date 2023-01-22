Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F766770E4
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 18:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjAVRHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 12:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjAVRHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 12:07:43 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11012003.outbound.protection.outlook.com [52.101.63.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4D96184;
        Sun, 22 Jan 2023 09:07:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8tDABeXQjGsPQPsfC080rzha4U39IycX51Ke5tf8zzjWV6N8eBYPK0hVRsI7qdiiYBltaSGmahO8Xr+zg1Lsv7TtV49vQMYmzPZev9uGry8wYeYz1+xZe9MFtxjHFDNa0/O5L+vIfTlnoWX90ltB9kapN9aAEhxdbkHay7Xhtrc0YHvKxTQ37zTc/h/BZh2BM4uks2GJwPeMi63UIvPMtzvUMtBm/nWaJW8faO9Ym+LkAE4Njoo0ha3y/wsTuXiv163OAKjEGWK0fD7g3tv6c+e9Y8sFbhThVbXumwQt2V9d7Z07ZBuxiNPEiFnfG2mKR0qaTuJaIk/JNEkTHAw+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=604SRayyklRpjImVlk5PCVvyMeRL/ZrQj0Vsxb+9jwU=;
 b=GNXMMnLwroyNQX4O95uPSMHmb7OWyRwe7sGji5v5O8hLl9iAhhF0C73Tru+gBVfGUzPsONDDItLThxoD1faUA0poY9BBoNJ+ebm2vyES721hQNLYqu1RWAlOV1sWHooKXIHPynCCdwaDGKiyQdRRnOJDAzB/vRQn+6oMhPLCu769CCTSVpXycbSv1Oj1QXXaNsfGviLUr01RFwr3EdPlYIZYcx7NsKQm9v3sLvY9xlSXvmmWyY46C0LrsRQsFZUApTBpkKPa+cg2i+hU8iYiyzwQAvL+nr2yYpbhfYIfNitnrFm6hIuOVVXOx73GBnBCDBykBrvgcVtOwNJSi/5D3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=604SRayyklRpjImVlk5PCVvyMeRL/ZrQj0Vsxb+9jwU=;
 b=rYcaPJBad9XjXh1iLoSS5okCWDUOAPqqATHpXdZrLfyT6Rbym1CktJBPKVUuJgBFQUINGF3x5OwXk9mONUOcz89AU4wkFnMI3Rc5tjc6Y20Ihh3TZbBQh9DZboIJWxL0RrBBepn9bvn/zuMOPwHtYrbdwndypyj2ouQcppJacBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MW4PR05MB9322.namprd05.prod.outlook.com (2603:10b6:303:1ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Sun, 22 Jan
 2023 17:07:32 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::e710:a9a8:3bc8:d0b0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::e710:a9a8:3bc8:d0b0%3]) with mapi id 15.20.6002.031; Sun, 22 Jan 2023
 17:07:32 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        chinglinyu@google.com, namit@vmware.com, srivatsab@vmware.com,
        srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH 3/8] eventfs: adding eventfs file add functions
Date:   Sun, 22 Jan 2023 22:37:02 +0530
Message-Id: <1674407228-49109-3-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d2d3b81-beb6-4a58-d09a-08dafc9b2685
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OvckA4iy0neXLBSk9HT9GHiWcbSFkmCeP7RKSWOL4wnyTo9dr1Skc2aRDwOY4nzSYGg0+OBW4dEumifbCbebbRm2rPoTk4Z2ExxywM1Wdy3DQe3lVNTYiysIuHI+Feu6Ah8Tw2C16pTxZYFU1edzJo2Zm1BhyCgYWYaFti9T97T9JGdow+kjoNiZ/11J1gygk91QEeZT4sfFva0pse4WS1Qzw6VgT+pgz7NbBVkeE513LJqsD8e4RvbMxHZXn0P99O68pQgis+w/FW1AxUZdibeAkvflkfPI9WAM4fDHSneYKIS44LvekzBHv1f6Jbmdurn3x6FJQArgYMQGZJxMcN/Vbc/nKKyb/L8Jn85mW/AcTV8IrSVKsWcoS2QeBQezCUCXzt4ltYiyvbdA+eID+IvjH3Wq0M6wDQRl2y08ecmDfUOziAJRj9BPPYl6sTHDlDo85RVHA3Cj5sUIkPFSMpvRbL95a4YySQlbbZnDDtgUrXhftSAvcsM7xITMUVd+prNXYvejG3KyolGjW4DDj0yi23qvT2N4w1t38z8Gh4l6WBrnVx/7qlknN5Cen0MH9VbexdPWy+oR5T0ppeQqzf121Rx7Ee2W/GlnkOYUNHKmlfhHdsrLO8FEEOYcY5apU7f4cmHl3l8J/fpm3wxbilqE290RzO/6HtYmL+ik6xScLKvX+QujIOEUtWGNsh2xfka9giLEgrvvPU7Mbt96MA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199015)(36756003)(8676002)(478600001)(2616005)(4326008)(66556008)(66476007)(6512007)(41300700001)(186003)(66946007)(26005)(2906002)(86362001)(6506007)(107886003)(316002)(6666004)(52116002)(6486002)(5660300002)(8936002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OLIgZGWFZiDZw+1zC+tLj/tOzDy7kgbPqbTBrq2YUMnLoVOcDjwymhQOzCvV?=
 =?us-ascii?Q?3KIkRaBeyAq2MP0qdRedP9d7wnP/XJ453DfBeVgT/VU4qVwsDT7KmZYNH3PQ?=
 =?us-ascii?Q?udxDmLDWgDAlvcnBhxpKbXmYuV2xhIvlXoIgCUceLDWTbVjAWCDq6Iri5q82?=
 =?us-ascii?Q?ZnPpImEEG0nyD8P2dwx3oEKBGw3ML2JKkUeyBzlxTLeYfmD2fZraqBbb69UV?=
 =?us-ascii?Q?iNON4fcAJVJvBPzY1VGb7SKIsHsIVn8DpkEUj45T5vZsuOB76KOexMW+hDVH?=
 =?us-ascii?Q?/0FXfOEVHmAf5kEmyosVoFvWVej7V31VBHmjafzslliyIIsd4Iyk35dP/qQB?=
 =?us-ascii?Q?2DRYBWsPYD3oI+gM7IzbC3F5AnLrsy8MPImgvZVMvjQ777cifyT2TjEI4EZw?=
 =?us-ascii?Q?5AqOveyX7fxCu2GvHWvdUyCPOT0l7V7JMVPwyZGRlLc0hIFGRVGF+pZodRW3?=
 =?us-ascii?Q?z1y/uyUUkz4kkyheAgF5v7Cci5e5hhV8hazfel+HPVUP8uyKcaOan+pnE7mT?=
 =?us-ascii?Q?T2H3JHCKLWCp/RZiteGLsxXqrHrg8Z4ipwcgvwS8hCE9rOJ8D9tEA+km/p7J?=
 =?us-ascii?Q?kHduqhB3p6Z/IXm7FdHNt9iQj1xP/NU5ZSTcYF0uHq5i1r3uA/q+CA7ncR/A?=
 =?us-ascii?Q?f6kr/r266n+4WRzXuPEiRV6h+Y1Xqdr90SZygWd1FpxX75zcVcEXiTcqZYjt?=
 =?us-ascii?Q?RY/utcUGgP+gnFmXdnIOnULIUElbFf+LX83y2X5dkjfHmnqJiHWPZSOuTBtt?=
 =?us-ascii?Q?xIrisdSF3l8AyMDJlPlQRaLGwKu8CGbVk4855pHT8w9jKA4BX4gtnTPrUkGm?=
 =?us-ascii?Q?n5LNILR9scyzVEKhYKIrDALmWjl9E5XpaH6OtvrdAQMRO9qUtiwZ3SkyrD3F?=
 =?us-ascii?Q?hXjBPdVhkomCmiIq2pLE27LO8brK90mb0dnP0SmptEG2sKS67U5PHOg1NCFH?=
 =?us-ascii?Q?50Fk39uN1xd3f08cgZMCSfN0jJ591n2lI8NZ/LySIUezWFLwPs1q7PHBn+k2?=
 =?us-ascii?Q?IdusG7b8rUGfXITtUbKc6csNxlj02g91TB3DojY+WMiXYovZSCWiKuW2rrLg?=
 =?us-ascii?Q?h6XwXbuz0Goso7d47bpGEAqmVLSbcMjUZm78vbryTcQpe+7wk69J5uE6etfJ?=
 =?us-ascii?Q?/0NO/59LfSKijFnmeIkviz0WWf5MHdiDhMOSVIikRj7RcKDRNJeXksxWS9tg?=
 =?us-ascii?Q?k4+aKJju54w3PV7h3CwgbtCd7oQtpGKgYNSOO74E/n1sQGiBGyETC8yvmBV7?=
 =?us-ascii?Q?L9rCWKZR4ecvhSgKyhaaSYrc4hJvIr2kHiKS71YNwzLbwbO2adkc0AyPhPeG?=
 =?us-ascii?Q?NZX5v2ssCchoX8Z1DfqMmupE3+odJYJyNZJFaesJUmsBMJZjsfo8PJK2JQ2m?=
 =?us-ascii?Q?S9Nz9R+Wmv0SEuoF+6b3B7mGZhIH4KZytu2BB2faShdDaMqTKoGc8AxIbBT5?=
 =?us-ascii?Q?SRCE3UwUNGn18b+Yxx7Wqt7YJqYp9POZprk+GfPKQQ7wQFhZB1twbzhPDDWU?=
 =?us-ascii?Q?OmvnjDcKPOtk6W2VtwPQfguB6FNbnFEiKdEJojYtLI1VkRplV99snlYvb1V+?=
 =?us-ascii?Q?kYBHnNFj77Y6I34M0HyiHYEzj8+UTdwfaBBKXrXy?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2d3b81-beb6-4a58-d09a-08dafc9b2685
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2023 17:07:32.4186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfeYe15TceNChNai1aiIE8MHuB/SDLhhBJZZYRBxF+3LkIf+3GeDYxV5IUqR+gFUoFRF1JmRh/1R8m9FtmyA6w==
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

Adding following function to eventfs to add files:

eventfs_add_top_file() will add the info of top file
to eventfs and dynamically create these files as and
when required.

eventfs_add_file() will add the info of nested files
to eventfs and dynamically create these dir as and
when required.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/event_inode.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/tracefs.h  |   8 ++++
 2 files changed, 116 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index ef3b435..e479712 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -171,3 +171,111 @@ struct eventfs_file *eventfs_add_dir(const char *name, struct eventfs_file *ef_p
 	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
 	return ef;
 }
+
+/**
+ * eventfs_add_top_file - add event top file to list to create later
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is NULL, then the
+ *          file will be created in the root of the tracefs filesystem.
+ * @data: a pointer to something that the caller will want to get to later
+ *        on.  The inode.i_private pointer will point to this value on
+ *        the open() call.
+ * @fop: a pointer to a struct file_operations that should be used for
+ *        this file.
+ *
+ * This function adds top files of event dir to list.
+ * And all these files are created on the fly when they are looked up,
+ * and the dentry and inodes will be removed when they are done.
+ */
+int eventfs_add_top_file(const char *name, umode_t mode,
+			 struct dentry *parent, void *data,
+			 const struct file_operations *fop)
+{
+	struct tracefs_inode *ti;
+	struct eventfs_inode *ei;
+	struct eventfs_file *ef;
+
+	if (!parent)
+		return -EINVAL;
+
+	if (!(mode & S_IFMT))
+		mode |= S_IFREG;
+
+	if (!parent->d_inode)
+		return -EINVAL;
+
+	ti = get_tracefs(parent->d_inode);
+	if (!(ti->flags & TRACEFS_EVENT_INODE))
+		return -EINVAL;
+
+	ei = ti->private;
+	ef = kzalloc(sizeof(*ef), GFP_KERNEL);
+	if (!ef)
+		return -ENOMEM;
+
+	ef->name = kstrdup(name, GFP_KERNEL);
+	if (!ef->name) {
+		kfree(ef);
+		return -ENOMEM;
+	}
+
+	ef->mode = mode;
+	ef->data = data;
+	ef->fop = fop;
+	ef->dentry = NULL;
+	ef->ei = NULL;
+	ef->created = false;
+	ef->d_parent = parent;
+	list_add_tail(&ef->list, &ei->e_top_files);
+	return 0;
+}
+
+/**
+ * eventfs_add_file - add eventfs file to list to create later
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @ef_parent: a pointer to the parent eventfs_file for this file.
+ * @data: a pointer to something that the caller will want to get to later
+ *        on.  The inode.i_private pointer will point to this value on
+ *        the open() call.
+ * @fop: a pointer to a struct file_operations that should be used for
+ *        this file.
+ *
+ * This function adds top files of event dir to list.
+ * And all these files are created on the fly when they are looked up,
+ * and the dentry and inodes will be removed when they are done.
+ */
+int eventfs_add_file(const char *name, umode_t mode,
+		     struct eventfs_file *ef_parent,
+		     void *data,
+		     const struct file_operations *fop)
+{
+	struct eventfs_file *ef;
+
+	if (!ef_parent)
+		return -EINVAL;
+
+	if (!(mode & S_IFMT))
+		mode |= S_IFREG;
+
+	ef = kzalloc(sizeof(*ef), GFP_KERNEL);
+	if (!ef)
+		return -ENOMEM;
+
+	ef->name = kstrdup(name, GFP_KERNEL);
+	if (!ef->name) {
+		kfree(ef);
+		return -ENOMEM;
+	}
+
+	ef->mode = mode;
+	ef->data = data;
+	ef->fop = fop;
+	ef->dentry = NULL;
+	ef->ei = NULL;
+	ef->created = false;
+	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
+	return 0;
+}
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 6983409..7d390d2 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -47,6 +47,14 @@ struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
 struct eventfs_file *eventfs_add_dir(const char *name,
 				     struct eventfs_file *ef_parent);
 
+int eventfs_add_file(const char *name, umode_t mode,
+		     struct eventfs_file *ef_parent, void *data,
+		     const struct file_operations *fops);
+
+int eventfs_add_top_file(const char *name, umode_t mode,
+			 struct dentry *parent, void *data,
+			 const struct file_operations *fops);
+
 struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops);
-- 
2.7.4

