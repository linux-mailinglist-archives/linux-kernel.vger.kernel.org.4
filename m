Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C4369AC77
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjBQN3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBQN3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:29:39 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79CA68AE5;
        Fri, 17 Feb 2023 05:29:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENEdgqs+C4FLRkpdptQJFcaAkLiwjY+5nNforafC7tEYoJ6qFoTwwV/FFIUvqmDpOcLhlEVfnSfFSXdV7zYwCAWmNDAF0vjENKQHGoupVyEJT8mk7/KUld5/Thh1TH4HZJ1PjluMHeSjTI47byBRy60dAqLzWC0l5XwP4mrXL4aJsH6qBIAi5oLSqBAbtn3EBdDvc66h6o5JkWpEn2g3XWKfN9M62JKtzYlMc1RaKsy3nL6fkZR7FmUeyf12clCWcBpOXj1C+D53ayfs0Y0CdtJy9Ll/oeIm72hu+cpbBiW48H26dali7nAiM85xd4aO1IR/46R0LQaH33g9nPD6iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wk13ozPfPfMx7zgtgTxhEgmWWrsKpgeeAk4uYYTBseI=;
 b=KA19iKJXK+ErjzjNsL8UL/nCSNdX1Of+894vxAUeLoesvnEljvJGREfc3KHGVbm5a+QJB5DONaL2YzRSdBHgkYViaAAEHzFUJpPE4f1SITiK+kpmt2Cqqvrr7A3/09oJLzidqpSSE0mGVAkKRsH6Mn/936OT+RIeTFbaOZwKWKtKthCha+44NgncL5t3dmg2AvtymPe6dVCyqy6hsMvB1vl3poQcuTiE+rUoKpw9j3mKFJ6Z4KcxSPklLzJfaGRFiWjiW1sCPUsNlQjjRm7EQxkjGYwq0BDOAOsmELOcDZcQNzTiSU1kkLBMUsaeXn8TcJKysA4Xj9mTqA2tabQjcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk13ozPfPfMx7zgtgTxhEgmWWrsKpgeeAk4uYYTBseI=;
 b=zWOEnAUUKfpqSzBeJ8/3dA0vA/tesvGRcgFQP5Irabk3vqN4JVaGcRCBmnaaIT9//zHQIr6yBcBYKCv10DhB02P3afL9q/ALld9JgiaPViG1yyB3AtNIVWRj0tcqa7tCa2S+BJLBcLdUiu1dTOSIuHiFqckyVsr9wHdkiYIcC3k=
Received: from MW4PR03CA0253.namprd03.prod.outlook.com (2603:10b6:303:b4::18)
 by DM6PR12MB4863.namprd12.prod.outlook.com (2603:10b6:5:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15; Fri, 17 Feb
 2023 13:29:10 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::bc) by MW4PR03CA0253.outlook.office365.com
 (2603:10b6:303:b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Fri, 17 Feb 2023 13:29:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.17 via Frontend Transport; Fri, 17 Feb 2023 13:29:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Feb
 2023 07:29:08 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Feb
 2023 07:29:07 -0600
Received: from xhdipdslab49.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 17 Feb 2023 07:28:59 -0600
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <eric.auger@redhat.com>, <alex.williamson@redhat.com>,
        <cohuck@redhat.com>, <song.bao.hua@hisilicon.com>,
        <mchehab+huawei@kernel.org>, <maz@kernel.org>,
        <f.fainelli@gmail.com>, <jeffrey.l.hugo@gmail.com>,
        <saravanak@google.com>, <Michael.Srba@seznam.cz>,
        <mani@kernel.org>, <yishaih@nvidia.com>, <jgg@ziepe.ca>,
        <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>,
        <joro@8bytes.org>, <masahiroy@kernel.org>,
        <ndesaulniers@google.com>, <rdunlap@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <okaya@kernel.org>, <harpreet.anand@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>, <git@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v8 3/7] dt-bindings: bus: add CDX bus controller for versal net
Date:   Fri, 17 Feb 2023 18:58:26 +0530
Message-ID: <20230217132830.3140439-4-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230217132830.3140439-1-nipun.gupta@amd.com>
References: <20230217132830.3140439-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT047:EE_|DM6PR12MB4863:EE_
X-MS-Office365-Filtering-Correlation-Id: a3242c45-d6b7-45c9-1c2e-08db10eaf3a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6M7fbrxf+E/KSSqGkmuqZz0d8C3me6eG/xM2+9HxIArlfQyLCU24gB8+jPL/5dCndXikC6F+AU7UG7QuT0M5mM9vBXDR6TRScJHBWgs6X3DDFcmXOdeC4LtH3KeBIb3jsmxDO0ctEUK5u2yoZyEGsLKPkw/7HaNxL94O5RWsw60sT9Ya1gJanRlnrGTOX7Je2Skq+E172lZji4Ofi9F5RqGMnQ2fWQu1dQEllsleCU3pBTBOmmdQiC2A/24PYci2YOpyzRo3we5RO4PESccgryds0dTudn02XBMwkU40clwaEKWyOnCMkomD9kRYWxbdQijvNMeZ/bBGGvjJSVh/CABnzrYa3nEHDjiSgyNSGtWw+qKqFNwnxCX5OfKy1aboK01kJH94hRGbW+Q/4KLOJQKQKeCgvWRfS1HMGRWlJ655n4JOqnDHTzG6Q6u8TZRiVi1fYxJqZgqNZzrwWbeOHT1u5bv/rhWZEnWT6u2KZXf+QAa6uJGAwKeClsUY/JrbTrXC0YQah/sVvcxCQy8jiwIYqiy4poEia/BAnScYy+ja5qainncC31C71SnfUyGJPRjMMLMulRE/TWU8qnTdSEuFs8LAxMsh4K4W6yoCfhmQ3eDkB11r/X+juNHyXiI0838NUJoZjN40e5uX7g41x0BLy1Hd0pVnDLD4mFO8guV2INDmIV0cMU+NQa1SpGb2oH1+0vUjC31pJEHXRjAaeQLk+XAckbmo0bAO91/u+Da/RstVNaWOQIBPitZUVIPTuO1nc+zr0R5jttFG3bV9BEuJRKGJnYzZ0Y0AiSvJf3O7TpdHJOqypTkJSSg0/429
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(40460700003)(8676002)(70586007)(70206006)(316002)(83380400001)(4326008)(8936002)(7416002)(5660300002)(6666004)(2616005)(1076003)(186003)(26005)(478600001)(54906003)(47076005)(426003)(966005)(336012)(110136005)(921005)(356005)(41300700001)(36756003)(82310400005)(40480700001)(86362001)(82740400003)(2906002)(44832011)(36860700001)(81166007)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 13:29:09.7439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3242c45-d6b7-45c9-1c2e-08db10eaf3a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4863
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CDX bus controller device tree bindings for versal-net
devices.

Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
---
 .../bindings/bus/xlnx,versal-net-cdx.yaml     | 82 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/xlnx,versal-net-cdx.yaml

diff --git a/Documentation/devicetree/bindings/bus/xlnx,versal-net-cdx.yaml b/Documentation/devicetree/bindings/bus/xlnx,versal-net-cdx.yaml
new file mode 100644
index 000000000000..50f8665e8d0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/xlnx,versal-net-cdx.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/xlnx,versal-net-cdx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD CDX bus controller
+
+description: |
+  CDX bus controller for AMD devices is implemented to dynamically
+  detect CDX bus and devices on these bus using the firmware.
+  The CDX bus manages multiple FPGA based hardware devices, which
+  can support network, crypto or any other specialized type of
+  devices. These FPGA based devices can be added/modified dynamically
+  on run-time.
+
+  All devices on the CDX bus will have a unique streamid (for IOMMU)
+  and a unique device ID (for MSI) corresponding to a requestor ID
+  (one to one associated with the device). The streamid and deviceid
+  are used to configure SMMU and GIC-ITS respectively.
+
+  iommu-map property is used to define the set of stream ids
+  corresponding to each device and the associated IOMMU.
+
+  The MSI writes are accompanied by sideband data (Device ID).
+  The msi-map property is used to associate the devices with the
+  device ID as well as the associated ITS controller.
+
+  rproc property (xlnx,rproc) is used to identify the remote processor
+  with which APU (Application Processor Unit) interacts to find out
+  the bus and device configuration.
+
+maintainers:
+  - Nipun Gupta <nipun.gupta@amd.com>
+  - Nikhil Agarwal <nikhil.agarwal@amd.com>
+
+properties:
+  compatible:
+    const: xlnx,versal-net-cdx
+
+  iommu-map: true
+
+  msi-map: true
+
+  xlnx,rproc:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to the remoteproc_r5 rproc node using which APU interacts
+      with remote processor.
+
+  ranges: true
+
+  "#address-cells":
+    enum: [1, 2]
+
+  "#size-cells":
+    enum: [1, 2]
+
+required:
+  - compatible
+  - iommu-map
+  - msi-map
+  - xlnx,rproc
+  - ranges
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    cdx {
+        compatible = "xlnx,versal-net-cdx";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        /* define map for RIDs 250-259 */
+        iommu-map = <250 &smmu 250 10>;
+        /* define msi map for RIDs 250-259 */
+        msi-map = <250 &its 250 10>;
+        xlnx,rproc = <&remoteproc_r5>;
+        ranges;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 2e860bfc4692..1436eb093f98 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -968,6 +968,7 @@ AMD CDX BUS DRIVER
 M:	Nipun Gupta <nipun.gupta@amd.com>
 M:	Nikhil Agarwal <nikhil.agarwal@amd.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/bus/xlnx,versal-net-cdx.yaml
 F:	drivers/cdx/*
 F:	include/linux/cdx/*
 
-- 
2.25.1

