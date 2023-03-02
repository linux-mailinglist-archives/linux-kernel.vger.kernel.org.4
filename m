Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756036A8A35
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 21:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCBU0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 15:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjCBUZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:25:43 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADE22820E;
        Thu,  2 Mar 2023 12:25:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWAiWILIYV6bYPnUTCk51xGjNH77owCkQ0BjtW6eFxCBKz1m2yve3/9oHkyQpwZXb9lvPZ2b7lBxkuu5fVqfG0VeyvAQPwGhHuDxeGq9qxc/rrsFzpo9f6kRPcpv5yiRbW8A64XlhB+P1Wm1bvc8Xfeip6Q/a9lFcYrTGWK14OzYCZ4MVqVG8lSJlmy9alEfwWmtU8N2JpFOYpoYvuyM+R8z+eJwrDkpS8DstZg/T+1F7URTdjnfidDDFKnS+74MoIM9Ufe8ZHqE67Xa0nvDcTMwYjOgy/V6bYzP+aj0NkeRIntbp5qMSnZWFJGO0nSdytP5sEQq1SRXxigIWn8HxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvBn5SIrSfI9gR5HDFhw8W4CA0A9jPC55GhGmzRT5DA=;
 b=Mld1elsbiQIP+yufIJ8f9z1Sp5/kCbfHNWwPW6AWd7LHsN17fbQdB+EItu6VcpAY2jbGCbbvWR7NPTY7oKNrtcS6ekQwlno8PQYE6uCtoMTxgtISYkrpL53I9VsEZSMRK4cVmjIOe7UJac0IIsqeFqVMpArPQNuP1g9gQkfxX0NYPlmvDVv/asjEvbZY9txDXPyF72fEeZ8Z713SFzd1QERr9DCcSTXLHUA7TdySYPgVBzy0VrorklYJT/jmHiAoKerZx010MFcOaoVZEyhj2eR27olr9R5QX1BozfWIgppF2WSmuYBcxVNXMSXpQcy07haQQ64y1Zy9PW6VsLNXkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvBn5SIrSfI9gR5HDFhw8W4CA0A9jPC55GhGmzRT5DA=;
 b=UPeyjZC0BfHAwhNNoMpQ/69J0sRN3qP9sKOx+tTLb53RbTgeiAjRoSmNIsbWFIqjE1d/ree4erUmdPEOeKl+57s9EszsEaoKanJKG7+InIDS6S6OUrrAPHWzgrDMf5Mh+qbdgE66nVIrQlbz/z5Sg6aSWHVQK1FwMcj0IhCh1h4=
Received: from DS7PR03CA0267.namprd03.prod.outlook.com (2603:10b6:5:3b3::32)
 by DS0PR12MB8443.namprd12.prod.outlook.com (2603:10b6:8:126::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 20:25:06 +0000
Received: from DS1PEPF0000E62E.namprd02.prod.outlook.com
 (2603:10b6:5:3b3:cafe::b9) by DS7PR03CA0267.outlook.office365.com
 (2603:10b6:5:3b3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Thu, 2 Mar 2023 20:25:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E62E.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Thu, 2 Mar 2023 20:25:06 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 14:25:01 -0600
Subject: [PATCH v3 6/7] x86/resctrl: Introduce -o debug mount option
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
Date:   Thu, 2 Mar 2023 14:25:01 -0600
Message-ID: <167778870113.1053859.9553109061915206299.stgit@bmoger-ubuntu>
In-Reply-To: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E62E:EE_|DS0PR12MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8c1e02-7f82-47b3-7515-08db1b5c364a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+Rbvhx2SIS+Z+qpY6jSzGPVumbmTjOttUi8xtA3r2gE5H87CVCaJeTHjcPv6dBGQ4ysqYMH9ybAl8RmaLcABjMOjhQ2ehy4OMiEzwDm7Pju5cb+6JM5momFvjnIHzAa1OCdofwjwQpRmTZ4JSM6IhpnLvyTL8TUAxFEB/3X+yqAxUKAjJgL0qPF7mYwudePPT5UZGk0b6dWCk9U1bcqDXO+fTqb6owl5n10sp13S7Nj/uK5clt2G1e+C/KxYn9U3Vn2Qli5/tKHP3CV6xELNaNl0vqRR9JnP1Rc2B9lWgrDGRa5BbXLr1LyoAMXx7I+ZXUwFzClF/USsnAkj8pBrihgzdr37InnPzqDp7zZDe/+q+GFm/I7lGzwffda9AWOz3ITyhxaDf1JvGKY2iNUyM7w1E5eckGaAVr0FGhPUe7LpDnUFHfCGCeZZbkMuy+Kyf91yoZMG67s/475peJ9k+gDaEVx4QXG7WDKpK0WAwm9tRZk7iO20cZFgSNnfSnNI+sNynCBlG3Mezpd1244YCsL+tXvWojPzXI9Gzx+Iq0KRpkJ5+I32uuqLMq6eoKeEpNJWbT29k4w7zOaMFPxAWSXVho0dbUaW0M3egf56S71/7m3iGtqIOg3byoYs7wpp1bjxZR5AKffoCGiR9yG/2Fwwf3ts+Bmo8Qx4VS8BDPvahqAOTIBk9rbvdJr6hJDiTeYrpdRe6LyA20aJS0x6Nsk553iF/NK02d1vQPZo+ubDWyrnOYy2syEsssORWw/O4tlGDmFFkK7rQ4fnvUIfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(7916004)(376002)(136003)(396003)(346002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(40460700003)(103116003)(26005)(336012)(16526019)(9686003)(186003)(16576012)(54906003)(316002)(41300700001)(110136005)(4326008)(8676002)(70206006)(44832011)(70586007)(2906002)(5660300002)(7406005)(8936002)(7416002)(478600001)(81166007)(82740400003)(33716001)(86362001)(82310400005)(40480700001)(356005)(36860700001)(83380400001)(426003)(47076005)(71626013)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 20:25:06.3753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8c1e02-7f82-47b3-7515-08db1b5c364a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E62E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8443
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add -o debug option to mount resctrl filesystem in debug mode. Debug=0A=
option adds the files for debug purposes.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 Documentation/x86/resctrl.rst          |    2 ++=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    1 +=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   13 +++++++++++++=0A=
 3 files changed, 16 insertions(+)=0A=
=0A=
diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst=
=0A=
index 67eae74fe40c..1ada4e0650dc 100644=0A=
--- a/Documentation/x86/resctrl.rst=0A=
+++ b/Documentation/x86/resctrl.rst=0A=
@@ -46,6 +46,8 @@ mount options are:=0A=
 "mba_MBps":=0A=
 	Enable the MBA Software Controller(mba_sc) to specify MBA=0A=
 	bandwidth in MBps=0A=
+"debug":=0A=
+	Lists the debug files in resctrl interface=0A=
 =0A=
 L2 and L3 CDP are controlled separately.=0A=
 =0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 6767c85b9699..35a9ee343fe0 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -59,6 +59,7 @@ struct rdt_fs_context {=0A=
 	bool				enable_cdpl2;=0A=
 	bool				enable_cdpl3;=0A=
 	bool				enable_mba_mbps;=0A=
+	bool				debug;=0A=
 };=0A=
 =0A=
 static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 389d64b42704..a1f13715a65c 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -56,6 +56,8 @@ static char last_cmd_status_buf[512];=0A=
 =0A=
 struct dentry *debugfs_resctrl;=0A=
 =0A=
+static bool resctrl_debug;=0A=
+=0A=
 void rdt_last_cmd_clear(void)=0A=
 {=0A=
 	lockdep_assert_held(&rdtgroup_mutex);=0A=
@@ -2411,6 +2413,9 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)=
=0A=
 	if (!ret && ctx->enable_mba_mbps)=0A=
 		ret =3D set_mba_sc(true);=0A=
 =0A=
+	if (!ret && ctx->debug)=0A=
+		resctrl_debug =3D true;=0A=
+=0A=
 	return ret;=0A=
 }=0A=
 =0A=
@@ -2599,6 +2604,7 @@ enum rdt_param {=0A=
 	Opt_cdp,=0A=
 	Opt_cdpl2,=0A=
 	Opt_mba_mbps,=0A=
+	Opt_debug,=0A=
 	nr__rdt_params=0A=
 };=0A=
 =0A=
@@ -2606,6 +2612,7 @@ static const struct fs_parameter_spec rdt_fs_paramete=
rs[] =3D {=0A=
 	fsparam_flag("cdp",		Opt_cdp),=0A=
 	fsparam_flag("cdpl2",		Opt_cdpl2),=0A=
 	fsparam_flag("mba_MBps",	Opt_mba_mbps),=0A=
+	fsparam_flag("debug",		Opt_debug),=0A=
 	{}=0A=
 };=0A=
 =0A=
@@ -2631,6 +2638,9 @@ static int rdt_parse_param(struct fs_context *fc, str=
uct fs_parameter *param)=0A=
 			return -EINVAL;=0A=
 		ctx->enable_mba_mbps =3D true;=0A=
 		return 0;=0A=
+	case Opt_debug:=0A=
+		ctx->debug =3D true;=0A=
+		return 0;=0A=
 	}=0A=
 =0A=
 	return -EINVAL;=0A=
@@ -3569,6 +3579,9 @@ static int rdtgroup_show_options(struct seq_file *seq=
, struct kernfs_root *kf)=0A=
 	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))=0A=
 		seq_puts(seq, ",mba_MBps");=0A=
 =0A=
+	if (resctrl_debug)=0A=
+		seq_puts(seq, ",debug");=0A=
+=0A=
 	return 0;=0A=
 }=0A=
 =0A=
=0A=

