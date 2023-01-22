Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0C86770E2
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 18:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjAVRHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 12:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjAVRHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 12:07:35 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11012003.outbound.protection.outlook.com [52.101.63.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C4F21948;
        Sun, 22 Jan 2023 09:07:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMlM5ZrLeI3JU68X3ESZYGy2+UMF8XKdydYvGWGkIvM0pIwO9BgMlsnjvmb39/qVjdUxml1EnQu66d2gIYJ6y7VkyX2O5NZF4CJaCu4u79AM1x18hkiaIjd4TVcwaKIp9OyAo+FtYASMYfjgAk/XIQ/9eSIzh2I+7iwCBkMXDvYr/Tqm2uKS/6KZ0QmuM//LtdDk99shbr6eDKXe6srAmKfV/SpE1T92Cf+CcMUBiGGGFCGArGhbHCHtDGzj2cUwc0WaMe0IXzl51OUBcE4nFVKtpo5pAcb0x71sxR9dnh+YaL669wK2xMgrwWalZuW3fnfoELEk9oPII5gN57cUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nsgy9MSvqSmYf0Yl6yn9+RruwGgucaqbm0UKDXWEAos=;
 b=DyvtF0vaqRqIGLYg/PkZdQ/yQiJDJQQg1dixjPp6Zyl/Oe5yueNDVAs6L3fKUFrqlOptnEiSxin3msK4PhnyH4gb6vM4JyjgrCXhPoyiLS73/T++BrCIzE3c66mSOr8fDuR7ECnNWn9ATEq4YBD/gOFZOuIx3v+GlMwVuyyQWfztNIg1/ZojySJcRy2zbxm+Wg7A+226vpYwZlJJazD87TjZu1m8nNr/0DIQH7gVQdcVOrMv3anAyHH7mAtot0RD3T0CVLKn4CojVYPOH2n7uNhL2pBIODC+AQNoBr45TOlh/KVUUoXsOc3XcC58DA7eZxkh23h+X0RINzMp5VWIYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nsgy9MSvqSmYf0Yl6yn9+RruwGgucaqbm0UKDXWEAos=;
 b=PA5UDriVn8EMBePaWeuGVhloRzUPBB6yKnT/qToedW7nb1tBieI3kRnu3MLOhvDpbqkdn2fsU4oBfI57KtuO4qFnYeiVBsBHwIhJwuFuZVt+04kRuF5GEWeie112p8Sn3zMIJ2r4XCr2VZFmtPP0S82bzPNn7w3A/2PnEpi/eak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MW4PR05MB9322.namprd05.prod.outlook.com (2603:10b6:303:1ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Sun, 22 Jan
 2023 17:07:30 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::e710:a9a8:3bc8:d0b0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::e710:a9a8:3bc8:d0b0%3]) with mapi id 15.20.6002.031; Sun, 22 Jan 2023
 17:07:29 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        chinglinyu@google.com, namit@vmware.com, srivatsab@vmware.com,
        srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH 1/8] eventfs: introducing struct tracefs_inode
Date:   Sun, 22 Jan 2023 22:37:00 +0530
Message-Id: <1674407228-49109-1-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:a03:332::19) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|MW4PR05MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f133675-de79-4b42-7d08-08dafc9b24bb
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: STg34hM8EOLTC20C+wUrIZv6NYCaKwT9Bv67CeMEtxwf2FzflHetm5KRuCjmjBjqJJWWR9mXR5aA99xAySTRexizmgFYAaUdqxig1h0oTGwuRKw4dk+sF6LV+UtPAKu3D/m63GTerVGtCJFvN1KgY85EQbq9HtkhtyfErK1wvxiWuoATqgv3wOgkJeiYR9IBvvDXsztjNipihLPuxafiSzsFQhjssbS1hyQjY8nz5itoPjwtBHa+siWaTh46WhEH6xOvhWZYEjsA3TEL2g+9hKPJ2eEQkKtF7rYYOwwyc4gzYidkddZ0y5vxgIqwAhu4KgWIN5BmxK2u5uZBiow7y0rIRko05lgk7CTNZR3Su1jMDIi97o54vX7n/70lUTCFM4K+ApjkfIRKIhDiKPkLK+ya33rSh/r9SFHyEmcqhzppxPBpkb7FpTntNErB23MTAhyskqOJO66KjMLKNvNABE06vcxi5EKXU0puvsSNKBuglRrIQXNRX5wMrp+ri1E6Ybp/UzuTggdBFMt4P93IrmtXB/zdjT6u+0S2nEFZ4OjwGkiXimxBR4s/6sNbX8gfEAqJffr95UukK+iNezRHrSnQXa3dEN+a5X9nMFE0LDNdXY7DXU+czctN2dLjCraaEzmajd2SuI0/R4Qk/5MJnviOC0nIErvjdwfnaxoZummkPnDRUpOPUfc35i3yw/6Oz8nOK4D2NRIguFJsIE3j9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199015)(36756003)(8676002)(478600001)(2616005)(4326008)(66556008)(66476007)(6512007)(41300700001)(186003)(66946007)(26005)(2906002)(86362001)(83380400001)(6506007)(107886003)(316002)(6666004)(52116002)(6486002)(5660300002)(8936002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nSOmtP2Oak5uvklnn2QIgABqxncSYziUtuLFsKTW7lbPWjDR/Qh4VURlq77C?=
 =?us-ascii?Q?iJppAy0T4kWFIlhNOGFvYXh1Ajq/qnXaMug2opFrrcYPQU3trxFSw3DAylND?=
 =?us-ascii?Q?ic2jv/XvstRp708wZDbtoRIiuu8V3sTMG2ySKWjbvlNQOCz0c/oJqFNviGs+?=
 =?us-ascii?Q?bmYDBWwkLWxPImKR+AiLfw9wGGI4Zva6AeBECDBzL8n4/m8ZeG0KNEozZdw9?=
 =?us-ascii?Q?OlB3Nvy9vCkKcZQPufOedun9Rq5TBJxKdwKARNe2GaVHJAU7Ykg9IAqkz1Sc?=
 =?us-ascii?Q?XXMdd2DVOlfWjRWG7pYLqJZP9+6zwruaC7nHhEYGeYOrvMcUjGBqBhFBBiJL?=
 =?us-ascii?Q?A0LhDwX2T1+cslegec5qW4twelLchxAoUbwpCtZUTIS0pLoGa71kA9EBrQY4?=
 =?us-ascii?Q?HBNojJ0C1grtoxv5Brs0OSGeoQA6zGUTbgWqFV0JsDaxdAGtTDGmbBg0nelq?=
 =?us-ascii?Q?vGpdeI56d1PLH2aYpk1VI1G9cWsZJT3Iqm81MAksAftxWVZmz3kHQfPd401X?=
 =?us-ascii?Q?wlTCWb46LBJMkBVpdGPNnrm0IDN+dorSXTKjZI3jQee1nsPQCXhBYNBZwBD0?=
 =?us-ascii?Q?K8T169am1Wt89zHW0++OhHRm8y/8g6/Zy3qsNmg7N/WucfDh5c7CCikwJosd?=
 =?us-ascii?Q?Nin6a28Yh6uSPqvPeWHreCLdovXT3ZUs0zPtlnJs4ZXhaWlUAC6BoJghWVuS?=
 =?us-ascii?Q?HeamrztNDzbAXFASQo3dGwIJyL9JYl7s0JMblsdm594sf6HYHew9ZtMjrLav?=
 =?us-ascii?Q?MNPn/ggjmyebFYaWGALaz7vezD2oiuMi+tQdBj7CVwh1t5WfvGq4lEPHXeEb?=
 =?us-ascii?Q?Ca9XYTuncnO/IX4Z4CV9zKhApMV/W7D2d++KF7RgmYgMB5XGLuO0/5FNjuZq?=
 =?us-ascii?Q?injcqnfqXJrDyDjZjCFHRRLJ08yJCdW5z4Oags1Su4st9yjnS4bZqRWN9yv8?=
 =?us-ascii?Q?kXuAn346KTCFQqna8knhIB8UJfRsa0PfUzAveHbZs661ERcmkWwZZy1ghxqr?=
 =?us-ascii?Q?tEQgNDPpPfgBuNmK1ERMsNZIJEOOgKCYG3VzgP9lF6uMJfQmrjC4tr9Oinmg?=
 =?us-ascii?Q?NiTogwYTLeNg+98aJIn0Kt/SCTFyqcMwoW7i3YN/7GYWv2CEkdUQb4TO083P?=
 =?us-ascii?Q?npazv2weZ7r3ObLZIi4K9d+WuKol7RGV0l009rJpLAlzyXXYKEcdeSNfkm6i?=
 =?us-ascii?Q?DmN2iZFB4KWhQ8HjuMo41gDnEcAqgrCLDBzegaP5ZyBEK6I9SZEWDrlud3sw?=
 =?us-ascii?Q?3byoRScNJzLd4gMMi07gGrPCsy2ypszHaVAgwMBqD0VP0QTpT94/KcnFL3Mf?=
 =?us-ascii?Q?O/qiOkbLVkPx+IkJC42v++vej77tdaE+RA7Npo4mnE/r8HTNlPdcvSaWuAyW?=
 =?us-ascii?Q?GqAg1q1GWSLJzTvDRDYDUdjQ/DCoDFOBhxd0MAtQ7VFVVy01w6f8tVxrp19m?=
 =?us-ascii?Q?qgBfomjHtv5zX2AnjBEx9YW2AWir4hhvK0UtHKhS9bZSvTCouk0hScq4nSr7?=
 =?us-ascii?Q?YYxFh3sXpqvnOde/kKca2+LMbjwKh9cS0p7S3lMJ7ugW78sJyTrFqKrmf4wh?=
 =?us-ascii?Q?z55CO0FQc/Blpk6M7vHk2G86cviXTa9iHpOCe2Z/?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f133675-de79-4b42-7d08-08dafc9b24bb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2023 17:07:29.4774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmGo+efjmdmrSmjnQ8iM4SbKRa750WIIbRKkCako6Yny0J7JXr0+kTgYTuCpIL25jgPOSlHlPoI+HFG6NhbD9g==
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

Introducing tracefs_inode structure, this will help eventfs
to keep track of inode, flags and pointer to private date.

Renaming, removing static property from some function name.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/inode.c    | 20 ++++++++++----------
 fs/tracefs/internal.h | 25 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 10 deletions(-)
 create mode 100644 fs/tracefs/internal.h

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index da85b39..015b7b8 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -127,7 +127,7 @@ static const struct inode_operations tracefs_dir_inode_operations = {
 	.rmdir		= tracefs_syscall_rmdir,
 };
 
-static struct inode *tracefs_get_inode(struct super_block *sb)
+struct inode *tracefs_get_inode(struct super_block *sb)
 {
 	struct inode *inode = new_inode(sb);
 	if (inode) {
@@ -399,7 +399,7 @@ static struct file_system_type trace_fs_type = {
 };
 MODULE_ALIAS_FS("tracefs");
 
-static struct dentry *start_creating(const char *name, struct dentry *parent)
+struct dentry *tracefs_start_creating(const char *name, struct dentry *parent)
 {
 	struct dentry *dentry;
 	int error;
@@ -437,7 +437,7 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 	return dentry;
 }
 
-static struct dentry *failed_creating(struct dentry *dentry)
+struct dentry *tracefs_failed_creating(struct dentry *dentry)
 {
 	inode_unlock(d_inode(dentry->d_parent));
 	dput(dentry);
@@ -445,7 +445,7 @@ static struct dentry *failed_creating(struct dentry *dentry)
 	return NULL;
 }
 
-static struct dentry *end_creating(struct dentry *dentry)
+struct dentry *tracefs_end_creating(struct dentry *dentry)
 {
 	inode_unlock(d_inode(dentry->d_parent));
 	return dentry;
@@ -490,14 +490,14 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	if (!(mode & S_IFMT))
 		mode |= S_IFREG;
 	BUG_ON(!S_ISREG(mode));
-	dentry = start_creating(name, parent);
+	dentry = tracefs_start_creating(name, parent);
 
 	if (IS_ERR(dentry))
 		return NULL;
 
 	inode = tracefs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
-		return failed_creating(dentry);
+		return tracefs_failed_creating(dentry);
 
 	inode->i_mode = mode;
 	inode->i_fop = fops ? fops : &tracefs_file_operations;
@@ -506,13 +506,13 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	inode->i_gid = d_inode(dentry->d_parent)->i_gid;
 	d_instantiate(dentry, inode);
 	fsnotify_create(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return tracefs_end_creating(dentry);
 }
 
 static struct dentry *__create_dir(const char *name, struct dentry *parent,
 				   const struct inode_operations *ops)
 {
-	struct dentry *dentry = start_creating(name, parent);
+	struct dentry *dentry = tracefs_start_creating(name, parent);
 	struct inode *inode;
 
 	if (IS_ERR(dentry))
@@ -520,7 +520,7 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
 
 	inode = tracefs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
-		return failed_creating(dentry);
+		return tracefs_failed_creating(dentry);
 
 	/* Do not set bits for OTH */
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUSR| S_IRGRP | S_IXUSR | S_IXGRP;
@@ -534,7 +534,7 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
 	d_instantiate(dentry, inode);
 	inc_nlink(d_inode(dentry->d_parent));
 	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return tracefs_end_creating(dentry);
 }
 
 /**
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
new file mode 100644
index 0000000..27869ea
--- /dev/null
+++ b/fs/tracefs/internal.h
@@ -0,0 +1,25 @@
+#ifndef _TRACEFS_INTERNAL_H
+#define _TRACEFS_INTERNAL_H
+
+enum {
+	TRACEFS_EVENT_INODE     = BIT(1),
+};
+
+struct tracefs_inode {
+	unsigned long           flags;
+	void                    *private;
+	struct inode            vfs_inode;
+};
+
+static inline struct tracefs_inode *get_tracefs(const struct inode *inode)
+{
+	return container_of(inode, struct tracefs_inode, vfs_inode);
+}
+
+struct dentry *tracefs_start_creating(const char *name, struct dentry *parent);
+struct dentry *tracefs_end_creating(struct dentry *dentry);
+struct dentry *tracefs_failed_creating(struct dentry *dentry);
+struct inode *tracefs_get_inode(struct super_block *sb);
+
+#endif
+
-- 
2.7.4

