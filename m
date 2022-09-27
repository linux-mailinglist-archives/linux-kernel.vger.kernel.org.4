Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9093B5ECE5F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiI0UZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiI0UZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:25:31 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6B94A11C;
        Tue, 27 Sep 2022 13:25:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxZhGFrVnBn0a+RVNw8vDIhEH3R2rgYdTMc+vFhW4nBdE9674CEBZ8yszedfGsrVt2MzWYS9Gdvbo8gDoW4GRzFF2vUyobvmOfXwVhiak8FycRsEtWzaIdUIHc6nagAMz9ami4u/PzVJpScQLqw+stuPkASheactNhgQdvWIBFIDOKaBZ59rrWzvgUJqmL4uzXraoZyVN1UjHCHRKagb4VRDL3wbsHFQZ2kKdZCcUp0zzY63q6/d+Pe/lUgUKrUKBbbazDM6z4C7LtoFlQ9xGQT1NqF4N+6AqK2MuX9u/sNwI3FuyHbBAiPlxUm9mRFlz/vQoylOBWcEotQF/jR7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYC+SU8me+95ffXfnT38T/ODDmPcmdTEzsdavBq1Tq4=;
 b=Hs2MMlrnDByIfAZdu84d33Wx3O5dTRiKyxtWu9YKMAxR2PqB6eV8jrQHCwu7Sm5Vmxm6zBJ/EzosDte73OVfPgvHX8E5jExls4pnL4qqUAn9VbnCzLgwd94NcSaBvjt/cgiwbNJpEnWxMmSIEZHVsVBfJAkTauLXAlCH69raaoXP97YziXy2F6KkPaPAxtd1rBGKVcdYnMSFCwsJ11yUJB/6PcfbF+8Bdbri37uXPCTehgQqIDICXvwnQBUa81e13FCFh67628N/kOURq44AJBJGt1VznW4xejWivkwwCfKSCLkMZgyz5rDj6rU3orVDLehrKrS7z2mJD+TK5y+WJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYC+SU8me+95ffXfnT38T/ODDmPcmdTEzsdavBq1Tq4=;
 b=R3sA1xVIerhhbgJdBowIXWWigH9eTDvgKgEMGUR4d4vVDSMhadRP9rg3BBGidzmI+VBR9Dh2s8wVC5kNaD5N2rQ6nxswIKlyQjoZW53oZAoMAPo7fDBa3Q4jxwGQT76mk2gO3F6aF8+2NfE9SHi0lnGqJ8tdUjpEFGDk0M0VXmo=
Received: from BN9PR03CA0175.namprd03.prod.outlook.com (2603:10b6:408:f4::30)
 by CH2PR12MB4907.namprd12.prod.outlook.com (2603:10b6:610:68::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 20:25:27 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::6f) by BN9PR03CA0175.outlook.office365.com
 (2603:10b6:408:f4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Tue, 27 Sep 2022 20:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 20:25:27 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 15:25:25 -0500
Subject: [PATCH v5 00/12] x86/resctrl: Support for AMD QoS new features
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
        <eranian@google.com>
Date:   Tue, 27 Sep 2022 15:25:24 -0500
Message-ID: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT055:EE_|CH2PR12MB4907:EE_
X-MS-Office365-Filtering-Correlation-Id: e15b1b7d-edb0-4071-d491-08daa0c66a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8K16VTsN1qUtd2kwrdA+VjSRBXlDqsAcIt+bW+ZyAz+Rr7ZR2vnhD+BjXUIbSkADhK9kwSUWtI5dhAGS3YTaqBn0BTzcBg8D8HSEXfktPGNCq6sM5bOAZLUmFbeAAfYXA3rA50a7Dk2n1iLo2JKSq7pRHHCONJ4511FJYvvQ+rlCs9xMKiAR2zCFDNFaxmQI4w3F+6a5jXk+kFB3rHvr9FUjrnvyjfzEYmvpTt3mTFndT/quGMi8Ir2Rfgu+Vg0lnlKHLTWX8iZW1BT9UO4J5++zNFUcSH3Oj7ymo1S2q4YqZ3WoV8YySNYIIV2xI5WvcJLyLse0l2NYyDdRu7K3m/XajWqU/qzL+ThYCqFOW2NPWZoRvSPBf2fjDajBVPHASKU0QVqjoDEXrolbYwxajQhIDrnaUq8z+sr40yPlpLf3Tt3vr1MOrmBqvLQ1wI9Xp8m74mqzy1lw6/3IqBUGgHv8DqYnkUzJm/2GJTwS7Yps6TVI0XYhHY1HV8drmOkoCJ+bs3x5zx0bAmymO00s0zfQizZ4GJ3JPZIisE+A/6iBVGUNqLpXeQOSCP0ka14fQiekpA4iW+5cTzZmamt45Srhe8kPjWJ+0fle8wVwl1vwDf3HSzizfQhm+tv8ulzbonGgQfQxxjpdfAboWtYHcBh83dbF5XAy8G5PRbkRBxHYOeBLarbSS5tth5dz7rIja1ZZN+6GoXN8GYYBv3fqbU2KiC+9zyc8KqJh66b/+nUkiyMoVEMPXjy/lyAVULHyvc6xUFAe1VKkxKAdKRD02NbQXvEDwXJcVZXgaztGcNUFfwWx05bzK32HVTTKh1CSnyFHYcxHNray+5o5RTNHV56CQXe0wBb+rxTbNy68AqWBF6ofVqfGBLzMO5ZlE6jrHIhhtEkLX0+4M8kID1GhAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(396003)(346002)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(86362001)(8936002)(103116003)(5660300002)(70586007)(4326008)(2906002)(41300700001)(8676002)(70206006)(81166007)(110136005)(54906003)(16576012)(316002)(356005)(7416002)(40460700003)(82740400003)(40480700001)(44832011)(36860700001)(966005)(83380400001)(47076005)(82310400005)(33716001)(9686003)(26005)(336012)(16526019)(186003)(478600001)(426003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 20:25:27.2651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e15b1b7d-edb0-4071-d491-08daa0c66a45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4907
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New AMD processors can now support following QoS features.=0A=
=0A=
1. Slow Memory Bandwidth Allocation (SMBA)=0A=
   With this feature, the QOS enforcement policies can be applied=0A=
   to the external slow memory connected to the host. QOS enforcement=0A=
   is accomplished by assigning a Class Of Service (COS) to a processor=0A=
   and specifying allocations or limits for that COS for each resource=0A=
   to be allocated.=0A=
=0A=
   Currently, CXL.memory is the only supported "slow" memory device. With=
=0A=
   the support of SMBA feature the hardware enables bandwidth allocation=0A=
   on the slow memory devices.=0A=
=0A=
2. Bandwidth Monitoring Event Configuration (BMEC)=0A=
   The bandwidth monitoring events mbm_total_event and mbm_local_event =0A=
   are set to count all the total and local reads/writes respectively.=0A=
   With the introduction of slow memory, the two counters are not enough=0A=
   to count all the different types are memory events. With the feature=0A=
   BMEC, the users have the option to configure mbm_total_event and=0A=
   mbm_local_event to count the specific type of events.=0A=
=0A=
   Following are the bitmaps of events supported.=0A=
   Bits    Description=0A=
     6       Dirty Victims from the QOS domain to all types of memory=0A=
     5       Reads to slow memory in the non-local NUMA domain=0A=
     4       Reads to slow memory in the local NUMA domain=0A=
     3       Non-temporal writes to non-local NUMA domain=0A=
     2       Non-temporal writes to local NUMA domain=0A=
     1       Reads to memory in the non-local NUMA domain=0A=
     0       Reads to memory in the local NUMA domain=0A=
=0A=
This series adds support for these features.=0A=
=0A=
Feature description is available in the specification, "AMD64 Technology Pl=
atform Quality=0A=
of Service Extensions, Revision: 1.03 Publication # 56375 Revision: 1.03 Is=
sue Date: February 2022".=0A=
=0A=
Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-qu=
ality-service-extensions=0A=
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537=0A=
=0A=
---=0A=
v5:=0A=
  Summary of changes.=0A=
  1. Split the series into two. The first two patches are bug fixes. So, se=
nt them separate.=0A=
  2. The config files mbm_total_config and mbm_local_config are now under=
=0A=
     /sys/fs/resctrl/info/L3_MON/. Removed these config files from mon grou=
ps.=0A=
  3. Ran "checkpatch --strict --codespell" on all the patches. Looks good w=
ith few known exceptions.=0A=
  4. Few minor text changes in resctrl.rst file. =0A=
=0A=
v4:=0A=
  https://lore.kernel.org/lkml/166257348081.1043018.11227924488792315932.st=
git@bmoger-ubuntu/=0A=
  Got numerios of comments from Reinette Chatre. Addressed most of them. =
=0A=
  Summary of changes.=0A=
  1. Removed mon_configurable under /sys/fs/resctrl/info/L3_MON/.  =0A=
  2. Updated mon_features texts if the BMEC is supported.=0A=
  3. Added more explanation about the slow memory support.=0A=
  4. Replaced smp_call_function_many with on_each_cpu_mask call.=0A=
  5. Removed arch_has_empty_bitmaps=0A=
  6. Few other text changes.=0A=
  7. Removed Reviewed-by if the patch is modified.=0A=
  8. Rebased the patches to latest tip.=0A=
=0A=
v3:=0A=
  https://lore.kernel.org/lkml/166117559756.6695.16047463526634290701.stgit=
@bmoger-ubuntu/ =0A=
  a. Rebased the patches to latest tip. Resolved some conflicts.=0A=
     https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git=0A=
  b. Taken care of feedback from Bagas Sanjaya.=0A=
  c. Added Reviewed by from Mingo.=0A=
  Note: I am still looking for comments from Reinette or Fenghua.=0A=
=0A=
v2:=0A=
  https://lore.kernel.org/lkml/165938717220.724959.10931629283087443782.stg=
it@bmoger-ubuntu/=0A=
  a. Rebased the patches to latest stable tree (v5.18.15). Resolved some co=
nflicts.=0A=
  b. Added the patch to fix CBM issue on AMD. This was originally discussed=
=0A=
     https://lore.kernel.org/lkml/20220517001234.3137157-1-eranian@google.c=
om/=0A=
=0A=
v1:=0A=
  https://lore.kernel.org/lkml/165757543252.416408.13547339307237713464.stg=
it@bmoger-ubuntu/=0A=
=0A=
Babu Moger (12):=0A=
      x86/cpufeatures: Add Slow Memory Bandwidth Allocation feature flag=0A=
      x86/resctrl: Add a new resource type RDT_RESOURCE_SMBA=0A=
      x86/cpufeatures: Add Bandwidth Monitoring Event Configuration feature=
 flag=0A=
      x86/resctrl: Include new features in command line options=0A=
      x86/resctrl: Detect and configure Slow Memory Bandwidth allocation=0A=
      x86/resctrl: Introduce data structure to support monitor configuratio=
n=0A=
      x86/resctrl: Add sysfs interface to read mbm_total_bytes event config=
uration=0A=
      x86/resctrl: Add sysfs interface to read mbm_local_bytes event config=
uration=0A=
      x86/resctrl: Add sysfs interface to write mbm_total_bytes event confi=
guration=0A=
      x86/resctrl: Add sysfs interface to write mbm_local_bytes event confi=
guration=0A=
      x86/resctrl: Replace smp_call_function_many() with on_each_cpu_mask()=
=0A=
      Documentation/x86: Update resctrl_ui.rst for new features=0A=
=0A=
=0A=
 .../admin-guide/kernel-parameters.txt         |   2 +-=0A=
 Documentation/x86/resctrl.rst                 | 130 +++++++-=0A=
 arch/x86/include/asm/cpufeatures.h            |   2 +=0A=
 arch/x86/kernel/cpu/cpuid-deps.c              |   1 +=0A=
 arch/x86/kernel/cpu/resctrl/core.c            |  51 ++-=0A=
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |   2 +-=0A=
 arch/x86/kernel/cpu/resctrl/internal.h        |  33 +-=0A=
 arch/x86/kernel/cpu/resctrl/monitor.c         |   9 +-=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 298 ++++++++++++++++--=0A=
 arch/x86/kernel/cpu/scattered.c               |   2 +=0A=
 10 files changed, 496 insertions(+), 34 deletions(-)=0A=
=0A=
--=0A=

