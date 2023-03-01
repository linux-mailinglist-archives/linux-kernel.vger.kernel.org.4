Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5806A7255
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCARwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCARwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:52:41 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD31B3E098;
        Wed,  1 Mar 2023 09:52:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qssumhq3SZF9xk8XPgtqCVF3KHc8rtUaifI6rfD1OGU3DS/K6Q4pm8QN/bfs4b3dXw7niRqoThxIUF3AbMORcUa12QDdCOarUsEKxA9kjJUeu0IAhwN3HUVaYUhShZ1xNZPRFFUkMNrgfpuN/kuMKBBUnAKY4wS0tPsY7dH+pWjR44pCowXXzbfpy+90J4/hKiGE5IW7fZo5sVKHZoHl7paHJqeWIo57GR7DemNMgUNBAGF2NDY68QoR+CHjx56DL7ms04yHxJnL8TATklcuTXHiZVS+4Psecd997IebfJFS72v+RiTXghHy7VTVOQFQl+gLESBaxFOHnJpxOpFlEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7MolpabH3iU8cKGf0j6DrWQ6XQGgDDcVsS8r/G+bSw=;
 b=gn6GE1SzrOMgygChGQd98OZV/P5ZZs+O3WN2CpGpHdm6MEBiLypO1NqCDvBWLd0GFsRJdO2xyqfcqDhEw64DFH4zftbneAcNcHWoT/Zbc5p9VFCjxZiAeZcuBm+Mn9RIZy4KxHISG5Sj1Va/KnaqzBBNiczHMZdw4EQTJk+mXijFODkF6XY8dEEs0YXhAwZRxregrw7JmADBCMKwI/JaBcqtVXjAtvSa8ObsaDrtILtp8363V9RJBVFl9oTLB19PT0sP6l8LVfjOY4Rvwzi2l6lJW6eF8jjguk9V/mmUoajdK3icF0NjUIemsKmrm1pNnwZx5CWKJtwUeuogRULOGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7MolpabH3iU8cKGf0j6DrWQ6XQGgDDcVsS8r/G+bSw=;
 b=ASZfxgRldVfohH9b9su65XLxQB3Wh4O1Gs+ZJg+lUV5FW1yVaF6dnt8pGGZfEsAXIB7x7V2/+a8Zd3gk/T/jggJnV/tjW9f2ou+4xLWFFH44BrLza0yrdo5tG53dPqMeKiYRrRf2gFlxc3t3e9Uyujf7fgbJHvjrYvbetnuSjjc=
Received: from BN9PR03CA0709.namprd03.prod.outlook.com (2603:10b6:408:ef::24)
 by CH3PR12MB8754.namprd12.prod.outlook.com (2603:10b6:610:170::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 17:52:38 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::28) by BN9PR03CA0709.outlook.office365.com
 (2603:10b6:408:ef::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 17:52:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.18 via Frontend Transport; Wed, 1 Mar 2023 17:52:37 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 11:52:37 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 09:52:37 -0800
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 1 Mar 2023 11:52:34 -0600
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@amd.com>,
        <neelisrinivas18@gmail.com>
CC:     <wim@linux-watchdog.org>, <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>, <git@amd.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 1/4] MAINTAINERS: Add fragment for Xilinx watchdog driver
Date:   Wed, 1 Mar 2023 23:22:26 +0530
Message-ID: <20230301175229.342004-2-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230301175229.342004-1-srinivas.neeli@amd.com>
References: <20230301175229.342004-1-srinivas.neeli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|CH3PR12MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: e8834737-0a67-4639-268b-08db1a7dbef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYhFgglcBN6NtiuJ9h0reXUAD3oj1DSK+tfbcd2vRPfV81AoN1mYLsbhTwh8gyMbXjz9lVPozSQTi/F63+qy9tgmiswl5JiGegMe60hDeEgZsChDwYwn/xnTDdTcQzjOn7oI4hPU12eThsrzVUGj3RO844IhCSvjbcsbV9vdyjUxTNNshq2gsdN6zS6Xj0t3ikORgwOEWt/zKAxr+PsIqCo+tABptKD3yne+M00rez3CtoYqC+tjN1wq3fqGJAdZqAshHHBefz0lzg0GgUvLBFoFfOyopcE+m50KRtvSQzHZQsaU/UPVFCTiFdya+K7m2QORAEcubj0ir9CnaV5S0IVIb6E5H1+zPAeJzTXHqDy3iW7d8ke9t2DqzUMntjLFlNJIfrPITbbqiMcYl0qVp9ZfXWAh+e9hnUng/V8U7L4Dxu5ISwT9GL/lah1unA1SAi3wSSCbWWKB30lcZWP2ZkNWYAnZz6fkp6mpWrizpze2zhUoW33UjaLowTa/ddYEDKzihn9jR3wchI5oL5xU3ptPJnWU50CGLSAoRZijwxbCmOIrglnaHK+uZoa7qfGxZNx9JF32S+/Ay02pB8RtRe2q2B6M+1e4bJ4eVhsEhp78jtoEz6eVkj78PsOyzmeW8JfdbMgNjLFZACYQHSXFcovAwvCIZ/EgeARiHlYsDijmkyzJrVfaJ0MLrJp792BqxNS4OY9U6arzj9zZx5j936joTdIQ5d4+g+fv4scbI7A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199018)(36840700001)(40470700004)(46966006)(356005)(36860700001)(81166007)(4326008)(82740400003)(82310400005)(8676002)(36756003)(86362001)(41300700001)(44832011)(7416002)(4744005)(5660300002)(8936002)(2906002)(40480700001)(70586007)(70206006)(40460700003)(336012)(186003)(1076003)(2616005)(26005)(47076005)(426003)(110136005)(316002)(478600001)(54906003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 17:52:37.9428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8834737-0a67-4639-268b-08db1a7dbef3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8754
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added entry for Xilinx xps-timebase watchdog driver.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b713407f887..7731e3ccac0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22982,6 +22982,14 @@ F:	Documentation/devicetree/bindings/media/xilinx/
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

