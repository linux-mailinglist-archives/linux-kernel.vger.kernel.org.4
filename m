Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2897084D5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjERP16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjERP14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:27:56 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8751119;
        Thu, 18 May 2023 08:27:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuoY6Rf4WuQE9R5gOnuop/UOVDkeK7BDVujrwXcRGlp2U+SarHACOzc7xWk5nATfLaJqQOwvsl/7ZSxggXt9tMd2dfAZ3CMXYbXZY4pQ7T/CRWjB0kA30B6t9h1w3bQ+34s4o2bSOShhpxjUleRzDpDkLrtkJkMmFi+PWWAc7oUFFrB+uRLH8EgoY9IfXNG5af+2YQs9r7IlwP3MUCrRBvy3Y+hPCMiW7li6xnLttLNNWkKz7qCmxTewbu5xHEkDKiLbZ0B+GvQZf31z/RBLsXR7jXhdkPOB8JyXOxOumyEqgKf4PRPn/CDg2A0w6sWhUIj0rgQD2Miqpqto0C4xcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8IDeOQK/fCZAR6RFCb4PKe3IkP6qRYWnBkJ1qFeuVo=;
 b=a+88gaRwx8L9CVBngwiQ7mVUH9/ZZrnBFuhrtWJbNKfMKoF5cKErYGapihYKE/4PHrJ7W8j6vASS1H8ZjUhKU1AIk1oEHRIEtUcQgEImWw4ja8lUWd25NxB7BlHDFrLrli7JxK6bfePaD05UkNXbzrILUr2w8b43dQ48pyI6+DhxNV8N7W/fbnMq6rGGHmDxiv6Ze89r/0ypLKepeV6MI7VPp1aSdA/9e1kdH5PBH9SVKRxWiYBvAdTyTq4vq+MsTH+vm41ORWZZnm/trweV8Fg3fcHJVCah/HttjkpaAoZqiXXC6MNHMDF9Bezf/6B3peKK58Mw1lxk2wW8+x+7ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8IDeOQK/fCZAR6RFCb4PKe3IkP6qRYWnBkJ1qFeuVo=;
 b=Vmw3elRK9emXvHlz09iBGHmQDD00GfgbYo6mVkWwFaxzxZ2pK/ILsUe6Pd0PqshjpvzzX1/TBE7bJIpkXBYteKf3tV0yukEA7G1LFHX+MAMBmFOD5cBur4PM7j7QZMcYSSFCxsyBY2b7rlw0cGoV5JH/u0BlGMdZbp2/udpPVpc=
Received: from MW4PR04CA0267.namprd04.prod.outlook.com (2603:10b6:303:88::32)
 by SA0PR12MB7480.namprd12.prod.outlook.com (2603:10b6:806:24b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 15:27:44 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::12) by MW4PR04CA0267.outlook.office365.com
 (2603:10b6:303:88::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 15:27:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.20 via Frontend Transport; Thu, 18 May 2023 15:27:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 10:27:43 -0500
Received: from xcbayankuma40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 18 May 2023 10:27:41 -0500
From:   Ayan Kumar Halder <ayan.kumar.halder@amd.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <geert+renesas@glider.be>, <mazziesaccount@gmail.com>,
        <conor.dooley@microchip.com>, <j@jannau.net>,
        <mailingradian@gmail.com>, <me@iskren.info>,
        <lpieralisi@kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>,
        Ayan Kumar Halder <ayan.kumar.halder@amd.com>
Subject: [PATCH] dt-bindings: arm: Add Cortex-R52 to the list of enum
Date:   Thu, 18 May 2023 16:27:30 +0100
Message-ID: <20230518152730.82954-1-ayan.kumar.halder@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|SA0PR12MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ee5c76-0921-449d-591c-08db57b46d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w4HAmigCsMumbKDmq9NN/ANg6N6U2pniZZ//BUOqNdmi4B6BEow8XdjDOlZvRJSr3CjrrH1S7bfmU4YaJVZpZOKJi8euYUMxBmtWqchixWpaE0z7y+Zb0COxSVmD5XLe9I5/why/HJi06ibg/qotE0BqD8aKi1HuCNxdbUxJH2yRDPrzw0e7S1bDbXfIk4YODw9zOgyUT5N1reRAPtPI7B3K/pp3Rx4tEk8RKOMLkOdErmDloqo+UKkHNI6pBiB4G7vtKCdFIZKX3VxGQU1NO/z3UIJ5gYLvM+fhRTYFjHhf8TP5uPnAw7jaUcK0FOWRvPCrrMZ8MkR/3qczUxZ3BofE1OKIUjjUnmiymtPMmM8WKK12yMUHfKKJ4OynHUqAiHXDVKWIaN0xdSokDwgfJDmthD6z71T2X6K4FJcMnWi4N63+WGjqaHL0LxaUL3qCOvLH9HrL+TbRbTstHAW506d1OOVydu0q385Hg2Yg+w9sX0FHF1J7SKHV0nMYVCm2BzoWUQekSZB42Iy2zLp/zeKzknKGXtscUCSmlbZOapu3TVUKfUBaIgUbL5MfIeLiTbu2r1dx2w1KalIo4xI7WGby1ycx91rLjt8vSRL72hhVdaaNOxCga9XyyS1cKVs4EKsOduPqKUX7VFSrL+ofgU2ghYsyuFZvCr+E9Sz4JZEKEESAegVsnVwbVX2ATdQt3oJXSeFe3efcUQ14wpK7zlVqsznknGTQKPtXPxWLWdgb/r6miR/fa1hxTazCbWtURl7ql8+/WSnw4VzSXrG7b3/IRq/h9GXv2eXD0ec9JF/Vx8TL064kCqgh//44VWoB2V3vE+t62ROy441yGn67/xZt8axf4UN+5/x+UxsJSWI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(6666004)(40480700001)(40460700003)(1076003)(186003)(26005)(5660300002)(7416002)(82310400005)(41300700001)(8676002)(8936002)(4326008)(86362001)(82740400003)(356005)(921005)(70586007)(70206006)(103116003)(81166007)(316002)(54906003)(336012)(2616005)(426003)(36860700001)(2906002)(4744005)(36756003)(47076005)(478600001)(110136005)(781001)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 15:27:43.9543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ee5c76-0921-449d-591c-08db57b46d39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7480
X-Spam-Status: No, score=1.8 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a pre-requisite for porting Xen on a Cortex-R52 based System-on-chip, we
need to add "cortex-r52" to the list of enum.

Signed-off-by: Ayan Kumar Halder <ayan.kumar.halder@amd.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index ff272e517d57..64b58238e3a1 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -153,6 +153,7 @@ properties:
       - arm,cortex-r4
       - arm,cortex-r5
       - arm,cortex-r7
+      - arm,cortex-r52
       - arm,cortex-x1
       - arm,cortex-x1c
       - arm,cortex-x2
-- 
2.25.1

