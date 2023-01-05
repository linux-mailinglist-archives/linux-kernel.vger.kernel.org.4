Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4B865E754
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjAEJGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjAEJGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:06:12 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690BD50E5C;
        Thu,  5 Jan 2023 01:05:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkI/Iq3QBeHbBfRioXvcxibUnyA6iRtZK7CFUZaNKBANFDFwsUyBO0HPAxUDLKowXUcDzrjoA0DdEOo+Mqmsa3MBfpPlad5KGpykTKTUG9jL7hjFtydyG19kLDP6IJfnwnkYsH0qFdSNZAcfsKGGpEgLlEsig6ibHpl4bAACiCGJSZVuXk6lcIs+a9E9SC6erJdJD+mxMeiBVzWxbP9MpuSziAUiBngj3xcNi3FFLRkUEh7q2LnxENPdy6mv3uNlmyQCt6gG1xOnx8RNVHB0mfi2U5Mt3/I51qBHS4eGwz/w+y5iRdkgQytDLHJyL7KR60zWgSxL2d2qHUrnUoyW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYX01oCXfFjmYXLCPr4po7FiWj3LZ2pBIW4IsyHemQo=;
 b=L5gac23yl0gneH4wcoUxvYe5N+bL35m6T+aI+QaNASlsYiSSXl97kt1EkIhj4uzCG43dz90KNpnIpmV1IQjAjAp/HoLdQozIhKdOs8cZ3MjEWW0pUpISb8nJszMScgCqHJvoYcm5s/r7J3Ca2hETDF0xoVkE5bpiXOcASHP1PlfWWZmdiK1xzEoe8nUj5u5AN7mw9jxrl8kFLgo3pNwq8DilNomILkVyt/Nax8IG/bZKoI7vsLfyXLXYRnoPs30LRDFdiVcG0nztOvElDPlP1G9Zx+7T/nxsjonWF3z7hZ0lgODqb6I6f+V/HQWgKREelA2EeFO29zXM3ufm4A49uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYX01oCXfFjmYXLCPr4po7FiWj3LZ2pBIW4IsyHemQo=;
 b=QagHeTFq4iqEZQUIQOJID6nWKXykqHwdY9eqqM56lSpVlKYLvEZrF5QT5w6xkJ6wDL+EB1nyDW21L8YS7pAAiBrwdG0dSmGVSsKAwQzwOEqHft6UEjLS/c77SpM7SgmZhHn9XDUlk+intrkD5z4KEo4677uzQvg4z5SH7iMwH6s=
Received: from BN8PR15CA0054.namprd15.prod.outlook.com (2603:10b6:408:80::31)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 09:05:40 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:408:80:cafe::22) by BN8PR15CA0054.outlook.office365.com
 (2603:10b6:408:80::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.15 via Frontend
 Transport; Thu, 5 Jan 2023 09:05:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Thu, 5 Jan 2023 09:05:40 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 5 Jan
 2023 03:05:39 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] ARM: dts: zynq: Add xlnx prefix to GEM compatible string
Date:   Thu, 5 Jan 2023 10:05:36 +0100
Message-ID: <7768d5d68fe38dd8e9300e9c6e09c228e79b2862.1672909533.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: 045e951f-6584-4897-2c20-08daeefc04a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wkkXNEUtGpZo6fG7Prfqpis7eXr+NXO64Y2iiOgmskJeB3fnqP5KMxgnMMRmynjpUGoYSrgy0M3w85ZZaZe2UuWj7FtQoU8v7wuGitogR/WhgZCvO29jDV59equWzvjDkNnZkOFi00tpwSypaugK5/Zgc13J6M1MxMnvpen6x5lI4Qaz2PpUA0lAEVaa4O1fFWNVeLLWZLl0DsHi5ZU/R3kFvAE75321wrq9/N3RH99dsTTofwCrhT81HwqPtWmjdODCGf8fBQ0H+YoV9avtprxSvK8IdDUVDoBQ4NzDxwKikESmDrl3eBb0rFto1IEBArYEhAaFYgRV8aqCGxydGri0shc2AJkY31u2dY1tli9CpXhrB/aaie7ZoJ7tuXlNLOVuYFx0hDyfL+BBT8ANMSB7Fzb4oPpFcw6Y+06qJbQ1fPkO6jdEVGWNL0aHfxiIfo9Ju63unDViqIif7JGRGXcHEUg3HYfk5Ha4IRokrw/h7gspLXinlmOTl4sjE4mQf79hkbVJBfESO7KyJnnTtaXoLf/AqPv7VO5zEy3Fa2nSKzsOpSFTngZl+4x4PfxgLzygw6Yi6+48EwAJLqR8n6l3rkQIWMW+ayKtGof8RACYb/56IRIha6ms2mMeUOZrhZjUFdeGkQDVK/qvAWtFggar/Ae5QXCoXOLCHqGaggTCKOJuH3gpgSTjrBMouppmR+FiiOCG/SAI2yzQhNco3KzvrvG07Np1ofHYX72ynkXEICekxGUGTJGc9wu7f11b
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(4326008)(54906003)(8676002)(2906002)(8936002)(110136005)(70586007)(70206006)(5660300002)(316002)(478600001)(41300700001)(6666004)(44832011)(40460700003)(16526019)(26005)(186003)(82740400003)(81166007)(47076005)(426003)(2616005)(336012)(83380400001)(36756003)(82310400005)(356005)(40480700001)(36860700001)(86362001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 09:05:40.2980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 045e951f-6584-4897-2c20-08daeefc04a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harini.katakam@amd.com>

cdns,zynq/zynqmp/versal-gem was recently deprecated in Linux in
favour of xlnx prefix. Add this new compatible string and remove
the existing cdns,zynq-gem compatible string.

Signed-off-by: Harini Katakam <harini.katakam@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Remove deprecated compatible string
- Update commit message

 arch/arm/boot/dts/zynq-7000.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index f221c60643e4..cd9931f6bcbd 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -243,7 +243,7 @@ qspi: spi@e000d000 {
 		};
 
 		gem0: ethernet@e000b000 {
-			compatible = "cdns,zynq-gem", "cdns,gem";
+			compatible = "xlnx,zynq-gem", "cdns,gem";
 			reg = <0xe000b000 0x1000>;
 			status = "disabled";
 			interrupts = <0 22 4>;
@@ -254,7 +254,7 @@ gem0: ethernet@e000b000 {
 		};
 
 		gem1: ethernet@e000c000 {
-			compatible = "cdns,zynq-gem", "cdns,gem";
+			compatible = "xlnx,zynq-gem", "cdns,gem";
 			reg = <0xe000c000 0x1000>;
 			status = "disabled";
 			interrupts = <0 45 4>;
-- 
2.36.1

