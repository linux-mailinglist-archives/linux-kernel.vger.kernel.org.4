Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39F25ECE35
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbiI0USL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiI0URs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:17:48 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD05CE0F1;
        Tue, 27 Sep 2022 13:16:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoeX7DqEOnsSZ6hSMOCy/c6H74g4Sg52tXWV/zi8gTxQkk+FRj1tjncyoTS7d7lo7kGsGekYRsUIDmxxV/Y78z1/MdwQhfvf/hwqAGKRY/QP0siQoKNg7PPn74yGqxGppVPMZVUl/KWmiN8eAENZRQyS0P3j9kESUt7sAxCrjO1JAnpQEKdCnA5mSPlQCocR8LeyHnB9e//lLU7ngrwsHka2vV14BYN+Dj/J1RhQA/BEX5pvRIV17tqhyYURciZSxxaVqmPeALqbnOLUTA3HDwCw/apyyPPKukhGMWqiXJdjn5ra/SJySxuLXbvqp4zvhaSTXpQMS7sI31WoSU3u2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TY5SPXTdc06ubH3G7e1vhn4N2NnA0kJtnca25kdnq6k=;
 b=V7/o0GQ1XPNlDvTwFBhHIptsIg7A395bN6tvyN7gNge76hmnoIdMamp2aMmqXpLh3aPV2WOzyUj64OM+64iyoQIoYShpyeSJQMsaJDku3ApegdYfmq6lVGkaBMo4hBmjPDhU00p1Q4t6Bz/A3SX1DUZ0i0q4jauj/qXBll/tWO6H5+qH7gWFquYIaR4y7kTAo0lS9iuZAfZfam68vLuNVcT5Z7fmNxlyZM/MusUnpSwMZhcrOqqveUIqv/tJkHMj2awtm5eYOWFaznEcd615ihrt+KX85cCTBVONu3wcKKZNdFqYSW3YCQmRuYmWGrSO3ftSbDk46XPP3OwXjGZ+Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TY5SPXTdc06ubH3G7e1vhn4N2NnA0kJtnca25kdnq6k=;
 b=vLGUkoGuixXJgvVD20aQQ4l7pIISjL7pYIM13pdV9fHCdeZpU9NiHADc9bgXZPTl3AZDVlcrZDjYwTHuyl2dL9dQhXdiOfVOsllNdDYVZ1ToadHK3RlhfOB8w4HwhacHYVd3S/FC/vpeJKHJMWbwj7wogj8FrrzBcqKMbSfdtLY=
Received: from DM5PR08CA0030.namprd08.prod.outlook.com (2603:10b6:4:60::19) by
 MN2PR12MB4552.namprd12.prod.outlook.com (2603:10b6:208:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Tue, 27 Sep
 2022 20:16:25 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::b6) by DM5PR08CA0030.outlook.office365.com
 (2603:10b6:4:60::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Tue, 27 Sep 2022 20:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Tue, 27 Sep 2022 20:16:25 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 15:16:23 -0500
Subject: [PATCH v5 0/2] x86/resctrl: Fix min_cbm_bits for AMD and code cleanup
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
Date:   Tue, 27 Sep 2022 15:16:22 -0500
Message-ID: <166430959655.372014.14294247239089851375.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT028:EE_|MN2PR12MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: 74014476-70ab-4b10-f150-08daa0c52715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YnCiPGfHQzkZ1NSyiO5OP/UpKwBBmtjV46n5sY+Y9EMc+ek3il1N0+RkytZUKA1dSR80JUhaMZdVvsP6v/X2v81tdOxhwT3Gd0TfdNWkZdT6ZK2ZwbJYb7dDALqVm81sWtqIl2OONlPFboV3jbo6296L4lhyY6j4slb1Z3tQe0pPl3mUfaiOwXyyT20n24eXJpSnZvWEVD7R/Q61Vgx1XWK4B5/8ITTh3qWmC1rAPp5RSGa3kcDx3rjKlJkZ2FwhlxyO9/4U7OXxlpVz/jyXhBnGL/F++Pyquba6CipFDVxwI8CF3HniHU0iLDNpYKBWkduANZkqI8+dL/fJFbrOlAcUVdexH5NpQf3zYx1F4AKdYKCHvNRdNzvDrfE3MbL4qW9PkIYNviMAz4+Dm5T2K6k1uM3SESIBxIdmuwgawXHpVhKLv9NEIuxSaVv5VRwyKF+Af6BIf1SnTVPvutDHKG5h2FW/Ua6Bd0jHquWnkJ4yDUYfbNvVk4QwFEz89/nYh0omEdFnQj4owWGP65r9omqqhtzl5mpf3corYF3AG+qsTvEhOuqZoR2H5muvQE4hBTIcaO3o1Z96siYm57ZM+HKJnzD8J42lDylcQk2aF0FBQh2stLIKsuPHZIEtJJDxIrvwiLKoQJCf4ZwhX7NaHF+PxWhrveBFwxRn40+Ruy0O5jCxq55nYOH1pmezBEdxtTgfvnUoYQ+ZzV32TyhskofBHHmLed5y5m6BzY6R+ich5fUtYDLKXblJR8/zx3otn1AeEQMlDWhKJhSSJx6JvwY3/aDoZGzTUaDH2mNHRMJ/zOdwct102m3e3AUhzpzIXdBEz2Vnw2ZK7E8o14LxUmYQI5AonkRo/m/NDSyo2p4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(478600001)(26005)(8936002)(9686003)(16576012)(110136005)(54906003)(316002)(41300700001)(83380400001)(82310400005)(4744005)(86362001)(47076005)(36860700001)(40480700001)(966005)(44832011)(82740400003)(5660300002)(103116003)(2906002)(7416002)(4326008)(70586007)(70206006)(40460700003)(81166007)(356005)(16526019)(186003)(33716001)(336012)(8676002)(426003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 20:16:25.0003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74014476-70ab-4b10-f150-08daa0c52715
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4552
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a bug fix for AMD and a minor code cleanup.=0A=
=0A=
---=0A=
v5:=0A=
  This is bug. So, submitting these patches as a separate series from the o=
ld v4 series.=0A=
  This was a comment from James Morse. =0A=
=0A=
v4=0A=
https://lore.kernel.org/lkml/166257348081.1043018.11227924488792315932.stgi=
t@bmoger-ubuntu/=0A=
=0A=
Babu Moger (2):=0A=
      x86/resctrl: Fix min_cbm_bits for AMD=0A=
      x86/resctrl: Remove arch_has_empty_bitmaps=0A=
=0A=
=0A=
 arch/x86/kernel/cpu/resctrl/core.c        | 10 ++--------=0A=
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  3 +--=0A=
 include/linux/resctrl.h                   |  6 +++---=0A=
 3 files changed, 6 insertions(+), 13 deletions(-)=0A=
=0A=
--=0A=

