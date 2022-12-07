Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6270646044
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiLGRbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLGRa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:30:58 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8EA5F83;
        Wed,  7 Dec 2022 09:30:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuRPHRNEhZvn4raDb+XETc6kwEXgo6dtKocJa2Ty0VuBJMSEQsI6VHaAnYVuIXJNtQfOuaArUptLCCE5x2/JgaOH5UKr58eRpAxe+7nU8akwuEGf6pWQ5QxCyN3gTf9+iNuGDvzr9yYU/ISzC6XPE6CCTdgISkJQ4LhZkR/14OUuMy8TQyxoDOxMV/jHQ3qRLmG0pwHtLlpsTz19Yv64B9TKNo6yRpmxzjpUXQ//Kcl7gNJXPm9NkyPKEMS0IDxWJg7ZHWl8j0BhrHWZjRp8BtNm90VjIRgxiC4qi1RMEwmPfwW1SMx1x8/LnLe7pVlk2IxAU08JvrGFarvgdtWbdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pq2iFFQ6NE6PcCOCl7doYeQ9RNsBJKaOPdnhpYpaNRE=;
 b=g41D2TG77aJ8upSKLYGeJw6hYu/rdzf93f4BHip+X4abSZXIe3IKQrK+pMfRU0P/ZfTECfhtncNFNH07MfIPrOe25tgOmgCkLshi55nYA5wontdsNGSEURm79lLtfSGmQkh0XYOL/ArtQ2DC36fAwc3VyOb8w69ciFEGRQlPIbgVk1OuxUml8YWa9lXrXMutOJkD2RpbAORXW3BlOCdKGwTFczavt0ONlk6tDr2JAuoT5pLATWSYy+7Q/efI5WDZrrl/lgcQSfxtakKHKoAQIfXiE9VorQfSbwv872fdP2Iw7EgXmrdeixIcZAzuDicL4N7qRbO4EhIAo4bz4kgArA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pq2iFFQ6NE6PcCOCl7doYeQ9RNsBJKaOPdnhpYpaNRE=;
 b=3tPrSETlHA3R5Qj6ZrGe8Q8PrSur2fApTECLRVkOxoXaKrigHGnXElxmaIZbdK2vHG6YKRUxayGAvktA5zgZXpR0YVWReCJS5MPeKOFfFO5TUKGNXSbuT7lQCmZA/wShtqkmucMd34QDNYvcragJCdZ2y+TUDnf1BN8QKT1kEwY=
Received: from DM6PR03CA0072.namprd03.prod.outlook.com (2603:10b6:5:100::49)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Wed, 7 Dec
 2022 17:30:55 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::67) by DM6PR03CA0072.outlook.office365.com
 (2603:10b6:5:100::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 17:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Wed, 7 Dec 2022 17:30:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 11:30:53 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 7 Dec 2022 11:30:53 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <ojeda@kernel.org>, <corbet@lwn.net>, <akiyks@gmail.com>,
        <jani.nikula@linux.intel.com>, <rdunlap@infradead.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konstantin@linuxfoundation.org>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v4 0/2] docs: Integrate rustdoc into Rust documentation
Date:   Wed, 7 Dec 2022 11:30:51 -0600
Message-ID: <20221207173053.1463800-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 3563fe71-8932-4267-e5d3-08dad878cb5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ox0dCGVZtkR2To9+zdpiZKBX+EpWTw4/eWHUeHhLIKFD0ssllLmNIp8HqlL5Ula0ewMZ2dzWwI2JEg/bx1eIBsu9dNHwoJkZmoa1yw7PGI5hyThv9zRWObHryfaAmcZ/EbxHhbsxDIXpAIcmmU5DJFuMD/Oagioi8qYSddERt3UWiDSlYunyvWvfdFLmWH1Oy8LVUl2w/pakj2H54kc7uX5QN4Vza96ogHWCziItxBpRDnSuSGnnbZy93zaDIjnJrKe8+vYEWTJzIPEgdbadZE3eKGQN59SsTvMLq9yZkvxkBiOsd5NHEAzL3Y8T5kx5a+hAWGIH81Z7WsQs84chTjG1RjAe7iihhtYNIzsDlPugqhBiRiSbWGbT+zufGaI3K/ntDFUyJONP6Uy5/dgEEmGHLJyjaCmKbsL66lZAC4G4hjY5DVqALVCbNTHp5Ojg2VqBlwNW6HupZr0j+rX4Drv8JcRPOv34sZauc57CgitjM0sxYYrflG2bs6fXOIwRe9BLF8Vqe1kuuy4b+7e655MKA1LsAoWVBx/AvwL5ZOnr9ZmBnz0V1pSgH/Lcyue1+KB0x7QUZPJDiNeyRslXmgICNO5Q4rwy3Zc8i/9ka6Ld2B4GOz+TuOou1bhgHYtdae2lxiTvO/UFXjy/iAf1RVbFzAEwCZsp5bNkg6ZelXj3W75PLpkRnk4Q9VfRDt0e0fwZfoCl1xeSXH12togkhl05iKMjadCkVBtYJUMWN54=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(2616005)(83380400001)(2906002)(86362001)(82310400005)(5660300002)(70206006)(7696005)(40460700003)(8676002)(40480700001)(186003)(41300700001)(82740400003)(356005)(81166007)(336012)(36756003)(26005)(426003)(1076003)(70586007)(110136005)(44832011)(8936002)(4326008)(54906003)(47076005)(316002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 17:30:54.5234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3563fe71-8932-4267-e5d3-08dad878cb5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656
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

