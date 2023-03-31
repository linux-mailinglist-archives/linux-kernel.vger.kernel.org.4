Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0237C6D18C6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjCaHli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCaHle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:41:34 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C0DE19A;
        Fri, 31 Mar 2023 00:41:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQw2LKNo9yCbvoEabCJKZfKaCZbASR3E6eDY79dEGshrm03Q5mRU27o1lQ/CX6Lmzcp8CXbBnROZhen4O/MbKRbIIC59zUAWkQs5tIrmHa9lmsrZ22xxrlF96bfPDn0mpzUScIUoRltSJi4iKbUo5mf8UZHW2GMT2RJJ6kAhX0QIy8Zyp2rU3RKTwToCgZvKYZdpj2jNFbKB/RY63ATdLMdvBXsA3flRFHY4YS7gdgiDiPbZ7dPieeNh/uF3ktiY/5nZHswl29CyCQgZ+p8BB8SAS7mnN7856mVFXrnzfCiFvRlBO+xGAL7Y/jvocXhgsaArB+ypUbDacMr90RZ8ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGSuVqvIoLNH/7eCSqOZVafI/kBEtClwS1YIIbRkv7s=;
 b=LwFTzR5TNqYO83yZnDTdj/HsB92YXOYJ1r3Rpy0AszM2ESjs+XZirXY/b5hKvqAsqamHN+ZJoNT6xLE80ApHdGv5MtAzO+Xp9jDBmYHqGInDCCvtB3CVQlGiPJHlkFoE8cA0F8efzDnQsVshgJz4yTY5yLZOCd7CgfXVUMNnul9ovL+EipAstoK4uDfudtOsXR3dW55KHJG83TXhL1gUclgrjxloW1MBnUOamBTpfvEqidPn1Ew6rTN/Ee29FQKzkEhJvJn4xjta3YqD04n7IWRM7fBPBja0w65eHBbmCGq5cWEjqDLd3eDlNNqiG2Um9J4L+CvJqgdbV+6KKnxBvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-watchdog.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGSuVqvIoLNH/7eCSqOZVafI/kBEtClwS1YIIbRkv7s=;
 b=hI9ebqdGw+FeCBU20qmii2dYFdnR3twxw7YUl8GOxWZKXV0jvUr3mUD0137HAo4lgYt2JEdridR2+CGMFJ0VmD9L1LxAEEiWfw0uDp6UWIbIgf8xzN9Jld2O+ZMiZUhfttQhPMyihlYR6AkR0t0k2WGsg26TShL32jVdiqIS4rk=
Received: from MW4PR03CA0236.namprd03.prod.outlook.com (2603:10b6:303:b9::31)
 by CH2PR12MB4907.namprd12.prod.outlook.com (2603:10b6:610:68::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 07:41:28 +0000
Received: from CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::1f) by MW4PR03CA0236.outlook.office365.com
 (2603:10b6:303:b9::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Fri, 31 Mar 2023 07:41:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT069.mail.protection.outlook.com (10.13.174.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.23 via Frontend Transport; Fri, 31 Mar 2023 07:41:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 02:41:26 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 31 Mar 2023 02:41:22 -0500
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <shubhrajyoti.datta@amd.com>, <michal.simek@amd.com>,
        <srinivas.goud@amd.com>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <srinivas.neeli@amd.com>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <git@xilinx.com>, <neelisrinivas18@gmail.com>
Subject: [PATCH V3 1/4] MAINTAINERS: Add fragment for Xilinx watchdog driver
Date:   Fri, 31 Mar 2023 13:11:14 +0530
Message-ID: <20230331074117.356339-2-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331074117.356339-1-srinivas.neeli@amd.com>
References: <20230331074117.356339-1-srinivas.neeli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT069:EE_|CH2PR12MB4907:EE_
X-MS-Office365-Filtering-Correlation-Id: 9837c2e0-3eec-4cf7-d7e9-08db31bb560b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XxaOHoN2S/wJZnJ/uJS1625YmEaYH1jarFjqO07efYLs7oKdGBGPSq4JJaOmih8JTKymiuvpcRs41CPtqErDB+Yd5OnZ0FnR/KV54NIyyjvWbgFGaYuJjaTID0oiNz6QDqok+N4DFlMVwx96qbYI2Jm8LU9MNfZs3OTHkm1jnnFTPbv9uwa68sp4OM3F09UG8Qg/vLNg/Wj/lkKWtGm2atXUM0BytfTfDwdFKFxjm8SUc21vQCfvY3pJ8qMO8mG4J9rsXC2AodOWN5sHE0mUYg2b0Dmy/LdbliRlHsty1oTLIJM5lof0G5FkL0obELyDP5UxOSCHofePjZzvsYj/6RAARTzFkV45NcjkMSaw3OG8s9HIYrHxaFHDaxm2shxDHPvK6XcSpZO8iMmIABExfRn5uAq0gfvh9msSCKOrBJpHHNGHDjTEhvnnUNgAfBKtbBypxQmGZA0CnMOYTTBBIV5M7aHTCNWzssiUd/maGX2Lt1anv1Y8VnhBNBEZXr9/fDdP0+j1JoZ16tjyVtLMzGRzmzCM36U7Rt1X0X9Ffp60SrXwtg+8AULATZ7W8XG+7xPiqmCgQZD6PH6DG1AG8nwA1Yd0nikzeL4/q+fKNo+n3qFpF9MnZbhh88Xcm89p785RJrl4CFGVo8t8PYCmT0bVLybFbnmIqRoGzTin+5ABqVX9rubWGSt5GhOFFQJdyuzTLxyaJ0eSv9KLbneZIpH7HVAX+d+Czi0fne3OvdY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(6666004)(81166007)(82740400003)(1076003)(356005)(110136005)(26005)(70586007)(54906003)(82310400005)(316002)(36756003)(70206006)(8676002)(40480700001)(41300700001)(86362001)(4326008)(478600001)(40460700003)(47076005)(44832011)(5660300002)(4744005)(8936002)(336012)(2616005)(2906002)(36860700001)(426003)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 07:41:27.3756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9837c2e0-3eec-4cf7-d7e9-08db31bb560b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4907
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added entry for Xilinx xps-timebase watchdog driver.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
Changes in V3:
-None
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d8287eb2ab4a..4ed139d56913 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23071,6 +23071,14 @@ F:	Documentation/devicetree/bindings/media/xilinx/
 F:	drivers/media/platform/xilinx/
 F:	include/uapi/linux/xilinx-v4l2-controls.h
 
+XILINX WATCHDOG DRIVER
+M:	Srinivas Neeli <srinivas.neeli@amd.com>
+R:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
+R:	Michal Simek <michal.simek@amd.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml
+F:	drivers/watchdog/of_xilinx_wdt.c
+
 XILINX XDMA DRIVER
 M:	Lizhi Hou <lizhi.hou@amd.com>
 M:	Brian Xu <brian.xu@amd.com>
-- 
2.25.1

