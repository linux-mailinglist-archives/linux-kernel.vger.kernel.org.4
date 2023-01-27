Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9881E67EBBE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjA0Q5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbjA0Q5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:57:34 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C62AB741;
        Fri, 27 Jan 2023 08:57:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSNXb8a4AFku4qgZtFwowb8Ygy+n8sjA6CeM6gWv+BbPP82TGCK7S6nLFgUumvaHhOl/Gjdq8b0QMWrYIl06gh0g0Q4X52sWXSZ9/aRvj3Jlk/LS9yG1lyILXmeXfIBNRkTiOSzyNUHXdU7O5VkwU0KBI+B16efInutYXhIsHbDK8hjs5Vu5WpTYbK8fBTG8dfHADfBMtmO6K/vEYHPsi5+K/7puiqT9We9cCwoSqGtxtym4lV1LYhYVM19ClK09f1g1xb3oMuuQbIJOJohLw70HJet8dFzuOGggPc288hirIxX6I/bEdEFc05pZtWqSSB2N+qULgkKQ1lx7PJL4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRRRSaC22oM2p+4aCS7qJcZqRCaaIirFEJy7nc99Vy0=;
 b=FDGhdKWcwGfYJLJKaOkc/gtPlK/b2MUxZDv/4yKmR14fQ8aHbNZBSQXWDpT4D5U74gkjhYN9E6OYGXNFnvERblNXiSExgobH/TBOLb24mVQio7MFnrtpyZO+Jk0tVl1g/ni46YDtNSuvhjX6KhNCjqVUTSHzw8HXi5zMB76VHaTrjYdguoTfeGkwXZuccHo/rMdG5bkvE33dLtUdDYBXfHn2Em+4/pXh42pc9+GKgqMnhMS8YcWa7Nn2vXDYsoGyV5vS7gkicxuqov9PdF7/IoQocRZ2Swx/BUeKITzwAWCRv9YMMTamKU5dlsGqmceQ0zdDaYfKuGFoCSjzhgLtGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRRRSaC22oM2p+4aCS7qJcZqRCaaIirFEJy7nc99Vy0=;
 b=Xj+MiD9HInPd3JwxCyR9kIXSdhjqak0zZAxO6ZEc1RwOkhu+MxhrFxZVmhNwm3bSI2a1hcyXLBY9To8zuugfDYDS5McWCECuQ/Dkd+lLoaaunWyw8zEqWxqbhVTlh/zM5S2PXusRnonf3iRKRaWkP3bjDeKFIPX9fUgCJfU1rVw=
Received: from CY5PR15CA0079.namprd15.prod.outlook.com (2603:10b6:930:18::15)
 by DM4PR12MB6230.namprd12.prod.outlook.com (2603:10b6:8:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25; Fri, 27 Jan
 2023 16:57:30 +0000
Received: from CY4PEPF0000B8EC.namprd05.prod.outlook.com
 (2603:10b6:930:18:cafe::cb) by CY5PR15CA0079.outlook.office365.com
 (2603:10b6:930:18::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25 via Frontend
 Transport; Fri, 27 Jan 2023 16:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000B8EC.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.3 via Frontend Transport; Fri, 27 Jan 2023 16:57:29 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 10:57:29 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 08:57:28 -0800
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 27 Jan 2023 10:57:28 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <ojeda@kernel.org>, <corbet@lwn.net>,
        <jani.nikula@linux.intel.com>, <rdunlap@infradead.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konstantin@linuxfoundation.org>, <bilbao@vt.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v6 0/2] docs: Integrate rustdoc into Rust documentation
Date:   Fri, 27 Jan 2023 10:57:26 -0600
Message-ID: <20230127165728.119507-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EC:EE_|DM4PR12MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: 7616e552-1146-45e9-8f07-08db00879371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mt3VjRUuYg/+QJEw0iGSL+9Wi0RL/F7ltrZIGCoDprTbcfDpJv05pMvqGyU90KgSIce8Hl74vttLKImuWwNFiZRJEtUPm+lh5JVqOTkAq5JRjobrTC3iCBe0sQZFyDaOU9lzIX4nJwoxMsMmBpsakIv9dcqGHMCHAdOwW+Gmlv7J+jtqw0zZhynjDFQqIwyKq5eHzYhCK7uoKJuxPT7jMj7WIwft054KmYUf/VBOGKCtDUQYm5AdCiciyRUMOR+1G2cfZLrMCocr+7g6+SkKm6ULMVy3UbYxAjdigySsiUVx34mqYetRdY00Js4LEc2O1wpAbHc/pDghE2K7fdjCNLvUuhRN8Vv+iqs5NOCcQihxuQraNF2GV8fN9oE76L4QAlf7AG1M2htKzNubTu3odG3s/1eWSm3WDbBszmvqC5dAoOJnQ8lArnoQRUx38ynI3gvGEvq8r1J1mZIGNw3kx/vzigvjNhHHXVSBAALsrEEQqbJKgqP5nvcUj7zkbwRoOGuq34Ir9VX19Dx8Bri3uy65aB1nnvCcY8BoDfQyk2uXJhjEOzjObaVOt92iI9F4nm5ToRz73+cWnxoebQGHogq6cIADAFd/rWcQHefVv3qvqSXaV9Hnqxo6pmUbiTGUlmsJ07HC4pYvC3iEwVVOzxARgF8tjK6Vp17t0NPWwG4KRtk8+wRe3nqLlF6/imysUs/vzztue2zs5Cn1TT8jZq8NY1k0VMSdssFSpArqXM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199018)(40470700004)(46966006)(36840700001)(316002)(41300700001)(36756003)(356005)(8936002)(26005)(186003)(4326008)(40460700003)(70206006)(40480700001)(70586007)(81166007)(8676002)(83380400001)(5660300002)(2906002)(110136005)(426003)(1076003)(478600001)(54906003)(47076005)(44832011)(2616005)(7696005)(86362001)(336012)(36860700001)(82310400005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 16:57:29.6397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7616e552-1146-45e9-8f07-08db00879371
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6230
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
Changes since V5:
 - Continue executing htmldocs even if rustdoc fails.

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
 Documentation/Makefile       | 10 ++++++++++
 Documentation/rust/index.rst |  8 ++++++++
 rust/Makefile                | 15 +++++++++------
 3 files changed, 27 insertions(+), 6 deletions(-)

