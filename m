Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E02669AC72
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjBQN3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjBQN3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:29:15 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D3468AEC;
        Fri, 17 Feb 2023 05:29:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hauRPjsqvU27ko9lORRtDihK1O0MMuwKXMhIZGXqjx/VTXHs60PHLJHT7C5TFHM1egjmr/4lRpKU702ggGClcKSttvDuPFrny7Elz3Dg8DTnqanc03lIEiVAoMGuN6RRP32BsTxDdvP0bh+ffFOYD3tdmkBKFhJlv+heKEwGS3emCPocHb5xbKPKCTCaIsy8OHl+W8GjnD4+7bTFKh2nPkJxkVTSgocdmI4ebK9e58XNJ2n2IhwiXuu6EtFBIBItXYoxA1Gn7/5bVpiZ6rzOTn/3FMWrqhluQ+xsYsT/NXE0LiIKnlEUwxWGBTMK8EKtZTl3X5eXe4rQVyMjcc408w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRNPO1mLwjhHrRMeoEbgCddCDSIEF/4zeqS8Ei2fE3Q=;
 b=ZnbMu4UixRAVSSTQeJD5S0u1x56Wep0MX8e87dLEcIUf4ZOdSTdX3MNIcnDIceCEPNju2mXhnXfcoE9d7wQSWaYA0xqZYihB+jWkiObBjdeV7cKHxEA/3Vx1wkJ1C7/Es5gYGlKvUH1XjtLhGOhUdUYvKwiM37sv5RNuq1ge7faoRUATsth4NPNa6Hm3woS4GkDC02iPAHgrCaZMUNZ5eOU/AZF8JViZtxWc5UBoD5BgZdHlOphGws2kmuSqBGkW/ifGMAJPdpjN87QOeqJOPInM282WIxE8JJjB35VTcC6Ss2Ik+yYsWijAVJfkYNDbnA3gOb9uxdV0zwCsomCI1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRNPO1mLwjhHrRMeoEbgCddCDSIEF/4zeqS8Ei2fE3Q=;
 b=1DDBVfydieHaAyg4yFjlEeJE5fJyA9kUl3ordI564K+0vcuB+DGbjo2xxLLCY2YFAs1eTn+iqUEnxWdhEZmf0cYXI2EM3WLZZzP4XIkPlyo6bD2jO88K1aWFXtaRRWtIfRfbr2WbwjmD8OnZTvY8HRaqpqKfR8+7j3lhTNThsJU=
Received: from DS7PR03CA0009.namprd03.prod.outlook.com (2603:10b6:5:3b8::14)
 by BN9PR12MB5100.namprd12.prod.outlook.com (2603:10b6:408:119::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Fri, 17 Feb
 2023 13:29:00 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::1d) by DS7PR03CA0009.outlook.office365.com
 (2603:10b6:5:3b8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15 via Frontend
 Transport; Fri, 17 Feb 2023 13:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.17 via Frontend Transport; Fri, 17 Feb 2023 13:28:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Feb
 2023 07:28:58 -0600
Received: from xhdipdslab49.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 17 Feb 2023 07:28:50 -0600
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
Subject: [PATCH v8 2/7] iommu/arm-smmu-v3: support ops registration for CDX bus
Date:   Fri, 17 Feb 2023 18:58:25 +0530
Message-ID: <20230217132830.3140439-3-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230217132830.3140439-1-nipun.gupta@amd.com>
References: <20230217132830.3140439-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|BN9PR12MB5100:EE_
X-MS-Office365-Filtering-Correlation-Id: b4234b94-ffd1-4f91-c014-08db10eaeda9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LghRv9L7kHJX0TfqDgdZQBOWSy6FgVu7Apv78Xp48sE36mdzYZbCuJvNkBaHbkd1Oxd3PIxrF65f9/2+66JfGVPGQLk/DMqMDVs//6tjeH/yhJRWsRKjHQc7rtY4myrVfbLMGSjVaXH3FwIIGkDW9jyrFH5RREQmGnS2sz1LdVW2XxVKEnDwzaT9XcMXru0gmyfdIiMBOSw2bv9Jkw42oC6aQTyNfC1bdZifWRS5E1OH4VPAi+kQkJzCBHnXCRCnZ7921113Tpf6zlaPznLO3R+mYW90d5p1C+o2ErkHGyThyyBinemzCEkAL6EcRHyukll1aoEJLdtnXMicE3a3/VwzY34zBivv8p8SFfSYqlagfi+Pbry/TAIls1IyMkG0d4i2h+EbHb3y1/hm3/UUvllYiQdKe1+DuupVHzBkekvk9ZPCuHrOjYu+HThKJEPgOpBc6SyU+9Df+hlh0OqzpnVjNg5LsepWxFTi7NezLCDzI9gBCGOD8I64UixX312sLa37lyGXyXK/L1TOqorcUUElUd/b+d8U6PvQrRQDzHmPLtnaJf9TEyD5rWUK+p8j8OM0oNqbrWZmJcD1LhITnQt0phpNiW5p7oAyIitZ/ESLoEXmWsj3Xe6keWcLY9aEhgUdboGnW+/wj4imfzQQAdTLt6eh2pjz4CG9BG2XS9Vul4SQ+Dnx1/sxBmnhiyxYprUsfXgr0NU4IZ0cjYIiVWYfnEUWt7go3OfxYoTrluobRrZmAxI6qka9eB5+aWzARZl1DAEjkZph+K83Jz+GiJCiPLwNoHMOTJRCY2arm74=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199018)(36840700001)(46966006)(40470700004)(81166007)(8676002)(921005)(4326008)(356005)(82740400003)(41300700001)(70586007)(70206006)(426003)(316002)(8936002)(47076005)(54906003)(44832011)(7416002)(36860700001)(4744005)(110136005)(5660300002)(2616005)(336012)(82310400005)(40460700003)(6666004)(26005)(40480700001)(86362001)(186003)(36756003)(2906002)(478600001)(1076003)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 13:28:59.7836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4234b94-ffd1-4f91-c014-08db10eaeda9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5100
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With new CDX bus supported for AMD FPGA devices on ARM
platform, the bus requires registration for the SMMU v3
driver.

Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
---
 drivers/iommu/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1fbe53354532..c2ff7754a4b3 100644
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
2.25.1

