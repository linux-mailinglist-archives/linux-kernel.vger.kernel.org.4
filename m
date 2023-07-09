Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C51E74C6AA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 19:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjGIR0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 13:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjGIR0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 13:26:09 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FB1C7;
        Sun,  9 Jul 2023 10:26:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7xvz7nVywLEF9FOqLveNCPazN4KiNCjELb7Vr3II4ddvNTuUn6yqAEsC+BYYNCnn+p2QmwR13EYb+V1vl9nRYrq0MxHSwI/yabwJlUmqERMi3Bm0IezLgNGn02TdL9cMjf/oOJJF/CgXZ0NqBXdEHcMynI5nWBuMO/y2+tJGDVCbREBfhMNluLmzo3vfaNHgpFfn8bUhqoj3gufrckL+bg7hLAPkKDEBIC+XTL3vFWNLQgFXDdru4bkOrgFVcPj/v4yHTXxbWSPa5kLvAqTRppqQ3NNNF25lSz5aitPmK+QyOPutQ2fEsZdAbm+swGvODpaUwpP5w3VEy0khfX3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8Wal3xpzGdXapR+dAQG6U/muAsewt3kJyhUYln8XHI=;
 b=WS+nxSNAfnPGz8G9zG3rvTRRKireLJWAsLDTPB2cKYlk0szV962f7vwnYhWKDFCSvuQ10xmUDLNwRTOTgXXt8mHfC6NJGNofzv2KUV2fnHC+wHaM1LdNLnt26LCiroZkCpzFjOf8dBpvbJICMMyrzvQPP1ZZl3xDLeJdDbucUhypx2pte8MVNYEC6URX7TI3zD57FaxrIgGlEoLVJuAgzIPMnGqdoOc8J66Vw8JOvXto1h64zVPIlPaKYueoTn+Y7kvL8oAY7S8gVY3283h9+toXTs+PaAR0PNiayclENI9GEOrH5tSzXnAdf0fke2jIAqG5Yt88EMSwSSEZrBj/Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8Wal3xpzGdXapR+dAQG6U/muAsewt3kJyhUYln8XHI=;
 b=M4/Whq3X6hw9O04JJqWOP5OUQnJVxn+u1ydJfMoIeToJq8aNAISe/JiwC30kK8XDfGdjC6YIjZY38bCMvW4Ic5zkmRlpTz1FEW+ArYQ09KPxQbK4w88TBGvkRShnYqlGfBMq3S30YLqz1vm9azs+W+PIfajf09mJu/kA4XLvF4M=
Received: from BN0PR04CA0205.namprd04.prod.outlook.com (2603:10b6:408:e9::30)
 by SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 9 Jul
 2023 17:26:02 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::30) by BN0PR04CA0205.outlook.office365.com
 (2603:10b6:408:e9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Sun, 9 Jul 2023 17:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6544.38 via Frontend Transport; Sun, 9 Jul 2023 17:26:02 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 9 Jul
 2023 12:26:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 9 Jul
 2023 10:26:01 -0700
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Sun, 9 Jul 2023 12:25:57 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <dlemoal@kernel.org>,
        <michal.simek@amd.com>, <broonie@kernel.org>,
        <sebastian.reichel@collabora.com>, <wsa@kernel.org>,
        <nava.kishore.manne@amd.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH] dt-bindings: firmware: add reset-controller property
Date:   Sun, 9 Jul 2023 22:55:42 +0530
Message-ID: <20230709172542.1393828-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|SN7PR12MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: f94fad97-c55b-4b3b-de82-08db80a19184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JVDzVzmuXy1pZVCwScT/YbGYY4dnSnksigCu0ND2++7BZSlLFgrn3ZnrTgsnC4MwetjDrujkU9nwTkKVjqicDv264jeAAZ87FRirUIkS6ccAnEyuZ7/0HinaiNwA+QhOo7mETOR7zevzNpdclNgHlJJiASazjo/YeIV7Ax9govm6RrVoxgt+wli40v/SHunFDyv37KHC/A41mDjjsHyTocepA8FE4tfIp34k07v6ihTbAP+ekEY+m6raHeYKYmZx8pxxtRYjcenngwoUmNEXDop8eUHgiH2VcCLVd0uBHoiyAKwIa+eDfALDC9Xf8SwOA7MsP1wAIXOdL7msQ0P9lVK9OcG6n2nu3dCmHEsH1TTgXuIPRwJwgf2bKMzvwbYUIqJxzU2WGz/eDQTyqrZOvQGkI0GRqETGxfydEmakzrDhufO+PcJni1QSmB9fX5S/AeXY9N4W6bk6G+wiBtOikHGAClppCu+JtyN1TDYI/FtQGxdNWSV1oXthFiVgeIJgeIXGimrSWKs2FMK/NBF3mjf4nz5pKE53qBd5uoxfalbBrTogiYenF+wFYUQSET+9/0cuU4JzglhH82k6a1jo+VtavVMwpZIjLG7AHL5eIUJ8Mfwq+XPyJwu8kXWYqQZKEetX/UAdQKPRmnLyXDsY4SGz+kdXclhcNXrfGII9xR9HbjQvq74ojpT5Ct3/bx9ZlJwrzZXKTZKAoCbaDmWfsjVgmmkIWz05yH6z+ZFy9fVwhwS/UqSjyCWbtmqDPryA+r0ByJingaMTh75sMpIG9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(40470700004)(36840700001)(46966006)(44832011)(5660300002)(7416002)(2906002)(1076003)(86362001)(26005)(186003)(6666004)(82310400005)(4326008)(336012)(83380400001)(426003)(36756003)(478600001)(70206006)(2616005)(316002)(110136005)(8676002)(54906003)(6636002)(8936002)(70586007)(41300700001)(40460700003)(36860700001)(47076005)(81166007)(40480700001)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2023 17:26:02.2238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f94fad97-c55b-4b3b-de82-08db80a19184
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6839
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reset controller is responsible for managing both device-level resets
and individual PMC (Power Management Controller) block resets.

To facilitate this functionality reset-controller property is added to the
firmware device tree binding.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml         | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
index 910bebe6cfa8..c3a7a5a61d02 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
@@ -59,6 +59,12 @@ properties:
       controller.
     type: object
 
+  reset-controller:
+    $ref: /schemas/reset/xlnx,zynqmp-reset.yaml#
+    description: The reset-controller has the ability to reset lines connected
+      to different blocks and peripherals in the SoC.
+    type: object
+
 required:
   - compatible
 
@@ -84,6 +90,11 @@ examples:
         clocks = <&ref>, <&alt_ref>, <&pl_alt_ref>;
         clock-names = "ref", "alt_ref", "pl_alt_ref";
       };
+
+      zynqmp_reset: reset-controller {
+        compatible = "xlnx,zynqmp-reset";
+        #reset-cells = <1>;
+      };
     };
 
 ...
-- 
2.25.1

