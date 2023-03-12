Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A3F6B6257
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 01:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCLApQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 19:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCLApO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 19:45:14 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805283D089;
        Sat, 11 Mar 2023 16:45:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WM0vG7vnzjbum6UAVlysVDLKBIJ3SOwZzfBQhtAigXqjd22C7cdbAa203NHgss8cuFZDIsV1uZpD5SteWj8YzpHGzu+cKfbZI2cTBaQeDm6LVpMLhc7W6A8ZX512uXY2j3HwCcduL0DIhdE+oo2OgQTm0l/u4G6UGLRK8q9lXTq0k7wPgBiS24WQi7vdI+4qVs9QUqBUqiIkNczY81IiBzW5QhyYwCrnnNtxcwDw9XNkefvOSjk5Rtjo/QEi3zcGl254nxJ0gZ+oo3m8foPw1pSznr7/4JFwn6i3ia9J6ft5S6JNnxFv0AN8SpnF3sJiXWvNVQgE+hJnDuWfB3r8Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dy28TcdtatfE39iP7KmaaFwO5+MCnCgUUyAylO9Y+RE=;
 b=fzXwHBacNy+eXODEDRXHaSNEC+pJpPhckkDx06Tzbnmze+D3lMJpm2alCSH1pNFzDPFnvO/dlH5PFU8N7EVE8QP13ECVD62pz4uSkA0oH+x+8XqcRohq0y4U/3CGke/GlShREouGfyQ0G4mYprZnyb8GzzTn0+ODhQYgSEvRkyZFLXULG3lMIL/V7rCmD5bUxKP84S78bXs0HXJNjFSnXVkhg1muS5/bEgHCIP3pcoyeF1S56wbt6aylYDluLQ+RkXFoa6y3DR+IwpYubyOsVaGH2p63zho0FgwyiZ5PKX7LKy9mMuH8EGF7X5JPz3NXFIE0qClRd5JIcJ79XnxU2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dy28TcdtatfE39iP7KmaaFwO5+MCnCgUUyAylO9Y+RE=;
 b=dvCjAYyQpW//XCEVHmnJCMQPNoKhQukm3kt18Wyjl1nfphyjKc85GgDpCJdFrFPMikVa4gqHu0pdgDRUMfqdHh2A/sAIo+KPwcgyLLGP9KCPHlYKOWk5DDxjYXvxRxX7+stqT3hgk19Ok/nXE6RCfAuAOmycjVpYTf8bZkLYRIk=
Received: from DS7PR03CA0313.namprd03.prod.outlook.com (2603:10b6:8:2b::18) by
 DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.20; Sun, 12 Mar 2023 00:45:08 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::6a) by DS7PR03CA0313.outlook.office365.com
 (2603:10b6:8:2b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24 via Frontend
 Transport; Sun, 12 Mar 2023 00:45:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.22 via Frontend Transport; Sun, 12 Mar 2023 00:45:08 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 11 Mar 2023 18:45:05 -0600
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
Subject: [PATCH v11 01/15] dt-bindings: arm: add AMD Pensando boards
Date:   Sat, 11 Mar 2023 16:44:31 -0800
Message-ID: <20230312004445.15913-2-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230312004445.15913-1-blarson@amd.com>
References: <20230312004445.15913-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|DS7PR12MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: 066bc509-0af3-455d-defd-08db229307a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wyACqOaB3pE6HCDkKR5FKPwFuKCpT5g82WfoiiXpJXID8+QTjHD9Y94pH9qe3CbFj2oKwZAYXRg2Jxai7hTBTUcDxfxbxdUlLnrpf4eK7/RvFN3zN544plV0KAWv5Ac0amWzgX+Orvj81T4kJrjN4BPiVSOu68DF6IqOJKjI7I+dm7hwu1CYeDl3Fy1jFcg14YGsMlM6rDtBDthpeJ1mevjAxpWEEkLEkwDtJhgmNX/sZfeLYaZ2Rh9YbP4Py1xQBXD5QTFfcYQUnOfixGIzZ54DD8gYFrY0o4R0osEKX64ERDz66H8GtDAcKv/7vq9eBg2P2So7U2ipckCij1mjj7oiX2oKz5SxEKR/j1BIJ1hFAaL1h6wZyx31VmzAZYDWSdbGuLuqG35R0/6h8CpJiC/Wy5BMColglhtLalIeYFJpV+oS0447inJRBrNXyve6dhZmiVMBtH+imsioDf/j4/HxP2zX/kTNeeegoMOenthCdTRxLYuZoeZiFqTQJ7w6xNVbFH3bmjXxi47sR5WGTVQrj9fjjpKDlXA4jj11c/2f8VRI9fNJZ7s3oxyfn4FKJ3+Bt3FnHOmMLvekN4/ZjJsTLi3bNEdNNQaNKMBIfXIdY8axaTthsrhgCphO45KUzedcfdkWGcMqvtcb+/5IuRpwUQKz/zU1U3u87MoUm+tbcZlJnbXSCdbSOAaiOxMWtwYsszn5cFP6wz3F0Vd+SyzHyCDSIeolWRIk+bRi2qVPdmpxHLE0/OduRnoO+cCF3f3Di0xFrDrzJwI7ISIY7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199018)(46966006)(40470700004)(36840700001)(36756003)(426003)(47076005)(36860700001)(6666004)(82740400003)(16526019)(26005)(8936002)(1076003)(186003)(336012)(966005)(40460700003)(356005)(2616005)(70206006)(41300700001)(4326008)(6916009)(7416002)(2906002)(7406005)(5660300002)(70586007)(8676002)(316002)(81166007)(40480700001)(478600001)(54906003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2023 00:45:08.5796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 066bc509-0af3-455d-defd-08db229307a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

