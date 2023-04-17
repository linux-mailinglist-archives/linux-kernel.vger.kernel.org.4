Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A7E6E554B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 01:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjDQXfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 19:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjDQXfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 19:35:22 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF176588;
        Mon, 17 Apr 2023 16:34:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeDzz1Zti2nbIuPgrEzzuqkKivalBP8in4pDEV5dK0jpE+ANdaIFsgtB7e8iqqKDVBa/9tvywiRmpssjtAbgZEFvhpDeIoLbgDu4+Zf3xk7UWKEnsO1qtmDHwaoqhlew8vESvAcUYD6c3cB/FTqEscx4QFiiK45ysOMdIb4FxO2Tm+fgh1bLa07aZXdlhX+BglBUJmqHQckH2WcUelXIzoml7r0WkL0vKlzrpR8km/g4ys0rY/deTGw5O2nEPOS/sgX/WkqbIMe01ZYR9n44dVmuB2mGZKBx2zzz6Nq36Ya8LMWVHT4gcubvDZUc3jtRrSSsuO4WM+5UxDC1APVdOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v739naT5KE3Eh5/kn8BKuSPeFkot4CMRU58/JZpHQl0=;
 b=kFOV0uQOSTmRb2rVsVctFI+NcsKQttbeidht0hfhO0Wo03/1r2jnZvx3j4fRlBEtqAJcy0NO51rYTChhZeF4zUX6oUz2BOtPlHIUq5vOxq9yNANbS1KgumonEbdz+OuWy7KynmvuV1cuFJsQ1YtmUQRRG1Tn0nuS9gzOGudit/cZBbXuvTemQJpvEd/5KP6F48cMIcg1LBKEQqIKAapRs1/e2+3uTaiQWYZxSiusR+GFF3/+aMRYpKClHLfzBFpTUwfIdSu2D3oXFVHZKZKkTXBKPaM58jrekS9PWJXKsbWrW1SSF5hBP6i0qmg4qgJO7Nkms81x1zU1toCjZHKOdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v739naT5KE3Eh5/kn8BKuSPeFkot4CMRU58/JZpHQl0=;
 b=cbtLIaZTbY/66Q1aEWXh9ilLP+p0vxxn6c0tk0AqajnCktWrEBP+Kn+254habajzp6VwYCNuZaI6pCuUQIR/FFyHxSHfLnMWfHvNpt/Xn/guohjjvnAMCaoZCDHHgp7EoG0OOIIrIkoq2s/OVGx3quGsPGQekmz/KxsqAFzB1t8=
Received: from DM6PR03CA0068.namprd03.prod.outlook.com (2603:10b6:5:100::45)
 by SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 23:34:43 +0000
Received: from DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::a8) by DM6PR03CA0068.outlook.office365.com
 (2603:10b6:5:100::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.46 via Frontend
 Transport; Mon, 17 Apr 2023 23:34:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT086.mail.protection.outlook.com (10.13.173.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.20 via Frontend Transport; Mon, 17 Apr 2023 23:34:42 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 17 Apr
 2023 18:34:39 -0500
Subject: [PATCH v4 4/7] x86/resctrl: Re-arrange RFTYPE flags and add more
 comments
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
Date:   Mon, 17 Apr 2023 18:34:38 -0500
Message-ID: <168177447844.1758847.17789021842152864417.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT086:EE_|SA0PR12MB4576:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ae592f-4360-496a-6383-08db3f9c521b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MaUXaOWqWPgdlqcblRBzar1CmK3E+5+D5TihpNlGjrngAgVPtyNJ06Ze+Z5uQiFhxkt7b9OMsIulCvWJYHWAdeMUQNTIOZ0pNo+wvjAYAkPP3ko7BQxmj+af7CJFdBYUyKExZ8Xbg736FAte5IOkdj639ICG8djlpNy51CC5rdyAoNXDy6LAOxt/aMDxYAwIp8CAR8xrD+AMVOl7usB6HykfzDFojoc9bKwaPdPF8ulBN/QzJx/lt/aRT19DV52OSqt2onTbm/OejALx3nYSf0QfL7uEk0+Ed6JMjsuGGjPyIEoohdQhccmC0GjqeV5XVYKpKl0ihrAAJ5kyG4n0Jyil4baVU149igTIPKiZ8P+f4bkWlvfp04vS4Jr6OGkpBWDvv4r2dYAGG2weYWxHuHU9CZ6ejGNIqMBlVSpsz+CMkEBJuFNoqIwgHab81cY+R848V3+HmGMj6/HO4DrYfrzeX4qy/HKl/XJedim576hN8lI2zKy5Z3nEzeqBLvactyVz6gWuIGuhnZEZnWWwsreLKiilmJfZ3uiP7wzMpia5scM2Wa73HFuSXZZS5VM0ba4uJyW340YshrrZEubKRHJjNEfxhMIjJu/pPnPQdB4tVungYWuLG2D5imlo4bVheeBWoUmPWOh1mcjDyttYROoEu3U5w2E5XyhJr9y/OwF9M/bJrp7EI1VIOS69a51NgD+UDD5/FqDnd1tOxXZStgu/Mm4G5R4/V8STa/ndkdoPgUDUS3a6iSDTG+cAKos7W9Soy0GXzEDyhrcaC0mWOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(54906003)(16576012)(110136005)(40480700001)(478600001)(16526019)(81166007)(316002)(83380400001)(41300700001)(356005)(82740400003)(426003)(336012)(4326008)(47076005)(36860700001)(186003)(26005)(9686003)(70206006)(70586007)(5660300002)(7406005)(44832011)(7416002)(2906002)(8936002)(8676002)(40460700003)(33716001)(103116003)(86362001)(82310400005)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 23:34:42.7250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ae592f-4360-496a-6383-08db3f9c521b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4576
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove gaps in bit definitions of RFTYPE flags and add more comments=0A=
to make it easy for future additions.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |   49 ++++++++++++++++++++++++++++=
+---=0A=
 1 file changed, 44 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index c4fc5a1c630c..75ddbd833fdf 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -240,14 +240,53 @@ struct rdtgroup {=0A=
 =0A=
 /*=0A=
  * Define the file type flags for base and info directories.=0A=
+ *=0A=
+ * RESCTRL filesystem has two main components=0A=
+ *   a. info=0A=
+ *   b. base.=0A=
+ *=0A=
+ * /sys/fs/resctrl/=0A=
+ *     |=0A=
+ *     --> info (Displays information about control and monitoring)=0A=
+ *     |=0A=
+ *     --> base (Displays the details on resctrl groups)=0A=
+ *=0A=
+ *    -------------------------------------------------------------=0A=
+ *     info directory structure=0A=
+ *     --> RFTYPE_INFO=0A=
+ *         --> RFTYPE_TOP_INFO=0A=
+ *             last_cmd_status=0A=
+ *=0A=
+ *         --> RFTYPE_MON_INFO=0A=
+ *            --> (L2_MON)=0A=
+ *            --> (L3_MON)=0A=
+ *                max_threshold_occupancy, mbm_local_bytes_config,=0A=
+ *                mbm_total_bytes_config, mon_features, num_rmids=0A=
+ *=0A=
+ *         --> RFTYPE_CTRL_INFO=0A=
+ *            --> RFTYPE_RES_CACHE (L2, L3)=0A=
+ *                bit_usage, cbm_mask, min_cbm_bits, num_closids,=0A=
+ *                shareable_bits=0A=
+ *=0A=
+ *            --> RFTYPE_RES_MB (MB, SMBA)=0A=
+ *                bandwidth_gran, delay_linear, min_bandwidth,=0A=
+ *                num_closids=0A=
+ *=0A=
+ *     group structure=0A=
+ *     -----------------------------------------------------------=0A=
+ *     --> RFTYPE_BASE (Files common for both MON and CTRL groups)=0A=
+ *         cpus, cpus_list, tasks=0A=
+ *=0A=
+ *     --> RFTYPE_CTRL_BASE (Files only for CTRL group)=0A=
+ *         mode, schemata, size=0A=
  */=0A=
 #define RFTYPE_INFO			BIT(0)=0A=
 #define RFTYPE_BASE			BIT(1)=0A=
-#define RFTYPE_CTRL			BIT(4)=0A=
-#define RFTYPE_MON			BIT(5)=0A=
-#define RFTYPE_TOP			BIT(6)=0A=
-#define RFTYPE_RES_CACHE		BIT(8)=0A=
-#define RFTYPE_RES_MB			BIT(9)=0A=
+#define RFTYPE_CTRL			BIT(2)=0A=
+#define RFTYPE_MON			BIT(3)=0A=
+#define RFTYPE_TOP			BIT(4)=0A=
+#define RFTYPE_RES_CACHE		BIT(5)=0A=
+#define RFTYPE_RES_MB			BIT(6)=0A=
 #define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)=0A=
 #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)=0A=
 #define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)=0A=
=0A=

