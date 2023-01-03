Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4060265C92B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 23:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbjACWHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 17:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238314AbjACWHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 17:07:03 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34139EE02;
        Tue,  3 Jan 2023 14:06:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1P71il/b3UadYlDI+fDxNyhzfmzXbpmnptIY621OahYdtJAdgUJcaqbmrMBJ3yaWQ3CS5BEH7y6jcjvQu09+mi9oDAfRG2QePLYlgVs+rqJ+0xBpifmT2Fhca1iNsT/S6/TkTM6vHgMftFI/N4/E07JBhhKt21CTlJXyrl7JqSMZXbfOscVrzN1cjEiTANkZWsZD1hfnNIqhob/0FmosEsOd6W/KDrHdLBcdXC5pwoPNLOpVAVY9NkRwdo6ajDZTFYJeV1J0+k1nVvUDjnTUZ5Q1naOZ9LovJfydSr+DVfhlNt4DjfsRC7MhX5Q5Cxw8KFwIxtNLhJd2QWZisxKkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWC3NKDwJaAlaP+2mtyG2QlcwQ43frYiNsQCyRnZPIc=;
 b=kNyaQSf8GbppsFXryYt0b3Gt8kANTsyYg1Q6mxZi0iy/xhCCjf9svfgreAFf2lKwT+WOKnVsVbdvxNFxQE7JGBWTeyXqR1TVwZ5FABJbm34TxoFc9kYvZMtqwltlG47nZVxrS/2NRkIUTGEozXRxGeBONfVylxFIeqI/PNOY4DDRYmeX1r012agyHgtofy2aswSriDJZTpEWzapHEwgyEpGhBz31sjB/OCYGdPfxEGEQb4IZnIPF8MuL6mQiVfFnsq5oZ8bhuH+7w/0Vkl22WMmvD7bvhESVYNliZXkvthaNKenrK+vSBjyXwaid8goSDrOKtNkP2RTh78ar6R7CKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWC3NKDwJaAlaP+2mtyG2QlcwQ43frYiNsQCyRnZPIc=;
 b=ISq+GOWK/yjwLQo3N5OsNZjq4LSCQMgs7RBuYMSQbCcx5+bDzEh484QT8bMjAoVIJh4Ej+zDOfyfdDeBhLBDhWfz5E3/PwBienRxhuESmFB2OqsbjjbcPI4cZUbDq2SefbCl08v9lmSsqTx6gmqf8RLoNQRWKGq+uTlSoe0B1kc=
Received: from DM6PR02CA0060.namprd02.prod.outlook.com (2603:10b6:5:177::37)
 by CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 22:06:30 +0000
Received: from DS1PEPF0000E63F.namprd02.prod.outlook.com
 (2603:10b6:5:177:cafe::6c) by DM6PR02CA0060.outlook.office365.com
 (2603:10b6:5:177::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Tue, 3 Jan 2023 22:06:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63F.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Tue, 3 Jan 2023 22:06:30 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 16:06:28 -0600
Subject: [RFC PATCH 0/3] x86/resctrl: Miscellaneous resctrl features
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <eranian@google.com>,
        <peternewman@google.com>
Date:   Tue, 3 Jan 2023 16:06:22 -0600
Message-ID: <167278351577.34228.12803395505584557101.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63F:EE_|CY8PR12MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 97876402-6471-4d78-9024-08daedd6c4b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gSW6Hn7aXw3lcxYoBCf2KWjwlzyvv/Y/TWEjSK52ey+tRYhsH2zpperncdiIC09F3LpPLmlTVX/pajbmpW+ew+WzAWPTypOst2CyMQxlnw+KTacXfxZllHXKF8Qn/WdWNwVyyc5gT4FhEj99pnahgsOrPUPpEpuZiKheAgoDAmB07VmKSVOPjmDTyTsGLx9mqFDLs81NQq67WyUXU/UhpKvAnn4YLN8A9+PpsL5PZ0+cf9sfhHsrz8r1gZ+uIaqYF2o0W4iO21/K4KhDN1Bfi0Wap9C8Nl0e+YBWD1Pgu5HBD5wJZt8h6rcy/R/bCu+BVAWr2o2NLvKtALhLXxgxBkXT/GhQqErzeombcN9tEzoqPtlRjorhg2zwuvYPx1r8158cV6AAeAQo+SppgFTVePUZ1r8Ixsk2DV6gBdsc7LG17Zf7txp7Qv3FHq73uzvjmLuH2SHPlBscaYMM5omjgL4RE6vbKBJ5OvqtG+A4wxnJfyFXtg0EbHHlxyuIkUyl6r0JAVxadAZCVWeagZwlthaQ0Mb/4SvnixOarKs99AoiSrC+yliDp5VxEeq60jQR8jhadIKHWSivqt1pnio63XRRB78oftAAeTZAl2HAasb9oLiH3AGnONTPCzo30SFieWPhiuzKCT2jZM5c4wuTyn929szam0lFHpCIKuElXAHHngRr69oZ3bzPlbgngRUMWke7Q9k5MDZWyEm5qaz0I06+1+kmk1i7+CcrWGdcbbA3gV/Ka+lZ+j8L7uqPflzAvSBNPMPuDUb+4DZdEnGPzpQP6ReIhr4nG5zHeK1umtY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(376002)(396003)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(83380400001)(47076005)(336012)(82310400005)(186003)(9686003)(16526019)(426003)(26005)(33716001)(6666004)(40480700001)(103116003)(40460700003)(86362001)(36860700001)(356005)(81166007)(82740400003)(41300700001)(8676002)(4326008)(7416002)(2906002)(5660300002)(4744005)(44832011)(8936002)(316002)(478600001)(16576012)(70206006)(70586007)(54906003)(110136005)(22166009)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 22:06:30.4870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97876402-6471-4d78-9024-08daedd6c4b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7657
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These series adds support for 3 minor features. =0A=
1. Support assigning multiple tasks to control/mon groups=0A=
2. Detect and move task's threads automatically to the groups=0A=
3. Add RMID and CLOSID in resctrl inteface.=0A=
=0A=
These feature requests are coming from our test team. They have=0A=
been asking me to add these features to QoS for a while. Please=0A=
review and comment if these changes make sense. Thanks=0A=
=0A=
---=0A=
=0A=
Babu Moger (3):=0A=
      x86/resctrl: Add multiple tasks to the resctrl group at once=0A=
      x86/resctrl: Move the task's threads to the group automatically=0A=
      x86/resctrl: Display the RMID and COSID for resctrl groups=0A=
=0A=
=0A=
 Documentation/x86/resctrl.rst          | 28 ++++++--=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 90 +++++++++++++++++++++++---=0A=
 2 files changed, 104 insertions(+), 14 deletions(-)=0A=
=0A=
--=0A=

