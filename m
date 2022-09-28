Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3261B5EDAEB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbiI1LBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbiI1LAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:00:48 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069E489827;
        Wed, 28 Sep 2022 04:00:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJT4rxsC2ZqdjVy6YMbZrob94IhR6NePMoL3TnUP412nAKdxUNhI46fMEk0Q137QmUw8DFKnd9hBp45uMqDLd8KGgt3lna9iAxTxhimi8FbUmvBSnH6ri0jWttbIUPIbTQzmppG4jVa8P/rMG9Q8XtdGrDB6FuHN3Qm8K4YV0EZ/gRJMnYZAtHtTNVYxUKHeONG/DiBHVv0z8nM3EPHII/xL0VwrOE9XTzP28+dvCdseOLTyERgXOZZ1gbu0bGzvqadGtUz6tyk7pBBTyU8SJNdAUN3z0B015nsHv29PWGJo32r9lzq3xuUFpG2Spq6O7XJq3w6FNlr27FbasD+vfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WW//KqL5TtZYSBkMZ1g82T9zh3lZwNLkAB5qcyuDtek=;
 b=FIE4O8/p17buefamjRkShCAmyoNQ6p6AdajqEaQPfoGbhO3IDAF6blPVRiGr+avr+F8ozlyjeSw72c/OU0nNbvc9Ff+JWf6SR3h8+ywjgsLZPf15HR95xpq0Wzt1yC2f+nSOz88HjqJdy7PNAvN4QWwcBKs1sz5ChpBCBR2vYGvg0KsIbzYLCZKBSIOO7J+hAYOmdJuHTRLCTWxY51NqkKlzUtItUPTfKOnm8gz4n9T//xNs7MUxp67xbUwqWrtjXjIzfIU7jOnueHLAjb2dQWvJR8ie8yWGSfFgopD2F2E87i6m8J9iGrbz9dlwUSgKBqRGbbgoJ490MPM4tS+YjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WW//KqL5TtZYSBkMZ1g82T9zh3lZwNLkAB5qcyuDtek=;
 b=q5llyhVYrDzKWadv/sF4o4kQNPzr0aTr+q0RAaFJvhTkPzNj4lR1leemrEhxnXydvsgsB7FJNBQX5VB6n79PD8hxDpuHH96+zRPy847hxE7itjsFamt78ipIbAgLhMRmPuJKrXxs5sI73rPuPngGbhQLSYDrvmSuBdvnWk7bVWk=
Received: from DM6PR07CA0128.namprd07.prod.outlook.com (2603:10b6:5:330::20)
 by DS0PR12MB7653.namprd12.prod.outlook.com (2603:10b6:8:13e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 11:00:01 +0000
Received: from DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::4d) by DM6PR07CA0128.outlook.office365.com
 (2603:10b6:5:330::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.27 via Frontend
 Transport; Wed, 28 Sep 2022 11:00:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT069.mail.protection.outlook.com (10.13.173.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 11:00:01 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 05:59:55 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <like.xu.linux@gmail.com>,
        <eranian@google.com>, <ananth.narayan@amd.com>,
        <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH v2 0/3] tools perf: Add branch speculation info
Date:   Wed, 28 Sep 2022 16:29:37 +0530
Message-ID: <cover.1664356751.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT069:EE_|DS0PR12MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: e4217009-e7b3-471c-27d0-08daa1409717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: crsA+olTUKdK2QutrSwwMLKXfu9pm1NlQ7r38uwID99v6Q/kQ1esnm5afRG8yUBmjxeADPwmcOMIWpFNLaJYPPCGojo1rmSB9qH0+opd/q8MADQmHOi4bol5lkWURjhvxm/91IzrEFPMiaGWVyaH1ZqNTIKjSsa3UIBhOe5vEZEu3o6b4/eafJy/KQL2L05tZekgaKq8AARtTWVYms1Nge7EQsZT/pBDP2qZsyHuWdw90lC6+VrbR7Bx+Ht8GKZfx7/QhQ28IDZB4HwrF4cKbhbpqwqwKaZ733Nkw+roS4ywp1Avj8LL4HvktGfdfyKlQv4daaN1MxSDz9O7hLwWp0bvahHwnO99qI5Inlt5M114aYB10m3qFb+Doz59yJhJO/0ZGNgTMKzYk3/wOEIUdst9vykB92LOj+spS1RIsyf3mmrh/xBxWMGiGCNnSTc3IR3+vrqrhnWnt3H7zV8Y+FSHpF7ZiMYgms7hYXrkDxBmeJJd5qIouiJmtwpdGrOw4bL93thfNrP5yId44gA1xQbpfAy/+F13f2zheENh9lJFxe28/XJUZkxZGlcpHxUxzM4RGUMtKIZWwjB7JGH94mlIvRBsPuvtXXWX/YcSuz7onPzqPoCLIHsBtzWSEmIrJzSQekgW2vzaZD9C4Jp+6Resi+Ff5p3MH0MD1k7Bbj95/f4cFFBa9dCqiVfLW0rMsTNarJEcPisrhzGxsIPuPQ2rd4RtKUIzzQKF0T86T/DGMPpOaexy/1/bUXp1x2SwfD9NNgrZt85RLclz0agRDyROBjMu5+1LKrnP7WYtfvqwr4Hohs8NJyfubuq+w/tatwx9caN5f1wKW+loYCJyoFbcWWo3xMJsoD1JXV0/gDMRHeMbToMeWY6oCUoAD9aI
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199015)(36840700001)(46966006)(40470700004)(8676002)(47076005)(41300700001)(426003)(2616005)(4326008)(70206006)(70586007)(26005)(81166007)(356005)(86362001)(186003)(36756003)(16526019)(336012)(5660300002)(44832011)(2906002)(7416002)(8936002)(6666004)(83380400001)(478600001)(40480700001)(36860700001)(966005)(316002)(82310400005)(82740400003)(40460700003)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 11:00:01.0109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4217009-e7b3-471c-27d0-08daa1409717
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7653
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Last Branch Record Extension Version 2 (LbrExtV2) provides branch
speculation information and the perf UAPI is extended to provide this in
a generic way. Update the tools headers and perf tool to be able to show
this additional information.

The LbrExtV2 enablement and UAPI changes can be found at:
https://lore.kernel.org/all/cover.1660211399.git.sandipan.das@amd.com/

Previous versions can be found at:
v1: https://lore.kernel.org/all/cover.1660217326.git.sandipan.das@amd.com/

Changes in v2:
- Drop msr-index.h related changes for now.
- Rebase on top of latest perf/core.
- Fix UAPI breakage introduced by the ARM64 BRBE changes to perf branch
  entry.

Sandipan Das (3):
  tools headers uapi: Sync perf_event.h with kernel sources
  perf script: Show branch speculation info
  perf session: Show branch speculation info in raw dump

 tools/include/uapi/linux/perf_event.h | 15 ++++++++++++++-
 tools/perf/builtin-script.c           |  5 +++--
 tools/perf/util/branch.c              | 15 +++++++++++++++
 tools/perf/util/branch.h              |  5 ++++-
 tools/perf/util/evsel.c               | 15 ++++++++++++---
 tools/perf/util/session.c             |  5 +++--
 6 files changed, 51 insertions(+), 9 deletions(-)

-- 
2.34.1

