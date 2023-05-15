Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1368703C54
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243743AbjEOSS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244037AbjEOSSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:18:09 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9594518CA3;
        Mon, 15 May 2023 11:16:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkY5ywQUoEPGikrh1hur31MXjaN6zgu7WQG9HfQQxD7EMjdyDW+j9+zhItTd85yk8JqQVJmEEn8WpqyXJnyjZF926QCcc3Nv8v0hOiojxIXJ6AkZMl9sDMt3MiTzkOikRTVBFSssfbmqhQ4mAakKrXqzt9Oy8MsBq57T4SPgU6H7CZZJv/QQtyZr1qVaKigJ3fnKXnBH1f8sxw2u9tVj7roWQxVUzGIJMmuCZHfMN09/hraoqTlU4rPW26jPnppyz1aHnAM175G9CAXxs9S4w4Or9ltoftIFa885AJJwvdaQIIM+OykbbsNs0sfN+R23MNtkXojchLBAWLhJvJULjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dy28TcdtatfE39iP7KmaaFwO5+MCnCgUUyAylO9Y+RE=;
 b=GAd3tn9T0y2pUfuiKMwOA8ulkP022tjEAKFrv2e0V+yaDmlvqMwPWMi0CjHzvSpXYlaExK43I5L1HPts6tmmaEv0pZSZ/30+DiXPJBUToT6KQFsOmGysVz4aZxT8+iL4KprZewkSgg/HrKw1GbHDKTVoV6pWxENJNQsl23VmF+LAiKltJku/tnUL66ZLo8r6LEVCM2K6tWO8BtBosYCHCXnOmHgBiaX5rWKLfqt2Ab2mnKU+VL8bJOi12bvIl5JPJ0rVElqyqnBHMicRa8EbkWTbQf4QWcDJkDA6l6uJDDLf8eW7m+A+1KjNQjbJAI4L8i6zquPwHHqKTfUGd3yo8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dy28TcdtatfE39iP7KmaaFwO5+MCnCgUUyAylO9Y+RE=;
 b=TsOwnmbE0mNJlUCl0JX+NSIaKsh89hzzqH674OS5aRbUsDrh2tXbZD7PekKVwaW81Yrg78KOqefgP1VatWqOfn4Ef6J4h7slkf0l/Jyxul3q3PIQeTmAnkxwt1a4H7Jfw706M56Bd5ZUooKiuC9TtHpDznbLoUZqjqrHO+fw1xo=
Received: from MW4PR04CA0034.namprd04.prod.outlook.com (2603:10b6:303:6a::9)
 by DM4PR12MB5198.namprd12.prod.outlook.com (2603:10b6:5:395::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 18:16:35 +0000
Received: from CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::f3) by MW4PR04CA0034.outlook.office365.com
 (2603:10b6:303:6a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 18:16:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT090.mail.protection.outlook.com (10.13.175.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.14 via Frontend Transport; Mon, 15 May 2023 18:16:35 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 15 May 2023 13:16:30 -0500
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <catalin.marinas@arm.com>,
        <conor+dt@kernel.org>, <davidgow@google.com>, <gsomlo@gmail.com>,
        <gerg@linux-m68k.org>, <hal.feng@starfivetech.com>,
        <hasegawa-hitomi@fujitsu.com>, <j.neuschaefer@gmx.net>,
        <joel@jms.id.au>, <kernel@esmil.dk>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <p.zabel@pengutronix.de>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <walker.chen@starfivetech.com>,
        <will@kernel.org>, <zhuyinbo@loongson.cn>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v14 1/8] dt-bindings: arm: add AMD Pensando boards
Date:   Mon, 15 May 2023 11:15:59 -0700
Message-ID: <20230515181606.65953-2-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230515181606.65953-1-blarson@amd.com>
References: <20230515181606.65953-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT090:EE_|DM4PR12MB5198:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e55fe76-910d-4256-3c8d-08db5570848e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: husvFtKWHgTDhSoT67CNj1jGvZg1++p5Of6XB45h37GNtE7An0jwVJHa+Udj5khZa1WPCGyKA26THU+6QV+yOPsdV+CVj07XmXavwBXYPzBLNBA6y/964FZKPy2dLdy72XOpL4zxVZcuEQUXx6aSFC3EKLMgYMbgAQPK5nXOMPnZY59cogiGTI2vESPn5g3cFWoywbqMiyZoTpqdJLbiJsO28/iGbDyEvWxDe0J8WE05Jn4wQZTeqr4pDwc9hL2gsllretqQmYEREvhO74P6FEaZUQa4J65+b/U9Sho/Zs+D1JFiCqyA+UmQ8MLec5svArCIW/Jbc7thNRDb/7Bw7Fu1KQkPKUQb3hq99PgmzzVNaE1OkUpPFJPylw4ugvZt57uVnIo6crZ/g25B01OgFDJRm4vqSy5Yxep/VPWJyOOZYWQ+sPAJmhgJ98sHwQ6AZSa2ZlRBZ+VoC4unBW+t0EysebDZtEAAzUSoR/jBmE7BuAsB1TEZ8mt7YW/hq5rjrsM7JpV3wiQS0+RrI1OFs8KXUrL19zOBdQ/SdmhVnNtETREczCUmZbQRC0RoFEEKSqw/4VbKpnctuyjplMMjROk+2jfNd5ybZ3/kMYTCrSfRVMDyT2m9eQjTZ/AvfONfABAFH2dZf0l9Mj3kUYQMOXcqJSnUaOoXiB+vQp4iHlKkN7TkaVHOrmlJZCgS3NsEEExDvYUdA1vntJCwfGR6xSQGeLRnRYl0QuOXPQnnu7BOeqW2EBsATlRFNlqZ+ll/3CRr+xjeXikg/x86tL0nEzTOospDZ8iW8f3EhjNXh0o=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(356005)(6916009)(82740400003)(4326008)(6666004)(8936002)(8676002)(316002)(40480700001)(41300700001)(70586007)(478600001)(70206006)(81166007)(54906003)(40460700003)(186003)(36756003)(16526019)(82310400005)(2616005)(1076003)(2906002)(26005)(47076005)(336012)(36860700001)(426003)(966005)(7406005)(5660300002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 18:16:35.0107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e55fe76-910d-4256-3c8d-08db5570848e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5198
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for AMD Pensando Elba SoC boards.

Signed-off-by: Brad Larson <blarson@amd.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/amd,pensando.yaml | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/amd,pensando.yaml

diff --git a/Documentation/devicetree/bindings/arm/amd,pensando.yaml b/Documentation/devicetree/bindings/arm/amd,pensando.yaml
new file mode 100644
index 000000000000..e5c2591834a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/amd,pensando.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/amd,pensando.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Pensando SoC Platforms
+
+maintainers:
+  - Brad Larson <blarson@amd.com>
+
+properties:
+  $nodename:
+    const: "/"
+  compatible:
+    oneOf:
+
+      - description: Boards with Pensando Elba SoC
+        items:
+          - enum:
+              - amd,pensando-elba-ortano
+          - const: amd,pensando-elba
+
+additionalProperties: true
+
+...
-- 
2.17.1

