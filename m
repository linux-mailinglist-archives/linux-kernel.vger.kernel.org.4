Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EF873541F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjFSKwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbjFSKv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:51:58 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233471BC8;
        Mon, 19 Jun 2023 03:50:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6PY4OmLeW8V0EyojS6pgk45c60A2y3DRtjYsbt9gyIuCzGOkClPBg/JN6Fw7I2p7yZ0X26xdxMYgHIwbROsZz6EUGEzxZtIbzfvFR9KwuuuFa8gFgqjMUDhOtSzOOh8ismuqogD02Rdaj83X2eeux3n8SWEp0Q1gdpF70D7/h5ncj/YoLt4tvPwAF8y/F0TyizD415kO6YW8mjBpt8TsaKjbznOZzBnSg2X7CRuowsJVBA1O0+rJ8C0e8XCxBDTf7Y6M1WeoOefqvbFkCAIZZtUc9PafVs3VjrMywKPgZrqSY//aF3O2DMPJHS+x6hGDvWzcenA/GpLzKE+eAFN/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29dLV5yQKdLOW9UG3t6z5YKrt+YFp2o45dGtjr7F66o=;
 b=d8bLiZ8fZRfDsRsfy+67Sx7VOBiTPakBbvCuAJnH5f2JOQJiExFjn/YkgFPJCqZc3Es0+MYOVQUzeSNd6FBDcuexb7gQH3GosvUOZ6ucFVuMr9D/96j9AIBL14yCL3Tf8tiPnrSSVPFQtqVgWkOBLz8toAY+OYvlBeQ50AgXMS2gUmQDikXwG+T0DmAbn2dnsZApveldpqlb5vjm0+JacwXIbMDX87fG2Cztz1Ff2xiVL4+QFz4X9iAgPpVnU3wcHtms9Focn40w+vjTrrZkwjjx2A4ldK0siLlNBirUGUwofu63Rvo4LaXdjoFZVHq0t6mDQhjMIqsofKKwAqSLxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29dLV5yQKdLOW9UG3t6z5YKrt+YFp2o45dGtjr7F66o=;
 b=CSMc//yEoT7JDgINPScst5yxJ9Ay1mcvdH3mUyazITNkjuq7lFde/a97MhRut6jx/IFPbsQGTzCAU1iJ7ETYQpAThIvh7S/psT0mHF/xAAfmRUKc6hfftZDVDQGPnXO7jvaEMlFffpKNv+d1LuGaz9vbm4CkTxakV0lsARA2rKA=
Received: from CY8PR11CA0006.namprd11.prod.outlook.com (2603:10b6:930:48::10)
 by SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 10:50:54 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:48:cafe::65) by CY8PR11CA0006.outlook.office365.com
 (2603:10b6:930:48::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Mon, 19 Jun 2023 10:50:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Mon, 19 Jun 2023 10:50:53 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 05:50:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 19 Jun
 2023 03:50:44 -0700
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 19 Jun 2023 05:50:42 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <balbi@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
        <git@amd.com>, Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH V4] dt-bindings: usb: dwc3: Add interrupt-names property support for wakeup interrupt
Date:   Mon, 19 Jun 2023 16:20:32 +0530
Message-ID: <20230619105032.2888128-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c56cc0-6cd3-4a3b-54bc-08db70b30e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UQsqwuZVhlSTZlcb80caOvOIEIJ4sFsqeRawr54JCgHyPMujM0A/8lCf0Z3u+/Ks9K5h7DKEpZTGK0hB5MkNl2joPhC08syq0t920MbpvAEmiXX+AKC+gq8HZ14Qt3GpOF/oShaSLEocusnoa8ZAGIsN/GdGNBlEQ4R6Ba08+lIJvyfRkfzmtbfEULISQTs0lPqMhjkJx5xgP9Q1NafJ4tj45HlRWva0FrJYSMnBSV2IQXcub0KhCJ3A/eRpjLMaIJfn56jNa0iurHbYi9GZ3LmVsM6kf/Mi3c/F5zDw9W58ilvCo5tJoDf3OPmqa/vYg7h037JSx+MZDMyB6q3HVdTDuAZy5ObzvTNOvNZnq2gnwctDdecGmeVdmyJkxdoGA/6L/++lZtvWGN+nsBxlamPfPPQLWcLN0vygGBAUFjQDjoOdePfHdvPSakXR8c0ENRAuVXzBh2VH3FjMiDrZRaD939aVARubdnLfJnhNG9hg5FCBheOa2aLHOcwgd19bpr6EKvckdgxrGaAMpHjVpL/Z+yBENloIQ58aPRwKWVr3vkdvhNLwhNg102Ag4hOi1fUOYBIonjy+elwWpHaKjRFUY0K7YFCWRW3OGSVnvw9PSYvro+8X0Wb0ntCLE8Gv/Z+w/DUzG3lmUlkJhKgFwWcgEsKlVPgA9/wDDvXwklWqvxBI0r5Wld0UmwRy5528xwjZZTRzYAHNrlZYeLYgq0yMTcpVdW22ApYfdKaseHfCPVfboARjg7636VZK9XRdhjVP/t4n3nrHdKBI5lufb2Oib3of0D+TTM2iKaea+xI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(4326008)(54906003)(478600001)(110136005)(1076003)(40460700003)(26005)(186003)(966005)(40480700001)(6666004)(36756003)(2906002)(8676002)(8936002)(41300700001)(70206006)(70586007)(316002)(5660300002)(44832011)(82310400005)(83380400001)(47076005)(86362001)(426003)(336012)(81166007)(356005)(2616005)(36860700001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 10:50:53.9633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c56cc0-6cd3-4a3b-54bc-08db70b30e14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hibernation feature enabled for Xilinx Versal NET SoC in DWC3 IP.
As the DWC3 IP supports the hibernation feature, to handle the wakeup
or hibernation interrupt, add host mode "wakeup" interrupt-names
optional property in the binding schema to capture remote-wakeup and
connect/ disconnect event in the hibernation state and increased maxItems
to 4 for the interrupts and interrupt-names property.

We have a dedicated IRQ line specifically for the hibernation feature.
When the "wakeup" IRQ line is triggered, it initiates a hibernation
interrupt, causing the system to wake up from the hibernation state.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
Change in V2:
- Addressed ROB review comments
 - Updated name of interrupt-names property with "wakeup"
 - Move interrupt-names property from dwc3-xilinx core to dwc3 core.

Link: https://lore.kernel.org/all/CAL_JsqK6_7XD7+w+EQvPPmbmSOpfo3JDb0xDN4StuHUm1kgchw@mail.gmail.com/

Change in V3:
-  Addressed Krzysztof Kozlowski comments
 - Update binding schema enum.
 - Upadet commit message.

Link: https://lore.kernel.org/all/76dfbf27-8ad2-6e09-5354-b006b9e81af1@linaro.org/

Change in V4:
- Addressed ROB review comments:
 - Fixed dt_check warnings

Link: https://lore.kernel.org/lkml/168448091422.2968830.10066003697035225886.robh@kernel.org/
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 4f7625955ccc..a696f23730d3 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -44,15 +44,15 @@ properties:
       It's either a single common DWC3 interrupt (dwc_usb3) or individual
       interrupts for the host, gadget and DRD modes.
     minItems: 1
-    maxItems: 3
+    maxItems: 4
 
   interrupt-names:
     minItems: 1
-    maxItems: 3
+    maxItems: 4
     oneOf:
       - const: dwc_usb3
       - items:
-          enum: [host, peripheral, otg]
+          enum: [host, peripheral, otg, wakeup]
 
   clocks:
     description:
-- 
2.25.1

