Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C35B712557
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 13:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbjEZLRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 07:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjEZLRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 07:17:50 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20623.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A38F7;
        Fri, 26 May 2023 04:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfEb4zKgd9WrUHHLDuj8KgTVBSdNi5PjTcoLJmmBUnmwbz1MEL3ozCW50e2+LVaZy8FKeVnZrakJXWEiwYL4yTl91BPLMpm1u239xYiGhnvlx+chJravSgkZZSHaO8H+Wr730+Jf96grlkXEGcMFEjKR3s4j2lhESt4vwtwVJIJSGzrpM4CDdIc4S1Tp+cEtF4oxPc1UFKpV53WQfCbIuyrd0eMhiFhpZ70D4uKoNspLDkmICQGVx12Tnv8M8E1Sz4NgxRViXvvHkTOGde2jIxA1CamrVwY1NPhd2ryyYLgLA5jHAkuMF7D8naZyaZBZL9bp4mpg43PkCDUGrZvUsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeJxCIOnxKxZjiebu0TEig2Dvzsz/Llw1ukl0zFR1dQ=;
 b=nFybqFKcmQtykuEdAdOUrEiabwAXBCt2surkv1qo+kv1U6YioSaF3cTnG/5OvEoSBCBHaJQ2+XLK5q9M8OQgPFXLLimIlt4MV1tNGKB+gwJkNeTvnqNmy97+EsNoUBiTGoxddhTABBbwwUUy2Rih8zNVoLYeyuR0KCtf2TyhulA2nFjvtQOR2rcjQIALX2jSVq7sFRs7rGI8BQw+tSvDEIbfqChKH6b/Sw2XAcOg5uRIVW6ikQ/oct6tNcqx8TIZ3z0gaRU91nAdU/FQQQqETsle+3uffkuvePwyhbSkyGpgWCCyvw+jzKTxwSUvrc8KQ1h3EQnE4M25FbMW4os+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeJxCIOnxKxZjiebu0TEig2Dvzsz/Llw1ukl0zFR1dQ=;
 b=Uya0XlEKAf+y2ZlcDD+wBVK3Ps4OykZ5kw1cEE9qonjJNoAGx7U1WoHUOzjW32EoacxOKX276PmyQEjVTpawGshgTeR5MNHYMYTx2ZZ2z4Eh//tctWW+DT9MXENWzIAjdZIjelR6L7Un2mr/2hCtrPErgAWbFq964ioc5E6a8RgcXm3ipHoBBMWcnBxq7VPg4YRNuEKD124zyIEUUQhTxZg9ysJ8+kPeL3tjTamzN8LsraNE1V1G1P7gBoFE6rtR5+WjFaaikmXQV4BpiT1WM5SZzq1IXpdbL6qJVvv8Yc+0F7org/NLn9+IYYFmacdRqbBp6SK4438le/CabEP+0Q==
Received: from DM6PR11CA0050.namprd11.prod.outlook.com (2603:10b6:5:14c::27)
 by CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Fri, 26 May
 2023 11:17:46 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::21) by DM6PR11CA0050.outlook.office365.com
 (2603:10b6:5:14c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19 via Frontend
 Transport; Fri, 26 May 2023 11:17:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.18 via Frontend Transport; Fri, 26 May 2023 11:17:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 26 May 2023
 04:17:33 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 26 May
 2023 04:17:33 -0700
Received: from moonraker.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 26 May 2023 04:17:31 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] arm64: tegra: Fix PCIe regulator for Orin Jetson AGX
Date:   Fri, 26 May 2023 12:17:27 +0100
Message-ID: <20230526111727.26058-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT014:EE_|CY5PR12MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b3b11b-fb0f-4cd6-373a-08db5ddad517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: meUFL3PSv3dtKyFiqKqf46v6+a/CTzs1wpG3HQXYOG2Iq8+JWFYomwViMStcC0znWvw+gtRwObXW3T1JmbJ2vbeQd2p9g7AoF5OCxD5Ur7MiKEKbT8uBHbagkhuhIWCGmdfCWAkFwKch/RlQviuyiPj/5g/NfZgtnD1iVPQ3pqUKbL8S66mdC1b5r4Ix/F2hsWhlyfYxAQGBj3LWd+63vkObHfXvtbYGkCijD8fXWcHpnS5xq3R6xXs2EBLCO4KQeKgZv5OVK3sRHixnP49K1iWcKHrj3RN32Yuqv5EmJW4vDohdcTnCVz7wh8ZJw5jBKZef4PzQwEfXXzpdrL7rmjqttGUbqT4PFXI/6fHinf6M0zZRa+UaJqLtbrCiGkikhuPs0MWuuKV7hbQ2XiKMAMozptXCbSapA0WZeGWX9YgHA3ZMDkRfzExNuK1aOkigOtBPI/ilXgGYU9+fKG5QvgCS5VEJW0lxvIAayIRSHLIpb8lzt02dAY7vVOnBGPKojGSaH7kWEvF7PycbdWmJhfuODwfRytnJycTWJU5f5H+zbRFdIpMhZ6fjvdM3eKGsal9YLAG14+GeLWu5ydgaM6jU6dcrx85NXeQhO2KF9v0o/Hlzn4tCY0QnGtvfqobVQOn5lJexB77xJexlHFlUO/nrkeZGf94YuAUID/PXk95V9P0XyE5xLoDiorjMPvWkjtLIAPfpPHJnchgYk5JxWpCKXhGV/Im+nJDMrQbaD7ie03RhUdgOxKvXbVkpVUZ1
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(70206006)(70586007)(478600001)(316002)(4326008)(54906003)(110136005)(86362001)(356005)(36756003)(83380400001)(47076005)(107886003)(26005)(1076003)(2616005)(336012)(426003)(36860700001)(186003)(41300700001)(8676002)(8936002)(5660300002)(2906002)(7696005)(6666004)(82310400005)(40480700001)(7636003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 11:17:46.0816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b3b11b-fb0f-4cd6-373a-08db5ddad517
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6132
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCIe slot on the Jetson Orin AGX is not working and PCIe cards
are not detected. The regulator for the 3.3V regulator for the PCIe is
using the wrong GPIO for turning on the regulator. Fix this by updating
the 3.3V regulator to use the correct GPIO.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
index e161618cfca8..4dce2e214002 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
@@ -142,7 +142,7 @@ vdd_3v3_pcie: regulator-vdd-3v3-pcie {
 		regulator-name = "VDD_3V3_PCIE";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio TEGRA234_MAIN_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio TEGRA234_MAIN_GPIO(H, 4) GPIO_ACTIVE_HIGH>;
 		regulator-boot-on;
 		enable-active-high;
 	};
-- 
2.34.1

