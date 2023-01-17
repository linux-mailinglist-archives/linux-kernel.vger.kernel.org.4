Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9266766DF1B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjAQNmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjAQNmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:42:24 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1500938EA1;
        Tue, 17 Jan 2023 05:42:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/eTyu95cQ5zWx+x+exiC2Q+ClKMy7LgaZ67ecKPeTOg7rwTOkKPyyK3WSvlCtxCLKkz8HC+fkVfoA9Y0d7fMo8A2E7AmR9RwgN5P2JhiRtV8FXeE9Nv7f7mRBuanfVnCwLqIsUhlq96Y8NC7x7/wTBDw4auplwGb4Ydb3KKnhaGEJFczyBfGVi78x8Ig+phL1yVK/M6HpuoEdjrgqPqH58oWueahe7HQPfl+iAFjszl9kNPMoatOvW+85k6T7YgO9v1DSaLyw+4zh1I02RGxP5T3PkLtMDZAItSz/+4Im/BuETf9SyM97Bka8unwdfBCpw9o7LN1lrZ5k28hSphBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iso73/wjmXE1KCynVlUtgn3ZDEPh0ArmTEMXnrxPZ8Y=;
 b=X6cWJ6IKt5h8tZl7r3OJDsvG5S0u/Twq7IMFE6EJfSutLqAmUs6VPy8W1MOHezVUNYYreFdd6A/6Db5DnDqboQF1WIqd/VPNoD5Iav6FjSYPO/6Hz2+E/Ae7bgSRBKFuqL0ESqjE0so45fW/EBytqfvE8CXF9yfOQ90nMG4vd2AuIRSKtL/z0Y5cW046ZPJw7EF28Q0PM2MagcVAIl1ytlu7Ia1L7qJRiLzsWwKlyi4tkjtFWaoSTvL7xRQRasyWRbiLhFOXMLjdcBO6Qpa3oGkccNEYHac/OSDNECgHs9edu49oXYWAFDVcTXqckQQbMjnJmZ9Z62/fP/IVEiwF3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iso73/wjmXE1KCynVlUtgn3ZDEPh0ArmTEMXnrxPZ8Y=;
 b=Zha4EZuwzWOb1UjDKjSTXZdExZmh6YGALvzLYWnzTIC/EXV9KPVoNPB3oLzoGpCHjMIx5zNy4Y+Y14CHjlfc/Hv/Ml+OJdhrRlxeqQTsuZzogxU/+MiBm7/cXf1H94NL0QlCpRNNNRXvlHyTaTY7UxnlUnd9j8kK1OF0O58ywxc=
Received: from BN0PR02CA0046.namprd02.prod.outlook.com (2603:10b6:408:e5::21)
 by DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 13:42:18 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::af) by BN0PR02CA0046.outlook.office365.com
 (2603:10b6:408:e5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Tue, 17 Jan 2023 13:42:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Tue, 17 Jan 2023 13:42:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 07:42:17 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 07:42:16 -0600
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 17 Jan 2023 07:42:09 -0600
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
        <ndesaulniers@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <okaya@kernel.org>, <harpreet.anand@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>, <git@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH 03/19] dt-bindings: bus: add CDX bus controller device tree bindings
Date:   Tue, 17 Jan 2023 19:11:35 +0530
Message-ID: <20230117134139.1298-4-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230117134139.1298-1-nipun.gupta@amd.com>
References: <20230117134139.1298-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT046:EE_|DM4PR12MB5039:EE_
X-MS-Office365-Filtering-Correlation-Id: 71855bec-2f7b-491e-abb6-08daf890a67e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+bcw8jANw9rL/YNgEHKSdO/coXqOB1ubn9WFzwA8iNGBogrMWFopbTg+7lBe8x++GlXpUnPjDPVh/wdaBDJsY/6vKI/GhlYDgCGKlj1uoJ2IjXAsw0bAZ+0AoJVbeaGxLqdZ+tC7HNuzLzOHN7pFeW2kWtCp8xp1nVTcQ9whv5hzZqXP5BpoTO9BHkqNagSAlPZwnbHwFxGvmkVeR8GlYhKwFsY05/lUhUpnn0rmZjYysjo3+vNJLvoUEShEyhyq2JhPngHac5Xh7j6/mP4mBlGju0E12VI8CWSgPttPRf+FoWnwt2KzljrT/Z5rS/wVZ1rkBgkYH86s4XWKD2xElYZtdgxQoWLX8eO88lYpvilrxgsINSpj9p/2+6vnS3DuJB6ZY4GDcQ+O2E6V1+y0632aWslrDcFcLJJm5CP1DK4RKM6aMQWySO8q6apoJGW75dk8x5doxYO1uJuaIsjceY6BVS8S6HiM3yekbQpNmJPQ1YmMafDLMpZNzuHp97sXJTX37ifts+MS6rYLziGtgoOZv9mcdOMHp1mwD8zdDigUHfTyzMxZ/NVAP0DNQNpgmktWsKK/U/F8A4LVX6uYAqhwIZ5BLLNBG9dcaYvLjKxgDUF44DhJ5jntlpnRqYY9IegcoqPW3fRRD8gCgrl8FPAQw6iyt6O0jUQPBXqcvG1kmyL7cMZ0I/oRConqzfvYtUB6IVo1dKxsfO62m/pW1wwyf6SiaQ69Gcyfod14d9taDJZ5bGiSJjSSIE2UcrVua6anH6+5wS63QaoYUUK38ut60camAzjMHnT+M1kVdjQanKqjRf78fyLElL91mwa3zchIfRmJP+a+3sX6VpO/mSq0ABL3c/2xDIuQsk5bxU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(82310400005)(86362001)(4326008)(186003)(8676002)(26005)(426003)(70206006)(41300700001)(47076005)(70586007)(2616005)(316002)(921005)(1076003)(6666004)(54906003)(40480700001)(478600001)(110136005)(356005)(44832011)(40460700003)(2906002)(7416002)(81166007)(966005)(82740400003)(336012)(83380400001)(36860700001)(5660300002)(8936002)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 13:42:17.8176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71855bec-2f7b-491e-abb6-08daf890a67e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5039
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for CDX bus controller.

Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
---
 .../bindings/bus/xlnx,cdxbus-controller.yaml  | 68 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/xlnx,cdxbus-controller.yaml

diff --git a/Documentation/devicetree/bindings/bus/xlnx,cdxbus-controller.yaml b/Documentation/devicetree/bindings/bus/xlnx,cdxbus-controller.yaml
new file mode 100644
index 000000000000..b2f186864021
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/xlnx,cdxbus-controller.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/xlnx,cdxbus-controller.yaml#
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
+    const: xlnx,cdxbus-controller
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
+required:
+  - compatible
+  - iommu-map
+  - msi-map
+  - xlnx,rproc
+
+additionalProperties: false
+
+examples:
+  - |
+    cdxbus-controller {
+        compatible = "xlnx,cdxbus-controller";
+        /* define map for RIDs 250-259 */
+        iommu-map = <250 &smmu 250 10>;
+        /* define msi map for RIDs 250-259 */
+        msi-map = <250 &its 250 10>;
+        xlnx,rproc = <&remoteproc_r5>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 25c76cf27f21..b43242546b17 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -966,6 +966,7 @@ AMD CDX BUS DRIVER
 M:	Nipun Gupta <nipun.gupta@amd.com>
 M:	Nikhil Agarwal <nikhil.agarwal@amd.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/bus/xlnx,cdxbus-controller.yaml
 F:	drivers/bus/cdx/*
 F:	include/linux/cdx/*
 
-- 
2.17.1

