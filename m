Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC57D67C8F0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbjAZKrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbjAZKrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:47:15 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57C467791;
        Thu, 26 Jan 2023 02:47:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDTSRbLQCXXq3Pmu/gE0Se60GpWTphG/Rx57QAuazcG04ib0vY5fmW5eRk8c80hOeehSisB9ZWddhTufDwNvcdxO1TGRaI+mzd+2NI+v3GzSQbBffns/UxMbIHxFGcub2HbqcptGTARH0HM/TtPhEIixR5DOJGWWtz2lRJs493QRmNy1u9y3nfnFPBs/epIjaT7mTXlgMXNi9TddfAGpsvOl4zgfLtdDq/0dBlBWXUBL4GqMKUPetMeSUGgEqthh+WmPhMY2gs/ELhOLnUUiFNN+KRo7zrkMLFOYfkuKaR4iBociaUVS6vsLOhH15zHT1NSRHnGJh2wA+aB3dkb2PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDysyl6J3R2f/k/yDOfJlNOZE2VLY7dUf9OR88bwy1o=;
 b=O5mzrdfvvK5kN/McVLM1UZri1us4LHLa3rbR0M6e2ymbTIoanjiDAaTzTfiNzwVu8dBc9v3BzuIc6WfNrBFJ55mZSxqoc0z/e7OaCXY3buBXGZCIf1OVE7cluX07VZaxUyxwHPY3N79/l1nr5fFELyO8t8uOVuSY8tsA5X92IXsCPO8htQYE985CyBDatADlxh6+lwn/JDljKSE/EYeiRWbgIjBCmCKno6bQYbuHFyNWflNtdRGOwqlrUGEuf/CV8g57QhV+nxJcMx23i1ej1czdoibh0v16RmeLkQZ3UAni9ooCke0qMDeOBnDm518ZL682YSNvevxaa6IwkDDPJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDysyl6J3R2f/k/yDOfJlNOZE2VLY7dUf9OR88bwy1o=;
 b=gCCYkYgwWf231ZfAwDIXUXVsc/sqUO607ArKX20bAp2PanI7vbWp4JR4uRGIw+5UqOpuLziIlivgP2Yukqt9Yxu7OzV2GFcVYAT40Ztdp1EigC06ECd6uEtcTizH1zWwOrfveZPn2RvKc0vHWWihiOZjDD6ay87XpJZ48ifr4Lk=
Received: from DS7PR03CA0303.namprd03.prod.outlook.com (2603:10b6:8:2b::19) by
 CH0PR12MB5042.namprd12.prod.outlook.com (2603:10b6:610:e1::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22; Thu, 26 Jan 2023 10:47:05 +0000
Received: from DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::a6) by DS7PR03CA0303.outlook.office365.com
 (2603:10b6:8:2b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21 via Frontend
 Transport; Thu, 26 Jan 2023 10:47:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT086.mail.protection.outlook.com (10.13.173.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.22 via Frontend Transport; Thu, 26 Jan 2023 10:47:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 04:47:04 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 04:47:03 -0600
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 26 Jan 2023 04:46:55 -0600
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
Subject: [PATCH v6 3/7] dt-bindings: bus: add CDX bus controller for versal net
Date:   Thu, 26 Jan 2023 16:16:26 +0530
Message-ID: <20230126104630.15493-4-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230126104630.15493-1-nipun.gupta@amd.com>
References: <20230126104630.15493-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT086:EE_|CH0PR12MB5042:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa18a71-57ad-4542-e9ff-08daff8aaa23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M7snAduc05/RySU4P2kCFHdurYkR19FcGwsLTGoPCE5qXe5KGQ1/vcHh/3FlJ/07ZOmP3YSwlAr/rZ66K4kp9MyTPnuvFWr/6dNdUKroZqBWsoUwwuCJvaL6rvFzrmMayIGT+pBDyUWPR6DLoUxPFck8WEfk7ROwTaflWjkNCj2oZW4MSAkBN8zw177go4jGCd/FATs/81ECjogGOYgkN1zFKT1ixot4EoujOJfu49+fS02Dsp1dddZa4U/Ea4TgxjncRjPVIDKUBh1j/Yw8rezbVxYGYWnEMXTkGJ6yYDhwsqt+30YIq43Cpd8vSnFOkTjigaSk+aD2An5EPlymlBEDC985CPVtyx+6XZw347ucfErORGXdMS43B43oOxNUDwfSSVhtqgiOtuFToHFjMYrg4wap+9xePy2dgPNt42GKrd6m8VXOJvw4cWVpqHxjjW3kjq7rCeDOQ7bHJBJCwxhsTX8WHEOym2QKDhi7pa3Lkk/IkVkzKvAC+O/9nk0xPbWyOcbIR7RHZ9uRwd9sEg6lX4vFPyVNHza4S1u6/gEy07k46IfKGkuX/tdhtwDLROGZP23Q/3/A0xJjJDO5ImANxEKIBe2DNVcqyN09pK3NYVQCAjPqAB5aKCxUWgGEhdO2p0PpUU4DR0WszqcwUvYnilWLEyLoHBdawmSSPvyO6t+1fpNGFQCGqq9FA8FwSSoKcq/K607ERXl10DH1wazceKO5UvLM6Lf35b8vwpxMd2dmLNrI/4saf7EyRisPmMV1fmBDI4qnOY80g/bLgu3JUQR+9p/JnDk931txJso8MC0unugQN/OwXZ5hgbSIJ1+pFUXMKAigmDfbRIDXH9etejvpU2nYDyX4R+FO5GN+Ec3WHkvRoMCeggEAiFca
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199018)(40470700004)(46966006)(36840700001)(70206006)(316002)(54906003)(110136005)(41300700001)(81166007)(356005)(8676002)(4326008)(70586007)(5660300002)(7416002)(40460700003)(86362001)(36756003)(8936002)(44832011)(921005)(2906002)(40480700001)(36860700001)(82740400003)(1076003)(26005)(186003)(966005)(478600001)(426003)(83380400001)(6666004)(47076005)(336012)(82310400005)(2616005)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 10:47:05.0615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa18a71-57ad-4542-e9ff-08daff8aaa23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5042
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
---
 .../bindings/bus/xlnx,versal-net-cdx.yaml     | 68 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/xlnx,versal-net-cdx.yaml

diff --git a/Documentation/devicetree/bindings/bus/xlnx,versal-net-cdx.yaml b/Documentation/devicetree/bindings/bus/xlnx,versal-net-cdx.yaml
new file mode 100644
index 000000000000..8452185b9d70
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/xlnx,versal-net-cdx.yaml
@@ -0,0 +1,68 @@
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
+    cdx {
+        compatible = "xlnx,versal-net-cdx";
+        /* define map for RIDs 250-259 */
+        iommu-map = <250 &smmu 250 10>;
+        /* define msi map for RIDs 250-259 */
+        msi-map = <250 &its 250 10>;
+        xlnx,rproc = <&remoteproc_r5>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 3b31df9f6bb9..fe5c656f2738 100644
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

