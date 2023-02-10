Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA3F69226E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjBJPj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjBJPj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:39:56 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8F155E7D;
        Fri, 10 Feb 2023 07:39:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhdWGb/GMPuyxEd4qa8L4OmBPwbqBjCsWuGgBtPX3ZT4u8om7dgq/MPKNEvbl3ZW7Af48JDi8CeAtDhDsRF0e2Mi4sxPlnlxVt9QPiPKGARiXjvHqjDZ9DunaPlixGBu6OhMQEUaduZewuKSKtaRJIDwMEBBgKKo4W6JNab3hdZ30AjHKFi386oG58xnh9KSonTp4IDA/v6j/1hfBXR6w7Tb+2MrMlrhqcdqu3ieLG1OEY311E09BUXbojreL93oj9dCFKveEIDgtdIyPm1EbpMxv4ZQVk1M3cs44wXZmdCB0DsdPsGnlur2kxJrVmfxmoD+Y6ay1HkCiKmoZkntvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DVFrzdlyWoHDzlyLn5beb9p2OpQlD5M1eD1VKnFWrU=;
 b=Pa7fEQeHMwTUXktERIlCv6zdczXWRQDUwX6Dyf7z3hhZ8SU1fFhAqBBqUoJqDqqdLB6cdMwjhK4dYIp4bO3+P4WXPvOQlObK9URu9kEcopNkdzGSQbUCJWXaBKABVU2o6XHB54AuiPvkKXT2clfwKBHI8cLR7Qr2rMbnOopNEoA7U7UK6cdI3uHVhy7bBzBZzS4gforE3KA3HjvFAvXxxmQ8n/Oj4sULGC7hoTc8uFVrQFAz/Ga5ZYAIS19LAm6DpfBLgN6SW1+ImP5JUHJKJXAfZepC3bYRJbHc8n29VCtY6txriPr5bMHJWJbcYv7AwmhUx8J6ZUyAFfhQpAfqQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DVFrzdlyWoHDzlyLn5beb9p2OpQlD5M1eD1VKnFWrU=;
 b=nPonsyrwL6HTuI22W0SQLzzEP3CK8ATCDnmN2XYCI2u6DG6coKYs0bc0f+C01gc1uLHB2gDvvXSiKsNEBRAHOvRY5b7edRxrzBMLOKPCMKpe36V5CaxbaZH5IB8+BvWx2bduF6dq4/H/jOY5175gIX/PN8/gNlk+qBdeQzOWp2PoM9UGyqEeKRoGpivMis8GHn324pGGWFxxco6qQ3t9Xnki/ukoxzv8fisiOKVhfdnsP95Ml9rWDWT2Ds8fMC0TX6VhFZrg7dxKOm0MgO94Z5HZlWrXnxCS4LwNrRYIXdO9x1UAxs65rPGWoC0aA+h6poanaAHgxzCaz8TbHj/PjQ==
Received: from BN8PR15CA0067.namprd15.prod.outlook.com (2603:10b6:408:80::44)
 by SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 15:39:49 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::61) by BN8PR15CA0067.outlook.office365.com
 (2603:10b6:408:80::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21 via Frontend
 Transport; Fri, 10 Feb 2023 15:39:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.21 via Frontend Transport; Fri, 10 Feb 2023 15:39:49 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 10 Feb
 2023 07:39:46 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 10 Feb 2023 07:39:45 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 10 Feb 2023 07:39:45 -0800
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v3 0/2] Add NVIDIA BlueField-3 GPIO driver and pin controller
Date:   Fri, 10 Feb 2023 10:39:39 -0500
Message-ID: <cover.1676042188.git.asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT050:EE_|SN7PR12MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ec9ae7-ebd1-4e94-4c04-08db0b7d0b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UJvpXEpW4dUvkBtiERIcSX8vWOvTLMUttwJEJJ2/t7YMt+7rS0iLorLP50kRahapFQv976ScOvGSFoqixi3D0IHmZsDLjsNb6LPLbToTtvJuiudOoxN323QHKFFqD1Igv8Ym18eeewFrRO9o9DYwv6v/8pZpRKyO5kx5K4Vr/2G7W4lWExT9sH+PXwzogcWgZEcYNKJ2tnVEn/dDUoMSvJEt9l191k9QUtg/9WexXfURqv0Ahrc7q2frQyUXLzA2xcY4f5jQXrnM//cZYJAMVBrcsf46wYHgmeAqkXWykTUkCgs6zrng98IYa0tNDCC4ontGQsQsqkZWDfAqEKg+9Jo7LqH8ZEc1sRopImVQ+tC9T5WqqQ44PZCiop0OQr2PENoTq+EBeRCANmZjRKhw0orhfkIahnfwbBOj20yi0bwGWps7C4SsfmaPZf23CdIU12Wqjmy7L5NX/T/BRFd2Ui4h0NKNNiYSL7WAT7QKoj3o1nixGfGmIjdboh8kixOZtFecgEdHkY1Fm3nJDjbpYvU0hjGWucox1QBkZXcef1L2wEH24b6kQbGmHdf1mSwdAwW5mTRNzZEQLr3x4GdMwF0MwZ0MdFR/0/m/i0v+Pi6EglrFWlbBSF2/odecQjdKLA/cSygDC1aD8ZqFNyefHWvg055iLEPQCBYzs2jHTxK9CaM9HLzYwAQULX4A7b0I/W1yRIVovE2OQFrxOIKe+Q==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199018)(40470700004)(36840700001)(46966006)(82310400005)(8676002)(450100002)(186003)(8936002)(70586007)(70206006)(4326008)(36756003)(86362001)(82740400003)(7636003)(356005)(2616005)(426003)(47076005)(336012)(40460700003)(2906002)(107886003)(316002)(7696005)(41300700001)(5660300002)(6666004)(26005)(40480700001)(478600001)(36860700001)(83380400001)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 15:39:49.4136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ec9ae7-ebd1-4e94-4c04-08db0b7d0b92
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches creates a pin controller driver and GPIO
driver for NVIDIA BlueField-3 SoC.
The first patch creates a GPIO driver for handling interrupts and
allowing the change of direction and value of a GPIO if needed.
The second patch creates a pin controller driver for allowing a
select number of GPIO pins to be manipulated from userspace or
the kernel.

The BlueField-3 SoC gpio-mlxbf3.c driver handles different hardware registers
and logic that from gpio-mlxbf.c and gpio-mlxbf2.c.
For that reason, we have separate drivers for each generation.

Changes from v2->v3:
Addressed the following comments from maintainers:
- bgpio_init can handle direction_input and direction_output
- Update pinctrl Kconfig to select GPIO_MLXBF3
- remove unnecessary #includes from gpio-mlxbf3.c and pinctrl-mlxbf.c

Asmaa Mnebhi (2):
  Support NVIDIA BlueField-3 GPIO controller
  Support NVIDIA BlueField-3 pinctrl driver

 drivers/gpio/Kconfig            |   7 +
 drivers/gpio/Makefile           |   1 +
 drivers/gpio/gpio-mlxbf3.c      | 262 ++++++++++++++++++++++++
 drivers/pinctrl/Kconfig         |  10 +
 drivers/pinctrl/Makefile        |   1 +
 drivers/pinctrl/pinctrl-mlxbf.c | 341 ++++++++++++++++++++++++++++++++
 6 files changed, 622 insertions(+)
 create mode 100644 drivers/gpio/gpio-mlxbf3.c
 create mode 100644 drivers/pinctrl/pinctrl-mlxbf.c

-- 
2.30.1

