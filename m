Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CFF6D18CF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjCaHmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjCaHmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:42:00 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51527E072;
        Fri, 31 Mar 2023 00:41:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bg+xP3qa+ANfvPIRbjNri0tdt9a2gRciU2jeyEtyA7+V/S56uvGVgocdfdpWCEK9fRwlbM9dUQYMEWJnP8vuvJwbRtoVmkJ0+88NfiAp6JSdti/gUZLW/ToRBatA3L9qDPytEVTk+WbU5bkk08z6v3j90BmqYzkeyLZ5EmwTFUjQ1OuaXI/U2J57BukZWJRnlcdWC/dSd39vgpslJ3+n4pVowuC72aj7YRAOtMtxKq8gAy3/6/y4vmf+l5XSmuf3KTMHZ3jxgsST3jS3SED6PN7E1CUan4LgXZwwaCwGN8OUudyTRFxYHrRyyWeX2oJgptNO8DBY2POC7T83S63DQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RL0XCkROS5sV11j0Or8iLOG8d7WCBvvKK+gsWxICLvU=;
 b=lN4wlz5JsBQCN2YjjedbFI8x5YhQiEH7PYyDX+eLS7huLhD371Ag6w7MkAGpTn8jSXWxGQ2RWKqqSJftZC57uLL9BBq5jYNf9mWO49120ru7GChQEOr6YEE3jU8qqJT1KRur/CpT2wWdFl84KrnXoebobpZVgn2VILyT3QO2Z8griMqiT/m+RO3JUMXlFU1yHkd2/KUEiYHz8JI28qT9P53PSKmgeHWcr+PZMYbY2T14Y+syuc0XIvSAkToYdc1INkAINOPJLINwx7PwBaxzRx0xPRiICPqC/LCg1N02IRbuelkUzfoY9aXYZijWXWvHB5/8fsJl2r2WlhZo5anfoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-watchdog.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RL0XCkROS5sV11j0Or8iLOG8d7WCBvvKK+gsWxICLvU=;
 b=0pf3X4BTIx+1plQBu++ez22L7CRWnBTLZA5rD/fBZkoBEcvxtizqiCZJg3UwLVfzeksU/lcLgVxuFtVV4W23dugtDXDQSySyMdToY50hkk5pBa28ixSJQnNObNE/827O6MeztOsuqT63ee0zQKGry3TeSRuv+2j+qiuL8GGJsj0=
Received: from BN9PR03CA0644.namprd03.prod.outlook.com (2603:10b6:408:13b::19)
 by IA0PR12MB8976.namprd12.prod.outlook.com (2603:10b6:208:485::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Fri, 31 Mar
 2023 07:41:53 +0000
Received: from BL02EPF000108E8.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::4f) by BN9PR03CA0644.outlook.office365.com
 (2603:10b6:408:13b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Fri, 31 Mar 2023 07:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF000108E8.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Fri, 31 Mar 2023 07:41:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 02:41:39 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 31 Mar 2023 02:41:35 -0500
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <shubhrajyoti.datta@amd.com>, <michal.simek@amd.com>,
        <srinivas.goud@amd.com>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <srinivas.neeli@amd.com>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <git@xilinx.com>, <neelisrinivas18@gmail.com>
Subject: [PATCH V3 4/4] MAINTAINERS: Add support for Xilinx versal watchdog
Date:   Fri, 31 Mar 2023 13:11:17 +0530
Message-ID: <20230331074117.356339-5-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331074117.356339-1-srinivas.neeli@amd.com>
References: <20230331074117.356339-1-srinivas.neeli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E8:EE_|IA0PR12MB8976:EE_
X-MS-Office365-Filtering-Correlation-Id: 5836fee8-9277-4b40-c1da-08db31bb6540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B+9urdVDxWRl00EaftWgPMftvCuzmRIcO4CHxY9FVhPr/0n+Vq1ldHZbeDdfjeBSa/Z/4x6ahrIh5x2YoluqDN3HmpIhHgNImYvZyM6FFthgY4A3PwLMphnV2VtotlpSpqgYSS9dAhTCLCuEY63kLuo1fxoExGT3H+nbzoHwVwmHz7sgp/sRnzh0WyrhUm7Vw7sqXjf5lx+SQZrUNoT+KS0FQJFjBGLtU+5iWLQD6NAFwBK2sWHTlVhZXVBHSVZOdr0VTQ6yZ3OyrFH2osfVVKReFEd1RrKM8sDGeYBkLvi6CKfCE+H7sFlzFKSw0nNaCQLl/+92uWxyT3/LIt59DG3vwuCXx0zJbbKz62tVhpjUcUu/UicTXjmXfk/u1YkjRw6/54Nc8SM6VPhfPl14iLZtcAhu3Tuwqw7zJW5duazbQqq9mrOksXBLQYMXjo1QAX/ZZ/cshe3U+DMpt3eIZbXLm+Jcr2wl2qx8XbQu/gCcnmkZRQTJCP6OXPYeYfpvwxJsPkWlllm8BBdn4O2gGjottqlYrPFRbhUTnGZzqm+7pWwfMaj7HLt4Kw4mhTF9Wicl9Ikq4KCjAvibDXDpj686JAICQEhzVi7vJCRNTltmffiBGsj9k1T0l0oQSceSQ/bGJVr16mRV4ENbZZP7AamPmJdNhocfgh5hJwIhF4OAcJBWkf2y8oP8fBzJXRLKvP+dSdihin6qvMttnaxKVHPPtwFcAUNsPvJFkN7Nh+A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(2616005)(82310400005)(426003)(336012)(5660300002)(47076005)(186003)(81166007)(86362001)(26005)(1076003)(6666004)(4744005)(44832011)(356005)(40480700001)(41300700001)(82740400003)(4326008)(8936002)(70206006)(70586007)(8676002)(40460700003)(2906002)(478600001)(36756003)(36860700001)(54906003)(316002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 07:41:52.9979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5836fee8-9277-4b40-c1da-08db31bb6540
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8976
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added entry for Xilinx versal watchdog driver.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
Changes in V3:
-None
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ed139d56913..7b862ef7c876 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23076,8 +23076,10 @@ M:	Srinivas Neeli <srinivas.neeli@amd.com>
 R:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
 R:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
 F:	Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml
 F:	drivers/watchdog/of_xilinx_wdt.c
+F:	drivers/watchdog/xilinx_wwdt.c
 
 XILINX XDMA DRIVER
 M:	Lizhi Hou <lizhi.hou@amd.com>
-- 
2.25.1

