Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506716E908E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbjDTKnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbjDTKnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:43:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183BD4C1A;
        Thu, 20 Apr 2023 03:42:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiAmS3eSasX88I4GBpYwypKDPlfoTdN4zmqXLXIF5v6jbqPx04mgCqtcWkjp4FB71qLGOpfnkYzvNqQ5I5R22vYB2qZ0M7ol9PSDQfS03Xc2L9XCDPaL6goebBAD5U7Ut0E+z225dpA+bTf1YHNjcrMePC5LhKJzGn/J1z9OZdjwX9dL003xGD8eCSL0RXQ+61j83ridu4hu1kstcP4jctY0ZPKUhvI3r9GOevbJEFcAWROB8DWoKpEAW1P2eFTy82aTMZ54K8of9MZTphpes+mRJfRv5QQECCE80oL/3beB9mT8i5OvgHjZfDSGpjQwDOPnxbH9GJ+Jy/gBV7hxwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4A/XBhEuOr46YORTmIiPKPMM/12qNDyIcxOGe9CVIIY=;
 b=E9IjNx5G7uwhc9+LvpVqTFzaj/LzCXgxxJ9hctlJja9OQXx9+c0ZWhYOxrvvT+urJKKuwG3x1Rw9WPgr8uykkSXskeAFN2Epz4VXGsbE4WEMF0SZ9fDMwyf+nxBBR6wSyMlwzLpxnKibT+gVQNhBKUnq3upqsrObOphjVhBDXhAoSKmPaplAd2IISIn8he90pwT0UIavTJFx9oFvOHJRfZvDW+17Pc4PEsd+hrboh+x271DRE/maTY3ymDQZERKeTGMvQO96Omt5+1/29WM6BAI8xUiN1oir17xl6sP8OG2EwjbpLRpiIZB1+rnV4G24+YU5wDGoLcEygC7alYxKyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-watchdog.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A/XBhEuOr46YORTmIiPKPMM/12qNDyIcxOGe9CVIIY=;
 b=u3uFwOkYuJ0ohaFnyW+RC8FmfGv4LGPGZ9eNVXhRpX3/RvcGysfGm0g/Fsbw7UrswjX1eY/qxxNdJf4k9kyfRp6uhX3oJwicj/TiqMyavraveL8I8PO5Kk/k+ZXg5S4+WPcd0JKMDitcAoXkDAHmaRiWnSmoGjeLEuTa2g/3IPo=
Received: from MW4PR03CA0278.namprd03.prod.outlook.com (2603:10b6:303:b5::13)
 by PH7PR12MB6585.namprd12.prod.outlook.com (2603:10b6:510:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 10:42:39 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::a6) by MW4PR03CA0278.outlook.office365.com
 (2603:10b6:303:b5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.23 via Frontend
 Transport; Thu, 20 Apr 2023 10:42:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.24 via Frontend Transport; Thu, 20 Apr 2023 10:42:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 05:42:36 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 20 Apr 2023 05:42:32 -0500
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <shubhrajyoti.datta@amd.com>, <michal.simek@amd.com>,
        <srinivas.goud@amd.com>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <srinivas.neeli@amd.com>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <git@xilinx.com>, <neelisrinivas18@gmail.com>
Subject: [PATCH V4 0/4] watchdog: xilinx_wwdt: Add Versal watchdog support
Date:   Thu, 20 Apr 2023 16:12:27 +0530
Message-ID: <20230420104231.2243079-1-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|PH7PR12MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: 58cb61a8-dd98-4668-6870-08db418bf588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kMPdLwg6oMV1CoVYarpbGYKDnHR1nyqz4kR2HJuBWNtNal5F5a9ssnqFx+ouM9YCRqLlxufH3+AIo1SbX6pb7QvHOr5KOa9IsdYe1mJhrcO9R3aHBBw3iVSbuaBoUqYBAC6eA3wtho665kqNmimBJTL9R2qO9YWO62FWpaC3/daSodPDIOFVs39+cEbsm6urITho2uP1rKh2JSiq2OP50vCS+m2ZAeIyQzUF6NW9onoGxgrm53wYxW3r7Bpc8f+SbzxedrmEqD3M/MVh7LognqP//yS8q6Qu3HNcywbvueEG2zE9LJ/vZoxOJf5X7JsKcMbGIyl6G0VW8KOBBd7YVKVCTDq+t5p9X1D2ZUQTWBgSuwzxuQn43sabzYE6qwA00rMiOwCpmcwM1ZJEkonKlORlyj5dd67qm6eSXxYCQ6AsBtdJxCX0WYvVbRRj1Ey8IbyShBdZqGKvAHRE+VAoNE1z1ZUem0nK9f8t0sUZyg0gdpxJ1WpPb3JFCSuWRCm9E+kysiulLmW051VKriwoCcbyQEN/K85rnTzDV1YPTgJL27yPO+d0ok45DOoBlAHGygQRdN0nXEQWPtcQ3B/IitmMHVLiLkAqqX4D2eCY+7a9IZPO+PozhK9ANTCLkZ/SI8XnM+1DwWbw4KOBm3lPSYu5l4uD2fKnauXs0bIrmvGCbYbAw6JCLsR+UGkPaZeZE5hehy5KHUBPpTPMNcJGM6IPi/IngI52MtbUVNguTOs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(6666004)(478600001)(110136005)(86362001)(36860700001)(36756003)(2616005)(426003)(47076005)(83380400001)(336012)(40480700001)(40460700003)(82740400003)(26005)(1076003)(186003)(82310400005)(81166007)(316002)(356005)(70206006)(4744005)(2906002)(70586007)(44832011)(8936002)(8676002)(5660300002)(41300700001)(4326008)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 10:42:37.6955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cb61a8-dd98-4668-6870-08db418bf588
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6585
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series does
-Adds dt-bindings for versal watchdog driver.
-Adds support for versal watchdog driver.
-Adds fragment page for xilinx watchdog drivers.

There was a series[1] sent earlier to add versal watchdog support using
pretimeout. In review it was discouraged to use pretimeout for open and
close window . This series is a new implementation of versal watchdog.

Srinivas Neeli (4):
  MAINTAINERS: Add fragment for Xilinx watchdog driver
  dt-bindings: watchdog: xlnx,versal-wwdt: Add versal watchdog
  watchdog: xilinx_wwdt: Add Versal window watchdog support
  MAINTAINERS: Add support for Xilinx versal watchdog

 .../bindings/watchdog/xlnx,versal-wwdt.yaml   |  50 +++++
 MAINTAINERS                                   |  10 +
 drivers/watchdog/Kconfig                      |  18 ++
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/xilinx_wwdt.c                | 201 ++++++++++++++++++
 5 files changed, 280 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
 create mode 100644 drivers/watchdog/xilinx_wwdt.c

-- 
2.25.1

