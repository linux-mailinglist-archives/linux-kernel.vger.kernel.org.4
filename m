Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8702F5E9550
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 20:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiIYSIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 14:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiIYSIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 14:08:25 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BD12B26D;
        Sun, 25 Sep 2022 11:08:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3XpBfW2yad1ImKhikLU/PS71JS5LK/Q3noud1yBW/BEGEkrqrQ/Mmbl/p4uVEnhA8OYDBFddDdwww1Fink/GFo6GGNHOOvz96Yzk7/wn/YJjuqHx2qwRpaIHDLXrVe3xGWncdXDo87QFL/fchoeVYqMm0Pkjqhwe3ASpAJpWWS9WqZupy8oBPlun8jMPHpHuxy6Ft26dxP6XC7vdQ3Jx+HrdEEb+6sfyYz06Tk0E6yRGbqDr84DWmTkFFm/avvC4UiijlZUmSaqLIILqG9nR95JmwhLH6EPEWm1umKZFoh6AWFyhdwhPawHVjSIfudiS5/vmeG9vFekdFF8EeJtNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ic6HEQgRzR3W7kuVmXXFhdlCDdYBBKBaFNgokwZ5Nxw=;
 b=meP9ktjhZnHiqDbZh5n539cAg34XcE75B3KqATivnZamlYN556sqNNaXxfYnMI7adwL3jzzBDJzRJdCVIleKpCwUiBfllM4d1qrY1c8O2/CzVe3WbTx+BI7pCJZ9JchypihtrFuNAwr01d0vpU6cLoeBOeMcV+T2h+QoEVXtRavR/lqotWTrmvoeayb5r5ucx150o+pwfnZsQC6GP7TMJMwKzUIG9okrn9YMJUihaELzLqg3LO9ADsUYBcW4mzQ/puIW+GBSwKn5O/Y4zsN7OysH7iPyhThxyzK+WN6B46OD1gv+av8GlDGS8gxRp9Q8s918lCjPo+gkrp8WOrXe7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ic6HEQgRzR3W7kuVmXXFhdlCDdYBBKBaFNgokwZ5Nxw=;
 b=W6di/Wg8X0p04u4YRFTrLNLCHRh1UbBFZ71gUEHnoYGo6yEQ1/ZBoZpfWocpH2wbcgdDeKv2RpGwt5OHPlF+DWn3SWt2jSg2SFYHZag1gZOWeto3Gq2P/oWZzb1GTwn9deiDnqfnQZ1zy5zbMK7iRs7KCsraaopSk2bZJ/ZCMHU=
Received: from SA0PR11CA0132.namprd11.prod.outlook.com (2603:10b6:806:131::17)
 by CH0PR02MB8149.namprd02.prod.outlook.com (2603:10b6:610:10a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Sun, 25 Sep
 2022 18:07:43 +0000
Received: from SN1NAM02FT0006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:131:cafe::da) by SA0PR11CA0132.outlook.office365.com
 (2603:10b6:806:131::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Sun, 25 Sep 2022 18:07:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0006.mail.protection.outlook.com (10.97.5.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Sun, 25 Sep 2022 18:07:43 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 25 Sep 2022 11:07:43 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Sun, 25 Sep 2022 11:07:43 -0700
Envelope-to: broonie@kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 akumarma@amd.com,
 git@amd.com,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 amit.kumar-mahapatra@amd.com
Received: from [10.140.6.18] (port=44788 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1ocW2Y-0001TD-JG; Sun, 25 Sep 2022 11:07:43 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <akumarma@amd.com>, <git@amd.com>, <michal.simek@xilinx.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <amit.kumar-mahapatra@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH v3 0/7] spi: spi-zyqnmp-gqspi: Add tap delay and Versal platform support
Date:   Sun, 25 Sep 2022 23:37:32 +0530
Message-ID: <20220925180739.21612-1-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1NAM02FT0006:EE_|CH0PR02MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd450ec-0700-4043-5ee7-08da9f20d7f3
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzuxxcu5o2gccLaJL2EcS6OsEIffC+f3xuWXM/FjpW+phvqCScKybuRSzHETbt6FnH6jXOy4Qj4HTohYCRk0Ha+gMGMmZFubfHE3h8DWPZwuEgGcEap8tiz60JZU9kv6nlimFJ9mZo+CVS360fuX37QX9WjhAznOCsbsnF6qKJagdX/Fv60RWpc1cmprQBxUChCNK48Ojhw+h81KxoorFgOngwPCekkeOC7S6JlFsFvrAuP79LzA55duxBlTwaORSZv3ieVP8HOC1xTOjTxOHr9bSlmaGFkaYVvRQ8ccGr24nOBLexNHY0twTzSoJrkIHBEn9ehlwamx7lb14h8QH5lL88rEr7rMWoLtitkPlFgOMikCfgbrTEVjLEfESY9OvKG9fq+sn86GXamN5UuxSjljYDx6rsnQRAhmKIpUidvRXo9HxfRRxD5DuDJFSjOp4Foiy4cSgUcCbxLV0YpoAKyXAxHRowi7X244xxLBC53276Xyo4ipQvjfdwVj6AHstYrp3N1bN76VlszyPHv3qL072IVJt9idmXtxFXts84VfPvGQXv1cll7qis5fe234at6nStzdVBOT6XMAyPM5bikfd7H2ryCtFocGcQX0/eAYhAHQysC8qTudDzFi9enwrVgoiH1FOw0Cc8qguwfmE1X4UUikFeJ68cy7d+6cbloYvjQ2ZU61RXj6n0x1sYmj2HVxgXBTZCqzhl0s0HivrnwgWfpDcLxM7VRqXck+lq3xACXCIl48qoQXQV4gmh5vJbrL4vy2Yw7I2fUILsKvscB59K8IpvFs7+WDz2TLEc4=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(40470700004)(46966006)(36840700001)(2906002)(2616005)(356005)(82310400005)(186003)(1076003)(7636003)(336012)(6666004)(107886003)(40460700003)(41300700001)(478600001)(36756003)(316002)(70586007)(70206006)(8676002)(4326008)(26005)(7416002)(5660300002)(40480700001)(110136005)(54906003)(8936002)(9786002)(7696005)(36860700001)(83380400001)(426003)(47076005)(82740400003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2022 18:07:43.6229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd450ec-0700-4043-5ee7-08da9f20d7f3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0006.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8149
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Fix kernel-doc warnings in GQSPI driver.
- Avoid setting CPOL, CPHA & baud rate multiple times.
- Add Versal platform support in GQSPI driver.
- Add tap delay support in GQSPI driver.
---
BRANCH: mtd/next

changes in v2:
 - Used of_device_get_match_data( ) API to retrive match->data.
 - Removed oneOf and used only enum.

changes in v3:
 - Rearrange compatible strings in alphabetical order.
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
 drivers/spi/spi-zynqmp-gqspi.c                | 191 ++++++++++++++----
 include/linux/firmware/xlnx-zynqmp.h          |  19 ++
 4 files changed, 184 insertions(+), 37 deletions(-)

-- 
2.17.1

