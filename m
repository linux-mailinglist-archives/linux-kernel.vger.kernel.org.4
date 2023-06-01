Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234FA71F289
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjFATBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjFATBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:01:15 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C5618D;
        Thu,  1 Jun 2023 12:01:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7xfuOtRXRmHvN4TfUjSi3R+rA9ie7cWj7kEDFEvAIa0w1I/yG3YdTRZNvST+4rD2W8Nj+RoeEph4AgpG42ee31XrO2Msb+TG7cpAbt3kn1WuHQfKkcopKgZk80fkmmis/Zi+JYNo4i/aMVMi+KyJw16URrAzPJZbzEYurmu5qrDRhvRC8Uer+vfTH28ULOJYt8Rv5ujs+1p5AU8sUFT+QkzECVPRjFx8cxlBCsgw6PyqTwSD8Hm8GXOcRDOmQ+ZIlica4WUf72OWuJLhfKOSx4ETLw4rKncJZv70scXpoIqE1xNqxb3dmExAOj3BvF5e+MRfW47CIN7+88thBxB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlnhP17pFYN7SOTt0fSv/J4PlLca4pwPzJyMFj3G0UM=;
 b=cIlmUE35IG2m9/P+//kz5wPzdY8yJ36H4wc27uB32MucNcVockE530jE6CAafglkwXw6tU/TQwhlTdE7JgufjKsuo65IYyDTgIqLj20qhhm+AK8Vod2oMG+eR3ZjKMXB4vh1IRnqtlvwSpH/cxtMTBnrH36/y5JRedYuxcGwikAfG9QA7suMn6aE/1SgqpuOO1x00hQKenxgk6NvcSawVM07gavmGJv7HGMPJ8CF1tkCiyn8aWvTwCRNyHZWEG/cDD0NtXCu73trYvmN6d40NNDRAa+f3Sq3lB/xhJtcExm3ghSL2UGJ4cqMUSy5JafZ0dPdSx4bxXvKZdLM8P+4Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlnhP17pFYN7SOTt0fSv/J4PlLca4pwPzJyMFj3G0UM=;
 b=TFpHqsR1Kmlh9T0CjgPAmdCn40Fym317+Mkt0kbNLPdmWWN38EAslOwLXRLF4yvIzC1hQ5rFho/PrW4wxZaDyy895+71bvmAMnXe2tLsTM/xrRz0dk/MH+cx8R3EX8/0xza/AuXSaL7TpStmezvsFtCmldIGf1ScREok9cnosgc=
Received: from BN9PR03CA0282.namprd03.prod.outlook.com (2603:10b6:408:f5::17)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 19:01:09 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::9a) by BN9PR03CA0282.outlook.office365.com
 (2603:10b6:408:f5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 19:01:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Thu, 1 Jun 2023 19:01:09 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 14:01:05 -0500
Subject: [PATCH v5 2/8] x86/resctrl: Simplify rftype flag definitions
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
Date:   Thu, 1 Jun 2023 14:01:04 -0500
Message-ID: <168564606414.527584.9565322327658331140.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cab67f2-1f71-4b8d-fc38-08db62d28f84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yM0ONVZ7DoRNQs7ZA7e+MWnKelTLyRdGPp6q+Qhus9wgAdRBjWWT6WFQ4Xt1y+rb4xKC1oy2YEFDnZHQA3ccJXY+Io5RWncNRP9LaJ2EAuVoIlKH+D660ryzE6z3mu4aWcB+q56uQYQYRIQjaeabMd3FBtrgdwXgs2zkDIoVHiF7Ka5HogiplKDgKY1aXzyOcqe9K0wRjhkJhu/Tc4ppkeFoI/YJIRFXDawhUJTEGIvLnNPYejhcaQ+SQY/kOjtYfpCpM2q9DnTklXlkiGRb9daIuHE7hRAUwNijAV/noPzJ8lEopQr0Epo4wfmVFqYuS2gIW3zFnqus6G0i8OXVV9KqJBFPSDrXY+gkDKPXi/XTIfLVTJYNGaLzdgtZapuOa9luXggyzBaatqCblAvQr3GqEqU9DUWoypls7NPGOoFMY0FPDb33Exx8iDoVUPZI1GF2IpZHfExHSCIRQgCH+fjIjdVUrR5Gia+yhssvTYq3RzVOPyXTZPjl6bXRoBZtCwqABVHjV0xMA9dnW5oc/FJ9zVatjXPFT+5M9hlO46A6Ms9QfVEO3mWJziazylOqp1YE4Ky8GgFiHxkQ5jJjZOrb2Qdu/05lHD7pgG77XzDOf0tOfhDqnyUNNY2ILl/EUBEm1clLWpRGW8f9bx8MUE9cKf+jMMpXYIcjVJ/fcu33nKqFKr5fhrj8RwlgZVV0nyll362ABKyPP4+gGcUbpMgtHMXHIRLngrwq35uTtDDJSxWnBiM/nLL+yFSSFkp45r5C3JyFxTbTz7Q62/vKIDBpKxdDwAAqvi6ZbyCKVao=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(16526019)(36860700001)(2906002)(86362001)(336012)(426003)(70586007)(70206006)(81166007)(47076005)(41300700001)(186003)(4326008)(83380400001)(356005)(82740400003)(44832011)(26005)(9686003)(33716001)(8936002)(8676002)(103116003)(40460700003)(5660300002)(82310400005)(7406005)(7416002)(478600001)(40480700001)(316002)(110136005)(16576012)(54906003)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 19:01:09.2943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cab67f2-1f71-4b8d-fc38-08db62d28f84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rftype flags are bitmaps used for adding files under resctrl=0A=
filesystem. Some of these bitmaps have one extra level of indirection=0A=
which is not necessary.=0A=
=0A=
Make them all direct definition to be consistent and easier to read.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    9 +++------=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |    6 +++++-=0A=
 2 files changed, 8 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 85ceaf9a31ac..62767774810d 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -243,12 +243,9 @@ struct rdtgroup {=0A=
  */=0A=
 #define RFTYPE_INFO			BIT(0)=0A=
 #define RFTYPE_BASE			BIT(1)=0A=
-#define RF_CTRLSHIFT			4=0A=
-#define RF_MONSHIFT			5=0A=
-#define RF_TOPSHIFT			6=0A=
-#define RFTYPE_CTRL			BIT(RF_CTRLSHIFT)=0A=
-#define RFTYPE_MON			BIT(RF_MONSHIFT)=0A=
-#define RFTYPE_TOP			BIT(RF_TOPSHIFT)=0A=
+#define RFTYPE_CTRL			BIT(4)=0A=
+#define RFTYPE_MON			BIT(5)=0A=
+#define RFTYPE_TOP			BIT(6)=0A=
 #define RFTYPE_RES_CACHE		BIT(8)=0A=
 #define RFTYPE_RES_MB			BIT(9)=0A=
 #define RF_CTRL_INFO			(RFTYPE_INFO | RFTYPE_CTRL)=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 504137a5d31f..181612d2c84b 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -3220,7 +3220,11 @@ static int mkdir_rdt_prepare(struct kernfs_node *par=
ent_kn,=0A=
 		goto out_destroy;=0A=
 	}=0A=
 =0A=
-	files =3D RFTYPE_BASE | BIT(RF_CTRLSHIFT + rtype);=0A=
+	if (rtype =3D=3D RDTCTRL_GROUP)=0A=
+		files =3D RFTYPE_BASE | RFTYPE_CTRL;=0A=
+	else=0A=
+		files =3D RFTYPE_BASE | RFTYPE_MON;=0A=
+=0A=
 	ret =3D rdtgroup_add_files(kn, files);=0A=
 	if (ret) {=0A=
 		rdt_last_cmd_puts("kernfs fill error\n");=0A=
=0A=

