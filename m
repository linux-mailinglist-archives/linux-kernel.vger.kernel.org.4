Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C746E192B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 02:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjDNApO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 20:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjDNApL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:45:11 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12hn2212.outbound.protection.outlook.com [52.100.166.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C10C2691;
        Thu, 13 Apr 2023 17:45:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BR+BFWMiRnUmRx9RK1xc5okFViJREhCmKbIbsRkhgsDLWsuN0RdN0ZNIv5b2ry7IU++bUrO3rXGhbBs6QAHdspmX6V5RMF9tmVcqaNjt54UH6AIa9NfRIHsk1JQRXAypxgmFuHZS96EFweQBGb74DBfNJnb57wVKrhQgTuVR72G7RRsiuO551nKMllJvY2YTtTlKJiBdh5wHdNUbZ/P7tjCryon5Ed6vjJLKyyC2UjKv/qNaXJmcPAK+nSeQpFOzzhBGgpFCK8lH1c8dk8CFg2Qj3hgrT01RUeyhMQPoxLP1GpZaM3nBWGZxeLIUKWZbBgrpu3TySChsRPj8FLjiSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kx/kpYZ7ir9/y4hkhUOBaWiXie83l6Pngi0Gj/5GgOI=;
 b=DsliWIUfv75vxeOv2AhWOx4mc8LKRy3D5qs4zFS2oB+/1cZXWcNclXSzrXBOBUwXdkXAIcWqTT5GMXLXWpiysviDAVenlGh6/XbzGd5PvCvn8i8vV0lvfg2R3F6Yc1dNdWuLZ8RC/DRwM1/Av44UxOz4UHFajuEM6xY6FfcUUqjqZiLc7MWcVgUpE+WU/QuFyC6dlLZG+8OrB6NKdM6Q/Jqt+9jZvny5505cYKYLiNH1ys6d9cyUfn7UmRSiQTjRSZ9QzggJrU0MrNssu8wlQrHaNDD5YE6HCAu3O3UVsV9EUPjycamZ97IyX20hhUACVVOmCKislu3D32rDpMdqCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx/kpYZ7ir9/y4hkhUOBaWiXie83l6Pngi0Gj/5GgOI=;
 b=hysT+jL55GsRRKNwZ5Bk3AvPRHNJ8iKLFx7x4GG40peGgIaHvS2TpKX9d0nf+mBnzpPo+f+EwaVQr5W0sb4/4s/jRNjk2JpjhlUWRxZuNqSJYar+K1fOhSqv8t9eAlBlvg4wn2qdR5ucXuKCsLkaD7nbbQjK7kDo8I24fkL8rPHoQZ6RML+7lchhJYYSfXnTAZau8QPqztedW4soB2gsLfU9vYcX40r6InBXEpB5r0iLZ02cXlrf9TASaUZKynaZRvmKimcxi2HqchBAZEhJ6+WHtZJL/nQeL+/fyIHs4iwZMVr6QrgFWzX9ULmDg86+GevRZGHIZCCD0h+z2I5VHg==
Received: from MW4PR04CA0135.namprd04.prod.outlook.com (2603:10b6:303:84::20)
 by CH3PR12MB8879.namprd12.prod.outlook.com (2603:10b6:610:171::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 00:45:06 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::d7) by MW4PR04CA0135.outlook.office365.com
 (2603:10b6:303:84::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.32 via Frontend
 Transport; Fri, 14 Apr 2023 00:45:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30 via Frontend Transport; Fri, 14 Apr 2023 00:45:06 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Apr 2023
 17:45:00 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Apr
 2023 17:44:59 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 13 Apr 2023 17:44:59 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [V6 4/9] arm64: tegra: Add Tegra234 GTE nodes
Date:   Thu, 13 Apr 2023 17:44:50 -0700
Message-ID: <20230414004455.19275-5-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230414004455.19275-1-dipenp@nvidia.com>
References: <20230414004455.19275-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|CH3PR12MB8879:EE_
X-MS-Office365-Filtering-Correlation-Id: 3edf3882-7daa-461c-ea8d-08db3c817de5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9CZSDJZ1D3MK8f7u5sJD401cNrrnJ0yKWFkn2sl/KMt2s6nmOxC7dmuABY5f67vQQL8sYXe04cnFWzc9I50SEiLH+Bd30Fmx3pxNaqS+432+0gz1iFz8ES9xxpo/lMloOVKU+ol4tJo3vekYaNeW8B34l0KDx+tTIx6UieTJ4cc6EB5datFE13pBT05dD3uPmSKkZQ8eYFdUgz3efckm716H/BX//Ffux0Tnp1svfRaPU/y5MymWE0J6cENjf+nelTy/A11nWTZKVLGX1K/eCUmBZON5OoMQ96/4XcUhoQ4NegSr984PYO1l52FhpAfMYbB7exKHVMJEYTtYrGt75YJtnCOcQAsP1WpMdNifLf4fQfpojz8D17diK+CItoyH5pfFIDzwJKa44Z8NDvUub+1JG9ykmIfzGjbFcpC/acCaJ9UXQIqRHEptJeGWwptTNAZ5eVzyT4Rig3/9ZKpifekEVLcUNKH7bHwMYP5mpSIn1WCVc1BRHXOMa+2gGBtuZuEJhkGDWODOF8ASuHdns6JsGUoE9cO/Df5//c11MvSG3j/PvJ4x0R5rqxTZwFLe1fQS5ZolDHNzwwqRhM+YKyF1hKkr1yekMm2Zn2I9SPxpm3iaZTMafSNA0yB2912cUN0TSEn9Vztq7uCrf38/kyjCnTr0bGwt1W9pWyhtBhFGYqPEKasajkaOKPdMcNu1IZas6oIqgXzePt4g9P+DVNshdgXtpHER8vwdyfXwhkXC/jZNd/BgEc7nkWzOD39pKjblDgaVSmIYroN2k+1Jr8ndJI2BrHrIsVM5GCw9jyQlRHtTqNKGNEIj2A2c68wC0VchOxT4vyRbE6cmDGoiR5wCCLjG0mFHWWVjimEHuSUrJHrrFLfnWVeMRsPtVuag
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(5400799015)(36840700001)(40470700004)(46966006)(6666004)(7696005)(40460700003)(4326008)(36756003)(70586007)(70206006)(110136005)(2906002)(7416002)(86362001)(356005)(7636003)(41300700001)(5660300002)(8676002)(8936002)(82740400003)(82310400005)(921005)(316002)(34020700004)(478600001)(40480700001)(1076003)(336012)(26005)(426003)(2616005)(36860700001)(107886003)(186003)(47076005)(83380400001)(83996005)(2101003)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 00:45:06.2787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edf3882-7daa-461c-ea8d-08db3c817de5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8879
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GTE LIC and AON GPIO nodes for the tegra234 SoC.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 8fe8eda7654d..54790c6b6a2c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -1156,6 +1156,14 @@
 			clock-names = "fuse";
 		};
 
+		hte_lic: hardware-timestamp@3aa0000 {
+			compatible = "nvidia,tegra234-gte-lic";
+			reg = <0x0 0x3aa0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,int-threshold = <1>;
+			#timestamp-cells = <1>;
+		};
+
 		hsp_top0: hsp@3c00000 {
 			compatible = "nvidia,tegra234-hsp", "nvidia,tegra194-hsp";
 			reg = <0x0 0x03c00000 0x0 0xa0000>;
@@ -1673,6 +1681,15 @@
 			#mbox-cells = <2>;
 		};
 
+		hte_aon: hardware-timestamp@c1e0000 {
+			compatible = "nvidia,tegra234-gte-aon";
+			reg = <0x0 0xc1e0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,int-threshold = <1>;
+			nvidia,gpio-controller = <&gpio_aon>;
+			#timestamp-cells = <1>;
+		};
+
 		gen2_i2c: i2c@c240000 {
 			compatible = "nvidia,tegra194-i2c";
 			reg = <0x0 0xc240000 0x0 0x100>;
-- 
2.17.1

