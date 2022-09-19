Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428C45BCE49
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiISOPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiISOPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:15:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B014319038;
        Mon, 19 Sep 2022 07:15:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NabqM4ng1K3LYPs1HC7Rfo/EjRBGJi3gfeaKan1JUPbkFPo/7Ddw7lNhp7Mfta89Tg3ty1EvKV2heGg3p98nUPZaHEzk4eEW2HBb7q+Y8hv1ae0m+5qDTEj3xq5eod2TWCTlbqtK+2TXb/bK2mJ1jq28uWzGZH+KY47WG1z1UG1llXd+RtBHGYIRWHnjIWH1BQU+0zajzyqheNopOoawfZTXfKne9YhKzpQNIUNuQvk32X6xhN/W4QC2iu2HKifDJl/AEX0iPiuByqkn3h9QwnjtUGk41JggeAPWd77km0Cc7ibNdzSTMO5SxpxiR0CNnsWAuVB+SEJ9+Fxn8R4uXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FYHRGw5enJ5DTaHU2GbtEt7EgqyeURoQtlqyRV4Xsk=;
 b=Fgg+dh8Qg+tUuM/2bpqIC5j11ciAyh/o6L9b2qxrVdN7upg3iCZJ6d84NGr8LhXBar6WjPJFVevLQyL51PyLtoA8reQBtPnztItQRQT/I70nQZ/tMccTYmB3llVCgtgiHR9gl/Co6zDgacy6/MtHHyy57F+z6fgRc5g2IdwUHrnTOXCjN6aTbzmVXuD+KeoeSCRREubiBjC5M18VPG6SQ1RtepyIGCD6PQMcJueCmMDLH2fwAMKsiDWBjfxcwOr6rzQQYEGl7cvVTjdhOoCUIj6+W6Ds614dSHwR7BaqRdBPdFFkf/ujSpNy5kqYpzx34DEKHvxx54jJY0JPwhAhjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FYHRGw5enJ5DTaHU2GbtEt7EgqyeURoQtlqyRV4Xsk=;
 b=cc88azsLaS+xkTq5Oovqht2LL3VXyeceloizUisi9/F0XxxOxBXrtE6W/zT/tW7zOiVbQmuR4e8lccVxDgV/HmWaLLTSDq4f0xyMyMUtToDw+jxz6es79XEybo1EBa9Wh51W8DN1vQVUX9X8rmqczXOERkhArneTzE34i2/n69uMNlFmmD4ChkxmcF0K1BXTQvzq4bTpU8dhUyNdJSAmynpNTO4HMjH42R0iIl71U1Tm+lgelCcSVGx06YCBAFNEBvbDJ8mnwOjz7fmTw90xkA3CSGVO5y7Yyf6lXZQc1Yzedgx4kVwE/kMmiKRKWiWKHeWwWq6GhzeyFAAWZ64tBw==
Received: from BN9PR03CA0765.namprd03.prod.outlook.com (2603:10b6:408:13a::20)
 by CY5PR12MB6105.namprd12.prod.outlook.com (2603:10b6:930:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Mon, 19 Sep
 2022 14:15:08 +0000
Received: from BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::ab) by BN9PR03CA0765.outlook.office365.com
 (2603:10b6:408:13a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 14:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT092.mail.protection.outlook.com (10.13.176.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 14:15:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 19 Sep
 2022 07:15:00 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 07:15:00 -0700
Received: from sandipan-pc.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 19 Sep 2022 07:14:57 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <kyarlagadda@nvidia.com>,
        Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH v5 1/3] dt-bindings: pwm: tegra: Document Tegra234 pwm binding
Date:   Mon, 19 Sep 2022 19:44:53 +0530
Message-ID: <20220919141455.31084-1-spatra@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT092:EE_|CY5PR12MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: c68832b1-a365-4b7e-556a-08da9a495b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PnaMGTbYEUZUGF1iti+CYpycJQkTGf780X4gR6yipvcJnz7sPfpZf0FwGceSPcUBP8dfx+Cxk9w+4wB+7V2UL6bxyr1TMatrX8ton+KGprir6cCHA1ssiEreRT/Jwmy3jRp/Tb+IR6nPRVO9j7f9hdRkW3b3ekmVB9yS72VQvWH2wdyK+jp7s/dOrhmuMzYtL/o4XOhmKmiI2JFeA+mpHjec4eJ9v0gXCqokoTEibAhgD3+LdLEuyyGYPFrPxnPl/FhEvmQW/3Tw8bLNl5evDPLFjPTPfMAb6yNXVDPye1raatVBFeyEPKnm8qFYVeHUjM3v0hIfsP3/v8PCoMo7IgTEXXqcscLraS9MTAPfW6gxVBGgghildoW7zSHToqEm1iUrVA6Cnh9h72/PGF7mWafJ9yL6HPKCajZ0vQ3vBBmVDuBaHqYWmiH4gUdMJzCocVzX3qpv1hykxOiUA2RllQuk56DYU/reIS5KR3yoS/ACUfQPbtVYy2zmaApspIWyFvwwq9lkD1tlH7gKHBj6kjC44hcXIg4qcX0l+AyabX6L9lVMNP7j436a4Coa65LYoY9D6oKWutVBIZ5IqxYMiYnY1760tc+iNvd9Gwn443VkKbrAjBXRGaHjMNcDRdP7kkUagc5Onddh5qHe9HAaX/ZjimKNt3BAQIYYR9Wb7Px1pWx0z73VtbDvauWGZoDGjmKcLXQV2IPcUtIrXpGAp/FRxwv37HuErLuFdji1dRJpo2zbdZC6orkq67y8n6Nh8xoMYpH9O3TbICPS82DFesSSJ5RlcedmsiYOOY6zXbweXAD7zA7J0pBDybiKmmSw
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(2616005)(316002)(54906003)(110136005)(186003)(1076003)(8936002)(478600001)(6666004)(36756003)(40460700003)(2906002)(7696005)(107886003)(4326008)(5660300002)(41300700001)(8676002)(70206006)(70586007)(86362001)(336012)(40480700001)(26005)(82740400003)(47076005)(426003)(82310400005)(356005)(7636003)(36860700001)(83380400001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 14:15:07.9309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c68832b1-a365-4b7e-556a-08da9a495b4e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6105
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for nvidia,tegra234-pwm with nvidia,tegra194-pwm as a
fallback.
The PWM controller blocks are identical to ones found on the
Tegra194 SoC. No driver changes are required and compatible string
"nvidia,tegra194-pwm" will be used as a fallback.

Signed-off-by: Sandipan Patra <spatra@nvidia.com>
---
V3 -> V4: Mention fallback compatible
V4 -> V5: Update Compatible with both Tegra234 and fallback

 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
index 74c41e34c3b6..47f1abf20118 100644
--- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
@@ -10,6 +10,7 @@ Required properties:
   - "nvidia,tegra210-pwm", "nvidia,tegra20-pwm": for Tegra210
   - "nvidia,tegra186-pwm": for Tegra186
   - "nvidia,tegra194-pwm": for Tegra194
+  - "nvidia,tegra234-pwm", "nvidia,tegra194-pwm": for Tegra234
 - reg: physical base address and length of the controller's registers
 - #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
   the cells format.
-- 
2.17.1

