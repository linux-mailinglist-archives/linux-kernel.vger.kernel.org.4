Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA346F4522
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbjEBNiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbjEBNhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:37:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130CD1BFE;
        Tue,  2 May 2023 06:37:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHcgv7ydSzT91DXSn7/dwc81Qu31tO6p3hRUF8LT+ftv5Ax6QiPHNwEUDMhOr4HOpEB11h2zKAilj5t34sVPKhkSAJ5z2yRHBbvKR/NGv1OuzLWtCRWspI+MRqNseHX1UQTbHxoQfPmpwsQkRlbbcJBPMqcS976VHxZ2Bha1aA2QcZDxx/1NWB3rT6Vh6yddW+QW1AMcmCXanPouUf38DgpDz+VTCCvPh284D0Xdx5GECGtwjyE+fCfmsDNspYSJNdEGeQeG23Z7TPl6GVtSZW1e3CxX2dcWv1LFNYXiO2nZpCUplZmQM7ALdKcp8/ugM45vD8FCvo53O2PWKE7h8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHZE6w/ntG770sHjG88RMPMVbPRfBcd+whTzcpKQI94=;
 b=FSyrDK50Q3JEfKCGHSu+fJXLBd7l2k4yalIWygM3UU91NMp5jxpJedeS5+NfgeauwZZ7Zgaix5E0dEyokE8j2pW0jP0zkwtFGl2l22vgpyeLoUN+2xif+hRHVjdK9fsX4yFE7b/qHyf1mButJ1+EZTaZtx5+n2vIs4vk8Z8R6T4VX62dOaiH1Ae2PDsRDyx+Xvcj7yz8C8KqEkNsQNtfu9b5LXz5fV7rAt6sONFtiSbGhYy93b4NkJOxXD9powlYNsRf88LFn4/enWy3jMsl28EsdHyLpb9FaU+oI5DaX7znG4UJtCH1Sut0A+45L7TwurMHzKU36L5a4tBdzsERkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHZE6w/ntG770sHjG88RMPMVbPRfBcd+whTzcpKQI94=;
 b=cPGaDB5fTZ8rWpf98r2isn2RYv2ORSm66TJ4WDyYWQxIsJx/ZusoFvbCADtURxb/brbUJRLI46L8H/PyDuiqJcGubn/8jiQ273k1l6CXMFnw2bDwv61ZmoXB2N+N2ZWfN22PEEhWQB3ihosRWnyOuOb/x3nIQZgjnffVfFf72fU=
Received: from DM6PR04CA0027.namprd04.prod.outlook.com (2603:10b6:5:334::32)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 13:36:45 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::eb) by DM6PR04CA0027.outlook.office365.com
 (2603:10b6:5:334::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 13:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Tue, 2 May 2023 13:36:44 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:36:42 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        "Harini Katakam" <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        "Radhey Shyam Pandey" <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 08/23] arm64: zynqmp: Add resets property to sdhci nodes
Date:   Tue, 2 May 2023 15:35:36 +0200
Message-ID: <8f8592d6454c024c8f8b92e56c9009c65ad1d54a.1683034376.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1683034376.git.michal.simek@amd.com>
References: <cover.1683034376.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT044:EE_|DM6PR12MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: 24256c72-cbb6-4926-3cf8-08db4b124511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qizz4p2zP4jR0kn+N3dxcumM6GLRPoAlvtZSR3iAPp8h85BxEytuEJo5U20si59502XbjwcOjyTaw/s+yqfWbJFgUh+kmKwiaiyKv0hHzQqGFQ/DcRFuiD729Wt4kAoyIpERA2jYM5efVmMlr7zjZvfx21tsI7I56wwoOCkmEtg1xqH80FhHIO8a2yQmQ8Dk2QAnliJFXpqq1fbWsIAFE5nqDy+o6bvEHf3cjZiQaCr39k3GWpMcPh8y4w/8zsZvThr9BOAcGOCWfXYmI8enCozp4H605Oh212rNXFfVrEJTrRsTKjwJCdcS+TKUlExlcjujWujcoaqW1CNj/mIZV7bY7yKqw4csdcXHIV/wPT/+YjPsRgndOOMffhOfSqHkRMQIgSXl1Td72e/9WBmHUl6lk8cHWmya3qUbNlTn3Hnsdnfeh7Io9Lmc9G3PucU5cOLJbynbx7HUbLy3lZ42HlC5G8LpqWQj1Rpm3G+FGjz844a8DMu/MzqHq+ntcJ+ChIAeMHpxrlLmDVGWdp/TezGr2/wOgz35szN9Oar0vA/s4nWUgQxZmH3i68SgQAqsO5ZcwKmVLsBYBJ4q0XUqKnWdTBqFGhFr2ku5r13Uh2/85BeKb8t6BPmVaadVMkXG/PkC3O5i+2ILdbscvV+z7oHXcwH5t1D+dh7QAwR9D2EmsRt3ienYExzUYPbaj0l6Y7PvlpmeViRxIYqqtCwEmqWxRugObD9t4re8CJN9f54Fb9w8vQyC5QLgh15FsIrr
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(2616005)(41300700001)(8676002)(81166007)(8936002)(356005)(36860700001)(478600001)(26005)(7416002)(83380400001)(44832011)(5660300002)(4326008)(2906002)(70206006)(70586007)(426003)(316002)(82740400003)(336012)(47076005)(110136005)(16526019)(40460700003)(54906003)(40480700001)(6666004)(86362001)(186003)(36756003)(82310400005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:36:44.2528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24256c72-cbb6-4926-3cf8-08db4b124511
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>

Add "resets" property to sdhci nodes. Resets property is used to reset the
SD host controller when dynamic configuration support is enabled.

Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index a117294dc890..7bd3e816226a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -755,6 +755,7 @@ sdhci0: mmc@ff160000 {
 			#clock-cells = <1>;
 			clock-output-names = "clk_out_sd0", "clk_in_sd0";
 			power-domains = <&zynqmp_firmware PD_SD_0>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_SDIO0>;
 		};
 
 		sdhci1: mmc@ff170000 {
@@ -768,6 +769,7 @@ sdhci1: mmc@ff170000 {
 			#clock-cells = <1>;
 			clock-output-names = "clk_out_sd1", "clk_in_sd1";
 			power-domains = <&zynqmp_firmware PD_SD_1>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_SDIO1>;
 		};
 
 		smmu: iommu@fd800000 {
-- 
2.36.1

