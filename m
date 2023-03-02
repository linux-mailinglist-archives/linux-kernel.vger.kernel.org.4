Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D37E6A8A2A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 21:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCBUYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 15:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjCBUYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:24:39 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F358E2F7B5;
        Thu,  2 Mar 2023 12:24:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVYmm3TbMsTC6P0HAGzu41587VXuKO2Y+687Rd+j+UBIVSlv7B+dae77y8UziiLsDCsc4Ny4pg2eVd49qTdF4KV67Ok0TCaKxdBm9ANXGXiw/+naT9dIW08i0m0poU+ZU9KnQNMMytQOA3x57tg/TLh52XUu8tzBmtYA6D01f4htcU944wkdm05DcemE8AONC3Osa9UBDWP+6t5cz57BgoliTMo7lQIs8a7FIfgm04mRLeJGsfzmXu7xFNxE/yBRnNCZ+QZ0RaSHT+TNxZsrOddQQrLE2jqmWbCERB/DQ/xLd9VpOjweXt84wdpEkJ+tmhR9mWxUKaNkmSnFBfawPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAuZmTFRzC2XzIYM432jNnpzNS8EmX1ldEFl1zp4MPY=;
 b=HHyEreJJRTgWrt3fe7JXrq5rRsBiS9Dyxff38HwynnVAO+uSyQ93OgSJpjspkM1523+LDqKt80pZL4cUM8UgT3sUYkCCqhJgvX7KXqXsW5ycCyUgSG8SxPjUOOFljQIkQN8GJ5delztN8YNqS4HeHCt3PxrbXKW3Tc85a0PCNd4JI6Lv8cP1oLQZkDNAhLH+XRWMRYF4fNoWkVM8KqdY1OfYRkS/9XzaOBvVkJcvzd2xR7J5hDqO/BVrQWx6+dMCXMLHkggNjofM+6XAqktxf3whxrZRnwuulBlS9qCQgtgQwM3RIYrxIELyJCXIvRZDg64xb6h9zQycSXO44Bn2rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAuZmTFRzC2XzIYM432jNnpzNS8EmX1ldEFl1zp4MPY=;
 b=pXi4KixdEymdA6hZXPDnASCms1nPFe0bZ3uJqw5WRXXyJ5L47yJWhWDmsP1cozdSsuqC2qMjixpaGXf/PN7KImb3tVMH9e4RZzdsagB4n/TKtKuOCyLgjfYCee6DhiUCE0w2XBRGRJmLr/18IXMaBlzUo8Cj+XcGhPxdQM6Xyjg=
Received: from DS7PR03CA0173.namprd03.prod.outlook.com (2603:10b6:5:3b2::28)
 by PH0PR12MB8150.namprd12.prod.outlook.com (2603:10b6:510:293::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 20:24:35 +0000
Received: from DS1PEPF0000E634.namprd02.prod.outlook.com
 (2603:10b6:5:3b2:cafe::9) by DS7PR03CA0173.outlook.office365.com
 (2603:10b6:5:3b2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Thu, 2 Mar 2023 20:24:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E634.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Thu, 2 Mar 2023 20:24:35 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 14:24:33 -0600
Subject: [PATCH v3 2/7] x86/resctrl: Remove few unnecessary rftype flags
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
Date:   Thu, 2 Mar 2023 14:24:32 -0600
Message-ID: <167778867236.1053859.12920879751317268318.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E634:EE_|PH0PR12MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: d947cb8d-1d93-453d-5838-08db1b5c23a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lp6ggzQH8M/I94cN0JIGvsiV/fhAhhi9216IgVoHRQ8VXF/irq8FNKVkq3pkh9rcrPkIstAv7KLROrseaJvDdLe/7sJEtxEwi0csZ4ONwxGjMZIp2c49q4Np3JEZAGngVv5BuUkFle9WPIX4dqhzbCdrEHDX7BxC5E3i/rY0HBaNo4vtI44sOh7y4wvYklY4PBoeQFY4TL/3wHMderiWWHi5davaUZ9ESNvNtw1Am1j5s2KbDecTvPa0hOSOMQFH4A+tz6qvrvO6hNHhkqAtA7h0/E/VXAlSxEWMXR5jQxYe68Tcf36iynu8DLIWelFLpAWvw8BaMwQD4PNEM28tJ8rrUYItlU/I98gq4ZcOjpbkghyLv9NaIvtS8WB4zGAsH5bqYcML2f9Y/hVkgiOibARTuQ4wdqt26eOJM0zBG2Pycqwh8xu/xwjuGy3wSdJHf/X9rj/misRHPDYkWMbkjIHeJNc4NtdMmx0wnv2ZbkTuQz3ey/x1WQzl2abxrVs9zI+BVa8KQ/h17AED2KAHHDEidPRynC4mhFaByDJAKcDBEWSuB2IiN4r7DtNbnSzwQbTJAtyfTT+bth2Mze5AGhROo4ncfUIyh7ooEplRfM6KrmjLtgEkyhOov81ugVzc6SQLWy/CuFrYuYJYl5I/qY7xmYDCBcVMDJyUvOCxA5gkM/svuN6S85cbIXz+h2UU05mFMMZKtxBP1+LeHpy29kyU9LnEpr97XyB3+FOElvZ2+GB5pxavIcnBwQekZINPKorq5yN9rp88QggVJiFBeg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(7916004)(136003)(396003)(39860400002)(376002)(346002)(451199018)(40470700004)(46966006)(36840700001)(103116003)(336012)(33716001)(82310400005)(316002)(16576012)(47076005)(478600001)(83380400001)(110136005)(54906003)(40460700003)(426003)(16526019)(186003)(36860700001)(9686003)(7416002)(86362001)(8936002)(26005)(356005)(41300700001)(2906002)(7406005)(5660300002)(70206006)(44832011)(70586007)(40480700001)(8676002)(82740400003)(4326008)(81166007)(71626013)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 20:24:35.1124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d947cb8d-1d93-453d-5838-08db1b5c23a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E634.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8150
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove few unnecessary rftype flags and simplify the code. This is done=0A=
to further cleanup the code eventually.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    9 +++------=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   10 +++++++---=0A=
 2 files changed, 10 insertions(+), 9 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 8edecc5763d8..571145d75d29 100644=0A=
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
index 15ea5b550fe9..3c86506e54c1 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -3163,7 +3163,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *pare=
nt_kn,=0A=
 {=0A=
 	struct rdtgroup *prdtgrp, *rdtgrp;=0A=
 	struct kernfs_node *kn;=0A=
-	uint files =3D 0;=0A=
+	uint fflags =3D 0;=0A=
 	int ret;=0A=
 =0A=
 	prdtgrp =3D rdtgroup_kn_lock_live(parent_kn);=0A=
@@ -3215,8 +3215,12 @@ static int mkdir_rdt_prepare(struct kernfs_node *par=
ent_kn,=0A=
 		goto out_destroy;=0A=
 	}=0A=
 =0A=
-	files =3D RFTYPE_BASE | BIT(RF_CTRLSHIFT + rtype);=0A=
-	ret =3D rdtgroup_add_files(kn, files);=0A=
+	if (rtype =3D=3D RDTCTRL_GROUP)=0A=
+		fflags =3D RFTYPE_BASE | RFTYPE_CTRL;=0A=
+	else=0A=
+		fflags =3D RFTYPE_BASE | RFTYPE_MON;=0A=
+=0A=
+	ret =3D rdtgroup_add_files(kn, fflags);=0A=
 	if (ret) {=0A=
 		rdt_last_cmd_puts("kernfs fill error\n");=0A=
 		goto out_destroy;=0A=
=0A=

