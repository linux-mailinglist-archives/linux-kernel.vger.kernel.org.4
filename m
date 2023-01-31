Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC3468273A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjAaIqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjAaIpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:45:55 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3B34B1A8;
        Tue, 31 Jan 2023 00:41:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KE9H/uraEBi9TG9qAaPPBQf99YliY1KJHJOhHKdFI39KYMk7ZYBS2Rq9uWdQbyYRQiqgDE6Wo7ZBVVJa0vu232Gl6r13rv9wWYwqRGRyCKThhWnjtjbCIIo5ewwrWtfjHs+rzHCvaRL7bZ1C0cQXQb+aVDpRC/Sxl1JFbCbrxc8g3xXSwLczKZr4qIuzziYkz8fl4tKCPhYvbKoTDfmgu6pvcenupQcMdky1BY+0o/Duhwfjb9ma53BJAzxQXTfjEZzay0OMZD4RfpLan72pBGvoNWETXwfJECfU+rT/UJVexnB8RccyAyW6KejxPXSNHkTLzbYpRwtjiXHy97ag8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDysyl6J3R2f/k/yDOfJlNOZE2VLY7dUf9OR88bwy1o=;
 b=npPVvOD9Yj2jjm8Hh0xTpewEAo3P+AoTtjyy1/CMdrFpaSh4kFLlMhPmVi7ws5gyb3qqGXDRjfCJAu5VBP4k4qo/Z8TLZznu2J9ok0vxO0t4h0VXWqegs1HtN0JEZf36/k0CybgFPRem7k9c+Zq7P1n1CS++Kmj2pFJSguz6HUh2jLm/HKNp+plJFe8xZnQUhuebPlYsCjcRFHrzLFwnQAeXEDvfD5i4nqz0KjuGttCkvoFjw0pe7asjLHHoEu630LbtvYTE01feA8B40oRVtRQe02bIumlqLMDWt2ZTaljlJ8UbI6SEMbSEPk6Mg1Hn8JCJdawFYEzS0Niw40e7TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDysyl6J3R2f/k/yDOfJlNOZE2VLY7dUf9OR88bwy1o=;
 b=ZiwuOXs36naAU+oGuOdTAzhCrirybk3lqaQZPuboTMPA+hXE65D6GcycmvyHArO5jKAdygnqjJNtSUo2DgU18ty+X3I/jE1lP5mUdZtGPrhHGPt3hYqW3szRxPyRn5L0d/I+TRfhdwXgjGjGRNNTQPJPsPGxFFOfYE52YqTEceQ=
Received: from BN8PR16CA0024.namprd16.prod.outlook.com (2603:10b6:408:4c::37)
 by CY8PR12MB8068.namprd12.prod.outlook.com (2603:10b6:930:75::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 08:41:24 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::fb) by BN8PR16CA0024.outlook.office365.com
 (2603:10b6:408:4c::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Tue, 31 Jan 2023 08:41:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.38 via Frontend Transport; Tue, 31 Jan 2023 08:41:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 02:41:24 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 02:41:23 -0600
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 31 Jan 2023 02:41:15 -0600
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
Subject: [PATCH v7 3/7] dt-bindings: bus: add CDX bus controller for versal net
Date:   Tue, 31 Jan 2023 14:10:45 +0530
Message-ID: <20230131084049.23698-4-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230131084049.23698-1-nipun.gupta@amd.com>
References: <20230131084049.23698-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT060:EE_|CY8PR12MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cde77a3-6f19-4f79-9b50-08db0366ef90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E6asuu86Obv1iwzWTNWaNi70vNtr0DPjH2M1YBWWYbw5Uyp/GJaSVUu7WbcnmmNbqxcmPSw7FMWzAgQOA6yTiUtZ5pyYqfs5ynvPCWuMT0OUs/Hu8ivu4SWpwNZaDDZkxnTpFvZ/QA1ZXSjnu7XPmVnTvGIXPiJ1hFtHDEsPnaNuhMg+mHE/gU+dtctebPciLoytkt1rt9g8Joy+eJ5pwL6hfvNMmf5Ez3Fs/RJt5ITxrBvmDpnsZVid9DL70iIxwAjK6thUCMxPqIXvMhoqedw9STL+owsCU91znPf1KTzEMfif7DUyVu1cDjQukBf78IzwRSso2gJh/nKfuKA91ZYKtbcyrNU7VHu5/EE6ifMLUgm+mFIE8eD2t8o9Oo8AnRH7RCX2SWUlWfaE94f9XBPff9X+4SBInyuIVF0vMF4xgI/0r5l6hjXltVF/iV7Spdlx72+wtI0MI+umFTMcTxxTwBPgslcQQHd/bXylj2cnqBBv0Fr0UQiAZpNx15ZrcurqIdjFeoPYMpL/hf1YwjRDY3si17xAsTGHytDVoNKnTYBcmW6adJW00qetgNU+TpHBamMnR4Aiee1TmF7ojIDnoQlkKLBV1oMS4Gw2F0bmpXET/8cX8G6V8HYtpEuuVV/qhGxqhRED9V6teLfyPQviWREnoYd8docBcBzquPJz0Z+0qAfgx6SVuT6aHH0uzHijMxky/r8tvDPrCYkIiSKqyqg+XKFbw/jBJFhn6XwtH/Fv6i49LDfZIKstNqlwFR6zKHN5TjhnzRAVR51hF571I8EOcI+ZvnIjILGWiq18QuBiTFzPSUbue2yKjBhP+wdvHlqmrtQmI9Xz+NwVMpL1XRPXbydmP0bJHRgoM8vRzUhrRvrg4cbCdjfag5IT
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199018)(36840700001)(46966006)(40470700004)(47076005)(70206006)(8676002)(4326008)(36860700001)(41300700001)(70586007)(8936002)(426003)(336012)(83380400001)(478600001)(86362001)(2906002)(316002)(82740400003)(6666004)(40480700001)(82310400005)(1076003)(81166007)(5660300002)(44832011)(921005)(356005)(186003)(26005)(966005)(36756003)(110136005)(2616005)(40460700003)(54906003)(7416002)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 08:41:24.3211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cde77a3-6f19-4f79-9b50-08db0366ef90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8068
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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

