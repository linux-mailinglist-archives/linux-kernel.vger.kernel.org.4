Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7021261A1BB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiKDUA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiKDUAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:00:43 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEED45A27;
        Fri,  4 Nov 2022 13:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUF15wbMHz57uMBdB4UM76cmLoCrjgAhEjxpkKeFCxTZaiWKlyBTd5vAzhxl0Odn6UDJPH3wRIboA22DL529Ofsz0D/sst3489G82nYgopL09dN9vMnLq3exdrLDIRht8/cPZSx4PcKqBs1I6ilEsJe/UcGAjOaOTbVoVnbCBiaefP5ZsdP6cbO+l/Jk9l2yzZcgQ+En2uZt4d37mWLw+z7niJI+EbYTCYHMZXjLPY4VlcX2q5cKYVbQvTp6oL+5aQpPYuZh8utZwSBD9J/tITEGrXreg2TAPsIgd7ZEyKml96gfrKPtRpqJMNEt3B37HRk8gZEaePdB4Hk+mKCY9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUNml/GcRC1L5UbtzmycKFoVbdM/W6e2kLFg/9v8EUQ=;
 b=DwnMmyKMcKLFpqtHgezYjAXweBfk6QzloWuCQESlXyHS+FG1EWYPIs43Oj7/xHXfjRvp1Ig3YmNenduorXlXS9er8WQf9q/H+kRHqZMFU66CaGIppFVMnai5E16NLeJwDsyV8dpMlH7U4eId1LIJi+nWbfRtB20OXidWmsmo1PcNBw/GCbtMbJMplgwhHPlocZalYk9I2g8HbwYNvJUy9Pl9m0BQc++uBdr5yux/+wKS4VwM5OHSCHB3eDNDOiptXyuSQUckqcaStlcH2Cr29ZqKn0A+tXx3qVu50+8riajH+V67N9XBNUGzR+T0/HhbcgYcHZ4ZphPcYgMP3Msp2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUNml/GcRC1L5UbtzmycKFoVbdM/W6e2kLFg/9v8EUQ=;
 b=SBNr7Na3r74zjNGDPy8uSeUkrB+ykuCJuctecj6ZbVCDfflFBmuEEKw7sy16edc9MaSkVuPY/c6fXh6jv/CqibQXIrsEWzoZRWHWjBcKAmd3EYtBK5pXSUC4AOWx6zHdIXRq95k4fQe7Q4fNey5O3omKarpU+hMaHBj2vfdOhyI=
Received: from DM6PR10CA0026.namprd10.prod.outlook.com (2603:10b6:5:60::39) by
 CH3PR12MB7644.namprd12.prod.outlook.com (2603:10b6:610:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 20:00:39 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::bc) by DM6PR10CA0026.outlook.office365.com
 (2603:10b6:5:60::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Fri, 4 Nov 2022 20:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 20:00:38 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 15:00:36 -0500
Subject: [PATCH v8 06/13] x86/resctrl: Remove the init attribute for
 rdt_cpu_has()
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
Date:   Fri, 4 Nov 2022 15:00:36 -0500
Message-ID: <166759203614.3281208.12929995949176975687.stgit@bmoger-ubuntu>
In-Reply-To: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|CH3PR12MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: bd087f91-cbd0-413d-a2ef-08dabe9f3ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HC7mWgj+EayOjw949XOVElJrgd/eLdAUzGDbFzbTOt76KfcpDgCW8yFwzMauYiyCtE0UwXeG15CtW0+oXTlCh5xW7ffEowDk2wL2L+W9NuqTTGus2apRJbfAMNWbeYZfoYJwS1ja+b7SIurw2YbMZ43fYWz9gaH/Swo4S/Ikpctrpbit2+EtsdKQMYGIUSUdq0h7T3mod5ylPdWLcRpFIQYznMpva6fCaSff6Rs0zIw31iJ2YK/EiRVeleuqGdPzCeQNLBikmk7p+lXA4gIttwaMS+Bqir23mNRQXHvjBOsjCYACa7P/OXEeCmU+jEZqdQrTc9LtGjJ/p90jGeSOA9yfI75nmPu+68+RF1Vu0wdiIJVwnaSzREnyxgqz8MXnOTT2nJSyyVRqeP4q9EXUYgtz1pLSu16S16zpWaWpgYc8QOV5aN8xEXzL9GuhMlnIsRUCK6J5W1TYnM/Xr6qEYx5gkpnOeOM3K54MNNB9+8Q7PUZgRD3LLczYNJ6GcQQ6osx/YBuN39jUiAo85SaHZ3X+xrP+CWuhGtI0b+jYuyrgWKO1IK8ely087vcCEpRgh/b42zWoOGWUMkFhps8RFRmj3dUkj5/zvacPOOf5r6vJtrLbAmKRrwOiIkM0kVjij7mbbxuUbHn7DdvIhY1WFl5ck1Me/dPJOElwaT4d6ZSbZfk0FsTDtV00Cns7F/1kSggMzAR7lkadPHk1Hor9zQ5Y3/EHiLzcPAOhqyhfVXxTXXFJrlQ+k2HFw+PBdX0IhcHPFasIzFjAxeGuW5gPvgTpCjWwRJrQkGJkEUcGf50CQ/mXfhOIvirg2k88tuIBhyxHMnmF5eEcCxKm+esMeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(39860400002)(346002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(16526019)(426003)(9686003)(186003)(83380400001)(336012)(26005)(47076005)(2906002)(82310400005)(40460700003)(70206006)(4326008)(7416002)(70586007)(478600001)(82740400003)(8676002)(36860700001)(81166007)(44832011)(103116003)(40480700001)(8936002)(41300700001)(5660300002)(316002)(86362001)(356005)(54906003)(110136005)(16576012)(33716001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 20:00:38.9970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd087f91-cbd0-413d-a2ef-08dabe9f3ee4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7644
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The monitor code in resctrl/monitor.c needs to call rdt_cpu_has() to=0A=
detect the monitor related features. It has the init attribute and=0A=
cannot be called in non-init routines. Remove the init attribute and=0A=
make it available for all the resctrl files.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/core.c     |    4 ++--=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    1 +=0A=
 2 files changed, 3 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index 6571d08e2b0d..b33a541f5c80 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -688,7 +688,7 @@ struct rdt_options {=0A=
 	bool	force_off, force_on;=0A=
 };=0A=
 =0A=
-static struct rdt_options rdt_options[]  __initdata =3D {=0A=
+static struct rdt_options rdt_options[] =3D {=0A=
 	RDT_OPT(RDT_FLAG_CMT,	    "cmt",	X86_FEATURE_CQM_OCCUP_LLC),=0A=
 	RDT_OPT(RDT_FLAG_MBM_TOTAL, "mbmtotal", X86_FEATURE_CQM_MBM_TOTAL),=0A=
 	RDT_OPT(RDT_FLAG_MBM_LOCAL, "mbmlocal", X86_FEATURE_CQM_MBM_LOCAL),=0A=
@@ -728,7 +728,7 @@ static int __init set_rdt_options(char *str)=0A=
 }=0A=
 __setup("rdt", set_rdt_options);=0A=
 =0A=
-static bool __init rdt_cpu_has(int flag)=0A=
+bool rdt_cpu_has(int flag)=0A=
 {=0A=
 	bool ret =3D boot_cpu_has(flag);=0A=
 	struct rdt_options *o;=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 16e3c6e03c79..e30e8b23f6b5 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -499,6 +499,7 @@ int rdtgroup_kn_mode_restore(struct rdtgroup *r, const =
char *name,=0A=
 			     umode_t mask);=0A=
 struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,=0A=
 				   struct list_head **pos);=0A=
+bool rdt_cpu_has(int flag);=0A=
 ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,=0A=
 				char *buf, size_t nbytes, loff_t off);=0A=
 int rdtgroup_schemata_show(struct kernfs_open_file *of,=0A=
=0A=

