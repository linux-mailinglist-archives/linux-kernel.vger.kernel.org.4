Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF96E5ECE75
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbiI0U1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiI0U0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:26:44 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74E2B657C;
        Tue, 27 Sep 2022 13:26:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wj/GLOAyh4JJnbuYxXD4hAysMl8L/7nuE6u7xa/itG+X3r6bZFTjY9nHv1fQwOSdl+c0XdlbiLvGuDBGUoyudjZhbaat0svEFXgSgN1accJY4MwnSifWru/OACwXU6CLIZ3mKmJ3Qg+LktdF0pYZl2Drf9jnzfyz1IvPzIi6lqk978IZUGQDRj9JW67c0Pxfsz6z8IdYqOYTez3fSl/SQrJHzRFxNXsfOXEJxGDcKzSIwTZSUdWYm5udZUW6km2D5OJjrtvw5BSPKcHmdbm5vqrOZLdbgRxqWRpXmO6I7TumlwgwRpOhhEwLx1kj324/wgcgfK656nD4zA0FPAho0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHiajZYHIqs7aPkdxF7r/wnOL6dQkajUWjDI54j+0t8=;
 b=Iyh/BW5TtdA/I8OdiCP9DIpWniROC+rpc7XP3TIbapyFeSzIpud/Ix2w7IkiUFoqPkP+BQ4BrcYmIH+jKAX+0hWfDslQcLlNQK2q2fF/7mfPpuDuRvLwe2xNl+IM+x+EOnk/q2F463w1BFjKSuLTHDeACB8+UnhenXNwox5aU6LBSctRrdp1ZQHA9v0cldgdu6KySG5sxN6AkwgI5MqWTopJDZDQZD9OS1Zqdj4P4Yl6aq3724FrPCP8Zyq//p+vbypAQkMWxO51AFSEQzfJClyBTxjonrcJgzFs6f+sKYnmdKtR9tbYoMyirCqG6kxAZPq1lcNTyXKF4Id7KMQj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHiajZYHIqs7aPkdxF7r/wnOL6dQkajUWjDI54j+0t8=;
 b=ndgcm+E/qpg+MovhuRIih8zpF6xjUtLQN50PpqP90JCVvAR6vmglgewsR+IIMBd3GE/DJ8/t1HVPX+7UpL+vpCsFTFNtgxhT7op3+UG+Fvn+Lu1/nqoQzUhn7e+FXNWOxkWvKem3FZzZsniA93gNg1QTQHZg2j2Gg4TO4jRKOXA=
Received: from DM6PR11CA0053.namprd11.prod.outlook.com (2603:10b6:5:14c::30)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 20:26:35 +0000
Received: from DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::63) by DM6PR11CA0053.outlook.office365.com
 (2603:10b6:5:14c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Tue, 27 Sep 2022 20:26:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT078.mail.protection.outlook.com (10.13.173.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 20:26:35 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 15:26:33 -0500
Subject: [PATCH v5 08/12] x86/resctrl: Add sysfs interface to read
 mbm_local_bytes event configuration
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
        <eranian@google.com>
Date:   Tue, 27 Sep 2022 15:26:27 -0500
Message-ID: <166431038771.373387.9706240777220251603.stgit@bmoger-ubuntu>
In-Reply-To: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT078:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 93dcea6e-d4cc-454f-cfe1-08daa0c692d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n9cSk4lK2Jh6j6dUaYo4lf1jezjvsg1y7n2Ea6KkrArUO0aB4O2TF4C/sZhkg4Y39kBD0HXi6i6/0kgb9zHlmR/uRJ8Vt+sIPHlHptTktRxaFoE9O6ijPcx8awxgEnbXMOZK/oIgYQ9/WJtEquEoocGQp70TXBk0e/uED2jDA42UhK+NCZyowcreyGO0IfKccW0Z1PfaWN72mZfwWKN1glNA8CloZ7u0mzeIzymwqsMpDNeBkfl4QXYCwasu47laNesTbCJAMGyMu9hAahe9g+ZsB0/rKr4pM8ILQmPygBFDidZtyTnP+VY56VOCHEv3qBYchOvpJ2fif37g2+WTBHeUFgYaK2ijnb0NFD8ETmfZhkOqWDCrgVzjUDMGDxNUFLsFdW2azRrCQguKATcVyktmZZ1XPMKJTgfR+DUtqoWMmZqbgquJC/ys1ta5unQ0t7xnJgcm7/05kGZg/z8wlAE5EWlUzvwthN+ktDPSE7B9aYvnV3mSjqnY32O5nkpBZ//PSC9hb+23FINcRpXNwpPSE/biQ//Zun/xlarq1dWejDTiusad/aI2jXhb6JfAPTkofyc+XAVYy3Wtzn/KJnx3bkc3H35JHO92h/r7sPOUT0ce9VFCsy+PmJWEMoSJNAATtNjrhOavgL36lqXGaOHpB+N2tEOy6aoP36tgfJLa9u6UUH1zx4ZezkZo0bqt1IdcAOZd5r2i1TD9pJfo1DJkhwqLREbA4IwMGpAWDqA8atJaKROrpOvm836i1jr5ZoHrANLOyO9hCLXdv1T12mKuCC6QJcHbbkXfzaoOX5NZ3qfk3lhuQTSAeWOTMAdOjAPMEhflh4SAPHdx9cpayQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199015)(36840700001)(40470700004)(46966006)(33716001)(82310400005)(5660300002)(41300700001)(2906002)(7416002)(44832011)(8936002)(426003)(110136005)(356005)(36860700001)(81166007)(70206006)(4326008)(70586007)(40480700001)(8676002)(478600001)(54906003)(16576012)(103116003)(316002)(47076005)(82740400003)(26005)(16526019)(186003)(336012)(9686003)(86362001)(40460700003)(6666004)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 20:26:35.2667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93dcea6e-d4cc-454f-cfe1-08daa0c692d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current event configuration can be viewed by the user by reading=0A=
the configuration file /sys/fs/resctrl/info/L3_MON/mbm_local_config.=0A=
=0A=
Following are the types of events supported:=0A=
=0A=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
Bits   Description=0A=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
6      Dirty Victims from the QOS domain to all types of memory=0A=
5      Reads to slow memory in the non-local NUMA domain=0A=
4      Reads to slow memory in the local NUMA domain=0A=
3      Non-temporal writes to non-local NUMA domain=0A=
2      Non-temporal writes to local NUMA domain=0A=
1      Reads to memory in the non-local NUMA domain=0A=
0      Reads to memory in the local NUMA domain=0A=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
By default, the mbm_local_bytes configuration is set to 0x15 to count=0A=
all the local event types. The event configuration settings are domain=0A=
specific. Changing the configuration on one CPU in a domain would=0A=
affect the whole domain.=0A=
=0A=
For example:=0A=
    $cat /sys/fs/resctrl/info/L3_MON/mbm_local_config=0A=
    0:0x15;1:0x15;2:0x15;3:0x15=0A=
=0A=
    In this case the event mbm_local_bytes is currently configured with=0A=
    0x15 on domains 0 to 3.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   20 ++++++++++++++++++++=0A=
 1 file changed, 20 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index b51fae77ba5c..27bf6ade0dbf 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1481,6 +1481,16 @@ static int mbm_total_config_show(struct kernfs_open_=
file *of,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+static int mbm_local_config_show(struct kernfs_open_file *of,=0A=
+				 struct seq_file *seq, void *v)=0A=
+{=0A=
+	struct rdt_resource *r =3D of->kn->parent->priv;=0A=
+=0A=
+	mbm_config_show(seq, r, QOS_L3_MBM_LOCAL_EVENT_ID);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /* rdtgroup information files for one cache resource. */=0A=
 static struct rftype res_common_files[] =3D {=0A=
 	{=0A=
@@ -1585,6 +1595,12 @@ static struct rftype res_common_files[] =3D {=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D mbm_total_config_show,=0A=
 	},=0A=
+	{=0A=
+		.name		=3D "mbm_local_config",=0A=
+		.mode		=3D 0644,=0A=
+		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
+		.seq_show	=3D mbm_local_config_show,=0A=
+	},=0A=
 	{=0A=
 		.name		=3D "cpus",=0A=
 		.mode		=3D 0644,=0A=
@@ -1698,6 +1714,10 @@ void __init mbm_config_rftype_init(void)=0A=
 	rft =3D rdtgroup_get_rftype_by_name("mbm_total_config");=0A=
 	if (rft)=0A=
 		rft->fflags =3D RF_MON_INFO | RFTYPE_RES_CACHE;=0A=
+=0A=
+	rft =3D rdtgroup_get_rftype_by_name("mbm_local_config");=0A=
+	if (rft)=0A=
+		rft->fflags =3D RF_MON_INFO | RFTYPE_RES_CACHE;=0A=
 }=0A=
 =0A=
 /**=0A=
=0A=

