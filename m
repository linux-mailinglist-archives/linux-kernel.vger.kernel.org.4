Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9255FA639
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiJJUaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJJU3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:29:41 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208BC62F1;
        Mon, 10 Oct 2022 13:28:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQTxWODgRXxCrlpBbRyQjDFF8pnqs0/0XL+3IzJ/YcO8/iZwOwxflT+WgXpsHm0QlsSHK9rQFt2kU5ErVMPPlaaigI6oMjMquXE9dlpACgoBGkPgZpCjslxDhRUNymHVLZWRL3t5s/aaSz40KzzFI4WSrDVFSuM8AAtTrxAypQ+xi6w1V5FqsdkmnPVA2Yz81RWEWKoC4fq6cxTFrs660CBzuB4t7b6joHzOmISYOzy+ey6pbzy4CVy6IKQF0HZSUqsMs/Pb35PAPXfbyesH1L6ZF5KR6+zDh6eMEcvL9n4ZDd1g7TcipBHAJn8wIRlnQdQbEChAC9Fn+LOaW+bWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xr9X6Cx8qPUXKUY20vHQnnWV4Z9lT49fGVOTJ90EP1E=;
 b=oXQ1cldC3yCN9pk7cdvx7r1+hcbxkREaKjW1+Dx/ZgApVNzn7vDQkwLbimIBcpS6smX2PmQsJ6vow+zuf+NxwAtyrgV+O/h9snpyTX+LQplkwLzB8IL39inPOV4fnjSB1ArlHL0sRPlsNc+kb6DWP2yxwfNSgVX+4Uu4y9AOH9Gs3V8oXqji8HDkj35n3Ks+BROulktcZLGLViuPjOlaOx0L4rAkDxmRyKvgObKDIu84b7sGdf8vSG4ps7Y/z/1gSZCmrWMBxBVYk3GMJpeBqk4SFsxRqvCEICmqaBKO/2mhdfhK/HRjbdp8DUPHOOjX6ZhAtOysZucVQvDR0MjlrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xr9X6Cx8qPUXKUY20vHQnnWV4Z9lT49fGVOTJ90EP1E=;
 b=0ztHkXxGVKsSZV7NDgc8jLnz3sGsBBJxWeIhyxXnlJgoHif2ysCjMSblEPJi/WqRqg0XO32bkrrZCMVJR+C5kYqqFpDGB9cG0/mS1Q/Fj+Qdil1qqF/DQkPRzAUL6b7VQ8OBGdBcwLFM5nGrg4VPK2is1xSWXVsVIzdcJH2VTTQ=
Received: from DM6PR18CA0005.namprd18.prod.outlook.com (2603:10b6:5:15b::18)
 by SN7PR12MB7022.namprd12.prod.outlook.com (2603:10b6:806:261::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 20:28:38 +0000
Received: from DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::54) by DM6PR18CA0005.outlook.office365.com
 (2603:10b6:5:15b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 20:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT105.mail.protection.outlook.com (10.13.173.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 20:28:38 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 15:28:05 -0500
Subject: [PATCH v6 00/12] x86/resctrl: Support for AMD QoS new features
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
Date:   Mon, 10 Oct 2022 15:28:00 -0500
Message-ID: <166543345606.23830.3120625408601531368.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT105:EE_|SN7PR12MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: c84d4f8c-3ce8-4b85-9fa2-08daaafe0370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 116nGCMb4jDodwk2iaXBY2q2tMM9Uax5RZo+R4FwW6nvZIgyudbfPuPeGY9vX1/NqdEWFLOCvtuutQj9XgK6zHmP6z//I9rBurNvWN8I6El3/O5gAGPGslgez7RezSDmG0tghQbLHPPAgSTXyJagSb2IRMdCGK2U7ibiZ0Y1M0RpckfVvbpJPtHI/BpU2E+3XAgq0QRturo9Rkqxsp360PTprzVD56t1bJSQdV9YOYqtvnIv3O6Mp40LN8fHWpEhtjky3rqDh53JdSrD//VJUeddhY8+QKdJIx83UtErH2YmRjj6I8/bdJ2j71gBcdDPTncarTB0lYOzU8FQ69U4b6/bPnsxxiC8adQa1MUFiEbV9Fv63RNVLPlnWaaoEwxWjanJlKCRLDcFDYU8eLneV+8C8h2TgKh7NLffYcTgKtvTz58SPslI9pysTj5824DvUeGoLioB2wFMjKpxD5Kt492+Z7UPyoZaVkepbhivZ/xUBk99ayIVWNJOXU9hsNsYCsaT1d+yM7Sl0rMCIjmCsI86IAdnAzmXbe6x93rEShJgVVhWhMincpFJJjDlpSXZx8X0lSI43f+CbhPfn7pa/U4POnnZHHKTUaru1lgxsSy8o08VkC07KBK5H+gfWOfdhGEqW2+szuV3NepvTU3hCWUpEvUw23xieOQVzzQgxMXKJ+UPHlllHPyWcPRygVd2YUUlxXqkGPcP4YVgtFU7F+c46doddOMH8kVWWqFxj08Xg5lAZtXOqCwOYf50REod251iIaNOrt0g+YEC8loMSxamK6dAUjHZr09m3D1QlotMaccBApTBsuvbEqCJKbOBAKSNVFhtoPXvONuw16rFJDqn1vIQ7ut4AdoGT09ARP2NXlKqwlV81nGBE0gGWkJc
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(16576012)(47076005)(82310400005)(86362001)(426003)(54906003)(82740400003)(83380400001)(7416002)(2906002)(41300700001)(6666004)(33716001)(40480700001)(103116003)(316002)(9686003)(16526019)(26005)(186003)(81166007)(70206006)(336012)(8676002)(4326008)(356005)(70586007)(110136005)(44832011)(966005)(5660300002)(40460700003)(478600001)(8936002)(36860700001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 20:28:38.1849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c84d4f8c-3ce8-4b85-9fa2-08daaafe0370
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7022
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
Feature description is available in the specification, "AMD64 Technology=0A=
Platform Quality of Service Extensions, Revision: 1.03 Publication # 56375=
=0A=
Revision: 1.03 Issue Date: February 2022".=0A=
=0A=
Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-qu=
ality-service-extensions=0A=
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537=0A=
---=0A=
v6:=0A=
 Summary of changes:=0A=
 1. Rebased on top of lastest tip tree. Fixed few minor conflicts.=0A=
 2. Fixed format issue with scattered.c.=0A=
 3. Removed config_name from the structure mon_evt. It is not required.=0A=
 4. The read/write format for mbm_total_config and mbm_local_config will be=
 same=0A=
    as schemata format "id0=3Dval0;id1=3Dval1;...". This is comment from Fe=
nghua.=0A=
 5. Added more comments MSR_IA32_EVT_CFG_BASE writng.=0A=
 5. Few text changes in resctrl.rst =0A=
 =0A=
v5:=0A=
  https://lore.kernel.org/lkml/166431016617.373387.1968875281081252467.stgi=
t@bmoger-ubuntu/=0A=
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
@bmoger-ubuntu/=0A=
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
 Documentation/x86/resctrl.rst                 | 136 +++++++-=0A=
 arch/x86/include/asm/cpufeatures.h            |   2 +=0A=
 arch/x86/kernel/cpu/cpuid-deps.c              |   1 +=0A=
 arch/x86/kernel/cpu/resctrl/core.c            |  51 ++-=0A=
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |   2 +-=0A=
 arch/x86/kernel/cpu/resctrl/internal.h        |  31 +-=0A=
 arch/x86/kernel/cpu/resctrl/monitor.c         |   7 +-=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 313 ++++++++++++++++--=0A=
 arch/x86/kernel/cpu/scattered.c               |   2 +=0A=
 10 files changed, 510 insertions(+), 37 deletions(-)=0A=
=0A=
--=0A=

