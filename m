Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA49E737118
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjFTP7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjFTP7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:59:21 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F83E6E;
        Tue, 20 Jun 2023 08:59:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqzTuRy46ZH3Nvtm47CPhHYj/6Sok/JQEGX9R/RJJgdOi6cE49Cex9ZM4uRf4cwDEORTdkYNWTD4gujizuzJkn0XSPO3T7zB4WQde1C71VtjCBTD6i9/ArlUJOf8+g4qYb8YKQ4mT3yUXPeEPwILc6nyzB4gROgZiwd7+4gH+gT5eDqrsRjVtShqrfKMSD1iAgFtTWcvs6EE3Ri7qWjc9PQOkjk3D8aLzAwe/RpmKte3rfw45h+B4f/MOFgG1ST7v0279gkH+pRRxFppWXWV5BsAAFgd5PKbnQCvya+kybgBxjV23Hkk+5raxvjdoa1ptcnHZr7qHd5j6sJfDhkpYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdD8425V3UMo9Nga7dVS45AUBd5pyo9+IW+WfktCmso=;
 b=R2hKj6ZRRueekCwWvdEVfOdpjhlLNIoHYcGEenxMRjK2xxvr+gkY5AlcWY7KuvQDJ3VaO7ZIIUHaVYdMctR2/FBvMgMi1rfRUBhRbjvmleXWcRxcLk9nxoHCg/5aksOoNMZMTKvLcYYYLXTEzisklHafPDQEpU6kxYZZVvMS/xvWSgkl/429zB5yH/VXhoWHKAjUC9O+GXiOKM+K+KPYHeS7dE/lR+T0kwpPJbCWv55MqyKh+DqE/GCGkmKxnDG0mAG4VQK5rF4JQTk6z664EIAN7MTuLq0NbmfItWGFIBhlb2bVhywzTD2QitMb5ROhHMGrXW/L+a2tA0YSQgZC+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdD8425V3UMo9Nga7dVS45AUBd5pyo9+IW+WfktCmso=;
 b=aiTFui/iCr4pEg1LYElYHwV69dDUzRAY7bgIFvq6D9Sue1IgVqqmzf/RC1Y8DLMbkfAhSNkT5VNSs2vL2bEOg+IKLyF/5gQsxKraAs+NIVmwF5/ItdZQKPL1EC80s6mDmxBBevg5mC6onx7mhfCmRFJZInHu3L9psDjqPQtWVcgu+z6MJPh8Hn3hrFWZesz/IsQdJTSBQ3XxeUBz7PaN+DR4YWqEeSi1V0coZVBohrgXeWsrd5kc6GK29mGeAWXrcif3frLm/ZQksSSKT354ua02IMNjECmqySwmVqgPnX6nMBwTb1uS2GzGV8HMjoNm89W9z6BfNB5XfrqV1LowXA==
Received: from DM6PR01CA0025.prod.exchangelabs.com (2603:10b6:5:296::30) by
 SN7PR12MB6864.namprd12.prod.outlook.com (2603:10b6:806:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 20 Jun
 2023 15:59:13 +0000
Received: from DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::e3) by DM6PR01CA0025.outlook.office365.com
 (2603:10b6:5:296::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Tue, 20 Jun 2023 15:59:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT072.mail.protection.outlook.com (10.13.173.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37 via Frontend Transport; Tue, 20 Jun 2023 15:59:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 20 Jun 2023
 08:59:04 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 20 Jun
 2023 08:59:03 -0700
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 20 Jun 2023 08:59:01 -0700
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <spujar@nvidia.com>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH] arm64: tegra: Add audio support for IGX Orin
Date:   Tue, 20 Jun 2023 21:28:47 +0530
Message-ID: <20230620155847.14598-1-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT072:EE_|SN7PR12MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: af0c7058-af8a-4c00-045e-08db71a74abe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A2ruSth5kzLrhMjqCKigYe0pB3LhtiP/WBvlonXj54R+PxUdeTDd7+tv9SL29hTp12A7AcrfLZOkleVgXpAwrTh1B67ZrBbSbVdgxCDCVDL9hSFUyOyVCWUALgvuYfRXX4WO1T9D1Ch6WEBXzK25DqL3/O+/Cj2uy6V+h5vPE4GeAZM5F8yUcYW1oGGtDO1MaWGKJemoVEP1zBUe6NmOzct3X9fXPcxkLTgViil0uPkiS13ijahmkrCLsu+pHCuvyZRQ89FyrdajjWj0emUP6WZpU3GDk9Tx0T1ZvF9DBxvhNHJVu5zVFhUevyi+5s52aKzjnO7f13WDyqMa4l40PfbknHqoL1gupsCuE6oUoo0J37M4TsrYEFOrlxCwx/i0asILNZcm8kaCjpsID8GeXHSG07SXA6Ozu6yDHpVs1ThMOfC/V7MDd7JtD43spH/1Kg+xAn57qRkY9Uc/N4X9outmrnPoc4e6MiSlUsvZ6QHgxK6dSYus3KVSjvF5r3qP44ZMz7/TJ8TiEFxUe5dD/5zq8MiQgBKEK/j59kTQHHV+idN7JPZuQXYg4MMuZA9wfK/Tvfq3rlJAhuYtkILpBnOVBfHaWZG8YEWmn2uWMsVV4+gjfsLZnVULH97ccmEUJE4FD/dfh2TG1XgjXodQVJJZlDSC75Rb1qo/StlTK0CQEGXQU3ggP6SH8juVqSUYZXs2/L3e2Zqpn84RdgDSh/LwusD1IwPoD1U03Icg2+3RVEc8+urE7XQBmgGDKXk3
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(86362001)(36756003)(36860700001)(82740400003)(7636003)(356005)(8676002)(8936002)(47076005)(426003)(83380400001)(186003)(26005)(336012)(54906003)(107886003)(1076003)(41300700001)(316002)(2616005)(6666004)(70586007)(478600001)(4326008)(7696005)(110136005)(70206006)(30864003)(2906002)(40460700003)(5660300002)(82310400005)(40480700001)(559001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 15:59:12.8938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af0c7058-af8a-4c00-045e-08db71a74abe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audio support for the NVIDIA IGX Orin development kit having P3701
module with P3740 carrier board.

Move the common device-tree nodes to a new file tegra234-p3701.dtsi and
use this for Jetson AGX Orin and NVIDIA IGX Orin platforms

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 .../boot/dts/nvidia/tegra234-p3701-0000.dtsi  |    1 +
 .../boot/dts/nvidia/tegra234-p3701-0008.dtsi  |    1 +
 .../arm64/boot/dts/nvidia/tegra234-p3701.dtsi | 1991 ++++++++++++++++
 .../nvidia/tegra234-p3737-0000+p3701-0000.dts | 2009 -----------------
 .../boot/dts/nvidia/tegra234-p3737-0000.dtsi  |   41 +
 .../nvidia/tegra234-p3740-0002+p3701-0008.dts |   91 +-
 .../boot/dts/nvidia/tegra234-p3740-0002.dtsi  |   56 +
 7 files changed, 2176 insertions(+), 2014 deletions(-)
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra234-p3701.dtsi

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
index 319b3a9cff24..cb792041fc62 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include "tegra234.dtsi"
+#include "tegra234-p3701.dtsi"
 
 / {
 	model = "NVIDIA Jetson AGX Orin";
diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0008.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0008.dtsi
index e468352b8b7f..62c4fdad0b60 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0008.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0008.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include "tegra234.dtsi"
+#include "tegra234-p3701.dtsi"
 
 / {
 	compatible = "nvidia,p3701-0008", "nvidia,tegra234";
diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3701.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3701.dtsi
new file mode 100644
index 000000000000..5e7797df50c2
--- /dev/null
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3701.dtsi
@@ -0,0 +1,1991 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/ {
+	compatible = "nvidia,p3701", "nvidia,tegra234";
+
+	bus@0 {
+		aconnect@2900000 {
+			status = "okay";
+
+			ahub@2900800 {
+				status = "okay";
+
+				i2s@2901000 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							i2s1_cif: endpoint {
+								remote-endpoint = <&xbar_i2s1>;
+							};
+						};
+
+						i2s1_port: port@1 {
+							reg = <1>;
+
+							i2s1_dap: endpoint {
+								dai-format = "i2s";
+								/* placeholder for external codec */
+							};
+						};
+					};
+				};
+
+				i2s@2901100 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							i2s2_cif: endpoint {
+								remote-endpoint = <&xbar_i2s2>;
+							};
+						};
+
+						i2s2_port: port@1 {
+							reg = <1>;
+
+							i2s2_dap: endpoint {
+								dai-format = "i2s";
+								/* placeholder for external codec */
+							};
+						};
+					};
+				};
+
+				i2s@2901300 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							i2s4_cif: endpoint {
+								remote-endpoint = <&xbar_i2s4>;
+							};
+						};
+
+						i2s4_port: port@1 {
+							reg = <1>;
+
+							i2s4_dap: endpoint {
+								dai-format = "i2s";
+								/* placeholder for external codec */
+							};
+						};
+					};
+				};
+
+				i2s@2901500 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							i2s6_cif: endpoint {
+								remote-endpoint = <&xbar_i2s6>;
+							};
+						};
+
+						i2s6_port: port@1 {
+							reg = <1>;
+
+							i2s6_dap: endpoint {
+								dai-format = "i2s";
+								/* placeholder for external codec */
+							};
+						};
+					};
+				};
+
+				sfc@2902000 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							sfc1_cif_in: endpoint {
+								remote-endpoint = <&xbar_sfc1_in>;
+							};
+						};
+
+						sfc1_out_port: port@1 {
+							reg = <1>;
+
+							sfc1_cif_out: endpoint {
+								remote-endpoint = <&xbar_sfc1_out>;
+							};
+						};
+					};
+				};
+
+				sfc@2902200 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							sfc2_cif_in: endpoint {
+								remote-endpoint = <&xbar_sfc2_in>;
+							};
+						};
+
+						sfc2_out_port: port@1 {
+							reg = <1>;
+
+							sfc2_cif_out: endpoint {
+								remote-endpoint = <&xbar_sfc2_out>;
+							};
+						};
+					};
+				};
+
+				sfc@2902400 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							sfc3_cif_in: endpoint {
+								remote-endpoint = <&xbar_sfc3_in>;
+							};
+						};
+
+						sfc3_out_port: port@1 {
+							reg = <1>;
+
+							sfc3_cif_out: endpoint {
+								remote-endpoint = <&xbar_sfc3_out>;
+							};
+						};
+					};
+				};
+
+				sfc@2902600 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							sfc4_cif_in: endpoint {
+								remote-endpoint = <&xbar_sfc4_in>;
+							};
+						};
+
+						sfc4_out_port: port@1 {
+							reg = <1>;
+
+							sfc4_cif_out: endpoint {
+								remote-endpoint = <&xbar_sfc4_out>;
+							};
+						};
+					};
+				};
+
+				amx@2903000 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							amx1_in1: endpoint {
+								remote-endpoint = <&xbar_amx1_in1>;
+							};
+						};
+
+						port@1 {
+							reg = <1>;
+
+							amx1_in2: endpoint {
+								remote-endpoint = <&xbar_amx1_in2>;
+							};
+						};
+
+						port@2 {
+							reg = <2>;
+
+							amx1_in3: endpoint {
+								remote-endpoint = <&xbar_amx1_in3>;
+							};
+						};
+
+						port@3 {
+							reg = <3>;
+
+							amx1_in4: endpoint {
+								remote-endpoint = <&xbar_amx1_in4>;
+							};
+						};
+
+						amx1_out_port: port@4 {
+							reg = <4>;
+
+							amx1_out: endpoint {
+								remote-endpoint = <&xbar_amx1_out>;
+							};
+						};
+					};
+				};
+
+				amx@2903100 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							amx2_in1: endpoint {
+								remote-endpoint = <&xbar_amx2_in1>;
+							};
+						};
+
+						port@1 {
+							reg = <1>;
+
+							amx2_in2: endpoint {
+								remote-endpoint = <&xbar_amx2_in2>;
+							};
+						};
+
+						port@2 {
+							reg = <2>;
+
+							amx2_in3: endpoint {
+								remote-endpoint = <&xbar_amx2_in3>;
+							};
+						};
+
+						port@3 {
+							reg = <3>;
+
+							amx2_in4: endpoint {
+								remote-endpoint = <&xbar_amx2_in4>;
+							};
+						};
+
+						amx2_out_port: port@4 {
+							reg = <4>;
+
+							amx2_out: endpoint {
+								remote-endpoint = <&xbar_amx2_out>;
+							};
+						};
+					};
+				};
+
+				amx@2903200 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							amx3_in1: endpoint {
+								remote-endpoint = <&xbar_amx3_in1>;
+							};
+						};
+
+						port@1 {
+							reg = <1>;
+
+							amx3_in2: endpoint {
+								remote-endpoint = <&xbar_amx3_in2>;
+							};
+						};
+
+						port@2 {
+							reg = <2>;
+
+							amx3_in3: endpoint {
+								remote-endpoint = <&xbar_amx3_in3>;
+							};
+						};
+
+						port@3 {
+							reg = <3>;
+
+							amx3_in4: endpoint {
+								remote-endpoint = <&xbar_amx3_in4>;
+							};
+						};
+
+						amx3_out_port: port@4 {
+							reg = <4>;
+
+							amx3_out: endpoint {
+								remote-endpoint = <&xbar_amx3_out>;
+							};
+						};
+					};
+				};
+
+				amx@2903300 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							amx4_in1: endpoint {
+								remote-endpoint = <&xbar_amx4_in1>;
+							};
+						};
+
+						port@1 {
+							reg = <1>;
+
+							amx4_in2: endpoint {
+								remote-endpoint = <&xbar_amx4_in2>;
+							};
+						};
+
+						port@2 {
+							reg = <2>;
+
+							amx4_in3: endpoint {
+								remote-endpoint = <&xbar_amx4_in3>;
+							};
+						};
+
+						port@3 {
+							reg = <3>;
+
+							amx4_in4: endpoint {
+								remote-endpoint = <&xbar_amx4_in4>;
+							};
+						};
+
+						amx4_out_port: port@4 {
+							reg = <4>;
+
+							amx4_out: endpoint {
+								remote-endpoint = <&xbar_amx4_out>;
+							};
+						};
+					};
+				};
+
+				adx@2903800 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							adx1_in: endpoint {
+								remote-endpoint = <&xbar_adx1_in>;
+							};
+						};
+
+						adx1_out1_port: port@1 {
+							reg = <1>;
+
+							adx1_out1: endpoint {
+								remote-endpoint = <&xbar_adx1_out1>;
+							};
+						};
+
+						adx1_out2_port: port@2 {
+							reg = <2>;
+
+							adx1_out2: endpoint {
+								remote-endpoint = <&xbar_adx1_out2>;
+							};
+						};
+
+						adx1_out3_port: port@3 {
+							reg = <3>;
+
+							adx1_out3: endpoint {
+								remote-endpoint = <&xbar_adx1_out3>;
+							};
+						};
+
+						adx1_out4_port: port@4 {
+							reg = <4>;
+
+							adx1_out4: endpoint {
+								remote-endpoint = <&xbar_adx1_out4>;
+							};
+						};
+					};
+				};
+
+				adx@2903900 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							adx2_in: endpoint {
+								remote-endpoint = <&xbar_adx2_in>;
+							};
+						};
+
+						adx2_out1_port: port@1 {
+							reg = <1>;
+
+							adx2_out1: endpoint {
+								remote-endpoint = <&xbar_adx2_out1>;
+							};
+						};
+
+						adx2_out2_port: port@2 {
+							reg = <2>;
+
+							adx2_out2: endpoint {
+								remote-endpoint = <&xbar_adx2_out2>;
+							};
+						};
+
+						adx2_out3_port: port@3 {
+							reg = <3>;
+
+							adx2_out3: endpoint {
+								remote-endpoint = <&xbar_adx2_out3>;
+							};
+						};
+
+						adx2_out4_port: port@4 {
+							reg = <4>;
+
+							adx2_out4: endpoint {
+								remote-endpoint = <&xbar_adx2_out4>;
+							};
+						};
+					};
+				};
+
+				adx@2903a00 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							adx3_in: endpoint {
+								remote-endpoint = <&xbar_adx3_in>;
+							};
+						};
+
+						adx3_out1_port: port@1 {
+							reg = <1>;
+
+							adx3_out1: endpoint {
+								remote-endpoint = <&xbar_adx3_out1>;
+							};
+						};
+
+						adx3_out2_port: port@2 {
+							reg = <2>;
+
+							adx3_out2: endpoint {
+								remote-endpoint = <&xbar_adx3_out2>;
+							};
+						};
+
+						adx3_out3_port: port@3 {
+							reg = <3>;
+
+							adx3_out3: endpoint {
+								remote-endpoint = <&xbar_adx3_out3>;
+							};
+						};
+
+						adx3_out4_port: port@4 {
+							reg = <4>;
+
+							adx3_out4: endpoint {
+								remote-endpoint = <&xbar_adx3_out4>;
+							};
+						};
+					};
+				};
+
+				adx@2903b00 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							adx4_in: endpoint {
+								remote-endpoint = <&xbar_adx4_in>;
+							};
+						};
+
+						adx4_out1_port: port@1 {
+							reg = <1>;
+
+							adx4_out1: endpoint {
+								remote-endpoint = <&xbar_adx4_out1>;
+							};
+						};
+
+						adx4_out2_port: port@2 {
+							reg = <2>;
+
+							adx4_out2: endpoint {
+								remote-endpoint = <&xbar_adx4_out2>;
+							};
+						};
+
+						adx4_out3_port: port@3 {
+							reg = <3>;
+
+							adx4_out3: endpoint {
+								remote-endpoint = <&xbar_adx4_out3>;
+							};
+						};
+
+						adx4_out4_port: port@4 {
+							reg = <4>;
+
+							adx4_out4: endpoint {
+								remote-endpoint = <&xbar_adx4_out4>;
+							};
+						};
+					};
+				};
+
+				dmic@2904200 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							dmic3_cif: endpoint {
+								remote-endpoint = <&xbar_dmic3>;
+							};
+						};
+
+						dmic3_port: port@1 {
+							reg = <1>;
+
+							dmic3_dap: endpoint {
+								/* placeholder for external codec */
+							};
+						};
+					};
+				};
+
+				processing-engine@2908000 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0x0>;
+
+							ope1_cif_in_ep: endpoint {
+								remote-endpoint = <&xbar_ope1_in_ep>;
+							};
+						};
+
+						ope1_out_port: port@1 {
+							reg = <0x1>;
+
+							ope1_cif_out_ep: endpoint {
+								remote-endpoint = <&xbar_ope1_out_ep>;
+							};
+						};
+					};
+				};
+
+				mvc@290a000 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							mvc1_cif_in: endpoint {
+								remote-endpoint = <&xbar_mvc1_in>;
+							};
+						};
+
+						mvc1_out_port: port@1 {
+							reg = <1>;
+
+							mvc1_cif_out: endpoint {
+								remote-endpoint = <&xbar_mvc1_out>;
+							};
+						};
+					};
+				};
+
+				mvc@290a200 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							mvc2_cif_in: endpoint {
+								remote-endpoint = <&xbar_mvc2_in>;
+							};
+						};
+
+						mvc2_out_port: port@1 {
+							reg = <1>;
+
+							mvc2_cif_out: endpoint {
+								remote-endpoint = <&xbar_mvc2_out>;
+							};
+						};
+					};
+				};
+
+				amixer@290bb00 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0x0>;
+
+							mix_in1: endpoint {
+								remote-endpoint = <&xbar_mix_in1>;
+							};
+						};
+
+						port@1 {
+							reg = <0x1>;
+
+							mix_in2: endpoint {
+								remote-endpoint = <&xbar_mix_in2>;
+							};
+						};
+
+						port@2 {
+							reg = <0x2>;
+
+							mix_in3: endpoint {
+								remote-endpoint = <&xbar_mix_in3>;
+							};
+						};
+
+						port@3 {
+							reg = <0x3>;
+
+							mix_in4: endpoint {
+								remote-endpoint = <&xbar_mix_in4>;
+							};
+						};
+
+						port@4 {
+							reg = <0x4>;
+
+							mix_in5: endpoint {
+								remote-endpoint = <&xbar_mix_in5>;
+							};
+						};
+
+						port@5 {
+							reg = <0x5>;
+
+							mix_in6: endpoint {
+								remote-endpoint = <&xbar_mix_in6>;
+							};
+						};
+
+						port@6 {
+							reg = <0x6>;
+
+							mix_in7: endpoint {
+								remote-endpoint = <&xbar_mix_in7>;
+							};
+						};
+
+						port@7 {
+							reg = <0x7>;
+
+							mix_in8: endpoint {
+								remote-endpoint = <&xbar_mix_in8>;
+							};
+						};
+
+						port@8 {
+							reg = <0x8>;
+
+							mix_in9: endpoint {
+								remote-endpoint = <&xbar_mix_in9>;
+							};
+						};
+
+						port@9 {
+							reg = <0x9>;
+
+							mix_in10: endpoint {
+								remote-endpoint = <&xbar_mix_in10>;
+							};
+						};
+
+						mix_out1_port: port@a {
+							reg = <0xa>;
+
+							mix_out1: endpoint {
+								remote-endpoint = <&xbar_mix_out1>;
+							};
+						};
+
+						mix_out2_port: port@b {
+							reg = <0xb>;
+
+							mix_out2: endpoint {
+								remote-endpoint = <&xbar_mix_out2>;
+							};
+						};
+
+						mix_out3_port: port@c {
+							reg = <0xc>;
+
+							mix_out3: endpoint {
+								remote-endpoint = <&xbar_mix_out3>;
+							};
+						};
+
+						mix_out4_port: port@d {
+							reg = <0xd>;
+
+							mix_out4: endpoint {
+								remote-endpoint = <&xbar_mix_out4>;
+							};
+						};
+
+						mix_out5_port: port@e {
+							reg = <0xe>;
+
+							mix_out5: endpoint {
+								remote-endpoint = <&xbar_mix_out5>;
+							};
+						};
+					};
+				};
+
+				admaif@290f000 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						admaif0_port: port@0 {
+							reg = <0x0>;
+
+							admaif0: endpoint {
+								remote-endpoint = <&xbar_admaif0>;
+							};
+						};
+
+						admaif1_port: port@1 {
+							reg = <0x1>;
+
+							admaif1: endpoint {
+								remote-endpoint = <&xbar_admaif1>;
+							};
+						};
+
+						admaif2_port: port@2 {
+							reg = <0x2>;
+
+							admaif2: endpoint {
+								remote-endpoint = <&xbar_admaif2>;
+							};
+						};
+
+						admaif3_port: port@3 {
+							reg = <0x3>;
+
+							admaif3: endpoint {
+								remote-endpoint = <&xbar_admaif3>;
+							};
+						};
+
+						admaif4_port: port@4 {
+							reg = <0x4>;
+
+							admaif4: endpoint {
+								remote-endpoint = <&xbar_admaif4>;
+							};
+						};
+
+						admaif5_port: port@5 {
+							reg = <0x5>;
+
+							admaif5: endpoint {
+								remote-endpoint = <&xbar_admaif5>;
+							};
+						};
+
+						admaif6_port: port@6 {
+							reg = <0x6>;
+
+							admaif6: endpoint {
+								remote-endpoint = <&xbar_admaif6>;
+							};
+						};
+
+						admaif7_port: port@7 {
+							reg = <0x7>;
+
+							admaif7: endpoint {
+								remote-endpoint = <&xbar_admaif7>;
+							};
+						};
+
+						admaif8_port: port@8 {
+							reg = <0x8>;
+
+							admaif8: endpoint {
+								remote-endpoint = <&xbar_admaif8>;
+							};
+						};
+
+						admaif9_port: port@9 {
+							reg = <0x9>;
+
+							admaif9: endpoint {
+								remote-endpoint = <&xbar_admaif9>;
+							};
+						};
+
+						admaif10_port: port@a {
+							reg = <0xa>;
+
+							admaif10: endpoint {
+								remote-endpoint = <&xbar_admaif10>;
+							};
+						};
+
+						admaif11_port: port@b {
+							reg = <0xb>;
+
+							admaif11: endpoint {
+								remote-endpoint = <&xbar_admaif11>;
+							};
+						};
+
+						admaif12_port: port@c {
+							reg = <0xc>;
+
+							admaif12: endpoint {
+								remote-endpoint = <&xbar_admaif12>;
+							};
+						};
+
+						admaif13_port: port@d {
+							reg = <0xd>;
+
+							admaif13: endpoint {
+								remote-endpoint = <&xbar_admaif13>;
+							};
+						};
+
+						admaif14_port: port@e {
+							reg = <0xe>;
+
+							admaif14: endpoint {
+								remote-endpoint = <&xbar_admaif14>;
+							};
+						};
+
+						admaif15_port: port@f {
+							reg = <0xf>;
+
+							admaif15: endpoint {
+								remote-endpoint = <&xbar_admaif15>;
+							};
+						};
+
+						admaif16_port: port@10 {
+							reg = <0x10>;
+
+							admaif16: endpoint {
+								remote-endpoint = <&xbar_admaif16>;
+							};
+						};
+
+						admaif17_port: port@11 {
+							reg = <0x11>;
+
+							admaif17: endpoint {
+								remote-endpoint = <&xbar_admaif17>;
+							};
+						};
+
+						admaif18_port: port@12 {
+							reg = <0x12>;
+
+							admaif18: endpoint {
+								remote-endpoint = <&xbar_admaif18>;
+							};
+						};
+
+						admaif19_port: port@13 {
+							reg = <0x13>;
+
+							admaif19: endpoint {
+								remote-endpoint = <&xbar_admaif19>;
+							};
+						};
+					};
+				};
+
+				asrc@2910000 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0x0>;
+
+							asrc_in1_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in1_ep>;
+							};
+						};
+
+						port@1 {
+							reg = <0x1>;
+
+							asrc_in2_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in2_ep>;
+							};
+						};
+
+						port@2 {
+							reg = <0x2>;
+
+							asrc_in3_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in3_ep>;
+							};
+						};
+
+						port@3 {
+							reg = <0x3>;
+
+							asrc_in4_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in4_ep>;
+							};
+						};
+
+						port@4 {
+							reg = <0x4>;
+
+							asrc_in5_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in5_ep>;
+							};
+						};
+
+						port@5 {
+							reg = <0x5>;
+
+							asrc_in6_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in6_ep>;
+							};
+						};
+
+						port@6 {
+							reg = <0x6>;
+
+							asrc_in7_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in7_ep>;
+							};
+						};
+
+						asrc_out1_port: port@7 {
+							reg = <0x7>;
+
+							asrc_out1_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_out1_ep>;
+							};
+						};
+
+						asrc_out2_port: port@8 {
+							reg = <0x8>;
+
+							asrc_out2_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_out2_ep>;
+							};
+						};
+
+						asrc_out3_port: port@9 {
+							reg = <0x9>;
+
+							asrc_out3_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_out3_ep>;
+							};
+						};
+
+						asrc_out4_port: port@a {
+							reg = <0xa>;
+
+							asrc_out4_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_out4_ep>;
+							};
+						};
+
+						asrc_out5_port: port@b {
+							reg = <0xb>;
+
+							asrc_out5_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_out5_ep>;
+							};
+						};
+
+						asrc_out6_port:	port@c {
+							reg = <0xc>;
+
+							asrc_out6_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_out6_ep>;
+							};
+						};
+					};
+				};
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0x0>;
+
+						xbar_admaif0: endpoint {
+							remote-endpoint = <&admaif0>;
+						};
+					};
+
+					port@1 {
+						reg = <0x1>;
+
+						xbar_admaif1: endpoint {
+							remote-endpoint = <&admaif1>;
+						};
+					};
+
+					port@2 {
+						reg = <0x2>;
+
+						xbar_admaif2: endpoint {
+							remote-endpoint = <&admaif2>;
+						};
+					};
+
+					port@3 {
+						reg = <0x3>;
+
+						xbar_admaif3: endpoint {
+							remote-endpoint = <&admaif3>;
+						};
+					};
+
+					port@4 {
+						reg = <0x4>;
+
+						xbar_admaif4: endpoint {
+							remote-endpoint = <&admaif4>;
+						};
+					};
+
+					port@5 {
+						reg = <0x5>;
+
+						xbar_admaif5: endpoint {
+							remote-endpoint = <&admaif5>;
+						};
+					};
+
+					port@6 {
+						reg = <0x6>;
+
+						xbar_admaif6: endpoint {
+							remote-endpoint = <&admaif6>;
+						};
+					};
+
+					port@7 {
+						reg = <0x7>;
+
+						xbar_admaif7: endpoint {
+							remote-endpoint = <&admaif7>;
+						};
+					};
+
+					port@8 {
+						reg = <0x8>;
+
+						xbar_admaif8: endpoint {
+							remote-endpoint = <&admaif8>;
+						};
+					};
+
+					port@9 {
+						reg = <0x9>;
+
+						xbar_admaif9: endpoint {
+							remote-endpoint = <&admaif9>;
+						};
+					};
+
+					port@a {
+						reg = <0xa>;
+
+						xbar_admaif10: endpoint {
+							remote-endpoint = <&admaif10>;
+						};
+					};
+
+					port@b {
+						reg = <0xb>;
+
+						xbar_admaif11: endpoint {
+							remote-endpoint = <&admaif11>;
+						};
+					};
+
+					port@c {
+						reg = <0xc>;
+
+						xbar_admaif12: endpoint {
+							remote-endpoint = <&admaif12>;
+						};
+					};
+
+					port@d {
+						reg = <0xd>;
+
+						xbar_admaif13: endpoint {
+							remote-endpoint = <&admaif13>;
+						};
+					};
+
+					port@e {
+						reg = <0xe>;
+
+						xbar_admaif14: endpoint {
+							remote-endpoint = <&admaif14>;
+						};
+					};
+
+					port@f {
+						reg = <0xf>;
+
+						xbar_admaif15: endpoint {
+							remote-endpoint = <&admaif15>;
+						};
+					};
+
+					port@10 {
+						reg = <0x10>;
+
+						xbar_admaif16: endpoint {
+							remote-endpoint = <&admaif16>;
+						};
+					};
+
+					port@11 {
+						reg = <0x11>;
+
+						xbar_admaif17: endpoint {
+							remote-endpoint = <&admaif17>;
+						};
+					};
+
+					port@12 {
+						reg = <0x12>;
+
+						xbar_admaif18: endpoint {
+							remote-endpoint = <&admaif18>;
+						};
+					};
+
+					port@13 {
+						reg = <0x13>;
+
+						xbar_admaif19: endpoint {
+							remote-endpoint = <&admaif19>;
+						};
+					};
+
+					xbar_i2s1_port: port@14 {
+						reg = <0x14>;
+
+						xbar_i2s1: endpoint {
+							remote-endpoint = <&i2s1_cif>;
+						};
+					};
+
+					xbar_i2s2_port: port@15 {
+						reg = <0x15>;
+
+						xbar_i2s2: endpoint {
+							remote-endpoint = <&i2s2_cif>;
+						};
+					};
+
+					xbar_i2s4_port: port@17 {
+						reg = <0x17>;
+
+						xbar_i2s4: endpoint {
+							remote-endpoint = <&i2s4_cif>;
+						};
+					};
+
+					xbar_i2s6_port: port@19 {
+						reg = <0x19>;
+
+						xbar_i2s6: endpoint {
+							remote-endpoint = <&i2s6_cif>;
+						};
+					};
+
+					xbar_dmic3_port: port@1c {
+						reg = <0x1c>;
+
+						xbar_dmic3: endpoint {
+							remote-endpoint = <&dmic3_cif>;
+						};
+					};
+
+					xbar_sfc1_in_port: port@20 {
+						reg = <0x20>;
+
+						xbar_sfc1_in: endpoint {
+							remote-endpoint = <&sfc1_cif_in>;
+						};
+					};
+
+					port@21 {
+						reg = <0x21>;
+
+						xbar_sfc1_out: endpoint {
+							remote-endpoint = <&sfc1_cif_out>;
+						};
+					};
+
+					xbar_sfc2_in_port: port@22 {
+						reg = <0x22>;
+
+						xbar_sfc2_in: endpoint {
+							remote-endpoint = <&sfc2_cif_in>;
+						};
+					};
+
+					port@23 {
+						reg = <0x23>;
+
+						xbar_sfc2_out: endpoint {
+							remote-endpoint = <&sfc2_cif_out>;
+						};
+					};
+
+					xbar_sfc3_in_port: port@24 {
+						reg = <0x24>;
+
+						xbar_sfc3_in: endpoint {
+							remote-endpoint = <&sfc3_cif_in>;
+						};
+					};
+
+					port@25 {
+						reg = <0x25>;
+
+						xbar_sfc3_out: endpoint {
+							remote-endpoint = <&sfc3_cif_out>;
+						};
+					};
+
+					xbar_sfc4_in_port: port@26 {
+						reg = <0x26>;
+
+						xbar_sfc4_in: endpoint {
+							remote-endpoint = <&sfc4_cif_in>;
+						};
+					};
+
+					port@27 {
+						reg = <0x27>;
+
+						xbar_sfc4_out: endpoint {
+							remote-endpoint = <&sfc4_cif_out>;
+						};
+					};
+
+					xbar_mvc1_in_port: port@28 {
+						reg = <0x28>;
+
+						xbar_mvc1_in: endpoint {
+							remote-endpoint = <&mvc1_cif_in>;
+						};
+					};
+
+					port@29 {
+						reg = <0x29>;
+
+						xbar_mvc1_out: endpoint {
+							remote-endpoint = <&mvc1_cif_out>;
+						};
+					};
+
+					xbar_mvc2_in_port: port@2a {
+						reg = <0x2a>;
+
+						xbar_mvc2_in: endpoint {
+							remote-endpoint = <&mvc2_cif_in>;
+						};
+					};
+
+					port@2b {
+						reg = <0x2b>;
+
+						xbar_mvc2_out: endpoint {
+							remote-endpoint = <&mvc2_cif_out>;
+						};
+					};
+
+					xbar_amx1_in1_port: port@2c {
+						reg = <0x2c>;
+
+						xbar_amx1_in1: endpoint {
+							remote-endpoint = <&amx1_in1>;
+						};
+					};
+
+					xbar_amx1_in2_port: port@2d {
+						reg = <0x2d>;
+
+						xbar_amx1_in2: endpoint {
+							remote-endpoint = <&amx1_in2>;
+						};
+					};
+
+					xbar_amx1_in3_port: port@2e {
+						reg = <0x2e>;
+
+						xbar_amx1_in3: endpoint {
+							remote-endpoint = <&amx1_in3>;
+						};
+					};
+
+					xbar_amx1_in4_port: port@2f {
+						reg = <0x2f>;
+
+						xbar_amx1_in4: endpoint {
+							remote-endpoint = <&amx1_in4>;
+						};
+					};
+
+					port@30 {
+						reg = <0x30>;
+
+						xbar_amx1_out: endpoint {
+							remote-endpoint = <&amx1_out>;
+						};
+					};
+
+					xbar_amx2_in1_port: port@31 {
+						reg = <0x31>;
+
+						xbar_amx2_in1: endpoint {
+							remote-endpoint = <&amx2_in1>;
+						};
+					};
+
+					xbar_amx2_in2_port: port@32 {
+						reg = <0x32>;
+
+						xbar_amx2_in2: endpoint {
+							remote-endpoint = <&amx2_in2>;
+						};
+					};
+
+					xbar_amx2_in3_port: port@33 {
+						reg = <0x33>;
+
+						xbar_amx2_in3: endpoint {
+							remote-endpoint = <&amx2_in3>;
+						};
+					};
+
+					xbar_amx2_in4_port: port@34 {
+						reg = <0x34>;
+
+						xbar_amx2_in4: endpoint {
+							remote-endpoint = <&amx2_in4>;
+						};
+					};
+
+					port@35 {
+						reg = <0x35>;
+
+						xbar_amx2_out: endpoint {
+							remote-endpoint = <&amx2_out>;
+						};
+					};
+
+					xbar_amx3_in1_port: port@36 {
+						reg = <0x36>;
+
+						xbar_amx3_in1: endpoint {
+							remote-endpoint = <&amx3_in1>;
+						};
+					};
+
+					xbar_amx3_in2_port: port@37 {
+						reg = <0x37>;
+
+						xbar_amx3_in2: endpoint {
+							remote-endpoint = <&amx3_in2>;
+						};
+					};
+
+					xbar_amx3_in3_port: port@38 {
+						reg = <0x38>;
+
+						xbar_amx3_in3: endpoint {
+							remote-endpoint = <&amx3_in3>;
+						};
+					};
+
+					xbar_amx3_in4_port: port@39 {
+						reg = <0x39>;
+
+						xbar_amx3_in4: endpoint {
+							remote-endpoint = <&amx3_in4>;
+						};
+					};
+
+					port@3a {
+						reg = <0x3a>;
+
+						xbar_amx3_out: endpoint {
+							remote-endpoint = <&amx3_out>;
+						};
+					};
+
+					xbar_amx4_in1_port: port@3b {
+						reg = <0x3b>;
+
+						xbar_amx4_in1: endpoint {
+							remote-endpoint = <&amx4_in1>;
+						};
+					};
+
+					xbar_amx4_in2_port: port@3c {
+						reg = <0x3c>;
+
+						xbar_amx4_in2: endpoint {
+							remote-endpoint = <&amx4_in2>;
+						};
+					};
+
+					xbar_amx4_in3_port: port@3d {
+						reg = <0x3d>;
+
+						xbar_amx4_in3: endpoint {
+							remote-endpoint = <&amx4_in3>;
+						};
+					};
+
+					xbar_amx4_in4_port: port@3e {
+						reg = <0x3e>;
+
+						xbar_amx4_in4: endpoint {
+							remote-endpoint = <&amx4_in4>;
+						};
+					};
+
+					port@3f {
+						reg = <0x3f>;
+
+						xbar_amx4_out: endpoint {
+							remote-endpoint = <&amx4_out>;
+						};
+					};
+
+					xbar_adx1_in_port: port@40 {
+						reg = <0x40>;
+
+						xbar_adx1_in: endpoint {
+							remote-endpoint = <&adx1_in>;
+						};
+					};
+
+					port@41 {
+						reg = <0x41>;
+
+						xbar_adx1_out1: endpoint {
+							remote-endpoint = <&adx1_out1>;
+						};
+					};
+
+					port@42 {
+						reg = <0x42>;
+
+						xbar_adx1_out2: endpoint {
+							remote-endpoint = <&adx1_out2>;
+						};
+					};
+
+					port@43 {
+						reg = <0x43>;
+
+						xbar_adx1_out3: endpoint {
+							remote-endpoint = <&adx1_out3>;
+						};
+					};
+
+					port@44 {
+						reg = <0x44>;
+
+						xbar_adx1_out4: endpoint {
+							remote-endpoint = <&adx1_out4>;
+						};
+					};
+
+					xbar_adx2_in_port: port@45 {
+						reg = <0x45>;
+
+						xbar_adx2_in: endpoint {
+							remote-endpoint = <&adx2_in>;
+						};
+					};
+
+					port@46 {
+						reg = <0x46>;
+
+						xbar_adx2_out1: endpoint {
+							remote-endpoint = <&adx2_out1>;
+						};
+					};
+
+					port@47 {
+						reg = <0x47>;
+
+						xbar_adx2_out2: endpoint {
+							remote-endpoint = <&adx2_out2>;
+						};
+					};
+
+					port@48 {
+						reg = <0x48>;
+
+						xbar_adx2_out3: endpoint {
+							remote-endpoint = <&adx2_out3>;
+						};
+					};
+
+					port@49 {
+						reg = <0x49>;
+
+						xbar_adx2_out4: endpoint {
+							remote-endpoint = <&adx2_out4>;
+						};
+					};
+
+					xbar_adx3_in_port: port@4a {
+						reg = <0x4a>;
+
+						xbar_adx3_in: endpoint {
+							remote-endpoint = <&adx3_in>;
+						};
+					};
+
+					port@4b {
+						reg = <0x4b>;
+
+						xbar_adx3_out1: endpoint {
+							remote-endpoint = <&adx3_out1>;
+						};
+					};
+
+					port@4c {
+						reg = <0x4c>;
+
+						xbar_adx3_out2: endpoint {
+							remote-endpoint = <&adx3_out2>;
+						};
+					};
+
+					port@4d {
+						reg = <0x4d>;
+
+						xbar_adx3_out3: endpoint {
+							remote-endpoint = <&adx3_out3>;
+						};
+					};
+
+					port@4e {
+						reg = <0x4e>;
+
+						xbar_adx3_out4: endpoint {
+							remote-endpoint = <&adx3_out4>;
+						};
+					};
+
+					xbar_adx4_in_port: port@4f {
+						reg = <0x4f>;
+
+						xbar_adx4_in: endpoint {
+							remote-endpoint = <&adx4_in>;
+						};
+					};
+
+					port@50 {
+						reg = <0x50>;
+
+						xbar_adx4_out1: endpoint {
+							remote-endpoint = <&adx4_out1>;
+						};
+					};
+
+					port@51 {
+						reg = <0x51>;
+
+						xbar_adx4_out2: endpoint {
+							remote-endpoint = <&adx4_out2>;
+						};
+					};
+
+					port@52 {
+						reg = <0x52>;
+
+						xbar_adx4_out3: endpoint {
+							remote-endpoint = <&adx4_out3>;
+						};
+					};
+
+					port@53 {
+						reg = <0x53>;
+
+						xbar_adx4_out4: endpoint {
+							remote-endpoint = <&adx4_out4>;
+						};
+					};
+
+					xbar_mix_in1_port: port@54 {
+						reg = <0x54>;
+
+						xbar_mix_in1: endpoint {
+							remote-endpoint = <&mix_in1>;
+						};
+					};
+
+					xbar_mix_in2_port: port@55 {
+						reg = <0x55>;
+
+						xbar_mix_in2: endpoint {
+							remote-endpoint = <&mix_in2>;
+						};
+					};
+
+					xbar_mix_in3_port: port@56 {
+						reg = <0x56>;
+
+						xbar_mix_in3: endpoint {
+							remote-endpoint = <&mix_in3>;
+						};
+					};
+
+					xbar_mix_in4_port: port@57 {
+						reg = <0x57>;
+
+						xbar_mix_in4: endpoint {
+							remote-endpoint = <&mix_in4>;
+						};
+					};
+
+					xbar_mix_in5_port: port@58 {
+						reg = <0x58>;
+
+						xbar_mix_in5: endpoint {
+							remote-endpoint = <&mix_in5>;
+						};
+					};
+
+					xbar_mix_in6_port: port@59 {
+						reg = <0x59>;
+
+						xbar_mix_in6: endpoint {
+							remote-endpoint = <&mix_in6>;
+						};
+					};
+
+					xbar_mix_in7_port: port@5a {
+						reg = <0x5a>;
+
+						xbar_mix_in7: endpoint {
+							remote-endpoint = <&mix_in7>;
+						};
+					};
+
+					xbar_mix_in8_port: port@5b {
+						reg = <0x5b>;
+
+						xbar_mix_in8: endpoint {
+							remote-endpoint = <&mix_in8>;
+						};
+					};
+
+					xbar_mix_in9_port: port@5c {
+						reg = <0x5c>;
+
+						xbar_mix_in9: endpoint {
+							remote-endpoint = <&mix_in9>;
+						};
+					};
+
+					xbar_mix_in10_port: port@5d {
+						reg = <0x5d>;
+
+						xbar_mix_in10: endpoint {
+							remote-endpoint = <&mix_in10>;
+						};
+					};
+
+					port@5e {
+						reg = <0x5e>;
+
+						xbar_mix_out1: endpoint {
+							remote-endpoint = <&mix_out1>;
+						};
+					};
+
+					port@5f {
+						reg = <0x5f>;
+
+						xbar_mix_out2: endpoint {
+							remote-endpoint = <&mix_out2>;
+						};
+					};
+
+					port@60 {
+						reg = <0x60>;
+
+						xbar_mix_out3: endpoint {
+							remote-endpoint = <&mix_out3>;
+						};
+					};
+
+					port@61 {
+						reg = <0x61>;
+
+						xbar_mix_out4: endpoint {
+							remote-endpoint = <&mix_out4>;
+						};
+					};
+
+					port@62 {
+						reg = <0x62>;
+
+						xbar_mix_out5: endpoint {
+							remote-endpoint = <&mix_out5>;
+						};
+					};
+
+					xbar_asrc_in1_port: port@63 {
+						reg = <0x63>;
+
+						xbar_asrc_in1_ep: endpoint {
+							remote-endpoint = <&asrc_in1_ep>;
+						};
+					};
+
+					port@64 {
+						reg = <0x64>;
+
+						xbar_asrc_out1_ep: endpoint {
+							remote-endpoint = <&asrc_out1_ep>;
+						};
+					};
+
+					xbar_asrc_in2_port: port@65 {
+						reg = <0x65>;
+
+						xbar_asrc_in2_ep: endpoint {
+							remote-endpoint = <&asrc_in2_ep>;
+						};
+					};
+
+					port@66 {
+						reg = <0x66>;
+
+						xbar_asrc_out2_ep: endpoint {
+							remote-endpoint = <&asrc_out2_ep>;
+						};
+					};
+
+					xbar_asrc_in3_port: port@67 {
+						reg = <0x67>;
+
+						xbar_asrc_in3_ep: endpoint {
+							remote-endpoint = <&asrc_in3_ep>;
+						};
+					};
+
+					port@68 {
+						reg = <0x68>;
+
+						xbar_asrc_out3_ep: endpoint {
+							remote-endpoint = <&asrc_out3_ep>;
+						};
+					};
+
+					xbar_asrc_in4_port: port@69 {
+						reg = <0x69>;
+
+						xbar_asrc_in4_ep: endpoint {
+							remote-endpoint = <&asrc_in4_ep>;
+						};
+					};
+
+					port@6a {
+						reg = <0x6a>;
+
+						xbar_asrc_out4_ep: endpoint {
+							remote-endpoint = <&asrc_out4_ep>;
+						};
+					};
+
+					xbar_asrc_in5_port: port@6b {
+						reg = <0x6b>;
+
+						xbar_asrc_in5_ep: endpoint {
+							remote-endpoint = <&asrc_in5_ep>;
+						};
+					};
+
+					port@6c {
+						reg = <0x6c>;
+
+						xbar_asrc_out5_ep: endpoint {
+							remote-endpoint = <&asrc_out5_ep>;
+						};
+					};
+
+					xbar_asrc_in6_port: port@6d {
+						reg = <0x6d>;
+
+						xbar_asrc_in6_ep: endpoint {
+							remote-endpoint = <&asrc_in6_ep>;
+						};
+					};
+
+					port@6e {
+						reg = <0x6e>;
+
+						xbar_asrc_out6_ep: endpoint {
+							remote-endpoint = <&asrc_out6_ep>;
+						};
+					};
+
+					xbar_asrc_in7_port: port@6f {
+						reg = <0x6f>;
+
+						xbar_asrc_in7_ep: endpoint {
+							remote-endpoint = <&asrc_in7_ep>;
+						};
+					};
+
+					xbar_ope1_in_port: port@70 {
+						reg = <0x70>;
+
+						xbar_ope1_in_ep: endpoint {
+							remote-endpoint = <&ope1_cif_in_ep>;
+						};
+					};
+
+					port@71 {
+						reg = <0x71>;
+
+						xbar_ope1_out_ep: endpoint {
+							remote-endpoint = <&ope1_cif_out_ep>;
+						};
+					};
+				};
+			};
+
+			dma-controller@2930000 {
+				status = "okay";
+			};
+
+			interrupt-controller@2a40000 {
+				status = "okay";
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
index cd13cf2381dd..387bb9e3f66c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
@@ -3,7 +3,6 @@
 
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/input/gpio-keys.h>
-#include <dt-bindings/sound/rt5640.h>
 
 #include "tegra234-p3701-0000.dtsi"
 #include "tegra234-p3737-0000.dtsi"
@@ -24,1990 +23,6 @@
 	};
 
 	bus@0 {
-		aconnect@2900000 {
-			status = "okay";
-
-			ahub@2900800 {
-				status = "okay";
-
-				i2s@2901000 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							i2s1_cif: endpoint {
-								remote-endpoint = <&xbar_i2s1>;
-							};
-						};
-
-						i2s1_port: port@1 {
-							reg = <1>;
-
-							i2s1_dap: endpoint {
-								dai-format = "i2s";
-								remote-endpoint = <&rt5640_ep>;
-							};
-						};
-					};
-				};
-
-				i2s@2901100 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							i2s2_cif: endpoint {
-								remote-endpoint = <&xbar_i2s2>;
-							};
-						};
-
-						i2s2_port: port@1 {
-							reg = <1>;
-
-							i2s2_dap: endpoint {
-								dai-format = "i2s";
-								/* placeholder for external codec */
-							};
-						};
-					};
-				};
-
-				i2s@2901300 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							i2s4_cif: endpoint {
-								remote-endpoint = <&xbar_i2s4>;
-							};
-						};
-
-						i2s4_port: port@1 {
-							reg = <1>;
-
-							i2s4_dap: endpoint {
-								dai-format = "i2s";
-								/* placeholder for external codec */
-							};
-						};
-					};
-				};
-
-				i2s@2901500 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							i2s6_cif: endpoint {
-								remote-endpoint = <&xbar_i2s6>;
-							};
-						};
-
-						i2s6_port: port@1 {
-							reg = <1>;
-
-							i2s6_dap: endpoint {
-								dai-format = "i2s";
-								/* placeholder for external codec */
-							};
-						};
-					};
-				};
-
-				sfc@2902000 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							sfc1_cif_in: endpoint {
-								remote-endpoint = <&xbar_sfc1_in>;
-							};
-						};
-
-						sfc1_out_port: port@1 {
-							reg = <1>;
-
-							sfc1_cif_out: endpoint {
-								remote-endpoint = <&xbar_sfc1_out>;
-							};
-						};
-					};
-				};
-
-				sfc@2902200 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							sfc2_cif_in: endpoint {
-								remote-endpoint = <&xbar_sfc2_in>;
-							};
-						};
-
-						sfc2_out_port: port@1 {
-							reg = <1>;
-
-							sfc2_cif_out: endpoint {
-								remote-endpoint = <&xbar_sfc2_out>;
-							};
-						};
-					};
-				};
-
-				sfc@2902400 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							sfc3_cif_in: endpoint {
-								remote-endpoint = <&xbar_sfc3_in>;
-							};
-						};
-
-						sfc3_out_port: port@1 {
-							reg = <1>;
-
-							sfc3_cif_out: endpoint {
-								remote-endpoint = <&xbar_sfc3_out>;
-							};
-						};
-					};
-				};
-
-				sfc@2902600 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							sfc4_cif_in: endpoint {
-								remote-endpoint = <&xbar_sfc4_in>;
-							};
-						};
-
-						sfc4_out_port: port@1 {
-							reg = <1>;
-
-							sfc4_cif_out: endpoint {
-								remote-endpoint = <&xbar_sfc4_out>;
-							};
-						};
-					};
-				};
-
-				amx@2903000 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							amx1_in1: endpoint {
-								remote-endpoint = <&xbar_amx1_in1>;
-							};
-						};
-
-						port@1 {
-							reg = <1>;
-
-							amx1_in2: endpoint {
-								remote-endpoint = <&xbar_amx1_in2>;
-							};
-						};
-
-						port@2 {
-							reg = <2>;
-
-							amx1_in3: endpoint {
-								remote-endpoint = <&xbar_amx1_in3>;
-							};
-						};
-
-						port@3 {
-							reg = <3>;
-
-							amx1_in4: endpoint {
-								remote-endpoint = <&xbar_amx1_in4>;
-							};
-						};
-
-						amx1_out_port: port@4 {
-							reg = <4>;
-
-							amx1_out: endpoint {
-								remote-endpoint = <&xbar_amx1_out>;
-							};
-						};
-					};
-				};
-
-				amx@2903100 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							amx2_in1: endpoint {
-								remote-endpoint = <&xbar_amx2_in1>;
-							};
-						};
-
-						port@1 {
-							reg = <1>;
-
-							amx2_in2: endpoint {
-								remote-endpoint = <&xbar_amx2_in2>;
-							};
-						};
-
-						port@2 {
-							reg = <2>;
-
-							amx2_in3: endpoint {
-								remote-endpoint = <&xbar_amx2_in3>;
-							};
-						};
-
-						port@3 {
-							reg = <3>;
-
-							amx2_in4: endpoint {
-								remote-endpoint = <&xbar_amx2_in4>;
-							};
-						};
-
-						amx2_out_port: port@4 {
-							reg = <4>;
-
-							amx2_out: endpoint {
-								remote-endpoint = <&xbar_amx2_out>;
-							};
-						};
-					};
-				};
-
-				amx@2903200 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							amx3_in1: endpoint {
-								remote-endpoint = <&xbar_amx3_in1>;
-							};
-						};
-
-						port@1 {
-							reg = <1>;
-
-							amx3_in2: endpoint {
-								remote-endpoint = <&xbar_amx3_in2>;
-							};
-						};
-
-						port@2 {
-							reg = <2>;
-
-							amx3_in3: endpoint {
-								remote-endpoint = <&xbar_amx3_in3>;
-							};
-						};
-
-						port@3 {
-							reg = <3>;
-
-							amx3_in4: endpoint {
-								remote-endpoint = <&xbar_amx3_in4>;
-							};
-						};
-
-						amx3_out_port: port@4 {
-							reg = <4>;
-
-							amx3_out: endpoint {
-								remote-endpoint = <&xbar_amx3_out>;
-							};
-						};
-					};
-				};
-
-				amx@2903300 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							amx4_in1: endpoint {
-								remote-endpoint = <&xbar_amx4_in1>;
-							};
-						};
-
-						port@1 {
-							reg = <1>;
-
-							amx4_in2: endpoint {
-								remote-endpoint = <&xbar_amx4_in2>;
-							};
-						};
-
-						port@2 {
-							reg = <2>;
-
-							amx4_in3: endpoint {
-								remote-endpoint = <&xbar_amx4_in3>;
-							};
-						};
-
-						port@3 {
-							reg = <3>;
-
-							amx4_in4: endpoint {
-								remote-endpoint = <&xbar_amx4_in4>;
-							};
-						};
-
-						amx4_out_port: port@4 {
-							reg = <4>;
-
-							amx4_out: endpoint {
-								remote-endpoint = <&xbar_amx4_out>;
-							};
-						};
-					};
-				};
-
-				adx@2903800 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							adx1_in: endpoint {
-								remote-endpoint = <&xbar_adx1_in>;
-							};
-						};
-
-						adx1_out1_port: port@1 {
-							reg = <1>;
-
-							adx1_out1: endpoint {
-								remote-endpoint = <&xbar_adx1_out1>;
-							};
-						};
-
-						adx1_out2_port: port@2 {
-							reg = <2>;
-
-							adx1_out2: endpoint {
-								remote-endpoint = <&xbar_adx1_out2>;
-							};
-						};
-
-						adx1_out3_port: port@3 {
-							reg = <3>;
-
-							adx1_out3: endpoint {
-								remote-endpoint = <&xbar_adx1_out3>;
-							};
-						};
-
-						adx1_out4_port: port@4 {
-							reg = <4>;
-
-							adx1_out4: endpoint {
-								remote-endpoint = <&xbar_adx1_out4>;
-							};
-						};
-					};
-				};
-
-				adx@2903900 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							adx2_in: endpoint {
-								remote-endpoint = <&xbar_adx2_in>;
-							};
-						};
-
-						adx2_out1_port: port@1 {
-							reg = <1>;
-
-							adx2_out1: endpoint {
-								remote-endpoint = <&xbar_adx2_out1>;
-							};
-						};
-
-						adx2_out2_port: port@2 {
-							reg = <2>;
-
-							adx2_out2: endpoint {
-								remote-endpoint = <&xbar_adx2_out2>;
-							};
-						};
-
-						adx2_out3_port: port@3 {
-							reg = <3>;
-
-							adx2_out3: endpoint {
-								remote-endpoint = <&xbar_adx2_out3>;
-							};
-						};
-
-						adx2_out4_port: port@4 {
-							reg = <4>;
-
-							adx2_out4: endpoint {
-								remote-endpoint = <&xbar_adx2_out4>;
-							};
-						};
-					};
-				};
-
-				adx@2903a00 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							adx3_in: endpoint {
-								remote-endpoint = <&xbar_adx3_in>;
-							};
-						};
-
-						adx3_out1_port: port@1 {
-							reg = <1>;
-
-							adx3_out1: endpoint {
-								remote-endpoint = <&xbar_adx3_out1>;
-							};
-						};
-
-						adx3_out2_port: port@2 {
-							reg = <2>;
-
-							adx3_out2: endpoint {
-								remote-endpoint = <&xbar_adx3_out2>;
-							};
-						};
-
-						adx3_out3_port: port@3 {
-							reg = <3>;
-
-							adx3_out3: endpoint {
-								remote-endpoint = <&xbar_adx3_out3>;
-							};
-						};
-
-						adx3_out4_port: port@4 {
-							reg = <4>;
-
-							adx3_out4: endpoint {
-								remote-endpoint = <&xbar_adx3_out4>;
-							};
-						};
-					};
-				};
-
-				adx@2903b00 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							adx4_in: endpoint {
-								remote-endpoint = <&xbar_adx4_in>;
-							};
-						};
-
-						adx4_out1_port: port@1 {
-							reg = <1>;
-
-							adx4_out1: endpoint {
-								remote-endpoint = <&xbar_adx4_out1>;
-							};
-						};
-
-						adx4_out2_port: port@2 {
-							reg = <2>;
-
-							adx4_out2: endpoint {
-								remote-endpoint = <&xbar_adx4_out2>;
-							};
-						};
-
-						adx4_out3_port: port@3 {
-							reg = <3>;
-
-							adx4_out3: endpoint {
-								remote-endpoint = <&xbar_adx4_out3>;
-							};
-						};
-
-						adx4_out4_port: port@4 {
-							reg = <4>;
-
-							adx4_out4: endpoint {
-								remote-endpoint = <&xbar_adx4_out4>;
-							};
-						};
-					};
-				};
-
-				dmic@2904200 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							dmic3_cif: endpoint {
-								remote-endpoint = <&xbar_dmic3>;
-							};
-						};
-
-						dmic3_port: port@1 {
-							reg = <1>;
-
-							dmic3_dap: endpoint {
-								/* placeholder for external codec */
-							};
-						};
-					};
-				};
-
-				processing-engine@2908000 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0x0>;
-
-							ope1_cif_in_ep: endpoint {
-								remote-endpoint = <&xbar_ope1_in_ep>;
-							};
-						};
-
-						ope1_out_port: port@1 {
-							reg = <0x1>;
-
-							ope1_cif_out_ep: endpoint {
-								remote-endpoint = <&xbar_ope1_out_ep>;
-							};
-						};
-					};
-				};
-
-				mvc@290a000 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							mvc1_cif_in: endpoint {
-								remote-endpoint = <&xbar_mvc1_in>;
-							};
-						};
-
-						mvc1_out_port: port@1 {
-							reg = <1>;
-
-							mvc1_cif_out: endpoint {
-								remote-endpoint = <&xbar_mvc1_out>;
-							};
-						};
-					};
-				};
-
-				mvc@290a200 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0>;
-
-							mvc2_cif_in: endpoint {
-								remote-endpoint = <&xbar_mvc2_in>;
-							};
-						};
-
-						mvc2_out_port: port@1 {
-							reg = <1>;
-
-							mvc2_cif_out: endpoint {
-								remote-endpoint = <&xbar_mvc2_out>;
-							};
-						};
-					};
-				};
-
-				amixer@290bb00 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0x0>;
-
-							mix_in1: endpoint {
-								remote-endpoint = <&xbar_mix_in1>;
-							};
-						};
-
-						port@1 {
-							reg = <0x1>;
-
-							mix_in2: endpoint {
-								remote-endpoint = <&xbar_mix_in2>;
-							};
-						};
-
-						port@2 {
-							reg = <0x2>;
-
-							mix_in3: endpoint {
-								remote-endpoint = <&xbar_mix_in3>;
-							};
-						};
-
-						port@3 {
-							reg = <0x3>;
-
-							mix_in4: endpoint {
-								remote-endpoint = <&xbar_mix_in4>;
-							};
-						};
-
-						port@4 {
-							reg = <0x4>;
-
-							mix_in5: endpoint {
-								remote-endpoint = <&xbar_mix_in5>;
-							};
-						};
-
-						port@5 {
-							reg = <0x5>;
-
-							mix_in6: endpoint {
-								remote-endpoint = <&xbar_mix_in6>;
-							};
-						};
-
-						port@6 {
-							reg = <0x6>;
-
-							mix_in7: endpoint {
-								remote-endpoint = <&xbar_mix_in7>;
-							};
-						};
-
-						port@7 {
-							reg = <0x7>;
-
-							mix_in8: endpoint {
-								remote-endpoint = <&xbar_mix_in8>;
-							};
-						};
-
-						port@8 {
-							reg = <0x8>;
-
-							mix_in9: endpoint {
-								remote-endpoint = <&xbar_mix_in9>;
-							};
-						};
-
-						port@9 {
-							reg = <0x9>;
-
-							mix_in10: endpoint {
-								remote-endpoint = <&xbar_mix_in10>;
-							};
-						};
-
-						mix_out1_port: port@a {
-							reg = <0xa>;
-
-							mix_out1: endpoint {
-								remote-endpoint = <&xbar_mix_out1>;
-							};
-						};
-
-						mix_out2_port: port@b {
-							reg = <0xb>;
-
-							mix_out2: endpoint {
-								remote-endpoint = <&xbar_mix_out2>;
-							};
-						};
-
-						mix_out3_port: port@c {
-							reg = <0xc>;
-
-							mix_out3: endpoint {
-								remote-endpoint = <&xbar_mix_out3>;
-							};
-						};
-
-						mix_out4_port: port@d {
-							reg = <0xd>;
-
-							mix_out4: endpoint {
-								remote-endpoint = <&xbar_mix_out4>;
-							};
-						};
-
-						mix_out5_port: port@e {
-							reg = <0xe>;
-
-							mix_out5: endpoint {
-								remote-endpoint = <&xbar_mix_out5>;
-							};
-						};
-					};
-				};
-
-				admaif@290f000 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						admaif0_port: port@0 {
-							reg = <0x0>;
-
-							admaif0: endpoint {
-								remote-endpoint = <&xbar_admaif0>;
-							};
-						};
-
-						admaif1_port: port@1 {
-							reg = <0x1>;
-
-							admaif1: endpoint {
-								remote-endpoint = <&xbar_admaif1>;
-							};
-						};
-
-						admaif2_port: port@2 {
-							reg = <0x2>;
-
-							admaif2: endpoint {
-								remote-endpoint = <&xbar_admaif2>;
-							};
-						};
-
-						admaif3_port: port@3 {
-							reg = <0x3>;
-
-							admaif3: endpoint {
-								remote-endpoint = <&xbar_admaif3>;
-							};
-						};
-
-						admaif4_port: port@4 {
-							reg = <0x4>;
-
-							admaif4: endpoint {
-								remote-endpoint = <&xbar_admaif4>;
-							};
-						};
-
-						admaif5_port: port@5 {
-							reg = <0x5>;
-
-							admaif5: endpoint {
-								remote-endpoint = <&xbar_admaif5>;
-							};
-						};
-
-						admaif6_port: port@6 {
-							reg = <0x6>;
-
-							admaif6: endpoint {
-								remote-endpoint = <&xbar_admaif6>;
-							};
-						};
-
-						admaif7_port: port@7 {
-							reg = <0x7>;
-
-							admaif7: endpoint {
-								remote-endpoint = <&xbar_admaif7>;
-							};
-						};
-
-						admaif8_port: port@8 {
-							reg = <0x8>;
-
-							admaif8: endpoint {
-								remote-endpoint = <&xbar_admaif8>;
-							};
-						};
-
-						admaif9_port: port@9 {
-							reg = <0x9>;
-
-							admaif9: endpoint {
-								remote-endpoint = <&xbar_admaif9>;
-							};
-						};
-
-						admaif10_port: port@a {
-							reg = <0xa>;
-
-							admaif10: endpoint {
-								remote-endpoint = <&xbar_admaif10>;
-							};
-						};
-
-						admaif11_port: port@b {
-							reg = <0xb>;
-
-							admaif11: endpoint {
-								remote-endpoint = <&xbar_admaif11>;
-							};
-						};
-
-						admaif12_port: port@c {
-							reg = <0xc>;
-
-							admaif12: endpoint {
-								remote-endpoint = <&xbar_admaif12>;
-							};
-						};
-
-						admaif13_port: port@d {
-							reg = <0xd>;
-
-							admaif13: endpoint {
-								remote-endpoint = <&xbar_admaif13>;
-							};
-						};
-
-						admaif14_port: port@e {
-							reg = <0xe>;
-
-							admaif14: endpoint {
-								remote-endpoint = <&xbar_admaif14>;
-							};
-						};
-
-						admaif15_port: port@f {
-							reg = <0xf>;
-
-							admaif15: endpoint {
-								remote-endpoint = <&xbar_admaif15>;
-							};
-						};
-
-						admaif16_port: port@10 {
-							reg = <0x10>;
-
-							admaif16: endpoint {
-								remote-endpoint = <&xbar_admaif16>;
-							};
-						};
-
-						admaif17_port: port@11 {
-							reg = <0x11>;
-
-							admaif17: endpoint {
-								remote-endpoint = <&xbar_admaif17>;
-							};
-						};
-
-						admaif18_port: port@12 {
-							reg = <0x12>;
-
-							admaif18: endpoint {
-								remote-endpoint = <&xbar_admaif18>;
-							};
-						};
-
-						admaif19_port: port@13 {
-							reg = <0x13>;
-
-							admaif19: endpoint {
-								remote-endpoint = <&xbar_admaif19>;
-							};
-						};
-					};
-				};
-
-				asrc@2910000 {
-					status = "okay";
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port@0 {
-							reg = <0x0>;
-
-							asrc_in1_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_in1_ep>;
-							};
-						};
-
-						port@1 {
-							reg = <0x1>;
-
-							asrc_in2_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_in2_ep>;
-							};
-						};
-
-						port@2 {
-							reg = <0x2>;
-
-							asrc_in3_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_in3_ep>;
-							};
-						};
-
-						port@3 {
-							reg = <0x3>;
-
-							asrc_in4_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_in4_ep>;
-							};
-						};
-
-						port@4 {
-							reg = <0x4>;
-
-							asrc_in5_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_in5_ep>;
-							};
-						};
-
-						port@5 {
-							reg = <0x5>;
-
-							asrc_in6_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_in6_ep>;
-							};
-						};
-
-						port@6 {
-							reg = <0x6>;
-
-							asrc_in7_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_in7_ep>;
-							};
-						};
-
-						asrc_out1_port: port@7 {
-							reg = <0x7>;
-
-							asrc_out1_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_out1_ep>;
-							};
-						};
-
-						asrc_out2_port: port@8 {
-							reg = <0x8>;
-
-							asrc_out2_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_out2_ep>;
-							};
-						};
-
-						asrc_out3_port: port@9 {
-							reg = <0x9>;
-
-							asrc_out3_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_out3_ep>;
-							};
-						};
-
-						asrc_out4_port: port@a {
-							reg = <0xa>;
-
-							asrc_out4_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_out4_ep>;
-							};
-						};
-
-						asrc_out5_port: port@b {
-							reg = <0xb>;
-
-							asrc_out5_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_out5_ep>;
-							};
-						};
-
-						asrc_out6_port:	port@c {
-							reg = <0xc>;
-
-							asrc_out6_ep: endpoint {
-								remote-endpoint = <&xbar_asrc_out6_ep>;
-							};
-						};
-					};
-				};
-
-				ports {
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					port@0 {
-						reg = <0x0>;
-
-						xbar_admaif0: endpoint {
-							remote-endpoint = <&admaif0>;
-						};
-					};
-
-					port@1 {
-						reg = <0x1>;
-
-						xbar_admaif1: endpoint {
-							remote-endpoint = <&admaif1>;
-						};
-					};
-
-					port@2 {
-						reg = <0x2>;
-
-						xbar_admaif2: endpoint {
-							remote-endpoint = <&admaif2>;
-						};
-					};
-
-					port@3 {
-						reg = <0x3>;
-
-						xbar_admaif3: endpoint {
-							remote-endpoint = <&admaif3>;
-						};
-					};
-
-					port@4 {
-						reg = <0x4>;
-
-						xbar_admaif4: endpoint {
-							remote-endpoint = <&admaif4>;
-						};
-					};
-
-					port@5 {
-						reg = <0x5>;
-
-						xbar_admaif5: endpoint {
-							remote-endpoint = <&admaif5>;
-						};
-					};
-
-					port@6 {
-						reg = <0x6>;
-
-						xbar_admaif6: endpoint {
-							remote-endpoint = <&admaif6>;
-						};
-					};
-
-					port@7 {
-						reg = <0x7>;
-
-						xbar_admaif7: endpoint {
-							remote-endpoint = <&admaif7>;
-						};
-					};
-
-					port@8 {
-						reg = <0x8>;
-
-						xbar_admaif8: endpoint {
-							remote-endpoint = <&admaif8>;
-						};
-					};
-
-					port@9 {
-						reg = <0x9>;
-
-						xbar_admaif9: endpoint {
-							remote-endpoint = <&admaif9>;
-						};
-					};
-
-					port@a {
-						reg = <0xa>;
-
-						xbar_admaif10: endpoint {
-							remote-endpoint = <&admaif10>;
-						};
-					};
-
-					port@b {
-						reg = <0xb>;
-
-						xbar_admaif11: endpoint {
-							remote-endpoint = <&admaif11>;
-						};
-					};
-
-					port@c {
-						reg = <0xc>;
-
-						xbar_admaif12: endpoint {
-							remote-endpoint = <&admaif12>;
-						};
-					};
-
-					port@d {
-						reg = <0xd>;
-
-						xbar_admaif13: endpoint {
-							remote-endpoint = <&admaif13>;
-						};
-					};
-
-					port@e {
-						reg = <0xe>;
-
-						xbar_admaif14: endpoint {
-							remote-endpoint = <&admaif14>;
-						};
-					};
-
-					port@f {
-						reg = <0xf>;
-
-						xbar_admaif15: endpoint {
-							remote-endpoint = <&admaif15>;
-						};
-					};
-
-					port@10 {
-						reg = <0x10>;
-
-						xbar_admaif16: endpoint {
-							remote-endpoint = <&admaif16>;
-						};
-					};
-
-					port@11 {
-						reg = <0x11>;
-
-						xbar_admaif17: endpoint {
-							remote-endpoint = <&admaif17>;
-						};
-					};
-
-					port@12 {
-						reg = <0x12>;
-
-						xbar_admaif18: endpoint {
-							remote-endpoint = <&admaif18>;
-						};
-					};
-
-					port@13 {
-						reg = <0x13>;
-
-						xbar_admaif19: endpoint {
-							remote-endpoint = <&admaif19>;
-						};
-					};
-
-					xbar_i2s1_port: port@14 {
-						reg = <0x14>;
-
-						xbar_i2s1: endpoint {
-							remote-endpoint = <&i2s1_cif>;
-						};
-					};
-
-					xbar_i2s2_port: port@15 {
-						reg = <0x15>;
-
-						xbar_i2s2: endpoint {
-							remote-endpoint = <&i2s2_cif>;
-						};
-					};
-
-					xbar_i2s4_port: port@17 {
-						reg = <0x17>;
-
-						xbar_i2s4: endpoint {
-							remote-endpoint = <&i2s4_cif>;
-						};
-					};
-
-					xbar_i2s6_port: port@19 {
-						reg = <0x19>;
-
-						xbar_i2s6: endpoint {
-							remote-endpoint = <&i2s6_cif>;
-						};
-					};
-
-					xbar_dmic3_port: port@1c {
-						reg = <0x1c>;
-
-						xbar_dmic3: endpoint {
-							remote-endpoint = <&dmic3_cif>;
-						};
-					};
-
-					xbar_sfc1_in_port: port@20 {
-						reg = <0x20>;
-
-						xbar_sfc1_in: endpoint {
-							remote-endpoint = <&sfc1_cif_in>;
-						};
-					};
-
-					port@21 {
-						reg = <0x21>;
-
-						xbar_sfc1_out: endpoint {
-							remote-endpoint = <&sfc1_cif_out>;
-						};
-					};
-
-					xbar_sfc2_in_port: port@22 {
-						reg = <0x22>;
-
-						xbar_sfc2_in: endpoint {
-							remote-endpoint = <&sfc2_cif_in>;
-						};
-					};
-
-					port@23 {
-						reg = <0x23>;
-
-						xbar_sfc2_out: endpoint {
-							remote-endpoint = <&sfc2_cif_out>;
-						};
-					};
-
-					xbar_sfc3_in_port: port@24 {
-						reg = <0x24>;
-
-						xbar_sfc3_in: endpoint {
-							remote-endpoint = <&sfc3_cif_in>;
-						};
-					};
-
-					port@25 {
-						reg = <0x25>;
-
-						xbar_sfc3_out: endpoint {
-							remote-endpoint = <&sfc3_cif_out>;
-						};
-					};
-
-					xbar_sfc4_in_port: port@26 {
-						reg = <0x26>;
-
-						xbar_sfc4_in: endpoint {
-							remote-endpoint = <&sfc4_cif_in>;
-						};
-					};
-
-					port@27 {
-						reg = <0x27>;
-
-						xbar_sfc4_out: endpoint {
-							remote-endpoint = <&sfc4_cif_out>;
-						};
-					};
-
-					xbar_mvc1_in_port: port@28 {
-						reg = <0x28>;
-
-						xbar_mvc1_in: endpoint {
-							remote-endpoint = <&mvc1_cif_in>;
-						};
-					};
-
-					port@29 {
-						reg = <0x29>;
-
-						xbar_mvc1_out: endpoint {
-							remote-endpoint = <&mvc1_cif_out>;
-						};
-					};
-
-					xbar_mvc2_in_port: port@2a {
-						reg = <0x2a>;
-
-						xbar_mvc2_in: endpoint {
-							remote-endpoint = <&mvc2_cif_in>;
-						};
-					};
-
-					port@2b {
-						reg = <0x2b>;
-
-						xbar_mvc2_out: endpoint {
-							remote-endpoint = <&mvc2_cif_out>;
-						};
-					};
-
-					xbar_amx1_in1_port: port@2c {
-						reg = <0x2c>;
-
-						xbar_amx1_in1: endpoint {
-							remote-endpoint = <&amx1_in1>;
-						};
-					};
-
-					xbar_amx1_in2_port: port@2d {
-						reg = <0x2d>;
-
-						xbar_amx1_in2: endpoint {
-							remote-endpoint = <&amx1_in2>;
-						};
-					};
-
-					xbar_amx1_in3_port: port@2e {
-						reg = <0x2e>;
-
-						xbar_amx1_in3: endpoint {
-							remote-endpoint = <&amx1_in3>;
-						};
-					};
-
-					xbar_amx1_in4_port: port@2f {
-						reg = <0x2f>;
-
-						xbar_amx1_in4: endpoint {
-							remote-endpoint = <&amx1_in4>;
-						};
-					};
-
-					port@30 {
-						reg = <0x30>;
-
-						xbar_amx1_out: endpoint {
-							remote-endpoint = <&amx1_out>;
-						};
-					};
-
-					xbar_amx2_in1_port: port@31 {
-						reg = <0x31>;
-
-						xbar_amx2_in1: endpoint {
-							remote-endpoint = <&amx2_in1>;
-						};
-					};
-
-					xbar_amx2_in2_port: port@32 {
-						reg = <0x32>;
-
-						xbar_amx2_in2: endpoint {
-							remote-endpoint = <&amx2_in2>;
-						};
-					};
-
-					xbar_amx2_in3_port: port@33 {
-						reg = <0x33>;
-
-						xbar_amx2_in3: endpoint {
-							remote-endpoint = <&amx2_in3>;
-						};
-					};
-
-					xbar_amx2_in4_port: port@34 {
-						reg = <0x34>;
-
-						xbar_amx2_in4: endpoint {
-							remote-endpoint = <&amx2_in4>;
-						};
-					};
-
-					port@35 {
-						reg = <0x35>;
-
-						xbar_amx2_out: endpoint {
-							remote-endpoint = <&amx2_out>;
-						};
-					};
-
-					xbar_amx3_in1_port: port@36 {
-						reg = <0x36>;
-
-						xbar_amx3_in1: endpoint {
-							remote-endpoint = <&amx3_in1>;
-						};
-					};
-
-					xbar_amx3_in2_port: port@37 {
-						reg = <0x37>;
-
-						xbar_amx3_in2: endpoint {
-							remote-endpoint = <&amx3_in2>;
-						};
-					};
-
-					xbar_amx3_in3_port: port@38 {
-						reg = <0x38>;
-
-						xbar_amx3_in3: endpoint {
-							remote-endpoint = <&amx3_in3>;
-						};
-					};
-
-					xbar_amx3_in4_port: port@39 {
-						reg = <0x39>;
-
-						xbar_amx3_in4: endpoint {
-							remote-endpoint = <&amx3_in4>;
-						};
-					};
-
-					port@3a {
-						reg = <0x3a>;
-
-						xbar_amx3_out: endpoint {
-							remote-endpoint = <&amx3_out>;
-						};
-					};
-
-					xbar_amx4_in1_port: port@3b {
-						reg = <0x3b>;
-
-						xbar_amx4_in1: endpoint {
-							remote-endpoint = <&amx4_in1>;
-						};
-					};
-
-					xbar_amx4_in2_port: port@3c {
-						reg = <0x3c>;
-
-						xbar_amx4_in2: endpoint {
-							remote-endpoint = <&amx4_in2>;
-						};
-					};
-
-					xbar_amx4_in3_port: port@3d {
-						reg = <0x3d>;
-
-						xbar_amx4_in3: endpoint {
-							remote-endpoint = <&amx4_in3>;
-						};
-					};
-
-					xbar_amx4_in4_port: port@3e {
-						reg = <0x3e>;
-
-						xbar_amx4_in4: endpoint {
-							remote-endpoint = <&amx4_in4>;
-						};
-					};
-
-					port@3f {
-						reg = <0x3f>;
-
-						xbar_amx4_out: endpoint {
-							remote-endpoint = <&amx4_out>;
-						};
-					};
-
-					xbar_adx1_in_port: port@40 {
-						reg = <0x40>;
-
-						xbar_adx1_in: endpoint {
-							remote-endpoint = <&adx1_in>;
-						};
-					};
-
-					port@41 {
-						reg = <0x41>;
-
-						xbar_adx1_out1: endpoint {
-							remote-endpoint = <&adx1_out1>;
-						};
-					};
-
-					port@42 {
-						reg = <0x42>;
-
-						xbar_adx1_out2: endpoint {
-							remote-endpoint = <&adx1_out2>;
-						};
-					};
-
-					port@43 {
-						reg = <0x43>;
-
-						xbar_adx1_out3: endpoint {
-							remote-endpoint = <&adx1_out3>;
-						};
-					};
-
-					port@44 {
-						reg = <0x44>;
-
-						xbar_adx1_out4: endpoint {
-							remote-endpoint = <&adx1_out4>;
-						};
-					};
-
-					xbar_adx2_in_port: port@45 {
-						reg = <0x45>;
-
-						xbar_adx2_in: endpoint {
-							remote-endpoint = <&adx2_in>;
-						};
-					};
-
-					port@46 {
-						reg = <0x46>;
-
-						xbar_adx2_out1: endpoint {
-							remote-endpoint = <&adx2_out1>;
-						};
-					};
-
-					port@47 {
-						reg = <0x47>;
-
-						xbar_adx2_out2: endpoint {
-							remote-endpoint = <&adx2_out2>;
-						};
-					};
-
-					port@48 {
-						reg = <0x48>;
-
-						xbar_adx2_out3: endpoint {
-							remote-endpoint = <&adx2_out3>;
-						};
-					};
-
-					port@49 {
-						reg = <0x49>;
-
-						xbar_adx2_out4: endpoint {
-							remote-endpoint = <&adx2_out4>;
-						};
-					};
-
-					xbar_adx3_in_port: port@4a {
-						reg = <0x4a>;
-
-						xbar_adx3_in: endpoint {
-							remote-endpoint = <&adx3_in>;
-						};
-					};
-
-					port@4b {
-						reg = <0x4b>;
-
-						xbar_adx3_out1: endpoint {
-							remote-endpoint = <&adx3_out1>;
-						};
-					};
-
-					port@4c {
-						reg = <0x4c>;
-
-						xbar_adx3_out2: endpoint {
-							remote-endpoint = <&adx3_out2>;
-						};
-					};
-
-					port@4d {
-						reg = <0x4d>;
-
-						xbar_adx3_out3: endpoint {
-							remote-endpoint = <&adx3_out3>;
-						};
-					};
-
-					port@4e {
-						reg = <0x4e>;
-
-						xbar_adx3_out4: endpoint {
-							remote-endpoint = <&adx3_out4>;
-						};
-					};
-
-					xbar_adx4_in_port: port@4f {
-						reg = <0x4f>;
-
-						xbar_adx4_in: endpoint {
-							remote-endpoint = <&adx4_in>;
-						};
-					};
-
-					port@50 {
-						reg = <0x50>;
-
-						xbar_adx4_out1: endpoint {
-							remote-endpoint = <&adx4_out1>;
-						};
-					};
-
-					port@51 {
-						reg = <0x51>;
-
-						xbar_adx4_out2: endpoint {
-							remote-endpoint = <&adx4_out2>;
-						};
-					};
-
-					port@52 {
-						reg = <0x52>;
-
-						xbar_adx4_out3: endpoint {
-							remote-endpoint = <&adx4_out3>;
-						};
-					};
-
-					port@53 {
-						reg = <0x53>;
-
-						xbar_adx4_out4: endpoint {
-							remote-endpoint = <&adx4_out4>;
-						};
-					};
-
-					xbar_mix_in1_port: port@54 {
-						reg = <0x54>;
-
-						xbar_mix_in1: endpoint {
-							remote-endpoint = <&mix_in1>;
-						};
-					};
-
-					xbar_mix_in2_port: port@55 {
-						reg = <0x55>;
-
-						xbar_mix_in2: endpoint {
-							remote-endpoint = <&mix_in2>;
-						};
-					};
-
-					xbar_mix_in3_port: port@56 {
-						reg = <0x56>;
-
-						xbar_mix_in3: endpoint {
-							remote-endpoint = <&mix_in3>;
-						};
-					};
-
-					xbar_mix_in4_port: port@57 {
-						reg = <0x57>;
-
-						xbar_mix_in4: endpoint {
-							remote-endpoint = <&mix_in4>;
-						};
-					};
-
-					xbar_mix_in5_port: port@58 {
-						reg = <0x58>;
-
-						xbar_mix_in5: endpoint {
-							remote-endpoint = <&mix_in5>;
-						};
-					};
-
-					xbar_mix_in6_port: port@59 {
-						reg = <0x59>;
-
-						xbar_mix_in6: endpoint {
-							remote-endpoint = <&mix_in6>;
-						};
-					};
-
-					xbar_mix_in7_port: port@5a {
-						reg = <0x5a>;
-
-						xbar_mix_in7: endpoint {
-							remote-endpoint = <&mix_in7>;
-						};
-					};
-
-					xbar_mix_in8_port: port@5b {
-						reg = <0x5b>;
-
-						xbar_mix_in8: endpoint {
-							remote-endpoint = <&mix_in8>;
-						};
-					};
-
-					xbar_mix_in9_port: port@5c {
-						reg = <0x5c>;
-
-						xbar_mix_in9: endpoint {
-							remote-endpoint = <&mix_in9>;
-						};
-					};
-
-					xbar_mix_in10_port: port@5d {
-						reg = <0x5d>;
-
-						xbar_mix_in10: endpoint {
-							remote-endpoint = <&mix_in10>;
-						};
-					};
-
-					port@5e {
-						reg = <0x5e>;
-
-						xbar_mix_out1: endpoint {
-							remote-endpoint = <&mix_out1>;
-						};
-					};
-
-					port@5f {
-						reg = <0x5f>;
-
-						xbar_mix_out2: endpoint {
-							remote-endpoint = <&mix_out2>;
-						};
-					};
-
-					port@60 {
-						reg = <0x60>;
-
-						xbar_mix_out3: endpoint {
-							remote-endpoint = <&mix_out3>;
-						};
-					};
-
-					port@61 {
-						reg = <0x61>;
-
-						xbar_mix_out4: endpoint {
-							remote-endpoint = <&mix_out4>;
-						};
-					};
-
-					port@62 {
-						reg = <0x62>;
-
-						xbar_mix_out5: endpoint {
-							remote-endpoint = <&mix_out5>;
-						};
-					};
-
-					xbar_asrc_in1_port: port@63 {
-						reg = <0x63>;
-
-						xbar_asrc_in1_ep: endpoint {
-							remote-endpoint = <&asrc_in1_ep>;
-						};
-					};
-
-					port@64 {
-						reg = <0x64>;
-
-						xbar_asrc_out1_ep: endpoint {
-							remote-endpoint = <&asrc_out1_ep>;
-						};
-					};
-
-					xbar_asrc_in2_port: port@65 {
-						reg = <0x65>;
-
-						xbar_asrc_in2_ep: endpoint {
-							remote-endpoint = <&asrc_in2_ep>;
-						};
-					};
-
-					port@66 {
-						reg = <0x66>;
-
-						xbar_asrc_out2_ep: endpoint {
-							remote-endpoint = <&asrc_out2_ep>;
-						};
-					};
-
-					xbar_asrc_in3_port: port@67 {
-						reg = <0x67>;
-
-						xbar_asrc_in3_ep: endpoint {
-							remote-endpoint = <&asrc_in3_ep>;
-						};
-					};
-
-					port@68 {
-						reg = <0x68>;
-
-						xbar_asrc_out3_ep: endpoint {
-							remote-endpoint = <&asrc_out3_ep>;
-						};
-					};
-
-					xbar_asrc_in4_port: port@69 {
-						reg = <0x69>;
-
-						xbar_asrc_in4_ep: endpoint {
-							remote-endpoint = <&asrc_in4_ep>;
-						};
-					};
-
-					port@6a {
-						reg = <0x6a>;
-
-						xbar_asrc_out4_ep: endpoint {
-							remote-endpoint = <&asrc_out4_ep>;
-						};
-					};
-
-					xbar_asrc_in5_port: port@6b {
-						reg = <0x6b>;
-
-						xbar_asrc_in5_ep: endpoint {
-							remote-endpoint = <&asrc_in5_ep>;
-						};
-					};
-
-					port@6c {
-						reg = <0x6c>;
-
-						xbar_asrc_out5_ep: endpoint {
-							remote-endpoint = <&asrc_out5_ep>;
-						};
-					};
-
-					xbar_asrc_in6_port: port@6d {
-						reg = <0x6d>;
-
-						xbar_asrc_in6_ep: endpoint {
-							remote-endpoint = <&asrc_in6_ep>;
-						};
-					};
-
-					port@6e {
-						reg = <0x6e>;
-
-						xbar_asrc_out6_ep: endpoint {
-							remote-endpoint = <&asrc_out6_ep>;
-						};
-					};
-
-					xbar_asrc_in7_port: port@6f {
-						reg = <0x6f>;
-
-						xbar_asrc_in7_ep: endpoint {
-							remote-endpoint = <&asrc_in7_ep>;
-						};
-					};
-
-					xbar_ope1_in_port: port@70 {
-						reg = <0x70>;
-
-						xbar_ope1_in_ep: endpoint {
-							remote-endpoint = <&ope1_cif_in_ep>;
-						};
-					};
-
-					port@71 {
-						reg = <0x71>;
-
-						xbar_ope1_out_ep: endpoint {
-							remote-endpoint = <&ope1_cif_out_ep>;
-						};
-					};
-				};
-			};
-
-			dma-controller@2930000 {
-				status = "okay";
-			};
-
-			interrupt-controller@2a40000 {
-				status = "okay";
-			};
-		};
-
 		serial@3100000 {
 			compatible = "nvidia,tegra194-hsuart";
 			status = "okay";
@@ -2018,30 +33,6 @@
 			status = "okay";
 		};
 
-		i2c@31e0000 {
-			status = "okay";
-
-			audio-codec@1c {
-				compatible = "realtek,rt5640";
-				reg = <0x1c>;
-				interrupt-parent = <&gpio>;
-				interrupts = <TEGRA234_MAIN_GPIO(AC, 5) GPIO_ACTIVE_HIGH>;
-				clocks = <&bpmp TEGRA234_CLK_AUD_MCLK>;
-				clock-names = "mclk";
-				realtek,dmic1-data-pin = <RT5640_DMIC1_DATA_PIN_NONE>;
-				realtek,dmic2-data-pin = <RT5640_DMIC2_DATA_PIN_NONE>;
-				realtek,jack-detect-source = <RT5640_JD_SRC_HDA_HEADER>;
-				sound-name-prefix = "CVB-RT";
-
-				port {
-					rt5640_ep: endpoint {
-						remote-endpoint = <&i2s1_dap>;
-						mclk-fs = <256>;
-					};
-				};
-			};
-		};
-
 		pwm@32a0000 {
 			assigned-clocks = <&bpmp TEGRA234_CLK_PWM3>;
 			assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLP_OUT0>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi
index d94147f22ebf..5c72347d47a5 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi
@@ -1,9 +1,50 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <dt-bindings/sound/rt5640.h>
+
 / {
 	compatible = "nvidia,p3737-0000";
 
 	bus@0 {
+		i2c@31e0000 {
+			status = "okay";
+
+			audio-codec@1c {
+				compatible = "realtek,rt5640";
+				reg = <0x1c>;
+				interrupt-parent = <&gpio>;
+				interrupts = <TEGRA234_MAIN_GPIO(AC, 5) GPIO_ACTIVE_HIGH>;
+				clocks = <&bpmp TEGRA234_CLK_AUD_MCLK>;
+				clock-names = "mclk";
+				realtek,dmic1-data-pin = <RT5640_DMIC1_DATA_PIN_NONE>;
+				realtek,dmic2-data-pin = <RT5640_DMIC2_DATA_PIN_NONE>;
+				realtek,jack-detect-source = <RT5640_JD_SRC_HDA_HEADER>;
+				sound-name-prefix = "CVB-RT";
+
+				port {
+					rt5640_ep: endpoint {
+						remote-endpoint = <&i2s1_dap>;
+						mclk-fs = <256>;
+					};
+				};
+			};
+		};
+
+		aconnect@2900000 {
+			ahub@2900800 {
+				i2s@2901100 {
+					ports {
+						port@1 {
+							i2s1_dap_ep: endpoint {
+								dai-format = "i2s";
+								remote-endpoint = <&rt5640_ep>;
+							};
+						};
+					};
+				};
+			};
+		};
+
 		i2c@3160000 {
 			status = "okay";
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dts
index 43d797e5544f..2b7856b303b4 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dts
@@ -64,10 +64,6 @@
 			phy-names = "p2u-0", "p2u-1";
 		};
 
-		aconnect@2900000 {
-			status = "okay";
-		};
-
 		serial@3100000 {
 			compatible = "nvidia,tegra194-hsuart";
 			status = "okay";
@@ -103,7 +99,7 @@
 		};
 
 		hda@3510000 {
-			nvidia,model = "NVIDIA IGX HDA";
+			nvidia,model = "NVIDIA Jetson IGX Orin HDA";
 			status = "okay";
 		};
 
@@ -151,4 +147,89 @@
 	serial {
 		status = "okay";
 	};
+
+	sound {
+		status = "okay";
+
+		compatible = "nvidia,tegra186-audio-graph-card";
+
+		dais = /* ADMAIF (FE) Ports */
+		       <&admaif0_port>, <&admaif1_port>, <&admaif2_port>, <&admaif3_port>,
+		       <&admaif4_port>, <&admaif5_port>, <&admaif6_port>, <&admaif7_port>,
+		       <&admaif8_port>, <&admaif9_port>, <&admaif10_port>, <&admaif11_port>,
+		       <&admaif12_port>, <&admaif13_port>, <&admaif14_port>, <&admaif15_port>,
+		       <&admaif16_port>, <&admaif17_port>, <&admaif18_port>, <&admaif19_port>,
+		       /* XBAR Ports */
+		       <&xbar_i2s1_port>, <&xbar_i2s2_port>, <&xbar_i2s4_port>,
+		       <&xbar_i2s6_port>, <&xbar_dmic3_port>,
+		       <&xbar_sfc1_in_port>, <&xbar_sfc2_in_port>,
+		       <&xbar_sfc3_in_port>, <&xbar_sfc4_in_port>,
+		       <&xbar_mvc1_in_port>, <&xbar_mvc2_in_port>,
+		       <&xbar_amx1_in1_port>, <&xbar_amx1_in2_port>,
+		       <&xbar_amx1_in3_port>, <&xbar_amx1_in4_port>,
+		       <&xbar_amx2_in1_port>, <&xbar_amx2_in2_port>,
+		       <&xbar_amx2_in3_port>, <&xbar_amx2_in4_port>,
+		       <&xbar_amx3_in1_port>, <&xbar_amx3_in2_port>,
+		       <&xbar_amx3_in3_port>, <&xbar_amx3_in4_port>,
+		       <&xbar_amx4_in1_port>, <&xbar_amx4_in2_port>,
+		       <&xbar_amx4_in3_port>, <&xbar_amx4_in4_port>,
+		       <&xbar_adx1_in_port>, <&xbar_adx2_in_port>,
+		       <&xbar_adx3_in_port>, <&xbar_adx4_in_port>,
+		       <&xbar_mix_in1_port>, <&xbar_mix_in2_port>,
+		       <&xbar_mix_in3_port>, <&xbar_mix_in4_port>,
+		       <&xbar_mix_in5_port>, <&xbar_mix_in6_port>,
+		       <&xbar_mix_in7_port>, <&xbar_mix_in8_port>,
+		       <&xbar_mix_in9_port>, <&xbar_mix_in10_port>,
+		       <&xbar_asrc_in1_port>, <&xbar_asrc_in2_port>,
+		       <&xbar_asrc_in3_port>, <&xbar_asrc_in4_port>,
+		       <&xbar_asrc_in5_port>, <&xbar_asrc_in6_port>,
+		       <&xbar_asrc_in7_port>,
+		       <&xbar_ope1_in_port>,
+		       /* HW accelerators */
+		       <&sfc1_out_port>, <&sfc2_out_port>,
+		       <&sfc3_out_port>, <&sfc4_out_port>,
+		       <&mvc1_out_port>, <&mvc2_out_port>,
+		       <&amx1_out_port>, <&amx2_out_port>,
+		       <&amx3_out_port>, <&amx4_out_port>,
+		       <&adx1_out1_port>, <&adx1_out2_port>,
+		       <&adx1_out3_port>, <&adx1_out4_port>,
+		       <&adx2_out1_port>, <&adx2_out2_port>,
+		       <&adx2_out3_port>, <&adx2_out4_port>,
+		       <&adx3_out1_port>, <&adx3_out2_port>,
+		       <&adx3_out3_port>, <&adx3_out4_port>,
+		       <&adx4_out1_port>, <&adx4_out2_port>,
+		       <&adx4_out3_port>, <&adx4_out4_port>,
+		       <&mix_out1_port>, <&mix_out2_port>, <&mix_out3_port>,
+		       <&mix_out4_port>, <&mix_out5_port>,
+		       <&asrc_out1_port>, <&asrc_out2_port>, <&asrc_out3_port>,
+		       <&asrc_out4_port>, <&asrc_out5_port>, <&asrc_out6_port>,
+		       <&ope1_out_port>,
+		       /* BE I/O Ports */
+		       <&i2s1_port>, <&i2s2_port>, <&i2s4_port>, <&i2s6_port>,
+		       <&dmic3_port>;
+
+		label = "NVIDIA Jetson IGX Orin APE";
+
+		widgets = "Microphone",	"CVB-RT MIC Jack",
+			  "Microphone",	"CVB-RT MIC",
+			  "Headphone",	"CVB-RT HP Jack",
+			  "Speaker",	"CVB-RT SPK";
+
+		routing = /* I2S4 <-> RT5640 */
+			  "CVB-RT AIF1 Playback",	"I2S4 DAP-Playback",
+			  "I2S4 DAP-Capture",		"CVB-RT AIF1 Capture",
+			  /* RT5640 codec controls */
+			  "CVB-RT HP Jack",		"CVB-RT HPOL",
+			  "CVB-RT HP Jack",		"CVB-RT HPOR",
+			  "CVB-RT IN1P",		"CVB-RT MIC Jack",
+			  "CVB-RT IN2P",		"CVB-RT MIC Jack",
+			  "CVB-RT IN2N",		"CVB-RT MIC Jack",
+			  "CVB-RT IN3P",		"CVB-RT MIC Jack",
+			  "CVB-RT SPK",			"CVB-RT SPOLP",
+			  "CVB-RT SPK",			"CVB-RT SPORP",
+			  "CVB-RT SPK",			"CVB-RT LOUTL",
+			  "CVB-RT SPK",			"CVB-RT LOUTR",
+			  "CVB-RT DMIC1",		"CVB-RT MIC",
+			  "CVB-RT DMIC2",		"CVB-RT MIC";
+	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002.dtsi
index c95063b19321..6d7c74d25967 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002.dtsi
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <dt-bindings/sound/rt5640.h>
+
 / {
 	compatible = "nvidia,p3740-0002";
 
@@ -17,6 +19,60 @@
 				size = <256>;
 				read-only;
 			};
+
+			rt5640: audio-codec@1c {
+				compatible = "realtek,rt5640";
+				reg = <0x1c>;
+
+				clocks = <&bpmp TEGRA234_CLK_AUD_MCLK>;
+				clock-names = "mclk";
+
+				realtek,dmic1-data-pin = <RT5640_DMIC1_DATA_PIN_NONE>;
+				realtek,dmic2-data-pin = <RT5640_DMIC2_DATA_PIN_NONE>;
+				realtek,jack-detect-source = <RT5640_JD_SRC_HDA_HEADER>;
+
+				/* Codec IRQ output */
+				interrupt-parent = <&gpio>;
+				interrupts = <TEGRA234_MAIN_GPIO(F, 3) GPIO_ACTIVE_HIGH>;
+
+				#sound-dai-cells = <1>;
+				sound-name-prefix = "CVB-RT";
+
+				status = "okay";
+
+				port {
+					rt5640_ep: endpoint {
+						remote-endpoint = <&i2s4_dap_ep>;
+						mclk-fs = <256>;
+					};
+				};
+			};
+		};
+
+		aconnect@2900000 {
+			ahub@2900800 {
+				i2s@2901300 {
+					ports {
+						port@1 {
+							i2s4_dap_ep: endpoint {
+								dai-format = "i2s";
+								remote-endpoint = <&rt5640_ep>;
+							};
+						};
+					};
+				};
+
+				i2s@2901500 {
+					ports {
+						port@1 {
+							endpoint {
+							       bitclock-master;
+							       frame-master;
+							};
+						};
+					};
+				};
+			};
 		};
 
 		padctl@3520000 {
-- 
2.17.1

