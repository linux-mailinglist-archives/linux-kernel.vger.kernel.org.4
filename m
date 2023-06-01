Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAB071F294
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjFATCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjFATCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:02:41 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFBCE5C;
        Thu,  1 Jun 2023 12:02:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqmYZu+bCE7ysv59y8IxgXPd3zYUbXdUPZFMR8zPawyX1FtNoD/M4bj49LdoEk4/lI09yIieMsCSB/r8D5fd7YgFDBI2s3+MVTGlW4EXyyaiI3Y7tqp3d6xpdZc3CioBlu+nDj4VPMyJAUIlPhZKsLciTiioXECDAW0INLOtXOkubnTZDSXnbbevQKClo/puhqnkpANCqQh66+XAxzzXn8WHj0jHd3WJW1m1aP8eVt6MsciO49nL/5XI8Nvc4OnDkBcz2iZFKH2EShrFwo3m9gxq5Y6ac4c9OXF/JjohSLMWrVQ/Jn/M2MP6igERirCRXcgT/zPMjF85iVdXwOH2mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxBu8aT+dt1aSZHgIZBlGrThsrvlYt0Itxizp0QbX9Q=;
 b=oWzkkX/yMOH5bnzxYCzJyxLLc6UIy71hfxCB+FLqx4GATafU/vFW6DIgIaki0et/Qvy3D4I6iqTPPNVwjfxcrrcqBtoSjEuZ7Lq9GoTFQNeG/9jYLgXAy+v97IiTmeBVvv4yOe8STbKh1JaSDa9GtjmivjG3sov+XYDgVBvS4s2v3fYaGlBMYQwMc2i48koGD8R/+vG5nOJ2kSIl2JSZv5GwgW+o27LDClcCKuVjCtHEDvugXqj61zHFCH7lcywhnEA6yS1ELHohy3Xd1ieTNK7bKet7wEjuoxwjjWRL4q5ionv2L4W0ebz6pEPxtYJTiSERJ1MR62FXBpjFV2yISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxBu8aT+dt1aSZHgIZBlGrThsrvlYt0Itxizp0QbX9Q=;
 b=RAYUeuDEAp7ChCLa7YdoHHF36EJDLg1zmHpumcM/1QLJnKsQ0ozMNXYUWSILV//vh++GSocxf2DLwz0xRbEW78XtX6KFm8fPa2Vw6hpxpx7a6eYlyR+4fnaU7m1hzUzZGIXqglZdrqeIfFcjPAAyKffGfnao8P1IDn3qz4jJx1U=
Received: from BN1PR14CA0016.namprd14.prod.outlook.com (2603:10b6:408:e3::21)
 by SN7PR12MB7298.namprd12.prod.outlook.com (2603:10b6:806:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 19:02:12 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::e1) by BN1PR14CA0016.outlook.office365.com
 (2603:10b6:408:e3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 19:02:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Thu, 1 Jun 2023 19:02:12 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 14:02:09 -0500
Subject: [PATCH v5 7/8] x86/resctrl: Move default control group creation
 during mount
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>, <babu.moger@amd.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <pawan.kumar.gupta@linux.intel.com>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>, <babu.moger@amd.com>
Date:   Thu, 1 Jun 2023 14:02:01 -0500
Message-ID: <168564612103.527584.4866621411469438225.stgit@bmoger-ubuntu>
In-Reply-To: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
References: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT032:EE_|SN7PR12MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fdc22f0-fd6c-47d8-b69f-08db62d2b501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xWU+6QkMXvcP8T9IF76B5cTsBiYELsGnUtdYZG5wSrpvE/dOEyljDdDyTOMOO6sdmmVQrtLwC+78tAMSrR246Dgc4pEwNbIAENWeWwx+j+naFcfdjHBzZfzhEgYwsM8RnEMFeKgWxOrkwbcsnXXgZbRMhvfIlhlqV2Z0zz7lW+kY6M/UprLn9Ml9D3p3hS+ldboojTSFR3A2VfFj0vbCQUqr5VmgDsMTuvxQkqUdxwgRcPRRiBgiThMFzzAUzn722IvdDW0PeQvXBo569rOwDk3JM3JHjTo5r8EyfU16RPwHUicOYZhTU+bRc1znqHXOD/U/QFmdaGlxOkWSmEjPgNE9h21UWmDmt76t82wykZCH+H2OdbV1UsnoLKcaIC/J/iSySITT4vqW88I5QVD7sFWVMkX0hLB+4DqDYmFsZbolrGiMOJ+mJ3/tjY2XpWZPJ5L13aE+NFJtItvixEoTy5gu80jihz23LIWv0n4tYY70PF9IaG+76KXZ9rX+1c3KTReSrM2yLGnm3DYSinHCBNwBdf3kW12jvg712DavjIVuoZFvBQxHXWjNp0aRkcTbFNAtyfoKpyWggm+l/uusiO9RaeIUG+sJhHoyRQYZ0C6BCktTdkbYenkF2wHSrgRZfrPmh3mNjSsAYYpRyVEo5LwbgYPX/bPLydxzCcn+a7N+wnX15QrbfMw+eJDdKJPFpZ/yF91kO66Cjl4VG35V/b91cUmd9VzrgyQ635hZPTP3wtVCCkRjBRE4JBTSuoi/gIpH4No5JtaSd2nFMd2fg8Tl9KoNeokcAMA2/KwI4jM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(40470700004)(36840700001)(46966006)(81166007)(2906002)(33716001)(16526019)(336012)(356005)(86362001)(82310400005)(41300700001)(8936002)(186003)(8676002)(82740400003)(478600001)(426003)(26005)(110136005)(16576012)(9686003)(54906003)(6666004)(316002)(103116003)(47076005)(7416002)(83380400001)(70586007)(70206006)(7406005)(4326008)(36860700001)(44832011)(5660300002)(40460700003)(40480700001)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 19:02:12.1093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdc22f0-fd6c-47d8-b69f-08db62d2b501
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7298
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the resctrl default control group is created during kernel=0A=
init time and rest of the files are added during mount. If the new=0A=
files are to be added to the default group during the mount then it=0A=
has to be done separately again.=0A=
=0A=
This can avoided if all the files are created during the mount and=0A=
destroyed during the umount. Move the default group creation in=0A=
rdt_get_tree and removal in rdt_kill_sb.=0A=
=0A=
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   59 ++++++++++++++++------------=
----=0A=
 1 file changed, 30 insertions(+), 29 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 2f5cdc638607..e03cb01c4742 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -57,6 +57,7 @@ static char last_cmd_status_buf[512];=0A=
 struct dentry *debugfs_resctrl;=0A=
 =0A=
 static bool resctrl_debug;=0A=
+static int rdtgroup_setup_root(void);=0A=
 =0A=
 void rdt_last_cmd_clear(void)=0A=
 {=0A=
@@ -2515,13 +2516,6 @@ static int rdt_get_tree(struct fs_context *fc)=0A=
 =0A=
 	cpus_read_lock();=0A=
 	mutex_lock(&rdtgroup_mutex);=0A=
-	/*=0A=
-	 * resctrl file system can only be mounted once.=0A=
-	 */=0A=
-	if (static_branch_unlikely(&rdt_enable_key)) {=0A=
-		ret =3D -EBUSY;=0A=
-		goto out;=0A=
-	}=0A=
 =0A=
 	ret =3D rdt_enable_ctx(ctx);=0A=
 	if (ret < 0)=0A=
@@ -2535,9 +2529,15 @@ static int rdt_get_tree(struct fs_context *fc)=0A=
 =0A=
 	closid_init();=0A=
 =0A=
+	ret =3D rdtgroup_add_files(rdtgroup_default.kn, RFTYPE_CTRL_BASE);=0A=
+	if (ret)=0A=
+		goto out_schemata_free;=0A=
+=0A=
+	kernfs_activate(rdtgroup_default.kn);=0A=
+=0A=
 	ret =3D rdtgroup_create_info_dir(rdtgroup_default.kn);=0A=
 	if (ret < 0)=0A=
-		goto out_schemata_free;=0A=
+		goto out_default;=0A=
 =0A=
 	if (rdt_mon_capable) {=0A=
 		ret =3D mongroup_create_dir(rdtgroup_default.kn,=0A=
@@ -2587,6 +2587,8 @@ static int rdt_get_tree(struct fs_context *fc)=0A=
 		kernfs_remove(kn_mongrp);=0A=
 out_info:=0A=
 	kernfs_remove(kn_info);=0A=
+out_default:=0A=
+	kernfs_remove(rdtgroup_default.kn);=0A=
 out_schemata_free:=0A=
 	schemata_list_destroy();=0A=
 out_mba:=0A=
@@ -2664,10 +2666,23 @@ static const struct fs_context_operations rdt_fs_co=
ntext_ops =3D {=0A=
 static int rdt_init_fs_context(struct fs_context *fc)=0A=
 {=0A=
 	struct rdt_fs_context *ctx;=0A=
+	int ret;=0A=
+=0A=
+	/*=0A=
+	 * resctrl file system can only be mounted once.=0A=
+	 */=0A=
+	if (static_branch_unlikely(&rdt_enable_key))=0A=
+		return -EBUSY;=0A=
+=0A=
+	ret =3D rdtgroup_setup_root();=0A=
+	if (ret)=0A=
+		return ret;=0A=
 =0A=
 	ctx =3D kzalloc(sizeof(struct rdt_fs_context), GFP_KERNEL);=0A=
-	if (!ctx)=0A=
+	if (!ctx) {=0A=
+		kernfs_destroy_root(rdt_root);=0A=
 		return -ENOMEM;=0A=
+	}=0A=
 =0A=
 	ctx->kfc.root =3D rdt_root;=0A=
 	ctx->kfc.magic =3D RDTGROUP_SUPER_MAGIC;=0A=
@@ -2845,6 +2860,9 @@ static void rdt_kill_sb(struct super_block *sb)=0A=
 	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);=0A=
 	static_branch_disable_cpuslocked(&rdt_mon_enable_key);=0A=
 	static_branch_disable_cpuslocked(&rdt_enable_key);=0A=
+	/* Remove the default group and cleanup the root */=0A=
+	list_del(&rdtgroup_default.rdtgroup_list);=0A=
+	kernfs_destroy_root(rdt_root);=0A=
 	kernfs_kill_sb(sb);=0A=
 	mutex_unlock(&rdtgroup_mutex);=0A=
 	cpus_read_unlock();=0A=
@@ -3598,10 +3616,8 @@ static struct kernfs_syscall_ops rdtgroup_kf_syscall=
_ops =3D {=0A=
 	.show_options	=3D rdtgroup_show_options,=0A=
 };=0A=
 =0A=
-static int __init rdtgroup_setup_root(void)=0A=
+static int rdtgroup_setup_root(void)=0A=
 {=0A=
-	int ret;=0A=
-=0A=
 	rdt_root =3D kernfs_create_root(&rdtgroup_kf_syscall_ops,=0A=
 				      KERNFS_ROOT_CREATE_DEACTIVATED |=0A=
 				      KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,=0A=
@@ -3618,19 +3634,11 @@ static int __init rdtgroup_setup_root(void)=0A=
 =0A=
 	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);=0A=
 =0A=
-	ret =3D rdtgroup_add_files(kernfs_root_to_node(rdt_root), RFTYPE_CTRL_BAS=
E);=0A=
-	if (ret) {=0A=
-		kernfs_destroy_root(rdt_root);=0A=
-		goto out;=0A=
-	}=0A=
-=0A=
 	rdtgroup_default.kn =3D kernfs_root_to_node(rdt_root);=0A=
-	kernfs_activate(rdtgroup_default.kn);=0A=
 =0A=
-out:=0A=
 	mutex_unlock(&rdtgroup_mutex);=0A=
 =0A=
-	return ret;=0A=
+	return 0;=0A=
 }=0A=
 =0A=
 static void domain_destroy_mon_state(struct rdt_domain *d)=0A=
@@ -3752,13 +3760,9 @@ int __init rdtgroup_init(void)=0A=
 	seq_buf_init(&last_cmd_status, last_cmd_status_buf,=0A=
 		     sizeof(last_cmd_status_buf));=0A=
 =0A=
-	ret =3D rdtgroup_setup_root();=0A=
-	if (ret)=0A=
-		return ret;=0A=
-=0A=
 	ret =3D sysfs_create_mount_point(fs_kobj, "resctrl");=0A=
 	if (ret)=0A=
-		goto cleanup_root;=0A=
+		return ret;=0A=
 =0A=
 	ret =3D register_filesystem(&rdt_fs_type);=0A=
 	if (ret)=0A=
@@ -3791,8 +3795,6 @@ int __init rdtgroup_init(void)=0A=
 =0A=
 cleanup_mountpoint:=0A=
 	sysfs_remove_mount_point(fs_kobj, "resctrl");=0A=
-cleanup_root:=0A=
-	kernfs_destroy_root(rdt_root);=0A=
 =0A=
 	return ret;=0A=
 }=0A=
@@ -3802,5 +3804,4 @@ void __exit rdtgroup_exit(void)=0A=
 	debugfs_remove_recursive(debugfs_resctrl);=0A=
 	unregister_filesystem(&rdt_fs_type);=0A=
 	sysfs_remove_mount_point(fs_kobj, "resctrl");=0A=
-	kernfs_destroy_root(rdt_root);=0A=
 }=0A=
=0A=

