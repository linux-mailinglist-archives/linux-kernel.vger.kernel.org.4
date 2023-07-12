Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3E575080F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjGLMVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjGLMVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:21:19 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59FBA7;
        Wed, 12 Jul 2023 05:21:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqU/eawJ68AzAxDOB3QhK4Tv/zvFkPBwv+XHnKr0lRp0929tdPXQZUDqPpTk3GS9gjmv583ryRiKhOT8HddeOrWGbVJuyLNEyejTYxMD2L1tkzEw8eDPw0DVrIQghWDJL5W6IIxaTFZ/p/qLbXrg/evqNpeMMdtomCEY7jS8T08Vf1f+O7qUkojIbOtssHuBV2Df/PuNKFdeV21ksE9VAv/oU6sEIHlbi637R+NP89DgNIapC2b03PXMYImtnAziZ17X10hmAPuLXKwwy11wQEsYwmS9SBBDn7kkHs+MPfuJ2iyncSugtLIY0YGwvj0DnuZ9CkQ34O5wUHS6P3IAGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZK2viYlOMz7DiVwGEDNqFdhwqtbL/TD7wUyGaTS2gA=;
 b=ZEuwWq+XwNbnFDC5kc3afRG5SIISaAk9TFtXb9QM0cnUfAtqXVJBLmUpAfQBt4Ys46HWTaUoIjRWK8xHSJXVkpkILpWBDmIAyp7DHs+BV58fLGW7X3OcRlxpSVxlqfxSwBf+XhRpfTEQ5kSegYjsKHmuh5DJ+oIglSuKdot1ANBZAmUlb2V2eLMvGYrBGm/0XZh1C01GepPv4OLnkdN088vmSwGDeD1gvY3tDP7GpPZunXypJrwur1mpLrTpqti5nXBjEaQPO78vKg4Jxowqi3jZml2eiOSWp4dvNIDN9rCLBV8Xc7poAo7p2rB2ZglzIdL/p/lhkmgDewmVyIN2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZK2viYlOMz7DiVwGEDNqFdhwqtbL/TD7wUyGaTS2gA=;
 b=rZgcC+PUVFgZ/kGmIZ4skd5oWoDtxncU8jmkqscItm10kBE4Ja2xC6OMMhKqdFyvUUkxF9YcqRi52fDs5KQXeBgfo+wQ1hM2aMSTComOZGu9jvq3OQI8qN39O5o/pcVArP0y0z2tQc7kB/A1t9QX0zOoTT7s5GpvwdG2GG86kE0=
Received: from BN9PR03CA0510.namprd03.prod.outlook.com (2603:10b6:408:130::35)
 by SA0PR12MB7478.namprd12.prod.outlook.com (2603:10b6:806:24b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Wed, 12 Jul
 2023 12:21:15 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::f9) by BN9PR03CA0510.outlook.office365.com
 (2603:10b6:408:130::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 12:21:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 12:21:15 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 07:20:53 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
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
Subject: [PATCH v2 1/2] dt-bindings: can: xilinx_can: Add reset description
Date:   Wed, 12 Jul 2023 14:20:45 +0200
Message-ID: <bfaed896cc51af02fe5f290675313ab4dcab0d33.1689164442.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1689164442.git.michal.simek@amd.com>
References: <cover.1689164442.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=890; i=michal.simek@amd.com; h=from:subject:message-id; bh=VhYAd1TqpHiv1k38ZgdGS3bzP4ZxBzUrP3KJHJ1fWHk=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpR1s+ZoC19rPaGjeWXN1LcOHnqcDHM2nk28YHVVYP3bA n1j+/D2jlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjARz1aGecYXp/dInq7ru/39 SufF3+r6P59HrWOYX9zyqph9USmPZd3iFa6bKkv//Z92CwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT021:EE_|SA0PR12MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b8fb459-e16a-486d-a737-08db82d27ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +184hJj2nrI7IoUIw+mYei3v17AGmFZ9f+Y1NqVaNxUOtlsP9Ng2yqkB6sUX1qQPWTWHO2sXt+p2sb1mvNO0Z3B2LnNER0O7RjE1TnTCPa4RqMA3pPRcHBEUvCGyR19owKImL9ZxzbLsflLaQIwEwLirz9waahKtkBrMcDOBC6dWr+lNwIpnlMjsypIYqJzjJeEppFWtay/7eArQq9pcpiMvCZ9/VW8VQj1kPhoQI5dX9ysKbj8rhXsHSChnVPhlb2uk5+6xXH4evefnVIYN2K2rphhK5N7z9SHlcA1cTHxHs1QTF3QR5MVMvTQixxF5m/w+W6kJlSgwkL3SnADaywiZroUl0sU8TB74HjhGjqyZEui0heDtTTT7bAGQhfCqwtoyklsq8gmO55gYwO7wzjMecFZlMP/ytQSfOR6rwYOQe4eNnc2gDEQvstY00KTMQHq3X8WxFudHT5q4BvY9zYyjCLjX5i0mByaRs7mlKbv0k71oehm+fvCXM6IOl8GZDcNmgQeedzUrsMf9E3Hx3Cu2YxEFHwER3TErMLD5L0+3b9sr1nXUEcenqq846B3aAc0Padwd1FIpM+o4jh6sv2g/vR8SFPMQXUyYlo3w81s0R2IaHqpRKbbLbTqJyrbeIMbxyoGtkOa8nl8khrNfeSdwdWbIrNu+eZf5cd0nkCHL2TE8CiDCjyJRWVAHScAS0J8cWWkTYWF28edWXK6aY24MokgfNdd+q/fiGyKLuE4qwUrsWVGwLRSj58xGXbmG1LoqENoE7VNCtobEz2hksXJnBDTr4dtmEit0CjExKwY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(26005)(82740400003)(356005)(81166007)(336012)(16526019)(2616005)(83380400001)(47076005)(40480700001)(186003)(426003)(40460700003)(36860700001)(7416002)(2906002)(4744005)(44832011)(5660300002)(8676002)(8936002)(36756003)(70206006)(6666004)(478600001)(4326008)(70586007)(54906003)(110136005)(316002)(86362001)(41300700001)(82310400005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 12:21:15.2953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8fb459-e16a-486d-a737-08db82d27ce8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7478
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IP core has input for reset signal which can be connected that's why
describe optional reset property.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---

Changes in v2:
- Add Conor's ACK

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

