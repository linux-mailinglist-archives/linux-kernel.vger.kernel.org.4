Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B665FACA2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiJKGVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiJKGV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:21:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC73E88A00;
        Mon, 10 Oct 2022 23:21:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjX7Y3wkgZUIba5YMEM6GfjZEZmTREHqMFtgP1kjrckZECwZFGvW/xzA2/KMZ+3FjUj4rsk9Cl0rROzV8MwlOfafL+848A2Hs7hqP+O1AMTY/XweboLRnPjcC4r/UmAw7HHNII6cJB4GHk796JwDaulsa9bjr/pB6365DH1c48Pe+ocILMHSXUV22OcdjGCltwmIdxOs0GJat+PEU1MEfRq3Am6PYTmD5Tc5jerOa/y3mdjyBHub59ReJPLU2c+bWbnTrQIDNEcwljZzjwOPABwmhprQUYY2PaQa60SDjzWg+c68BwSUYh6K17KW02TdW7vlKWBzaOeD7uQ5x1EXmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHv4UUmmi618SqLBe+XEf59UgNdXdyQns6LLRHqU9ow=;
 b=AUPHSVNI6p0Bj9leWFLC3FpeDI1Lzws8WZAgEM0hahpVVBDbZeLjdDW7mTpHjEDysIbhT2DMn158jgqqKRZJ0v4bAC9PeZ5MC8HOHmTIzCWASNqGAoGh+06c9ov3lAKQxGCoaJbfaY/FjdMW1wvWxT9OMhr6PiOmwn3GJyco8asoKiKg/Hz29Ssu0oB2aRxXtpVMRqRErdXgXYFZE/X4uAGYhA8eIK65ncP3lSmAQJTC0pOU64yLa/UFD/EK4JWPIa7Kc2bwfgTnZ0dXoJY5DkbJnI2MDhmKujMKR8oeG1wBCTLELUdxX+uzn317e5jVexvms9ChfvJwGybUIexAtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHv4UUmmi618SqLBe+XEf59UgNdXdyQns6LLRHqU9ow=;
 b=NagI6rZlQKgGxNYiOpbrxShLff8Dt8+bR9F/VBiDSth2kFy4IGt3hETJkNwhemy/vXRdBxjCh947f+/tYQ0FG9qWXqsDAL1VigzO+ldB6kDXJXEztWT89VavwD94HkXUA044xvrP3qSjzclxRnL71pdA2LObBdRYR79VNVitCVg=
Received: from BN9PR03CA0218.namprd03.prod.outlook.com (2603:10b6:408:f8::13)
 by DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.34; Tue, 11 Oct 2022 06:21:05 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::61) by BN9PR03CA0218.outlook.office365.com
 (2603:10b6:408:f8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Tue, 11 Oct 2022 06:21:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 06:21:05 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 01:21:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 23:21:04 -0700
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 11 Oct 2022 01:21:01 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH v4 6/7] spi: dt-bindings: zynqmp-qspi: Add support for Xilinx Versal QSPI
Date:   Tue, 11 Oct 2022 11:50:39 +0530
Message-ID: <20221011062040.12116-7-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011062040.12116-1-amit.kumar-mahapatra@amd.com>
References: <20221011062040.12116-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 15489511-f286-40d4-40e9-08daab50c761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UzjsqKZZudGOuZpmwxeIOD8P1QPKSwIp6tVyblpAJGwW3WKJWHupMR5G9Jd346fjXrlFqbeEDuUpXGVqP7Mcq5ASG/Qmfg3blVJcbj3Ksk3nTowK39m4PD/QILQ3Ggl84KyH3hBcY84p5rtwHRmxMyshTW8QGB2Ll2q7Jmqa7IqnSyCHMQsztmdF3CZGlUlwvSwpva4LrRl9avq1DhLoG3tIweOJfP8jU3YxBu79+btMLrdb8MHwYIQGuQhioQZ4aqWVF/RflLsMI3fEZ/90VuqYoHWs30VKTqIH5dvOjjb29MN8R6z3o1wH37Kk+dn+7ns2fETP81Oyv/ocDkGCzmKT7W69Ox6cJ/xdLjyC6Ow9t2mBNX9jJXnlO///zuGj6xJeeC5KpCEjnmuqmOyyecQnVqHd674dv9KLCTEJAJPNS0uElfIxjRBw4DSBfrnRoQXraGiBc5ayJ9zdwvT9NWIqW9nXuOlltWrPrStwaVic0YJ0AIQ1D37u11VDprQ5XJ4lS4fth9yHMeQBG/tqEriWUb9/4uXtGPnMh2ed5JYyp1pXqsGtp4kcCk9n+xdsYenpDYxc4FL7kFf2pGVSNiyV/ir4Zn4ZSEormneJvcpTni/ErgM9Bym2+YlKyYmTpbEnZQ/T3+X1bTB+ZUaWzeIum+0xb9JirvrIQiZfeR7xFUPhxz/Ul8/RXjd+1WrN/SxYyuy/Jb34gUZzfZ9t0FVsLcIJStnR8GimUyZ6gLQUgahe+PsM4eP6gFQKymwcFzxKfTsikU4wcHNmsHEh+MDSALYH2HCSoRwOJ98+pHU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(2906002)(186003)(2616005)(47076005)(83380400001)(36756003)(8936002)(70586007)(41300700001)(4326008)(86362001)(40460700003)(40480700001)(6666004)(82310400005)(356005)(82740400003)(81166007)(426003)(336012)(110136005)(4744005)(26005)(36860700001)(70206006)(5660300002)(478600001)(316002)(54906003)(1076003)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 06:21:05.6806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15489511-f286-40d4-40e9-08daab50c761
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible to support QSPI controller on Xilinx Versal SoCs.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
index fafde1c06be6..5ed651084896 100644
--- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: xlnx,zynqmp-qspi-1.0
+    enum:
+      - xlnx,versal-qspi-1.0
+      - xlnx,zynqmp-qspi-1.0
 
   reg:
     maxItems: 2
-- 
2.17.1

