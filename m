Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BA266DF17
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjAQNmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjAQNmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:42:13 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D0232534;
        Tue, 17 Jan 2023 05:42:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnpBmC8xvPLD9tveeYh/Vh6WaqE69Sn2NMEM5Xy/ip7iQzsBXEDIPf2Gg2Njl8Z6pMVRmFbUweb9Bw1nbQuIJebJYNssr7jFkGZcrvS9JGKCc4V0iNrsmI5le/9VscADr6c0Z3wrHeL/yAraLC32nt9QN2E0YGy5UuDhHC8B3QXaFcK3O0Fh2h3SBK39zNErMUzDGJqbt77yzc9g5SfSFLyYg/yG7sX5jgHJsn8ukkLwmwoVmfFGM6DqRpD+9gIPeI0bVsTbfNmTTLklwEo3HvrvbsPtz2Q9k0PfIxYRU7/beqrw30m0tn2fdV5dlMmMfsKORlEHUq9Ep1WZTlwd7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEOwb8fEvg1k9YeUg/v38So2HvgO1aLYV6V6pVrSsYc=;
 b=nGfafrZqYLDvcu3P/278xVisF8hukURyegvM2dsgn+PhSgiTFXfsOw54EYjuxULouI6zNgU2GkURAJvrANpBrbEyfqraqNk3sGNVd+JZwkyXPw9TEJTKKRC/XMuOWNkDcU2xdlPJE5dDOlrtrRJuCFj9n0hWp1ypl34D16K8oFOXuzw92vXqZHL8WgzC8UHYYNEfuDDicJc/EIoGvSjrhQMRCciII8tEpvk3R518lFkVuFZ6cVofFRkZEpLydMRO8yrfVI7QJLxr5ydDqTx6XUODv8zqLZKQcCi52OcLfDV7Qd5wcgFR5tQn8h3uX1ZVjNiYRraglfbIS2J4IzrJnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEOwb8fEvg1k9YeUg/v38So2HvgO1aLYV6V6pVrSsYc=;
 b=kTGzgGiQoP76jlkjAGXy9n/3ejH4y3YqqeAAKiPYOcZCIOO7iGp2s4eKJaB/oP+dAsemo28UlwZ9Bvy++kl1pXuHDaDd1MsbrCPOzBCfJTHIkFKGTlbZTEHFTY0imCqFgdT5XlJDhGEgNvC7kdUyzFRyFwKCJ0h4awHRDEVfDvM=
Received: from DS7PR03CA0287.namprd03.prod.outlook.com (2603:10b6:5:3ad::22)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 13:42:10 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::b6) by DS7PR03CA0287.outlook.office365.com
 (2603:10b6:5:3ad::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Tue, 17 Jan 2023 13:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Tue, 17 Jan 2023 13:42:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 07:42:09 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 07:42:08 -0600
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 17 Jan 2023 07:42:01 -0600
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
Subject: [PATCH 02/19] iommu/arm-smmu-v3: support ops registration for CDX bus
Date:   Tue, 17 Jan 2023 19:11:34 +0530
Message-ID: <20230117134139.1298-3-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230117134139.1298-1-nipun.gupta@amd.com>
References: <20230117134139.1298-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: 469a86a5-c114-4d62-792c-08daf890a1ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 650N4iaDm5bf90rZFrfpaoKCrvdceTqmvVS56nyd2QyGkggg+cls8DJjwoOmIY5Abtz7R1nKXr8Y6H3K7gvk+S41lH0eWUkNjUOKofV0CIBelhmliPD9tejSainNcVJS472txMvKZs3jtRx9Rx55i+RaKgGc54JspYkYWv61dQ8pIBMmvZ9qp49nGSHO5HpaC0ULLgIiQfDrViQdF3agRrJ+GwcBWiSGhl+xQ+84YbNl4JqOycms/UNsATUi/rv75DzTkBHYuNsO/POcui+6y188iJBdlafY3hAYsxmD0Dikww9GVUigdlS5xaTkw4iOJDJqGZuLEyf28YkGN+ZWnXaE6wGiQn3YXsM0zwJ/LbXu+TtfRRWlxX2z5PjTdQG0bZRIwvu6Plrd3bQWtrLt56BfvtR3TEWq2Z6S4F7ld2ET2t8q/Tgp/ZL0h2ocG4CLkoQkFQtrUkRiIfMmRy3EqCTYeIE70r4obrpw4NxXnDmta0hFxU1HGS9VMNUaJqIHTGHMC78MnznvHYZYctOMSc0tLXxTZ+UY/2dblw3qYclH9rQrYzrFhSt60ebJB+IhjrOzkMZ6H8AtuxU+D4S2zkXJSdRqDX64Ll51zsxGIMcaKmT4obC6tv1ge/7RX9Nq1e1YgASxpOF9RLSQzuS1H6+2IjLhaPEiMCgZQK3M/zmRSaiI2NX1vxMsODuhqlm+OZiJCgnFrX8A+KArTBQqvgHfV4lg+2SmhFKfs+m7C9eZ8N7Dhl7m71YvD/7MmaZ+5zGzzN65eDSrS5hoEmLm6HTKbKVoP1zioY9YIRRPHVU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199015)(46966006)(36840700001)(40470700004)(4744005)(44832011)(2906002)(5660300002)(41300700001)(356005)(7416002)(82310400005)(6666004)(70206006)(40460700003)(70586007)(8676002)(4326008)(8936002)(36860700001)(36756003)(40480700001)(54906003)(921005)(110136005)(81166007)(82740400003)(86362001)(47076005)(186003)(2616005)(1076003)(316002)(336012)(426003)(478600001)(26005)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 13:42:09.8738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 469a86a5-c114-4d62-792c-08daf890a1ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 834e6ecf3e51..6a28ef25f337 100644
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

