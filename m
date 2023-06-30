Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E0074347A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjF3FlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjF3FlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:41:15 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66A53AA1;
        Thu, 29 Jun 2023 22:40:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CG5KtOmbQNZoaW/kBtEIukXLofDxiXXb4atF2qPykN95BpuFLVyYqF5R+HxMDU0bFJDuvRMOkNqI92djxWTUgLbXHp3cSz0Silc8BhEL077AFKMhej2ki5aIQWSeZBpIoKEh66t/bn9Jau1YpAMGcSWaq7l8cfQfBEmbvCI3a57vqujE9/7YB/G4V4weuWqjbRmVA1QClUzBzE45rbngVvSO3b14cUWSu4/7mQDhSvBVnXDeWdDJrv6MAdluiA49SsBDwnWIWlY/pGZBp9GAQ5TxOLz786cyMk9hUOcmOLNOqBEAba/DtcuXmB0Q0jMo5Rg2TP1xvcnpe7w0jhel5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+pizYYg1ey/zm4pL87pVpZ2HKiq91cy4HDCwtuIHYU=;
 b=nz69juZXNnB793WZDmGR/nWSfaox3OAyOhxSwskajFEoKq/oftzdUKppdiMuQu5tMn1qRvAOMdrRLLlbG6YQ/iHjfD0RqSMWiXpbhTpcFXrvO3HcDlal1J2VRk/Y37mZfU47WWHc52ru7FdREfl99lkvu+m/vJ35LDXajJyl6RUxhxMZO/UKnUzzkzqaFTaFSUX3t4SWcfYS60eotQaEuCishbkhspZ3ffVFTAfBKxuRWOBR8SspHRoE20jZcF0CFW3AteYJQHt4FfktOSslfeV6ZdbhmCdrfIdZUlutjnRtRK7tkd2PSR02rhke2vfS3wR/5t36abCfJEqe/W1fGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+pizYYg1ey/zm4pL87pVpZ2HKiq91cy4HDCwtuIHYU=;
 b=bza3dTzqVFUVXgSbBqKTSsGz7/RBLk7TolZQzgHyPgnoDFCo32cr2/Ru+gL0W4gEDrgxGZrQk6LxBC70GP3GR2iY59Hfhno6+PFvozwgUErqQvoaiLrF9x/dO2fxo4XTwDUiuNWmv6FxG/8wZZARw7wS5+jgX3zwLOeZl+FvXR0=
Received: from DS7PR03CA0202.namprd03.prod.outlook.com (2603:10b6:5:3b6::27)
 by SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 05:39:10 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::41) by DS7PR03CA0202.outlook.office365.com
 (2603:10b6:5:3b6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 05:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.50 via Frontend Transport; Fri, 30 Jun 2023 05:39:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 00:38:49 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Fri, 30 Jun 2023 00:38:44 -0500
From:   Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <sbhatta@marvell.com>, <linux@armlinux.org.uk>,
        <michal.simek@amd.com>, <radhey.shyam.pandey@amd.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <anirudha.sarangi@amd.com>,
        <harini.katakam@amd.com>, <sarath.babu.naidu.gaddam@amd.com>,
        <git@amd.com>
Subject: [PATCH net-next V4 0/3] net: axienet: Introduce dmaengine  
Date:   Fri, 30 Jun 2023 11:08:41 +0530
Message-ID: <20230630053844.1366171-1-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|SA0PR12MB4447:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d64c9d5-8170-43eb-b5f6-08db792c5442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nbhf5sKvQdXLSjnyna1wtnWfpRfQ5vjstPfFayrJyDV08PQdtWwsQyLzX3cPUbkGacFs+y31UNLCN9XFsPeAmTAQe1E11AnqVGAhSJ6zW9B9RNRQvXTOW2my6urGnpMGcTz4ZzrOr2NoZ4xEp8TQb6edvTxpifyuc9FyEg+IPNzdF3rWIQJ4Y7IvZ0sVZEAU+BphgEk0BFPSbBUhAJUS50ORfwtnRX1EqkLDudYYxf6DVpqBD38n2W+FrFg4J/ETvG96G1QTTHy24DFyYLYkuiyms7GWl+xfj3ysEh2l0m/Nfj+VoeA/ZIlJSfMaeWvoTjTcw9iizUF9EH41g1YKQWRJWzxPZgDYS4UKuDANKsPrJOGma4G5565naycWXJu4MSzyKNf+MAENCQbJhc0E26Q36f/9ER5MCxsApzVVhKDiiPJ4gx/GXWUifcruNXOT0r7srhnY5hO/hxi4TOgoKSYHK6/WWKcE5mWssVjFmRHC7bE7y/Rc1sW1aW3hYDWBZkK4zS2OJYLQZo0JJnIfoa/xwIq3SyrOi0BYcnXZb+j54czC18jytRXbD5nMfuTDAy5aSljQpkK/9GxQJeaDYX+DWn6196OTKokDHq4YbEZwttHTsCCpJIFJAiLtXvsjru1gOlG4a7ssByhCOUsi1hmDAhdNp5ec4sNJpWHmZLRt6RXh4zq12oi3WB0vSOFILQ8vK4nB3dmebp7OBNU/Z7EcX5TYCRUeJV0tM6wIi2QQtaUyRPcamE6ksEXSS5GBBESSlxiaQVlLU1IrhBSfAguSXnvCyMolrB3ouMp1P7c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(966005)(478600001)(40460700003)(6666004)(47076005)(36860700001)(103116003)(186003)(26005)(40480700001)(1076003)(426003)(336012)(2616005)(83380400001)(36756003)(82740400003)(82310400005)(86362001)(81166007)(356005)(4326008)(70586007)(70206006)(2906002)(316002)(7416002)(5660300002)(8936002)(8676002)(41300700001)(110136005)(54906003)(66899021)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 05:39:10.1456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d64c9d5-8170-43eb-b5f6-08db792c5442
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447
X-Spam-Status: No, score=1.5 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The axiethernet driver can use the dmaengine framework to communicate
with the xilinx DMAengine driver(AXIDMA, MCDMA). The inspiration behind
this dmaengine adoption is to reuse the in-kernel xilinx dma engine
driver[1] and remove redundant dma programming sequence[2] from the
ethernet driver. This simplifies the ethernet driver and also makes
it generic to be hooked to any complaint dma IP i.e AXIDMA, MCDMA
without any modification.

The dmaengine framework was extended for metadata API support during
the axidma RFC[3] discussion. However, it still needs further
enhancements to make it well suited for ethernet usecases.

Backward compatibility support:
To support backward compatibility, we are planning to use below approach,
1) Use "dmas" property as an optional for now to differentiate
   dmaengine based ethernet Driver or built-in dma ethernet driver.
   Will move this property to required property some time later.
2) after some time, will introduce a new compatible string to support
   the dmaengine method, This new compatible name will use different
   APIs for init and data transfer.

Comments, suggestions, thoughts to implement remaining functional
features are very welcome!

[1]: https://github.com/torvalds/linux/blob/master/drivers/dma/xilinx/xilinx_dma.c
[2]: https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/xilinx/xilinx_axienet_main.c#L238
[3]: http://lkml.iu.edu/hypermail/linux/kernel/1804.0/00367.html

Changes in V4:
1) Updated commit description about tx/rx channels name(1/3).
2) Removed "dt-bindings" and "dmaengine" strings in subject(1/3).
3) Extended dmas and dma-names to support MCDMA channel names(1/3).
4) Rename has_dmas to use_dmaegine(2/3).
5) Remove the AXIENET_USE_DMA(2/3).
6) Remove the AXIENET_USE_DMA(3/3).
7) Add dev_err_probe for dma_request_chan error handling(3/3).
8) Add kmem_cache_destroy for create in axienet_setup_dma_chan(3/3).

Changes in V3:
1) Moved RFC to PATCH.
2) Removed ethtool get/set coalesce, will be added later.
3) Added backward comapatible support.
4) Split the dmaengine support patch of V2 into two patches(2/3 and 3/3).
https://lore.kernel.org/all/20220920055703.13246-4-sarath.babu.naidu.gaddam@amd.com/

Changes in V2:
1) Add ethtool get/set coalesce and DMA reset using DMAengine framework.
2) Add performance numbers.
3) Remove .txt and change the name of file to xlnx,axiethernet.yaml.
4) Fix DT check warning(Fix DT check warning('device_type' does not match
   any of the regexes:'pinctrl-[0-9]+' From schema: Documentation/
   devicetree/bindings/net/xilinx_axienet.yaml).

Radhey Shyam Pandey (1):
  dt-bindings: net: xlnx,axi-ethernet: Introduce DMA support

Sarath Babu Naidu Gaddam (2):
  net: axienet: Preparatory changes for dmaengine support
  net: axienet: Introduce dmaengine support

 .../bindings/net/xlnx,axi-ethernet.yaml       |  16 +
 drivers/net/ethernet/xilinx/Kconfig           |   1 +
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |   8 +
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 616 ++++++++++++++----
 4 files changed, 516 insertions(+), 125 deletions(-)

-- 
2.25.1

