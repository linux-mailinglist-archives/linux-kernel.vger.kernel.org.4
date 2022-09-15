Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C6D5B9A62
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiIOMIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiIOMIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:08:05 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0261E74E1A;
        Thu, 15 Sep 2022 05:08:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dG/ZkiDHOWSkxHN9RfDOOjTC+M9F003UbGyyTELLVVhL3tqMrzSfQ+ibBgYyBTq1Y1t192XI4CCE7ToXtVm0LbFnpqRHYXxkQfprnHf+P9SqwyXkEvtwHpE9dcU7Hub9a/I49KLsXo4I46ELzdXRrXlqm7mUsmxtTrMqODTWQ3V6m7fx9wBIaOBDQ9lWx+cjULXUO1ADQQ5dgj5ZiwMlPmyNRzdktOs4MrE/7oaLhgzK/rwMpEPzdnlNRsupnwu2o9PkElD3xmD6+OxoO7w8tYRTKre3+SaJ+YpNCTMH6freu78kmWj7IstNekSgeq5xuNV5PjjYHPh5kMiRP05H3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIRlTv3PZjDdH3/1Uifj7Qex8CmmASu5XvUXYIEohxs=;
 b=Gq6F73yRYc2aa/vxAH5MWcSKE8o/JK9DJHl4UZbt6RBd+0KPul/5eb1TrATnty3Hxq2zvBzVQilifbGyBk631BU/UXOfUrjqqnCCW7MqLtOAqLMpAmCtx5kdOYHLH7hd710hLI/4NdvK+pnOUC5yDkVl5q/yExxhlysLkroYDnPwcsXS2nU8CZvgmx3EgvGL34fyTwLRwpUYrXHcZd9Ek/ZNSQ+A2t2soAZQiT6IXh2xENllK1flutb9TR/r51MZMkgSKyJbdbbFz4x6kJLI24OqZW8rN459YDscz1qMFLmG83QtuA/ACMy7GJR7NDtI+Pw1m5BIsgM0RfHz3xK+Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIRlTv3PZjDdH3/1Uifj7Qex8CmmASu5XvUXYIEohxs=;
 b=eHkuY8F1nYSgQRDOhcJI1AJo0fRHz4lOBLOTAmOVF6IPMqVYGZyDCnH0Fy3lU+X6XyZgmXKaaTR/dsjG7NDUPY2n2IGixzP+ZsIDBdQ+d4bgZpmW4sYulieOowXzPxWCSl7fyS3uOK9SHqVhPHGQLAQRt98IAkMnZbfCfa6BUs0=
Received: from DS7PR05CA0085.namprd05.prod.outlook.com (2603:10b6:8:56::15) by
 PH0PR02MB8678.namprd02.prod.outlook.com (2603:10b6:510:107::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 12:07:58 +0000
Received: from DM3NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::5e) by DS7PR05CA0085.outlook.office365.com
 (2603:10b6:8:56::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.6 via Frontend
 Transport; Thu, 15 Sep 2022 12:07:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT063.mail.protection.outlook.com (10.13.5.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Thu, 15 Sep 2022 12:07:58 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 15 Sep 2022 05:07:56 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Thu, 15 Sep 2022 05:07:56 -0700
Envelope-to: broonie@kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 git@amd.com,
 michal.simek@amd.com,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 akumarma@amd.com
Received: from [10.140.6.39] (port=33420 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1oYnet-000Fci-Ul; Thu, 15 Sep 2022 05:07:56 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <akumarma@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH v2 0/7] spi: spi-zyqnmp-gqspi: Add tap delay and Versal platform support
Date:   Thu, 15 Sep 2022 17:37:43 +0530
Message-ID: <20220915120750.1424984-1-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3NAM02FT063:EE_|PH0PR02MB8678:EE_
X-MS-Office365-Filtering-Correlation-Id: 659f9d53-32ba-4fb6-e326-08da9712ede4
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bm/2gAslst/0Fv1y5jVNIfTzFBniG2YnLkuUzlZZRlgL776S1JRJJxHstT/dwGzgKtQoLtBUU+tlXL/7oUvbsFgnnLe6UsKjvDZOAhU+cwYNQE6eHwKRf9Ze42D1giLRXtR/7n8zFwxXfWWhPccXT7oOSU5ggxGs3yHr9OIs7uMF9WO30Qc1lKE+SAskjpeHdS3ac4bsGOx+xnav6y2uWtIgnI+jsNFDd1vulgwgCZQluyzj6aOLp5KtpUfft8HZd372kwl1F/XviIMtAOncv4Tgw/xmcp2RP1RtDNOjtFZd2VnDfWWxZiI/WcBhBtmcK8jJa4vcgEL4HRIj/6cO8gLs80b1gHY7IUhEIhJlvgMZ4ySCqCx1AokOEZ18npkJKj/dmTMPxOr+lFYQZGeKIwfBn0KPn2gHxFXwb6y1Pq4EkIYkUkpgQueQcbLp8P3fDZ4JHr4hfNt7gUnBUO5WhiGYyxzzx932Qy/U08maWeLYzjv59AKl5ESd43JtVsIa+BjaP6+J9tyR2G/0LzOIUDoS5Sj/xwpIWZxIW+gyJ5TPa5r3zFVrBLRBgpQL16kbmqSLqhzMBtxeZN6UMHGeAFO17x9TxvXxWxS5kEGmKD7PDe6o3EaJpXADqMJAv8pa6eJeUQZidk6+IZk8sMFRdTwW85HF81VvMs3UzwQnrh5R0bP0fReKVBcobJAqeowlddxdXwkq1gAAaUGFLYJkL3wlu/PLPQrqFKGVM5y7kYdZFEMDljHk61iEHjcqxLeVxAHXYlhZhN4Qlp/WMEOb89lhGEzOWrohCg4X1CvfDPo=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(316002)(8676002)(54906003)(356005)(7636003)(107886003)(40480700001)(5660300002)(82740400003)(7416002)(40460700003)(9786002)(4326008)(70206006)(70586007)(8936002)(2906002)(426003)(336012)(41300700001)(2616005)(186003)(1076003)(82310400005)(478600001)(26005)(7696005)(6666004)(36860700001)(110136005)(36756003)(47076005)(83380400001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 12:07:58.1658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 659f9d53-32ba-4fb6-e326-08da9712ede4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT063.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8678
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series:
- Fixes kernel-doc warnings in GQSPI driver.
- Avoids setting CPOL, CPHA & baud rate multiple times.
- Adds Versal platform support in GQSPI driver.
- Adds tap delay support in GQSPI driver.
---
BRANCH: mtd/next

changes in v2:
 - Used of_device_get_match_data( ) API to retrive match->data.
 - Removed oneOf and used only enum.
--
Amit Kumar Mahapatra (5):
  spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
  spi: spi-zynqmp-gqspi: Set CPOL and CPHA during hardware init
  spi: spi-zynqmp-gqspi: Avoid setting baud rate multiple times for same
    SPI frequency
  dt-bindings: spi: spi-zynqmp-qspi: Add support for Xilinx Versal QSPI
  spi: spi-zynqmp-gqspi: Add tap delay support for GQSPI controller on
    Versal platform

Naga Sureshkumar Relli (1):
  spi: spi-zynqmp-gqspi: Add tap delay support for ZynqMP GQSPI
    Controller

Rajan Vaja (1):
  firmware: xilinx: Add qspi firmware interface

 .../bindings/spi/spi-zynqmp-qspi.yaml         |   4 +-
 drivers/firmware/xilinx/zynqmp.c              |   7 +
 drivers/spi/spi-zynqmp-gqspi.c                | 189 ++++++++++++++----
 include/linux/firmware/xlnx-zynqmp.h          |  19 ++
 4 files changed, 182 insertions(+), 37 deletions(-)

-- 
2.25.1

