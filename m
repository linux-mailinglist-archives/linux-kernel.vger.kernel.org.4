Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8252637DF3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiKXRCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiKXRCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:02:49 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2B418B3C;
        Thu, 24 Nov 2022 09:02:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8iIkGQtInmgMcF70nWYBJUkqGKcuw1qB8NkJBkR4Il4RaUe/blB6xcyz3TIWtcytN78tbbyhPdUHm5J5YmRkIbD3aa9B2AOqcoiMcSfEVUXWaNmFF65EgcDFkTW6lIrXZA/fxrKx9k1DmmO3e2yYgeYS90tE9pJT0R6JMbuig0mXb6Yb3oGInobB5JNdXd1s047Sf/162TSn0G4XsXemDmjajrxcmvIrPPywIdvd1SrApVh9+pb8xO/rBxSww41cmCe1XPauL78j8mwqoLfZbfNbIOYzx83dTcg2kN94VPWL1FlxU00t0IGnT+bco6gMUqaVKRd0jHamNAc/g6GrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m99/gTo0KTRMi9E6+WP4aRTN979Dzrg1RBvg3C6icM8=;
 b=R3k6Gcckh0hH6Rk6Y6IFjg6wAVKk4sTynp9n3eTMqAVQJLCX3TexiKPvaCrZRdZHxl9RyLjfm6n4GvuC9SgIpCnstJs9L1vmlFvVY7lzAghgUkYplKQ0GJGiWizWFWucMheIe4AzJ5ZxScjUPOSWTOp+erT1yOAjWzY0lnT7CCcLVTejKpAbIDaoklWBwV78F+X2quathduaU/q+AyZllIyUHIiqsyJ7APlT5X9g+8egjVkFFnBHv6wTJHVxxxRd4tX/fo8aRR1F6jkV0HVcAz3DuOo1RO3H4am9kjImK7XaxjFcFXecpeoYPxXRlH5OYYZ/kpc6NvKBvM9uNtGDSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m99/gTo0KTRMi9E6+WP4aRTN979Dzrg1RBvg3C6icM8=;
 b=TKgzYfdLejaovmUzE0HmxfB3sJnP45Gk7dnfMGnUQh5fVmOJmM0fZSvofAIkIC5v9IkJMg95HgeQfgfQcMk5mXA+VItgD0vml1FpqCTwqj8IJkLe9aoB5PNcfe5yVt/BmhmEeuFM7vx2MRJwpEckTtQ/zRT+tFPzGuAjdxfGogI=
Received: from DM5PR07CA0082.namprd07.prod.outlook.com (2603:10b6:4:ad::47) by
 MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 17:02:45 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::ae) by DM5PR07CA0082.outlook.office365.com
 (2603:10b6:4:ad::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 17:02:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 24 Nov 2022 17:02:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 11:02:43 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 11:02:43 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 24 Nov 2022 11:02:43 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>, <lukas.bulwahn@gmail.com>, <ojeda@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bilbao@vt.edu>, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH 0/6] docs: Update kernel-docs and progress translating Spanish
Date:   Thu, 24 Nov 2022 11:02:36 -0600
Message-ID: <20221124170242.1892751-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT004:EE_|MW4PR12MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: a71f7cb2-3d3d-4080-68f1-08dace3db4ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /vFgysH90LeEmfunAKPkb/5/ABOZ730fG+c1iYjV/FLkkP/lp+Tn3pwEoWH6nQctAtoBrYrwm2rR7WW8Exskn6TrjZ1gfJA5YA9QsZhmW7izno3kgzOr00/ddLwCke1orE7ady3pYIRz2zN8EMLfjV9obC2hTFAhSZmF2aW57GwaCe0zwTAZ66WoOpMgo2kZt9siWqIcfjO1uQt5M+/XG738i/xP8s2a7gkLQWf+pRAFmoLtt2mjCBQrp8zaxYLdFMhtsmoSzp/1M27kts2060hvW7P71kBldLXy6y0uBhBYxt78gGG85EpsuO/syrQG6LKOc16ivMQRSRcdsaCA+AxgZ490T5MZn4/SGl9uKZvxzDL5Khedpfrq3DrJz+U3CtrsgSacDBCrcAVfM8QmgGVzJjLp2oM+LxaG8SVY02G4/XnidjmNgzXVexy4ozUGqEdmg0aMKGaYs+QlcQjp6ZcCHeacrIEtPGUGEi8Y51PWiTXT0AEvqdkO35+mRkmsQnqj2VzcmIS1sns8BalRfu3xCMDfdiWoD85jLMJCUWyHdBqhBIeNl3FZcxNZt7SnvOr/uYv2QkUAJODWGMPHXy+nezv6qEC0zU4WzhZkLS1+gdpC4MMen3+kIKzVLsuyjPUx8n6+lV/lBz65WNMm/+GYNANs4zG8Ca+FdA2IUWt9sK4gOuXFOyQYS6UWUJufKDZC+JPVxRGW+AceubDART8NbCwIVxKfTOXZQefQGSI7Wzg9y4LADVfC7CV2EHfB/Q8J+pKY4KpU0RuzNm2j7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(36756003)(336012)(5660300002)(83380400001)(2616005)(7696005)(54906003)(44832011)(186003)(1076003)(70586007)(316002)(8676002)(70206006)(4326008)(8936002)(26005)(36860700001)(426003)(82310400005)(356005)(81166007)(82740400003)(2906002)(86362001)(40460700003)(15650500001)(110136005)(47076005)(40480700001)(6666004)(41300700001)(966005)(478600001)(66899015)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 17:02:44.7056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a71f7cb2-3d3d-4080-68f1-08dace3db4ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set:

1. Updates the maintainer of kernel-docs.rst. Retires its outdated
resources and adds new material. More context on [1].

2. Makes progress translating kernel documentation to Spanish. In
particular, it creates translations/sp_SP/process/ and moves documents that
should go there. It also offers translations of kernel-docs.rst and
coding-style.rst. 

Carlos Bilbao (6):
 docs: Update maintainer of kernel-docs.rst
 docs: Retire old resources from kernel-docs.rst
 docs: Add book to process/kernel-docs.rst
 docs: Create translations/sp_SP/process/, move submitting-patches.rst
 docs/sp_SP: Add kernel-docs.rst Spanish translation
 docs/sp_SP: Add process coding-style translation

[1] https://lore.kernel.org/lkml/20221118170942.2588412-1-carlos.bilbao@amd.com/

---
 Documentation/process/kernel-docs.rst         |  477 +-----
 Documentation/translations/sp_SP/index.rst    |    3 +-
 .../sp_SP/process/coding-style.rst            | 1315 +++++++++++++++++
 .../translations/sp_SP/process/index.rst      |   15 +
 .../sp_SP/process/kernel-docs.rst             |  187 +++
 .../{ => process}/submitting-patches.rst      |    2 +-
 MAINTAINERS                                   |    5 +
 7 files changed, 1540 insertions(+), 464 deletions(-)
 create mode 100644 Documentation/translations/sp_SP/process/coding-style.rst
 create mode 100644 Documentation/translations/sp_SP/process/index.rst
 create mode 100644 Documentation/translations/sp_SP/process/kernel-docs.rst
 rename Documentation/translations/sp_SP/{ => process}/submitting-patches.rst (99%)

