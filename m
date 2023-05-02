Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FA96F4576
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjEBNsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbjEBNsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:48:14 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12F0F7;
        Tue,  2 May 2023 06:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpUmVnZdzyJ4C3Kfzx+6Uui5OVjK68uoJppDgJIYsJ3hMRStgm8UZ0HikwAaXuFRBR3upNQu6dGOcQMCTHUqDVn/bqSz5/K7+KROQI0jgjRdW7z38MZMmfKOIx+UPsgdQjPsGH1z5SK3l3VO3VlTe5clctg4Ou7VKxW1OlONeze8Y444SN08nKeRBpQvH6+lpG2ahtT7AQVSgs5yDlnm2o/ePZ65rYi5IIkY7qNvHD/SyUGsE66M5Y1zvtToQaD2hfNP/JAEJROyk19N1zIKwo1masOzMofGh8/NDyNJN+Gx/Ku+wATu9gQAn1zXYG/MUyyZLSUXqRB0Cg6tU2bSSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gy0AN5R1CfjsEyNLYTxG91wPGDIm3nORggRUnJaeYmg=;
 b=V1WM+tz2wk+4sg/5rtbKMY52GzpdVVcM0bn4QrDjyYBRZocoO+aa/H4QnOO5534N1roz3iqKNoodozSoCKMxXrECvbCn4+WbeA1XCpziGabbYSm3h9bXU2vWmgdeONYpquGNAz3/byUKXJw77qYHeb8BYkcA/CM38PWL6BBOVD1i3L5bZTZa0KQVUZ9miLaw0cUcqmU96XnN6C4SUPJ6KHU2ze5mXdigh+/MVl2GUeaU0Y43Ol+tlychXLuktTGS76teIi7TdIZFYHnvu+DHtMi1Yf7KUgv6Irah1RwJZJA+5Uszt8qDCxM87jWrUtj2UOjURcE2AokeqmeWhwlFVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gy0AN5R1CfjsEyNLYTxG91wPGDIm3nORggRUnJaeYmg=;
 b=Gtsz0HpPvVr5JSvQk+mQ+dg4YRFLgR39xyRusPIg2jHiIbf2dNCuRYSRo7LOGynls0rmARaJ/nq8A9QbdathWtbTYIWn1E/HK1muzGopKcPlbipDdm18ZCTdjuX6XuR1qchEupeSGhGDEmSY6gN9B/UB0tRj/B6/V6ZNU7US+C4=
Received: from DS7PR05CA0047.namprd05.prod.outlook.com (2603:10b6:8:2f::26) by
 SA1PR12MB8644.namprd12.prod.outlook.com (2603:10b6:806:384::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 13:47:47 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::cc) by DS7PR05CA0047.outlook.office365.com
 (2603:10b6:8:2f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20 via Frontend
 Transport; Tue, 2 May 2023 13:47:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Tue, 2 May 2023 13:47:46 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:47:45 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH] dt-bindings: spi: zynqmp-qspi: Add power-domains and iommus properties
Date:   Tue, 2 May 2023 15:47:42 +0200
Message-ID: <87563d1a920458dff134bb92b27645471f4d9fca.1683035258.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT062:EE_|SA1PR12MB8644:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d173196-24ae-4f88-d994-08db4b13cffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c/qWmYzJpRf6yhqCyFE34kU5t86ETE8RBKJWOz2H4Eqqt96RV+Ce3TN11BvtZY4mhc2LukYhBF37slpxDzGpShlA0wCtCNH3WHrTGCc8Hx0YvbwXarUq/Tjh8zeXVleUy4O2oBYTq0slhxiziodY/c6N8HSSJmfWsmSZ/+13Z7VXEUzEzIibAKGf7JGBZMhZ9GMJYg2i1WlZpmT1kt4primRQlKxFR8/wepMw+iGb5swYr/asPIdWLLwvedcTznq0dd22lj2vjXD0kH5gCWKMP7jFsVMiB6r1ttLPkUSexZtPiHH1pNk1Ht6p666PQ52gMIAPYG8noM30u2C7xpZLs6tp0jBvMinQPGZbhJX0hFlxStHR5GefM6sSM6fz+l2OsiholxmVR9PhW54UdKSdrIZrqRHHjk2qCLZfSN4wxDFOxYeL41TtGS33Fot+jx6xZMC7u+JnYtXXuuvbsBhBljWcYzrQ8Z0UdlLud1gEVZ06vwOv4HUoOkPgpxD6PCwYMY3gfV0FlY+xQcvYAxMqEoYdE+KVeIzWuX0/Zsy+b3MCvqwu5T0qs2PSh9kvUYG+rZLIjL4JYWPIrfldbFLFkzWHA8KftdDQHCkb6VyeBpKjvwatLF2b5ItClRfWHvX5Ajrvw9QUAjaIWArOcvYy2iQGD3fF/kQc6NpYLD9qsiN9BrulIz8K/2kQIN/ZFelrvVFCsmbR0xIHkg+IqDRj77HS82dnqLfMQD81MXG4vgdxw3NTCKhOqkFyNTC9RQD
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(16526019)(70586007)(356005)(4326008)(186003)(82740400003)(316002)(40460700003)(478600001)(82310400005)(110136005)(70206006)(54906003)(6666004)(36756003)(86362001)(40480700001)(36860700001)(4744005)(2906002)(2616005)(426003)(26005)(336012)(83380400001)(47076005)(5660300002)(8676002)(44832011)(8936002)(81166007)(41300700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:47:46.8257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d173196-24ae-4f88-d994-08db4b13cffd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8644
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe optional power-domain property to fix dts_check warnings. The
similar change was done by commit 0aec3958c88f ("dt-bindings: gpio: zynq:
Add power-domains").
And also by commit 84fa8f159022 ("dt-bindings: arm: coresight-tmc: Add
'iommu' property") for iommus property.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
index 20f77246d365..226d8b493b57 100644
--- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
@@ -32,6 +32,12 @@ properties:
   clocks:
     maxItems: 2
 
+  iommus:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.36.1

