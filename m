Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7EC6770E8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 18:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjAVRIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 12:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjAVRHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 12:07:50 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11012002.outbound.protection.outlook.com [52.101.63.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ABEEFB0;
        Sun, 22 Jan 2023 09:07:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sx+c8KvKmtm6widRcvLyOr1nmSuPNrIoLAgZUvHLF4j3JtrBOWu6LfDz6ZGm7Ns+Oi0onblXCVikp3GD8hldOAJj7i/nTJylUx4pj5X0o3CsUF8QEUIOI+zWOL5X/PmTQWGRUD2iFp/vFU86sV2b2XKbdasA7vkIz13g54BMOkP2ZANcfF0tLeRXYZ9ZWFdBG/CaL10MeO9HN5d4u7BCezc8cs2X5m8Ix/6Ra+RPScL+LWNVGptVWGl4OqKRuZQ3w/87rWyNy14Xxc7iyIG7BEsHsO5YZgPAPndOEk8IGi64q/pfv/eKjxq+hmjoP+MdL8/MW2iTr0snC0oKmIHGGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIBdJsxCUmdswEgQ7f80fp1KQeiWBLq6UZqSGbOF+LY=;
 b=oT2VkxlTKa36ZEyg5ApYT2ifUpk0YgSVtORlj3nDA9hzEPVEjFEbhCXx2KLgfdB7ctpzJodWwhnY7ss+DlpGviuRCWmMS6jN/gVXsTN/l+BLGiMf2EL2FIdKzdXEtra0noMQBP7Sk3K9Vx/zfb2cHGOqXeCIgJtznLKwDANVUGAValBCEt4T3cQTQwAVPTtGNw9V4B09FXzjWx6QcrWgDbPCYWKVFogk9qw4fw71lF/QSY1ONB5i2XEStvO7FLjQxVUG3uWtwNRe4TfpLWtlD+1YO8sfEcA8MKUC/8mJo79gZ3Lt4T2fwRznC7UYzdAC3/UiZGarsGjNTJcQyrmROw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIBdJsxCUmdswEgQ7f80fp1KQeiWBLq6UZqSGbOF+LY=;
 b=09QMIGI+ojFBRbw3ZRg35HZ4Xg4xZCqmgswhBHxH+I/V7I09dX+Vdj+ZZvP8vZjpxwmqmXVMEwpYHonpaWuX3idTdekhcH6dGgesj3TtNxd965nf7yaAc6fyQRu6SaNx8wOU60X87jEYM+Q1YOgP9Z9y8lgRAU/H/zep3F+XHBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MW4PR05MB9322.namprd05.prod.outlook.com (2603:10b6:303:1ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Sun, 22 Jan
 2023 17:07:36 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::e710:a9a8:3bc8:d0b0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::e710:a9a8:3bc8:d0b0%3]) with mapi id 15.20.6002.031; Sun, 22 Jan 2023
 17:07:36 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        chinglinyu@google.com, namit@vmware.com, srivatsab@vmware.com,
        srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH 7/8] eventfs: creating tracefs_inode_cache
Date:   Sun, 22 Jan 2023 22:37:06 +0530
Message-Id: <1674407228-49109-7-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 98364896-cc4b-41fb-0dfb-08dafc9b28ce
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/Otofv8srmNB6hAW+otLKZ9CNNe9GeVnkUPzYx1kWcj/730/8REwJLJ1TXfpkr0/HXRqCocUK8d92ouI8moD/vAmhDBTk1JSKbzpe7rPvY/Us2c9SoizY7P3QXVeB6hKvlbZvXCEYrBDEv4YG9j4cAsx4bLNwPV2WMw0Wu8VCRkhnW0+0olRFaRi9UNUNsXaApFYPByjn4gZB/bvJkkFH2trcmmJ4lK9ZHFNVux0FcyMBI7xmBisBXLESQpvhgXAfkYTUEYtguxNDOi5ii0ybIQfio63Xh253GtoXNmkIdycolESZYynTJ3UsBN9dyUXlponlZtB8rS5kqyGGMZq7RIb7bCDdBmbl2KqT084rC6WRFRMXDWn1ojcRR+vmohfKx7W/DvbnGPy+NPx8Qv6OJd4fcM/eEZgPSDoAI0fiLcTh4u7Q4DQoOztYrB1vHl+vobyqugLYkk0nLD9JCB8jMv5l6rmBHY8uKmAeEc7bYd8Oo6CAX4MVT+lHgWBjnhRMjv8+rCZTWfCs83p1nFgiErxJav2LK4Mg32c2uJVjiiZNBJ28+mPfGDFnd5neDqcwBteTOzaiBTYwjYuCaz4Qd23JtZI5uwweGSOgYQK5drueLR6xnSCXXENaPN8twrCO5O3N8oYPRBaks4sTr6Jqto7DS+tm4EBkxyYWpChL5HqqOrYC+pF+g9eqSTbBPgl9tQ1V/Bn04LSTzQQAomQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199015)(36756003)(8676002)(478600001)(2616005)(4326008)(66556008)(66476007)(6512007)(41300700001)(186003)(66946007)(26005)(2906002)(86362001)(83380400001)(6506007)(107886003)(316002)(6666004)(52116002)(6486002)(5660300002)(8936002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sHMVVb0uCUTVVdiTVJd6RJjbsjo748lDlpoBuWEUunIgpNVfjtfkNHHb27AS?=
 =?us-ascii?Q?2nU0qA2ZI2kZ4rZ4O5ESgwT7GPQEdnkg8ABNIA7/0qRfVHgyW8DNpmU8fbA5?=
 =?us-ascii?Q?8rgtoTTMXqLBPnHma4aJB5vQnABM7XbhwvdKkjJELHuzkdlqS7Rf247MlAWG?=
 =?us-ascii?Q?+FFuWKtYrsIXjcI/fxgnUsG0uwtCmBQuKm8epxoJGzFDYUDVyaA1Lvn4+WeB?=
 =?us-ascii?Q?9YIUUTNUeHvDHZWdC+omKnNlmjIumczjbrVdCAET8PrtL1gOyOU+PaRKONDO?=
 =?us-ascii?Q?OxHW49MatAvZ04RrDX924vnzzO6zz/OwZipTkqwUZ3ObIUQ9OG4hruZAhkOT?=
 =?us-ascii?Q?RxDtWQ6UC7oYBs4OlZ9zU3Yq3MhEmhFQmue7a17L3jSHTqCcXEmjNd/YewES?=
 =?us-ascii?Q?485WArv5ORxoh+Ik4H/XQpjZRdemggjKd8acVW3u5PBGbzb9Y/OgaXTI/uNl?=
 =?us-ascii?Q?inDekRkYNlcb3MczPYLFXM9Jl3V8dkWIGBIX6BtHHFutjYQi3PrVfeH3AGk/?=
 =?us-ascii?Q?Xr9IzbP2oYzgLqjPnfcfDlWhXa/aBc5dnIO1npIuddL89vSJJqTQ6NTaxikA?=
 =?us-ascii?Q?7fte7/EDUewWKXYycxBiVXEBdfoUcVBbWgMYB1gTNKXa4Mx1rvdjeJp/KcNA?=
 =?us-ascii?Q?B+StdURFu0fJOj10g0bVZ2ZfiXQwulikE3+kHrK0ufl8ujAh9xBm4Zeedr5B?=
 =?us-ascii?Q?twtBkATlLduLdLHWym2ty3ynmFTKoHWZ2JLEHltJZrHSWUHo474qYhnglTHJ?=
 =?us-ascii?Q?mKUy0pxr62CnZx56FPBtSXAsJf2h6dYsJB+Ias+lkwP+r9ot21pP57xVNTIr?=
 =?us-ascii?Q?mKvYXBehXFTRy9qTcrgYQwcNwT+R5dgDB9UCSR7zZRAEx1EKOpHUNP7y/1jW?=
 =?us-ascii?Q?4J56Tjqdombzj7T9DizQP/a76oNfbBYCowMon1oSsJ94F1hRLQxYyWF7SFh+?=
 =?us-ascii?Q?HF3ojgClztba2ZSGCuCtvMBcAAAuGZMLaC+8An3XUQtxQyl5x/pZze/7v28r?=
 =?us-ascii?Q?J/tINOJSIZOJJIR/c6BOKObK02VB+c0e+9eYO6SFsH8wAykwIdWnA8844I5z?=
 =?us-ascii?Q?lcBv9wEAGPmmVSTXuMXBFMDibyVotKkxscZ/MMrPI6+kFXwXPObTDTthEYzi?=
 =?us-ascii?Q?6kFwUGfUMFIGilus8i5fG9JwfgkPChoZmvJ9B8Msrpfqc+9vhiEHltRvOt5m?=
 =?us-ascii?Q?kNjMfWMH7YzsXR4Yy1/TWAHRbgRq8KqphmISCl6fvmUvOSQ4HdUSI1mbi39l?=
 =?us-ascii?Q?BYMRUTEH6j0adfNf8F5NWt8ypfgCIU2rQW3AYOlsFYl/5EFo6NIi/baV+rob?=
 =?us-ascii?Q?+NrV1SiXXkHyToqh0GNDOYe94jOorwfFTW0nYR+de5q9w9ZgeF5Pz8VXPYcB?=
 =?us-ascii?Q?T4XtRBBwe+tJZJtetgECHvhNcNzlkSYdjXdPhfs1RXJWeFiprVynHevqAoX+?=
 =?us-ascii?Q?SMxS6vAMTurQza98P3FjHzG+MkfzEUI7UPoHMNaM8k3iEzl1wJw8ffMbaOGR?=
 =?us-ascii?Q?wX0sfd4X5Tzh+NPv9aRY/DSOiP5oWKa3eLa/KjaCmuOiRNjQh/LsEwHJKDEX?=
 =?us-ascii?Q?j8G+WKejYaIsBFQHXBOfExiea+dKm/QiJgyatxJZ?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98364896-cc4b-41fb-0dfb-08dafc9b28ce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2023 17:07:36.2319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuREX2HtdDCE2JMoM/5Bfi/p68W0poRGWYpLumIMFAzElM+2tjZjzRlfs6uZLr5aHnVVs/5vbwDBeO5p3hDP7A==
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

Creating tracefs_inode_cache which is a cache of tracefs_inode.
Adding helping functions:
tracefs_alloc_inode()
tracefs_free_inode()

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/inode.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 6d950d1..8fdbd81 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -21,13 +21,33 @@
 #include <linux/parser.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
+#include "internal.h"
 
 #define TRACEFS_DEFAULT_MODE	0700
+static struct kmem_cache *tracefs_inode_cachep __ro_after_init;
 
 static struct vfsmount *tracefs_mount;
 static int tracefs_mount_count;
 static bool tracefs_registered;
 
+static struct inode *tracefs_alloc_inode(struct super_block *sb)
+{
+	struct tracefs_inode *ti;
+
+	ti = kmem_cache_alloc(tracefs_inode_cachep, GFP_KERNEL);
+	if (!ti)
+		return NULL;
+
+	ti->flags = 0;
+
+	return &ti->vfs_inode;
+}
+
+static void tracefs_free_inode(struct inode *inode)
+{
+	kmem_cache_free(tracefs_inode_cachep, get_tracefs(inode));
+}
+
 static ssize_t default_read_file(struct file *file, char __user *buf,
 				 size_t count, loff_t *ppos)
 {
@@ -346,6 +366,9 @@ static int tracefs_show_options(struct seq_file *m, struct dentry *root)
 }
 
 static const struct super_operations tracefs_super_operations = {
+	.alloc_inode    = tracefs_alloc_inode,
+	.free_inode     = tracefs_free_inode,
+	.drop_inode     = generic_delete_inode,
 	.statfs		= simple_statfs,
 	.remount_fs	= tracefs_remount,
 	.show_options	= tracefs_show_options,
@@ -675,10 +698,26 @@ bool tracefs_initialized(void)
 	return tracefs_registered;
 }
 
+static void init_once(void *foo)
+{
+	struct tracefs_inode *ti = (struct tracefs_inode *) foo;
+
+	inode_init_once(&ti->vfs_inode);
+}
+
 static int __init tracefs_init(void)
 {
 	int retval;
 
+	tracefs_inode_cachep = kmem_cache_create("tracefs_inode_cache",
+						 sizeof(struct tracefs_inode),
+						 0, (SLAB_RECLAIM_ACCOUNT|
+						     SLAB_MEM_SPREAD|
+						     SLAB_ACCOUNT),
+						 init_once);
+	if (!tracefs_inode_cachep)
+		return -ENOMEM;
+
 	retval = sysfs_create_mount_point(kernel_kobj, "tracing");
 	if (retval)
 		return -EINVAL;
-- 
2.7.4

