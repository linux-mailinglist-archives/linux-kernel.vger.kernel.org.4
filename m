Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8E8688932
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjBBVsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjBBVrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:47:43 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DF78627D;
        Thu,  2 Feb 2023 13:47:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENRfhL+H6Loax3Y7mMO1QQlXqFEZ7bgmpOP/lZsYbBNtl3WNNjjq0Cx/3Ajinu8jh5oIVIqSfL5o+vOEcKZgt1kEk/4tAhSi4Zc3M6bwGemARcKmSiB/d/+LflAvNCPHS3zCa6ntf73cOWNUEdwUUgMv4qTIa9sDt99QHNUrYQ2OwEYDB6c1eOeFdCLUs2BPqwxW2bazODV/3lwiVVyWcVDRNq85CfrYflQ6t567KdxzfTpmpu3kbOk9G+9MmLbyYx/zex2HmbUVFufYBmudjDhRMvP6C/k1fZpqlYKICF37enLjK7DFZ+Ped/1hKjRT/wrlooouOQGZEXmWUMLN0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0smFb+avJ9Wx8MwUlb3vlWOOpjCo4cU5/TxwWHUvKKU=;
 b=SO92bjjO9/tcZ4ZQVVoK0Fv+hA1oN4oTnwqP3waZrEkdY0n3tkDQqtjRGf9PG/1xwPjJA6raslJ5/g4/9pa/n37iLe2FpfLj5U+h6AjUwpz8Ac+3q5vfUfAuyDvOkesF3LS2i/8K59XCIZzgRh+n/gAKxzfYTKyNWrxnVvPw53Qu57VFq7CRWY5LuoG4MSzFqbKNrqLObms43t5wr4sjrOmbi/4WvpclieOsrn0L+QqdExye0Zv4XtaARAfHL7KAuntOnGS+YslPX7y486VTGO4PH3Bp2MW8/paE88ohi5I30AAf90dFYYnXNmWLpZT93eKpHqBGKX75DzthSx1glA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0smFb+avJ9Wx8MwUlb3vlWOOpjCo4cU5/TxwWHUvKKU=;
 b=ALeSD0xRoaohhiNwy7yIUuXH8vCuvm2ZK9iv+Ms3x/5wIKQHosrvrKn0N9QhsfRhvOQ4iYqr6nKA+Z62IoJcswuEO0kKN26BO0KFPEc+/c4wowFkiP8sE3Fey6WGOQ/qMK4D7Utkedm2frCStmc8/4okqGbXtQV0elLrZh9oXRQ=
Received: from MW2PR2101CA0007.namprd21.prod.outlook.com (2603:10b6:302:1::20)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 21:47:33 +0000
Received: from CO1PEPF00001A60.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::a0) by MW2PR2101CA0007.outlook.office365.com
 (2603:10b6:302:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.7 via Frontend
 Transport; Thu, 2 Feb 2023 21:47:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A60.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.21 via Frontend Transport; Thu, 2 Feb 2023 21:47:33 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Feb
 2023 15:47:31 -0600
Subject: [RFC v2 PATCH 6/7] x86/resctrl: Display the RMID and COSID for
 resctrl groups
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>
CC:     <babu.moger@amd.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <eranian@google.com>,
        <peternewman@google.com>
Date:   Thu, 2 Feb 2023 15:47:31 -0600
Message-ID: <167537445137.647488.9039585071837467840.stgit@bmoger-ubuntu>
In-Reply-To: <167537433143.647488.9641864719195184123.stgit@bmoger-ubuntu>
References: <167537433143.647488.9641864719195184123.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A60:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab6f7a6-91ef-40a5-60e3-08db0567178a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NPnuE0iPcCQTEWwTgu+oy4Jh+5Sa6R+vafp6fkgkdPdDZZgwAgjbDsBcmX2Ltuf9ke46yyPExxLcx86Gx3R0vlRYMMBjDjOVZ4c7ShpZ3rJmrhb0ywOcaRaauNs+fybIExHQ6Jjz4MTo6bsj3Tg5Y2/tl6QPd6PCnb1obdxQKeptaR71mTGVYX2t0fr5ZrmGq2cyY6rzfyCSN4PyT4c79HIUXMIaupTb9JMpam3EHbbpoUqsuZVKfXxSlEtWE5WgyyOewkp4z/PVTwdefj6MWlae/AROcWvdNCzZ+0f9x+3Ujm2LmyGYNjHkktcIq4n+AZb8sub2x4iYMzh0FDrSLOAPr+N+TBxtq4Ie7Y9OzJA/W6p70F7mHrQ4jJ+JyL8rG/+wvohYwPwr5eYw7+Xw3z2JzNU0Z+P5ZBZplS6NCxM7nco39Y/Tq4l8s32GBf3b0dVGhIeHFGqtjOdyit/yj4ps/ZcwSesLCVAGkle7Oda6XdOI0kxxW8YIedPYtFUJS3JAdtH6HTrkDk+FMmkFVSAQoCguNWM7/qn+Fn880/Vi9Wf+Dnnjn8CgM0CnNG/WlBph35qHhx+wB/jUvUlpD+ddAQiL+c0+W7/jI0dwjbYzA+9+g8+Pr2d5LDtp87JDWdytF7ZL6hlB3rSCDGa1ArFEIDYJ8xXqvOOIrTJjXaE5LwDtuWRgcPy60tzOpfn4hp0rRx+K8CmgOHMnknYJQ7u/rN3Y3rxBpYAW2OYlxfDYDX3tyNMkuR3hSI39ofSuAcwJpzOdUW2DnYXrFSN1FQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(7916004)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199018)(46966006)(36840700001)(40470700004)(356005)(40480700001)(36860700001)(47076005)(82310400005)(81166007)(40460700003)(82740400003)(44832011)(426003)(2906002)(8676002)(41300700001)(7416002)(4326008)(16576012)(54906003)(70586007)(316002)(110136005)(8936002)(70206006)(5660300002)(86362001)(26005)(16526019)(9686003)(186003)(478600001)(103116003)(33716001)(83380400001)(336012)(71626013)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 21:47:33.6053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab6f7a6-91ef-40a5-60e3-08db0567178a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a user creates a control or monitor group, the CLOSID or RMID=0A=
are not visible to the user. These are architecturally defined entities.=0A=
There is no harm in displaying these in resctrl groups. Sometimes it=0A=
can help to debug the issues.=0A=
=0A=
Add CLOSID and RMID to the control/monitor groups display in resctrl=0A=
interface.=0A=
=0A=
$cat /sys/fs/resctrl/clos1/closid=0A=
1=0A=
$cat /sys/fs/resctrl/mon_groups/mon1/rmid=0A=
3=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 Documentation/x86/resctrl.rst          |   17 ++++++++++++=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   44 ++++++++++++++++++++++++++++=
++++=0A=
 2 files changed, 61 insertions(+)=0A=
=0A=
diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst=
=0A=
index 2c013c5d45fd..de332c242523 100644=0A=
--- a/Documentation/x86/resctrl.rst=0A=
+++ b/Documentation/x86/resctrl.rst=0A=
@@ -321,6 +321,15 @@ All groups contain the following files:=0A=
 	Just like "cpus", only using ranges of CPUs instead of bitmasks.=0A=
 =0A=
 =0A=
+"rmid":=0A=
+        Available only with debug option.Reading this file shows the=0A=
+        resource monitoring id (RMID) for monitoring the resource=0A=
+        utilization. Monitoring is performed by tagging each core(or=0A=
+        thread) or process via a Resource Monitoring ID (RMID). Kernel=0A=
+        assigns a new RMID when a group is created depending on the=0A=
+        available RMIDs. Multiple cores(or threads) or processes can=0A=
+        share a same RMID in a resctrl domain.=0A=
+=0A=
 When control is enabled all CTRL_MON groups will also contain:=0A=
 =0A=
 "schemata":=0A=
@@ -342,6 +351,14 @@ When control is enabled all CTRL_MON groups will also =
contain:=0A=
 	file. On successful pseudo-locked region creation the mode will=0A=
 	automatically change to "pseudo-locked".=0A=
 =0A=
+"closid":=0A=
+        Available only with debug option. Reading this file shows the=0A=
+        Class of Service (CLOS) id which acts as a resource control tag=0A=
+        on which the resources can be throttled. Kernel assigns a new=0A=
+        CLOSID a control group is created depending on the available=0A=
+        CLOSIDs. Multiple cores(or threads) or processes can share a=0A=
+        same CLOSID in a resctrl domain.=0A=
+=0A=
 When monitoring is enabled all MON groups will also contain:=0A=
 =0A=
 "mon_data":=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 9b7813aa6baf..c35d91b04de6 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -760,6 +760,38 @@ static int rdtgroup_tasks_show(struct kernfs_open_file=
 *of,=0A=
 	return ret;=0A=
 }=0A=
 =0A=
+static int rdtgroup_closid_show(struct kernfs_open_file *of,=0A=
+				struct seq_file *s, void *v)=0A=
+{=0A=
+	struct rdtgroup *rdtgrp;=0A=
+	int ret =3D 0;=0A=
+=0A=
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);=0A=
+	if (rdtgrp)=0A=
+		seq_printf(s, "%u\n", rdtgrp->closid);=0A=
+	else=0A=
+		ret =3D -ENOENT;=0A=
+	rdtgroup_kn_unlock(of->kn);=0A=
+=0A=
+	return ret;=0A=
+}=0A=
+=0A=
+static int rdtgroup_rmid_show(struct kernfs_open_file *of,=0A=
+			      struct seq_file *s, void *v)=0A=
+{=0A=
+	struct rdtgroup *rdtgrp;=0A=
+	int ret =3D 0;=0A=
+=0A=
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);=0A=
+	if (rdtgrp)=0A=
+		seq_printf(s, "%u\n", rdtgrp->mon.rmid);=0A=
+	else=0A=
+		ret =3D -ENOENT;=0A=
+	rdtgroup_kn_unlock(of->kn);=0A=
+=0A=
+	return ret;=0A=
+}=0A=
+=0A=
 #ifdef CONFIG_PROC_CPU_RESCTRL=0A=
 =0A=
 /*=0A=
@@ -1844,6 +1876,18 @@ static struct rftype res_common_files[] =3D {=0A=
 		.seq_show	=3D rdtgroup_size_show,=0A=
 		.fflags		=3D RFTYPE_BASE_CTRL,=0A=
 	},=0A=
+	{=0A=
+		.name		=3D "closid",=0A=
+		.mode		=3D 0444,=0A=
+		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
+		.seq_show	=3D rdtgroup_closid_show,=0A=
+	},=0A=
+	{=0A=
+		.name		=3D "rmid",=0A=
+		.mode		=3D 0444,=0A=
+		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
+		.seq_show	=3D rdtgroup_rmid_show,=0A=
+	},=0A=
 =0A=
 };=0A=
 =0A=
=0A=

