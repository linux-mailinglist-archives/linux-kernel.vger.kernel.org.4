Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91BC5B9A77
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiIOMJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiIOMIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:08:36 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511787F100;
        Thu, 15 Sep 2022 05:08:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAOWkmNA22cJjsbpS2Iez2/yBiUswzXO5/aBcMZeTccvD5NuuFyQGrZi3A2YdUmMFL9jw4z80wNUqkbYB+sFkcIBGCXxI6rl9CBsVw+5CiBx0P83IuVTRTtd3XmDkoGMks1U/wIzlR/q/c6oQxwGSzOAt6AYOyds894No468rD+d7bWF/RN5+UWZa8NU77mWn+F7x9/KQmSXpuLMjPu1kw1I/aS5ow0SiQ7N4TP3v+idkxU9wvQj05pr5VqnrT9t4tZHlKiy3GbNaT02ktJdly1cKtl+NR6WrP0YruLTLSWGL4pmXzJYQZtsC8jis41NANQ9nVrJD2JvTfex0HlD9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIXtmoreUwJdEoRPBDZTZoiftr8lP7JPs55YuXXKbMc=;
 b=bE5imhxveHYC9IeWFR4IlG/iWAwTE3mnDVJt0oMMN2Gw556g7l+6+XkkFOcxI05jG7bVL3U4f52yTihn0JYJDR8HIUEufSVCgCtP0jXHIdLhDNz2ivnFz5wdWRd5HFvnABqY2SmcAvcJ3RYhBjTiEjjHgSRag5m/XKciYHaoGCoBKejLvS+tYZVsptRfIgCuzpbI+Nr85VMmq7SCQ9AiV76hQw7PrXgyIJJDQDyrYWr2LiFe4fu6j4rtApBr6UTgpCYfffR89Pj8pRdWzYLNLKLJdj7HqeHaUoGsLzzLz2YxLtg4iRvOeBBTyU6dlnPc/djOHfKfmrzNM5pF41FplA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIXtmoreUwJdEoRPBDZTZoiftr8lP7JPs55YuXXKbMc=;
 b=eD/cxCsH93y+jvNeDoM6e6UVbexWOw5+SIRnV8sLbhbAiO5jJmzpm5J/qft9yRFD/q810kp6NjWYipTpoLACDi09kUVuO2oe2Fg5RvjSJxUNzq70NtfvLgQ0WMjk/UlclA24voRT4zR6iH4FIzS2+VQr55fnz83NfhDNjtxocM0=
Received: from DM6PR01CA0025.prod.exchangelabs.com (2603:10b6:5:296::30) by
 DM6PR02MB6843.namprd02.prod.outlook.com (2603:10b6:5:21e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.20; Thu, 15 Sep 2022 12:08:27 +0000
Received: from DM3NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::9f) by DM6PR01CA0025.outlook.office365.com
 (2603:10b6:5:296::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 12:08:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT032.mail.protection.outlook.com (10.13.5.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Thu, 15 Sep 2022 12:08:27 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 15 Sep 2022 05:08:15 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Thu, 15 Sep 2022 05:08:15 -0700
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
        id 1oYnfD-000Fci-A0; Thu, 15 Sep 2022 05:08:15 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <akumarma@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH v2 6/7] dt-bindings: spi: spi-zynqmp-qspi: Add support for Xilinx Versal QSPI
Date:   Thu, 15 Sep 2022 17:37:49 +0530
Message-ID: <20220915120750.1424984-7-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915120750.1424984-1-amit.kumar-mahapatra@xilinx.com>
References: <20220915120750.1424984-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3NAM02FT032:EE_|DM6PR02MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe0b0ff-b1f8-46b9-a3ef-08da9712ff33
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A80+SxMIPm9Kfr+WB2FS0uxXVOh9EYehm8Tzs/++Oe8QBUmCvOMqWLA4CMuS1qEd0Z35utNK9zQ0wf+c0AwQ2i6USdTh7SuuTErbtbJnqYwuseWuW8vC42Gf5g9LQC1/3PDAVU8d5LeP07+P0g1jdchsqHjeeXXdNtNFpcLtvH78iZYBg1plPAkng4U2UTf1e3hqvs6UPAbpSv9g7olNSt9BpAlsU1IEKvhawo1R57gyoFPyBJM7uwizItxEd3I379rIrl191Ta/crK0+tx2wUEDotvlDkT6JAvLPo6o3aahA8w7tNDNscVArj4dHZTWuxudkN1GVK0R99Whbl5423aKcPPkaQLf3Ri0GgJ34TUhtQzv+RZAMR44MGFovsbkXiA5Uy2pDm66fP4mJHP1K0DyQb2gbP9AjjanBfdq3MZjuDT5ViC1OaSqJFkTTG6w5HUm+d/RHqwFxvMBR5QXKO0AYecAmu7aVUbEv4Y/YMHS+gISgnXhScOwwEkbOAOxbXd1N/VBzsKM7flSSmLzUaC3rZdvZyw34RH8jbsTmCFNbE6b7wqwuOoeE6HBqp+Vul21XdSAyt5risZuqIz9an1beMLC+fqanUh+tSj/decaW8su3xi3wB/5Uvb/GC3zWlgtOaMwQMqQEbmd+2wXl8MPjluOis+nHOuZAoXM5hn3iN2aINtmqrvtspbnOUBmYp7t8zLBZ+Irx4tf1CaZnvE9Syp+ebuvtfOhniMNS+ZnOoPL40pYsdN0Jdo6c13i4hGCY0eGS8XYA8Gz+Q/br5ps0T0rtaaIlqeYDEmXIaU=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(356005)(316002)(426003)(40480700001)(186003)(4326008)(9786002)(47076005)(36860700001)(2616005)(70586007)(82310400005)(107886003)(70206006)(41300700001)(7696005)(82740400003)(110136005)(336012)(54906003)(7636003)(8676002)(2906002)(1076003)(8936002)(36756003)(6666004)(40460700003)(4744005)(7416002)(5660300002)(83380400001)(478600001)(26005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 12:08:27.2188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe0b0ff-b1f8-46b9-a3ef-08da9712ff33
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6843
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible to support QSPI controller on Xilinx Versal SoCs.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
index ea72c8001256..37108bfdcd81 100644
--- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: xlnx,zynqmp-qspi-1.0
+    enum:
+      - xlnx,zynqmp-qspi-1.0
+      - xlnx,versal-qspi-1.0
 
   reg:
     maxItems: 2
-- 
2.25.1

