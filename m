Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A2265E6F4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 09:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjAEIkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 03:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjAEIkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:40:39 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4363C4D49B;
        Thu,  5 Jan 2023 00:40:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtdZLfeIiWhR8xQMHOuAU230Vijj/INHs5SfXsE4kEOVfvnwU4/ESxHuuJQ5H5uaRhRd6n7l3XZv5an+cT/pllE6niEkO9AQ8Gok7hkL33K3vwhq8QvzUY9FxIFeH3hW1z843KQ/MA0IF2A7FsrKXU6k3RT4tvJTDJxyMNW4rycpIlVXUlsqkVk+CwO4IsQPq0m0bBhXpEDdwxBzg87R3tBEIkfjOSfPopdOXgIEtecnV9mdOdMbX+hCvzyNGGl4LlW40AHZ1y082Yo/eAd2awqgGkGwv2OjNOeN9mlkgZOXW8dgLNVjWcq5I2xYKhE+gvkNeFYq4s87G03KdOKyxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hAIG6Jg2yg/a81HWiCCVXiTSVDGxwLfhBpksTTy6O8=;
 b=JE/A9VoJuwp0JEs3NkMApXXfdTm4unZFwdA7CKEnjeRTTE0vB+v+TqiFH8kf18dMf6QxYR5F+WfXjDOijToAQtFqjboUtk84jU7HvOhSZBb+fXI5zp/mQUlJjt00cnDJV3gZp5XX6GD3Svaog/mPzHQeRcKSGUj7I9sFKMIjh3xV4TA4JcnTVuaGWPPEwzH3BcxBpYiUCbjy5xVhtGVW92fP7i5qGPoNmvmNBMOCcQ3URjMlAT5Rvf9h6sSYvfyTc7AzOeukvaFUU74kHgT9N0eOXyTSuPpo+Ghoh6naD+9sgWF3re43NuOzW4Fyvy9KRZ3pB92JcLi+i2sVB7ovuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hAIG6Jg2yg/a81HWiCCVXiTSVDGxwLfhBpksTTy6O8=;
 b=rvFoS0xG9H0zgGa3VtLviz6DWLUHgBjafLyT5pZaN9fQjoS9XZot01BEBIGfPZ08Ap/p+kdCPsh0BA9BzNon+ykFhXeAVfDWwyDkwwS36ZlyMo52OGIMx01UjRJw5jfXlB5/0xNdLrf1lBysVwckhzhRWeZkvC2voV66evZz+ZU=
Received: from BLAPR05CA0019.namprd05.prod.outlook.com (2603:10b6:208:36e::24)
 by DM4PR12MB6400.namprd12.prod.outlook.com (2603:10b6:8:b9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Thu, 5 Jan 2023 08:40:36 +0000
Received: from BL02EPF0000C405.namprd05.prod.outlook.com
 (2603:10b6:208:36e:cafe::5d) by BLAPR05CA0019.outlook.office365.com
 (2603:10b6:208:36e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.6 via Frontend
 Transport; Thu, 5 Jan 2023 08:40:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C405.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.13 via Frontend Transport; Thu, 5 Jan 2023 08:40:36 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 5 Jan
 2023 02:40:35 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] ARM: zynq: Comment interrupt names IRQs for pl330
Date:   Thu, 5 Jan 2023 09:40:32 +0100
Message-ID: <8e5a921c16efe09030fda036340186c11dd990bf.1672908030.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C405:EE_|DM4PR12MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: a173bccd-18a2-4b97-470b-08daeef88444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1XBqtUEmGWdkHEIVmIk8kNRiM87i7O8dDHL73zrZGPrgQUFlix/T7ckR+LEwjyA9DzhldB/F4MeCdie9M1E4+XXdMo+/ywilFRLgQ2Pkg9FljWx88KG5VnP2f6dfhjLy6FFIH3AI6RqbmhSPH6pKE3lEl6olk7+jKrnxG2TAuGl2patWccY6x/PRuLTNXrsOM25x6h7W6qSDQgCYJ35sJ39YUEFu4UUMjSScrqWkF6KmiTPz2iQVL1fm1U+IbfwlR945G6nOeHg7f+s6PSNQ1KaxGxLSAwrsvZPF9XMgiGrGsVUjmAvp91aFfIvtiKPMY4d/rvCJeUGCF3/JtvCs3KQviqiDjcDZ4nkZ3iZfS4Tm8QbHhKl7jJk1xiZNloSqGW+vvLxxwGrbsjM3NFFLSxvMk/tX7mWUpfGGvPcC7bJy2HMHnHuEn5kgBBY8c0pM8u4ERPl0c+Zzz0sLEGRwVX50kytCiVtvgA6pWpNx1OP4Y9wwiPJdt/n1F5tqe0B4Ocq1EMuSyGBUTq/hPbvNnEi3UhMtXAtYGdA58vLd+Lm4AZL+zsDJFPvcLlmoJXlJ7NbyR6Oc3VycdO7V4Qu2khNiwjjOOf1nk3/5gVy5a8mH47pC/F9VY1hsuTqBMGBm48peF2moAelV1ZOiFVCvhWZKdjJD8OfH64Z22DEfDRyF6n28KoTxTFada3DqThY3NdRXFmBcff3XLSgMxFb9SROPf5cNjLOtbBrZYOq3CVyToDwqX3JtkJkI/IPYhfh
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(81166007)(356005)(82740400003)(40480700001)(36756003)(82310400005)(86362001)(40460700003)(316002)(54906003)(2616005)(110136005)(478600001)(6666004)(16526019)(186003)(26005)(44832011)(5660300002)(83380400001)(4744005)(2906002)(36860700001)(4326008)(70586007)(70206006)(8676002)(8936002)(41300700001)(426003)(47076005)(336012)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 08:40:36.4244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a173bccd-18a2-4b97-470b-08daeef88444
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C405.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6400
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pl330 DT yaml description doesn't define interrupt-names property that's
why comment it but keep it as comment.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/boot/dts/zynq-7000.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 25fbca70ac1f..c5bb6ddd5370 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -347,8 +347,10 @@ dmac_s: dmac@f8003000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0xf8003000 0x1000>;
 			interrupt-parent = <&intc>;
-			interrupt-names = "abort", "dma0", "dma1", "dma2", "dma3",
-				"dma4", "dma5", "dma6", "dma7";
+			/*
+			 * interrupt-names = "abort", "dma0", "dma1", "dma2", "dma3",
+			 * "dma4", "dma5", "dma6", "dma7";
+			 */
 			interrupts = <0 13 4>,
 			             <0 14 4>, <0 15 4>,
 			             <0 16 4>, <0 17 4>,
-- 
2.36.1

