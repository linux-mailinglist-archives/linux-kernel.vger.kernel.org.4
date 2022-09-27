Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADEA5EC06D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiI0LFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiI0LEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:04:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85A761B0A;
        Tue, 27 Sep 2022 04:03:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThFg++LKuW2ezkDAZ2gHi5FOxyC/gPaV+Td+NSdj+U+8sOVBnzMaNZIb6vZ0AQOL76akQdtUTEtcQr7yVs0h/teLhC6LVrVf+Ecb4Z+ZZKJ/rKsozrA13VT17CgGDQwIscNsl2FVlnVMsqoe+t8TtrKzE8uB6QcR0/0HtEzpmwFbwnQJyhhxSEdOnDEyDUxkW4mdmuWOyrs8Qq1WcIrWCvgmKI0wtDCU21P2/POO6al9B5HZglfarA8wwBUgTGXFaTh4OKjxd32+8CQSTtHBTedegQUorMinSa151yvYQU9IJ6bh+jhY1GBKFG9y4osU3DaHwxIV4+8VENu4+3Oz3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ig0BMYVie26+MrMcwe3ltN2N0YHFj7eXpz0SqNZtKvE=;
 b=aJTb6h0TWHzHFF6IA32bNWBej5N9GthVo/W3XssnRPnWuivQL9BNdQPGBh7ftTZTOwhTy9Ym4YVdMqmsPN2uDUq252YIjMhSdf0QzHBlW48IiuFVWl9PBhOWia84oo+Dr73WpC7iiEUbkDWGMbpaakOpGXNWIBdSb2WInlMeqSod1k2q9yhY+xnq3ZkIvNgIcvsOYSZmTolOVjx2ufeXKGIORwL3Z526ygDHPTc0r9v9ZXtHqWG3Gl1L7/o5MeqyrOnkmPvFFqTfjmY56KbBL7trkwtFmdD4+udC+uiDokPJAu5kZbAia2UMrjefs8gg+ME0yFLPc9QnUzKaMZunzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-watchdog.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ig0BMYVie26+MrMcwe3ltN2N0YHFj7eXpz0SqNZtKvE=;
 b=5k9dHLxueTwxa+SJ9kLdMV9o/VV2lFiYDXYb4Mh4Xde/9kmrTjQ7vN2pq5MG1SC4YBomFOBSBWZn58t7+AtB9HkjXtvMeCboXLwq6C8JV1UrSj/QHgVl0VYAo6Lxx4ogIZTiqAvn6o5SvtaOBVpVqhyGOpX0+NdgCBVoh9lyA8w=
Received: from BN9PR03CA0681.namprd03.prod.outlook.com (2603:10b6:408:10e::26)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.24; Tue, 27 Sep 2022 11:03:27 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::87) by BN9PR03CA0681.outlook.office365.com
 (2603:10b6:408:10e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Tue, 27 Sep 2022 11:03:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 11:03:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 06:03:25 -0500
Received: from xhdsneeli40u.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 27 Sep 2022 06:03:21 -0500
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <srinivas.neeli@amd.com>, <shubhrajyoti.datta@amd.com>,
        <michal.simek@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <git@amd.com>
Subject: [PATCH 0/3] watchdog: xilinx_wwdt: Add Versal watchdog support
Date:   Tue, 27 Sep 2022 16:32:54 +0530
Message-ID: <20220927110257.41963-1-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT022:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e6f3c34-e530-45f9-c779-08daa077e71a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J02BQYXUuzemMvsP5QZ4nEe9nY64/N25pZM056mLsstW4NPEESYYVwBbzGniW3ltlAE1q80SMvPZ0HtLVjI9Y+TX0SLddVwtHdndS0gdCTACHedJ6o4/N3FB2fqgnZWZZ2musrNC/9+IOuZoBEQOIHVeRGAKGEnSBM3ZBYg1yLtG56WB01/hSeSBEYi6JETrAMtIt/8bSoGfNeMQeFC0BV2IZ9gzNVq4UnQoEWHNp4Pa+banKPJ5qZgfLRbyOPy/0h9UrZWfwjJEzsRRgbONmoRGaVQ/5RlEBwg7niPQHRiyhmsSmX12fyv9p3AU7Y4y3rMx9QL+NttIokB1YoDyjanpeD6zfXhl05x6CKbSmjHROP8PRJfqEsgnYvZ48Amw2WDxbJAxbmPew7WUaGfXYc7QUhug3Mt1wSO/Ed9hoSaZZYB8I6CPqNeRXuYgf+D+glA53AV1qvZJ/q9SlR4qJlyrK0neOQhJSQMQEtaiimwdursT9ILEAS/3fQS2meQW1lTnZKq41rQDZRW2GQuoLBbndIEiExuAOl4K1HTQCNh+hrTz7hr10r9lx3n69YxR/Fq2EQfkLbpX6W2Gefdjht+UPU+SJZ23JTX8axvE0Scytq6Ph0koI4NrMj6Q+vgNOm+CsJA/9jSuTFrGCwArA+2049oUImU34AouuAVm9Fc28AA8dk5i88b4IO+g8oXkj6N91dTaFrCgPa3+Gk5BVTjg435xCp3nvbFMicohh7GC+xshdoUo3AGHJbuu22BV3zpHNZ+FIUMSo42sGOTqqpCd95C9TIUs4AipdqEGuu4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199015)(36840700001)(40470700004)(46966006)(2616005)(26005)(36756003)(4744005)(316002)(2906002)(82740400003)(41300700001)(44832011)(6666004)(8676002)(40480700001)(82310400005)(70206006)(8936002)(70586007)(426003)(4326008)(47076005)(83380400001)(81166007)(336012)(186003)(110136005)(356005)(86362001)(1076003)(478600001)(54906003)(40460700003)(5660300002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 11:03:26.4565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6f3c34-e530-45f9-c779-08daa077e71a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series does
-Adds dt-bindings for versal watchdog driver.
-Adds support for versal watchdog driver.
-Adds fragment page for xilinx watchdog drivers.

There was a series[1] sent earlier to add versal watchdog support using
pretimeout. In review it was discouraged to use pretimeout for open and
close window . This series is a new implementation of versal watchdog.

Srinivas Neeli (3):
  dt-bindings: watchdog: xlnx,versal-wwdt: Add binding documentation for
    xilinx window watchdog device
  watchdog: xilinx_wwdt: Add Versal window watchdog support
  MAINTAINERS: Add fragment for Xilinx watchdog drivers

 .../bindings/watchdog/xlnx,versal-wwdt.yaml   |  49 +++
 MAINTAINERS                                   |  10 +
 drivers/watchdog/Kconfig                      |  17 ++
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/xilinx_wwdt.c                | 286 ++++++++++++++++++
 5 files changed, 363 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
 create mode 100644 drivers/watchdog/xilinx_wwdt.c

-- 
2.17.1

