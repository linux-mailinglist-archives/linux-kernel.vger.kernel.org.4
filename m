Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74E85B5F3E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiILRYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiILRYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:24:09 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2045.outbound.protection.outlook.com [40.107.212.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BE13F329;
        Mon, 12 Sep 2022 10:24:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqxDMugQyj/V4EgeKyX6Hb/vEfj1G7zhN2L0ZTzQAfrBy69YXsGoWtUK/CONg/IXMADz+rnPm5rHEvNZ/b0n/sL2yH5f3LdBmqqqv1eiCmUJfCbYBjl7UDh/cJn3lKkA5Yokmut+10TgX4S3I2fBxWCDNGjVrFzCUS0NuIYbmH+WkhibuzJ21X/cokr/YQEf7qu7s+vPbz6kGU/MseTRd01u+VFO72+8ylupYc+LlpCxVI3B3KQUu4drhuVhBmljoMQGfeXIU17O3BG/CwntK0pB4FKmLwUQzLVJGfonHPHEryYCvsKZXOXw+U9EqpfzrHNupx6qQQW8zDVLTY4TMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpKlc3bKgAX+Jo59M23L+qgxh8VVLDmY64Q2XIhNDMI=;
 b=GY5e/K+RaCDcxwBSVnRacbxZxrvD94WsMA/T4oh0BCwCDuQHhvaZIGzH3dl8cnBtuJ2o+ZJ145TclghRUXSNq/bCa5Mc3oCNidH2/ekIsTT20wg0GAvd+g9qlj3YiVVtf0Of8c6mMP23ll9vpcOIaEoQpmkd9rbyAhw7RSWqY7A2UI+BXl7zHKiSo+iSyGXxA8ZjM56kJv186x/PP9/yQyKG1AyUw9YWu3dm8qR4iO+WK45lsvVQQSbbgMFB0UXmiWDbn2xOTZtYTis/8NBlSvqdjjnGAcLOsXR6yQrqLTNQIyVdWul8T8/cn96dO7trvC7ibuz4gEO4+3VjSprMPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpKlc3bKgAX+Jo59M23L+qgxh8VVLDmY64Q2XIhNDMI=;
 b=TCx8QDz3zB89ZDJNVjkBxXiEpAiFxYLAM5bA6vacG/m5oOGTvin7zmiUDqyd0iq4JbXbRfizcqKforgx/X7ilX0T3yBhKDAW5BdBxIQDxryzF+zAXJcAvYo1v6LNED6NkuhF9yPb6lHnvzjTlm1JI0ruKXwlqFQCBc2sJp5KP74=
Received: from BN8PR04CA0027.namprd04.prod.outlook.com (2603:10b6:408:70::40)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 17:24:05 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::21) by BN8PR04CA0027.outlook.office365.com
 (2603:10b6:408:70::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Mon, 12 Sep 2022 17:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Mon, 12 Sep 2022 17:24:05 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 12:24:02 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <catalin@antebit.com>, <philipp.zabel@gmail.com>,
        <travisghansen@yahoo.com>, <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v2 6/6] acpi/x86: s2idle: Add a quirk for Lenovo Slim 7 Pro 14ARH7
Date:   Mon, 12 Sep 2022 12:24:00 -0500
Message-ID: <20220912172401.22301-7-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc9bfb3-9ce9-42dc-2c2f-08da94e397c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ntZML20Nro5AZnt/GsIQ8FkSpYSNCalpIhExzQhLcNcRMePcgPWmi5eIN+dl8QThvyknUKsuVlGNG3QkpMXhI3yX76vG33gJj7sfCSCsR11JoQYimz9IJy7q5zPKUaGpwIRyQ/aRPVoYjnbF6fmZEypLLcI5NspxfF6IdMHPqQMruDq+I4Xe9bLheZ7o/x4tNM97qpvMey0UOi14z6lHGJ/LR3SSk5zy3/pZl83aTCBRpBMssVhVVk7M6gi4Q6Sckvlh8JjEjTyS+aHenVxh8dZTHl3nHMk1xIUCnXDWjlE3TDouUlV9OegzSJf/aAl0tjNFNoDKkjDa8fsZRsjrUnHjzdGQqdk25KkUHQtHvPpx8BjM+tVFdYkvs2ZfnVCvQtlqqNBlLo77BwUJdfnyJPszoou/uNqTj0ClixnrdrF0NVeGFz3CkUw/uXFFDP80PgTxz4nEL091+zQtUAMihZwdgckwb6DbeewdYyDimDWZDkYamItN3Ye83KMKSzmgo/jR030nTwPUetcBArBECDySYTcFo51xLYwClTeqVxqW5oXC63mK7C0dcA6faU8DUyprcWfTJ66kcCumMFRW8wwwqQdTPFLuzbz+SIkMcPnN3GPD+mMf76vD5rThJMivwnnhhWUhO6tMqrR5moB27JLRa4UC/FkzVHrI8JlGTgwFim4qoeLNnyYt6yeFUU+HhSxE6TmufZVsbyMrCtuavHfAwJom1h2WtNJlI3qLzb1yhs9+CN8FOOGstGeA0N7x1cQQBWt2i7ETg0Snacrl+ugtHsOz37sJSCNzrgLFsiVH+QNYZrMbEijh5urqm/oRiywm4cSW20mBvV3ERMoPxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(8936002)(5660300002)(426003)(356005)(70206006)(40460700003)(36756003)(4326008)(16526019)(7696005)(82310400005)(82740400003)(478600001)(186003)(1076003)(47076005)(36860700001)(81166007)(2906002)(45080400002)(26005)(86362001)(110136005)(316002)(8676002)(2616005)(54906003)(44832011)(966005)(70586007)(40480700001)(41300700001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 17:24:05.0359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc9bfb3-9ce9-42dc-2c2f-08da94e397c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lenovo Slim 7 Pro 14ARH7 has a sporadically non-functional keyboard
when resuming from s2idle.  This is caused by some missing calls to the
EC that don't occur in the AMD codepath but only in the Microsoft codepath.

Add the system to the quirk list to force Microsoft codepath.

Reported-by: Travis Glenn Hansen <travisghansen@yahoo.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216473
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * New patch
---
 drivers/acpi/x86/s2idle.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 4bdc7133d2ea..8475a3915812 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -428,6 +428,17 @@ static const struct dmi_system_id s2idle_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Zephyrus G14 GA402"),
 		},
 	},
+	{
+		/*
+		 * Lenovo Slim 7 Pro X 14ARH7
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=216473
+		 */
+		.callback = lps0_prefer_microsoft,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82V2"),
+		},
+	},
 	{}
 };
 
-- 
2.34.1

