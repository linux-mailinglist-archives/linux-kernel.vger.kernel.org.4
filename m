Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD966A8A26
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 21:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCBUY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 15:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBUY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:24:26 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7913A2202D;
        Thu,  2 Mar 2023 12:24:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UodihRvYmEsKmSsWpaTypVtVYly1XIH8SJIUO3iBpbZdQGI/kbf+gsAYz5wKmlEYWa1ksLt7mJ85RFkpemdPc932ogq4I0uUXjJpwNjGFJr1ofuDh4GMr1mhI1///nADa+ucxgE8YvJlgqnmeEZhX388anQbd+VfrPRUcC31jATGJLDNWXjahgSJVTqMjavRzAAgj44XtZso3ckOOahWSIY/MwWujeaH3/6mXHy+pblGF+qibsDhabBC+SwG8eYuZNIHzVpmAEofgRnvI8+D7Hs/Kr3K0DLZScJOBTZeC/V3g4slIVxn1yTMabShPePKbHyv+a6mmfpDWmXklrNbRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THTYmXsorbTljVKrjq8/hN1MQG4zXc9YJg0l4le1JRc=;
 b=KaGI2sfrv5Ysr0ubccQRCwD9Lk7Zk9zwGcTxU+MYwJCNjiranngMJ1oxoNfsScjQ2Vhmev4uNWF5w2z7TOBBssZbucXybmdTNKGmikH1rGuwHY6p7irQPu5oumyY/khZE6hycIQmqf7DBJSyu8BFQ1X5tzcEEnChMG9zyBSWNFlpyOn64v8HOV9LqijyP5PyCYNur0AMnddg/zFNMcYkvQ0g/+rl6T5wUiiMttUK5/Fm8jMYGriaUrt3BmQ17xlRkWjENXPNKPABbDz40bDC8nMnTDXu4FalNBu+gZUILahRNle1gssyr55PDikId/dGpLnyTrMjbNnPgyGKlr5xvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THTYmXsorbTljVKrjq8/hN1MQG4zXc9YJg0l4le1JRc=;
 b=WrABrYvjyRGAt3HN1MqSZRs+7F1aFBpl5Sx+18NHjmJqkk+vraZFk9IxbH6AT27psNR6qrqYNK955+V7a0SaMXdbm9aE/eKvHZpNqme3GfCy7YqBq82giVIQjpuMuRNTOu7I/eARidXQgwH2qOyBiYJa0ucHyO62weBQGMQ6OLs=
Received: from DM6PR06CA0035.namprd06.prod.outlook.com (2603:10b6:5:120::48)
 by IA1PR12MB8494.namprd12.prod.outlook.com (2603:10b6:208:44c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.6; Thu, 2 Mar
 2023 20:24:22 +0000
Received: from DS1PEPF0000E633.namprd02.prod.outlook.com
 (2603:10b6:5:120:cafe::4c) by DM6PR06CA0035.outlook.office365.com
 (2603:10b6:5:120::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.20 via Frontend
 Transport; Thu, 2 Mar 2023 20:24:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E633.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.16 via Frontend Transport; Thu, 2 Mar 2023 20:24:22 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 14:24:18 -0600
Subject: [PATCH v3 0/7] x86/resctrl: Miscellaneous resctrl features
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
Date:   Thu, 2 Mar 2023 14:24:12 -0600
Message-ID: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E633:EE_|IA1PR12MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d1b755-a9d4-410b-76df-08db1b5c1bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8PBgwb9aNsJlPOJJ9E3hx8U+Ys/PicB3+MwBjQWy9NT5Kcjt1FtNHAJRveE4Y1v4YlowQI2unB94XVloprJHtyPH6+/PSjeHO8t9RR/U9cNnrmnPKUYf0pIjg30zDMhbACkyB1aCKZx19DvSGjAmiHrJAbQR/2JeKJnlEFLjNDVwZv7kP6mdBGOJ4uNg2IEgnxSa8phj+xkPbEXG1Thh9DwnWRXNHbf23q3Tp9jcdjwboiBHSsqL1jNmWRi+1DmagwC/qz9uM1JgKQfC57UIJDEQ+mzGHnClR5XH6L2GEhK25fFDrRUmqSviO16u5zdcGKBj+MDiuhBvtBA70/+Jc93ObMI+/ZwTyOdpQbXt1wFSdV7wFVyw/2nFhCWXqvH2J8eikbDj0kXYw8RgoPrQ3wXBZXp3FfsgPkwg+fnu1H4NBKK8UTp/zU7XNbCXvkSnGJHqX/UI8NJwd5exnqoDTJcxNef4rIR3hZY9EPEqsr6RCrTqtnaod5lCGkgP2EFfaKmjb/apt5zEvZ7P5lj0+F114+Q/xWWgFwnCpVVwxen084zzIX1+DxNpRNSUw5AFfIEeHJ+qErLwb6lgOKLILQeymiHgaGExCHnz2Z9eb3YjfZHHfE/8ywrlhQ5htGKnXXbYud5CJIyye7Lcl7i2V9FphKT64LSVMeOTvZJCTTPTvoAXiGGbEzMhGLZlLWxCXM7C/Dbc6LB5/Mmmzugsmp+vQGpOJnnMv+lKrmvGFvACf/UNVdJfyFEs4/ZvwQhvNM1ASV1Ejs52DRACRTr7GNyBmF+KjxT98bl4jcRTdo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(7916004)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199018)(46966006)(36840700001)(40470700004)(40460700003)(70206006)(70586007)(110136005)(316002)(16576012)(83380400001)(54906003)(36860700001)(8936002)(41300700001)(4326008)(6666004)(8676002)(9686003)(966005)(186003)(16526019)(82310400005)(47076005)(26005)(336012)(478600001)(426003)(33716001)(86362001)(2906002)(82740400003)(40480700001)(81166007)(5660300002)(7406005)(7416002)(44832011)(356005)(103116003)(71626013)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 20:24:22.2157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d1b755-a9d4-410b-76df-08db1b5c1bf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E633.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8494
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
Code is built on top of tip master (commit 7fa08de735e41001).=0A=
---=0A=
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
v2: https://lore.kernel.org/lkml/167537433143.647488.9641864719195184123.st=
git@bmoger-ubuntu/=0A=
v1: https://lore.kernel.org/lkml/167278351577.34228.12803395505584557101.st=
git@bmoger-ubuntu/=0A=
=0A=
Babu Moger (7):=0A=
      x86/resctrl: Add multiple tasks to the resctrl group at once=0A=
      x86/resctrl: Remove few unnecessary rftype flags=0A=
      x86/resctrl: Rename rftype flags for consistency=0A=
      x86/resctrl: Re-arrange RFTYPE flags based on hierarchy=0A=
      x86/resctrl: Display the RMID and COSID for resctrl groups=0A=
      x86/resctrl: Introduce -o debug mount option=0A=
      x86/resctrl: Add debug files when mounted with debug option=0A=
=0A=
=0A=
 Documentation/x86/resctrl.rst          |  30 ++++-=0A=
 arch/x86/kernel/cpu/resctrl/core.c     |   8 +-=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |  68 ++++++++--=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 179 +++++++++++++++++++++----=0A=
 4 files changed, 242 insertions(+), 43 deletions(-)=0A=
=0A=
--=0A=

