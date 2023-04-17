Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D456E5543
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 01:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjDQXeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 19:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjDQXeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 19:34:15 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306B94C2B;
        Mon, 17 Apr 2023 16:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XD5VA58+SEozbSzU8LlNwTVpEJToJr9Kzao1iQMDQZlNfhlLICyN2nPOW28iWidtEJUbK9CLj8vpOvju/z3xuyPZEQDqfGJJbLR6RMnD+DDhB5lAZgmFyGl+3HwAEfeOqvxuEPo24Poz3nxr0LO9laQ2JW+dZCFciHnW2KSEkarS4KeE0ttNn1TkeHY+EatOz8+Zjlv3Jg6x/CP3FJ6dSyKeQiZMluxPGkNCrcgPZQiEUCxmNRinixWecDgX5sZma8nnndTSmPLHb9CIYWORfRSnV6HLshYgZtrtlcA7XtXJpA98LvDwROaiZFFBst3glWZKogXOKt1ZrZgYRjy/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJIi83lyubFdDpXE9qeWwL1EitAWnX7CQcm381VpOVI=;
 b=mK0rHklmSqrS5xrGs+VJCu1Lbrja1e1Wo2fTBwv4OXKqlFhPrUfj1bJq2EKLZTwSLKtw/l+BXCML6R0n6qhEwYr9uM5UXMG9BK57wHZHholdu6tR/OF11b4r+84PnhJrXEZC8Yd3AuHLOuMmd9+D1ui8Ks3l9bKrkm+npqlWdLClEBYF0GZM/HnsF1pI0D+6+Tda3dkCzRdrLJkbB4YU4ABgjT0oDR6k2wz+yMnWo8+3L12J3ZACCvka+AMVNytTASjEEi76Xj2cJuilltoVe9/u6g5ToKiPGwIBN8+MrP/EPLgzqvCKolpMbIDUCEcJQqQFjH4KW0xgzhMBZZYYZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJIi83lyubFdDpXE9qeWwL1EitAWnX7CQcm381VpOVI=;
 b=e0Y+umfKxfRkZ2y+5Rte7WApF/IgOhqSzI690cfo4nlRoOLAcNS9WLWQNlO4dXP2E6VKR/Xx/rpSzhz7kmU8ccGzZqucOI7mgPHaBWn7tNsV/spGpCeca+x+a3RhCxiMGm5X2z5H75podMvCgJdKr+vOzaodynTemKcGjS9pFdI=
Received: from DM6PR13CA0062.namprd13.prod.outlook.com (2603:10b6:5:134::39)
 by CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 23:34:02 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::40) by DM6PR13CA0062.outlook.office365.com
 (2603:10b6:5:134::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.19 via Frontend
 Transport; Mon, 17 Apr 2023 23:34:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.20 via Frontend Transport; Mon, 17 Apr 2023 23:34:02 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 17 Apr
 2023 18:33:59 -0500
Subject: [PATCH v4 0/7] x86/resctrl: Miscellaneous resctrl features
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
Date:   Mon, 17 Apr 2023 18:33:56 -0500
Message-ID: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT038:EE_|CH0PR12MB5284:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c00c67-5438-4ef0-d7c8-08db3f9c39d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kjD2VyZnrNrCMW8QsqyxzcpBzNpEM3nQSx64/1maf5iTQH3e2uKW0uI+WtNPMWkXkolnpbclAkeuQZRQtoGhpDPgs9BVcOB/xS1+A77c47gIPbbr2vC7YGiKzqgPijllnBCv+5ae3V5yfb/RCsXWqoYsfPfJo7w+poQ6yWTES3QShrd8yzF8pXVy5ADGP6grCU/sqeOs+KEqaCGFAfI2F6RK0CgfZaIDjONcpni746LYBA4M+cLkCXVTjGIq0qfgcHMI4JiDTqGMh7TrA9cQZP0xxRYTfIt//Yaaq/E0ChluvU0Co19X5NU9U1DrB53WFz1b/s4bXtBn58ta+IQB48wiIQ1vksO2Z1ZYTNuyIo+vZ+k7S8w/u5nABBTNtksOcq/mHqYdccapA7ArlZOSKtAcTHCazkXbXkip7dp7Yb9IQMPu/pIALKE/XYg3e83Hq3L1r5Rnnskt5EPq5BxUFyDxloCwAHh2+KXWX8xSxhQ6vR5BKn1YX4YcmbxzCSiV3UjRLDKAuh8HfB4WXCeozVJsLkNYrSjESf5UQrdjpB9FGmaS+uzXAGp25XHpoYd00Vythc67WZLSHIXbLGR05O0fEUzbN8ceYz+VTVafy9y7Q2ZFfrflhmVYYAsWSg1LdmpnOuG1xO0Yy4McqTYhjbHKnz9XMOa7eHVBjDO+oZWrE17jzTjTqSooMEC9LvqJOstndP1INV6OLLs6fYKTs3CU6ZZ1eBmygDpYmeOtYG1fp0o81oVHHhaP/N9O6i54lHohLP4OfBezPlpVe4terGTWGuTy/PhJz3IdoYyho0g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(4326008)(70206006)(70586007)(2906002)(86362001)(426003)(336012)(82310400005)(7416002)(7406005)(5660300002)(44832011)(8936002)(40460700003)(41300700001)(110136005)(478600001)(16576012)(54906003)(103116003)(316002)(6666004)(186003)(16526019)(356005)(82740400003)(26005)(81166007)(9686003)(33716001)(47076005)(966005)(83380400001)(36860700001)(8676002)(40480700001)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 23:34:02.0236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c00c67-5438-4ef0-d7c8-08db3f9c39d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5284
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These series adds support few minor features.=0A=
1. Support assigning multiple tasks to control/mon groups in one command.=
=0A=
2. Add debug mount option for resctrl interface.=0A=
3. Add RMID and CLOSID in resctrl interface when mounted with debug option.=
=0A=
4. While doing these above changes, found that rftype flags needed some cle=
anup.=0A=
   They were named inconsistently. Re-arranged them much more cleanly now.=
=0A=
   Hope it can help future additions.=0A=
=0A=
---=0A=
v4: Changes since v3=0A=
    Addressed comments from Reinette and others.=0A=
    Removed newline requirement when adding tasks.=0A=
    Dropped one of the changes on flags. Kept the flag names mostly same.=
=0A=
    Changed the names of closid and rmid to ctrl_hw_id and mon_hw_id respec=
tively.=0A=
    James had some concerns about adding these files. But I thing it is big=
 problem.=0A=
    Please comment back if we can do better. =0A=
    Tried to address Reinette's comment on patch 7. But due to current code=
 design=0A=
    I could not do it exact way. But changed it little bit to make it easy =
debug=0A=
    file additions in the future.  =0A=
=0A=
v3: Changes since v2=0A=
    Still waiting for more comments. While waiting, addressed few comments =
from Fenghua.=0A=
    Added few more texts in the documentation about multiple tasks assignme=
nt feature.=0A=
    Added pid in last_cmd_status when applicable.=0A=
    Introduced static resctrl_debug to save the debug option.=0A=
    Few minor text changes.=0A=
  =0A=
v2: Changes since v1=0A=
  a. Removed the changes to add the task's threads automatically. It requir=
ed=0A=
     book keeping to handle the failures and gets complicated. Removed that=
 change=0A=
     for now.=0A=
  b. Added -o debug option to mount in debug mode(comment from Fenghua)=0A=
  c. Added debug files rmid and closid. Stephane wanted to rename them more=
=0A=
     generic to accommodate ARM. It kind of loses meaning if is renamed dif=
ferently.=0A=
     Kept it same for now. Will change if he feels strong about it. =0A=
=0A=
v3: https://lore.kernel.org/lkml/167778850105.1053859.14596357862185564029.=
stgit@bmoger-ubuntu/=0A=
v2: https://lore.kernel.org/lkml/167537433143.647488.9641864719195184123.st=
git@bmoger-ubuntu/=0A=
v1: https://lore.kernel.org/lkml/167278351577.34228.12803395505584557101.st=
git@bmoger-ubuntu/=0A=
=0A=
Babu Moger (7):=0A=
      x86/resctrl: Add multiple tasks to the resctrl group at once=0A=
      x86/resctrl: Remove unnecessary rftype flags=0A=
      x86/resctrl: Rename rftype flags for consistency=0A=
      x86/resctrl: Re-arrange RFTYPE flags and add more comments=0A=
      x86/resctrl: Introduce "-o debug" mount option=0A=
      x86/resctrl: Display CLOSID and RMID for the resctrl groups=0A=
      x86/resctrl: Add debug files when mounted with debug option=0A=
=0A=
=0A=
 Documentation/x86/resctrl.rst          |  29 +++-=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |  62 ++++++--=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 188 ++++++++++++++++++++++---=0A=
 3 files changed, 243 insertions(+), 36 deletions(-)=0A=
=0A=
--=0A=

