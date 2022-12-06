Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328DC64480B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiLFPcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbiLFPcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:32:00 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299B6286F5;
        Tue,  6 Dec 2022 07:31:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKcXuIE5rp20npDiY1coyO0wd0q7sjp6TKqHyVRcU9a+EZ+5ysgs/hqT/9HnN5qbCl8gAgSGqxL9hlmC8/1xe4+7bspoTcw5TqFQJN6f8yrvv+dIZigtdp0lIS7uoun76+KT599Z1KQ6AbNGDh8gJyk4KpcXpPTCPFlWL8gdcL0KQfqRKD61s9LQeRoM8yfItNQH9EqEu2s/Pm+c6Pzmw6+5WTf7HQKjdeV3rbONL+MMN0UKhokDBzqWih28lT9r42bxJhYowBDfcZkzCatUvgQ/jIvL72mMdAnM1am8Ko9p5WfwJwQBPB2F2w6Bk+Z2JO3t9jYooP2Tdy2N0hoowA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4m2D7XL4F4FhvPAEMJbEHVgqdY+wkIy4ohH/dzEZ/d4=;
 b=Lz8CiSZlllIzjAnErM7hLiPD1aVGVM38tfVe8A3bTSKURo+UdfZHp5e6lS6dwDvqS37OeNX+m8REoYQ69k60mFAqqPvI1AxsxE4NrlKIfHVJ2H60QlkanM0PtUFDSw+kHDi21IiBglc4NwvNzGW4DUn4ri4YPPyjsHiXZGRvukEmKj+jY5F1BjHp+vOhTgi4DssJZ8+Th3Oti5nH3DUf/YXNsmxJkVdjdE7N3kMn1tnl1Lof0+hJbfASMeSxvaQFkjBAI0TvsakYYEuUCkaUZV4IDFTQ2/ngYqfOzUJFuPd8VXl//pAwgyEdcFy6q7M5zhSTK3qJwNWfHd8ifsdRZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4m2D7XL4F4FhvPAEMJbEHVgqdY+wkIy4ohH/dzEZ/d4=;
 b=ZY1ZCyNUlHuZzNV18dU2/HFKGa/LbRDz3Db/h41/V5xn9KhMTBdzEv+aNA9Uok6MUpbM2REsF7sRSSq26k+mXrFXwoFVhj7oBJ+XT4+CVlB01fQv+8VORNqo3OkqiQ2zDhZ27U3bG3977TXaIWVTCP18B7nmcpGzzFzzHOS8CVA=
Received: from BN8PR15CA0035.namprd15.prod.outlook.com (2603:10b6:408:c0::48)
 by MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 15:31:54 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::73) by BN8PR15CA0035.outlook.office365.com
 (2603:10b6:408:c0::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Tue, 6 Dec 2022 15:31:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.14 via Frontend Transport; Tue, 6 Dec 2022 15:31:53 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Dec
 2022 09:31:52 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Dec
 2022 07:31:52 -0800
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 6 Dec 2022 09:31:52 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>, <akiyks@gmail.com>, <ojeda@kernel.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bilbao@vt.edu>, <konstantin@linuxfoundation.org>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v3 0/2] docs: Integrate rustdoc into Rust documentation
Date:   Tue, 6 Dec 2022 09:31:49 -0600
Message-ID: <20221206153151.771038-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221201204814.2141401-1-carlos.bilbao@amd.com>
References: <20221201204814.2141401-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|MN0PR12MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a382fdc-6c50-4403-3aec-08dad79f0090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZLm2WZ80JhWi6mOwzx4eQVVM3SiLji/qVIWtcA8itzqgqxZJcmXmrIKcjZlRwcYOtqnLy7/Miam8nSOb9F8+Eh5Gfp/nVbjPHgdp3Ya97YFqTSlzo71fY7dlo6GdWvBPdMhUrYc8tb0m7hNYZ1ChHAvRTeSIsxRZH93mrtyFtBql0Bg5iTsRlTvRPwYbaNHqL4Y9r1raYz//XwfQat/qdsPUVht9pBcdYkg7kONl2QoiZiYFPhxkQ1mdZrCOge6Q2eM4/ZH/Lcd+stlG6/2hJNCi5iS08Bcl6IcaQQtxL735J70XzGXXrPWfaFXN5tmhinPyGPqybBNQK8mWp2lppJTBbxtidhYTRbHdT/y5+aFF5iXYzLZDW6cHwxlgy0krL7n9g5Y2fJBYU3fRJM2QAQggdRZXjVBk/Zgc1d070tWPp0W3foNJqTTmrKU5nDq/BodmnbUp3ruShYPs0k4sqySnHif9m+we50LHYVbwLpZmoq4ZOVEM4efcycg6UFy3TSdBKqRJcH0jojFf8hHTEZip7M2dtuyQ42141Cej/gxv+27xE52NGqwbUfLQK/kGjig7jK5NvouWAFL1gXsJGSVHD0NMmW7NLdtbPDLUHeVhbhJ1MzmI541w15a9aJl3otxY5FZpfBfmnsEUAITl6rQ8tWQpgVhaAEux3Ti10aZJgyWMq1pYOtBXZzyNVYf+TIaT75qReS+JPz1W4CgKqLejgt3sB2zIvx+cDJb6VZQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199015)(46966006)(36840700001)(40470700004)(7696005)(83380400001)(8936002)(2906002)(186003)(26005)(110136005)(86362001)(54906003)(336012)(41300700001)(316002)(1076003)(2616005)(40460700003)(44832011)(82310400005)(4744005)(5660300002)(426003)(36756003)(47076005)(70586007)(70206006)(40480700001)(36860700001)(6666004)(478600001)(356005)(4326008)(82740400003)(8676002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 15:31:53.5101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a382fdc-6c50-4403-3aec-08dad79f0090
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713
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
 Documentation/Makefile       |  4 ++++
 Documentation/rust/index.rst |  5 +++++
 rust/Makefile                | 15 +++++++++------
 3 files changed, 18 insertions(+), 6 deletions(-)

