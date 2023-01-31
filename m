Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398F268358E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjAaSrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjAaSrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:47:10 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411314A216
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:47:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PV57meXeHmCz9qPXcmnWhs3dzfU7sgdm62pMuXW7L0UW6nFyrv2Q89xvTFQUL8aHO1SSk/NtknwUwOFje+a6pTYNjzOwBy2TXgq/EsSjF4m05z7GKcpvp6r20e/EP3P1R3sfqHZXJeMW8ZpQNf64460Z9TfZj5aLQYXT/RjenXSh8J5ib/F/bXAgmgEkBLNoLwWs2sfntL9figeIZOliusJiBLNgquA8WA1aZ9QkMO9MgKFhbOlcsJ1pPKZiieYvjjTTm3ffLhEuL7xHKkZZqQae8kEWsgTMYYe4vP4+oQF9zcdqgvRX2X58wSy2wuWPocwhu6M/3sIfBRqgFCUAKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAp7VZ3TKj4X5FUzmfezDbSjp2xsJm8OBrvdfGHEa1E=;
 b=KmnRKFEsNDD6d8F6BBfxs5cuVHQE+ZQn603j24SmCFhirJpJ6p+yTD0rJsxskiQpnt0lWiUNc0oudYVthdLqfpTdKhxs19h3hNNoW+DjaukPQt6Kh2Yu7AWgeah5R55M2E44IO83WwIQFgHaUh6R/dw1xGC+65eQEBt6hS6R0YybROYjO/fjL0aRaUjH7EYY9bpwfNiRw4/uL9IP66lunZEtYl3VlXAitwXrBjdS21VkWOMjxZH/2fW6lS+z+UFQJjE9t0JG9g34bgQuHo4Bx0neo68tzoxEueK6fOoO3ACav0We0/9tQu0WY33AHXlYqnau6t6fZoq7W296HRz7Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAp7VZ3TKj4X5FUzmfezDbSjp2xsJm8OBrvdfGHEa1E=;
 b=y+5BgAk8Ve2fkukD/dYbHvyzSndpJDfJ02jJaJY4NA02eYpd6oqQVi+QkHREENad1lXRK277cRbfw6OLjTF06pNEHSytZbfhyPR7jzirIYGkaO9czaJ/PzeRF1x/TmuHZXfjLOieRnFWZt2zm7f4g+o+cmX9/9qJCZFlqcLiHlA=
Received: from BN1PR10CA0013.namprd10.prod.outlook.com (2603:10b6:408:e0::18)
 by DS7PR12MB5717.namprd12.prod.outlook.com (2603:10b6:8:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 18:47:07 +0000
Received: from BL02EPF0000C409.namprd05.prod.outlook.com
 (2603:10b6:408:e0:cafe::53) by BN1PR10CA0013.outlook.office365.com
 (2603:10b6:408:e0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 18:47:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C409.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Tue, 31 Jan 2023 18:47:06 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 12:47:05 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Jaroslav Kysela <jkysela@redhat.com>,
        Mukunda Vijendar <Vijendar.Mukunda@amd.com>,
        Saba Kareem Syed <Syed.SabaKareem@amd.com>
CC:     Pananchikkal Renjith <Renjith.Pananchikkal@amd.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/6] Fix default DMIC gain on AMD PDM drivers
Date:   Tue, 31 Jan 2023 12:46:46 -0600
Message-ID: <20230131184653.10216-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C409:EE_|DS7PR12MB5717:EE_
X-MS-Office365-Filtering-Correlation-Id: b9261604-e9e7-4712-eae3-08db03bb8d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gUQqKL99wRi+ce0Z0gp3ArQ+tcVS/VBteJo/IMlPZlH6NsfSOAGt8J0J5uaIbPtLLDXs/TYsoYc3agTDZ7PPx1Gg2ob66n4fpuKV2zwJD5/w5bijXoPh8j0xYHJ5pFygb5L2iV5WamxvqYQDN180xc9lEUN6eJweVJGQ6o3Igt6bBsfV5V8sqwsPcx9NK83C7OXcbG/98AIpXvfQ/2T3nezU7WhFRyo8H0x5uKrOiCTYGOnNxiR/JGLp4UV6Q4TyJ5nu6PvSt8HRaXGUBHERlhMXzBOL1ZfHHfePEV6FmjR6+QIlVOKT7UotovD/EKERFBHcF0Isy+yyvmDvqxDE1TQK4/sbR5ze3/loBBQUh4gfFPlOw5sGdqAqEOYwS822SczFz28AkZt6bgeMwHTxUGGQeKLPLh5WwqpMPHp6K/Xq1++rkUjKSp6K/zYjao0ryH1o/fxE/1fKQKH1CPjyp3TD4gLctwzmy3eiPY9WTeCyFohJNuEFuhVJe5Sqf4l8lriyc3uj3DtMjwYvYpqpNrfXqLGjrrcBXmt7R7QFhdz3u9MlsTcikK0cBK/oa3BNJAlaZzsTrAItNI3vz4P8A+RT/zIOT04BzB4+O7A/15FwBkzjm9gJY0qYs1Nz7Y5scpORpElDgOvkXt1n/raKa9E4H3Bqw1scAIwWacsgjAbucSi4DEzy2AJFpLIy1MMzvrDWwkK2alHFf5y5rdVHFLghvSCikzyGAVxEPxeMKAU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199018)(40470700004)(36840700001)(46966006)(86362001)(82310400005)(478600001)(356005)(336012)(7696005)(36756003)(54906003)(110136005)(2906002)(6636002)(6666004)(44832011)(40480700001)(5660300002)(8936002)(41300700001)(4326008)(316002)(40460700003)(70586007)(83380400001)(81166007)(186003)(16526019)(26005)(70206006)(82740400003)(36860700001)(8676002)(426003)(47076005)(1076003)(2616005)(66899018)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 18:47:06.6066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9261604-e9e7-4712-eae3-08db03bb8d3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5717
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been reported that a number of laptops have a low volume
level from the digital microphone compared to Windows.

AMD offers a register that can adjust the gain for PDM which is not
configured at maximum gain by default.

To fix this change the default for all 3 drivers to raise the gain
but also offer a module parameter. The module parameter can be used
for debugging if the gain is too high on a given laptop.

This is intentionally split into multiple patches for default and
parameter so that if the default really does behave better universally
we can bring it back to stable too later.

v2->v3:
 * Use clamp and clear properly

Mario Limonciello (6):
  ASoC: amd: yc: Adjust the gain for PDM DMIC
  ASoC: amd: yc: Add a module parameter to influence pdm_gain
  ASoC: amd: renoir: Adjust the gain for PDM DMIC
  ASoC: amd: renoir: Add a module parameter to influence pdm_gain
  ASoC: amd: ps: Adjust the gain for PDM DMIC
  ASoC: amd: ps: Add a module parameter to influence pdm_gain

 sound/soc/amd/ps/acp63.h             | 2 +-
 sound/soc/amd/ps/ps-pdm-dma.c        | 8 +++++++-
 sound/soc/amd/renoir/acp3x-pdm-dma.c | 8 +++++++-
 sound/soc/amd/renoir/rn_acp3x.h      | 2 +-
 sound/soc/amd/yc/acp6x-pdm-dma.c     | 8 +++++++-
 sound/soc/amd/yc/acp6x.h             | 2 +-
 6 files changed, 24 insertions(+), 6 deletions(-)

-- 
2.34.1

