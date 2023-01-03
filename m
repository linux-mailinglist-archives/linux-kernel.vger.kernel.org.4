Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5185165C92E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 23:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbjACWHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 17:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238527AbjACWHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 17:07:10 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A487D15FED;
        Tue,  3 Jan 2023 14:07:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPzJYiRuuHQpXNxujpGY89+LiQRfLvnczRqPxhKOPIka3zEku98MatPU/ampy9wOw8rVjTfGf5jHO2WTfZXS7ARM+qOrJGut7OC7BbTYkfDkF8KOxFxZ6QhSrPHCOfuKQkQyFlFKlxJGU9jExkGuToCqvYu99e2IRh5kc/iqSFP/7BcIkb/ttPPJT7FG8GaY5RexjOv+auQ6BO/FveAx5ojhsSIvvfIvNEzqFf1NUflixtqXDdFJMq1t229KKMo0MM0aHgtRT5JxIs3/6cVO14Qmwevvy+JQMzMzk6Vjl1TlSMma276GE0QFfCuqaqrBKiXn7EI9t5u3A0Vrq4ymXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7qtJrEoGp8AP6Vo7LCbs2EEQvG7I8yvIULPC360r3w=;
 b=XcXYR1JXQ+QGrMFpgJ0gvTNKAg0h4EkNV3hECDxk7KHIvLZDe2xQrJUVUSfxJ3h8YfIEAKX7axOGQbS33mOUgtlVQZdWf/JSyxvAN+0CRFCBh9AoPpfmZvTebN5xVbmv0kIJaKBaC4FhcX9xaneP9ut6w9Ha12wCCplp+LrKRjCEvoZe2N80kbZ/RgqQJ5OHcC/mg6g0UXw2bWpw2/ySuOgQUtjrbLgkzAx3O9ex/0pwFTdFSaPGSYBjiVRcxBB9Pu//g0bzy3EaHlNIGivba397o8YqILK2e8AwtMRBW8xDXanQVpFztAJR5xK8DNxRKJw/tSyBaz11ckq+WwvreA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7qtJrEoGp8AP6Vo7LCbs2EEQvG7I8yvIULPC360r3w=;
 b=hHASKWSDMiEvCkRCDj3wLHEdXJ6km+uY7a+PsiEWpKa3MMm8uOrWqDWVphpdMotmEoL5dgebo1ek6+FddhGgS4LyTRU03wymAtXKm2YBIoP/l+qY3KxG1lA9uSvA3DftYIBDRk3Tb1w0CN4ih9vMiQQq0dhhYsIt2Yx//2nS3D4=
Received: from DM5PR07CA0106.namprd07.prod.outlook.com (2603:10b6:4:ae::35) by
 CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 22:07:00 +0000
Received: from DS1PEPF0000E645.namprd02.prod.outlook.com
 (2603:10b6:4:ae:cafe::d3) by DM5PR07CA0106.outlook.office365.com
 (2603:10b6:4:ae::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Tue, 3 Jan 2023 22:06:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E645.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Tue, 3 Jan 2023 22:06:55 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 16:06:53 -0600
Subject: [RFC PATCH 3/3] x86/resctrl: Display the RMID and COSID for resctrl
 groups
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <eranian@google.com>,
        <peternewman@google.com>
Date:   Tue, 3 Jan 2023 16:06:53 -0600
Message-ID: <167278361325.34228.16916982678071203069.stgit@bmoger-ubuntu>
In-Reply-To: <167278351577.34228.12803395505584557101.stgit@bmoger-ubuntu>
References: <167278351577.34228.12803395505584557101.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E645:EE_|CH3PR12MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 0311d435-4be1-497f-e124-08daedd6d35a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7qkIw5T0LQwSF8QI9+Qw4aDPkRsFHAEauFugseDkLZNvVc/tR/xBQ8ov6Jk1puzGkWiOD5/ZvGJzQAznsLPgwrHdRQsZ70ikPnSvwUFqRQBeZI+nyWA9v7D7rX0wra5bkOrwSulDq1rGN6w36mF/aQDK2TwU7KkBy6ATLoaJPbZwZzzt68Kp2JePQ9vdioPlfacH1CnCkX4b04tHzFNuhYsqZJqGTguM5Us071qT8vskkZaPKANZShDx//eVxLTfr4nqV7faHmRPmOjclavUnPU0sNOosEi4+tPadX7pVQWYbfdOI/Mk9HKQOEOawyzR3M2bEIqxS/Md7qVE4URaIbPQskZ+LuZT1AUa2zr8uRgyyRTzPU//S+C+vKwhkTWjgmF4j+T9mZuGM9w6KoWl0tTeCL7J1jbd5uuRdiwuTzgiua1GHno02JNlkRkZu94Rrgkg3XUntyc62SvxUf5DA+3bHYfrHorr94MFEbcYm1Q7y84GvTZJVQtCbsbt8h6cUmIxTswojLLms3h7F379w6UPEj8Dklg5Mv4ZA8pcbegQLr6CO26yyDZekjmb9aVOG+0ZOZUrSa9uXxvKz0wFWSBUiIE1l1R8wUIc1gAE4hBEF7iEwBElkRZOJK2RjhPuYfZgheuQh5tiR3qFlNhK8dkSR0Qkt3vpkkFD04yFbvmyhjfGzesELRVUpkDeMu5lDL6Wlzu4pC2n8QfoemsZNOCzMBAiy/ng8UpKk/E2FSlm6G4QE8r6dElRkYGC3RVeK8VUgjJ7ECZ9mHm93S0u03TGpVuYD8C29Fhy63SiHgU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(346002)(136003)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(83380400001)(47076005)(426003)(16526019)(336012)(26005)(9686003)(82310400005)(33716001)(103116003)(40480700001)(40460700003)(86362001)(36860700001)(81166007)(82740400003)(356005)(186003)(478600001)(41300700001)(8676002)(4326008)(2906002)(7416002)(5660300002)(8936002)(44832011)(16576012)(316002)(70586007)(70206006)(54906003)(110136005)(22166009)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 22:06:55.0297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0311d435-4be1-497f-e124-08daedd6d35a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E645.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 Documentation/x86/resctrl.rst          |   15 ++++++++++=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   46 ++++++++++++++++++++++++++++=
++++=0A=
 2 files changed, 61 insertions(+)=0A=
=0A=
diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst=
=0A=
index f26e16412bcb..8520514bc8b5 100644=0A=
--- a/Documentation/x86/resctrl.rst=0A=
+++ b/Documentation/x86/resctrl.rst=0A=
@@ -231,6 +231,14 @@ All groups contain the following files:=0A=
 	Just like "cpus", only using ranges of CPUs instead of bitmasks.=0A=
 =0A=
 =0A=
+"rmid":=0A=
+	Reading this file shows the resource monitoring id (RMID) for=0A=
+	monitoring the resource utilization. Monitoring is performed by=0A=
+	tagging each core(or thread) or process via a Resource Monitoring=0A=
+	ID (RMID). Kernel assigns a new RMID when a group is created=0A=
+	depending on the available RMIDs. Multiple cores(or threads) or=0A=
+	processes can share a same RMID in a resctrl domain.=0A=
+=0A=
 When control is enabled all CTRL_MON groups will also contain:=0A=
 =0A=
 "schemata":=0A=
@@ -252,6 +260,13 @@ When control is enabled all CTRL_MON groups will also =
contain:=0A=
 	file. On successful pseudo-locked region creation the mode will=0A=
 	automatically change to "pseudo-locked".=0A=
 =0A=
+"closid":=0A=
+	Reading this file shows the Class of Service (CLOS) id which acts=0A=
+	as a resource control tag on which the resources can be throttled.=0A=
+	Kernel assigns a new CLOSID a control group is created depending=0A=
+	on the available CLOSIDs. Multiple cores(or threads) or processes=0A=
+	can share a same CLOSID in a resctrl domain.=0A=
+=0A=
 When monitoring is enabled all MON groups will also contain:=0A=
 =0A=
 "mon_data":=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 0d71ed22cfa9..98b4798e5cae 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -769,6 +769,38 @@ static int rdtgroup_tasks_show(struct kernfs_open_file=
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
@@ -1593,6 +1625,20 @@ static struct rftype res_common_files[] =3D {=0A=
 		.seq_show	=3D rdtgroup_size_show,=0A=
 		.fflags		=3D RF_CTRL_BASE,=0A=
 	},=0A=
+	{=0A=
+		.name		=3D "closid",=0A=
+		.mode		=3D 0444,=0A=
+		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
+		.seq_show	=3D rdtgroup_closid_show,=0A=
+		.fflags		=3D RF_CTRL_BASE,=0A=
+	},=0A=
+	{=0A=
+		.name		=3D "rmid",=0A=
+		.mode		=3D 0444,=0A=
+		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
+		.seq_show	=3D rdtgroup_rmid_show,=0A=
+		.fflags		=3D RFTYPE_BASE,=0A=
+	},=0A=
 =0A=
 };=0A=
 =0A=
=0A=

