Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312A06C5C01
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 02:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjCWB3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 21:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWB3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 21:29:44 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242C635AD;
        Wed, 22 Mar 2023 18:29:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhjhcOWYNed0FATEVIyM4BO2Zj3wNq5CaOF56UlHgF8pJ7CbjHWDqcd9q98Qw/reJL7/iFXyH1SVxj39cQeOwaBxwZUw496p/tIWXZT/jqwMXaBlWRtAEmywwGlXNj43xSpFP3Z7k1qxfBS2oo/JByxwunfm+ad0Y3WhzRTtoG4s38ieu2PaNz+Iq+olu03iqxtOobXa7UDeK7H8D4GzLnBGlOXIXz6zKhW/VApOp97pBbJZFAyVat4BKAkJsoyT7I+pL3rN053LAXSZY0fbhK60vaNYuFq4gcPLPAl/eXodl2ASIC8rBqLpzecsTso4J55AsMweD8cVmNaGXY6cmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kx/kpYZ7ir9/y4hkhUOBaWiXie83l6Pngi0Gj/5GgOI=;
 b=oIh8+dFeVP4LzR8Z5c0iGx9VGQMJq6FmXQb9m3Ns2sZ8s9+Mxz55DrnBp/TjYAOsyTAKU7CrPKfVj/aSvAoaoUpb9yVHrEc7iQUs/FG9lqH0ZEkdxH2iCmbUrrYq5eCsAb4+UWe6kuhf2Bh7P/IDT/cBtrvQBYB+iBBYIk/ykJT9b2y73VCzyUpgxD84i5kg+53tT7w6q7RDzIdMkoO5Ex6UgK3piLAZ3YtTgy6GXgLnt/EvLGfZsAyqY5yuyD9l1iy4WnYzD2e1rzxbk4UHM0y7W2z+amndyiD9uB2guOELi+YOUg/W2N6ICKDZPqQeMZqkXwZ7nVi3ji7xetH8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx/kpYZ7ir9/y4hkhUOBaWiXie83l6Pngi0Gj/5GgOI=;
 b=UVoCIesJEbnkYSnASS540uHp+rTdsOMISKoUUe/JLoODls6YI7KEJmJoKe8QjHF77XekdP9Glypir2CR+5YJAejJNVMBISwu9+cBUu9MOw5O7ov3PrtDDMgGjyyCeVSxTf6UhdvihgJq+2tPD3grrJ2fEqSLcRLeDETJc8LgsRLS/hZWTQBdyrRBGsiku+P/MIfsKnXPvyIWCu0LSe6nCkNa9PyIZLQzIG0ciu6zZXwBJJfkHXf4pL92SqEWLfL3N4VnPf0NvOiYpT0wsDVj4p4qNIE45Cv91JVqx2lsS6wav3EC08vWetkKrhnQBVka4TM9DcVmfvTYQStIVNDVEA==
Received: from DM6PR06CA0005.namprd06.prod.outlook.com (2603:10b6:5:120::18)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 01:29:41 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::f9) by DM6PR06CA0005.outlook.office365.com
 (2603:10b6:5:120::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 01:29:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 01:29:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 22 Mar 2023
 18:29:34 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 22 Mar
 2023 18:29:34 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 22 Mar 2023 18:29:34 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH V4 05/10] arm64: tegra: Add Tegra234 GTE nodes
Date:   Wed, 22 Mar 2023 18:29:24 -0700
Message-ID: <20230323012929.10815-6-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230323012929.10815-1-dipenp@nvidia.com>
References: <20230323012929.10815-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|CH2PR12MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: 60125a30-0ee1-42a2-a451-08db2b3e1339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I512c2jsJIYLscuzOOkP7WHzhMAUse9fKWTIX01FOMuomcpcYIEVUUt1Fs43d4u7xV//odBxhvZJp93X7q9/vdqISBFdLHHBtRW4Wx9mnTf0Ni/eh6A14O478d5WLgJzL6osZZo/SdvPTMcSmgeKyYeveEl8yRC0KPkV/cXtN/GsW9+bBU1jOheUniPGcLMBUVLMR6YzMDd+8kCDQY7JCloCPYhPSwDOOAQAyEIgjbAQpP1yLR/gkmUpL0TPLRZyWI6zIkm8d/6jzN/hgRooN9r6CytkeKZYxXtB/PbGTHvukmzeHdO2gSaJzVXICfl1UtR9d6NSDdChGoQPenf9z1Lt2+BtmOZUQ9VxuPPx6D8oITx0iAH9dRwEPTIgjA5I4JIei/2MQVFusuXMcjlEyT+cIsifE5FLkHbsDXsQFswnMckfE/zO1POUFfiBvvKL15ue3jx7fANY7gJtaQGvsD8f6VllwcGHXSFvsvmcX+ZWnVwT7CDx3oplqdAvBjtSRCn5IJUithPnQU13Xy7YQTGSTfwFHb/mmJ7b1zn23OIBgmeWFN1uSj+9OVhzUXD4I+oCzpFgaqUOsjrNPbniA1OZYge8/T0T8mN0PPGfDBecuL1ovGHoy+pGNvskywlIwKcb3e6ZKkASq2JDjk0sbaVnlKg9xa5KkRtn+Y4y0mNxf5XJKqCUOjwfIm86T7XxuP+e6F6/dLcRNiPE1Zwfh3BkavlFsfg+LmVy0AI1iWnQec6mwxH6l3hTCCA29QB/XWDIOinLbYlXOfVmS8lE5UnFkfKy9YHxvm+MeFo5oBMCf4a2uqxzH2YtlGqUQK3B
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(83380400001)(86362001)(7696005)(82310400005)(40460700003)(40480700001)(36756003)(316002)(6666004)(70206006)(8676002)(4326008)(70586007)(478600001)(2616005)(336012)(110136005)(47076005)(426003)(107886003)(186003)(26005)(1076003)(356005)(921005)(7636003)(5660300002)(82740400003)(7416002)(8936002)(36860700001)(41300700001)(2906002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 01:29:41.2162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60125a30-0ee1-42a2-a451-08db2b3e1339
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

