Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9826F70C1C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbjEVPBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbjEVPBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:01:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95054115;
        Mon, 22 May 2023 08:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERVaeSr+Kld2wEgZv4pBjYa6gxusTbfZ0kJ8syQNcqj83S4TtqvlL97OqooktrtrUq7Tc7O1qK5PPuzf9w2NmsKaLsiHjQvFxwMek1EBISkQKjgxsGsM047A1Vr/BGJigtZVP1OgmLjdte/L+Cwr0xhriKT4XEQBda4QYUslxEW7Agqgv+dSQwzM5vlmbcgIN4Y5RHBzCVjQlcRzVM6lG6TZ1yj7CldUPBSSVY39Hh2XMPuf5k6Th3xEyEVXvdS1q1bpaFaGqU24dtD+UYjzKNJMSTASVxvRHB4XHDegmr3w3wpF4pcHc4p0sVBtXVKS72bykQuqUXt+qko0L2ZFjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHVx9hiAS4QeT8dNB0+8kNSaa2YUmaI91h4i76spYJw=;
 b=UXqkjEFhcpxgiaoE8vtMRlnWGHNwCUdwe0KID/vlofIm2CoOdKwvFRTJhvR4nis9mNjlXcfB68OWc58NKYIXXdMVRuCx4I93/aNcAgKxUCdx8q2gSYUwN1GRPy0GQnxu9Xfgcx3dGmfqBPlWoXJNYHzWnjzM+Bw5WzEtW8duFENNGV8/B56Q1nVaQYBtnGn4oO4O73SoLcG3NzBMHdIkWVlD3GxyJ5syIU0lutYYjuBMWsLLiwLO5cV9k6cnq0FAIF+1AYsuLkQLQT1+3+80LFgEoyzuqQ9/M5rr0C3e2m8qtjkukUmPR48lLsxmmOOKsZBsDdEpoBKa7H/dqrp8Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHVx9hiAS4QeT8dNB0+8kNSaa2YUmaI91h4i76spYJw=;
 b=KVDBUcD78Y09BEasUBpMtSrIULMaHdMoT+7qzVESucEYPMsXO6+g3V1TCRH15J7NRAo47MHBBeUB4PZ8isfdNU+hS4GwygVcNZCAFDWi2yXdgZP7Ks2OYDAT3/vpaPZYtnz6YRQqqBlEqZjOmttG7cnl73XGJ1dm7lcEc66Mj5o=
Received: from DS7PR03CA0285.namprd03.prod.outlook.com (2603:10b6:5:3ad::20)
 by CH2PR12MB4971.namprd12.prod.outlook.com (2603:10b6:610:6b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 15:01:11 +0000
Received: from DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::1f) by DS7PR03CA0285.outlook.office365.com
 (2603:10b6:5:3ad::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 15:01:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT088.mail.protection.outlook.com (10.13.172.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 15:01:10 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 10:00:56 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Parth Gajjar <parth.gajjar@amd.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 6/6] arm64: zynqmp: Used fixed-partitions for QSPI in k26
Date:   Mon, 22 May 2023 16:59:53 +0200
Message-ID: <7368dc772d8dc29477a880ac2065e2ecb98cf3f5.1684767562.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1684767562.git.michal.simek@amd.com>
References: <cover.1684767562.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5127; i=michal.simek@amd.com; h=from:subject:message-id; bh=4BxoH5GEkO+P7RNlBSyEwz59lTNpi7uO/qUt2btiaRc=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTs5vi5QdfrP/5edJ/R+/SkD4b+ZVv16rPe9C9Z+VmvJ PX19q37OmJZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBE9n5nmB+xKF5F9aBaXm9K brFsk7YPS1O9PMM8Ux2TiRlhL01u8r79uCNdd8enj5cLAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT088:EE_|CH2PR12MB4971:EE_
X-MS-Office365-Filtering-Correlation-Id: 663ec5f3-2e28-468d-f983-08db5ad56156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JT6NfnfGNx9qyPEGZGeIU+5p9PuiC2TV2uxRnFisCINRWEy4mLG1ecNI2VAHnPI/yepSsYlCaTcpfM6J/17JkkO2ZUbXDDfy/J93l4w8Qi7AXFEtuzPoG+6xxuk7hUDZ8e9xnNKIecIqNGfX+6X0GnvNkIEn0Tbg72aQR4voM2OPjOJeFilkWoYECVGgv+WlHpKUdF9lR1KaOjabiHSr0llFzRklDlV8wkypxsODUGjbkTen8QILg1hyP3gPw68v1y8s82wW5id2iuq8hv9rYoxF2gFScdws7LexB0Q9jfwbJxAICZ1PhyY/I4Bi8eCfol2nbbATp6aQZYt6W6+fzUUFkkOOQ7QyWlt8E7biNofb4pc89tALSlxhPhVMQskMGK871bKk+tP5Q5X5D8d9hJQyHGMZBVgmmz2nczxC91rNQjJC755/hfSTuG8aUtHEFDL9H6wOw2p9WxAuz/NwRguz4Eq6rDtbQRRR9ylEpMKj+89b0Y4x8+tSxr+e0E7mfSoCUfiveeGhAluS0yWRXuJRdYH1edkuPsZIx7iy8NBr0+RPFOaaF69tvBVgfHYJeMHW2DRbFZy+Varcks+QTAuWQF1VRrYF7zEa72PjP+5lzuNSpJ1ImMR7Lp7m9F2mZTG3d9nQ+VWzZCpDQY1Hb1sy+IH/IiXPTyzBnhIMkLAe/+Tn7lZa6qqAWTWAPIfCD+Byn8regxubvY1fPRytsc8kbml5dr3heNgM5CsYapBe/OB5myoOEZCGGoLDOBtMQDS7b8BeN8H4v0s8+m12HXr5haUorKh3fWsPxxm4VIU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(81166007)(356005)(82740400003)(40480700001)(40460700003)(86362001)(82310400005)(36756003)(426003)(16526019)(44832011)(8936002)(8676002)(336012)(7416002)(47076005)(2616005)(2906002)(186003)(54906003)(478600001)(41300700001)(316002)(4326008)(110136005)(26005)(5660300002)(6666004)(70206006)(70586007)(83380400001)(36860700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 15:01:10.9899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 663ec5f3-2e28-468d-f983-08db5ad56156
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4971
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

(no changes since v1)

---
 .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    | 169 +++++++++---------
 1 file changed, 88 insertions(+), 81 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index 84e18fdce775..dfd1a18f5a10 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -127,87 +127,94 @@ spi_flash: flash@0 { /* MT25QU512A */
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

