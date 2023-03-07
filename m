Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865466AE04B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjCGNVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjCGNUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:20:37 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3E653722;
        Tue,  7 Mar 2023 05:19:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1R4Z1ZrSo9uEe2ob3AwUcExMBb+ouydXVUjba4226VkPkG24yH/7MiI0SI8SwkUVY38KgB4r6bASYjoWrV8SWxyFwJLndZKrrTXgEjp5S2N9pgpDq93aaJZMJ4F1pjN0IgMtYrpQwuatMSXewOUlIaRsgsJOBIaHvgSt9sG/aw6jsMnRzaGF3+/jUGiMHz0fmaotDJn1PuM6t5ETsKt7FO86/H2X1MbLNsQRxqYcnA4gvw/cayCBGpREZKppDC9n1XsWLK4k2hUQirY9BIpzUrzz4SMCO00z94LRhzWZPFu6w266QDTQcfXJodnvNJPD0INOZUsmYKvvg+uA+TBaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPn3ajlLaDUqkZ14d3pihUrvQNKiBdpTaSADyLGU+bc=;
 b=DBoAoP5rGHpArpmzXDDNd4UFu7EiG7PvHow+HA0rZud+FYTqXRxcWeUIP8RteUkaQ+0J1ImRCGjvM12+9qK32XFQWhvxh3seGPwrzj5kqjrr4MoXfhaEAOhIG5afFEnDXaab7U59Ffo+g9AjQ22OmcyI71ifO9iajlVmI7YkHjV5TSqvduG/9erax9mNnmMXvSun4C1XsYynUJGY8x2irlFOW0ZAJc2ijHHGs2u5pQthK1N/jcJ5mgzfPHVSdkq8sEGaRYtRmWOr4P4KdZryNrwb05f6xfJwSo8lAeZeL903MOE5Y8drzlr+j5bV5Y9AzootesSN2F1D3FOXbkNq/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPn3ajlLaDUqkZ14d3pihUrvQNKiBdpTaSADyLGU+bc=;
 b=eKyCNVVEbNQi6dg02t3MMoCDzUlGhH8KV+TuxSzONcYAizQJVVPwyOlcNCZmKlsZPEE2YQLbjeoj8CXbcBydEzJzk+Liw6VPa238PmrCEGArDdEWI7B6tH1uexTrflRLDjPIADHo9ZIWwkDvgrB4oolEQpujk5ytcUgv5yMvoXA=
Received: from DS7PR05CA0065.namprd05.prod.outlook.com (2603:10b6:8:57::10) by
 DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28; Tue, 7 Mar 2023 13:19:45 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::48) by DS7PR05CA0065.outlook.office365.com
 (2603:10b6:8:57::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16 via Frontend
 Transport; Tue, 7 Mar 2023 13:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.18 via Frontend Transport; Tue, 7 Mar 2023 13:19:44 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 07:19:44 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 05:19:43 -0800
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 7 Mar 2023 07:19:35 -0600
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
Subject: [PATCH v9 2/7] iommu: Support ops registration for CDX bus
Date:   Tue, 7 Mar 2023 18:49:12 +0530
Message-ID: <20230307131917.30605-3-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230307131917.30605-1-nipun.gupta@amd.com>
References: <20230307131917.30605-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT017:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d538a6f-f453-4b6c-13df-08db1f0e9e52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p5iTXGDRte6T0r2z7nMcVFXn35fOqIEfPOekFEep4m71dVpevmm5WGQTYnyD12WfU266sjV7QdMlioypqIbwMm7CdYXEC5vnDNPphSL0yCDn6KzDVOv72JCdITyUz8eOEl4hACfPzysQZHcSWJU7zk8zcWxuWqTC1W4igBsX5G+ioBwID98nWSkrrdZYTN3UsHid07/6fSlGNtC0+NpzzrJnYAL5Ip5Cei6t77H/tkn0Bee7tDwGiIaMkJr3yx2yKIJ725p3r3Gfycz9D+UTgtFnqzVMoXV4WkYHRQ42MeqRmGhA+IQLyGcVlNqHpGrfO42N3oIxQg4Vv6TJtFgsX9tyIZ5hHSOuQo6+pfJFT4GC5apAc9XVsUkS+EjHpgpGQLRoSYxCcnsrad8/n/DSErJ7C6WV0gqzFvZzPZKB+NknxI7C3vugwc7udSuiIeOVKKXZ8OSxzSdP8y1fTp9A4jnwPoNaJ6qVwT56QLfc0sCQKsIsDtf8hE/AQECXq19gS9cxyJwBuKKIalOOUzPagWV/vLtEe3j+fxBBUDpfeONo8mVtxrq17kcpFqOjHv/diiF7wNOjkbbOkXFteI8mSnb6DDz1nJ+onq9k+4LJVO1YOGZLe5hOW/7R9JAhwXn2zVdmb6TCBpHiyLDEy8HtWj9rkNXHQ2Ql5YWXQXHkQ7OvhnwDYix44y0Vy2l0LL1ZnfcurcgUkGs62Hb7NvM3494JNjsiEgcdsd0/vqi0GDMbUq/pElKSPIq15uEMUkiX1OHAsIAWga9K09Bu+mKj/QL/bR2ZfA6zHDrWaO18HvQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199018)(40470700004)(36840700001)(46966006)(41300700001)(336012)(47076005)(426003)(2616005)(356005)(1076003)(921005)(36860700001)(81166007)(186003)(82740400003)(26005)(82310400005)(110136005)(316002)(478600001)(4326008)(8676002)(40460700003)(70206006)(36756003)(70586007)(86362001)(54906003)(6666004)(40480700001)(2906002)(4744005)(44832011)(5660300002)(7416002)(8936002)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 13:19:44.8458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d538a6f-f453-4b6c-13df-08db1f0e9e52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With new CDX bus supported for AMD FPGA devices on ARM
platform, the bus requires registration for the SMMU v3
driver.

Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
---
 drivers/iommu/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 10db680acaed..0025a631b8e1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -28,6 +28,7 @@
 #include <linux/fsl/mc.h>
 #include <linux/module.h>
 #include <linux/cc_platform.h>
+#include <linux/cdx/cdx_bus.h>
 #include <trace/events/iommu.h>
 #include <linux/sched/mm.h>
 #include <linux/msi.h>
@@ -129,6 +130,9 @@ static struct bus_type * const iommu_buses[] = {
 #ifdef CONFIG_TEGRA_HOST1X_CONTEXT_BUS
 	&host1x_context_device_bus_type,
 #endif
+#ifdef CONFIG_CDX_BUS
+	&cdx_bus_type,
+#endif
 };
 
 /*
-- 
2.17.1

