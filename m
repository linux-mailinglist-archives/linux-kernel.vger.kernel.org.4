Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0083A6E554F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 01:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjDQXf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 19:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjDQXfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 19:35:52 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6022A59C7;
        Mon, 17 Apr 2023 16:35:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLZIOyHLkgMCXL8jxQ2zQLBjiCra00FSTf1rPq+YZubaMDaDJuNxgODAxlLzS9TxEI1t2V1ByswTt+TvnxZK/6hSfreYTEMKjE3XRpgoYhsAdXLRoIkXzAaNiY6RzOtl7Q/qn3l4Xn7Nph8CfThoQJQXi16awGX3RWrgE2cNAbGgSljZBD88GKCvJe635p0PEOrdOC9u3H8XUlktB5bOipPC2cUp8/zcVpnX4NO7I7Z2E7MpigPG3ezEcedN7o7UmgBh1BFqF6pdlR1b7lO/oMqHuu2DfF+7OrhKg1z+hfzV0DQhiOcHxdMbqYeqzWHf9gfjj6C029uYCLxBVBjG8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ybihj2KdjI+Z/hC4V5qabsSvdzEjuHKYdxCu5RXeBuE=;
 b=cERSTkq3Qqv1dLqgQVzb2ZHQU1do3vNv5/otabDpaAHuKFsjkvPBxtO3tWB7F3mNKMRNvEWOPWYnJ53VXmNgwY+VwNpm/5jG4LCjw7xqCm7sauU9sKdbuCgRgFJcPz3uf3JO+ngcxVnQvMl8qJzKqCt727AHSUGgoem2GCytny095moBGgIisB/uRW4dH0z0IJw8GdT63Nl9wk2h6CodLZtMFkzbNkT3lNRyrhh24gWcQNxvQV9LmBHyFyXnt3HvqeZBfUXvxFvXzRus7DucjtNOjCf7yIqKoVC5XuroucIdrCLpcgnlulp038yM6VayaSekDbmuC3V5xo/mmRlutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ybihj2KdjI+Z/hC4V5qabsSvdzEjuHKYdxCu5RXeBuE=;
 b=nvlQt+0K4TQCMx4dN98BPpZ9iSCBUXMGYyTkdG/MhXFvSGjl3ogCCs0/7q9BohywSwCuyuAaRJoPnqVBsPrnq3tdMpS6CbCC3I2hqUGMqbFMQae2OLjRzSneVaS/Z3s9kYx/9/AeF4/BMnSUmL2PoTvo88623cbHWQS4FxWGPJ8=
Received: from DM6PR13CA0066.namprd13.prod.outlook.com (2603:10b6:5:134::43)
 by DM4PR12MB5279.namprd12.prod.outlook.com (2603:10b6:5:39f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 23:35:05 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::c6) by DM6PR13CA0066.outlook.office365.com
 (2603:10b6:5:134::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.19 via Frontend
 Transport; Mon, 17 Apr 2023 23:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.20 via Frontend Transport; Mon, 17 Apr 2023 23:35:05 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 17 Apr
 2023 18:35:02 -0500
Subject: [PATCH v4 6/7] x86/resctrl: Display CLOSID and RMID for the resctrl
 groups
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
Date:   Mon, 17 Apr 2023 18:34:56 -0500
Message-ID: <168177449635.1758847.13040588638888054027.stgit@bmoger-ubuntu>
In-Reply-To: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|DM4PR12MB5279:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db6958f-de84-47e6-5db6-08db3f9c5fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +qHLlN3NhxpQeXu/Oq7b94EFUb+/bAUXFOD7olAcz8QNr4y7oBjTkAsIBA+Qh8GZixOOkgBI8HowcOjFqbKS+3a9Ov1xF4Qgs47bdHIzK/2C8wPeD49Ij0qK90ZgerBSFpLp9Eg40ZuZzB4zRMWAZpRpODaVKxdXhjMlurSbZ/SBy7dKvLarKQSGrg3Ym+e1XRLQI/YgrDOWYzIbdUhb1HoscKHHJ9mUhlSArSibX7iCDm8WrPSWVJHrn/UJI6c2w6WIMHbnEZCKACYP4lTTD8GexjLnCgyCe9hE59ZWzGbIf2YH4RGaJBHWQEvWvKYju4ZqGNFX1gZKWaTVccc0d6EKST0FIZURqrb+DmfG29lQCZ/QH4F4rIogUiXFIgjKxgScaoLjcWRGTm1XW2k037BFf7ZQLo0NLU7BL7ArcVW5QSmBivvQyCjj3UYfzxcrry+ySmCgJehTXhqnE6wzDVQTWArQVDvCBVlWeoegkFmQKCCedatxqkOQ3uTMJbuXlOZm/+Z9Hdj6EyOMRV8JY2HLHehDoetE7kZUehMWEs5PcMNkM6mRBWSR3Z6aaj1d/dxVZQ/4pINxxKMuO3IRWJdxiQu+U8y9tMzh43gfbEu7BmrLx1af/EWurw4BMxBGcvGm7ybn4qiejEyXGnSqImDnuqoFEbmJJxc7xmuTDcoPE2Igd5rM7sZdcj37niMxhGbs6gxBm4JoqkmQ7fqO9YPCCY/l8UsB8nUVC6pJ/50oZ+3NAgGT1GKVxE1ugD64FA93WHJtH+4aLl4PoI3N1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(16576012)(110136005)(9686003)(54906003)(26005)(33716001)(478600001)(82740400003)(70586007)(70206006)(47076005)(316002)(83380400001)(6666004)(186003)(16526019)(336012)(4326008)(426003)(41300700001)(356005)(8936002)(8676002)(2906002)(5660300002)(81166007)(7416002)(7406005)(44832011)(82310400005)(40460700003)(103116003)(40480700001)(86362001)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 23:35:05.4200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db6958f-de84-47e6-5db6-08db3f9c5fa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5279
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a user creates a control or monitor group, the CLOSID or RMID=0A=
are not visible to the user. It can help to debug the issues in some=0A=
cases. There are only available with "-o debug" option.=0A=
=0A=
Add CLOSID(ctrl_hw_id) and RMID(mon_hw_id) to the control/monitor groups=0A=
display in resctrl interface.=0A=
$cat /sys/fs/resctrl/clos1/clos_hw_id=0A=
1=0A=
$cat /sys/fs/resctrl/mon_groups/mon1/mon_hw_id=0A=
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
index be443251b484..5aff8c2beb08 100644=0A=
--- a/Documentation/x86/resctrl.rst=0A=
+++ b/Documentation/x86/resctrl.rst=0A=
@@ -345,6 +345,14 @@ When control is enabled all CTRL_MON groups will also =
contain:=0A=
 	file. On successful pseudo-locked region creation the mode will=0A=
 	automatically change to "pseudo-locked".=0A=
 =0A=
+"ctrl_hw_id":=0A=
+	Available only with debug option. On x86, reading this file shows=0A=
+	the Class of Service (CLOS) id which acts as a resource control=0A=
+	tag on which the resources can be throttled. Kernel assigns a new=0A=
+	CLOSID a control group is created depending on the available=0A=
+	CLOSIDs. Multiple cores(or threads) or processes can share a=0A=
+	same CLOSID in a resctrl group.=0A=
+=0A=
 When monitoring is enabled all MON groups will also contain:=0A=
 =0A=
 "mon_data":=0A=
@@ -358,6 +366,15 @@ When monitoring is enabled all MON groups will also co=
ntain:=0A=
 	the sum for all tasks in the CTRL_MON group and all tasks in=0A=
 	MON groups. Please see example section for more details on usage.=0A=
 =0A=
+"mon_hw_id":=0A=
+	Available only with debug option. On x86, reading this file shows=0A=
+	the Resource Monitoring ID (RMID) for monitoring the resource=0A=
+	utilization. Monitoring is performed by tagging each core (or=0A=
+	thread) or process via a RMID. Kernel assigns a new RMID when=0A=
+	a group is created depending on the available RMIDs. Multiple=0A=
+	cores (or threads) or processes can share a same RMID in a=0A=
+	resctrl group.=0A=
+=0A=
 Resource allocation rules=0A=
 -------------------------=0A=
 =0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 0169821bc08c..15ded0dd5b09 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -782,6 +782,38 @@ static int rdtgroup_tasks_show(struct kernfs_open_file=
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
@@ -1843,6 +1875,12 @@ static struct rftype res_common_files[] =3D {=0A=
 		.seq_show	=3D rdtgroup_tasks_show,=0A=
 		.fflags		=3D RFTYPE_BASE,=0A=
 	},=0A=
+	{=0A=
+		.name		=3D "mon_hw_id",=0A=
+		.mode		=3D 0444,=0A=
+		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
+		.seq_show	=3D rdtgroup_rmid_show,=0A=
+	},=0A=
 	{=0A=
 		.name		=3D "schemata",=0A=
 		.mode		=3D 0644,=0A=
@@ -1866,6 +1904,12 @@ static struct rftype res_common_files[] =3D {=0A=
 		.seq_show	=3D rdtgroup_size_show,=0A=
 		.fflags		=3D RFTYPE_CTRL_BASE,=0A=
 	},=0A=
+	{=0A=
+		.name		=3D "ctrl_hw_id",=0A=
+		.mode		=3D 0444,=0A=
+		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
+		.seq_show	=3D rdtgroup_closid_show,=0A=
+	},=0A=
 =0A=
 };=0A=
 =0A=
=0A=

