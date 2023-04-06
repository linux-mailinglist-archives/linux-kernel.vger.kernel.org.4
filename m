Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC6B6D9E99
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240138AbjDFRUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239512AbjDFRTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:19:52 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC01265A9;
        Thu,  6 Apr 2023 10:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XH+AR7MuvHQRF0c6L+SNlTTix/MfU9S8wXa8JxVuQlP+GUbN2A4bqoHlFFtc8qW5O9NX/sgAQNnImbxSstTK+snNWk1sEoeRZbVaD19dd1qURs6fszuLXnNTBadZWUGxafVxxdWBj9C1Gix9L0YLcyenclk1cCibAl+iUqeHrzP5qs9IT7ugS23TTLBDbAf2mvZlleLWRzguWC9d3uAejzdWx7tZeV8oQiOvmvOMhF4XkvNg5F1rAYC0J+x3PCpRr6+0582s8TW2FD/UOTVdGJzqs4cMOzsu2WghnfihYW7eSzylUf5ij8fzQG0cYX4O5gAQeQCc6A9aSYlAbvaXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dP5kJ/vC5AJs62jqKAJ+brtcGkn+r0lWkhnYvZGCnX4=;
 b=TWzDHb1+vRyJGu3LTlOpfMH0haUDGPlAvCY2HWPAcKzoAnoDDypWvNtmzuO67XgwSQgEHs2yzuliGc2LjLE6bRfHzic4V8lYLjOYR9Nvs1T3YML8jW0xvQZGHAb0+cGo1de37dToJ0VcMA0JyUuoxolEnDGElPl6YjDOnsEgAqW1GrThErG/vM431O2u5Ipf3u9HEMfTQrHAuBkMxlLf+lUXRF3e6aFA5C3s63OV04MjF+SQdUAhpaIQB3AL/cgwqPtGpuGMnoX6nG3loxySW21dphpz1uw4EdTLw9RRqa4Bjq6OF0PlG7q53NvvRGxREUXaiZWwd1TiaaRTY7eC9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dP5kJ/vC5AJs62jqKAJ+brtcGkn+r0lWkhnYvZGCnX4=;
 b=YBXmH0NwUxLqD+KXVqw/n0bSH+ezwRQzD6pXqUcg57Ws+5ay+mB7iJ9ErJFkGPC9sUVLK95FtMi5ZeAiAq9Tlxj1fUCEfbVDjxfOtSwL5Ev2cFWnSYfA1l3zUKcHMGYe8YtLekuz0r9idOEqrUb8zg2cZs8CoVHzVpIiBA2a8DQi+M1fzrPbdv5OGqTHtKlW2Ulc2+dnI5fl/jOT1SJsyJXfnnW7aZ7xPnq9fBDaJTJa2V3IRFLNKfTM42t5rzr0i6jx9lrnO8khwTkOdoFltLyITEQY1l55iGhkZZ59MxunibidcHQzMQM3cEDA5OqsmEolyYeSxyrKiQsC0jQlEg==
Received: from BN0PR04CA0078.namprd04.prod.outlook.com (2603:10b6:408:ea::23)
 by LV2PR12MB5797.namprd12.prod.outlook.com (2603:10b6:408:17b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Thu, 6 Apr
 2023 17:19:08 +0000
Received: from BL02EPF000145BB.namprd05.prod.outlook.com
 (2603:10b6:408:ea:cafe::9) by BN0PR04CA0078.outlook.office365.com
 (2603:10b6:408:ea::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31 via Frontend
 Transport; Thu, 6 Apr 2023 17:19:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF000145BB.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.35 via Frontend Transport; Thu, 6 Apr 2023 17:19:08 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 6 Apr 2023
 10:18:42 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 6 Apr 2023
 10:18:41 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 6 Apr 2023 10:18:41 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [V5 06/10] hte: Re-phrase tegra API document
Date:   Thu, 6 Apr 2023 10:18:33 -0700
Message-ID: <20230406171837.11206-7-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406171837.11206-1-dipenp@nvidia.com>
References: <20230406171837.11206-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BB:EE_|LV2PR12MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cbfc649-9de7-4545-420d-08db36c30837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 79CdTszBmLszeXitwHvUE5nXo0p7C2LzQWaF48cW//47354iU8Z7sEUbPW5N6/8hOcuKIh7eNAw/GWKnR3GY34oaacc774zdviRBqNXVQnt+Pt8SZ9QOYeovAaB19KLIDQ1c7jU52u1eERdgUdO88STj1gWIXrO/em74CHkPCqydLihvXLq+ABe4R60/5i9gXek5lrXEqTyuv6q/2Pk9Bpo/wxRdj/Emxl0EvkDKbkMF1BVdU1IPrmRwA4iYgbeom+9k1H5/2EZauDH6gO7JB2YISad9lG0pgmMIFE9wxXIvlQVwhEjEsK5lkSVlfzWbfjBfg6q+ftgfRVugM8RiEl4heQltJbxJGm975Vo8xZU31lqSrPTwSxXN2ZSl7XNhUNyiF4yYpAfEzpp45ynpNLULurceC7VCx3bgFBKmLungPB9o7Y8nen1r7z9T5Z6qAOYEegSjs9yYiMkg3XzS26bMBjwrVdzG0S7jygG0xCCE4fY2MSEdwRolsMTGUvx1oLbXCxPEea5TndrDOYdTD67rtgZP+fsrwObDcfrPMvzXuufDnJOlpH/R49/Oy9Z3GpRdRzGHFuqMlmiBnNxHVTlwuoev9KIOhVPlWOP1ElxxTqko+DNPmEDD+jL2N8hKIKPpS/LxXuMBF7kwqrt/LO/Ezg0Uel1eBa04V4RTGmqpI65ec5FJEUu5dioZzePMRc3V6yw3q0JmBnvSGRyvY8Rc7hXJkEjZe2XUATrHpmVo/DUVEWz7ecEslcSSRBqqNQ+Fy0l03/K3LB8ZnVY3tReBUyFQ/HiiRSXCcNASrlmxguSX8+EDDFwBN4uxImky
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(2616005)(86362001)(82310400005)(2906002)(36756003)(83380400001)(40480700001)(336012)(107886003)(7696005)(426003)(186003)(6666004)(1076003)(26005)(36860700001)(478600001)(70586007)(82740400003)(8676002)(40460700003)(70206006)(4326008)(5660300002)(41300700001)(47076005)(110136005)(921005)(7636003)(356005)(7416002)(8936002)(316002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 17:19:08.5543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbfc649-9de7-4545-420d-08db36c30837
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5797
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make Tegra194 API document generic to make it applicable for
current and future tegra hte providers.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
v5:
- rename tegra194-hte.rst to tegra-hte.rst

 Documentation/driver-api/hte/index.rst        |  2 +-
 .../hte/{tegra194-hte.rst => tegra-hte.rst}   | 33 +++++++++----------
 2 files changed, 17 insertions(+), 18 deletions(-)
 rename Documentation/driver-api/hte/{tegra194-hte.rst => tegra-hte.rst} (50%)

diff --git a/Documentation/driver-api/hte/index.rst b/Documentation/driver-api/hte/index.rst
index 9f43301c05dc..29011de9a4b8 100644
--- a/Documentation/driver-api/hte/index.rst
+++ b/Documentation/driver-api/hte/index.rst
@@ -18,5 +18,5 @@ HTE Tegra Provider
 .. toctree::
    :maxdepth: 1
 
-   tegra194-hte
+   tegra-hte
 
diff --git a/Documentation/driver-api/hte/tegra194-hte.rst b/Documentation/driver-api/hte/tegra-hte.rst
similarity index 50%
rename from Documentation/driver-api/hte/tegra194-hte.rst
rename to Documentation/driver-api/hte/tegra-hte.rst
index f2d617265546..85e654772782 100644
--- a/Documentation/driver-api/hte/tegra194-hte.rst
+++ b/Documentation/driver-api/hte/tegra-hte.rst
@@ -5,25 +5,25 @@ HTE Kernel provider driver
 
 Description
 -----------
-The Nvidia tegra194 HTE provider driver implements two GTE
-(Generic Timestamping Engine) instances: 1) GPIO GTE and 2) LIC
-(Legacy Interrupt Controller) IRQ GTE. Both GTE instances get the
-timestamp from the system counter TSC which has 31.25MHz clock rate, and the
-driver converts clock tick rate to nanoseconds before storing it as timestamp
-value.
+The Nvidia tegra HTE provider also known as GTE (Generic Timestamping Engine)
+driver implements two GTE instances: 1) GPIO GTE and 2) LIC
+(Legacy Interrupt Controller) IRQ GTE. Both GTE instances get the timestamp
+from the system counter TSC which has 31.25MHz clock rate, and the driver
+converts clock tick rate to nanoseconds before storing it as timestamp value.
 
 GPIO GTE
 --------
 
 This GTE instance timestamps GPIO in real time. For that to happen GPIO
-needs to be configured as input. The always on (AON) GPIO controller instance
-supports timestamping GPIOs in real time and it has 39 GPIO lines. The GPIO GTE
-and AON GPIO controller are tightly coupled as it requires very specific bits
-to be set in GPIO config register before GPIO GTE can be used, for that GPIOLIB
-adds two optional APIs as below. The GPIO GTE code supports both kernel
-and userspace consumers. The kernel space consumers can directly talk to HTE
-subsystem while userspace consumers timestamp requests go through GPIOLIB CDEV
-framework to HTE subsystem.
+needs to be configured as input. Only the always on (AON) GPIO controller
+instance supports timestamping GPIOs in real time as it is tightly coupled with
+the GPIO GTE. To support this, GPIOLIB adds two optional APIs as mentioned
+below. The GPIO GTE code supports both kernel and userspace consumers. The
+kernel space consumers can directly talk to HTE subsystem while userspace
+consumers timestamp requests go through GPIOLIB CDEV framework to HTE
+subsystem. The hte devicetree binding described at
+``Documentation/devicetree/bindings/timestamp`` provides an example of how a
+consumer can request an GPIO line.
 
 See gpiod_enable_hw_timestamp_ns() and gpiod_disable_hw_timestamp_ns().
 
@@ -34,9 +34,8 @@ returns the timestamp in nanoseconds.
 LIC (Legacy Interrupt Controller) IRQ GTE
 -----------------------------------------
 
-This GTE instance timestamps LIC IRQ lines in real time. There are 352 IRQ
-lines which this instance can add timestamps to in real time. The hte
-devicetree binding described at ``Documentation/devicetree/bindings/timestamp``
+This GTE instance timestamps LIC IRQ lines in real time. The hte devicetree
+binding described at ``Documentation/devicetree/bindings/timestamp``
 provides an example of how a consumer can request an IRQ line. Since it is a
 one-to-one mapping with IRQ GTE provider, consumers can simply specify the IRQ
 number that they are interested in. There is no userspace consumer support for
-- 
2.17.1

