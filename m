Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90956F4521
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbjEBNil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbjEBNiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:38:13 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8B46A6E;
        Tue,  2 May 2023 06:37:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAniDlIsvSROindNHrBubh4xtuUTbaWeVXSCqYi5pJRuTRQ529Z3RFDsTNy7v+kHGYL/sm7RlBQ8JMx3zk2IpzJwRFyxSR9kOOvXXQdtM+FB5eKW4/ZNgMfgGwRzbBhHQdpbZkiZ3rJv/bGkTnACT24trIPOUwMl69qGgTarrw4TjmBDHpyxvV9+jgfakKfHyyH9NpSVFfHh013zwujo8BKs7BwfX8fRyW/r+8eo+10YpWTxXw8ugSzynOjDqsPzePaHTJ1avqS4BOz4Zdp6LPD8a3WwvPwYr2kRk2iaCWmgdh1P64HWHXrIyCKmuYkCZIIJBedykXt11fwB28rYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BC8/1UIWUCzF2+AMagPXK2xExd5k/3krlbzdrE323bg=;
 b=YPWQV2oN+tT1NvqL7CHS1BYBfhbDsD0jw7XSgzuWoHS6Hjs2/B4iMBYW6CRmlztVa34sMaZBy+T4zRsrYgqIdGatdpy/AJ7+jA7RUbXbp6pmHzeKwRMQ9tJ+18xNNdvIYMJ4TCpzWPy3AonfCJegYX8jKiaoM6LLoYo8Nc2WjQ1UCw8FznLcllP3v49Q/TZpC23ocdGntziVS6/iaAg01bvM0CNqgakXmM3mSFBIam7wDX169CziFF7hmKrCHuD3GwmvnsDFxnPgf6przXvuFgaVEiNt7nQU9qBq3xpxg5TSYz+VVijb0H0Gx8It7Ryy8j3+ihU8zC8IDYpsPHu9Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BC8/1UIWUCzF2+AMagPXK2xExd5k/3krlbzdrE323bg=;
 b=t8b/+DUGbopATHa7g8TNcFCYBZNjGnSUK9oscwjLqWOoZJtOV4XoZg5LAVGmqo9gPfZWcJFRN2hZbjcYU1zC9sKKVAzjxb2hm/AAJJGX/HVv64wAPw3r/hY2FrYoAnDzb5xYSt3Pk2R1ADPLhiws/WNzFro0+Vujl61x9zB8Sp4=
Received: from DS7PR05CA0055.namprd05.prod.outlook.com (2603:10b6:8:2f::15) by
 CY8PR12MB8361.namprd12.prod.outlook.com (2603:10b6:930:7b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.31; Tue, 2 May 2023 13:37:22 +0000
Received: from DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::9b) by DS7PR05CA0055.outlook.office365.com
 (2603:10b6:8:2f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20 via Frontend
 Transport; Tue, 2 May 2023 13:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT115.mail.protection.outlook.com (10.13.173.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Tue, 2 May 2023 13:37:22 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:37:18 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 12/23] arm64: zynqmp: Add mtd partition for secure OS storage area
Date:   Tue, 2 May 2023 15:35:40 +0200
Message-ID: <20dd23821118999c6fec2bad52ea446d1a66fefb.1683034376.git.michal.simek@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT115:EE_|CY8PR12MB8361:EE_
X-MS-Office365-Filtering-Correlation-Id: b42be925-c572-4816-b325-08db4b125bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LeqCNtsR3EYNb52opJdLYWxSDIDFVBh6ybFdHbkjp41j23Lh91TNNzFA14agkhWJmfHWh4fAU6sLcS9TWd98aDhLXu9Aw9jbIP3FHC5rQpmy/emvilmn8VwSgAETA7v0fji9/c9bg02QlXZmxPI7JntlClQMTWp1jfQejhvNWt89yS/TYSNOjlaMvCEjLHHFU6xh1mLQs7oT8iecMt7i0+lP/zPGu50BE+QvdKoXNbhA5pfP6pD7qd5QVsOQx0fNsQUkcCkkXygqOcP/KUEejushH0RUr+sRPCWz2+vZLcxW6GB4DUg8x+IVH0roCIpJPMJlMp6cdYexgsbGD5uXk5oURASDwqqPFgkStMgYyn1WNOyxfHz+NslNqPxxRKvtyprufynR83YvyfmTd5GDaEWBEpw5fkwp/qb1mPM2OuIdZyZJMl62of3wHPH4qphO0z9HM1m+ImkWsAvcOGIZurk9zPCRFl7HLPRO81U557Elv1mFeCztnJ28n1Nqo8aUMEpdPeaPVK8yMxuDBB6W3AGXJsNBIJw+UyL87aNGASovRdCr951WG8l4xoYq0Fw+XaYRnKIEUB/Jfj65hdR/sh82Ho+Dx6zJQACee2nv82gX6fex1XPsuhou2QdCOOdG5ENE874nedivwe7JtrArYr/z4ZHLcz64Zik4CpV1MZ0BJtS8OSPLUkztqY1ZC6EQBcbvcseOpa6UBYfWviWjKf1lNjm14vabN3HGnqzAeyXHVHztrU1pMEjyvOcxyAHk
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(86362001)(40460700003)(8936002)(8676002)(4326008)(41300700001)(70206006)(70586007)(81166007)(316002)(82740400003)(356005)(5660300002)(44832011)(40480700001)(2906002)(16526019)(186003)(26005)(6666004)(47076005)(36860700001)(83380400001)(426003)(336012)(36756003)(2616005)(82310400005)(54906003)(110136005)(478600001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:37:22.4436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b42be925-c572-4816-b325-08db4b125bd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8361
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>

Update MTD partitions of Kria device trees to allocate 128KB of QSPI
memory for secure OS. Increased "SHA256" partition size & changed
starting address of "User" partition to accommodate the new partition
"Secure OS Storage"

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index d3c6a9feb114..5fbc2fbd2638 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -83,7 +83,7 @@ &uart1 { /* MIO36/MIO37 */
 
 &qspi { /* MIO 0-5 - U143 */
 	status = "okay";
-	flash@0 { /* MT25QU512A */
+	spi_flash: flash@0 { /* MT25QU512A */
 		compatible = "mt25qu512a", "jedec,spi-nor"; /* 64MB */
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -161,13 +161,17 @@ partition@2220000 {
 		};
 		partition@2240000 {
 			label = "SHA256";
-			reg = <0x2240000 0x10000>; /* 256B but 64KB sector */
+			reg = <0x2240000 0x40000>; /* 256B but 256KB sector */
 			read-only;
 			lock;
 		};
-		partition@2250000 {
+		partition@2280000 {
+			label = "Secure OS Storage";
+			reg = <0x2280000 0x20000>; /* 128KB */
+		};
+		partition@22A0000 {
 			label = "User";
-			reg = <0x2250000 0x1db0000>; /* 29.5 MB */
+			reg = <0x22A0000 0x1d60000>; /* 29.375 MB */
 		};
 	};
 };
-- 
2.36.1

