Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FF2734C73
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjFSHiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjFSHiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:38:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2827AB1;
        Mon, 19 Jun 2023 00:38:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1+xpbZj613L2YZNxmoPM6dj/DWHmP/toB5jtQgjswQ3Zk5QOKRumNYoewIh4G6s/uk1KFpr/e8ilOizvkTGWe32LZLhdYFi1IlNXcX+N5EaWadJf6ZShRM3l/ot2RLlvLqPWqAKfCgO54O3JeuCI4MBLQ8s+KoW2KcK1hpW/EUs6wlzr1+Uqcq+nX0mBoCATFdvgLSC+EJlSxgz8vnPYrOJhlrBSl2/ixnXaGXGlxlhfHAa2LUyXxWbBJ8pF6KN4/jKwJkSK0m19txmnnvfv+dBKEccXKYo6FkiGqnoWQIRX6ATPD87dNo1m2ToyNziMCJJOheoRNoE+eaPWHznoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsPx8e+37eZbEZoPzXuk/kJZ1fBjD2xe93STSdVfqik=;
 b=lwZWxlYZydOGjgCQQLAh3cysFNGUVwgXWrlr7cMwa6ACLp5xKMattUmhpm+DBJYNdpV2g5Fgr1umao1c5YMqNlpsx6gnuLENk4RCemBPi4CGWei5VNNxUj2U7x5RvSMUCsXSAuZTqv5LMMWosJRvTu1PCeQgBeXcFSPlryQYd+nwHWkoLzUlOdurwWN+c558/OrTdbXwV9mHVdnqEdVQ5EqV65Nt78RH+cWUJhh4Tb6cjef0tl+9jCnPUQZlJdro1ORTSd0u9U7bARgAfbRrPYeh5ubrrjPPuUOhfDh+il671dooh6JDOinchjnv05iwgb1DalxhqzgwmnB7NaNQpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsPx8e+37eZbEZoPzXuk/kJZ1fBjD2xe93STSdVfqik=;
 b=sKjCKxde4lACiB3YVQj2QhhbzwonaboLKedNtUgRmceAkkcMGaCNMG4A5xx9QqZrGmcTttMIO3BJ+BwLS6lFQPTkhlI6VeP587SHPZpyTfAj332RKnxzPgS0S4ISoMeCe8U3JtBZQpOUHEBxFGzMlHclirp29t+V/X3nOVQ62jE=
Received: from PH0PR07CA0115.namprd07.prod.outlook.com (2603:10b6:510:4::30)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 07:37:58 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::35) by PH0PR07CA0115.outlook.office365.com
 (2603:10b6:510:4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Mon, 19 Jun 2023 07:37:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Mon, 19 Jun 2023 07:37:58 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 02:37:56 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        "Piyush Mehta" <piyush.mehta@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Robert Hancock" <robert.hancock@calian.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: zynqmp: Fix dwc3 usb interrupt description
Date:   Mon, 19 Jun 2023 09:37:54 +0200
Message-ID: <6544d13afd9f3d8f5413e32684aa16e4d155e331.1687160244.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1601; i=michal.simek@amd.com; h=from:subject:message-id; bh=mohniBW7EzmVobHdZACv2HCOpXxuCoB4bjAVLwnZ34c=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpQJrFsfXGDJFQw56r6Hb4niDL7Uba56k1W5s8T2717Bl fTizKLcjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjARjU0M8/M773vcrq5oP8/x nZlvRfHuv5u2PWGYp5C5SmpR4fqEquhZRWtrCpQZ1F8nAQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: deca9c56-652c-4285-7baf-08db70981a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dCVHBPeGkKRyuiM1BUXMkSDmyRubXupAHpobWtrWhvSRsZib/gzn95ki53OLTqY+Zn1Nup3X3gZddEmIjiAFQEzwdw0xqhQytgyh9jz54XkPySkCgwrocpJQFqgBvzeHcxI5kaf7G5lsblonw6kxVvGLDIsJYFcqnmiKW+NZYdDsZlL8xEh9Ru3MdREl6rjqxZrAubkMpqu1/aLsA7HmOY45EM3WbA0DXSTeyXf62VllDtcBixO94zbbcwGXWpqC8tz5NiSd0FPVU9wTHewq+6stuVqdrkIKCDNLuOEcqasOLBUHvZAgXTlW/wXA94XSI1gcnKe+RaorwaVLte8MdVeRLHkFcnrr2TJIb0i5nNhQ2HHF5ts8wQhH6sppTZHCIcnoQ4nflu1ptFzdlC+clAW4Hh8TsCGLAWkWnWS3RiqYBqHOfcTxJ3ws0IbvouyIGoaCPnyryu4ySYsL8IRvVj38EChe9wwNkVzlyAYNYt4P3YA6tLvIQU9Ck2mlZ/r90obnXvsGCRpaxBXISFfKgvNTrC6OvhL/Xreybw/lVz3vkCprbjDTiSGdzagr0ohPlQabpZ1FyEtn8jM/kNdXNI/LQqo21CX/JL/dHZTO1Pe74Z7CeHTD61DsOKvFgMeRswZ20OK09rNRqQbe/4HON4yBfHbihB8H9IncCPrfEOWpLS/t61eQ0gwGtkj5FaU/cM+CpSD+d0Zyl2mtktcX8Tk4iTWXDavVD47apQhJdp3LLdeG2xnKTSPhIeE4sqTLZxq3ldY8b0UKqaW0UKLSDM3DoVJoifrurWEbx+QfgQk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(16526019)(186003)(2616005)(26005)(36756003)(426003)(336012)(478600001)(83380400001)(47076005)(82740400003)(110136005)(54906003)(356005)(81166007)(36860700001)(70206006)(70586007)(82310400005)(4326008)(316002)(41300700001)(7416002)(8676002)(8936002)(44832011)(5660300002)(40460700003)(2906002)(86362001)(40480700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 07:37:58.4465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deca9c56-652c-4285-7baf-08db70981a81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on DT binding dwc_usb3 is single entry without anything else. That's
why combination dwc3_usb3, otg is not allowed. That's why split it to host
and peripheral pair which both points to the same IRQ.
DWC3 code is reading these two properties first before generic dwc_usb3.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 02cfcc716936..e8104ffc6663 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -888,8 +888,8 @@ dwc3_0: usb@fe200000 {
 				compatible = "snps,dwc3";
 				reg = <0x0 0xfe200000 0x0 0x40000>;
 				interrupt-parent = <&gic>;
-				interrupt-names = "dwc_usb3", "otg";
-				interrupts = <0 65 4>, <0 69 4>;
+				interrupt-names = "host", "peripheral", "otg";
+				interrupts = <0 65 4>, <0 65 4>, <0 69 4>;
 				clock-names = "bus_early", "ref";
 				iommus = <&smmu 0x860>;
 				snps,quirk-frame-length-adjustment = <0x20>;
@@ -915,8 +915,8 @@ dwc3_1: usb@fe300000 {
 				compatible = "snps,dwc3";
 				reg = <0x0 0xfe300000 0x0 0x40000>;
 				interrupt-parent = <&gic>;
-				interrupt-names = "dwc_usb3", "otg";
-				interrupts = <0 70 4>, <0 74 4>;
+				interrupt-names = "host", "peripheral", "otg";
+				interrupts = <0 70 4>, <0 70 4>, <0 74 4>;
 				clock-names = "bus_early", "ref";
 				iommus = <&smmu 0x861>;
 				snps,quirk-frame-length-adjustment = <0x20>;
-- 
2.36.1

