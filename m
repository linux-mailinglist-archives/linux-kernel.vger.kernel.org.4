Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD3C71F28E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjFATB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjFATBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:01:51 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D774E48;
        Thu,  1 Jun 2023 12:01:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehUxeGvyoQXvp66xMnH1dCyap0VKIDzwaCCjVe/M6W0fzwBSVVMvgEYvEW3D1m4dbJDhplfWiXBNUdHv4ITSgNOEUMEe865tBiSv1U25n5LblecW5u0/woHhgWhx5uJbrevh/hDKdi/F3cD5X/oYeuQHX9x4n7/aSesHjGpE7Z8wCstWD67Grtsl0VqlI5PldIcWF5t6nBwophiVnxDKVeFQ/gogrt3tnsX+l1xv7VCP67Yw/cyd4GN3CDvmgm8TNrPZtYXX83aAPVP/xXqlSmMr8AFhh80Lhhzt/2zBL5WSyCU8HcFVakIfw87r6UhqmSjgDRGaJ5ih5xdiIReTxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoVa02dLFHualE+BoKCmgPQ9TgNP0FupFOQWvV33T20=;
 b=D25libUkwKM2E+oxP3SwXRsB9MS5l7gYzQWkOO94q8xP1GmjrdCwKv0OAEekbB5lyffvQGkhn1fiEu8snI9mIecQKtop+gcZTNPmz9qSQzlZZocyCbgqyCIJietcZI7CkKQKZvcQ0mIESSfwPeoTWZhwCwxobZtJoNfp8iYv3WBZO3iOFi5HHs6ED8WHgH6SX2mVWQTN/CBhQw7SGGRpKSX2e5WJJQuNrkYorqVDtVJnW47bBshQpLsHR6iZei2PAHiASUZ3M62UC7i+ddvnM2k+QF9e61iu0rRIHXVdiahmvURk34YStym+353Lc8nzIgXr8JJKdi4b51Axof4jlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoVa02dLFHualE+BoKCmgPQ9TgNP0FupFOQWvV33T20=;
 b=qCoOP3FI0bKZj5Dr4P84pFbdWLwyl5FeR8mooCKXNyR8u7ByU7vDYPFOXf+cdoh7Ly4/nGaqdYUBVfCjI8/9WGw4q3Oeu25smRA+k5UJs5bSpWrFoerhAGA3ktpmMmONQj6fNKjxcqRL3uDbUYHj0XZQbcWwRtlutlBMo3WE7Kg=
Received: from BN9PR03CA0674.namprd03.prod.outlook.com (2603:10b6:408:10e::19)
 by IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 19:01:36 +0000
Received: from BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::68) by BN9PR03CA0674.outlook.office365.com
 (2603:10b6:408:10e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 19:01:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT081.mail.protection.outlook.com (10.13.177.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Thu, 1 Jun 2023 19:01:36 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 14:01:33 -0500
Subject: [PATCH v5 4/8] x86/resctrl: Add comments on RFTYPE flags hierarchy
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
Date:   Thu, 1 Jun 2023 14:01:31 -0500
Message-ID: <168564609148.527584.17320328540832247657.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT081:EE_|IA1PR12MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eaaa9a9-b9b5-4f65-b0ce-08db62d29f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zJ2WtJ7bvgw/5qWAXxu/XOMx5+bWeMQmIvSj59pr+W9G7crDcztDsddaVSyAYjtKbixHAXHVL9RwlCcpsDPcNST/TdatgFbn/IvWQkTn7u3h6UDwuUwrz3EENZCYoJtwd9Uev/oV4gcw9uJQnf5gavikl3wGnn9dh3bYtf89nh/wPgZCu5UOJDpayt1yBf57QVFpzOlRmwgLdbFPTW9HgU8+gsd9EEUAFvpBOsMumGZ7G4AyJcFmouxupR0T8uHyM5HbzR5Yq+gmgZH2BwnYzaozLgKWPE250Ykao/yKZudAQP5Vo2AMomZEGHxMhVVqQW4mgoizzjd7A/pzWYe7JOPRwSvkZiUCL6UZj9cZalg1FZR8Ve4hTVMB1h0ES6R0hxK8WqZvCF+pnCDdlsxWcn73tPFIQc8RfYv3Nn0AgOodahIpPmCllv+1VL3GSCAyqjsmJ61NRmFwSDvDK6AKy2zNKTcSzrcLSmzK3mSmMfmWguOw++rZzTnG74jjVrVVWypXHKQjqFZbR2mCnzCSDGahwX7e0JP6xX6aeRpHJyP8XlQMXNL77oOxObnrWw+qUAmW/fmKwk5ZJdfqXxOTn0PXDkovrGh4f+LzCVGo703a/xMLCRYxVPUGdt2TDachWF/Buw9mP+AjCw3D3COOjUB619mTX//YVmUfhI6Z+a7VI+8EvFhKnoIUmNtQY82UYHlFX8YqOcu81tZx6jGZFdsROOqKRZUhpdZAiWL09HIKNOyHEFJainAdH5AeFU81hxDgBY/YADHzkHumNF5mZCnGtUre8Zimy3MzyoHxh8s=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(46966006)(36840700001)(40470700004)(103116003)(33716001)(478600001)(47076005)(40480700001)(9686003)(26005)(186003)(16526019)(426003)(336012)(36860700001)(40460700003)(41300700001)(4326008)(356005)(81166007)(70586007)(70206006)(82740400003)(316002)(82310400005)(44832011)(7416002)(7406005)(86362001)(2906002)(5660300002)(8936002)(8676002)(16576012)(54906003)(110136005)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 19:01:36.0679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eaaa9a9-b9b5-4f65-b0ce-08db62d29f7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6235
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl uses RFTYPE flags for creating resctrl directory structure.=0A=
=0A=
Definitions and directory structures are not documented. Add=0A=
comments to improve the readability and help future additions.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |   45 ++++++++++++++++++++++++++++=
++++=0A=
 1 file changed, 45 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 2051179a3b91..c20cd6acb7a3 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -240,6 +240,51 @@ struct rdtgroup {=0A=
 =0A=
 /*=0A=
  * Define the file type flags for base and info directories.=0A=
+ *=0A=
+ * RESCTRL filesystem has two main components=0A=
+ *   a. info=0A=
+ *   b. base=0A=
+ *=0A=
+ * /sys/fs/resctrl/=0A=
+ *     |=0A=
+ *     --> info (directory and provides details on control=0A=
+ *     |         and monitoring resources)=0A=
+ *     |=0A=
+ *     --> base (Lists the files and information to interact with control=
=0A=
+ *               or monitor groups. Provides details on default control=0A=
+ *               group when filesystem is created. There is no directory=
=0A=
+ *               with name base)=0A=
+ *=0A=
+ *     info structure=0A=
+ *    -------------------------------------------------------------=0A=
+ *    --> RFTYPE_INFO=0A=
+ *        --> <info> directory=0A=
+ *            --> RFTYPE_TOP_INFO=0A=
+ *                Files: last_cmd_status=0A=
+ *=0A=
+ *        --> RFTYPE_MON_INFO=0A=
+ *            --> <L3_MON> directory=0A=
+ *                 Files: max_threshold_occupancy, mbm_local_bytes_config,=
=0A=
+ *                        mbm_total_bytes_config, mon_features, num_rmids=
=0A=
+ *=0A=
+ *        --> RFTYPE_CTRL_INFO=0A=
+ *            --> RFTYPE_RES_CACHE=0A=
+ *                --> <L2/L3> directory=0A=
+ *                     Files: bit_usage, cbm_mask, min_cbm_bits,=0A=
+ *                            num_closids, shareable_bits=0A=
+ *=0A=
+ *            --> RFTYPE_RES_MB=0A=
+ *                --> <MB/SMBA> directory=0A=
+ *                     Files: bandwidth_gran, delay_linear, min_bandwidth,=
=0A=
+ *                            num_closids=0A=
+ *=0A=
+ *     base structure=0A=
+ *     -----------------------------------------------------------=0A=
+ *     --> RFTYPE_BASE (Files common for both MON and CTRL groups)=0A=
+ *         Files: cpus, cpus_list, tasks=0A=
+ *=0A=
+ *     --> RFTYPE_CTRL_BASE (Files only for CTRL group)=0A=
+ *         Files: mode, schemata, size=0A=
  */=0A=
 #define RFTYPE_INFO			BIT(0)=0A=
 #define RFTYPE_BASE			BIT(1)=0A=
=0A=

