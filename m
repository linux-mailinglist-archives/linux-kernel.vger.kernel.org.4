Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4C66F5301
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjECIUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjECIUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:20:50 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A1C4C11;
        Wed,  3 May 2023 01:20:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkAjBk/Gx6hBGN6oub0rIuxkmhDv+lxL1kEDoSksc/CqIt4S+LXW26QV8QrjTxVRV8cbdS4Q9kR4gp+1aih8uk2NtqiKPkfvGQRqbiNVXReIeqIfLWxROk84A40kNRViLOx24uqo1wVHgs6aHJu0C0rU7we9EWcAX75JO5J/S69UOsa9eOUlzP8Xws3PqFMzf1KqwTYwimnI47lJIGglV1GF7FiuDWpqGaBalkwRs8Ucnbhabd4JXG/DbfD6FV91rHTYfAcFc6XQanD/Qhj4HCylfN5J0qK/7gxku85NWpPvBCVYiETX5UYalOevp2pOawuaURxwbk7/LD1SOHQ+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvqAJqqOUwIYhs8O+Y/vEmh5LfIoU9uG10gu+3Pl07U=;
 b=Ni6HX0XTG+TwGSFdohlDWpW5wqRz+dKoNEeyN6ZHXUaa6ssjBk6EyEWigZIPNfHIiObBvNgRYVAd4y3eqLWscxaXyBp9VTBk9NR8ynWkY7sOfRpPuz6hBja2Yt+dRF2yVcygtfDM/gyiXsdDMCxhvPnTxnAlZ7wY3VccZtyM7FXc8czf4HXOqBDT9XqxjlEjtj3GB+I102iObfWv4Ttsd7EBZjUkXx4Hfjm2XvgE7J20ZmyCjqxCC9qmXedAZz0cJy5nTZUlPLjKurWAQZtV5za1jCDIwAbtUWopgXKFeug/km1/VHcvuY31lU9kiE1vQGuZPoqfaelGzM322fDKSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvqAJqqOUwIYhs8O+Y/vEmh5LfIoU9uG10gu+3Pl07U=;
 b=T0YZOeE0qKungkSNNi1zF8/XbiVtMAZzlnhDR2ogpuKWFB9cogSjc+jKJlFxy9MxGsoB9opBSvjfF/MHubCGR9luufkkHaLgfxA7x7XMz05pH9LpKy/JfL6NiuoiD7be8Ks8ssI1VCVMgteladvZtU2cIUkSFjI0vLzJ1oN934M=
Received: from DM6PR12CA0011.namprd12.prod.outlook.com (2603:10b6:5:1c0::24)
 by DM4PR12MB6544.namprd12.prod.outlook.com (2603:10b6:8:8d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.31; Wed, 3 May 2023 08:20:40 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::4e) by DM6PR12CA0011.outlook.office365.com
 (2603:10b6:5:1c0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22 via Frontend
 Transport; Wed, 3 May 2023 08:20:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.22 via Frontend Transport; Wed, 3 May 2023 08:20:40 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 3 May
 2023 03:20:38 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v2] dt-bindings: spi: zynqmp-qspi: Add power-domains and iommus properties
Date:   Wed, 3 May 2023 10:20:36 +0200
Message-ID: <2afed7285061abbb5d9ad3b1e795b737dcff9693.1683102032.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT028:EE_|DM4PR12MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: 650e47e3-a897-4b08-1b21-08db4baf4806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nMgyN5U7G4Npz5uxb4FhjJBd0CLije9jizG4PIIIeQKbsQRbZxL+T6++FINitLexvF6+mbbuNAHoWqGQm1SdcjCc9G+Lg4CZUrwqKrGuem0VAzHDeatw/igJlNouSPmww3nwmo5GMSARQDuE/aEjei7nKsds0hmsm8kMnhK2PxLILbXz6qY97NVevX53IV4KbhuKo+seJOTcJhri8vzbHqMP7TZQT4UZS28UmAHxwwpdwGsznJ16jFZEfaT6NcW7pmVqKfcZEDsz9eFl4//4a1IwNJkUDvzDU3wdni6ev75EcanCfOEfXuC22JeRwstG/1UKPVcFJPL47kNWcVLgPtztug+weoTJmEkOMhZPXBYzgIuSCbgvp4gj/SCxTWKcPzZuglM0Eyfmk5Qjlbx19jlUCuOgVx4DcH1EmOoePfLCgZVjWlwL4tTBtP5haa/64aQzhJ+kDMYYrKTjqJUpAORE/YyOYXQ//k4IPVXXwPltOow0zkgIb+GVWbVr6SqqAHYb33VrFBMgD7hNMNnPHLFaPsc8S/SwZqFA5l5aeYRnJf0gJ8oTO6xVjHgmxJFkYU7pqjnqSPjnen3GfzZNoO2YhZcOhTZDSXwVRlKUuoSEGCyzJQGiikEkQZ5WeQJFVOjF2Hi005towiIn+z5WT91GS/58TYJ4fPFZACDhzQ0bklg1kQ3WgCHZOHyOGZa9BpoAUyqhZYaTcwuOT/T+GKHQb4yZdkuVh0qD0ylXbADBxdeZMZ/4r/8CIwwBJtSJ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(41300700001)(83380400001)(426003)(336012)(36756003)(70586007)(86362001)(47076005)(36860700001)(5660300002)(2906002)(316002)(44832011)(8936002)(8676002)(82310400005)(4326008)(110136005)(54906003)(356005)(81166007)(82740400003)(2616005)(478600001)(70206006)(16526019)(186003)(40460700003)(40480700001)(26005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 08:20:40.1995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 650e47e3-a897-4b08-1b21-08db4baf4806
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6544
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZynqMP QSPI IP core has own power domain and also iommu ID that's why
describe optional power-domains and iommus properties.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- rewrite commit message - requested by Krzysztof

The commit 8ac47837f0e0 ("arm64: dts: zynqmp: Add missing iommu IDs") and
the commit 959b86ae37c6 ("arm64: dts: xilinx: Add the power nodes for
zynqmp") described these properties long time ago in Linux that's why the
patch is also fixing dts_check warnings.

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

