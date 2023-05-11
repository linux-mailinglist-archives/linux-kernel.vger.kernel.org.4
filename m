Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB5D6FECB0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbjEKHX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbjEKHXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:23:02 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on20618.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::618])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A82D65B9;
        Thu, 11 May 2023 00:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPQhF6KxSm0j9BoBtjVstSRGw27BmgsXfAM/xu2xuIyG+IjONHevHDnJCOeGJqZS2CkXclWfogDxGdQKUOpJmoE+WQtbSjz3pPm2nmI4TkCmDhG4GE/XzMNUnuRw7TaLGS/uF5brCrEhfK9hTSsHPc0mG8Ug0XFhz4JIhCSJJESNXmnZzy62JwkRHwhwPaMcEY6k/Wa0fyX0tbpfE1SZHzTvyTYSUFKHNUosn3yoLIROIegbulvYuWSoQC8kDYGwV5cUiefWy/mdReHL/DZdkGYY9AwvAlBRnmG9xY9CUhvukIB/HV9SUgwJQMLGwDUHt/ucTr/oGdtSyuPXcBTPtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVl2x1FXQ1jFFMO4lDmqHk2FSQaKo+vqoiDwJHlZGDo=;
 b=M0FcQ3zlATPClQ6FMrbqVkCLiXaeNNwZL5Ppr+oQc5H+nZeanhunWjjzFmxlGPSNvRSPql80W3yOuxtfuFDRMXorkkmPEcqchzYu88T+hNI4id7s4XbSpwi1GioTayCJa3UD4Pue1PNWUncF2leB3Wlw5DJXu1umKhPxg2GKd4B8cb0Rx3xdMxKNcUYNaP/7tvzh+o+GTQ0mHbDUN0p9hhGurCnQUtdHbyJrWygdP3KCAy94xi5lqgKQoN6ST994T3kPcEAl7WT1XiOsMPIlolk8Jj3S3xeaharT4q7lwG9Li4wOZAcofjYiTvF4DKXdqYwIvXDpizo+mtLv8Qlphg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVl2x1FXQ1jFFMO4lDmqHk2FSQaKo+vqoiDwJHlZGDo=;
 b=r7fuigB1oUdKsqMeCEuIb7L7dFJOarDMX2PxqU/56RDc7hK4eOsa/I5rXxZ9H2YQr+KQ1qdOv8vG3FazFiNgZk4vZLycNGvnCfFRu7hYGFh45jVlvGmpRM1cVgwID+rd5uM6vRzzw1bMyhxJfHDNL1BryDsqE69y0P2FTSJ5RWk=
Received: from MW4PR03CA0305.namprd03.prod.outlook.com (2603:10b6:303:dd::10)
 by DS7PR12MB5719.namprd12.prod.outlook.com (2603:10b6:8:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Thu, 11 May
 2023 07:22:23 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::e4) by MW4PR03CA0305.outlook.office365.com
 (2603:10b6:303:dd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21 via Frontend
 Transport; Thu, 11 May 2023 07:22:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Thu, 11 May 2023 07:22:23 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 11 May
 2023 02:22:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 11 May
 2023 02:22:19 -0500
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 11 May 2023 02:22:16 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <balbi@kernel.org>, <michal.simek@xilinx.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
        <siva.durga.prasad.paladugu@amd.com>, <git@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH V2] dt-bindings: usb: dwc3: Add interrupt-names property support for wakeup interrupt
Date:   Thu, 11 May 2023 12:51:54 +0530
Message-ID: <20230511072154.2030703-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|DS7PR12MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: 076ff5ca-6736-4c22-8321-08db51f07714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DyRFuNBClnQihRZv+LvGqoQMIyhE6hWwfQ9xgs54CaOUKhLsh7/veSfBNTI+6VqMDhNI/kFycMF/uaCeZLMpnFBjpU7W0CZJey89Zo5g9aCH6/YG+XOR/1c+3LcsoB90qRxDBoUz0Q3cUMnFOL9TPvNMH6ECH0gBRwnIkJxUH4tmvybh3m+GeMgCmgoC6UrfVlvWV3c/qI9IYXi3car1Q9xDX5Ca8LGh+V/JxTgpHI31TFoNR8MUo1MlxQFrNF22vHWPVXyubRtFsPotcya8QLKomqgjdtmj0CaLkLQ82BlV1lsrH7PQB+7cacvvZLq9WIfkSO3YohBahY6CZ9+Tob/g4nclf/hd7y0R6lWW6HvUQoiDyEvgJ/7FzMuq4bxEARX1Q2H7lr2mYjtfc1zQ8cKGZtifVDgL9OIg/4zAwc9rCYxQtZUiyIbUBZh7db4avHeDVXPv//XMqaZsIqksza8V4sXMtIsLdLyDm88z81w2/JinWW+FShh1p3Xwqglao91XYcgTJ8/+FgFFb60yWCADG8RwvanesZ+5u9XGEjd8rtNwaHFoz0J3ZXSyRxw1MMjEl4DVqmVZv0gwPWZJX1bmprLi5u8VluJu+r80m8XMK5QLGk/QhkRKXX73ZEvgKlc9tXaL8r4ILjZi56ShFCU55UPIzRRAB43XzpALbNTgZZL8TWWVJ6771mAIYfMUGuH5ipnrb330dQPVJs8avMiA1WkL3ZYECeNQTlIXypil3W9GRk1LZYzDArdfSIUW6QnE0vcpT1uYqunwttBKbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(8936002)(41300700001)(8676002)(478600001)(316002)(44832011)(70586007)(70206006)(5660300002)(54906003)(110136005)(356005)(86362001)(82740400003)(81166007)(36756003)(2616005)(36860700001)(40480700001)(26005)(1076003)(966005)(186003)(6666004)(4326008)(83380400001)(47076005)(336012)(40460700003)(426003)(2906002)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 07:22:23.3484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 076ff5ca-6736-4c22-8321-08db51f07714
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5719
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hibernation feature enabled for Xilinx Versal NET SoC in DWC3 IP.
As the DWC3 IP supports the hibernation feature, to handle the wakeup
or hibernation interrupt, add host mode "wakeup" interrupt-names
optional property in the binding schema to capture remote-wakeup and
connect/ disconnect event in the hibernation state.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
Change in V2:
-  Addressed ROB review comments
 - Updated name of interrupt-names property with "wakeup"
 - Move interrupt-names property from dwc3-xilinx core to dwc3 core.

Link: https://lore.kernel.org/all/CAL_JsqK6_7XD7+w+EQvPPmbmSOpfo3JDb0xDN4StuHUm1kgchw@mail.gmail.com/
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 50edc4da780e..db512769bd80 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -53,6 +53,8 @@ properties:
       - const: dwc_usb3
       - items:
           enum: [host, peripheral, otg]
+      - items:
+          enum: [dwc_usb3, otg, wakeup]
 
   clocks:
     description:
-- 
2.25.1

