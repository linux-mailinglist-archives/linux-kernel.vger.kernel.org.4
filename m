Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7823B600E73
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiJQMBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiJQMBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:01:35 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8BD95BF;
        Mon, 17 Oct 2022 05:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dm3382lfl0Ap71nybvNx9a++MpjrjeDqaYpsewjvL/ZEi2jHh0Iib0FPsB34IzNYt3SCGJrpBHJ0EGgh7v2k6+RyhzZNV24vfaW7ihZ1Ze04YfRQzJoxZiBtnhJAWYyNRGURVS61u7Ua98aQF3S4ElWwXOQPDCVqOTjvQFOmIvg5G+1SUn/VKUQ8kMEfejn0QXV9dnX/t/3pAA60T2xMacxHbkAFJpaJyha7pumtMY7DrL4gqEIZ1YAMCaz05GTfgAX0PsIO5Atz2fzVPglL7yefd2exSGMs8au7OVieiObfu0dkzmiPvwPRDXy9iDyrofztCRurEq1lQsnLZqyGag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXyi38GmDsjYCDWYgL0HGT0+QMDi6MLggAkwmRwSPic=;
 b=j5uCXTL5usdOdmOH1cTMXYTUA33VrNDHaULIvE8wzgCFtqGaQvo+tYsdb3k0xhbi0kdyVs6RQOcY79T3ndwNhqn4d7panXHsu4cWQKQT/fGvYeUMU6soBmV8jVB6sN2VOatpfJ3K40hI9ilqAYY+BEM/L15o1kkIWB1JDel76zjpE4uK8kimQZ94vDvbHpHOQYIHdR/OcypPDhw/yciybT74IikS50VzKCyve1GQlu0bHOquZmAJ5jZh9hhxSpVt5YB4MJc3woqi+vwk6CG5Cj8ECgfn0VCulTNp56cmwh8wO+CtiCnYCBfjhARft+OYfnRNed5o7tTTVF3V2Ut0tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXyi38GmDsjYCDWYgL0HGT0+QMDi6MLggAkwmRwSPic=;
 b=TQbBZi/gT69e8nrYb9QX2BApbZimuRMKoTuhgmYI/g/KpjIw6YMoDB4fGq/+JhIOJGLm8jYMeBVn4udxQC3sNHbpPvCYXprG3eAdq0lQ24JwDo0jvUyAXo6OcpjxfObUbZ3omEZEfP3YdC6Yq13g6+P0kNIoy6QtYZWVhJ0M9Us=
Received: from DM6PR07CA0117.namprd07.prod.outlook.com (2603:10b6:5:330::32)
 by DM6PR12MB4514.namprd12.prod.outlook.com (2603:10b6:5:2a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 17 Oct
 2022 12:01:31 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::46) by DM6PR07CA0117.outlook.office365.com
 (2603:10b6:5:330::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Mon, 17 Oct 2022 12:01:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 12:01:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 07:01:30 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Mon, 17 Oct 2022 07:01:28 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <saikrishna12468@gmail.com>, <git@amd.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH 2/2] Revert "dt-bindings: pinctrl-zynqmp: Add output-enable configuration"
Date:   Mon, 17 Oct 2022 17:31:00 +0530
Message-ID: <20221017120100.21549-3-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221017120100.21549-1-sai.krishna.potthuri@amd.com>
References: <20221017120100.21549-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT042:EE_|DM6PR12MB4514:EE_
X-MS-Office365-Filtering-Correlation-Id: 2094b5a7-fab3-4ea7-67b1-08dab03754ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q+3oHppZzXiuIFdD2On9XejyqSftkJvNy6+2IAR7lnJ/JrggF2O3MAt3226WmEZZlOJX9haTswK3yGsXWeAMHMlZ5T0AdpuxtQgf1YCdGNKYh529XYGvMbp5miye2o/v3+ts/wbQSptoXVudLfei9p9pZof67Ko2TQ8PDh+GwXkYVsfxB4qBDAMv5V5DLCCPTifVGOvOOlQcWt+eDB23LWwEMZhmBdtNxdUI2qQ6DHAV5s7zQN+hn3GAQYeHi6M2ujrC8yxYJsa1vRE/llagMNsRdSl5VGPknhZLRpocVECKVMSy45pmTJdsprJrRY5v3FcpNl/INBAGcZg3rYgwNdBfFfk4UG3SJdTV/4g3GW8Agv2nJfH0nV/03S767YQ4gpiHhQc8FkJrRd0vHOb85hV+aSaE7hykk6yavsCIkH6qnbnMrRAQ4g9TZaeQ60PBtNNRyMrmaEhW4b9iasrQAxQGabNq+VyuBWntO8J3UGBicPAaSO8oejDCYyDe8OJY1oZVbXSM34jrfHmvEHaFyO6H7NmPOzzs/l0l+p9HZ1Q6j8jDcwV1HM3h3/GEOp+iYFc2EcXPMW/HaRYkelVo8ZmNK/5QEGgd0T9yE8ese0dyQieCFDXqtMg3Xfp30gN01Ik6JVv1ZEDxUAoSAp8vbUqwYm2pYIDmFuCZfmh1NFEn3Hm7jfGu9sh9SwvwIGKSliWmKBkgoXTFIBZpdLJzD9bH5aUebR2ZRuxukox5SFR3S7SPOXmIenjPgzPHAJQYYUjmczzMwPTCVEGmAzVczP4s0aGEk5RoLVS3rKex3/pivA5JifaX7hyEfPZY3rmq
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(110136005)(4326008)(6666004)(54906003)(316002)(478600001)(70586007)(70206006)(2616005)(8676002)(336012)(1076003)(5660300002)(2906002)(186003)(41300700001)(8936002)(82740400003)(36756003)(356005)(81166007)(82310400005)(26005)(47076005)(426003)(83380400001)(36860700001)(40480700001)(40460700003)(86362001)(103116003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 12:01:31.7806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2094b5a7-fab3-4ea7-67b1-08dab03754ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4514
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 133ad0d9af99bdca90705dadd8d31c20bfc9919f.

On systems with older PMUFW (Xilinx ZynqMP Platform Management Firmware)
using these pinctrl properties can cause system hang because there is
missing feature autodetection.
When this feature is implemented, support for these two properties should
bring back.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 .../devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml      | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
index 1e2b9b627b12..2722dc7bb03d 100644
--- a/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
@@ -274,10 +274,6 @@ patternProperties:
           slew-rate:
             enum: [0, 1]
 
-          output-enable:
-            description:
-              This will internally disable the tri-state for MIO pins.
-
           drive-strength:
             description:
               Selects the drive strength for MIO pins, in mA.
-- 
2.17.1

