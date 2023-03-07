Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401DE6AE04E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjCGNVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjCGNUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:20:43 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADB95B85;
        Tue,  7 Mar 2023 05:19:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JO6hz9AZ4ZydAxfoh6C0cBQvEO55qIUJckX+YilS7SP1/vz1EwhNjRjMLKCeJZiZkZwAV0FaemKt3YvqTsY94OUDsiMGNHEZHCp62VMSA+SxBL1VaisIh7vyq0AYRtbqFZZCis0DxvYKBLrObTBPza9c3QJus5ima9AIA1FeCrXau1K9eaedT6a7XKCnFvF9HNtoqAC9IPgJyj31lJSBSUnOTD2ZRTiBNW9kRffX7+aM4RXJheSuslWP0c2Z7JJC1PBUrD/GtLt5877wGpFemTUOMd3PVh2jSxVFP/EtsXev/uveFuukfbC/TRxSNRRRoK5ubGSnhKlLBgn/Sr1Bkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSWitXQvHdAmKHYA+WhhjbbDTpMQvt64jHyk2iMVmno=;
 b=ETQZO3znrHQ5WeigAkpK2uPYMx9JTvfgUuz+q468JmMHIhcHH9U4FzRN0wXYck5VlkWgcmef9cad2BzkR5qXeVOIgtLdyO+dPnKTc7J+3jidXRzdKxcKJa1Rv/cVpcp3roNf5ADUQXRbr/JRozn6dLATX6HrKX99Ycic0WS3Eqg5sslbx2Z9uaVgwrAFugiQbPSP7YvVbyCEEfK/atBJQvQmzwxMcZ2rOKQnZABxo9OutWlHhJYV4DP0zAp0m+6Z6bhB5FDS87zCRn+4nUdM1UmBsKMuVjSbdG+gpLCbyI1xldEunoJtnT1Q4Y6PQJPLrVObQUy1GitLZPMTiZNX1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSWitXQvHdAmKHYA+WhhjbbDTpMQvt64jHyk2iMVmno=;
 b=dUNRpZA0OKk4VqZsoiwvOZKR6LUG9jm9KjXyZfkBa3jdVAS+GghTvHaklnG+rwffZqgZt/OSzXRTGXXvFak9G94BBkN92MhDeuwphOmp1/oIdeKhJYk9KqIMzoxWIwi67N6rWB8DHp81ZeJkFa3lXOLwX1IcS/qKmH5POKRr/zI=
Received: from DS7PR03CA0016.namprd03.prod.outlook.com (2603:10b6:5:3b8::21)
 by DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 13:19:53 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::51) by DS7PR03CA0016.outlook.office365.com
 (2603:10b6:5:3b8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Tue, 7 Mar 2023 13:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.16 via Frontend Transport; Tue, 7 Mar 2023 13:19:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 07:19:53 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 07:19:52 -0600
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 7 Mar 2023 07:19:44 -0600
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
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <pieter.jansen-van-vuuren@amd.com>, <pablo.cascon@amd.com>,
        <git@amd.com>, Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v9 3/7] dt-bindings: bus: add CDX bus controller for versal net
Date:   Tue, 7 Mar 2023 18:49:13 +0530
Message-ID: <20230307131917.30605-4-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230307131917.30605-1-nipun.gupta@amd.com>
References: <20230307131917.30605-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT057:EE_|DS0PR12MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e90e2b1-c7fd-400b-8845-08db1f0ea377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hYJVvNaBgNygIuOOGVmuKqDbdHWG1CYN3SCwfR+qyRfzEF/VIzTQQao6V+A0rpkdRGmZbU69q2uWusP9uRE5F8QULtrsK0jCDlpeeqsk/YpUdbbhsz2LKoBNoI7dDkoFHhkWTR9uXDHWK8aXCVoipKKBWdx/M82ZzadlThGrNzS1MCKipYvI7cCnmHdKeoyF5KGNZJWvuuqDz/jtaI2XYffkvMBHwqn1kUP6g8pCD41IAYXCRjEV47FUEYWofEv9BgaC/bxMaFLEpdu2rbUskjh3TaiU9zVtaKpk6rqlvRrj7dUj5/rg5DWmtUWwkeQKGQgrhQhG4hlcg9JMXX+seCfZqL4Q/pBKnwi9cFp1SbeFm2bg4m+bWjdt3nIQY7T3PTBhbCH+yTPHnZXTyFIqlYtpkxU6JTcTffJblLOpLtdD+DTyRhjLfYdcxl2Y+w6nqqahmuowLimhzDnrrNJ0kkLVqex8YMx4RdnikE7hsn1wcUL1tDL97TsA17bQ5Bx+TjkN4TfFLJve3Bb/wU/88MVu442V3ZY5Jmmxe1boEPYAjjmi4X7BwVyBMExPWTfhnB3DFQ4mWLGqZYmnf2FuHON862okPCSnAASyB7efiDT/KHwnKWoqcj7Ec9mnwP5DWLpFqy3dOpU1yWTUcMztu+0wbI3o9hr6rEeyjaS2xYr0Umi+tHJAQ4KSDEtJ2GMweACbSWME539GVQuOSaOY/DJXWDTBeBEpVfj3VS7HWH6u4ycXuNuZx1MbZeLUXRFFxdKzn3ej9d7dmirbzMk0MdXZ2bP4JDqBizjDpIKGZuGV7YytsicOiHng8nIggsDS
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199018)(40470700004)(46966006)(36840700001)(356005)(81166007)(86362001)(36860700001)(921005)(82740400003)(36756003)(4326008)(44832011)(1076003)(2906002)(5660300002)(41300700001)(7416002)(70586007)(8936002)(70206006)(8676002)(40480700001)(82310400005)(47076005)(2616005)(186003)(336012)(26005)(83380400001)(40460700003)(426003)(110136005)(54906003)(478600001)(6666004)(966005)(316002)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 13:19:53.4799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e90e2b1-c7fd-400b-8845-08db1f0ea377
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CDX bus controller device tree bindings for versal-net
devices.

Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
---
 .../bindings/bus/xlnx,versal-net-cdx.yaml     | 82 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/xlnx,versal-net-cdx.yaml

diff --git a/Documentation/devicetree/bindings/bus/xlnx,versal-net-cdx.yaml b/Documentation/devicetree/bindings/bus/xlnx,versal-net-cdx.yaml
new file mode 100644
index 000000000000..7f62ffbdc245
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
+  detect CDX bus and devices using the firmware.
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
index 24f936ad11fd..3174deca545c 100644
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
2.17.1

