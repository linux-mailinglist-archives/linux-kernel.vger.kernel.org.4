Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4A8682745
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjAaIrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjAaIqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:46:38 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01CE4B774;
        Tue, 31 Jan 2023 00:42:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTAxcNx9s3a8Gt5vnJBcbXWn29XS+DllR9DR33A59f6yMXQsMviaFjsnjVoemvdbC8D1154SP+MsZVXDqIwnU1+WRQ+JA7js/FPaKX/m27XoxUsybniFwvwxHVgQ/bu1T94DyV3KVqYI6sq/7+vURS5HAlfbFCf3lcYKROl4ajyMi2J/ZghgFeDnuhzV7iHelyl8ueesxSFRmmosOEdOCssdB/mWoVX/B3p22xsKOm9cS7b6AaWZfG2MqscLTS+XToJ1IadsVS60RiKba9VWy8hY1l9RUqj39agZJTbSMZ2zlFjn3hXkHmP/oV7928Me75b4S4hJDg0j6HhCkFlLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlzPuLLEbAhqgEFXXJ/7oWPWefwjMBa7kw3LTlPetdA=;
 b=HcAOUU0bxKY4QV5xkvxJXEIt89KzjAS8sYIVTnKplT2Q21dmdPHTCEQhp+/rd6jY9ST2Y8RQuaEvEh0JamzFveFhcMx0A8Z7JrOjXThfUABgXR4Zurs1UollaTmr6Q6JQqcsgosKiMMqy3frgyMpBrvFn4lj6WiSVqqSIvFSDL7rBJtJ4CHNijxbLiBgqoafoetEqesexV5hNmkpubmeF7EsCFFmbsQttgcIV+BbdwF0YKj6TKKc3xFcPh9nuVuFj+sP9BhrqRXq+M9jsmtRIfO+ptrAxgqiSmwiO5K7e1tcXG22zyZ77UZJAU+1w6k/jbbOup31ecwrAaN2a8K3pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlzPuLLEbAhqgEFXXJ/7oWPWefwjMBa7kw3LTlPetdA=;
 b=nid3C4PTB4urEHIXa83UhPJNfwlbManswa4xd4aVGg3gKa88mb0q8JvBGVPVtSPkoiHly/8VU52G/USroqyLK+GceGdyvKlrpqP14s3nFlbVXJDmaWL6y3pYZ2RroauVbl4KuCDTs94sgDJVKwYvHbbpSs8bPcYZ37dAmeZsz4Y=
Received: from BN0PR04CA0002.namprd04.prod.outlook.com (2603:10b6:408:ee::7)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 08:41:21 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::73) by BN0PR04CA0002.outlook.office365.com
 (2603:10b6:408:ee::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 08:41:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.36 via Frontend Transport; Tue, 31 Jan 2023 08:41:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 02:41:15 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 02:41:14 -0600
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 31 Jan 2023 02:41:07 -0600
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
Subject: [PATCH v7 2/7] iommu/arm-smmu-v3: support ops registration for CDX bus
Date:   Tue, 31 Jan 2023 14:10:44 +0530
Message-ID: <20230131084049.23698-3-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230131084049.23698-1-nipun.gupta@amd.com>
References: <20230131084049.23698-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de066a6-8702-4665-12db-08db0366ed98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yrsj7Ls+RhphV3jjxEbX2vqHZNfEZbhK8TaPAta+N4DYAQ0X2QkCkZquwnAbpvuOasWkVOWutRHH1pk5uyUTCVAxW5udZSAlN4TaVWxz8z07HyAV7HQUrISIQXSL9e2QHHOmP/YGBJ7+22OehXiQqquYw/LrTz7jQH/BJN6vd2HRRkPi3xOlD6LQyYIUecHCY4vQemy8wlrgRJDFX1/QJiEpNQdCpL8xuCbUFjhPozBVX92AhPQiiy7gAzsiMfhJ567Kmoa5adiL3oA4iBj4EuyfY7pKVFtD765tcxUT/F5bwONjJuzoOdjWRV1atsDeRQlab4z35QmFOhBXZaXiB0/JKh2dpu7Fa6KPcI7ksOugfQihoIiyMgq9bFn9FSrf0U4fQQ2qBj74pEhZnEDkjLXfhxPUjJRseKPO34xTG7cWJ0TQGEDQVxAIdR7jg68GBr8DBEaCu2SWtixq9qyyvHTZwzQhTdTlJwB2yvU94A7eZpwwP3yVmdJQ1ftkoJUNH9OK2ybR744k/oO7OPzYOqYtOCotck93GbTooye3bG7EUdnA1ixA1Hew/56NZmIqhr7/v1m9SAEztGndNGH9lgs74nNN96JCeSeWrwir65eYFoQ9zlJiABm0Ol2ALKFt/2tpTa61lF9EThiQNNsfFQWPAGvpVl9rcODJxb12UVJMo8woiHmaHw9rZAJVwp2U38ZT4Vs+zjoqNOAHxPFDXAyns+aV42SleRT/akbRirBj0HGCzHkoidfsoCmZ74wpm2eS8cAJVW0gqLMbSvULkGQ9H+XdDA3xVD5xDQDWx2E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199018)(40470700004)(36840700001)(46966006)(478600001)(1076003)(6666004)(82740400003)(2906002)(4326008)(40460700003)(36860700001)(70586007)(86362001)(186003)(26005)(8676002)(54906003)(82310400005)(316002)(110136005)(7416002)(5660300002)(41300700001)(8936002)(70206006)(81166007)(4744005)(47076005)(36756003)(2616005)(336012)(921005)(356005)(40480700001)(44832011)(426003)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 08:41:21.0302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de066a6-8702-4665-12db-08db0366ed98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233
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

