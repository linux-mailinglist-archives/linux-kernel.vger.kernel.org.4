Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1BC6F4527
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjEBNhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjEBNhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:37:36 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380986A54;
        Tue,  2 May 2023 06:37:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdYboHoTD6n+RkY4RS7l0JoyAVPtwaYrwggUbENvJM74Xvxy2jtzngBFQTAyq5yWBKZ2/bZs7Tyxqz+Yx+vfSegL6THqKErvnP4NPjBgxP+HaU7O+FIlZtJmzjhM7rFu0CE9xHJ+HYZ4LaZecJxuNdMgLJuhWv6EQxLPpJX1zdEbzWnkXI1itXJilmMiLevz5p8cVPTpdcv7njUfnHJixwHb/2eeVCGLOYbDj6JIIXkA4vtKmkUJLv9747K8PYFszQg8xyHr6sq2c6EmB4gsJ7hJQpuIexta+xBucYGNZcymko2FwE/LW62DUkvnsAawkRMdqOFEtOfbluu384/6+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYAxaiUQ3mc3pC3rp6MjVQciGbkJU6x5vjV8dTq/3yU=;
 b=d6AmEEYy+WrOTULCLBtm+GvowBLhIekvS947E55CC+GMjMlFLFGCkQQycTqM085BRm+C6JsZliDfYKl+BUgRjF4M8drAJ0Gr0RlpbS987VSmPtrWgnC6alCv0aQMsP2Cr2e6pNO7fWMALUklAkB5m5CdAcP3yly7CFjyBq+8vXX/1b+s23xPAvjv5QNxlEX3Wzo88ydJlWJPtQWj25ogGwtPljU2c0QnYqvbo1xkebmvdqXKcNpuUpeRD6NqmOH+qmu3K1ZWLgMbadsW0pvl+OhD5ljlTvqfiWTnzWukH/BtVtoEYHGYdN+iY5v+IxezyVuGYUgvE8qWArqfpHJ0BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYAxaiUQ3mc3pC3rp6MjVQciGbkJU6x5vjV8dTq/3yU=;
 b=bmqsKSGcO3QfhKn4MevW1HrF+qQHpll027oLrrnCdbSZTByQXX91IVbUjAWDm6RhenOGeUv7txBuxc6C2LUtK0XH3ec/HUKatBW7mQNGT4EgKGzDk80SZj4IwbmTBr341mqgdKKwWo/Du5xmJRqoDebIZHALVF9QIJvpNqkF7GE=
Received: from DM6PR10CA0009.namprd10.prod.outlook.com (2603:10b6:5:60::22) by
 LV3PR12MB9186.namprd12.prod.outlook.com (2603:10b6:408:197::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 13:36:41 +0000
Received: from DS1PEPF0000E636.namprd02.prod.outlook.com
 (2603:10b6:5:60:cafe::bb) by DM6PR10CA0009.outlook.office365.com
 (2603:10b6:5:60::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 13:36:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E636.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Tue, 2 May 2023 13:36:41 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:36:39 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 07/23] arm64: zynqmp: Add pmu interrupt-affinity
Date:   Tue, 2 May 2023 15:35:35 +0200
Message-ID: <4c6674bf7e048e7370248e50ed3d011d604d020e.1683034376.git.michal.simek@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E636:EE_|LV3PR12MB9186:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c3760f-735f-4a98-c258-08db4b124331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jvqZ13gEJ2a4Q88synvCjLMz9XjRr2INvai0quMAWEX1bf+14rGeprEf6ZDb3BlTUhsoWw4BiGHsQSBXe/BqXGDpDo7k4N/KEjppU+18nNt2juzmBAHMdzzafqrWzWBnKgELDRDMaoP/e9Uam9GUuEkhnjhPpCV3dwItdAdA6cdvr2fo9xOGX+5VyVKJRo19Qtxm3lFyPPBUrXm4bNG9eZ2rRIJGvuf4N5RXuL5MgERfTf9eY6RLgHSpDZ5nTGRAn3DFf8rtybGEIQiWfbQZvdU2VdNRln8wnf/wvw8uasB+nXGZuXj2hqgb5/Kf11PPl3F/W9A77+m62+LGffCYBw2w2KOHHRakIrciJ3ctpLHx2j9dzjCOpMLO1OTw88dH6xoa8IJkCHn+CgIUwb9NVX+uGl/5G5ZQdIADQQfBoBKN0DY2YZyi4n3xGCG13hvDCc4a3lhxE+YHvm36YfhcrOmnZXZ4ZSVOEFsXuz5jzf1+CsGSGPf9yTPNsxobMRG4KQqWXt8tJb0D2fz167is6Aic9oTGjQyWU9BGRbdqqVFXh4wr12/tA58ZN1Y7yh02MLYEcJ+U1+8GcA0Hvn2ZPO2dJxoO1t64Enn+GdLkwwAotSwlPYsXx8epRSCd1pz5tFuY7N1T3l616WpTX7/ee5K0N4g26TH8aVHDOIgL1VF68RZ6aIp62Y1B3VW7SN1HWygRh7BBm5gwG0Zf4daOGFzKhZbyrIh5QfB4ItTW3Lalj9SMP3NxltJf3Wu9sw8J
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(26005)(86362001)(6666004)(8676002)(8936002)(40460700003)(5660300002)(4744005)(2906002)(70206006)(70586007)(4326008)(36860700001)(82740400003)(7416002)(81166007)(356005)(41300700001)(44832011)(316002)(16526019)(478600001)(186003)(40480700001)(110136005)(426003)(36756003)(47076005)(336012)(82310400005)(54906003)(2616005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:36:41.1104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c3760f-735f-4a98-c258-08db4b124331
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E636.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9186
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Explicitly specify interrupt affinity to avoid HW perfevents
need to guess. This avoids the following error upon linux boot:
armv8-pmu pmu: hw perfevents: no interrupt-affinity property,
guessing.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 61c7045eb992..a117294dc890 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -161,6 +161,10 @@ pmu {
 			     <0 144 4>,
 			     <0 145 4>,
 			     <0 146 4>;
+		interrupt-affinity = <&cpu0>,
+				     <&cpu1>,
+				     <&cpu2>,
+				     <&cpu3>;
 	};
 
 	psci {
-- 
2.36.1

