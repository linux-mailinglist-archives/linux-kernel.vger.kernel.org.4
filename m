Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A8369B832
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 06:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBRFin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 00:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRFik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 00:38:40 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301E75CF1A;
        Fri, 17 Feb 2023 21:38:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JR7g3RfeqRnEm6+WiAPtwj2/FzibXYkH9ECxMbPASA5DGH2ln9vqkd7PEBdncfe9wcfCrdMIHG2FuCZShxWDARZhP2nokKJ4WNzU/CZ5pjnRr9iyO5aleBoVgYCQLetekQeJ5I68cnNRbFmtOoHhxa+C8Ab2IXBgGKJwGoUUDBq2F5SPA+OCuM5ExSqHaa8iBMKL0NE0SfjU4taNlsJOsnxrOk7OhzvWYa4EQ1EgI0jzzv1JeMhKPm3uCxSN+9k+EGAluLly7cN4ybLJHzpdgxy5y2ONbn4u8elnXqWPln/lEaHwRqm2+zPy0ZHlctjxMyWsnrZKuZJELrJADaYKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jj5SHFDulF6gxWkCEuxIU7+ZPeHjzo76uZ2/FrC+NKQ=;
 b=gGn9tUNJpSdJ8CJQLHtXFocRhHy6hrSLp9ve4uG1ASYArZ48bS9QokkmbYzwvScbn7HcpZdZQEw8Ce0R7aKUBiig94bmjZtEZcoW8/x6VdSrEKffS27W5TJDhSJ6TqItyd5Vy/nhxVpCn3jNvbG0mwX0qXvExWafRq55oW25J6q+9TSUnQVMp5g/OMff/ZZgKiBmouSgd27el4Ny90ai+1HW2lTHStW1xRbgfLYWwLWwalNose7nfrc76ankrHiWpPViAQlRwa2Psgg2qX7u8ufThiHj1a7EKVWi/bSsVE2FM8P2e5g/OsuRWg0GEusG36NPN33w5MNVPJzcK92xBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jj5SHFDulF6gxWkCEuxIU7+ZPeHjzo76uZ2/FrC+NKQ=;
 b=fD61eynzvJxaRtSx5qZ1I/6+04Scjpu1GNcIKf6h+u3PfQwsIM7SMJ1ys67EkaiLqhvBR2KhCZHopZ2aORqa7Xsmx15We6rQcy88H3L4nA8zyqgmmNVG53td+2SdcNWAhx1Z8Vz4Ewxnj9kgzbMGpCpBlQQ9/Fbkpd3DEVTLAvI=
Received: from BN9PR03CA0924.namprd03.prod.outlook.com (2603:10b6:408:107::29)
 by CY8PR12MB7636.namprd12.prod.outlook.com (2603:10b6:930:9f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Sat, 18 Feb
 2023 05:38:36 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::a3) by BN9PR03CA0924.outlook.office365.com
 (2603:10b6:408:107::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.17 via Frontend
 Transport; Sat, 18 Feb 2023 05:38:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.18 via Frontend Transport; Sat, 18 Feb 2023 05:38:34 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Feb
 2023 23:38:34 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Feb
 2023 21:38:33 -0800
Received: from xhdharshah40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 17 Feb 2023 23:38:31 -0600
From:   Harsha Harsha <harsha.harsha@amd.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <michals@xilinx.com>
CC:     <saratcha@xilinx.com>, <git@amd.com>,
        Harsha Harsha <harsha.harsha@amd.com>
Subject: [PATCH 0/4] crypto: Add Xilinx ZynqMP RSA driver support
Date:   Sat, 18 Feb 2023 11:08:05 +0530
Message-ID: <20230218053809.1780-1-harsha.harsha@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT028:EE_|CY8PR12MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: f2001188-8352-4da3-b9c4-08db11726082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+U3ymawVBmdRGKPdXZdVEKmpjviLSaYP2rQdCvvOYQVFsAYYCHVO3Xwn++aEFX5GYW5GB4Hlw6BngQq/jepJ7kNWId6UplmPpuQZrwPpPFfWXaS/y8mzmBtGk1pUraFBIoIa/VszRslSi0vV2pip4maKBHXD/lOq+XczB1DYJ4voztPEOzngry8D2zRLzusxp5/XeFYsFg0bBNGvpvIHl/hcnRFMU8fGHJwDl1xbepXjb/W1MHT7Y7MMjm5kfrhyXOZ8o0Ovb39ce1ntMeymdXd9CxyNUtG8KMeQk/ebLtw9fXo9QdIDNIqTGm7nVCYM9EfmPEzeyqmVwz83eblLK6MoMe6XSipFDDplB9/nU9Vsz7pYMzZ2tWkYoa0MrvihgS9Z4vcXpONYEIs7B3Unhh8jb4qofTqcjVOUchaxHW4BFb+MjZk2ffywujFcFog274481nYZVz3n+DfTdCFhGcIzHKe/uNMYdSH2bS39mYfMgLMmOJQqJmoApehNRswaCxyCcXs3/4OCX07Tui0kKDSyhSqVANGIH8IZOgjAQ5C0wKSwXImtF+HhEIi8gqM/WrJu5DGnOUqjuqZKWZvXEc9p+UqSKndtl7CjlWqYW21e4zAXR0vPvaAkQlEn9XQXTFnu6SJUFj3zL3kw24otAr/6kn3HbEQJCa1ePtL+66L2vJ4EgJ2BnFFg6Ak8Lh3r4sotzmEPor8MqGm5y3FP3hFy/M8Ndj/+yQs1+bnH5hueKF8JEBgkpJJyRtYN+lC
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(478600001)(83380400001)(47076005)(426003)(316002)(36756003)(54906003)(81166007)(356005)(36860700001)(110136005)(2906002)(82740400003)(86362001)(82310400005)(40460700003)(70586007)(8676002)(70206006)(4326008)(5660300002)(8936002)(40480700001)(4744005)(41300700001)(26005)(2616005)(1076003)(44832011)(6666004)(186003)(336012)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2023 05:38:34.5712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2001188-8352-4da3-b9c4-08db11726082
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7636
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set does the following:
  - Get the SoC family specific data for crypto operation
  - Adds communication layer support for zynqmp_pm_rsa in zynqmp.c
  - Adds Xilinx driver for RSA Algorithm
  - Updates the list of MAINTAINERS

Harsha Harsha (4):
  firmware: xilinx: Get the SoC family specific data for crypto
    operation
  firmware: xilinx: Add ZynqMP RSA API for RSA encrypt/decrypt operation
  crypto: xilinx: Add ZynqMP RSA driver
  MAINTAINERS: Add maintainer for Xilinx ZynqMP RSA driver

 MAINTAINERS                          |   5 +
 drivers/crypto/Kconfig               |  10 +
 drivers/crypto/xilinx/Makefile       |   1 +
 drivers/crypto/xilinx/xilinx-rsa.c   | 489 +++++++++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c     | 100 ++++++
 include/linux/firmware/xlnx-zynqmp.h |  42 +++
 6 files changed, 647 insertions(+)
 create mode 100644 drivers/crypto/xilinx/xilinx-rsa.c

-- 
2.36.1

