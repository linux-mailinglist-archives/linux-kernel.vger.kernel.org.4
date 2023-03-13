Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67896B78E4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjCMN1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjCMN12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:27:28 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4CD65C64;
        Mon, 13 Mar 2023 06:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkHckp9FcHeFe2mvW0h8fHZTb/kpL0npCKBf4lAyHJqCWWQPZuxr0eCkoxwoO0nzZ9DrEFn5lgqQx8eYpajGki8kSE3nQHGKZxbYwT+Z975MuyIr0W5ylfrQUC5eVgWooo3YRLRC+Si5snlatv2hNiZ0Q/T77lKJFKqu9Fdqyelx7DQsSZGJs+lqFzLWagV5lzBHpNm+bvb7lmvPaCxMN2jUPtWYt3R9UiQA4fceIAN3JVkyF+gju6+1Dp5JLDGkC3x4fX0Adlo1YejPsOddylSJW8pAvimD1QFqJ8IoiO9xnZDytzgVuaN8Xr37nTIJ8c0WqQfbbUilaiV8kZ93vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6p23UugGrGGqQeN1QwTG4x8RMMSYedLlyBWRG4zcIg=;
 b=M7pN7YbvuysvKEFZ5gzAOeKti3YoSjyDOwc/IfzbFKCUEYdXPAvRcngduhx00STUovRAP5OCpdU7TmrNrx6QwtFXKMmCvuU+gpn6VktJ+thoWht6ez/2oDm2fyypxVXzrsm2VZlmWu983gkV38zYZyNCdW/wsZmC2w9zuL4yzuYG89gTHMlap6vphwVMtcNS573DhJYv9GLW/otTz75e5gderQJNOsTH9ny8DNd03l7m96yAjKHwA/7OeEpte4LuyQzmx71zfZteVr1tllWqljFfb68A/+JYLb5s3h+NSEVsRQ6kAi1h1KROSO8JLjucFS7rKj5085y953uWbr4FcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6p23UugGrGGqQeN1QwTG4x8RMMSYedLlyBWRG4zcIg=;
 b=C/0FX4oKXa+PZfvf24Z41SQuo2FXAWU5svLkZs4yRnkuT6J6WAKxCmrLL24mbt1++rTpaoQDs0WDrmRsi3JxTZaoHycJ+LdFvHFnNnKDqecyNePxoMj8NLVheWDC6y/Q8kdn1uM+pVPg0bRBYo0Axr79hPN/ocgyL4R2tstnOBE=
Received: from BN9PR03CA0505.namprd03.prod.outlook.com (2603:10b6:408:130::30)
 by DM4PR12MB6445.namprd12.prod.outlook.com (2603:10b6:8:bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 13:27:13 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::a1) by BN9PR03CA0505.outlook.office365.com
 (2603:10b6:408:130::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 13:27:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.24 via Frontend Transport; Mon, 13 Mar 2023 13:27:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Mar
 2023 08:27:13 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Mar
 2023 08:27:12 -0500
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 13 Mar 2023 08:27:04 -0500
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
        <baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <okaya@kernel.org>, <harpreet.anand@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <pieter.jansen-van-vuuren@amd.com>, <pablo.cascon@amd.com>,
        <git@amd.com>, Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v10 3/7] dt-bindings: bus: add CDX bus controller for versal net
Date:   Mon, 13 Mar 2023 18:56:32 +0530
Message-ID: <20230313132636.31850-4-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230313132636.31850-1-nipun.gupta@amd.com>
References: <20230313132636.31850-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT014:EE_|DM4PR12MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: 4375809d-eafb-4430-9117-08db23c6a83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WBLtx54QX87xY4yJWAeogpPMM+0BT6Gdvc/3KAQyWPv/EqgLIbVSRxT93wF1NoL0iC9Pve1Wyiqhfc3inSLrPC7XrJL7lcMGMc9vWo2xyXjZxXgZdKugqFqhETJDRePnug4DujNH3ro8PZQmhJatGesfaGA2su+wiaIc/3ZMG2eEKmoGE12RhL1QNwsISxDsxd1J/GCbCqVl1/fziQlYICsZurBU5KUv1GhcIaARqRjlTu8cw4J+cS2YEvlI72kTEakQAKgJRskVEgVTSW+Nf2OwSRWpKxtXqurA2gA2AJ+/VpZibB8oVNt9hKXE/v3ud8KECyrhZYmGjUmgvRKygCJXmIzHqIctiIaSuM8N7mXLCvkG7FGSqT7wfJ8aZXaeV/T4hx0qc6SVgtzE2QyucRVGVBWYKPF6KSC3JJ3dyMPGCei+SzB8yAYzRn2vko5Guv5fDy4YA+j7dbEJIR5gv7jpMzTNuAutdsirjO9FWqMUu8Trvh1Ubbwq+yrKgcvtesDel2/RXWBIlxavjHnNqRRAbFSn2rmTrCMXcGfkADlY/Uk7G+VSv3s+CiPIjdt/zv+w3OXOfOG7VQygfWH0piXOgNZ1IYmFRFr+7Pu6FRiow74Yu+ardoCiZhb2uLrkimJRcVr23WuolR0VYxpNDcuSkQzqo1b05vzfoqTMr2smUD41AWiKna7N/Pnn3wcRV04T0CwosBLystlkLpIXYw5J2mxufCyGIC1Qq/FuO0BEysIJv6Uc2TGlFqPAA1JTHuh/64HEXpMcGiy6eps6guhW2D3OVvL6sbMIxWq8qUpG+BLxdV0Cg/b+KAj8BZyC
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199018)(40470700004)(46966006)(36840700001)(82740400003)(426003)(36860700001)(82310400005)(356005)(921005)(2906002)(70206006)(41300700001)(8676002)(70586007)(40480700001)(40460700003)(4326008)(478600001)(316002)(36756003)(86362001)(54906003)(110136005)(81166007)(966005)(47076005)(5660300002)(44832011)(26005)(2616005)(336012)(186003)(7416002)(7406005)(1076003)(6666004)(8936002)(83380400001)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 13:27:13.5757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4375809d-eafb-4430-9117-08db23c6a83e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6445
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 16b42c22902b..82b2c5534e1f 100644
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

