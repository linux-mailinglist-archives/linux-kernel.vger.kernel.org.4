Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0156E9090
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbjDTKn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjDTKnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:43:03 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4215D19AC;
        Thu, 20 Apr 2023 03:42:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSQJY/CJGlYzouxLvkCWs/fBtSn/pO+WpnrM2Z2P6Fv9DFyzfTO+HrbIZrQkDejMX9Nz8QFZa4EegVcHjl3/YlDH5xvPEDP6DSBmG8St34hSLNd7/KYw7RYTYWjR69ysIu15D7ypXC7bMv01tkhZ3vZ8uLJaRYkSE1FQ2N3D1dZ2ZU2YjhKN8dO2h7lhmTuJjcDN5to+7QxK5nBoA2a472VGMs4l9wXulhwwmlnCezUS4rNDWFiHSkTs7va1Op6c/7pNf811McfS1t39hNdFbUFNMPWieyDYRl/7silTOkhra0YQNp6si3qUbfGXkKAuQivNT80AgjtXlHLNONRfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcce2Sdq6urR/D2m4dTJ3IivgnupefVak85nIGXDV4Q=;
 b=J/FI9CqViCldCuw0BSbmgbRYTcmj3FV7CODJ6Km3PnXKEfik7ihKLALeqapOp5Ga5J5d+KMoe1GL0mapLEepN7AXu0t6kJRCnfVuLK+kk0bS7SF2SJYc8rTiAG9D0kgSy6yR2OGZy/zsGwvk2q8MQeOszFhUhAV40Z4p98ezZlLNQZJS01IJMJgaChMzch+N9YQCfU/aFimKi/+ZEyM1YpfHnDQPkjq7FAK5yVvlI7ZQZF5UYVD5Tzb01oT5NQfKQ+BL5f+oqBXhBXJbNJD7FaarXS9rxdSd+Pw+3LH0nFSsELsKle3RimornhSL2Y62wERIUwSMtx9+UlyY1ofgsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-watchdog.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcce2Sdq6urR/D2m4dTJ3IivgnupefVak85nIGXDV4Q=;
 b=lxdhwh7kZ+feQfIiDYFa/aXvdvw3OGXaw+eqJ2BvYY3l3kS8YJ6c+u6JTGPvoJ9wzW7+GJJMbHdSI1Miju/hDl4/ojTvVIKB60/UG1pi+HbrrkcP0pVaFpNn5wg9FsaS2dd8UqpbYUhfgRpIhf9JaTy2AstHV+S5DTrpKDuZoAc=
Received: from CY5PR13CA0001.namprd13.prod.outlook.com (2603:10b6:930::34) by
 CY8PR12MB8363.namprd12.prod.outlook.com (2603:10b6:930:7a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Thu, 20 Apr 2023 10:42:42 +0000
Received: from CY4PEPF0000C97E.namprd02.prod.outlook.com
 (2603:10b6:930:0:cafe::5b) by CY5PR13CA0001.outlook.office365.com
 (2603:10b6:930::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11 via Frontend
 Transport; Thu, 20 Apr 2023 10:42:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97E.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.14 via Frontend Transport; Thu, 20 Apr 2023 10:42:41 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 05:42:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 03:42:40 -0700
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 20 Apr 2023 05:42:37 -0500
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <shubhrajyoti.datta@amd.com>, <michal.simek@amd.com>,
        <srinivas.goud@amd.com>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <srinivas.neeli@amd.com>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <git@xilinx.com>, <neelisrinivas18@gmail.com>
Subject: [PATCH V4 1/4] MAINTAINERS: Add fragment for Xilinx watchdog driver
Date:   Thu, 20 Apr 2023 16:12:28 +0530
Message-ID: <20230420104231.2243079-2-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230420104231.2243079-1-srinivas.neeli@amd.com>
References: <20230420104231.2243079-1-srinivas.neeli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97E:EE_|CY8PR12MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c855bf5-af48-47b8-8e40-08db418bf80b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EB6QYphDqNkPjYyOIHdu3/nA6V+N4ih1Dey7jbJ+35dkVaMsbpnXllKDn/ekQj0aAHPaJEqtXFHwfMrVDYHUR2neJ9ahHimNeykSo5F9RZgNEUJhDt6+DaSCxxsrJoFf/kFyyqUJnr0Xc4Eq66Av58rUdnRkmwsvdDanJnZQwlN2vBJoQgpEU12YQWhCglqrjSzPgTWpdROgrdJcr//v9Zzf+GKgD1ySGP1XlquGdBxB5rMqsJjLxt8mDLCBgtddGUleu5gny7qGUaOun5MyqQPtsgvAnuDhsflZL8JnkNzVBoMw0PsTbvdMG7F7Kez4jRuqLqRbQqZfPBg6d9KWGQVphTZ/AiS4/oBRVOadd8h033WGqKJ46PyA2a5sRPI0BQDCfcMsuXGE8/i8etWYe2u+Bx3vwAcq1x2WJCIOgUoeX+TZBtb5RSboId24rwNAuQGVSeGqS6U5DthRgYDSeEiRB8CkPaysIkEKdeqGcpFwbV+U2SignLnKNYk+/vXueIoIlU0Ci92FoAHU6OABiiRUinp3JhNL9DEOXHXRpPJtSyNq3E715+1MC0YZTbNuZEQz/8UJ5a5c9id56t0ly4fbEIuH+85TUBBrokNam7MS7IQCaTkZE7kCOPOhAcK6Wh7V65iyvt4eDgIdW98W6Jt0lyfMBs7RvO7/Q3ZPmo0hlEF9K/0V0AoOX6xkAJFbtKxo3bo1OT4GHvWlqRt5Ix8fYvUxzglsEHQ31aLKeGg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(2906002)(8936002)(4744005)(8676002)(44832011)(5660300002)(82310400005)(36756003)(86362001)(40480700001)(6666004)(26005)(1076003)(110136005)(54906003)(478600001)(36860700001)(2616005)(83380400001)(47076005)(336012)(426003)(186003)(316002)(82740400003)(4326008)(70206006)(70586007)(356005)(81166007)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 10:42:41.9729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c855bf5-af48-47b8-8e40-08db418bf80b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8363
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added entry for Xilinx xps-timebase watchdog driver.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Changes in V4:
- Updated patch with reviewed tag
Changes in V3:
-None
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eddbc48c61e9..327901c9f1d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23143,6 +23143,14 @@ F:	Documentation/devicetree/bindings/media/xilinx/
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

