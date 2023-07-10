Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AB374DD81
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjGJSkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjGJSj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:39:58 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC34FAB;
        Mon, 10 Jul 2023 11:39:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIawtq1rmHC+/MaOvlzAqh3sC/vx4299NrtfluNboqKTd46mRH4xCWYX8+U1Bw4byqwMkphiY2gHJGXUkCR0QqH+QZk4s5qIIsn+2zzVD4WLsofz3LzmAutk5vVa1XOoG1lMOnfT802mKINHJFIKQfIkVkJxKlgFr74iM+Qf0wth5YhnSG0+ccJ37aLT6NRtjCnSkKd3Mo2+W+XI0RtCMRiSMJwwDmunTF9EiL6e5dEr8GylzAtYf47IrJJfHI1xo4MLXPUtuJJ5sn2LjOcFc/xwdQRpU4PrSkuOyg26TaBOVJP6HHEsiZaAWD+wdKZhp+xUB7i47cAsMJrMNxvJVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDId1bdinfxU6PYsvZ3iggsYlHFY0aSKwsd6jTFg+o0=;
 b=VHVJ+2YhdIu9Q9ZbpZ0l+4Uddp+ecMhQrmvv6X7Mt9tqzpkAHDDujK4zinUSSgqHzoGsCHbw6QAhf0E7T0IFWgG5JVmZ9j0JzFRgwKws5ojbUxhRD7cVnpFYUdJHkMVHGzM37j8i9HuaNUwmZOP54uHCk+mLhdAjE6r2/55JlXAV9eo4htcXayTiMzIkd+T+wcJT6KxiBK3TH9O2ghgOipVxns7Bkxg7QHKtghun1CbDGuhtuYIqBX3a/q2xgwKmskJ002+EUA1zaHdn+lj8L4Gi51aAQb8tCeP7XFMhV+fqDSAF+u8pwMeAPkACNr8WwmFTrVf968EP4of5oF0Sow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDId1bdinfxU6PYsvZ3iggsYlHFY0aSKwsd6jTFg+o0=;
 b=aNU1iW45PZNsIoqRKGI+90KYJPp42ga4NxYSNkfYm1h1wNaUeoZWK4Yi6J8M0nG+2TM6P7RvwTW24ZTfQVMNvAXt+kVmWntlXc4yMDDwIGb24lcbuZhRqC/qXjapmpKZs1boONGXA7jzc5rgA1LHXM277V1I46hQpVCc4CBBpy4=
Received: from BY5PR04CA0017.namprd04.prod.outlook.com (2603:10b6:a03:1d0::27)
 by DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 18:39:55 +0000
Received: from DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:1d0:cafe::fc) by BY5PR04CA0017.outlook.office365.com
 (2603:10b6:a03:1d0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 18:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT097.mail.protection.outlook.com (10.13.172.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 18:39:54 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 13:39:53 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Mark Gross <mgross@linux.intel.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 2/2] platform/x86/amd: pmc: Apply nvme quirk to HP 15s-eq2xxx
Date:   Mon, 10 Jul 2023 13:39:34 -0500
Message-ID: <20230710183934.17315-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230710183934.17315-1-mario.limonciello@amd.com>
References: <20230710183934.17315-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT097:EE_|DS7PR12MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f2a3bc-2c9f-4eee-2276-08db81750e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /swIwPzrsBGsxnSH/wEh3XAcZOJY1UrCH0qHOFAqRGcnDRZTKz8LO6Ba1IsFNHFszeMi7pejbqzg7a1NNn3vOSNwc59OEmKbiSADYG+Im6RaDFgLorC2RdCE2usuXtUPjMWbE/juBLv4rt8+gayYmrnSSB2MBmuUMLGgVhziY+Pb4TCy9x9qigs1BDjodXcGhDghwkSYUnfp/dxwDrOpRW4SsI60WjX4hrCr+twa4SeQiSNj/yyfw6DPW4aetyyLTroqMibP4xAEDwxcY80s/dF3pLG27mRCBMWDmA0uJa5VQx1FZkJvOrccSiGcJrXmzJrzwy8R82ap6OpAmjNBTP1eb7uF+c7bgOEbc7PxgfOBK3IuX2DxS73K5teOGDVSuihbcqdH6y/ec74NFWIgDQF3IlSwIpiqiVkft9QAskfbHcThlJeeDTT0Lrs/c/jNmSjGushTSaR5cfZqy398V7iXai5uNaun0T8J2RF/aF5yqxXJis2FVzMh4Ohkb6oBC8OMklOp3ZjFdwbCuEZD/k5j7ESc2mOCK2kNzo7Pal+PH5Zk0Ho9xV57fi4KnZ7NcaMgJYRvZF6Li4liZkqX2vCHxd5MpBFfPdAxv9e/TaDceiTK4vHcwJUqNsYOYPNNo3rwm9vT2fvhzxNlq0Aq3yVVzTmWtYaa+cKj6kO01BvfvwerV8AZwwExwayhaX+hmas3NFS6jNQlb6MLlIh/FqjqwNTdgn0XW4phiSV9c1CRSOGBQvDAzxjUwWxMESq6
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(186003)(1076003)(26005)(16526019)(2616005)(966005)(36860700001)(336012)(83380400001)(47076005)(426003)(41300700001)(4326008)(6916009)(316002)(2906002)(5660300002)(8676002)(44832011)(8936002)(478600001)(7696005)(6666004)(54906003)(70586007)(70206006)(40480700001)(36756003)(356005)(81166007)(82740400003)(86362001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 18:39:54.8131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f2a3bc-2c9f-4eee-2276-08db81750e09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP 15s-eq2xxx is an older Lucienne laptop that has a problem resuming
from s2idle when IOMMU is enabled.  The symptoms very closely resemble
that of the Lenovo issues with NVME resume. Lucienne was released in
a similar timeframe as the Renoir / Cezanne Lenovo laptops and they
may have similar BIOS code.

Applying the same quirk to this system allows the system to work with
IOMMU enabled and s2idle resume to work.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2684
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc-quirks.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc-quirks.c b/drivers/platform/x86/amd/pmc-quirks.c
index 387855ccea812..cdf4c7d0a36bb 100644
--- a/drivers/platform/x86/amd/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc-quirks.c
@@ -109,6 +109,15 @@ static const struct dmi_system_id fwbug_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21A1"),
 		}
 	},
+	/* https://gitlab.freedesktop.org/drm/amd/-/issues/2684 */
+	{
+		.ident = "HP Laptop 15s-eq2xxx",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Laptop 15s-eq2xxx"),
+		}
+	},
 	{}
 };
 
-- 
2.34.1

