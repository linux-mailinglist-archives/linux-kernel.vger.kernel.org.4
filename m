Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDFF63F42A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiLAPhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiLAPhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:37:10 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46BAAD33A;
        Thu,  1 Dec 2022 07:37:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLVcNHJBEWbd8Ykguqn8+WTInqtGeIO2QCqHmfYu0a3SayBoJvmrPwzpKq3fY2zzPiTUyeBb14rXnavIONycpgMVYRFgBLSdsFWn2KO7KSpQ1Ky5PgPKHcdNG3LRTBgZ9DYTDMRYdNvHTUz99UlWY8JiqOHUjHDntI1w8jhlw6stBcrA36nQzbZ5YHEaWmXU9teLTvuOdqoV+5M1yMeU12rm8Bo8QYBIE9v/ia4m+8B0uKeZdzIfpYlBYrDqIny7UPLWMtaSvrTlz5nBQfB+U9nk6g/TNJO/3z72ABo/+zKBpFuOY1SCSeKntiw8sg0gcSTNJRKRFzVt3o9siT5kXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSPaLBPKryxvsIaZH6p9iqxAa87bzU1121Sb7imypRc=;
 b=nT/wI/oiMsnxeUDBX8K83dwguKEVgubhtk1LDBjD9CRT6YJYCj4AOTTVAcQyKY5wxFWB43yFzlO4Lvlf+/CfkBKfJFjNEN40HOIYr6I+YNCUg6QGLsALyrj2AvrY9hHaT8/y+xxDZhbmL/KURFQ+/knZNjnTKwA7SDGCDfcQsx+a1H8j6B0NLMOEXmnxFEd8buPXa8jCDOUEBN6p8L1rTNGoHdpAPq7txXf3biWoUI4lfQtW4JTRGRqZbXWr9OJ8ksoENt5TSQKvIDJK2GGsvu/urRJo4476ukh+1YMFAiIG+V3M4z1BZreeYZG1nmdW6Wln3oXkiqEpDMBfmWvaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSPaLBPKryxvsIaZH6p9iqxAa87bzU1121Sb7imypRc=;
 b=HMPODTE4rX1djMJZBr2eJr/6/cqVYHu1jYG/TJo/HE1GIaIF7WxRYCdi683J8BJXZiA248lKMR2T7FpEpth5eU9Zf8mRVeXaDQ1wa2oa93rOJ7V+k05q9QLPIXoK5I1lb06W1E9BjpkFdzn3Lsdfc4QSBYAWy+qtLJe3r23lysU=
Received: from MW4PR03CA0128.namprd03.prod.outlook.com (2603:10b6:303:8c::13)
 by PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 15:37:07 +0000
Received: from CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::66) by MW4PR03CA0128.outlook.office365.com
 (2603:10b6:303:8c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Thu, 1 Dec 2022 15:37:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT086.mail.protection.outlook.com (10.13.175.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Thu, 1 Dec 2022 15:37:06 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 09:37:03 -0600
Subject: [PATCH v9 09/13] x86/resctrl: Add sysfs interface to read
 mbm_local_bytes_config
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
        <peternewman@google.com>
Date:   Thu, 1 Dec 2022 09:37:03 -0600
Message-ID: <166990902305.17806.9650262646704189221.stgit@bmoger-ubuntu>
In-Reply-To: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT086:EE_|PH7PR12MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b6a6fc-6583-4775-b801-08dad3b1e76d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O+RMWiRyPI/z+ApWlB10AviGXU5NlO47iiW2GMKj2AC2ikqODVLv7HCv91fC0CY9cS+6JQ4Z7NbUFgj6vYyWw8TLCCSzKIC3arFCpPgCq3P2HIbQkHdh1Su9CzMT0RzKaQilKGAP/sbOBjOKLEwwfv46hYleYLg7PpnnAla9pEIOkvvXaIzCpN7e4MjZqT8Qg1TtFwFBOeTBqMTMNJKHMCP6blmrjFyOtVvPAxfM3y2/GeP643tv27IcHxACadtmf6Z51Qfy8oEJMWom2c4tKEiGlp/aS2Fi7hsQwqq0r7yrDhbe8Yf+xa/k2vlt8hfsZUazXOJT/F+ppphrPDB2A+uj66Ok5yCyVIuzdmcnq27JakSuWENcK93gU9qdp5y2an/zaNVi+5NejSixCbqvNA+S819o6K3MVm48syM2olEiUZbNdiYs8YwxWwGGps+1UNN5TC9N34SULTFDJ7AI0Wd0YUta7swZGDfseSc+yY5iZ9gmJBvF9VbLT12Gv3k4v2jXJRt5yC3gmrBkJDZsj6Kzyx0ROT7jNp+p1g+MvfbUEh8BAgErujXX6s9usbc0+s1Cx6/au1WV7izTqyIHy7eMsfsMGUKDhSJZLq0lUBpJCRlj6Mqb7zAdybKwMbcztyIqF6GiwSdTSxhUJreKqXeJn8TKh2Bguo53gcS8hB1qMY4PkMBo8VQ8rM5UpVTjVasR12ocPkZL9qQkxwoTP+JT9nd2axaWJ3pvWxfqdAkKkl5b0X1pkl885EbZtFfjD3nUGQN2G/itVMsLXuCq0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(136003)(396003)(39860400002)(346002)(451199015)(36840700001)(40470700004)(46966006)(41300700001)(5660300002)(82740400003)(426003)(16526019)(40460700003)(40480700001)(16576012)(54906003)(110136005)(356005)(316002)(47076005)(81166007)(70206006)(336012)(70586007)(86362001)(4326008)(478600001)(82310400005)(33716001)(103116003)(9686003)(83380400001)(26005)(186003)(8676002)(7406005)(44832011)(2906002)(7416002)(8936002)(36860700001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 15:37:06.9246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b6a6fc-6583-4775-b801-08dad3b1e76d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5595
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
the configuration file /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config.=
=0A=
The event configuration settings are domain specific and will affect=0A=
all the CPUs in the domain.=0A=
=0A=
Following are the types of events supported:=0A=
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
By default, the mbm_local_bytes_config is set to 0x15 to count all the=0A=
local event types.=0A=
=0A=
For example:=0A=
    $cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config=0A=
    0=3D0x15;1=3D0x15;2=3D0x15;3=3D0x15=0A=
=0A=
    In this case, the event mbm_local_bytes is currently configured with=0A=
    0x15 on domains 0 to 3.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/monitor.c  |    4 +++-=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   16 ++++++++++++++++=0A=
 2 files changed, 19 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/re=
sctrl/monitor.c=0A=
index 2afddebc8636..7c8a3a745041 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
@@ -788,8 +788,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *=
r)=0A=
 			mbm_total_event.configurable =3D true;=0A=
 			mbm_config_rftype_init("mbm_total_bytes_config");=0A=
 		}=0A=
-		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL))=0A=
+		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL)) {=0A=
 			mbm_local_event.configurable =3D true;=0A=
+			mbm_config_rftype_init("mbm_local_bytes_config");=0A=
+		}=0A=
 	}=0A=
 =0A=
 	l3_mon_evt_init(r);=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index e93b1c206116..580f3cce19e2 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1507,6 +1507,16 @@ static int mbm_total_bytes_config_show(struct kernfs=
_open_file *of,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+static int mbm_local_bytes_config_show(struct kernfs_open_file *of,=0A=
+				       struct seq_file *seq, void *v)=0A=
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
@@ -1611,6 +1621,12 @@ static struct rftype res_common_files[] =3D {=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D mbm_total_bytes_config_show,=0A=
 	},=0A=
+	{=0A=
+		.name		=3D "mbm_local_bytes_config",=0A=
+		.mode		=3D 0444,=0A=
+		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
+		.seq_show	=3D mbm_local_bytes_config_show,=0A=
+	},=0A=
 	{=0A=
 		.name		=3D "cpus",=0A=
 		.mode		=3D 0644,=0A=
=0A=

