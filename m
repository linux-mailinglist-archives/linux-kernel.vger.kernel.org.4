Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238FD6F458F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjEBNv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbjEBNvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:51:53 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457131A5;
        Tue,  2 May 2023 06:51:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMIGCCw+jCVSuFEChHKO4xxSpopZgQQknKhkzeFfNa5lIUlzWzlzJkN+8ZuakOYFn/KbBaQSa4R36iYLHrM8lhqO3AXebia2JmcmJzKul/S43YiHb+60aTJajsdzoaas0voLTGvUvsSyypgwyaqQDo59qcE8l6OoRi0yT41WnStQ2vnqRLQfVwJcpI/MXjtYTgaJP7Gdf3hRKYwoX0yE6VuNU3Zz2UULXuOA+z57EQiFfi0q7nibf1wpNsA6ndDigs+0ScNow/XHwf+Uj6UCQPnRFjrwCsxlsxdKoqfyW5WmxUf6vrYjrSn8pQ80beWa0kkFuGkXd6/Jq6YMr8iHHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfOVT3SDfVdzbrHU0EHFmB+Pxa2yYan6KdPCeKqGbdQ=;
 b=TCTjyVepfFXIeAX4wAZ20donT1RG9BT782lx4cX4k20wXYZ9O79F2174673nN8uWtGfPw7qtwAjS4VjvMZzZcfiX2m6sqdCugq12+fHrSMuDX6T37/EpvBFGSlBoga+lwE/tKH/auoWSA8WsUmM75+a/7i2oxg8kphRENMUofrgx8d+Oud/XnuKfbFiSG2JfbpS5qkp9ZsslAd2o+q4LAgRvd0djEqMAAsubFqtRSUFwVlOW5EjNxaZMz44mgY/lBtYB2J/oOfa72qB1H0qXe97kd05mtYTakuq5/oe4Kn6R020H36YM0iNd0a/3HG7t2IeDNHs7EHSWNa9OtTyVpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfOVT3SDfVdzbrHU0EHFmB+Pxa2yYan6KdPCeKqGbdQ=;
 b=M/DwLSZtpOd9BTCTSo9cjzYEQayhgPaAQhZ7wcfJrsK0kOqnPDNGvhFHt+LnH3JvzJwANFR194MUZV1xubKkhh87OIaDYTHrBl5PKHpqqbFWdFwhQMuyhLMBv0qQfT7myODzIDW1sbhW7sUTRk7X82x5RCvpzrludZH+gsJ0OjM=
Received: from DS7PR03CA0083.namprd03.prod.outlook.com (2603:10b6:5:3bb::28)
 by MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 13:51:44 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::67) by DS7PR03CA0083.outlook.office365.com
 (2603:10b6:5:3bb::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 13:51:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Tue, 2 May 2023 13:51:44 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:51:39 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Robert Hancock" <robert.hancock@calian.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] Revert "arm64: dts: zynqmp: Add address-cells property to interrupt controllers"
Date:   Tue, 2 May 2023 15:51:01 +0200
Message-ID: <e3312910db0922bb8c24a8e681de41709ca11bdf.1683035456.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|MW6PR12MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: e535293a-87ba-4939-a253-08db4b145d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAWaJhIg7EyEWvwFvQec3ycAf2r0nFMaPtfA6IKO94zT5O2yYFywmaOy62mnz0eqEwjk9PHWc0FNm4GXibe/l3ljDnVatxKoLJiHmDoaMYJf1BxjCJE1pkhr+ijQ2uSCSlq8A/bZ757pRplhUFKp/RBbB2KNuxi0bt1X6OXAnDivW9S5OfCryxusyPLisORuNWD0SiRYX15Y9QlGeB0aamCQIIpfAubmfCQf2oFSJHhQpQ0wekN6KC8ePFm/baU4lu4bsWGqRkAjFIz58ju4vctCNvrz3fCqxtefcbXG5T8T/CMf/pMxvFRBszD3g8z10vsDeGtwHH4xhsNiRn47oNGk6c4Met+48xE2+ZjVI2I1uTDzlfXsfuJbqX0P2+gp4q4YAE1fpKMRKsO1yrzCBq8UYTVerWhsawJ5RB/3fazwyNQu19Key4FmfNrP7cvb1K5JM0ny50uPlLEzT7wFq1EZyjXSGyZUMWWtxuP/ON9yqCxvRCMBCokngrukfl1RDy3VIhGvbu2uXLcU/X86mu42NPLmj/4FvpZuc+QZgtFqYKb9b+a5p+MtUxc87Pw5E4oIMRBL5t2Sn0CJv56eOC5+KAgrkjTyWiHven1NNKGFKmEvPrtVPqi7W1AU7DXosS6/C5GaKSgxZfILyui28BIWEiqaqxy0Q5ch9ClXPipYQPm4+rLPEIFOfrN9IxX/bzPKkPoVuojTQzaxOd4zndRpJu5u1gL+NlGOMFsV3Y+4ZrykvQqig9t+goSVhcvO
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(36840700001)(40470700004)(46966006)(36756003)(110136005)(478600001)(40480700001)(70586007)(70206006)(54906003)(4326008)(336012)(6666004)(2616005)(316002)(40460700003)(966005)(426003)(26005)(16526019)(186003)(82310400005)(2906002)(8936002)(41300700001)(8676002)(44832011)(5660300002)(7416002)(81166007)(356005)(82740400003)(86362001)(47076005)(36860700001)(83380400001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:51:44.0384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e535293a-87ba-4939-a253-08db4b145d61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c6badbd2d321c19d4f55ee56b0ef12bb3352feac.

Long time ago this was discussed with Rob at link below that there is no
need to add address-cells to gpio and interrupt nodes that's why reverting
this patch for ZynqMP.
Also there is no visible DTC warning which was seen in past.

Link: https://lore.kernel.org/r/91e3405245c89f134676449cf3822285798d2ed2.1612189652.git.michal.simek@xilinx.com
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 51b8349dcacd..2d564ba7e9e4 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -419,7 +419,6 @@ fpd_dma_chan8: dma-controller@fd570000 {
 
 		gic: interrupt-controller@f9010000 {
 			compatible = "arm,gic-400";
-			#address-cells = <0>;
 			#interrupt-cells = <3>;
 			reg = <0x0 0xf9010000 0x0 0x10000>,
 			      <0x0 0xf9020000 0x0 0x20000>,
@@ -633,7 +632,6 @@ gem3: ethernet@ff0e0000 {
 		gpio: gpio@ff0a0000 {
 			compatible = "xlnx,zynqmp-gpio-1.0";
 			status = "disabled";
-			#address-cells = <0>;
 			#gpio-cells = <0x2>;
 			gpio-controller;
 			interrupt-parent = <&gic>;
-- 
2.36.1

