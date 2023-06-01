Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F9271F297
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjFATDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjFATDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:03:02 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EC9E4C;
        Thu,  1 Jun 2023 12:02:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmeCByQ/YO8SckBUAAYsnDDlRU8L4MJiplWNHv9dNHutJpd/DpOK1N/z37UwRSrMIV+0GsV5afTK26TxH7XeOEcNlkZ0sX4LwRxN9d2Hm/GDdWNQG+B48HF21W3z9Qg9hkH2byOe4gk7/DOnIS4ij7n4yIkyqLUr5iyHzZqEWwVRuqmFgzqu7XVndQyxxjRrrFxmSSt4sQRpmV24jBnd9Nw1FE7jkOWvuQhGJxOoMZw/HMY14cLmV9PVDjhDc9eIkhq992k0mxpbrX2RzQeOr5MYzpO/Zjr1bMZ6IUFSk9Yn9sCpu0KYgF3+weC3NTk7SGdW5ja9uRg0RXU6nHIJFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OP3izmuN35dIUh+t44uEj8GzBCiBS9lxHY/vshGP5g=;
 b=MtM473ky7NSLLxKeqspH/iMnB1Zg5k93L1FOlWpEWI3/zu9Zm1ykZdkO3xkd0tjq9M0VLSg3vAHJqEr3JBm3ScdOVlzv8WPSTn3OAqaCZodpkorH4QrFNRNy1DAEgxRCvTu+2zejTAanUTSDwdnkkLLHMX+gucFdQnXWRfi2NuAkLPvKVwFAKESQqcD1yCjTDMlY5NrubaJN5OdlGbMmKG/ekzFsvef3ndBZ3mkcw6yCNoNelIdVJWvqwf7ptY+kqDEnrOW3LEfVVjAm8FAZmJfpH6QQbF/n47lUZ7mZ2tOYdKxDRHlJoBOBp1K2aXU4ZN+4ACZ6l5v8aNxhuSP0uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OP3izmuN35dIUh+t44uEj8GzBCiBS9lxHY/vshGP5g=;
 b=2wblee+8wRF0RmmVqldUeeUV59c/j6DnFlHMyy3jsnxWPxjIiI9q1nRJT0lp7+RiveJwFL9EnXJBiHiQftLfx+A3MEbDwR2kf2FIz/MvKKz/0Qo18442bUeoFMcwFP47Aoqml9J2E/61eTevYFMhyRDNUTu0VnL2bMDi/y+5E60=
Received: from BN7PR02CA0031.namprd02.prod.outlook.com (2603:10b6:408:20::44)
 by DM8PR12MB5463.namprd12.prod.outlook.com (2603:10b6:8:27::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Thu, 1 Jun
 2023 19:02:22 +0000
Received: from BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::b1) by BN7PR02CA0031.outlook.office365.com
 (2603:10b6:408:20::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 19:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT109.mail.protection.outlook.com (10.13.176.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Thu, 1 Jun 2023 19:02:21 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 14:02:18 -0500
Subject: [PATCH v5 8/8] x86/resctrl: Introduce RFTYPE_DEBUG flag
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
Date:   Thu, 1 Jun 2023 14:02:16 -0500
Message-ID: <168564613667.527584.13233260903070279360.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT109:EE_|DM8PR12MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: db3550a6-92e1-4b36-a7c3-08db62d2ba88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hrr8cmr3cVMGrqEPl1gdY7wqzahCwkjl6ILwFj5El3s+VJsJ0qXmqnDO2IvCysGig4ux5EEsYDF5ZVE5IbPIWdnAfQieAkPvRkEVmOzLDEGTk6mK9+ubPJe8ITBMoiEsggX9uGHLSZaFXgSn9/2WiCHJSnpfiCNx84cnsgMBtFLI9lnsKOEfatj85LNx9eG2a1qlNakjiRzhezpHK1ZPZDWqPKlUiIzVsYoBTcbfGof54rtwj/vm2vbKsKD9BJsSm+icLDHetsW0pbUv8XM+D20Pjs2bFQdh3WkFT0JCoIi6WEq/AePP/BfurFzRMM8CFD/JvRjYlJP0WPLhO0mzyEiT0s+QTUCk/s6Wbq3FqXAPEYrzRd4u7dvQAypmANZsvo3SC0tHV+UkPr4dbBqKuiwGdLSh6DaQoG7V4cxYI1/gvNW8gvVhnPZib1sJaEo4WSPo/2GNb77lPyliPkLoPyY7OCFTEw2fInxPPNlRoSBvsRCSwLOtgXNmBrLiyu1HBsHABd4QBI+F/OssSGYduflk9Y9reAwxfHWf2o04ulpABZ5y1B+XB1jBVwH4tggfsmOTyxsaAbkjnd3MBTel1mjjoDZGrilYCqUWaCIGpEnHRi8vXyPaRkINXDanL8AiIJVW51EyuZdW3OO4ZtEmd8fEAiCAAvOy0ujXqFqU8tG7Dsx4Q7xxulZDXGMUlTeJ7upHz3R9KSUqIIoVIp+jEMaULLEkQRQBP+hgWbcjs0BxoPs2B657+Dse0BS+SV8LhQaBDSWEWkCbgeYNe+Zm7yLdXvyXbSTiyy6SrimT9Wc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(346002)(39860400002)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(36860700001)(336012)(47076005)(426003)(83380400001)(82310400005)(86362001)(103116003)(81166007)(82740400003)(33716001)(9686003)(26005)(186003)(16526019)(40480700001)(356005)(110136005)(54906003)(8676002)(16576012)(2906002)(8936002)(316002)(41300700001)(5660300002)(7416002)(7406005)(44832011)(4326008)(70206006)(70586007)(478600001)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 19:02:21.4604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db3550a6-92e1-4b36-a7c3-08db62d2ba88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5463
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce RFTYPE_DEBUG flag which can be used to add files when=0A=
resctrl is mounted with "-o debug" option. RFTYPE_DEBUG is OR'd=0A=
with other RFTYPE_ flags. These other flags decide where in resctrl=0A=
structure these files should be created.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    1 +=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |    5 +++++=0A=
 2 files changed, 6 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index c07c6517d856..5bc8d371fc3e 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -294,6 +294,7 @@ struct rdtgroup {=0A=
 #define RFTYPE_TOP			BIT(6)=0A=
 #define RFTYPE_RES_CACHE		BIT(8)=0A=
 #define RFTYPE_RES_MB			BIT(9)=0A=
+#define RFTYPE_DEBUG			BIT(10)=0A=
 #define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)=0A=
 #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)=0A=
 #define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index e03cb01c4742..9e42ecbb9063 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1862,6 +1862,7 @@ static struct rftype res_common_files[] =3D {=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdtgroup_rmid_show,=0A=
+		.fflags		=3D RFTYPE_BASE | RFTYPE_DEBUG,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "schemata",=0A=
@@ -1891,6 +1892,7 @@ static struct rftype res_common_files[] =3D {=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdtgroup_closid_show,=0A=
+		.fflags		=3D RFTYPE_CTRL_BASE | RFTYPE_DEBUG,=0A=
 	},=0A=
 =0A=
 };=0A=
@@ -1905,6 +1907,9 @@ static int rdtgroup_add_files(struct kernfs_node *kn,=
 unsigned long fflags)=0A=
 =0A=
 	lockdep_assert_held(&rdtgroup_mutex);=0A=
 =0A=
+	if (resctrl_debug)=0A=
+		fflags |=3D RFTYPE_DEBUG;=0A=
+=0A=
 	for (rft =3D rfts; rft < rfts + len; rft++) {=0A=
 		if (rft->fflags && ((fflags & rft->fflags) =3D=3D rft->fflags)) {=0A=
 			ret =3D rdtgroup_add_file(kn, rft);=0A=
=0A=

