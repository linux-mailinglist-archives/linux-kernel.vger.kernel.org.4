Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0076F4529
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbjEBNip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjEBNiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:38:13 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3AB6A68;
        Tue,  2 May 2023 06:37:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwzuoI0wFWd5QKBvms6wFpRunCtYg6Bva7qePcOhN/yV1c05hay1f+VryDjCjHkTZF3fGmWbex+l+GbVtAIWjnsrnrYi6f9w7jEjZ+uK39KIpmCUanvVl4E4oOUlJRTdwAQ3RNeoRf+t06x0XwdF+cYqIDzBqHHExcU1h6ccAIdHYogwTjubL+9oyLao4vDjgFR5lfBnjHlo4KvoMFhgPM10cU0vv658G3HSknXGwssCKVzKK4UCEFeW+GM58aDhfi0Uqc0pLjQDuSrEH7qIVq65MOiTyPirWOvkRuA6Z8ttwdKvXmfo3YA9qjEvREcN9joIDhipepFKjbVvLX8PZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQFvyoPSgfYvPEEleHEK5se76uHOKDoGyolMGYoZdD0=;
 b=c98e+Nj2iKxY6iOqgPr9B92iKYFEe63j53Zq17VOBN8ygeTCDFW3zdMDvAWKvrwizyBorzPyk4R1JB45RPUhAcEIyCj+cQ3TZ9hn12p8w5q7iYYFYMiCLa2tnmf5RmFK1NUtky3Da4YkqZZM5J/oLYlbCOcMZ9U3+XrKoI3k+Lx30IFyZHcWqVZ81Dcsdi8Q2kzangYE9Zcbw0rj6z0ZUDs+FPE1VzSA2LVff6c/f5PQ+FJY3+lL7ox4Tm33Q0KkslKuLNPnZ8jNUiyTjA6AQfua4EQcOy71aYzE+1k6VBIT/WvO0CnNQ+ZLpMnv96xmcVjGCvU5CLWP1CsrRORB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQFvyoPSgfYvPEEleHEK5se76uHOKDoGyolMGYoZdD0=;
 b=ncW2XnNekOfoK2orkmU9EbN4nw31UxexQ/947xogzaXJORPIDsv8qDrRsBEKfoGSyoovbi0T6B7HGdD987uOxwMXQJyFFdPJFVBphEFMnNIP2SUz+AmSKkd4RDlM2XCRIU7/0lajB0ZJh6y8SLdCXZcj0LHykPs5OReptaxbqb4=
Received: from DS7PR05CA0061.namprd05.prod.outlook.com (2603:10b6:8:57::15) by
 CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.31; Tue, 2 May 2023 13:37:30 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::ab) by DS7PR05CA0061.outlook.office365.com
 (2603:10b6:8:57::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20 via Frontend
 Transport; Tue, 2 May 2023 13:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Tue, 2 May 2023 13:37:30 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:37:22 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 13/23] arm64: zynqmp: Used fixed-partitions for QSPI in k26
Date:   Tue, 2 May 2023 15:35:41 +0200
Message-ID: <c2942b2f34d1c27f39e6dda3944ee83302de4626.1683034376.git.michal.simek@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT060:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 44dc5de4-6306-4fc4-2eeb-08db4b12608e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: INYOM7hDbW0pa3Q6GC2+/KLY99dhLlcap+Vq3NiUBoXmXlG2PlT492ut3z24jBeu2P6SnUcwwmFSq+G+FrqktGgbMs4T9ejPd2VBkvvlCZdqCZUJso+a9HhmY5ZnV1Bt01bgUQ6p1a4nu7aAs90jrBPNlt/vLK/HqBOnxQOobgVUgS63rT1zCb/wBBdQ/1Ziuegi7ib7vEs8DqinTtvFirVjtrG+GkawntvtOu34txQuDpSoQ66Rv5jFv9jgW2dBQjE0XpBvKetUTQWkMYCo5JRrEgR4PlEsuwYLHyFO8fW7q4M0XUXX0iznyXNeNtNfoOVzWVenzbluVtPik0deqXVQaAdRu7EVdB4CQgSLZa29lJdUFAAA9zIJMR8ZIQkIHRl453Gl0PU/Y2p073M0/iDMY/jxna504qz6wi7/PNFzKX03xcrYA15vAPDGvnBGPBUUe5kj4Id+84NrO6ufx0Z5o2bWyNrSMmmdeCuevgJmzI42Nfenkc97jOT0kyxfTP4LG/9MqJkpGzK7YOveBxeBeqM+T96HMlt/3dfa6QWyaja1E5gADdRnqa9QItErKfSnAXIIafp5h7Un07Fs4NkhiFQpSriKen6xKaFcUYHjAOnTi2PUDZzPUROu7LxGeB0FbmHxJU1uFapdvbd4aC+7O94xZ52t1DNCLmcGbrErwrmuySQMLk7e5yFI6DvLf+6ly8IAxgTbhahfFX5rV4Czyz56nXP4kXlqdknT7In/HHdHe531GTAKOP7nwtAY
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(40470700004)(46966006)(36840700001)(81166007)(356005)(26005)(82740400003)(186003)(83380400001)(426003)(36860700001)(336012)(2616005)(47076005)(16526019)(36756003)(44832011)(2906002)(40460700003)(110136005)(40480700001)(86362001)(6666004)(54906003)(478600001)(70586007)(82310400005)(41300700001)(5660300002)(8936002)(70206006)(4326008)(8676002)(316002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:37:30.3701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44dc5de4-6306-4fc4-2eeb-08db4b12608e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using fixed partitions is recommended way how to describe QSPI. Also add
label for qspi flash memory to be able to reference it in future.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    | 169 +++++++++---------
 1 file changed, 88 insertions(+), 81 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index 5fbc2fbd2638..cb3e5c06fdc5 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -91,87 +91,94 @@ spi_flash: flash@0 { /* MT25QU512A */
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <40000000>; /* 40MHz */
-		partition@0 {
-			label = "Image Selector";
-			reg = <0x0 0x80000>; /* 512KB */
-			read-only;
-			lock;
-		};
-		partition@80000 {
-			label = "Image Selector Golden";
-			reg = <0x80000 0x80000>; /* 512KB */
-			read-only;
-			lock;
-		};
-		partition@100000 {
-			label = "Persistent Register";
-			reg = <0x100000 0x20000>; /* 128KB */
-		};
-		partition@120000 {
-			label = "Persistent Register Backup";
-			reg = <0x120000 0x20000>; /* 128KB */
-		};
-		partition@140000 {
-			label = "Open_1";
-			reg = <0x140000 0xC0000>; /* 768KB */
-		};
-		partition@200000 {
-			label = "Image A (FSBL, PMU, ATF, U-Boot)";
-			reg = <0x200000 0xD00000>; /* 13MB */
-		};
-		partition@f00000 {
-			label = "ImgSel Image A Catch";
-			reg = <0xF00000 0x80000>; /* 512KB */
-			read-only;
-			lock;
-		};
-		partition@f80000 {
-			label = "Image B (FSBL, PMU, ATF, U-Boot)";
-			reg = <0xF80000 0xD00000>; /* 13MB */
-		};
-		partition@1c80000 {
-			label = "ImgSel Image B Catch";
-			reg = <0x1C80000 0x80000>; /* 512KB */
-			read-only;
-			lock;
-		};
-		partition@1d00000 {
-			label = "Open_2";
-			reg = <0x1D00000 0x100000>; /* 1MB */
-		};
-		partition@1e00000 {
-			label = "Recovery Image";
-			reg = <0x1E00000 0x200000>; /* 2MB */
-			read-only;
-			lock;
-		};
-		partition@2000000 {
-			label = "Recovery Image Backup";
-			reg = <0x2000000 0x200000>; /* 2MB */
-			read-only;
-			lock;
-		};
-		partition@2200000 {
-			label = "U-Boot storage variables";
-			reg = <0x2200000 0x20000>; /* 128KB */
-		};
-		partition@2220000 {
-			label = "U-Boot storage variables backup";
-			reg = <0x2220000 0x20000>; /* 128KB */
-		};
-		partition@2240000 {
-			label = "SHA256";
-			reg = <0x2240000 0x40000>; /* 256B but 256KB sector */
-			read-only;
-			lock;
-		};
-		partition@2280000 {
-			label = "Secure OS Storage";
-			reg = <0x2280000 0x20000>; /* 128KB */
-		};
-		partition@22A0000 {
-			label = "User";
-			reg = <0x22A0000 0x1d60000>; /* 29.375 MB */
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "Image Selector";
+				reg = <0x0 0x80000>; /* 512KB */
+				read-only;
+				lock;
+			};
+			partition@80000 {
+				label = "Image Selector Golden";
+				reg = <0x80000 0x80000>; /* 512KB */
+				read-only;
+				lock;
+			};
+			partition@100000 {
+				label = "Persistent Register";
+				reg = <0x100000 0x20000>; /* 128KB */
+			};
+			partition@120000 {
+				label = "Persistent Register Backup";
+				reg = <0x120000 0x20000>; /* 128KB */
+			};
+			partition@140000 {
+				label = "Open_1";
+				reg = <0x140000 0xC0000>; /* 768KB */
+			};
+			partition@200000 {
+				label = "Image A (FSBL, PMU, ATF, U-Boot)";
+				reg = <0x200000 0xD00000>; /* 13MB */
+			};
+			partition@f00000 {
+				label = "ImgSel Image A Catch";
+				reg = <0xF00000 0x80000>; /* 512KB */
+				read-only;
+				lock;
+			};
+			partition@f80000 {
+				label = "Image B (FSBL, PMU, ATF, U-Boot)";
+				reg = <0xF80000 0xD00000>; /* 13MB */
+			};
+			partition@1c80000 {
+				label = "ImgSel Image B Catch";
+				reg = <0x1C80000 0x80000>; /* 512KB */
+				read-only;
+				lock;
+			};
+			partition@1d00000 {
+				label = "Open_2";
+				reg = <0x1D00000 0x100000>; /* 1MB */
+			};
+			partition@1e00000 {
+				label = "Recovery Image";
+				reg = <0x1E00000 0x200000>; /* 2MB */
+				read-only;
+				lock;
+			};
+			partition@2000000 {
+				label = "Recovery Image Backup";
+				reg = <0x2000000 0x200000>; /* 2MB */
+				read-only;
+				lock;
+			};
+			partition@2200000 {
+				label = "U-Boot storage variables";
+				reg = <0x2200000 0x20000>; /* 128KB */
+			};
+			partition@2220000 {
+				label = "U-Boot storage variables backup";
+				reg = <0x2220000 0x20000>; /* 128KB */
+			};
+			partition@2240000 {
+				label = "SHA256";
+				reg = <0x2240000 0x40000>; /* 256B but 256KB sector */
+				read-only;
+				lock;
+			};
+			partition@2280000 {
+				label = "Secure OS Storage";
+				reg = <0x2280000 0x20000>; /* 128KB */
+			};
+			partition@22A0000 {
+				label = "User";
+				reg = <0x22A0000 0x1d60000>; /* 29.375 MB */
+			};
 		};
 	};
 };
-- 
2.36.1

