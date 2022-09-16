Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30DD5BB219
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiIPS04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiIPS03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:26:29 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766C0B5325;
        Fri, 16 Sep 2022 11:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0xbvWh1VyIZxrd6YKzhBWraJ13r4QhOz3vwtgZBc+ECyQxYlbJyJ/IKG2dPPLsWL1W6igg6entEYKTMpUNRvsgqNb93KlbDC6AfkGogqcQGobOUtZ8lDEKLMb7veqsKn2VS6+YWMxQ3lGyPDIi8PDCC82ni32gn3G91Us7aZK0Nq+kaHmS9Vhi42EhOJwXYRV0ji9N7rrc5CYMfFFYpQpP7HMWgDVSUn4rcLn79ayWbyPv+8oCmrQjFH9/M8SG1C2lm5e3yWy/82FUXkM62SXnQmAZkZGlU7/aJoaZhqZ0OWYB+R/p8OIXJlFjoLOd/xiZ5qa5qc+Z9D07dyCwjWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/m8K/CiYjxIv0zHj3BcTcWMGT19AMaYr2KN67unwh1U=;
 b=PyD6IDARP9+Xn1WYdXIdmWIQp1UKAwI40wzndoIxcXqkf+d2KudggOHSbXmUl9xfjbAzR3nHI/dTiBX8dUd/KssjppKqJFsumHq6nxW3g+HNkOoco6wkZ00Rio4DJQCDXjPFop+OYU5EmTcK1o7WKufnc7GB345EEqtXtXFoqmB2Qzz94WZjIBtyRFz2jBnhehfapaLwIE7hscFjx3FN2H//VsJ5RQy+sNNDn8E3voDnIy9inJXGWFy3mfFtzxV9UZsD+9Lsc6G/Bv1ipnkmYGDUZXcojsnUNcwCN/Np8F8Tm1RX7BcIAzGZxOkRsN6rb1aNNjodloxTWmSALe5ZuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/m8K/CiYjxIv0zHj3BcTcWMGT19AMaYr2KN67unwh1U=;
 b=yd+J1ZLdo7kV4oXqGUarMWQKKaXM/F81cZWE456QrG/qYkjrVPjbcQXifvyZpeTKcbQHbhNw+7+CDTkiuuggTQdJ6NXgW9WaYH0D4IHiEOQVfREvbisXpVdoAcq28oEL/FVRaGq2zc56WRnhAx8YYdINXY6Bixz3eZjHsNCqNFY=
Received: from BY5PR17CA0036.namprd17.prod.outlook.com (2603:10b6:a03:1b8::49)
 by DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 18:26:26 +0000
Received: from CO1PEPF00001A60.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::58) by BY5PR17CA0036.outlook.office365.com
 (2603:10b6:a03:1b8::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16 via Frontend
 Transport; Fri, 16 Sep 2022 18:26:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A60.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.11 via Frontend Transport; Fri, 16 Sep 2022 18:26:26 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 16 Sep
 2022 13:26:22 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <travisghansen@yahoo.com>, <catalin@antebit.com>,
        <Shyam-sundar.S-k@amd.com>,
        Matthew Anderson <ruinairas1992@gmail.com>,
        <philipp.zabel@gmail.com>, "Sebastian S ." <iam@decentr.al>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Len Brown" <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v3 5/7] acpi/x86: s2idle: Add a quirk for ASUS ROG Zephyrus G14
Date:   Fri, 16 Sep 2022 13:26:07 -0500
Message-ID: <20220916182609.3039-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916182609.3039-1-mario.limonciello@amd.com>
References: <20220916182609.3039-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A60:EE_|DM6PR12MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: 57fe0424-f171-4831-deb6-08da9810f750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jg6lkGbYIpHwXTtYiUoEqhO8Sy8yPDEVTbY9Q7bXrYh9+tWHmVb8/mG/8DxoAbDzjZzLZNTyfhcz6Rb8/2vva59JjMflWxs7uBLKAwk8vHStgndnMjQBLtjJ2aluGv69uSXiEl5/mDiQLHywnLwYLf4TC4RFX/AHDrKtbTuHjhp1tzZTRpP2V4+FW1nZaYFf3CnxG4QuNVbKfLHHgfp4Yh9F5PoJkyr6WKWuyS+Uu0rI3Cbq9AINBaeM5EtB+yQ9/+bHZdE/im2vRQCzNl86chhHHuOEooR7ZJTxL20S1VS0CzYoWuQPlhW1QS7WWxSdl3N29YGWig4lNtMwErFX84QeDewuTXDzqlNwArxCmiZJdff93V7Ac3TVl5AdK7jccoo4LWsjpcIjKpOJAypEY8Euf+wMdwd08EkFP0mvsmLE+WRZLwSXAMCUt8JG6V2BaPrr/3UONwm+clnH3raVpkTkSlMTXgPOKsrfJSR40Qn1g167lkW6aA1H52wBV8i5WhuYepjuhNQ00451fMHoKRP7Tdvof6dcdyaHEpxCcTBKPaCdQ4B35NknA2E1seZdDBG/rzn3gE6pc+BLGfR0UkodornSfHOFbnn9vZm5hGhjIilNPJuD+j3bpS2OJLsJN3Frn5+hfNxRlN14vyivOFMS6ENebY/MjL1UjqdfZJiW/bE5xBFi7Yo0aiz1kcwvAU4A5Ntox5OFKrMfIMEbwBkcA4D0vbzhC9/nku9h10+D7zd8ZRV9M8dy8QDJI8z8is8DON1lDng7WP2RSoQLX4qxdEXK8DQqj7LDO5JWRw56vCJdD7YoZSMjyabIU26l
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(41300700001)(186003)(1076003)(45080400002)(478600001)(7696005)(40480700001)(336012)(16526019)(47076005)(426003)(2616005)(6666004)(26005)(44832011)(2906002)(40460700003)(82310400005)(110136005)(70206006)(70586007)(54906003)(316002)(7416002)(5660300002)(8936002)(4326008)(8676002)(81166007)(82740400003)(36860700001)(86362001)(356005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 18:26:26.0641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fe0424-f171-4831-deb6-08da9810f750
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS ROG Zephyrus G14 is affected by the same BIOS bug as ASUS TUF
Gaming A17 where important ASL is not called in the AMD code path.
Use the Microsoft codepath instead.

Reported-and-suggested-by: Philipp Zabel <philipp.zabel@gmail.com>
Tested-by: Philipp Zabel <philipp.zabel@gmail.com>
Tested-by: Matthew Anderson <ruinairas1992@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Absorb tags
v1->v2:
 * New patch
---
 drivers/acpi/x86/s2idle.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 1b638bd30fcf..52f41119f296 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -420,6 +420,14 @@ static const struct dmi_system_id s2idle_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "ASUS TUF Gaming A17"),
 		},
 	},
+	{
+		/* ASUS ROG Zephyrus G14 (2022) */
+		.callback = lps0_prefer_microsoft,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Zephyrus G14 GA402"),
+		},
+	},
 	{}
 };
 
-- 
2.34.1

