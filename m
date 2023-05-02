Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDF86F452D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjEBNho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbjEBNhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:37:35 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104E66A67;
        Tue,  2 May 2023 06:36:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVBNAbNe3oBughD6XQxRZW2T+EUO5DSuEhWVl7JYqfj4Y7ixRpqKiXwErcOqizdvDo2QEbPOWudmeReSlevbxtJ/sc8K1/myhDLS4Idkacj3tpWEGvDyNS0NZrmFZ+qkBPcTPnT3ZxyFAKootrwmyaM/VIQTviey+FL+QuUdiibwrELovJQaW4N8YeRHC4zcZMUYKw0opuPppipIt4R879pvOueeXlHm3lQqsXwDL6TTMWC1J0YbMMFUG3OrAOMgw33cg0/S+MGH3+SurL+07uEqTkXVs/lu+8+FicJJuBqF3soPf3+XJ6GuVUR6J5lyNHzhlrGpSN9GvrZxVWKX9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XYWvYBsJgFC/Uolu8upj50xk2GLhvkzlH+sSaDQO4c=;
 b=LudX1TPMToVLWWU2ydVTB7c8XrtxQY3pBiEURnRs1TUbxqje+MU8Gk2HTEYjb4C1G7XYFes9M28a6VopexkJqztOUZZd8BABIryGkwRyh5/T17dlO+QKUJ8bZg0zVJ0A4cOOelu0Y3kgb9mrWUH7Zg96FwXKowM+n4tiMGeZnJdWnSxE8WZFvZOimYFRiNgL9YrNuo9q2H4frPcJIGxyvDEc1a0HVm9rT4Jn1KQSqBPYJOUYEsdaI+HhG8NXi6ggii6e/XtjpWgXDF5nV2xM9kxs7Fey9TTLKPYOP17kzAM3KUQmzNFfSiIJr7oTyKsHtBtNRZCiwrCcy9eJmsnzlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XYWvYBsJgFC/Uolu8upj50xk2GLhvkzlH+sSaDQO4c=;
 b=rMa9MyG2yibMALmoPpmUHZT0ny3cWpQx7oi6lQ650E4xes0WU6XhoI9GHQ57jmrkSEf/K7FZL3nSXIkECX4asfdToOEGV0j2rHfTeNqwHu1AUCQNqYVt4egySyQA487qM71ZxrYsiqINyMeNrtyaMp6QhXgoKWlpaw3iEwU53Yk=
Received: from DM6PR10CA0018.namprd10.prod.outlook.com (2603:10b6:5:60::31) by
 DM4PR12MB6062.namprd12.prod.outlook.com (2603:10b6:8:b2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.20; Tue, 2 May 2023 13:36:37 +0000
Received: from DS1PEPF0000E636.namprd02.prod.outlook.com
 (2603:10b6:5:60:cafe::3d) by DM6PR10CA0018.outlook.office365.com
 (2603:10b6:5:60::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 13:36:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E636.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Tue, 2 May 2023 13:36:37 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:36:17 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        "Piyush Mehta" <piyush.mehta@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Robert Hancock" <robert.hancock@calian.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 06/23] arm64: zynqmp: Sync node name address with reg (mailbox)
Date:   Tue, 2 May 2023 15:35:34 +0200
Message-ID: <5d8e80383912b8ff75409764efb75f3b85917087.1683034376.git.michal.simek@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E636:EE_|DM4PR12MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: 5772367f-7501-470b-2d74-08db4b1240d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EOCsGALA3aguuT8nmpLXZjRXJKOV911nw20sEwPZUUFjdSd87hACofo1zulO0ePqhIwQnvqZpPU9qHjAQryfqsxAchVEvJ+c8GOuWDhc7bz/pfsHV8ZZxBeAH/dwVQHiSIL2xkuKq2DOkSovY1OBcFCsW1wOdZr+Qg9GpAx3QMMWT62+KvFBcCTBZCttaCTHuOzoXxH1JF75MQF4/Z7I59HaJgYSeniY0ctaWxwf3Frt2QurKsLB7QQobc4+IF7F30zhxWTIo1RxpeTP8KpkUIiRxFq02cc9mrevo6vFSYT9kCsNiIu9SOp01+V2N8x40zmPLwDWtM1wG16ZHiug1RXprQcEH6svLFFJTY0ZsNB4CdVkUHPjO9xzzAUzuguUITRxiT/GqeJ5PDgJfqvCy8M4U+eqpMGKUgmPKKleo0HX0gKW3E/i2yF1P5Um3tIcpC2/hA3suJBvASr3fSCDAmyGb8S5W6QNrWGoDQoPIr+e3uBOCI9dG1Ol9QJ0tDxwP+ovktWtxH4npCAuHWMWyt8uH8mPW1ry/eH0HaEEsJSqnnYAYbkto+11iyFxueDc9e0rSuakQaxsY48DrsNsSW+9TGu/02SOoq/H1UaxJ8XRWG179LaDpeQZ5/7SNtvbA+T9T0L2F1iQs9baXZ94HdKaeWBTtMnIDxNSsEGqNGcU8PAK75PDsVqoXE5mUXFZ+PdyWc0e8bkMEF83U0WcSAae5AaHgp2P4mTGOPY5eRfqLMYdOQ3bsuR3wDVpMYWR
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(40470700004)(36840700001)(46966006)(4744005)(2906002)(40460700003)(186003)(16526019)(86362001)(26005)(82310400005)(15650500001)(36860700001)(83380400001)(40480700001)(336012)(426003)(47076005)(82740400003)(81166007)(356005)(36756003)(2616005)(6666004)(41300700001)(316002)(8676002)(8936002)(110136005)(54906003)(70586007)(70206006)(4326008)(478600001)(7416002)(44832011)(5660300002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:36:37.1417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5772367f-7501-470b-2d74-08db4b1240d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E636.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6062
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address in node name should match with the first reg property in DT.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index c2d80c7967e9..61c7045eb992 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -135,7 +135,7 @@ zynqmp_ipi: zynqmp_ipi {
 		#size-cells = <2>;
 		ranges;
 
-		ipi_mailbox_pmu1: mailbox@ff990400 {
+		ipi_mailbox_pmu1: mailbox@ff9905c0 {
 			reg = <0x0 0xff9905c0 0x0 0x20>,
 			      <0x0 0xff9905e0 0x0 0x20>,
 			      <0x0 0xff990e80 0x0 0x20>,
-- 
2.36.1

