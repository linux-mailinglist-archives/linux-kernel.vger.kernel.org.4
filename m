Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F59E6B78E1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjCMN1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjCMN1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:27:09 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7A85DCB8;
        Mon, 13 Mar 2023 06:27:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpd1h/wLaw2Ztu2TslPZyyPYcyRjtcXA5Tmv+yXSkroiAOM3VK1qm+7sGRec3x0rr8XC1JLgUoEYsg1aNFS1qYAmFXsFHgl+ac7kcLDNN9Mzt7Rj2isncvv20L3E8fDJeBR8n6sbvOnY7An+Biu7c091VkkiA1lfCeIOiJAu2kDAClx2LzWODlHz7yvDj8xo01OUCGL84UBXpWs/35dNQEJh5XWlxqZRUmcm6ETqtIxDvh5IXqrIIQSWR2eCJ282JvdjWwwpOj9Nthre14RnouQiXapSPtQZz6YN+cCCgTMfkYNFcuWvD5FITdUvchbmguZwEUWECrm0fuxTLx54Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bawfmbjUf8mv7uFYwQZQIgp3u5GJIczB/3r47fNH35k=;
 b=RTrFJD/pbIN+EYnV7gGfn2oKUUTyCf3HaHFcvVFa+bCOG/f1PM+Ry3ycVVGMHVpm6EpEJ+JQl/b9yF/Vg42DPtBy+6NS7TilnDETmkCO1cM8eW8Y3dLDHckGuZ77V1d5lU9U8hGEb8CjmPYN1I2VgA/8PwcVhIi1DRvZcPAxUlZ7L1qJWsj5/RqPeoKvb8746ovtMSeIITSSVXfb04ENOghGyqEfWHgNokzg9HbXi9dMNud6IpnteoYjbK8/m7XaQkAdAI2sDIPNOSQiZ4PHxVcCfE4tuK7lG8EXvF/G47sISujVEW3GaD8o3wD875boSZ5vtWbhFBsRSRsylZcTdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bawfmbjUf8mv7uFYwQZQIgp3u5GJIczB/3r47fNH35k=;
 b=iXlZdqZDgzjqRubowPcpfbp3FF2UMYzzik3jjSMbXxuabr7FrsHkQ0cC/dN7QjT5n73DHG0mE1JCZB8q0ifJxZreJwz+a4Kf7ykOzzTlg7zedK6Ksn8dA4XUQ8h9mOkAum6/7Uz0a7V0P1+6LOHmTE23ngniyl0kW4IYBatYpjw=
Received: from BN0PR04CA0160.namprd04.prod.outlook.com (2603:10b6:408:eb::15)
 by IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 13:27:04 +0000
Received: from BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::56) by BN0PR04CA0160.outlook.office365.com
 (2603:10b6:408:eb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 13:27:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT112.mail.protection.outlook.com (10.13.176.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.24 via Frontend Transport; Mon, 13 Mar 2023 13:27:04 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Mar
 2023 08:27:04 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Mar
 2023 08:27:03 -0500
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 13 Mar 2023 08:26:55 -0500
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
Subject: [PATCH v10 2/7] iommu: Add iommu probe for CDX bus
Date:   Mon, 13 Mar 2023 18:56:31 +0530
Message-ID: <20230313132636.31850-3-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230313132636.31850-1-nipun.gupta@amd.com>
References: <20230313132636.31850-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT112:EE_|IA1PR12MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d7f8a2-bcdf-486f-a7ea-08db23c6a2db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CiXRp5KIQOdlc5DkTysRq3CdPnRGwhfQamKWGuKJS+NKgABIgLhfnVGSwJLD70ihaQMNb+LG+Q287WxLVLlWTp1PudAD1mG/38P179ur9sAKx3XUvHv2iCbJYc3KBvaLOpOIcP+ynbNrl2j34CZh3fZ9JwOf3CYTNt4ENmFF88ISpiaoiQsxGZaqLaaphzv/aJdxdkxOQAEUJ5AggOd/Kc+rIn2aPEQBmcQC/4QxCoHsI2sdxNQ2ToQJ/m6ZQPi1ifbM4zZqOyj2uG5fBWytAFhnsXsZ0NBv8KFT82uA/CH93ctJw0GcFC78eJuRHs2p49oZl24axGLIAgWvZ11+5P/wFLJJcnqLIC4i7HY3+7a0LKLyZDCqmjLy43fU6Phk1KqN7osynhfHNTnt4VucqZdCLZG+70IwJ0wu0BZRA8mtKC5IEc7ILPQ9ibkqEs3sBPzW5yAtcilPV+CTTeRW6+Wnvso2VNVa1BhjLT6WlEiQ+h49SvoTUzbba6OREHBiGtKejm6LxL/rmElaoPH6HSXbbX/WQV6QA9QoRH9eWy5WOdOU7aUY9S5Q//itFlgMkxHRj0YwRp8o2fm9NRiYAkNIVJdRRMQoU70pbp0HX18xNLOlORg/OwISj++9LOAOhDw3EX3wyH2IVtyjuHGZfe5NVatfnfTBnhTbdOhBu8btjiXbn2rO8zPPu/4MbYL5/2QSCzanxG+G755nvtOxniJ500pywPQQJss3KQXDvdOomtrDJOE7yIoPVSsFes2gqP3HAiNlUkIrubH7lCIw1BAnDB1+QqaY2CDXt4aOozs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(2906002)(6666004)(4744005)(26005)(1076003)(36756003)(44832011)(7406005)(5660300002)(40480700001)(186003)(86362001)(2616005)(41300700001)(921005)(4326008)(7416002)(8676002)(47076005)(356005)(70206006)(426003)(70586007)(336012)(40460700003)(8936002)(81166007)(82740400003)(110136005)(478600001)(316002)(36860700001)(54906003)(82310400005)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 13:27:04.5389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d7f8a2-bcdf-486f-a7ea-08db23c6a2db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CDX bus to iommu_buses so that IOMMU probe is called
for it.

Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
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

