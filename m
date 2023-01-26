Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B3567C8ED
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbjAZKrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236600AbjAZKrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:47:02 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A4D5C0C4;
        Thu, 26 Jan 2023 02:47:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMcQtLIhQgmEc4aenYeTsy3nSsyXEiUZNUz2b5Bila6mFYZQspzzyRhvp0c1xdncV9BSRjomc88CMqQWOsWac6z3ii9ntY5f3vNF72JUMB2O5HO+RZ0AvI/VkCTr/slReedgKT++Ov4XtrMRpYWsqthb65guwDTw/5i9awHgIE2jbwGSgEUX9+so1wtE4NZxe5ng55VsiREoVqmeYM2TE5gA0LpLuCJGpAHbWe/Kk6ITLfu+FjvJlkQbvxHMfjMsQGGUkulA2t/6vwu1TGR4S7jls6tLe4Ec6lOpl11sS60Yeerp5rH1CPwxJGVco4aHzJatyKKzL8kbfaCBiVamog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlzPuLLEbAhqgEFXXJ/7oWPWefwjMBa7kw3LTlPetdA=;
 b=bVoQYEcOancPw8lx8SY6vAuqb2bxJzmNIZmo05I9VKrjPrdWjgr+ap3dLSFOiU2o/41F9k1JjF0t9FgTBu3i6oCuI0P4oLKDykddJEU5p+OI9IUR7GujQpwfmmiElnsAjkTjFnN2pW8qBq6rRnpJXwae2IXLxfQF7VroTSWC/b9O7HxHefD0ITEXEoIJ+EuVDRzRbbasK1MRhTG8TVffL98C47Y0H+fC3bsrOBLtFpVyucsVFqKnmBvl/QZxMkhi++4Tmt+gQrj7wWnoI8tfDGOzn6u4sRIT/nYTlLFrYRpGP4iEprPQpoB0OEYdJ+R/D5ZXfvdvpbDhNeJm6/Izpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlzPuLLEbAhqgEFXXJ/7oWPWefwjMBa7kw3LTlPetdA=;
 b=2L19KBLOuFA4cZTCUO7YtgKe8OObKoY4Kdf6z5a/yAv35R2boPzbFYhilUJWqwvRMGSIs0dwAIVA1xs5IOEzmkveLLP12Na6V7oXT9rBAgf48LvgEXwege4dLS6oSt/C6Lv6qvpACaAsWrBWBqbb7+ajusOK0HHhacDQevbFwBU=
Received: from DM6PR08CA0064.namprd08.prod.outlook.com (2603:10b6:5:1e0::38)
 by CH0PR12MB5219.namprd12.prod.outlook.com (2603:10b6:610:d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 10:46:56 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::74) by DM6PR08CA0064.outlook.office365.com
 (2603:10b6:5:1e0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17 via Frontend
 Transport; Thu, 26 Jan 2023 10:46:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.22 via Frontend Transport; Thu, 26 Jan 2023 10:46:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 04:46:55 -0600
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 26 Jan 2023 04:46:47 -0600
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
Subject: [PATCH v6 2/7] iommu/arm-smmu-v3: support ops registration for CDX bus
Date:   Thu, 26 Jan 2023 16:16:25 +0530
Message-ID: <20230126104630.15493-3-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230126104630.15493-1-nipun.gupta@amd.com>
References: <20230126104630.15493-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|CH0PR12MB5219:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e95d0ef-18b9-4bbb-d806-08daff8aa522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6PJrJQpnPTmbm35QR+KPaisuJ436XcQASHQd1TzklXD7p3nHztyhUlAA60tKWTGxFJk03CHGpkOw0zd97AgqHFRWw6fQR6TKI3kh3XcOanCZsOgTqDyceqq1DLznBie3UhygKZ2NPLI0IVmVaTY4ndbmk8KySZXnZSEqvid8K4FYt31s1qE5reXEMovNKP0CEf4O/TUoUECSBljpZw3e7f9+MHl1wUWeRaE9sLn43DLAmm7jwsMzRFXhTRHmFwqDDQTB1YUQyXBeKoKx0jFzdghtlqGo8IaCt3f2/qibF3yIMOjmSYYXDXz4xt6ZpWWsxsBVApt9q/ujbb4cie22IUY5SbCbGEc1PQmI0UkaxiuKfDSnzankt9V0TleM5vaDjAYfEEZi+RhxbJuYLBPtbxc5l4PQ3s3wFgRjGsxqBA5p3BaDC+Z80b8/3dI6To0mcVWRI/1l9V2UhUWtWV6PjW0s7RafbopNP2u7ehOz4//AfxPBVcB2c2vVhs67b32M5M2SNvAPshTmTKcSWw6jx448P4Sbtmi6DL9+IG+s+pemOM8Go27y9GBxrjVClsg3BsWBQKPnunLOtS2I9hFoRYQw20MsbUdmWt+wSYy+qHOEYIkM/POXT5Ze9Uj6e8DlPZiciV5fhDKCPRv8F+f4cvCr1HbnjtDJDQdw61KyypO0sLgiz1AirBBo5LGxwmYz/6tRuH4F2db4uU4IXUvSfHWSbqX19zY8W9Ue3ZSwC7Djb4fTUq82qf/4f/IA+VgjlXh5kaQ4CPa2TQhsKaPPPDRtdxMHCScc4CICWYENdCg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199018)(46966006)(36840700001)(40470700004)(36756003)(40460700003)(336012)(8676002)(40480700001)(478600001)(316002)(110136005)(54906003)(6666004)(1076003)(44832011)(5660300002)(4744005)(7416002)(2906002)(4326008)(70586007)(70206006)(8936002)(41300700001)(82740400003)(921005)(36860700001)(356005)(81166007)(82310400005)(26005)(426003)(2616005)(86362001)(186003)(47076005)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 10:46:56.6659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e95d0ef-18b9-4bbb-d806-08daff8aa522
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5219
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
---
 drivers/iommu/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e3e401da53c6..4e8f2051a9b7 100644
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

