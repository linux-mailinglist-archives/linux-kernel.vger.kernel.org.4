Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EDC71F283
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjFATA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjFATA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:00:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D777184;
        Thu,  1 Jun 2023 12:00:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foGy1Cw2c96ReXBk5MVJDDJvPSLT3AmB6/NZx5Pyr4FN+oxdpwOLDZWataSGenk88G0MnFixTDpBEH9Ezcko1LCi9HFwc4/qgGz03+Ld9GNnNE4BYR9cRLa7Ge/ggZYfMr1320h5Wvw561YCWSZb9BV2zEZFW6SD0/5XXHli4/lPIGAPRZe5rL0uncVpjDsVwaBBgTPDsyKbbi6XxJ9DwsWuGETtXpPjQBPkpiScpvamMFMz2OJWSL/s997bwoF1VsQ9GS08CGdL2oeiEN6b5IlzGCkY9FFSz4nzkVQ067++0xv5fBpNIo8XdZoRP3oVj9KEQ8ytHsQg2/K9gpthoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLJl50GmEnSBnaPZwF9Wqgk8E86mHj/JrLqKvNVfpfM=;
 b=ERAlUT9Dkt3Faxy3+37hEvTL7bdYi1+hVjFV86DSL4fC6ZMP3+ECE30XlXdExtzY1OR8ZCs0r7usSc+vg89/jyxyfXK+fwQDd4XBqSws7RuyGab+xps6MTCBmjUDiyAo03Wigv7ve5r3NGV9Gh5XvUu12ibE61KEHHDgQa6QLFhX4vHwh5UTw6ytqrEryYPwnulYHITi1g0xV+659JQJ3JQWRewhrkmNARuM+cAwv02jHCxiV+9b8tPCKO+Lm0lVpLWtYGg/PLCRacrAK1Q7F+i/JPBguSGL1gNFYmdjiG953JDpXhcYU7ti1ptVbTZZI2U2wn7EsrjHgSMuw02jsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLJl50GmEnSBnaPZwF9Wqgk8E86mHj/JrLqKvNVfpfM=;
 b=vs1MqKToDlaOv6HDZS+M5FkhZJLTg95HXYgQV8MW/otGnrbxxmzcbtg71ES98XZh3+ZNP5pXag0BpoM6HGrxapYos6GToQSfJraNwE8DMeg3BXgfoj/kJdhl0jO5No2CFQf7FmTAnZ84YZAp6zdRURfaagB0DuespcsW6OMNMns=
Received: from BN9PR03CA0690.namprd03.prod.outlook.com (2603:10b6:408:10e::35)
 by DM4PR12MB5264.namprd12.prod.outlook.com (2603:10b6:5:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 19:00:49 +0000
Received: from BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::dc) by BN9PR03CA0690.outlook.office365.com
 (2603:10b6:408:10e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 19:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT081.mail.protection.outlook.com (10.13.177.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Thu, 1 Jun 2023 19:00:49 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 14:00:46 -0500
Subject: [PATCH v5 0/8] x86/resctrl: Miscellaneous resctrl features
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
Date:   Thu, 1 Jun 2023 14:00:45 -0500
Message-ID: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT081:EE_|DM4PR12MB5264:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a9b163-b6b1-4285-0800-08db62d283d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gqJcbt02b2pVNW+mrBUm8ezDHuoTkaT6SJ/wkQ60I3uxeZpRfeN26Wu1IlC6tPs5wIGcuQEaOYMnH1ilU9YEsa1VhaEoVHCoQug896/svOyP4nL13fkovfke2Fxbi8KIC7cu7jDc/esIRan1aqs+WWP5Rp4LeH/8dlx+3ULLezzotk0yrgIsYP9V/LLr/AqLTXYUiw6pX1f/Cy5tf5n8qUjoUsljnanXZXVcY4dJdOxEigxzrkCTFzZkyj93Xg3612KdXPau3xz/X9fbcWEDk+tEC2h2Gfft7MT6Hd4gLnYNI13tcTpSm4+XN2hDEuAwEkysW8zdMdTdaZMH5/p79ahPYjBkm2A0bWup6lAwzS8AY0WA4vwHyR3gh9TtI4x8s6l0vL9xtDg6LJ3zWSgOe9iCHWYeW3xyI6OW2z/hmzmy9loL8/k/4Vf0B/bonwYUddBu2mUIw4r71B5NTlHez6MrpNZbgSruDBkbwx0Eqca4JGX/yhQtt3Ob1w9wWIOQEGxLeqxx5w1gypKkZshfFsM6rO7xDPdOz+oYeQQ+41+WM/wLtDz9X+8O4becpYImm9VVHCrwJ1fGqPe9pJwG/S7+WqaiTOULrpqjHZaK8UuOizmKI6/9zWfphDLnv8mjrBeRDDM6t2JsdnResawCe820qKKAyNDdNR43LyIqjd7FCrOSdEu5WGNuEeQQf+q5qFGM8zWauOQ/zbGQCX481xOv0+A1usjbOfpv/nziXGEurl7gc3sg5OObqM6qa9tQMgWLGvlpMuYSrcma0t0syGpmSH96Ke87x4HrFxwb7YD4YlRy0kPFvKPXnVMW8MVMB0S1wgC3GEbdnLa7KHcg3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(2906002)(26005)(9686003)(16526019)(186003)(316002)(40480700001)(40460700003)(5660300002)(7416002)(7406005)(41300700001)(44832011)(8676002)(8936002)(103116003)(966005)(356005)(82740400003)(81166007)(54906003)(36860700001)(16576012)(336012)(4326008)(478600001)(82310400005)(426003)(70586007)(110136005)(47076005)(33716001)(70206006)(86362001)(83380400001)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 19:00:49.6953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a9b163-b6b1-4285-0800-08db62d283d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5264
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
4. Moves the default control group creation during the mount instead of dur=
ing init.=0A=
5. While doing these above changes, found that rftype flags needed some cle=
anup.=0A=
   They were named inconsistently. Re-arranged them much more cleanly now a=
nd added=0A=
   few comments.  Hope it can help future additions.=0A=
=0A=
---=0A=
v5:=0A=
   Changes since v4:=0A=
   Moved the default group creation during mount instead of kernel init.=0A=
   Tried to address most of the comments on commit log. Added more context =
and details.=0A=
   Addressed feedback about the patch4. Removed the code changes and only k=
ept the comments.=0A=
   I am ok to drop patch4. But I will wait for the comment on that.=0A=
   There were lots of comments. Hope I did not miss anything. Even if I mis=
sed, it is=0A=
   not intentional. =0A=
=0A=
v4: Changes since v3=0A=
    Addressed comments from Reinette and others.=0A=
    Removed newline requirement when adding tasks.=0A=
    Dropped one of the changes on flags. Kept the flag names mostly same.=
=0A=
    Changed the names of closid and rmid to ctrl_hw_id and mon_hw_id respec=
tively.=0A=
    James had some concerns about adding these files. Addressed it by makin=
g these=0A=
    files x86 specific.=0A=
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
v4: https://lore.kernel.org/lkml/168177435378.1758847.8317743523931859131.s=
tgit@bmoger-ubuntu/=0A=
v3: https://lore.kernel.org/lkml/167778850105.1053859.14596357862185564029.=
stgit@bmoger-ubuntu/=0A=
v2: https://lore.kernel.org/lkml/167537433143.647488.9641864719195184123.st=
git@bmoger-ubuntu/=0A=
v1: https://lore.kernel.org/lkml/167278351577.34228.12803395505584557101.st=
git@bmoger-ubuntu/=0A=
=0A=
Babu Moger (8):=0A=
      x86/resctrl: Add multiple tasks to the resctrl group at once=0A=
      x86/resctrl: Simplify rftype flag definitions=0A=
      x86/resctrl: Rename rftype flags for consistency=0A=
      x86/resctrl: Add comments on RFTYPE flags hierarchy=0A=
      x86/resctrl: Introduce "-o debug" mount option=0A=
      x86/resctrl: Display CLOSID and RMID for the resctrl groups=0A=
      x86/resctrl: Move default control group creation during mount=0A=
      x86/resctrl: Introduce RFTYPE_DEBUG flag=0A=
=0A=
=0A=
 Documentation/arch/x86/resctrl.rst     |  19 ++-=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |  66 ++++++--=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 199 +++++++++++++++++--------=0A=
 3 files changed, 212 insertions(+), 72 deletions(-)=0A=
=0A=
--=0A=

