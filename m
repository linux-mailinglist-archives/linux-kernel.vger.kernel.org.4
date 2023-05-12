Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F233F700739
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240903AbjELLwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239935AbjELLwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:52:15 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF5BD2DC;
        Fri, 12 May 2023 04:52:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=day3KkZwGKo5kzwLyfvlkSl8FnBCFYsYQjSNs2Y1kIUc9ZAVDSDeO7f16dawu2sSyIEmwjKNBRsIuw9IMhsGCY/cmLZQNNs7KcM6awpH9miU/SsjwnTC4Rt/lrSmAjlT+/T/ccC3mQvD9PmxwKhwbSIbVZ20XWBDYQNYCuuXU4ZFKhtlEusi/yBHeU7ORdKkaflRU3yhzkl2M8ihjXj+hE/szR3f3fIpKi39DNZ+zzA1jVrqePaGgHkNWpp/VylvpYvZlUQwZ+Ck0d3jFv239bBrgJ8qOG2sUWIAEs75n0pUBp5CohvR7f3Wc8RUUUO93GVhKWNLvSVkR6EWz3NXJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mm3qIK3rngfOuXWdkkVOCxkBKbmp/tSQ/1cMJyHG4Ak=;
 b=JXFF5cLXQmy6427wr2InytgsQ6PUTW2Iv8nVHlQQFB7NEmwQKtT72gLmLESzoTKdVStKgeCiIiyIvMKoZJ8cQTmAdyriDN+40vCNk0oFyAHIay611I7PqJFYsetukwxi2ggAp39xNgiFbA1gD7BbGH62HjnixDMNdyAEj3FDZLoIP1ext6LPGP7aoiRviCZGi402Kr5jQCxVyuCbfsp3brc+0fVRO7kng/QNF7x0BgPHIwvGIJbt//ZycKJrqr20jYnAac7RqFK+LX6Dl/sZOzl87y/YgO8EThm0u1Pus9OQM0MbU1PlYDA/lCbJgd07tOzRthzwJyFs8RA/Jv65DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mm3qIK3rngfOuXWdkkVOCxkBKbmp/tSQ/1cMJyHG4Ak=;
 b=irh53By8iAln+dAr+RDRja3deLr/UsKJqimCNLVPEHw3IDJ16Eu/MTjZKzeQLAGbKB6155wjLT+Ncyn6O/SVISxHTW1AbDUZW0XurfqnYgDPyubKbdhylx2GsElhjQrpaSWiEW2FZTogKCMZUFMuiTMkynRymzz1KjP0AxqTmnE=
Received: from DM6PR07CA0050.namprd07.prod.outlook.com (2603:10b6:5:74::27) by
 DS0PR12MB7849.namprd12.prod.outlook.com (2603:10b6:8:141::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.21; Fri, 12 May 2023 11:52:09 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::e9) by DM6PR07CA0050.outlook.office365.com
 (2603:10b6:5:74::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24 via Frontend
 Transport; Fri, 12 May 2023 11:52:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.24 via Frontend Transport; Fri, 12 May 2023 11:52:09 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 12 May
 2023 06:52:07 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>, <dlemoal@kernel.org>
CC:     <stable@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH v2] dt-bindings: ata: ahci-ceva: Cover all 4 iommus entries
Date:   Fri, 12 May 2023 13:52:04 +0200
Message-ID: <de594534321417d25d2434db334db075524f61e0.1683892320.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=michal.simek@amd.com; h=from:subject:message-id; bh=lcbqYn8kOUM/9tTXRKSXbpQlbkOO+5I3NvoukU+Ysf0=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpQ4jYT8SZf1WT1D37QsnlctyCf8LHHKYt9lBen3nmj6a dXZsbl3xLIwCDIxyIopskjbXDmzt3LGFOGLh+Vg5rAygQxh4OIUgIkYZjPMD5er9lCPV/t1rZhr paVfaMX08iQFhgWTZh7lnTDvRYvgIRXXy735zf+vxz0BAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT058:EE_|DS0PR12MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ee4a0f-e9e7-4745-8f69-08db52df50f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EvYgpq2l+cIe9tjaeJXOCH3Fhu3lj8IOi792O9uMimcgSquJNqG2Rint5mpMgh37n5PiPnCH5T+sY3nnSjJjKshLCe+kYo+W4+kvxm2C4qnY+jOg3TLD7KGWnV+dmj2arApRg8kwXPYHMYJtbtIheD3Dk0C5kHCUdg+A2HKAHcM1WSHGXZD0CrbnjbTDSfn+8PMZP6UD5eA6q0H1Lhw1v7V3uNWbnJVysjZci9P62+KlbOlm3/BZqzFhDWqj8aECQ740YCQoX1rnehnLtPHF4SzH3AKfsrYo2GC6ohazuiJk8vQAOAEanybOkvgejlBIrVUxZyUAkiXtUruHQ8KxTgYAnSPeO4heL/xbAO+Kt8eiGQYRzvcWUvenKZ5T9r3BbPi+TuSRHm+YQTVuczUAkVwNdPQf9RqVgoAYe//yXEojXOLVNph5Gs1XSV86J5+4kuUxQ/qJUGaaxAOosMWUFEgJL41iQm3ml3BccHPucdlakzaQoKHdb2RzoE2gL+YjUlp8t9fZd/ud/7ixMfvg3T4Q8eX0UwRF4YJyj5w+FdBIDvYx0aeqIRA2BvITAtgRR9irKGymdtpbP1TLXxrybXiUW/2r9SoKgo9tbOqOkLZh1FWLrMApQ1RNUwsnnyworAlZGT9jsBVlUiuoGZfXne+SoMKZUr6sHs+rxadlJ4PTb6F7feHjNU9l3PEP4JeSlgsIw9SE3Oz6YGmzXE6jLmuEDiFNuB7f17spM8G+inONP47S61hd70ItdTYalE3j8ZjJiAA0rQKC57n1r/NXg41aQupnexm46tarBewsaTY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(36756003)(86362001)(6666004)(478600001)(54906003)(110136005)(316002)(70586007)(4326008)(70206006)(83380400001)(41300700001)(47076005)(82310400005)(40480700001)(5660300002)(44832011)(8936002)(8676002)(2906002)(7416002)(82740400003)(81166007)(356005)(16526019)(26005)(36860700001)(2616005)(426003)(336012)(186003)(40460700003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 11:52:09.1927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ee4a0f-e9e7-4745-8f69-08db52df50f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7849
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

Current only one entry is enabled but IP itself is using 4 different IDs
which are already listed in zynqmp.dtsi.

sata: ahci@fd0c0000 {
	compatible = "ceva,ahci-1v84";
	...
	iommus = <&smmu 0x4c0>, <&smmu 0x4c1>,
		 <&smmu 0x4c2>, <&smmu 0x4c3>;
};

Fixes: 8ac47837f0e0 ("arm64: dts: zynqmp: Add missing iommu IDs")
Cc: stable@vger.kernel.org # v5.12+
Signed-off-by: Michal Simek <michal.simek@amd.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v2:
- Added Krzysztof ack
- Add stable tags reported by Damien Le Moal

 Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
index 9b31f864e071..71364c6081ff 100644
--- a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
+++ b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
@@ -32,7 +32,7 @@ properties:
     maxItems: 1
 
   iommus:
-    maxItems: 1
+    maxItems: 4
 
   power-domains:
     maxItems: 1
-- 
2.36.1

