Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12436FF2AB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238324AbjEKNYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238214AbjEKNXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:23:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F499173B;
        Thu, 11 May 2023 06:21:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bbj/5F8rZed22mCLHwqWkyZeDjjczvkwS82SqN8SyQwKvQAktIN/faE9SCi4iZOFtoofQclSoi+lOWoobp3tRVk173YFNbZ4iiRgKcjI6EVsQxCWo3vMyNIZQd9o0Bnp49A90GxoSxFKEQqBfqJE5ymWIpSaSvhirrDgIYce4r8aXObkR+yVp13Aon4jaCWcGZjUvLCiH5g4Fn1GnOFJcDxRVCq/a9gWK56FBRowustvtIMwePISB5VUEMaB4Qz+t9b6XVSgS1QoLUk1q2emLGPn6rAJDEWClg7jPLoUCAXg9VR0WFj1NEItoaTDmqupG+OAeGIEp/McpIxkFdZ/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8a0SkoIDo6jEczOU5I35DlYbs4SJGSq9k4aQ5+tKx0=;
 b=FKXX/o5CoiQhQGwpmC0v6wDfs8OcZPaCVh25oED7AirmvntBzqCy7Wu3hyQ0SK7lCUryzu6n0gkfP8QkjW6phYCwj61i6ykzutjyL/GJ1RrxqIKpb4mVPktWB+wht5AzqeksL/pik+pRNTrrkCg3jSZcGs7GCXApxEtPBSqnGsQRbv7lHfQXSPq2mVQrqM1TJkIbpWoQxwWCmxinqt0bJCmYwKkwyKZS3mJ0x2Z/QfHrKn5FfXzR+0Obr3Ecris5KiOMiqxK1x6HVOxgLjNBwOgyLNFr4fqZ8QfpoRMDdKVDSAwRL4QaeOwDLQGVXmiJ8m/5fObdtiG/TwKKT6NzUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8a0SkoIDo6jEczOU5I35DlYbs4SJGSq9k4aQ5+tKx0=;
 b=oe47Si0gZSIBgJ3ogx87J2hfYVhJccXPEO/0iE/XhgLXvpOQ2mfhfkC8pDLg6s+vdlEwyzKacuF1EBGxi4bfgpv+utjqp40KursadoPak3cgk9RQwfwMVE/qyL5t3qrKzN6FtlxtCM7SwVcqAutD+gERaR/UZekiEVcncKJ4a6L4Ll5wWW5c4oGxJ3igijCAsSZcVyikmoCRJGZMcTBwblrvQo9lwWeYkJHWyHwDiBY2MXjIXs/GMdEKmZdDt4fhbt91NDoJVof1p3vSB4Wa5deBVc/tZHFOkjlh1iGG0yBnk1Zt6fUA84YbLHg93eziGDP4jfLBge83hOCpT9S/bg==
Received: from DM6PR13CA0010.namprd13.prod.outlook.com (2603:10b6:5:bc::23) by
 DM4PR12MB5277.namprd12.prod.outlook.com (2603:10b6:5:390::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.20; Thu, 11 May 2023 13:21:29 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::e1) by DM6PR13CA0010.outlook.office365.com
 (2603:10b6:5:bc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.7 via Frontend
 Transport; Thu, 11 May 2023 13:21:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.22 via Frontend Transport; Thu, 11 May 2023 13:21:29 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 11 May 2023
 06:21:15 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 11 May
 2023 06:21:15 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 11 May 2023 06:21:12 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joe Perches <joe@perches.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>,
        "Thierry Reding" <treding@nvidia.com>
Subject: [PATCH v4 1/6] dt-bindings: mailbox: tegra: Document Tegra264 HSP
Date:   Thu, 11 May 2023 16:20:44 +0300
Message-ID: <20230511132048.1122075-2-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
References: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT059:EE_|DM4PR12MB5277:EE_
X-MS-Office365-Filtering-Correlation-Id: b20d041e-59c0-4710-6e8e-08db5222a174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b6N3cjJLA5MD9GQVetRgDtep0JLLo62Sk1ccIn1PhYC7iK4mp41lRW4vOLxqEbfPFDIaWmg7TlXglaaNxZPc9a7wobNpL3FvFB6WQMYRkK45ogKqjcYv7iDqpqKBKcYtFCniCNfM9I4K0ZChzdkxcyRMMmX3lMfHXn8Ub/ycPQ+BQbzsjki1IQPN7rtnzgUTrlH2sApo73CEKSTnF+qSV5TW2kyLBGrvsdXH485DXie8Kw0EXghXb6tKKK8bjB2ikudp0vfWi+zWjPpWIkeD7O9IVXyW9BaUS/XiGz0CsBRinj5OPHiQv32MprBC/YheGE+celMRMjePPm9HNu8keyvRRxu4RLdYsF468mNq1PviwTppO3GbNAQfccKTOpYDv/uGcy16O9e4Z+Bwl91joDzmy78nWOawby5cyVJI7e9VpDN2bgB450X0IZjz6PYXFoLLcUsY+G+kDGp27BoXRfI3Lu4/Kb2mzkBbPpvVfj8D1WUsAaLDaxIXaMRDRwlDhrgZnfHmIzS+dR1eecMAoBitUYgyxPkUhrIGYYZD/XvFy/OMbGmmPTUqWk9M5WU3RE3XAQ/4y/6AoCCu1aSnoQGG+hw0WZ1DSwWOfsSt5/Z5t51a1hsGgLLdnK3rnbvtCiGl7/vRVulXuJl6s8tFbobkIZ05CsDM6nNtN5iEXYmbtng6or/ZPFGegCp8uMQuiUoColh1hPJBBW5KU5C4avxTr8GmbyJRI/8jVC31G6/p9XMYRLu4EsPQaBb+5Y9j
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(70206006)(82310400005)(6636002)(107886003)(8676002)(54906003)(70586007)(110136005)(8936002)(83380400001)(2616005)(4326008)(47076005)(316002)(336012)(426003)(41300700001)(7416002)(40460700003)(1076003)(186003)(40480700001)(478600001)(26005)(2906002)(86362001)(356005)(36756003)(7636003)(82740400003)(15650500001)(7696005)(6666004)(36860700001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 13:21:29.2622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b20d041e-59c0-4710-6e8e-08db5222a174
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5277
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible string for the HSP block found on the Tegra264 SoC.
The HSP block in Tegra264 is not register compatible with the one in
Tegra194 or Tegra234 hence there is no fallback compatibility string.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 .../devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml
index a3e87516d637..2d14fc948999 100644
--- a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml
+++ b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml
@@ -66,6 +66,7 @@ properties:
     oneOf:
       - const: nvidia,tegra186-hsp
       - const: nvidia,tegra194-hsp
+      - const: nvidia,tegra264-hsp
       - items:
           - const: nvidia,tegra234-hsp
           - const: nvidia,tegra194-hsp
-- 
2.34.1

