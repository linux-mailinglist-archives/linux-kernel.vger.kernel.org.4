Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816F76F4595
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbjEBNyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjEBNx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:53:59 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD38E9;
        Tue,  2 May 2023 06:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBsvAIvmafHE/efn0UwlLwGiW8jDB2WE2EuyZBLqUGq0XrAOJMV/aM3ny5SldGElqg+4rQvVZmseTEO3qF05wNYwdsnJab8UOx1bvrIoenCzDe/vxmf93Q4PMjlfM/cB2QmT/ND3Cs0+74m1qwqvW/RPrxOhppzIqj3saT/998XOevAvLEhb1K87wG4vJGV4P/EC+S00ELLrSlCdI4rR9rTpn4OGoF+P9RIDtSQeqCqE3qdUrA3U0vG3uQH8flZaCayO+5GCc+eM55FJslAjJ4ZVTNLT4qyVgrcBGtCFE55S2qLrKV9/xJNu9/Y6sLiLjWKAbs3F0k5lp/66PiZnKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y35OiaIke8BzC7ox+rDD+4ZtSNoW0nj/JbGbGsk96Is=;
 b=mHPOd73braktkqmZBT3YLTAbPFdG9P96pyV/2lAwYxCCR+IIF46b13QVmo2x7O1oDKoLW4swJymQe/JFX9MjJtgRed0EHvLB5rpAjlAADjkIh0pVf2jGUN7TELr96PtrJ+chebh/YTmaMUK1Y/JCy0QDeSXmGREj9QT0NYQHh+pMnKI6j8aBZScvj0nuf5Kf1H3IZIYq3PwOhMU+icW5hxRA+e5qyswLvo3r1owGrHJKQEiXTXrv8gbCKtfg6MMwTXoDi1F2/0g3zUrQaeeGXLYx7xn6TRxLHsyCQ8zCFw4gYhReec7mqF02q+AgZeoYmSRd+YKNElhKh1T+xAgtjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y35OiaIke8BzC7ox+rDD+4ZtSNoW0nj/JbGbGsk96Is=;
 b=asbIVCaEcOecCRQP/+rzF3vxgqPHkTtjhpMIyVeNQ09JOkr/b5YMZrcTS5ElLe+vOkAwydZDkq6c7L3Fy0Px0xKPoXfANIlrSY5/+IIcjU2sHnEpqnEe8MxqsHqzkc3cS9hri4ele7Jm7fp0zXXA5WYa8QKnCbGOQz6H4KNc3bo=
Received: from DS7PR03CA0182.namprd03.prod.outlook.com (2603:10b6:5:3b6::7) by
 SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.34; Tue, 2 May 2023 13:53:56 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::af) by DS7PR03CA0182.outlook.office365.com
 (2603:10b6:5:3b6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 13:53:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Tue, 2 May 2023 13:53:55 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:53:37 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Varalaxmi Bingi <varalaxmi.bingi@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] ARM: zynq: dts: Setting default i2c clock frequency to 400kHz
Date:   Tue, 2 May 2023 15:53:35 +0200
Message-ID: <4dde5d1eb8e4572dae4295a19a4c83002a58e5da.1683035611.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT012:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 28531aad-25d5-46ac-a0b7-08db4b14ac0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IU1KmrWyh3y1mn9IJyR1QOeEQusnU6x9TfqMv6pGY5WFMqW+f87YaIsXh+NolI/AhLug2G9y6sH9/4p39V8b1cleCZPH2HYezZFKx+HI1VwJJelFcTWCBkEo+GTUoHmxz4i/EK4QW6uQbHGednzG7vIUVZ1gW5x7gYr0Zr94y3t7276HYSExE3UjaauMxot1YzzukZxTOvbGP6VGkV9K3z9vNeX5VIfUQ/C8g4nVlNitaven16N38IiTPkSg6E0+fxo/7gv8PryXkoSU8Y+WRyRqv4Hlq35ngZg5fk/4jX45FTtHuf4cbOAvoREMFfGwEbLnb2x7aCQkf7X30iUcog/vdWn++Kl7kSynYbNGBk6ZipOMOUj5N0QRWnMQggMVlkEXJDjI6+JttUS4u1JFTHJoBkzmpKM7ZKpqCtwkzEJe4bXyqZjb4V9Vk0u4FynIf4hWCFn1gjlj7+dhMSq5hUz1QEZSfyK98fiGTPo9E16QZq+ifnqNVrTEw8UslHQrLeXzuIVPA2m17jVe0l7po5/SM70y6ksUjVPka0EHZFrQ3JTfnUIzzN4Lz3pCh5jw780fSbBhpHaaiBPBVrsyX8IVzVkEor6WIxjsunjFDZ+5QDDCLXJth2FNucn5QwiJAYeaA1rtpe3jfsJXQHb7S21eMOEbAEKMdCHNM4BYkk2c278lgBXy9fLlqSk3IvJIH08NSPefpkMutaocy4ICgkgG+uY288NZ3f7H89zEvCqgOpRQbpJrTHv6Hh4iiEdm
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(426003)(336012)(2616005)(40480700001)(82310400005)(26005)(186003)(16526019)(5660300002)(54906003)(8676002)(316002)(478600001)(110136005)(70206006)(4326008)(70586007)(2906002)(82740400003)(81166007)(41300700001)(356005)(36756003)(86362001)(83380400001)(36860700001)(47076005)(4744005)(44832011)(8936002)(40460700003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:53:55.9629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28531aad-25d5-46ac-a0b7-08db4b14ac0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412
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

Setting default i2c clock frequency for Zynq to maximum rate of 400kHz.
Current default value is 100kHz.

Signed-off-by: Varalaxmi Bingi <varalaxmi.bingi@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/boot/dts/zynq-7000.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index cd9931f6bcbd..a7db3f3009f2 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -149,6 +149,7 @@ i2c0: i2c@e0004000 {
 			clocks = <&clkc 38>;
 			interrupt-parent = <&intc>;
 			interrupts = <0 25 4>;
+			clock-frequency = <400000>;
 			reg = <0xe0004000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -160,6 +161,7 @@ i2c1: i2c@e0005000 {
 			clocks = <&clkc 39>;
 			interrupt-parent = <&intc>;
 			interrupts = <0 48 4>;
+			clock-frequency = <400000>;
 			reg = <0xe0005000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.36.1

