Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA2670D68C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbjEWICo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbjEWICk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:02:40 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20626.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D015EE0;
        Tue, 23 May 2023 01:02:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9me87FJajo6IXHn20ZCWm1uUwznr5jbROCFFnaJHM0VDN/bagrae5iSw6MCl9sAfcWNlIlKz108gCMrrjXrNrlrQMT1InnvHh1vDpKwVuZFAwSpVwyuqUKfHEQ8HIUl0HIBiF8O69crhqb9JMkrJFBUcIsQtMjHxQN04n89PaA82sRl+1kjZbv+2x4RCqV3giWRCUmw2BGJTq/2vcT58sOL/PuCiwDI8Dmvm4bFbiVsHgmQKx7d/UBEffmMmhmB0jvcQktakvw90G15KFaxsNdk2RXDN1XIo9WnDC/oK3Qg+JCXJc5SDbBe5FPOuueP6bU0iQBsK0J6J6QBsusENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eo81fJmZHsRTyBsEaiVSv7dKeEvtvRcI+ad07KxRIv0=;
 b=QpRPxF5pMfT5qSoqAYyt6+vd5Kag21Qk8uQwJ3WQEo+t269LvjoKjq47yaJ6ybFvgxhhfrO9djX4OE+xZI3Tvy6x/i8WtpZKvFSnHAp4QvR2h2nbvKRN/OVm9A17M/nuId705Wq2N20IVPgxFV8AAKNcoO67OFydli0XayMTXNtf4D3QwXC5SkIJmAY0RRThY4pdQYVS7iAi9JnMeHmZjY6McdfI+wT/8Q2PDET9pV+7+XFIyHoogvyR9YtmMeQlqhxqA14sT84WDiPsJ6JxPV6EsI/avAQkz85CfNHCnMlSv7bfd6tgwSag6ST8XwkdfyTbjGWRA1CArBc4GZ5jhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eo81fJmZHsRTyBsEaiVSv7dKeEvtvRcI+ad07KxRIv0=;
 b=GguUpuf3cniU+by0LzRzZko97+XWx2SrkPVIk2ICNchYkgmtPwC6MgfTCxQ4s/Wju9y9VHxS999i57lloSSnMdOVlWk+eYnUtsW1rmBXqWIzmpq+vvHNb64Rp5558CmEr1tgZFcf+w4XNmMXF+pVhF/OEkA9P/QTTk1jkiilahU=
Received: from MW4PR03CA0020.namprd03.prod.outlook.com (2603:10b6:303:8f::25)
 by DM4PR12MB5359.namprd12.prod.outlook.com (2603:10b6:5:39e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 08:00:18 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::e6) by MW4PR03CA0020.outlook.office365.com
 (2603:10b6:303:8f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Tue, 23 May 2023 08:00:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.29 via Frontend Transport; Tue, 23 May 2023 08:00:18 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 03:00:11 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>, <piyush.mehta@amd.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH] dt-bindings: usb: xilinx: Replace Manish by Piyush
Date:   Tue, 23 May 2023 10:00:09 +0200
Message-ID: <504444f5c2f4e725ac39cba1d72032d5a00c7cda.1684828805.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1474; i=michal.simek@amd.com; h=from:subject:message-id; bh=4FKBf7ilNnfh7qAml97Il1ZrBm/4wjR0cwmNGKOvuRo=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpScorZL/IGeSieLTR79/fy78sZZ5hPCvHcidnWFJ56ut nPpEJ/REcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACYyuZZhwczK/hMXajnsDN5w JWVMVPh7LGqRLMP81ChXruZND/MKPm6YMfvyGwmtNJFqAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|DM4PR12MB5359:EE_
X-MS-Office365-Filtering-Correlation-Id: dec79204-c682-46eb-685e-08db5b63c010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VmLxZWooxuNXvkRNCH883DwkPxBdJPrr8BP8Q923GZ8rd5Ug2oB+08Ur7j2d+/P394pEtSZ1+gDKnT1iOQitgxxQZhHMyVAcH/dz8C9oZfdjS20W6wQ9EECnC81oFS8UbcYI2rXxL4bbFo6gISsJx/llUWjaFJBg/YHu3ormYVJjskArqYf/Q0SoWEWdjpUlS+LEJJ1nyc0eGHE5cuq7NqA0lU2ZgAZLQ5LpCGp2uc/FTdHThkMsLAQD1zQMWeOmdUGyUss14fSV4vPetbMTXi8AI6bmC8jE624u0/udSiAX0rw+yzHNyLRat7OTl29EjvcHRM/FCEIexBJQU6nwdlGQ36HEUNxqS2KSomzjVMZTYAUitftb4SkJjnOd23gGfwAeHmU0wNaa9tUUd/Y7pZ+PUYR/ahbnMLLP9NeRBwdy9BLZWIl/6aMzfddoCiEkexbFe9QV7VYIghdOsUm0bBNdCYKSCmWVFAqx5USvyF0MkE1RYx1yUep39cOXY/iXkIV8G41UYRfYyWfR6tpcE4ub09lKwBXT3dOWwdWgDfY9EYUGScLMePagrIW/jlWApR9NhQaCybtTRcunR9cPpN6ckpigNxu8d0Es+1mhccuX8vRWidmGR3uKcmYcZXw31vrmR8GznIGqadZo8M1OAxu63+GPJnS+xewJyoSsceDlLpSu08h5NSezapveODqRau/w8lzG6Eudqug27yaiEAtMPQVe+hPbSuZ9FSyKp7ywQw2NlXv6V/yGNyN0qa5IyxlUaeLBuUx/YKNC8LApDo5Z+VwbMjmziRhKLKHA37c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(54906003)(966005)(41300700001)(478600001)(82310400005)(110136005)(316002)(4326008)(6636002)(70586007)(70206006)(86362001)(5660300002)(8936002)(8676002)(40460700003)(44832011)(81166007)(356005)(26005)(7416002)(82740400003)(16526019)(186003)(2906002)(83380400001)(40480700001)(336012)(426003)(2616005)(36756003)(36860700001)(47076005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 08:00:18.3841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dec79204-c682-46eb-685e-08db5b63c010
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5359
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manish no longer works for AMD/Xilinx and there is also no activity from
him. That's why proposing Piyush as the best candidate instead.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml | 2 +-
 Documentation/devicetree/bindings/usb/xlnx,usb2.yaml   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
index 098b73134a1b..bb373eb025a5 100644
--- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Xilinx SuperSpeed DWC3 USB SoC controller
 
 maintainers:
-  - Manish Narani <manish.narani@xilinx.com>
+  - Piyush Mehta <piyush.mehta@amd.com>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/usb/xlnx,usb2.yaml b/Documentation/devicetree/bindings/usb/xlnx,usb2.yaml
index 04c123c7252a..868dffe314bc 100644
--- a/Documentation/devicetree/bindings/usb/xlnx,usb2.yaml
+++ b/Documentation/devicetree/bindings/usb/xlnx,usb2.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Xilinx udc controller
 
 maintainers:
-  - Manish Narani <manish.narani@xilinx.com>
+  - Piyush Mehta <piyush.mehta@amd.com>
 
 properties:
   compatible:
-- 
2.36.1

