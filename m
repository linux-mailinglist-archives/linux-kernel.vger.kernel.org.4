Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70653666B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbjALHQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236453AbjALHP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:15:56 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D71CDF6;
        Wed, 11 Jan 2023 23:15:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbgajXCo26ffiiBHy1muUdskAWkIZiQ4LxxFAc0OB+NC7MYWG0eV3Layqfv/xyTnFuk3FBSqJZoDm0J3IYDQg9KZB+yFGGVv05RlLqSl8uuKmMdWwZI8NBSvHZZVV4HYDtGVI4S+/PYMtgBy+h8LpwVXnweg/D7RqHgMbv/AdpBMThwiUeWhyP84MC/EzqSkObPUuQs2b0fCp3FCUjqVTXKDrhpAhQclsQhxVnTck6GzShFzfahW6+C/2vNiAKSXaPDH++MkgQPgh8vNE11NQhWYmbNSTlvweCphM/pEZ3JiApSFRQoDdv0jEF7lHErvGPqwe49mNnQ1ni0PteZcfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNO+9HxQ3nWY7GvGKfUOxnnoWl4ZDx49Gd+tZ5M82hA=;
 b=YVdjdsNvmlTid7qAgiuFlc9ZHlIEwmV6iCxdbnfRbENlLs80R2a4eE3r3UGQGNZrbCo9YNs8ydPcZAJLBU0FNArP8a/sG6KKcME+kHWfqnkQR/AvT64qgEgh4qmTy37YFf+b1aNWipohDGqvhQBMwWMGV9AACwrXDl4PW+yaATreedA+cS23V35RvVXrARwcENO5Kh5+ab9pwKZYdQU85TwytEVNsBCeAOHsoz1tYxFxYD22o9Y7x/cDWIoJ1xANb2GemTFtkS9NVGlOYj6NqD5tZlFqwXhHKs66jkP8bJr43nULECzft2PqsgzTAr1lvNff0EYvGp6TY5hR0iXetg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNO+9HxQ3nWY7GvGKfUOxnnoWl4ZDx49Gd+tZ5M82hA=;
 b=WzRX0yxJiKTNyWC3OZobTMbkTbaNInV5y7lqDwni6olDCta+cXZeL5qnFpsMdobXlhi9piE7QcVA0V5rNkjiKoNPdA2VYIxAEKZjByDYHdWJah16YhtC7A5UKc4mt8UDvV0RratzUmpt3PEBUjpDOLzATY6AWf7UJwTooKqaEHU=
Received: from BN9PR03CA0430.namprd03.prod.outlook.com (2603:10b6:408:113::15)
 by BY5PR12MB4967.namprd12.prod.outlook.com (2603:10b6:a03:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 07:15:52 +0000
Received: from BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::cb) by BN9PR03CA0430.outlook.office365.com
 (2603:10b6:408:113::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Thu, 12 Jan 2023 07:15:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT109.mail.protection.outlook.com (10.13.176.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.12 via Frontend Transport; Thu, 12 Jan 2023 07:15:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 12 Jan
 2023 01:15:51 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 12 Jan
 2023 01:15:50 -0600
Received: from xhdmubinusm40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 12 Jan 2023 01:15:47 -0600
From:   Mubin Sayyed <mubin.sayyed@amd.com>
To:     <robh+dt@kernel.org>, <treding@nvidia.com>,
        <u.kleine-koenig@pengutronix.de>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <git@amd.com>,
        <michal.simek@amd.com>, <siva.durga.prasad.paladugu@amd.com>,
        <mubin10@gmail.com>, Mubin Sayyed <mubin.sayyed@amd.com>
Subject: [LINUX PATCH 2/3] dt-bindings: timer: Update device tree bindings for cadence TTC PWM
Date:   Thu, 12 Jan 2023 12:45:25 +0530
Message-ID: <20230112071526.3035949-3-mubin.sayyed@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230112071526.3035949-1-mubin.sayyed@amd.com>
References: <20230112071526.3035949-1-mubin.sayyed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT109:EE_|BY5PR12MB4967:EE_
X-MS-Office365-Filtering-Correlation-Id: fc96fe43-ad86-4f34-96a9-08daf46cd6bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yxOmxZE1sgRDqDxGaI34CWRslLE++TudD1J1fILQQHywkdcquZVsTiVELkaq7q/0bLmmsQ4ZWXsJHWCxIeR2tUl25jU/SFu1VErd3Q/0K1YoCMdRF8VXZFgtDgA1h2xARvtFpFuas0xdPwnM/KJmzw68nYK4jlKMCLxCUmQFCbFS1dQDXvL2oXUX1bYImig6U1kMPGmrulDJCrQicsf8vhj6ZcpuZJ0yjy0BLfaKdZ6+hncpe71yZg9+JErSmiFuz/1mchPRravXdyBHpQVXrJP8IwdKIjjXBqVioV/MjTtEX8i00KSCwYpEsRt6d8runOnXCMp0oGjZXIakvBmzhmFUo513aDIHW8wd3QQIWug3hLcs6SswnvEKcsRXD632dm7zxQPRRSAWOw/NhBSNIpTvD4Qe3GEAdmkG6pVOfdX5WSSVooDUXQgJ5mY3ExvY1RLYke2nzQyBrmXR0p0dWRpWUCnBlXJnLyPLzitsXXWgxX9kivG7ug15FUsa3DNnxLKnj+osY/Rw40o3wCDmOU7h4zjuBHvcxIdQzgoB94H+HLb+KdiKuJfzwpA7CXJqRqY4cw15XnXm3GsQ7cHIzFrt9sAXt0H5JuwN8RbB/ga+MJz/qXeE01iC1wfQH02VKKlEGIzh388dIB2/xTvIJ4wIusTdqWsHWdgrJ2HiPEeI5ZrYWDSL0EGKczSNtpJeZ68x45fLVKmttUGiM+qOkxD164So0eB7Mn6jRqsEiVM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(478600001)(426003)(81166007)(356005)(47076005)(41300700001)(1076003)(40460700003)(86362001)(316002)(110136005)(54906003)(2616005)(70586007)(26005)(336012)(40480700001)(186003)(82310400005)(4326008)(36756003)(70206006)(5660300002)(15650500001)(36860700001)(2906002)(6666004)(44832011)(8676002)(8936002)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 07:15:52.2141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc96fe43-ad86-4f34-96a9-08daf46cd6bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4967
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cadence TTC can act as PWM device, it is supported through
separate PWM framework based driver. Decision to configure
specific TTC device as PWM or clocksource/clockevent would
be done based on presence of "#pwm-cells" property.

Also, interrupt property is not required for TTC PWM driver.
Updated bindings to support TTC PWM configuration.

Signed-off-by: Mubin Sayyed <mubin.sayyed@amd.com>
---
 .../devicetree/bindings/timer/cdns,ttc.yaml   | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/cdns,ttc.yaml b/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
index 7d821fd480f6..2855e92e02e3 100644
--- a/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
+++ b/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
@@ -32,12 +32,26 @@ properties:
     description: |
       Bit width of the timer, necessary if not 16.
 
+  "#pwm-cells":
+    description: |
+      Required to configure TTC as PWM device, supported cells are 0 to 3.
+    minimum: 0
+    maximum: 3
+
 required:
   - compatible
   - reg
-  - interrupts
   - clocks
 
+allOf:
+  - if:
+      not:
+        required:
+          - "#pwm-cells"
+    then:
+      required:
+        - interrupts
+
 additionalProperties: false
 
 examples:
@@ -50,3 +64,12 @@ examples:
         clocks = <&cpu_clk 3>;
         timer-width = <32>;
     };
+
+  - |
+    ttc1: ttc1@f8002000 {
+        compatible = "cdns,ttc";
+        reg = <0xF8002000 0x1000>;
+        clocks = <&cpu_clk 3>;
+        timer-width = <32>;
+        #pwm-cells = <3>;
+    };
-- 
2.25.1

