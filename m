Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A444865855E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 18:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiL1Rqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 12:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbiL1Rq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 12:46:28 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1D6295;
        Wed, 28 Dec 2022 09:46:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhpX04r8Vrja47mbPMQzj8J6N2ykSLMy88+jh7x+OeZ0O4V8FeblW/3C2eWGrxrWt8P4Y0HLDfOhLc6b33/QjYRebW7gBs2QrorIwGlEvyuggppzi59a/18TFIaBRSzZ/FKuHpoBDoCBnUAKHMFljeJ3Src1Ua5lLxZ5eA0mH2lsIpRyp07UDDoVkBx10dMAZdI/X6L7l8Cf1Pqia78GJjNTgaJ/X9vFPwmZ0T7xu1RzaJRwwFRz5wzPqa0FZA6RB/6ugLQO+Ws0Gi41PCEbkJcGL4+Sc1IoQgAGTkh4+QDsLhpcxjmwrJdkWrEeysar79XnftO5fkTQTKIzMXrR/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YW3onDaQGxlrWy7S5FEzVO5Irq1vH1a64bWVVAnaKGo=;
 b=M9KHgnOWN78vRml2IzwSCblp9qjTwxFUcp/h/+wHqNs8PyoNv8c99hCPi9Xq/1cJz5WQSNb8LXXL05aupnvsj0WGQW6AoxulScuvJAvYmui3l8Rrb66uADOv8zptUQb8UgKnwYX3breZEjJbr+TGxLwaIUOng8Qy9ZtP/8lmNtctYzGUlyxJi5BjU3JoFrWxqu+i7iD0JqkxK7zcV/HedlCgn8qMC10YSYxIIE3EN4cmc+JvVjOeGuPUCY68i71usN/FMFS6q8jDf58ljWXFcH9ksIwyHnXDvvsDzgF1sGYtw35Xq/EelMDOFfvEt8mzPTwePFI99P79FBA7PrsVNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YW3onDaQGxlrWy7S5FEzVO5Irq1vH1a64bWVVAnaKGo=;
 b=IKgK1QeonQfHR1DCB1WNNcC0InqUOLDN0AO8e8ATDuq2w+/fTrxtygRkIvO+2ZVjrq6fYQf6enpjIn7PSm8QwiptcQo8TS7s5F0Jdb7Ju+qvySsY27jYwmMCz6a/WAMRd9SReIA+B2Klt3qaMMxiXHSsTWzrMw+1QyP/S1VccL4=
Received: from CY5P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::21) by
 MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13; Wed, 28 Dec
 2022 17:46:25 +0000
Received: from CY4PEPF0000C971.namprd02.prod.outlook.com
 (2603:10b6:930:b:cafe::dd) by CY5P221CA0003.outlook.office365.com
 (2603:10b6:930:b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.17 via Frontend
 Transport; Wed, 28 Dec 2022 17:46:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C971.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.10 via Frontend Transport; Wed, 28 Dec 2022 17:46:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 28 Dec
 2022 11:46:24 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 28 Dec
 2022 11:46:24 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 28 Dec 2022 11:46:23 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <ojeda@kernel.org>, <corbet@lwn.net>, <akiyks@gmail.com>,
        <jani.nikula@linux.intel.com>, <rdunlap@infradead.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konstantin@linuxfoundation.org>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v5 0/2] docs: Integrate rustdoc into Rust documentation
Date:   Wed, 28 Dec 2022 11:46:21 -0600
Message-ID: <20221228174623.144199-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221207173053.1463800-1-carlos.bilbao@amd.com>
References: <20221207173053.1463800-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C971:EE_|MN2PR12MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: eee8f716-0230-415b-1e4a-08dae8fb70c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gDzxy7hgYvI0Am5XXooHXUaJ5EoLoxH/PeSs/csYQyOb6hLw2O5hRwNdVyD8sMetrA0oEIY0nx5lV/MifFpbJWiU0hDgannbZCNWD10c2Uxs7J/IYVunthbhP42YG0q9glnHl4M5yVQafDdowhDurZL18tQr/AcfaEqDi4l8obO5tWXoo5dQ/Kl41Hku5TTgDqebVKNfyrnj09/KmqW+QXu7rzeFRsQI0Ge2u7P3B78lUg3B1XCOg1oj+CAlPO/Ls1e6vZoU5X9+NuJYq4rLxW3Gwf/twobMEu1/pZI+AGOqy/nEGVkevxQuS2JLNOYdlw5Ze4pd+2fwMRKkNtocg5ruzjVfge/aYdbSTWhnpJmMy4BkP21x1VXtzYJCDO88FeteIbvBtZ8S3/xwJMewG5XjFic+2/vD/KWtmaielM4tf+QfiGTm+ysFdSa/UN8IWZuO3lSK8Fqe7QYnyt/iJ+fKeJDTJ0jpS6PGvUqsM4CUk0qdYubgouCBb3d3p+CSIRgmWx3KD2bJsoDF/uCD/bxb+e/1SdQiFKK2KpwJXp3RwE6NW2YaUl6jVWoVvHJJAykMn7QpY3wG+wTKxTXbA1smJfT0jfczEFxCZGcSxydO2Yo57U01G6Hmoje+RZPTv3wgQ7OTYeXuG+04CTXZnyIhb/Nb3zmDGEZPKVp7oT1oJGIEbUQh4HtuShxeOy+ksVvEMSQhSOdKpHQY8ae6EKSrFtd0j4vLzj37HZr5JH8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(2906002)(5660300002)(8936002)(316002)(41300700001)(70586007)(70206006)(4326008)(8676002)(81166007)(478600001)(7696005)(356005)(82740400003)(26005)(186003)(110136005)(82310400005)(36756003)(36860700001)(426003)(2616005)(44832011)(83380400001)(86362001)(47076005)(40480700001)(40460700003)(1076003)(54906003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2022 17:46:25.1523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eee8f716-0230-415b-1e4a-08dae8fb70c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C971.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include HTML output generated with rustdoc into the Linux kernel
documentation on Rust.

Carlos Bilbao:
 docs: Move rustdoc output, cross-reference it
 docs: Integrate rustdoc generation into htmldocs

---
Changes since V4:
 - Limit rustdoc note only to html outputs.

Changes since V3:
 - Added Reviewed-Bys from Akira Yokosawa.
 - PATCH 1/2: Avoid error 404 adding tag `rustdoc` for Sphinx.
 - PATCH 1/2: Don't use "here" as link text, describe destination instead.
 - PATCH 2/2: Check CONFIG_RUST in a way that allows us to skip generation.
 - PATCH 2/2: Reoder Sphinx runs so they complete even if rustdoc fails.

Changes since V2:
 - Split v2 into two-patch series.
 - Add "only:: html" directive in Documentation/rust/index.rst reference

Changes since V1:
 - Work on top of v6.1-rc1.
 - Don't use rustdoc.rst, instead add link to Documentation/rust/index.rst.
 - In Documentation/Makefile, replace @make rustdoc for $(Q)$(MAKE) rustdoc.
 - Don't do LLVM=1 for all rustdoc generation within `make htmldocs`.
 - Add spaces on definition of RUSTDOC_OUTPUT, for consistency.

---
 Documentation/Makefile       |  8 ++++++++
 Documentation/rust/index.rst |  8 ++++++++
 rust/Makefile                | 15 +++++++++------
 3 files changed, 25 insertions(+), 6 deletions(-)

