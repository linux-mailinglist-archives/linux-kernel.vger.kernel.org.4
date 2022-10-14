Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4B65FEDD7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 14:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiJNMLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 08:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiJNMLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 08:11:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DB41B76E7;
        Fri, 14 Oct 2022 05:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMYTBM9tt4LGzPZmocwq92lW9mTxhsJlC4XDm2kRJOoctIccvtS2vnzmy0hQzxQPmxY1j/VGFgSSAMaSBabkLw7f0S1o2Pvrxz7/lKCIgisjwREtGR6f03C1SFn6vWxD/Al41NvMcpLe9DNFev11Dr34SEplL2DxhCcB7Goow+cslrSqHhF5CkXoKoiCG6vbRnqP/WYzw6ZUebs1o2M7YexFyNyu6CvzSyZMF1XIV/t+EP53QimZ+v320N9LrGH2tgUYGbF4BId8TL5QDs+PdzPshe+5SRyPr2TVomHyr28i1KA8pZgtlKfb90N9/iTQHALjDLdzRCyoPYqKwhAiSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+YIXYcSMDaRJ+dsRDesqTDguOFFPTSNn4DHA31WySY=;
 b=ar8wanz7HbPirb28T+JricIa8wLL4h8wO2Q8MealKtXWUHwA+dkB5EbpARDjOQgK6577yaBY8/QFINBlAn65W9W5qdNHcL47+X0T/epx4tQThNF6EoWybbRstGPBCstvwyg6mlBRgxX9eisnJSvNrqjEPnfAkMHL1429PbWOrGRqdg8NvCeiRedXNw9FrVEE1cLJuh/gzN7KunIUCZqCmz6ApO+rRObeoYJpN38vxIolNVK2675N/nHgBuo0Jy+IFv+PLSGmGBb0YCed8HwVAh0LNjrN47KvsQebkTMMllFSEDovTydZO0Per05+vSV1iBD+p7COA1BOGtQmFgao8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+YIXYcSMDaRJ+dsRDesqTDguOFFPTSNn4DHA31WySY=;
 b=hdXcGt5sP28YkCsrosIFkMvhHvFFl9z711QbGGoU3si1Y5FMyTimyeghcIEz5ZCUoeruFuL/K97Qv3ymaTN2b46f7KPDFknoR9KjvM55VVJxphhr/SR/zYLBLphLLJ/xT83C5pHm/NL4KzOWtIBdbf6FEGrNc/nkWjAoj5GkenI=
Received: from DM6PR07CA0078.namprd07.prod.outlook.com (2603:10b6:5:337::11)
 by CY5PR12MB6276.namprd12.prod.outlook.com (2603:10b6:930:f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 12:11:41 +0000
Received: from DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::78) by DM6PR07CA0078.outlook.office365.com
 (2603:10b6:5:337::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Fri, 14 Oct 2022 12:11:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT069.mail.protection.outlook.com (10.13.173.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Fri, 14 Oct 2022 12:11:41 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 14 Oct
 2022 07:11:39 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>, <linux-kernel@vger.kernel.org>
CC:     <Dell.Client.Kernel@dell.com>,
        Julius Brockmann <mail@juliusbrockmann.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH] ACPI: x86: Add another system to quirk list for forcing StorageD3Enable
Date:   Fri, 14 Oct 2022 07:11:36 -0500
Message-ID: <20221014121136.8677-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT069:EE_|CY5PR12MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f28717c-f896-4dee-d8a3-08daaddd40f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7Z3VX+nnucUbpmMEhgy+eEx0H6zAZ5i1koVVZP8+QtSnAb7wiN6SY5ZnulQEuoKY0Ic5MIO0R/+aqrlA89J7mDUWFbqPGBgU0l5O/wyHLHtCdUECyUvV0YMW/hcv89rbmUgJcfO7zEA6k7yG3LZfypxyGwrMm8AWVoercoOnhMs8BOdW/AA0BgVOkucTa/aBMptWJN72zS5gF0A2B5O7PCETr0LMt5RV0+/DSPLX6QCsIVvLV7/dBhRByGN3QxCCpEyNLFzNo3h9uQQIQ+QJ3OFcfp7cys0aZSLtKfHH7BmRTl0/3CcKDxiXZD1k9FWn9nnp68VDj4nrhks0hOz8D/NhIkM9RyDYTEeiLIfreTLXHYCNEnQrWOfFioxLnL/tyemmwflGbzLSHV1s4RUqC5JnAvb2sByYVsuhh8rcMs6JZeyhQKZ4jQ3CNEtNUFB7TPjhXfO5uht+e0XOAozdIySQx5DZuqJ5GTgV1wg4pW3vnzGLCqzI6wfYRfUgOL0JCMqRli1TeZUDHjq2xFamDxVVjrufA1Y2ngKcNv6yXQVdWQ5Mhub3GQu6ebQ0/vwfFDf22qJFsD+n6o3CjjdWBFT7Z7Ior/X+3QWMDsWlxZtZdkTBKbDnOSFWjtZ0+SXG72lykXy9q+NJsC00PmHWkfx0pIqvK/V+ieiiIAu34RKyXtGyn1c335+s3zQOYDJGZnsWSozXnXJN0wYh2pf5bBQ3o4hXJxdpq49s8wAk4ozIEBZCyhzKZp2assb+App6NFQBGQVQqoH/EJBEd6Pi7ypWIZaxHBYnupDTXsqmsHWfeGYuP6a/uhfce28mQ6kwjVMPS5ENFo/jFsAEUUjuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(41300700001)(47076005)(426003)(26005)(8936002)(336012)(316002)(8676002)(70206006)(54906003)(186003)(1076003)(110136005)(40480700001)(2616005)(40460700003)(36756003)(16526019)(86362001)(82740400003)(4326008)(2906002)(44832011)(81166007)(966005)(70586007)(356005)(5660300002)(6666004)(7696005)(478600001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 12:11:41.4862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f28717c-f896-4dee-d8a3-08daaddd40f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6276
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 018d6711c26e4 ("ACPI: x86: Add a quirk for Dell Inspiron 14 2-in-1
for StorageD3Enable") introduced a quirk to allow a system with ambiguous
use of _ADR 0 to force StorageD3Enable.

Julius Brockmann reports that Inspiron 16 5625 suffers that same symptoms.
Add this other system to the list as well.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216440
Reported-and-tested-by: Julius Brockmann <mail@juliusbrockmann.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/utils.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index f8a2cbdc0ce2b..d7d3f1669d4c0 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -219,6 +219,12 @@ static const struct dmi_system_id force_storage_d3_dmi[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 14 7425 2-in-1"),
 		}
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 16 5625"),
+		}
+	},
 	{}
 };
 
-- 
2.34.1

