Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809396DC960
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjDJQfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjDJQfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:35:51 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1113B189;
        Mon, 10 Apr 2023 09:35:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEw9Ja0xGM0YQNN2aUJzBwB+dB3k0Y+GdyUIQJhbxeEmm2DgF7QyV0YIYCIbAqKD9R7wq3N3GtffuD/Gz7X6ZMjKH8a2kuNyoq/FFH37GQt6WOwAdpp3jl2W/TQnQNPb9CjaMDsO7pBKEm7hZw2fJtbMzE74kfYaF90Blo+5y/xhil1KPq3RmP58CMRb55eO7M632qiOSZEd90BXiq6eGG1sooEXf1D+GnstqXldPOsZnng8nqSnExTYMOpJ3TExLSCzOoimF5HydtVbkUz0u6gmvlQqEVPqvMjDMmmkmRdZet/RTgQPwWvwNao9tFdI1NoiWw+WZi6aWQEzx5Fo+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PlOwcNcTtXGnlmqhDNFnIR85/M12exiue5PBJhUqW8=;
 b=HMRGu+bciifC209egQI4hpb6o6hIIsOWzf1Tiai2CYcpdxteBGctEDWfkeZWKigxzupgFBmg73OiLXlYN/70fKdWU0QPQgo4a4GcJkA1vCio6lRjXYMnfzmFrWswBOAtGSIGSLRv+1Uzdl5hkNtkOx0Ff8ckong3+QzwWSWL/IsKc/Rrz1BoPceQjpKwOo2YZvx3wU56NEVYFbdpZhVbBnbJvedesgEh8unXCqFP+7/ubAnptDDz4BGQs7Av9gTXQgwT5xQ/R+R7lL0gjPFCyE0xddbNoIY+DOO6ox8QVUiKEvrpxUljnSFqYy4Cr8ZP9sEO/km9zvQV32Vcno5STA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PlOwcNcTtXGnlmqhDNFnIR85/M12exiue5PBJhUqW8=;
 b=du6DLAM1R+yPgdndYT93r9RWkmFnhtEnIQGdw2+SclMeA9/eN9HT5SVn3B/MAZn2WFdmM2/CcBtEjQle4/yweP7x0S15YIAJ2JGSa9GtpKslsd1wK8pKLL5qMVZct0HqBwKpsPKFhlxaZXmuKrmfcfX/eirTlJXdkdNZxPhoBLc=
Received: from MN2PR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:23a::26)
 by SJ0PR12MB7474.namprd12.prod.outlook.com (2603:10b6:a03:48d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Mon, 10 Apr
 2023 16:35:47 +0000
Received: from BL02EPF000145B9.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::c4) by MN2PR03CA0021.outlook.office365.com
 (2603:10b6:208:23a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36 via Frontend
 Transport; Mon, 10 Apr 2023 16:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B9.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.25 via Frontend Transport; Mon, 10 Apr 2023 16:35:47 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 10 Apr
 2023 11:35:40 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <corbet@lwn.net>,
        <jgross@suse.com>, <andrew.cooper3@citrix.com>,
        <peterz@infradead.org>, <Jason@zx2c4.com>,
        <thomas.lendacky@amd.com>, <puwen@hygon.cn>, <x86@kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH 0/2] arch/x86: Set L2 Cache ID on AMD processors
Date:   Mon, 10 Apr 2023 22:05:25 +0530
Message-ID: <20230410163527.1626-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B9:EE_|SJ0PR12MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: d5ab7d90-76f8-4237-b491-08db39e1a33b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+A/ICHFYJVcUYOI+DiO96EWTcF88EhNRd4EJA8aLP0Uf2qqHSCTWxjjUlnermDtmZhvVl4KhJsBsCSq/FbGGHRC7PsMbsTHgZC+nSVwkRFJFyGBHwI/KARKnnjHcR7+5chCB9I9iKUgNzKs3CHE1TjaHt3v8XotVdeHjA4cq9cHWewyixQiaAZV/ZeR9NCpqhdKHFjHcXO8cwtPWUyMljVkuZYkxbT8+M8UUkbJGzpGUHCioTVR+NFw7Ey9yJvhJ5E/zwOqk0MvFiVv3z/QBxeG/z0tlw+ML9cgyNH9VDEJlHMGuZ7vDXCHsPtMBUQBXyha1EcACSyDy3yw1H/ZTTqL+kuZCv2PLkW3telI2lGtepjRBcy2lPw82sKOqGB0sSkOBdvWbvYO1o8DTAXfS+W5LYCnfV7mF4+7YAQqVnQYGwCfMVAvdq6Q27XlMcqpxRcRqv4mGXvl+YX50WJBs2MagPKrAEIqLhFgZUx8OMpMcajeI2XixHhKX3WVgXYS0co589Nu6xshANYxMx1laOK49Ict/h8YD3QQrmX/2MdGDU6ulpNKi9LFsqHkRHZZCrrOcODs4OwpYdmSc3wHJ+LeMmu1/nVgXTQJuuRoaAT2K6ucl6denJ6QQsQuj0HVGUEgdpu/+n6urlZEXI1p2CFtA/CbWDUYtVyK8X1sNY+KckOSzd1iZ44tucQkjsM+3x5aA8VJNLs2rsecVX7spj3QdX5UGo1JcASlluHOowM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(36840700001)(40470700004)(46966006)(86362001)(36756003)(54906003)(316002)(70586007)(41300700001)(6916009)(4326008)(7696005)(70206006)(8676002)(478600001)(83380400001)(40480700001)(82310400005)(5660300002)(2906002)(8936002)(7416002)(36860700001)(356005)(186003)(82740400003)(81166007)(16526019)(6666004)(26005)(1076003)(426003)(336012)(2616005)(47076005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 16:35:47.1612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ab7d90-76f8-4237-b491-08db39e1a33b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7474
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 66558b730f253 ("sched: Add cluster scheduler level for x86")
defined cluster on x86 as the set of threads sharing the same L2 cache.
cluster_id on x86, maps to the l2c_id which currently only Intel
processors set.

This series sets the l2c_id on AMD processors with X86_FEATURE_TOPOEXT,
using the extended APIC ID and the "Cache Properties (L2)" CPUID
(0x8000001D EAX). On AMD processors without X86_FEATURE_TOPOEXT, current
behavior will continue.

Following are the changes in value reported by
"/sys/devices/system/cpu/cpuX/topology/cluster_id" on a 2P Milan system
(2 x 64C/128T) where L2 is per-core level and SMT sibling of CPU (X) is
CPU ((X + 128) % 256).

- tip:x86/core

  $ for i in {0..255}; do\
      echo -n "CPU$i cluster_id: ";\
      cat /sys/devices/system/cpu/cpu$i/topology/cluster_id;\
    done;

    CPU0 cluster_id: 65535
    CPU1 cluster_id: 65535
    CPU2 cluster_id: 65535
    CPU3 cluster_id: 65535
    CPU4 cluster_id: 65535
    ...
    CPU254 cluster_id: 65535
    CPU255 cluster_id: 65535

- tip:x86/core + this series

  $ for i in {0..255}; do\
      echo -n "CPU$i cluster_id: ";\
      cat /sys/devices/system/cpu/cpu$i/topology/cluster_id;\
    done;

    CPU0 cluster_id: 0
    CPU1 cluster_id: 1
    CPU2 cluster_id: 2
    CPU3 cluster_id: 3
    CPU4 cluster_id: 4
    CPU5 cluster_id: 5
    CPU6 cluster_id: 6
    CPU7 cluster_id: 7
    CPU8 cluster_id: 8
    ...
    CPU126 cluster_id: 126
    CPU127 cluster_id: 127
    CPU128 cluster_id: 0
    CPU129 cluster_id: 1
    CPU130 cluster_id: 2
    CPU131 cluster_id: 3
    CPU132 cluster_id: 4
    CPU133 cluster_id: 5
    CPU134 cluster_id: 6
    CPU135 cluster_id: 7
    CPU136 cluster_id: 8
    ...
    CPU254 cluster_id: 126
    CPU255 cluster_id: 127

Note: Hygon, theoretically, should be able to set the l2c_id using the
same cacheinfo_amd_init_l2c_id() function being added in Patch 1. Since
I do not have access to a Hygon machine to verify my theory, ccing Hygon
maintainer Pu Wen <puwen@hygon.cn> for l2c_id enablement on Hygon.

The series also adds documentation for clusters on x86 platforms and
applies cleanly on top of tip:x86/core at commit ce3ba2af9695
("x86: Suppress KMSAN reports in arch_within_stack_frames()")

---
K Prateek Nayak (2):
  arch/x86: Set L2 Cache ID on AMD and Hygon processors
  x86/Documentation: Add documentation about cluster

 Documentation/x86/topology.rst   | 31 +++++++++++++++++++++
 arch/x86/include/asm/cacheinfo.h |  1 +
 arch/x86/kernel/cpu/amd.c        |  1 +
 arch/x86/kernel/cpu/cacheinfo.c  | 47 ++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/hygon.c      |  1 +
 5 files changed, 81 insertions(+)

-- 
2.34.1

