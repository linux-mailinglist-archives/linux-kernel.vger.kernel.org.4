Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3C9688929
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjBBVrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBBVrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:47:19 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905EB8626C;
        Thu,  2 Feb 2023 13:47:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGN7EAbVJNPLRV9stZy6ECmNrqQt/0HvwIueOlBC+hIzQNCGXejZ7XXz0+4f7rBngq8N6gK9oIbhO8RHaERJZuIbr3+TrIgvvJ5jtewRBsOXoqEqOe8JR2fY/cFkRzioEmiCKg04/LHuWLU1eYXeL1GS+SNE0fvfUCkmj0YM+3J+u+lpQXcRUgkGo8NmLxeHsDHb2KGUaHFKCqbxBz9mGhBkFYm+olaySXrO2htO5dQefJiJ7z4//ZFmSTDVgd4uGrUHtyKa7ZxnS1GoPhjvDlRM2HVrqoFCP+/3cfbmBZmVQKez+/wTWssRJrW02ilNJDJUy74Favv7NbR3+zDUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBTajpA0WH7bgpLB6DtWgGNNgryYV5eQZMQu51zpt5Q=;
 b=fhHV9gZXNOBRYcpfiNMzIoWuUm2sV54XdrvYXeURaPTdVMx4NAmI4dt6JR94t0Tr9jhSX3Y8bupnKGYsDR4JurOF87dA7BmUoHyW/T7m/2F9Sz+6+0nI3+G+dY2zk0wViPJA6SvYIWiV1mth1nB6Hr9dOJgFh9xkefn/BQXUG+0LhY1Mh9KpjPCzHUk2To2gniH9m/7/O8yv0/Qf9IrWSRERV6asfaEEXG6rGyiMaUXBnN4bMmqrBdmwMpqigqqrBtPWUWHLDR6dLjec9NdNoUCvizoIuDenBcv0ZWi/eGMElLXLHafjkD4d/45ZYc20axgjyb/Tep+0pPokW30SxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBTajpA0WH7bgpLB6DtWgGNNgryYV5eQZMQu51zpt5Q=;
 b=OJQY0Rx5b2i+6LTBvv4rBtgu7Nn8XwVv4fQSaSUvgUxz7uU/laqLq1C8cRaH6UpedWfxVLxujdspq8INwC9BecgUg/MIbQgMXsnn/rtIJT7FW2GwMa4RbCLaClyRqxuckY/9JIBaXzMXwx3kdnhKIaveFlQd6cx1HbMQTBXRv2I=
Received: from BYAPR03CA0032.namprd03.prod.outlook.com (2603:10b6:a02:a8::45)
 by CY8PR12MB7122.namprd12.prod.outlook.com (2603:10b6:930:61::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Thu, 2 Feb
 2023 21:47:08 +0000
Received: from CO1PEPF00001A64.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::56) by BYAPR03CA0032.outlook.office365.com
 (2603:10b6:a02:a8::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27 via Frontend
 Transport; Thu, 2 Feb 2023 21:47:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A64.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Thu, 2 Feb 2023 21:47:07 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Feb
 2023 15:47:06 -0600
Subject: [RFC v2 PATCH 2/7] x86/resctrl: Remove few unnecessary rftype flags
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>
CC:     <babu.moger@amd.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <eranian@google.com>,
        <peternewman@google.com>
Date:   Thu, 2 Feb 2023 15:47:00 -0600
Message-ID: <167537442064.647488.11274211283317010424.stgit@bmoger-ubuntu>
In-Reply-To: <167537433143.647488.9641864719195184123.stgit@bmoger-ubuntu>
References: <167537433143.647488.9641864719195184123.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A64:EE_|CY8PR12MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: ae607a50-c2ed-486a-1bbf-08db05670834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QFU9+XLh02dT1QRSDFnKL8fOYFlDvkUYtpRJinDQv2vq058r6lVcyKmpT66GdW9LZhYVquQ8jf7v2LrGKOc7yQA/Q+v3cS3cszY/aQGeDNHrCQ45kqViqYUec56m0imS4n6FwWxpNXO6WBOdJEWZ5KR04nH9CbKCrFnrhvNO0GqK4/A+dgFpkZsagb39QT5GSdTMi08XkJFEpuxp4cHSHzsVAR0pFQ7NZMKlXQ1XVVIxEM9n6uFcpB2cNcksTP1ns+tAl/T0US5RKmoTScGWX18yEzmI4ZvyISDS2OxHJdm+d02YGVRfKi0sm/1Wyh67xJCB6anmVVpfqSlXZ+K0X+d+/aEQ58GW5yl8aWN1MKBSIqBOCAhBUjk4IsAkGol3SW77vVyP9oFnMb4AggnO/QwHk2RGV67xJ0eiKxiNRqNTo6l7p3eOpha+WdkA7jS3CSex2SYAUFgTIERatYEvm8NDRZq9yYvsUJnD8w3DwhgxTmFALp0Mml3Lmoge9GfFIrd8LF2UrZRXFAqWfsNNWz7ddPIn4UWbPlGobxUdz0FEVQPYjctbBF1Uocz9wVSnPDY/yYE3AEYMfe+EQFaS0sUtZPaPIipvIS3nWYWcwqEdesQLQvk72repGEVBl2pbYuF3YQlbCvGOodpQtAn+JZ7fqftJb4nIrtmLuxjBxyO777AkLUqUYkg/k6iFnuhjOaSKGzPL/hCtzK9OGSqIDrJUydQ5kDONlBusKBU+h371Ju3x2xUE//4p3NTi4RUnEJ6ba/V8gL2fVFCRRIg1KA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(7916004)(376002)(39860400002)(136003)(346002)(396003)(451199018)(46966006)(36840700001)(40470700004)(103116003)(81166007)(86362001)(82310400005)(356005)(83380400001)(6666004)(186003)(82740400003)(36860700001)(33716001)(336012)(426003)(9686003)(47076005)(26005)(16526019)(44832011)(316002)(2906002)(478600001)(110136005)(54906003)(8676002)(40480700001)(70586007)(16576012)(4326008)(70206006)(7416002)(5660300002)(41300700001)(40460700003)(8936002)(71626013)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 21:47:07.8897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae607a50-c2ed-486a-1bbf-08db05670834
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7122
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
index 13b7c5f3a27c..cccf3fb84b26 100644=0A=
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

