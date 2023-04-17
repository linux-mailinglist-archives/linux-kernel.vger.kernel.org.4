Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587D86E554D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 01:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjDQXfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 19:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjDQXfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 19:35:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CCB4EED;
        Mon, 17 Apr 2023 16:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XILsgfKN8YM9vEO6f8svo1gH7wbKuUFKNTudovDO3AMwhu1KcMP2ndVlo+ZJ9+3fo0N+dZzryeVBsfI2IZFFqXr0ZMoYJLdx06Dk4lAGBRs/lOcETmnD7noIi/C1B8wGr/ly7+xngXD9kdAF/epJuHR1G91Hpi+Sy+bazyDLsj1/LzdNdjkmU8OdSLEXjzkeIl90Xhx/nh/wvrlw3pUGP5bDXZOTFdDgVVUKCPsVpUrhx7mVyLK6Qtt5QKvzV2cn66t/9t+KohlTdb8dp5p50oI4dSn+6G7yR4XM8P3uP5J+4CHSsrpViCi9crn2vj6bjhVd3X9J6f9SwaV04+2lOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Wxlde95AsHw+0VAeqLIM+TbHm0GFJbbkm7bzu+8CBA=;
 b=VVv7gmDuhoAGeMhaVb1kLitZ02ftpEOoCi0YZp0bROrA2DiU5wgbuqHFMW3FRb4+41mvfxgm1jnggYtgf243rcNAowL/rcymNqqMNSav/J7FfVy1+Zi/5kNUlD6Bzr9RHYn43TUSJsb9INWh0NUeP9CfWkWod7yeBusFIMM274IjqCUfUh238HTnqOYgbWRMqmrnfXBmsKrTY8zZUXFPgv6yekmTO73gUxOHtd5PoWdaqlfj2aGsp0VtBZddDsNQk+xE2nIp56mb4G9YLqEs89pLIY663W4reDQooKj/f6vteIZsWnEWs767Ak6ve18Z1i2ZpptefpJzgiyHCAykyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Wxlde95AsHw+0VAeqLIM+TbHm0GFJbbkm7bzu+8CBA=;
 b=4DEO3u/bXtHmHDmwEQz8PTptQ7b+0xbCSVOOso8RmzLyFad95K+dcNgCGWUgta3/sWsZa5T7MkF76jVJh7e2MFnxzmXr3MzjXF4SHrYFAW/XRhPhTuFyQYNK28kb2+I42JMoZ6xTKjHIY0eHDWkKMxzaRJzUUT655raATfzO8Aw=
Received: from DM6PR03CA0075.namprd03.prod.outlook.com (2603:10b6:5:333::8) by
 IA1PR12MB6283.namprd12.prod.outlook.com (2603:10b6:208:3e5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.45; Mon, 17 Apr 2023 23:34:52 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::9f) by DM6PR03CA0075.outlook.office365.com
 (2603:10b6:5:333::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.47 via Frontend
 Transport; Mon, 17 Apr 2023 23:34:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.20 via Frontend Transport; Mon, 17 Apr 2023 23:34:51 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 17 Apr
 2023 18:34:48 -0500
Subject: [PATCH v4 5/7] x86/resctrl: Introduce "-o debug" mount option
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
Date:   Mon, 17 Apr 2023 18:34:47 -0500
Message-ID: <168177448739.1758847.17451432454091802068.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT008:EE_|IA1PR12MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: 1604e693-a5c0-4eab-1da4-08db3f9c576d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Of57r7sAAXyRvYdlwuJBrjlb+gxiIOhe4G2wqpF8cwH7+kCtc5dXoR0Qpx9PZcLilZWoJcZmiGDOVEIxn59UzyQW3jHh5JQmThdWiPr5tM9+NVAChhShqXRDMWl36x8yG2B6sJWE+6xQlC1zkSiXMygoZLDNG/fzkv1SUKAX70EVhQNWxCVEL6sCSELjQf19Shs8Cnt1L+MUrMZyo425gXCd4AV4cMR13qSmydn9tbPcJ4HQXOGswJx/MBAWk67l3KNv5lTRApz22Th8ULCszkcGQ20mMsJMZlsxAtYzBz6NT5aKB3bvNWWTKJdynT1tiNeIkCLM9QogEBTKDA68fa50R+HXAfgNV8kVW1B9PneMfG5oOaYKXnLYuglerjjEV8zPvayE3dkNgEZ+C9mwZX2Vtfl9qY16OhU/n5lRhcmtcFQu6Yzo1RGBRY3GZKZABZD88IsxT7a1wOZ+w0pD+8XSQvdKjF3EtTLGWlNy80LzMXNrIaGu2T7R6QVeMIZ6qoz0f+ffDNDMecm/+klKoU0GiH+Ih5tFiuh82IwuONk7tc+0MilJo3KLwnOMdWb9TUrlIa/ovVCJSuXjSnMTBiMpATBt8jiTBtC81dqAcNeWpqFtgcoKq+8xKlKRWs1Z4NBPp+KXgH2N3d0Z993e9FzbKWMTthuMizLUNAB9OzeuO0deQbqVwg+1IbdnnRtOox30pJGgUNKqJd0Z8LevozC3SwL7Rhcc82L2ttWrxfbvsnA2tKMnQyZFUoanjzOWHRqAwO80agMKa0BX538KFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(40470700004)(46966006)(36840700001)(86362001)(5660300002)(40460700003)(16576012)(110136005)(44832011)(316002)(33716001)(2906002)(7416002)(7406005)(356005)(81166007)(41300700001)(82310400005)(82740400003)(478600001)(36860700001)(54906003)(47076005)(83380400001)(8936002)(426003)(336012)(26005)(70206006)(9686003)(70586007)(40480700001)(103116003)(16526019)(8676002)(4326008)(186003)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 23:34:51.6492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1604e693-a5c0-4eab-1da4-08db3f9c576d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6283
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "-o debug" option to mount resctrl filesystem in debug mode.=0A=
Debug option adds the files for debug purposes.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 Documentation/x86/resctrl.rst          |    3 +++=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    1 +=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   13 +++++++++++++=0A=
 3 files changed, 17 insertions(+)=0A=
=0A=
diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst=
=0A=
index f28ed1443a6a..be443251b484 100644=0A=
--- a/Documentation/x86/resctrl.rst=0A=
+++ b/Documentation/x86/resctrl.rst=0A=
@@ -46,6 +46,9 @@ mount options are:=0A=
 "mba_MBps":=0A=
 	Enable the MBA Software Controller(mba_sc) to specify MBA=0A=
 	bandwidth in MBps=0A=
+"debug":=0A=
+	Make debug files accessible. Available debug files are annotated with=0A=
+	"Available only with debug option".=0A=
 =0A=
 L2 and L3 CDP are controlled separately.=0A=
 =0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 75ddbd833fdf..1eac07ebc31b 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -59,6 +59,7 @@ struct rdt_fs_context {=0A=
 	bool				enable_cdpl2;=0A=
 	bool				enable_cdpl3;=0A=
 	bool				enable_mba_mbps;=0A=
+	bool				enable_debug;=0A=
 };=0A=
 =0A=
 static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 719e29248892..0169821bc08c 100644=0A=
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
@@ -2387,6 +2389,9 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)=
=0A=
 	if (!ret && ctx->enable_mba_mbps)=0A=
 		ret =3D set_mba_sc(true);=0A=
 =0A=
+	if (!ret && ctx->enable_debug)=0A=
+		resctrl_debug =3D true;=0A=
+=0A=
 	return ret;=0A=
 }=0A=
 =0A=
@@ -2575,6 +2580,7 @@ enum rdt_param {=0A=
 	Opt_cdp,=0A=
 	Opt_cdpl2,=0A=
 	Opt_mba_mbps,=0A=
+	Opt_debug,=0A=
 	nr__rdt_params=0A=
 };=0A=
 =0A=
@@ -2582,6 +2588,7 @@ static const struct fs_parameter_spec rdt_fs_paramete=
rs[] =3D {=0A=
 	fsparam_flag("cdp",		Opt_cdp),=0A=
 	fsparam_flag("cdpl2",		Opt_cdpl2),=0A=
 	fsparam_flag("mba_MBps",	Opt_mba_mbps),=0A=
+	fsparam_flag("debug",		Opt_debug),=0A=
 	{}=0A=
 };=0A=
 =0A=
@@ -2607,6 +2614,9 @@ static int rdt_parse_param(struct fs_context *fc, str=
uct fs_parameter *param)=0A=
 			return -EINVAL;=0A=
 		ctx->enable_mba_mbps =3D true;=0A=
 		return 0;=0A=
+	case Opt_debug:=0A=
+		ctx->enable_debug =3D true;=0A=
+		return 0;=0A=
 	}=0A=
 =0A=
 	return -EINVAL;=0A=
@@ -3549,6 +3559,9 @@ static int rdtgroup_show_options(struct seq_file *seq=
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

