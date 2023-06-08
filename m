Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0EC728027
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbjFHMgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjFHMgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:36:23 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4591FDF;
        Thu,  8 Jun 2023 05:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9UchvOOcMt8aCkttxuPak+kFyHjU+UjQY+3pxOQxzDhWPhGw7paYmU16MJ1GxlWQKnHpEDNpdpAd81y5LWMtF5FO7MpmIYt8tTh3z+PfvC2vLAmQx+7pUgI1Ua//9pTl2bN+tRygGOe5UR6vRv72OO2t9/qq2L5Sp9Ek7rBBihRQS68zjBgMLdelv+dTltG76Bg+0UTziUD5s+JtEpNFglw3Zu0D4Hd3sOYcTlYFy6WDQyqB/Xst/ImDl4m20DL6UlPdShfNVJgDbxfyfsGpkEVynuVxyvMCTAhGE156SraMkBCtKhlOMNGx94JBSFbsNvxMGxPr6w8x0dKGkirGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3gWYJK0yYKL588ks5lQuR/5RrLLl66f1Y9KQKDIQKg=;
 b=XlKYBLkBfrBN1MQUTK49Pp2lXeDs653qzMs7fG6H2nzHc8waiMOxQ4JUgNjW7xEjJ4bWi93bCVf+lFJ8Tu5pQu9UxWS7TCk2cFH8uchoHYJ5/WFVXiB/mXVWCOa6LEZ2IGsCzxiyqBz8FvsI/vN0PRevThkOA/XvEdu1gGRjAz0L9SqWLr5Z1TZCVJYyy8hvBoIFhERCskVEf7Xidq+p5KREK6WUjERaijAc1j3XXjKWBmj56HUNWyf4+7ezaXvLkq96Jz/daZBylB5p29wGzA45gHb/OF2snZICmLOkIk7E3UEEjVTEev2gbtO038j/91MY8ZqhliB+XFzoezlBDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3gWYJK0yYKL588ks5lQuR/5RrLLl66f1Y9KQKDIQKg=;
 b=q+dlX2awpWlYsWd3cTa9HIopABhUUdVxpXY/hPvl0e2UCPBrK+Nr6WoHTO0EJlEbqzt75FaGzvtbs9oyRQR4yycKTj8jkkMsMYR2OgRSuy3y+950HC6aiMR25RXv1wR7pyXR424MHuCLcRAhesrrKjA8SjEOVznXZiez2PRzVEA=
Received: from BN9PR03CA0649.namprd03.prod.outlook.com (2603:10b6:408:13b::24)
 by SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Thu, 8 Jun
 2023 12:36:19 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::39) by BN9PR03CA0649.outlook.office365.com
 (2603:10b6:408:13b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.25 via Frontend
 Transport; Thu, 8 Jun 2023 12:36:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.24 via Frontend Transport; Thu, 8 Jun 2023 12:36:19 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 07:36:17 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Varalaxmi Bingi <varalaxmi.bingi@amd.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Harini Katakam <harini.katakam@amd.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
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
Subject: [PATCH] arm64: zynqmp: Setting default i2c clock frequency to 400kHz
Date:   Thu, 8 Jun 2023 14:36:10 +0200
Message-ID: <3034ec006c8b11e025904d4cc2524255523636f6.1686227766.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056; i=michal.simek@amd.com; h=from:subject:message-id; bh=3NGA0cTWfVIaeCxH5zTnCQewHI5rUCFCkjzNc3PVVdY=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTG0+ZbDuZ2VF3aGKYSt1J78r43Ske+/Qhe+vPvhFLX0 jX3VOeEdcSyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJeNgyLOj4r+kc+b8pKqrw 7J+wgukvjtTMlWeYxZQ91efOS4ZaptqNE1dkF1zsXRIlAQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT049:EE_|SN7PR12MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d9a782-99c1-4992-41d0-08db681cf5ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TtwP1geVB1UzYqcNwKp3a5/C7wTyndC5gf/PPI84UrZTPMbIinq/zVMy3nd+5D0e3b7Ux1k9zroYRhgGZzGt8Aa6gCdmU6qRt1xPj3hYZI0yQYLqwTeo0NcWHssZpio7Wb8RVeCDFLqqaCf+vQ3RiQvU/QzGR4kgho79CcF3RYHA5O0mKTXshLYAz156D3gGJy1diOl+50HUic7kpAJ7C4n6Velkb9nWe+ToNJ1aj7LWL5lflALWGC1jMUUhIipJcKfT3d6o1SvojTbM7tIJYfHs0AahygQ6aHPdcDN9/WPKVdSlA66etbZRLNUuRaSz6wOGQzjDhaGgsHKLc+XmlvRbR3FiRO5wUBMC9XvSJmKR38ACqnPVxEqv3R7/VY6iV6kGoKvihJiua/7dqmA81pgd9HKv2Kqbw0Q6S33nEb8C1F9bFbDjwZ1TtQtq/OOj0H9cYEMXIDYfvVETo8ixDVcctM04zF/DbP5xhkDFpB26DCriKG/n8LMW6O1yDX2hNPBgxlp6FsLA5vjMDUI1HBGDl+utjLt5ZPYU7wEKBeIAJ2CoVIM9gT7GSWmeHWgzNsjKwKGkfjr/e3QdO0wAcKmOBPEM+0ovnfkuyEkZT1rnVySlW9NmVcy7VNFyuVlKQKIKBTif6e53Fw9oeFG6oGlKazCVgDAUakY4OySdezXlUJpNjPsjxhm1DPhqrKy3boCJRm31p2Ud9uIyum+pW9INcJaTJQ28b4fZ35XQuE14zxpUA4NRrEOx3uMhHlSG1xWrvJwRJWDR0Z1dzON4tpR2sF1fdrzDdwIyYP3sIY4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(316002)(40460700003)(41300700001)(426003)(336012)(83380400001)(2616005)(86362001)(82310400005)(36860700001)(47076005)(16526019)(186003)(7416002)(26005)(44832011)(2906002)(81166007)(82740400003)(356005)(40480700001)(5660300002)(36756003)(8936002)(8676002)(70586007)(70206006)(110136005)(54906003)(478600001)(6666004)(4326008)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 12:36:19.4478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d9a782-99c1-4992-41d0-08db681cf5ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6839
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Varalaxmi Bingi <varalaxmi.bingi@amd.com>

Setting default i2c clock frequency for ZynqMP to maximum rate of 400kHz.
Current default value is 100kHz.

Signed-off-by: Varalaxmi Bingi <varalaxmi.bingi@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 394db49ac6cb..675b88190845 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -648,6 +648,7 @@ i2c0: i2c@ff020000 {
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 17 4>;
+			clock-frequency = <400000>;
 			reg = <0x0 0xff020000 0x0 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -659,6 +660,7 @@ i2c1: i2c@ff030000 {
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 18 4>;
+			clock-frequency = <400000>;
 			reg = <0x0 0xff030000 0x0 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.36.1

