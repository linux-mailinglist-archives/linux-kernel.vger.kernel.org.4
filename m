Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05EA74F117
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjGKOEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjGKOEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:04:43 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20623.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CB910FD;
        Tue, 11 Jul 2023 07:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxatZr4RtkXewKTYK6yxJ6/i9sHvzsE8B+OusUMjudJGQPerU7qPKXaDWqgyyxY6gAXIDP7jO1CynwDpKHV/xpx9u5Zyfa0AaMCX+u8ke4OP60mvdGFHlwXBczSspPlJhssLW0SwzUA/tk0F1WjA6QWQl4Y2BtYjQ96I/Z3ZVmX0c486HtBuvxgwj4fxFA5GsN4qAzHmwq6BefYOHO2oq64A4iy4cionqjEw2x9nYyGhrUrdAm0rS1w8nyx40ZQow/NMRAgEKEaIf8OjJa3011NRLerrqPBTGpUh3t/eHA4twCfjOE8d0u5p2nYhDm/PQ36lGnHt5Y7kb/cfvgvIDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pTSYvFETht6sMCSzKuPJd8oWLrcMVXn8r75pgS3Uyg=;
 b=MW0AybhfdRvB6X+Dpp97ChhX6+jogIW2nt5kq3zHRx6N70sH5Pu9Gxy9wwKeOViyiBCX5fU8jxrG5Rb6Rrdd0IZJz+BSRChpwps88fgiWuKRj4v3fVx2TKlgkDIbCLGdv9zhSIBTusYZ/EnXcuigAcVvw1QzD5fllvpNZ/cbZrwT4zBamNQpjriV3XMo4PpUoxLwv6nwv01dzl5BN4/o3npPHXq8xDPbM0nUmQ8fQyF0Op6MHHPEhxCSbixF3NZKtSw8KY6GD8vDK+zxFs/C9MPsjF5EcITGGiJZyTjiMjLpUGIuykNKVI+1oVs0lr/EZ0huzIg1NXORXx/b32E00Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pTSYvFETht6sMCSzKuPJd8oWLrcMVXn8r75pgS3Uyg=;
 b=ub5AfDrg5sSrdAjFZjUIaFKA7kTGer2xM+AA2jfMUFZwaDjMsquOsJTcUMmjZnTWXP6fbw9HMtkVVtwdvMwkYQKPsq7jt4DgP0L6L0qNVUrVl/5FhzG+oA3Ii/V3c+vkaBtrPDyVyoJRlbcdwZQoLcBcQXSGKz63piwOp0RnEoA=
Received: from BN9PR03CA0153.namprd03.prod.outlook.com (2603:10b6:408:f4::8)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 14:04:31 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::9b) by BN9PR03CA0153.outlook.office365.com
 (2603:10b6:408:f4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Tue, 11 Jul 2023 14:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 14:04:31 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Jul
 2023 09:04:06 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: can: xilinx_can: Add reset description
Date:   Tue, 11 Jul 2023 16:03:54 +0200
Message-ID: <c8e7f86d60b56a9ca2592d9ee30a3a64e535f429.1689084227.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1689084227.git.michal.simek@amd.com>
References: <cover.1689084227.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=800; i=michal.simek@amd.com; h=from:subject:message-id; bh=ktU+oCYPYvHUPIoixLda/q7IbfISa1Uix454Pt+/r4c=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpS1iR5Rpknq+1d2KzfNUPmifqZtTbbZEp7cmMKXe3/Ps Hz3vzi4I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzEiYlhvmu71MsLn5mzPlgE c7M+XPuiPf+GL8M8LQGXJbcC5rdmFkU8ibkksku1SNIZAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: 387bd894-0502-4f1f-e2cd-08db8217bfc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8PXPV9Hb4wKG7SNV9WGpeGpHufjzyWqhiazmCQmDhR9vtvvPg/dWnTyQCVIYDXzYEIYkCF2OY/Z1Ysw/sOsLoGNdob+pumbr1k3Df1BrbzgdzHNSCxCfkuanI8Bnyh8EWzde3RXkgPympT5kN7gD0CZ4RR9cn4DK8/t+Q5FM47L6/7ctu2sjp2j3mJBuhnMj2FIsIdR6HyLmjzu0b9D6WeIUuX99jJUq6oyZzP1T1wVSFuMhk0Qg4gReiokISnmRnjSUdvlTh76bkED2ZX5LAMKxbGHywX1KykabVVpJ+y6Qz8eznH5FgUDnolgF+G7/wcRYJUpC5hCXmbw9kp8F7qGSz7UowJ2N8/koKR0HvzPED441FlPmBhYJV1h3BVgevoR44ogpwwIIgUp/oXuWSFCR60K3ji95XIQ/SjfkLxdKutDBKvVC+jYchRSxXg1t52yddHqyXPexYQukHZj+C6dSr1Ssjzo6qhMbzHFu8YsTb+RZeF5eogkmNFcgCTJ6MawCGvKXAOg4hiLriODzn58EboTNLDXJOOM/S8mkWYyrf2lMbp/3SWijZeAOejaY0vTT0G+eQh31RRzZFqKBvoM7W3x3bDTZ97MuDEM4wVSkrE1s8MFR+n1TCKyErY+Br2UY9Pq0UNH3an+ktWWfX6mW07F725xD6INIuSmGO/s8W/YuUhJV8Er/6fnM7WgalrSzLt07Yzd+WbSOAqcfJWm/DYKuo+0nwHcTzVmecoXPrmCDd+ulrEkw7XPKbQ2/TSaLgmtiCC4P7HbKkqe9SlyknKipjBDLdt0YmrA3iJI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(36756003)(82310400005)(86362001)(40480700001)(40460700003)(110136005)(81166007)(356005)(82740400003)(478600001)(6666004)(54906003)(8676002)(316002)(44832011)(7416002)(5660300002)(2906002)(4326008)(70586007)(70206006)(41300700001)(8936002)(4744005)(2616005)(426003)(336012)(26005)(47076005)(16526019)(186003)(83380400001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 14:04:31.5798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 387bd894-0502-4f1f-e2cd-08db8217bfc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IP core has input for reset signal which can be connected that's why
describe optional reset property.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
index 897d2cbda45b..64d57c343e6f 100644
--- a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
+++ b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
@@ -46,6 +46,9 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: CAN Tx mailbox buffer count (CAN FD)
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.36.1

