Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED905B5F45
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiILRY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiILRYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:24:09 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2041.outbound.protection.outlook.com [40.107.212.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C803FA14;
        Mon, 12 Sep 2022 10:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7leVopCiquovhB+aplOQEqtPvH82yM0vlGja3CeW3md+2uP23EKESe2t79sVsYDsVGSjKa2HqOM40HCe2s4WDrlLXKXdpG5qDizVsQz9u2cC1Gz6kWxwBIFyTBi3aSwjycHku2oQ6UMGNsB5bpBGsLtP5/u8jpWmmwp5/TCiyyh2YxRVVcb0Z5BZn9xc1pOFj4T4eMgAcZU7+SUY3VrWixNTahsoyFdz/DwUatcgnEDCU0f4/u8Ug1lr0Wf2kA7uavTy3AoY6/FUJZ+skGdWXn2t1tG1zRtTsoBfkDb0fXRSX3vkxI9BFzDS1eG7+yXwQa2UD9bHnAmL+bVbMw+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lK9uxD6xIm0iY2YY+0p39rG6K4Hz8h+/204xdfwS/U=;
 b=IAtgPKH7hXuiE5fO7F37nIDswIt9/co4fBRwvZ3n/qVsnajNh2jcLWJnGkpbOdamWMqyaVpiUbv/2Q20OVodk+Cksx3PE79/kRiop5AeYwcYhWno8xxPcJa4BF9k7Ya1c6N5Kio75C6vq06vOIx+/l2G4Vznwx2M1jnX5SkkUq4vOhSl8NHWqO1VGHX0/BGerc2k71si6fFYNN6wgf9fgu/3iJ98A1ZHlf8vQn+YhCheosdB1IPVdX2/IaX2Wfy4n2QsLldWJcfKVrPBu6lUFIxB8XYeIZwf5UCfAGYBGgwn6uom3MZBwLv8Oo4kSKPg3ghjbilMQz+lXGosa522PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lK9uxD6xIm0iY2YY+0p39rG6K4Hz8h+/204xdfwS/U=;
 b=VDZoDYlst1eg416VouuY+AblMgImhj1PEz3QM12viJqtj4/pC+fQCc5XgrYSWU9lPMVgvoCgctiN7hQKS+iIQlN39T7xv3vIjFt4kl53yGedvlYNG08FBxyeUw/IR90PprM8rKqIpfH0EzrzMAyQJfnX6cmXMlVtN9wMKlUyDYE=
Received: from BN8PR04CA0035.namprd04.prod.outlook.com (2603:10b6:408:70::48)
 by SJ1PR12MB6076.namprd12.prod.outlook.com (2603:10b6:a03:45d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Mon, 12 Sep
 2022 17:24:04 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::7d) by BN8PR04CA0035.outlook.office365.com
 (2603:10b6:408:70::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Mon, 12 Sep 2022 17:24:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Mon, 12 Sep 2022 17:24:04 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 12:24:01 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <catalin@antebit.com>, <philipp.zabel@gmail.com>,
        <travisghansen@yahoo.com>, <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v2 5/6] acpi/x86: s2idle: Add a quirk for ASUS ROG Zephyrus G14
Date:   Mon, 12 Sep 2022 12:23:59 -0500
Message-ID: <20220912172401.22301-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912172401.22301-1-mario.limonciello@amd.com>
References: <20220912172401.22301-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|SJ1PR12MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: f03f12f8-1fc8-4d3e-966c-08da94e39749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gFP0eY12GhREdXWE1pQAaH2JiD74fFQ2lXZbRl13/bzddorsSyWfxaCMUVBRkgLnMzxWHd2UYmagR/2D5RrePheqXk6OIz5zEolH1N/Stg3KyXveGdMxkeLT7FJX+H1ZKGiL5Aj+lE9dG1y4KcrI+PCEI+N9d8Z7v2Po+/m4/+lmos0hAJQSEV9R13kP2RY0OO786ZUA1wipvBE16O1vdOgpVKhJD9pJNN895DCsDhN3psUi0MWmftVD83WKzdl4vIr1wvtDrtXdIXH20CTsVzHQP0ObDSQCp8MfyiE/chpaBfL6GsW1ymoAtB6N788eCAifKPgZFI9jgJafPWmhO5WBuWW+nYgEM+dB4g65H95o9tYbQSpM36j4rVREJgJtZHste5Rl0WELLCtpLMDkboKfV5DHP51cJyca7eZjo4ezhoH8UHN6edRwY1/Z9kG3NmSf9jn7smm7yD0WyQFB/w89ca1akWLEXK4KdILvVJc0LeHeC+waFeu+xN4IcU3EkjbDZCnWJaJcF2np3QCjs0Ap1kkRZZyoJs9Ul12FjYZ6Kg8U9hC6FvzUkZszjxOD+nuKbYGfIdp52O0e0W6lz/PF+4uDpsRS5dr/UsBdKyKZFDNVBATrTEiE/Yocw8ixSQ5DBrxe3JP9nrYj9+BgLL/XjSdGWc0qGhLInmqFfKmDQ4wKuwYVRRz3n2/iV5y5DHn+1PstTIDfALq7E24frxSIij4u0O7Wd9Vcz0LvVDPnEICHUhj8mGmTqxNKXktMIsycsqq1cgY4LJUcJFCrXeP5kD/s4ZISTTpMqsiRD6HjmROWhJ4lK238CShigv+C
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(26005)(4744005)(356005)(2906002)(81166007)(47076005)(7696005)(41300700001)(82310400005)(186003)(36860700001)(8676002)(316002)(70586007)(4326008)(110136005)(478600001)(8936002)(54906003)(40460700003)(86362001)(1076003)(16526019)(40480700001)(2616005)(45080400002)(336012)(5660300002)(44832011)(70206006)(426003)(82740400003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 17:24:04.2390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f03f12f8-1fc8-4d3e-966c-08da94e39749
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS ROG Zephyrus G14 is affected by the same BIOS bug as ASUS TUF
Gaming A17 where important ASL is not called in the AMD code path.
Use the Microsoft codepath instead.

Reported-and-suggested-by: Philipp Zabel <philipp.zabel@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * New patch
---
 drivers/acpi/x86/s2idle.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 9ee734e0c3c5..4bdc7133d2ea 100644
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

