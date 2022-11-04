Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094D961A1AF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKDUAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKDT74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:59:56 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA8ADFA1;
        Fri,  4 Nov 2022 12:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VD2xpVn07YRwPn1HddbaouHUJpB5VVlqHvkPXvIgIbfKFSH5It1qTxLvB6pd/M0LaxD6dIp7msULXFzXVbxewa2cWmg+C6MoGKBGd60blf7iRtHzs6HMnfb1W1Lq+dhBqAf3YXuglA8ER6C1Q3/8Y8EdcrCFORehyqYounm0Sy+1sImmoH4O8E9V68av+23LbjOW72dhCjttZYFkkd4XihIYaODJZ+FJPvzzwi6RJKCXElvTiUbtIXz9bqA77+2e5XZRP+tGdhNKc6SlMA8xshYqQVx3C1f4grqDtDZWxi098Rp/yQDDwXkmV1E5gRwC0aS6D5jsaPI8l2aaXsuEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCGfXwg+Yy7wk8yV6Y9jkZv5IFKIZTOAMCG3e1U2jrA=;
 b=bljL1yqNqYXoEP0zDwhW9zCbEbTFxkp25QPid+cVdWaA1wtnn7LJZzwXwtCBn0ISLnyoHm+wdnQFbm1drO0ssmOGZU7Up2d3YzXqyU7Hm/0Rh42tQ9soQc2NdZaQofRWI35mXurOZIPmOHlvrQx/19VP4mdtNZW/Kn4MehyHqrmJcV/HuZBR32uAIe8k5iD9xfWR0s5jjUngPHmDFggM2XwfNb/bWjP5P6KS3M6zTxpGb5pISAszpMNbbFUkHHof477tT0piX5qtPxmAhcehG0GbwStaTu2DhnPo0s9suAwWinN3CgaZz+OrEoHHmZ2IjqdjCoKapSCFrvS1dswTDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCGfXwg+Yy7wk8yV6Y9jkZv5IFKIZTOAMCG3e1U2jrA=;
 b=iTgeQjEYnF1hwmYb+JQC/9/OqAPVoXHrCcEv5SdQd0Z/OBk2hVq32mJnAEJjnuwVYK5xJozfoK5OcsKS7fh8OfZnwtKfC5z/CgvRBRz5jeSQ+fPcZ2JPKx8osABF4ll4LsH1tLJhGESvihfvihfHoCImtdkhdXLU0kmdiSzMqf4=
Received: from DM5PR07CA0104.namprd07.prod.outlook.com (2603:10b6:4:ae::33) by
 BL0PR12MB4897.namprd12.prod.outlook.com (2603:10b6:208:17e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 19:59:52 +0000
Received: from DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::cd) by DM5PR07CA0104.outlook.office365.com
 (2603:10b6:4:ae::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Fri, 4 Nov 2022 19:59:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT092.mail.protection.outlook.com (10.13.173.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 19:59:51 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 14:59:49 -0500
Subject: [PATCH v8 00/13] Support for AMD QoS new features
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
Date:   Fri, 4 Nov 2022 14:59:49 -0500
Message-ID: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT092:EE_|BL0PR12MB4897:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a897f8-bd3e-44a1-1e83-08dabe9f22d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bk8uoPAovG8UpUel/ynuFHyFSttOGouYD6CKmn2eMkNOuiz6R9lSaVeXdV/1zO/UwV23TnIYSivI9prVHQvDAbkxVecMYQlTOBkYuNadDAkPhb/C0E938AvtU1E0pZtlAwLgVsif0O8WMTZQJTPjuAU++/c0JiK8Om5kF0lQAS13szkfJwX72YjQqIhx6hXmvpVdWdCKfSXPenxgafCXdu13SGcQTJJ8Wgkyy8U8QfeFI2QQe0NBGRyiSXifCDIwJu/ZYVonPb7Qi+o59agxbrR7QPh7bAiQbT+uVpLRPYX94VnO0YXjRdMjjpY2CyI2acbvEwc+2Q4gqj+dMSiLBla6KgbjAo+8yU9xR6vFBP5zJWZGqBB5c/RlCMMYc+NhvmapKjE7TnC24RqKDpMTDnNiSkihsVXO45Q2aIYGclxHSjhtbkao9npBp8LxtWon1aD69zzvQVxf8OLaBgukjA0nftRJYojhXTBx61dqQxeYvFt04EaDZ/5Pjyxaux/+Oayz/Zebqo2uXiVI411rSHNDi5UZC5g08ngifhqB+ezIeARu0NE1utO3NysdOKzARiZYdrJbi5Uols9F/42cPQ/vxvTYHWtlBv1RrOS2Q0NskWEanCtOoiStZCgJAquWmPAvQzW+HVKJ18I/v9S2zUdBKjq2RnaWP8+AjrjVTERVTM0ZQ1RGflduE4Kk0BHraBraggd73ByQDVEQ9dH1qssm2NY/QrnEVF8VSRbS/Q7LFb6lb3pUIur7d1wdYstAF4PLa+tjCLJbaIYXvGRGNZ4ZZHzcDR+eyiiAEkJE67VK2uAVZ+tBNCEUVf7w8fD+M7+B3XGdYnntJZ+0qERplpC/GCIGU1tGCCbV7CKOPQT/5acNS5EtJ7xsFZnucyaN95EMDWMfB9W7+KVCeOsZ8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(356005)(81166007)(33716001)(82310400005)(8936002)(82740400003)(478600001)(966005)(44832011)(316002)(103116003)(36860700001)(86362001)(40480700001)(16576012)(110136005)(40460700003)(26005)(8676002)(41300700001)(336012)(9686003)(70586007)(4326008)(7416002)(70206006)(5660300002)(54906003)(47076005)(16526019)(2906002)(186003)(426003)(83380400001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 19:59:51.8707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a897f8-bd3e-44a1-1e83-08dabe9f22d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4897
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
atform Quality of Service Extensions, Revision: 1.03 Publication # 56375=0A=
Revision: 1.03 Issue Date: February 2022".=0A=
=0A=
Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-qu=
ality-service-extensions=0A=
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537=0A=
---=0A=
v8:=0A=
 Changes:=0A=
 1. Removed init attribute for rdt_cpu_has to make it available for all the=
 files.=0A=
 2. Updated the change log for mon_features to correct the names of config =
files.=0A=
 3. Changed configuration file name from mbm_total_config to mbm_total_byte=
s_config.=0A=
    This is more consistant with other changes.=0A=
 4. Added lock protection while reading/writing the config file.=0A=
 5. Other few minor text changes. I have been missing few comments in last =
couple of=0A=
    revisions. Hope I have addressed all of them this time.=0A=
=0A=
v7:=0A=
 https://lore.kernel.org/lkml/166604543832.5345.9696970469830919982.stgit@b=
moger-ubuntu/=0A=
 Changes:=0A=
 Not much of a change. Missed one comment from Reinette from v5. Corrected =
it now.=0A=
 Few format corrections from Sanjaya.=0A=
=0A=
v6:=0A=
 https://lore.kernel.org/lkml/166543345606.23830.3120625408601531368.stgit@=
bmoger-ubuntu/=0A=
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
Babu Moger (13):=0A=
      x86/cpufeatures: Add Slow Memory Bandwidth Allocation feature flag=0A=
      x86/resctrl: Add a new resource type RDT_RESOURCE_SMBA=0A=
      x86/cpufeatures: Add Bandwidth Monitoring Event Configuration feature=
 flag=0A=
      x86/resctrl: Include new features in command line options=0A=
      x86/resctrl: Detect and configure Slow Memory Bandwidth Allocation=0A=
      x86/resctrl: Remove the init attribute for rdt_cpu_has()=0A=
      x86/resctrl: Introduce data structure to support monitor configuratio=
n=0A=
      x86/resctrl: Add sysfs interface to read mbm_total_bytes_config=0A=
      x86/resctrl: Add sysfs interface to read mbm_local_bytes_config=0A=
      x86/resctrl: Add sysfs interface to write mbm_total_bytes_config=0A=
      x86/resctrl: Add sysfs interface to write mbm_local_bytes_config=0A=
      x86/resctrl: Replace smp_call_function_many() with on_each_cpu_mask()=
=0A=
      Documentation/x86: Update resctrl.rst for new features=0A=
=0A=
=0A=
 .../admin-guide/kernel-parameters.txt         |   2 +-=0A=
 Documentation/x86/resctrl.rst                 | 139 +++++++-=0A=
 arch/x86/include/asm/cpufeatures.h            |   2 +=0A=
 arch/x86/kernel/cpu/cpuid-deps.c              |   1 +=0A=
 arch/x86/kernel/cpu/resctrl/core.c            |  56 +++-=0A=
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |   2 +-=0A=
 arch/x86/kernel/cpu/resctrl/internal.h        |  33 ++=0A=
 arch/x86/kernel/cpu/resctrl/monitor.c         |   7 +=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 304 ++++++++++++++++--=0A=
 arch/x86/kernel/cpu/scattered.c               |   2 +=0A=
 10 files changed, 515 insertions(+), 33 deletions(-)=0A=
=0A=
--=0A=

