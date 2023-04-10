Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A886C6DCAFE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjDJSqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjDJSqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:46:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946551FEA;
        Mon, 10 Apr 2023 11:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCRqYiEVrRFTGHEaUDljcn5jL40ymQGwLGurDooZD2kuvijdZEnkObVjDfI//qnZLBqJ27YuveXlWfzeUyjbJldsjdwY1s1PMATTv8bvgyaPKeyjtjHHIBotZkOwfyT7AVEH/JLqOWFbR4th+Rv05y+7F6Zew7h2RfGABXxvBZ0SF6p+d8hvCL1l1E5K1Zm4jRWp7a1ZooCuLU3QIVNhnIGHnwtdAfQ05Zt8kmLlfzDBmG+dWSsmFRBeKPgxJE9IZL6XVBiLhZKtctK6P5raxZ07T1CYS11iFZuiwrlhn147t7Ifii3judSYXePTsXUrZnvUi9tOt1XRbmAhEo4+PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKnW45e7WATID2AQ00PmM4L++2zkqYt0EGCGnck4u+o=;
 b=YmdUSjmhXti070dH0y3TAuwcet6YW5zUhKeIC+kXi5yxdpKysLyly3wqmpydgfX1XnonyuLek3e0mKXyzqWZzUhJBTyflnWJ2QRf8p2rQog3A+StEM+q240jh8lVqzYM1sPJbLuibk64LC5kSqbLHJkWKGVVLSRIldojiK1jcMSM+/oMjhAjcIJcXAuITgHRsPTQQ8QKrH95d1bnhIvqnQaLvKzn7cBKUFcd+n7x0sYRXc7ugyrViw9JQHFHSHV1pMV89oOnmFNBK3MuM9If9mmO0SHEZA3731IrgxcblHP1yr/3KUPZBcari8Qo8mBsDaESZ4Y6dohN/tkIsswIUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKnW45e7WATID2AQ00PmM4L++2zkqYt0EGCGnck4u+o=;
 b=SZfwNewaew6eR6dyylZeNyoRBQalZK4OJdotgD434coyj4/Nk6wrY90Wh2feN5qmW3uamyV+aROel9nVivYeab7UR6jRgMPbuoGqf/a4xJTU+kXEf8X7NKfOFLjuT81byJlXF1uD2KfBI3V5kM8Njfzd/eZoJ+5Jde/vQ6FpIkY=
Received: from DS7PR03CA0106.namprd03.prod.outlook.com (2603:10b6:5:3b7::21)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 18:46:32 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::6d) by DS7PR03CA0106.outlook.office365.com
 (2603:10b6:5:3b7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.39 via Frontend
 Transport; Mon, 10 Apr 2023 18:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.27 via Frontend Transport; Mon, 10 Apr 2023 18:46:32 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 10 Apr 2023 13:46:29 -0500
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <brijeshkumar.singh@amd.com>,
        <catalin.marinas@arm.com>, <davidgow@google.com>,
        <gsomlo@gmail.com>, <gerg@linux-m68k.org>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <yamada.masahiro@socionext.com>, <p.zabel@pengutronix.de>,
        <piotrs@cadence.com>, <p.yadav@ti.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v13 05/15] dt-bindings: soc: amd: amd,pensando-elba-ctrl: Add Pensando SoC Controller
Date:   Mon, 10 Apr 2023 11:45:16 -0700
Message-ID: <20230410184526.15990-6-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230410184526.15990-1-blarson@amd.com>
References: <20230410184526.15990-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT052:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: bc221dac-1306-4a5c-db6c-08db39f3e79a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fkZsvLTBxYyc95OgGL+ex1fuc/LVjj2he59UByxjum50nASIQQnybDWgUzCuw2TxQxMwIejEilZz7U7g9Piq076lTKLyOD8PonvaY4AOrvZjOt9TdB1YluX7416703ytXK4+2dV/fcmG8MvGzeg5qCnSRl+wFnccQi4kZhIp658CEWRrhPbgnuK3XvE0xgLJyht+rF6y1GLbsXA66fnqnPIkqCrPY9AFQTFZLbIob5S8oxXs5sOaBZv8UII9QwuzJWRNHiCcYr7nSI5bBvwE+Hsu9DYeUu/EwnuevMsRrohWzCjVZ8J3A0c7xUbV0W2rWD+MisFDLh/mJM7/h9uvzvYJs3/bM9JQyU8TRfCTWo1h68PAsHcmrNEpv+1j8pKJ3oWg1TVf8+RghilJbTBYMpqU/CHWd1O2ahLgvKiZktXSf1OmO1J9YxXwiCN3f2stFcsBThcWltPKXvSj2jIB/FSShL7nbgnxjlyXCC5sZ3HeN6hrsdC9/yhwyfGOKuW3MVzhNN05bCWAELm9c2F1gBybTUrYuiqpYfBIMV0lgFmUHVBL9ARJQNqOqVEl/xbJN3hEHm92kw7+W0VTflQgXoIyJrhweYi+5WTNneJU2J+tP87qe1/rwy5huVdgZ9S3N+1H9kyz4OMpKnOfqEpUARMP0QFeROvN7f7nqTcMbqb9bjSWebXWTHhjNmy8SFNshC+0ud589tuwWUdT7vELjxrl2tSBlmjs2L0+WAwjb0se35bAfmPvc2YstTfbCIvwxv22/ucCT0XyoJfQXc3f6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(5660300002)(356005)(41300700001)(81166007)(478600001)(40480700001)(82310400005)(2616005)(36860700001)(8936002)(8676002)(82740400003)(83380400001)(47076005)(2906002)(426003)(336012)(7416002)(7406005)(186003)(16526019)(40460700003)(1076003)(4326008)(26005)(70206006)(70586007)(6916009)(316002)(54906003)(36756003)(6666004)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 18:46:32.7641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc221dac-1306-4a5c-db6c-08db39f3e79a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support the AMD Pensando Elba SoC Controller which is a SPI connected
device providing a miscellaneous set of essential board control/status
registers.  This device is present in all Pensando SoC based designs.

Signed-off-by: Brad Larson <blarson@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

v11 changes:
- Fixed the compatible which should have stayed as 'amd,pensando-elba-ctrl',
  the commit message, and the filename
- Reference spi-peripheral-props
- Delete spi-max-frequency
- Remove num-cs from example

v10 changes:
- Property renamed to amd,pensando-ctrl
- Driver is renamed and moved to soc/drivers/amd affecting binding
- Delete cs property, driver handles device node creation from parent num-cs
  fixing schema reg error in a different way

v9 changes:
- Instead of four nodes, one per chip-select, a single
  node is used with reset-cells in the parent.
- No MFD API is used anymore in the driver so it made
  sense to move this to drivers/spi.
- This driver is common for all Pensando SoC based designs
  so changed the name to pensando-sr.c to not make it Elba
  SoC specific.
- Added property cs for the chip-select number which is used
  by the driver to create /dev/pensr0.<cs>

---
 .../soc/amd/amd,pensando-elba-ctrl.yaml       | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amd/amd,pensando-elba-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/soc/amd/amd,pensando-elba-ctrl.yaml b/Documentation/devicetree/bindings/soc/amd/amd,pensando-elba-ctrl.yaml
new file mode 100644
index 000000000000..f1d3ed4f519b
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/amd/amd,pensando-elba-ctrl.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/amd/amd,pensando-elba-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Pensando Elba SoC Controller
+
+description:
+  The AMD Pensando Elba SoC Controller is a SPI connected device with essential
+  control/status registers accessed on chip select 0.  This device is present
+  in all Pensando SoC based designs.
+
+maintainers:
+  - Brad Larson <blarson@amd.com>
+
+properties:
+  compatible:
+    enum:
+      - amd,pensando-elba-ctrl
+
+  reg:
+    maxItems: 1
+
+  '#reset-cells':
+    const: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#reset-cells'
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        system-controller@0 {
+            compatible = "amd,pensando-elba-ctrl";
+            reg = <0>;
+            spi-max-frequency = <12000000>;
+            interrupt-parent = <&porta>;
+            interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+            #reset-cells = <1>;
+        };
+    };
+
+...
-- 
2.17.1

