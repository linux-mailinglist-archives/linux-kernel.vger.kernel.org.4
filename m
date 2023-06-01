Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B16D71F292
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjFATC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjFATCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:02:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31011B8;
        Thu,  1 Jun 2023 12:01:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+GjEAZG90EUMswPrruQtJ7h/myQN6aRYaiCiMgr1Ql5V5k7xG6cp7AS+30Ij+cRN0VZtiDzgFEwSxV+Kc/J4ezia0rdakXCFfgw3oyKycloUni7+1/fj0gvjbc8NYgOEccua701M4/X3t8LF3snyr4fWnlrtOgA4UONyOxYyH2AzB7f6yfa0dqKosw5fEzWcwITfMd+rX+TfLD5iueJdy0X1c/SP7Sj1T/aaKodAg+r3EmjWy1IF8W77GrzFneMUsm7l/VHahvqQbuQ3zSJSt4po+bGYhSG1zSKVkZEk6bjhu1mMQ2GYVs6Qj4sQrrTNwtbHwNIwAqGTP5k6SwEpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pc7gUMeTIQG06bGDJbpD3jGGCpa1NF77PZ/v+V6CXYs=;
 b=NDGEBoag0QrlgzGPCYpNUaakVDmnow6z7QjARnHebvRXj1Lq1oECk11aZ5ffTgMLY7XTkXd4RkL4vasOh1EeA3/tyGw26Lr3VJtzwJw3XIfblu3gnlxKSlS3BfBAFDpINyDGRf5eJ2W89rJhWR2qFJeeOBQtkl0kGProwffNNYvrle3OxhvfPB5e901aci0EQT/JTdXf1dpqblC8fYyKMe3v3RNHS4Ah7fB9pKYejhOsES/uOlFYT34fRm7obs3Z4PVPTnpxQvJ/KHlzBdBadIMfJVhOMd16kdN+QHNZ2lsUvBfS0E/apLdashgVQhfmC+ng7ZoNGQdPIoW/zhwmGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pc7gUMeTIQG06bGDJbpD3jGGCpa1NF77PZ/v+V6CXYs=;
 b=RPQAelQR3wf5eluYNGjy5HcMvnIprlw9YI14J5+Lpu0Yldjy7iUbSpzzIyvvZTZ8Ltpcpuv1uegl5rFmw7YL8AXTLNKul1G8pvsVMVT6UVmUEn90cRmZh8nNhn1IoYtob/bBuKhcRDaGjX7UAo/SUiBxIh07zCzlXI4esU8ayjE=
Received: from BN9PR03CA0204.namprd03.prod.outlook.com (2603:10b6:408:f9::29)
 by MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 19:01:56 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9::4) by BN9PR03CA0204.outlook.office365.com
 (2603:10b6:408:f9::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 19:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Thu, 1 Jun 2023 19:01:56 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 14:01:53 -0500
Subject: [PATCH v5 6/8] x86/resctrl: Display CLOSID and RMID for the resctrl
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
Date:   Thu, 1 Jun 2023 14:01:51 -0500
Message-ID: <168564611100.527584.7981937236207103115.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT009:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb3154a-6fbe-4109-9695-08db62d2ab78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBdrmy7MTlTWcT64L/wGoBX6gH9+RXMZ5j0SI12SBEJEW2lVuzBltjJL4WZCGLJf52u+Ci8PYtElh5ks8/P6sjwx3BNxcaIet35VvZI5fxQ4m/F0qLCiBK6r/gbiEXDqi/hbNpxb7+fWjEQqlb3VkQiORGS3cQsLgxPtUEn3VazPgmoAsmk3cogoVkC1UPGcFbUEGXbXM/AXBR777Cd97WaSCAu3vWYERqib5EXnWFaNn9LugOXl2TKOcQVoB1lcF6UD46Wb+9FxpBmKilB4WoqkPLydGJi2C0J7RqfKddYqaMZP54qf5VXQibX46ZMMkLhmOXRVZClnrvbJTxPThgoMWet1Ro1lP3p3UeJVGTeqWbU9NNFxhJXBz8lqMVGLMBlJ8WNvl/ryJSWhHSlcg49tcU2iZKSiiGCOGW8tfd+qIqxnlShCzANJjozQgZ8f8YlDu+Dl9DXhntn3KGuGBt1qD6n2ZR/VsSOoGdEc6HWf7p7gNJCoedW+LplSnIynKy59f4GrLUjeHzPOignN5VymqGbaVZ917y6D+kQLDLwQET/AvZoEBscgbYyBeztEJt0wzZSsU03n+2ZBLGXGjEq84nlnNUlC8aVf09+XMaePYBfs91NzMsHRGka1f1hkEJkA1J7XM4jKbOyHnZ5XakINGbL0PVUybuwj2SKKwnwOF9CrGF8i2YEqoovUNqqlVgdiETlbXpUMUCIevVi9wQkVwJ2P6Kxq+dRe5n+q6jWzYCH775NF6hWGWKHDwqEI9E99iE73Cj5gtY4EabTXKioR9kDhOBjRaeu8YPPpn38=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(110136005)(7416002)(7406005)(54906003)(5660300002)(70586007)(70206006)(356005)(81166007)(82740400003)(8936002)(8676002)(16576012)(478600001)(186003)(9686003)(16526019)(44832011)(316002)(4326008)(41300700001)(26005)(426003)(2906002)(86362001)(336012)(103116003)(47076005)(33716001)(40460700003)(83380400001)(36860700001)(40480700001)(82310400005)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 19:01:56.1893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb3154a-6fbe-4109-9695-08db62d2ab78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In x86, hardware uses CLOSID and an RMID to identify a control group and=0A=
a monitoring group respectively. When a user creates a control or monitor=
=0A=
group these details are not visible to the user. These details can help=0A=
to debug the issues.=0A=
=0A=
Add CLOSID(ctrl_hw_id) and RMID(mon_hw_id) to the control/monitor groups=0A=
display in resctrl interface. Users can see these details when mounted=0A=
with "-o debug" option.=0A=
=0A=
For example:=0A=
 $cat /sys/fs/resctrl/ctrl_grp1/ctrl_hw_id=0A=
 1=0A=
 $cat /sys/fs/resctrl/mon_groups/mon_grp1/mon_hw_id=0A=
 3=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 Documentation/arch/x86/resctrl.rst     |    8 ++++++=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   44 ++++++++++++++++++++++++++++=
++++=0A=
 2 files changed, 52 insertions(+)=0A=
=0A=
diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/re=
sctrl.rst=0A=
index afdee4d1f691..1baf857ad8c6 100644=0A=
--- a/Documentation/arch/x86/resctrl.rst=0A=
+++ b/Documentation/arch/x86/resctrl.rst=0A=
@@ -344,6 +344,10 @@ When control is enabled all CTRL_MON groups will also =
contain:=0A=
 	file. On successful pseudo-locked region creation the mode will=0A=
 	automatically change to "pseudo-locked".=0A=
 =0A=
+"ctrl_hw_id":=0A=
+	Available only with debug option. The identifier used by hardware=0A=
+	for the control group. On x86 this is the CLOSID.=0A=
+=0A=
 When monitoring is enabled all MON groups will also contain:=0A=
 =0A=
 "mon_data":=0A=
@@ -357,6 +361,10 @@ When monitoring is enabled all MON groups will also co=
ntain:=0A=
 	the sum for all tasks in the CTRL_MON group and all tasks in=0A=
 	MON groups. Please see example section for more details on usage.=0A=
 =0A=
+"mon_hw_id":=0A=
+	Available only with debug option. The identifier used by hardware=0A=
+	for the monitor group. On x86 this is the RMID.=0A=
+=0A=
 Resource allocation rules=0A=
 -------------------------=0A=
 =0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index be91dea5f927..2f5cdc638607 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -763,6 +763,38 @@ static int rdtgroup_tasks_show(struct kernfs_open_file=
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
@@ -1824,6 +1856,12 @@ static struct rftype res_common_files[] =3D {=0A=
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
@@ -1847,6 +1885,12 @@ static struct rftype res_common_files[] =3D {=0A=
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

