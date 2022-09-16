Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58FF5BB212
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiIPS0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiIPS0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:26:24 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2041.outbound.protection.outlook.com [40.107.212.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBD7B4EB2;
        Fri, 16 Sep 2022 11:26:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgIlOSDj9p+pPwYTeZ8+u+XdN99HC2QwaFFECtOLL23lVaeAaoxXiAn/sW0ExYFIlDpj+qvPRIiCiN2A2CLDEMvSG5F1s/jzEdKB7iezlLJyhWTF+P73nnuBVSuIzcJEn61W+ZhLxoiQZn79iZ469gk/3+uqqW/ZdreauXoey/ei9l2Mfez2DYCWZobvKlCcWsIX0mczffg6qIkz+PJtVd+EsJMlX8H9hlVk9L/cqeMTpNNEJ26R8jVTLJh5OXAPWD698SyQVXbsJEBMnU2E4W7tO7uVopFx+Ds7u82Md6ec2sq8IJcHg6MmymQxPMcUmznuc8kk9gZ8Au8Bckyvtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WX01IQsh1BxsH+c5+jv84ywbcDBl7HEozausjPBN5W4=;
 b=Ex0iuXCEFt/68Mi8QwQo+SC/ChbjJpkYD6NCylk/QNJlSHTaZ8GI2UpjyrgOLJp/k37WJEZRDklc2bKrCTubWXTyTwjOzH3gd3lpP116BkNCoJRqBYq/RLT3LaFZ7cUkSxogJnr35WQQceHfqmT5cTnn4YZXYleY3548qR63JSDNUXJ0FOycid6S4TXuPDGVu51Iay86WPbUDDS0ztcN2YS5fWZLXFiGB7aTO1Y6ARO84PsgF/cifAm7qYpUF0piiI8QBZlHyBmsD4s8451+aA9WfVF3uK2+I6GTbzRVQu1V9fuql5iGniRQYCl4jPwchVnFK1/iwn7WtceKfyRBOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WX01IQsh1BxsH+c5+jv84ywbcDBl7HEozausjPBN5W4=;
 b=nLOvpbnxXLgSXfOoiXpgcTzJ1Oi2Cm7mHYNTKj20ctkc2Jpn+0RB7K9qR68m76zxC0xLAseapzJRrQPq1pL/ydDWCL/ASRU8yZ/GkElIj0RJkkYayO/rYIPHgGV5SAEJwtqtfKW/1LxzEbjP5+l7dg6Cs33aQ5zKmUmcllmB7e4=
Received: from BY5PR17CA0002.namprd17.prod.outlook.com (2603:10b6:a03:1b8::15)
 by SJ0PR12MB6781.namprd12.prod.outlook.com (2603:10b6:a03:44b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Fri, 16 Sep
 2022 18:26:20 +0000
Received: from CO1PEPF00001A60.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::20) by BY5PR17CA0002.outlook.office365.com
 (2603:10b6:a03:1b8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16 via Frontend
 Transport; Fri, 16 Sep 2022 18:26:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A60.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.11 via Frontend Transport; Fri, 16 Sep 2022 18:26:20 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 16 Sep
 2022 13:26:19 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <travisghansen@yahoo.com>, <catalin@antebit.com>,
        <Shyam-sundar.S-k@amd.com>,
        Matthew Anderson <ruinairas1992@gmail.com>,
        <philipp.zabel@gmail.com>, "Sebastian S ." <iam@decentr.al>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Len Brown" <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v3 2/7] acpi/x86: s2idle: If a new AMD _HID is missing assume Rembrandt
Date:   Fri, 16 Sep 2022 13:26:04 -0500
Message-ID: <20220916182609.3039-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A60:EE_|SJ0PR12MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 77be53ac-0684-4818-020a-08da9810f40c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jgZIpM5gTZyy4+AaDsc7bN0yYr1BWQcO2kfCX9Fd1pxJvy12r8PixbsZwgWj3ZeO8AI6Z+xytgNZAVcYpEE7isXh7vmCnZppg5mkXAThfRo4yMjErvqgWbvsxkTHdDcUXzXi952+8xGrInGPRNQb+VA1z12qb5NtZyhGNgxIfQJ7rDVw0aP/hOdJBg+FCw1Rti70PNUIXGjDpCqDh96RI2BtjgMBpRWf/GgB+aO9TVgrUoSZrJOyBAoW22Cvy5lJG5SQtVK7x7CCxgoMlQPAdwCEhqTKidGvkPoKrRC9+fu3hicE4RpjGPezACkquFp1BoiBbzZs96hMZE6iyLVmOVtKmnKjTMqXn+42PkoxVzUd3tPjdPkMr9BFtNMJfdCn8T9FnWYGD5VwrdJWuKvLhJnJdnm6UvSsrqZ4RRIaXnjriPWwco0R48Xy8XHD7rGgosn7BITG45PHnOJBGozm5KKh0QF1wR1qQsYvaL6iTfJ3PC4R7B+bzZ3eMfCjDF/Q3LRAXX3DdR+KFsiK7QMeWuADmwTIivlm8MHdXFj6WIIWTzbpBIWlKKWH4sEsz2Swaf08Mb6XcBmYrK5jHWW1uihDVMz1apqCQt9ACrXhzTux1tU9nCALWgvjgCUvk75L3q3PQdkKw7NjskWq+ZMEgfd+/STkL8RJnTLnGWDEIOTmisTpaT5vqHE8kCqFvIehj1JrJXTEyYjqvJSK95S2DJJXy0HumIOLeoO+IyE7Zoe36klE4ff6qlwsoKPfTkObts8OLDTh/MEbb1YFhd76DDFU0RCuRVMxrh2PnpbsGN31arzMsLccB7xo+HcytQEH
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(81166007)(82310400005)(82740400003)(44832011)(6666004)(426003)(41300700001)(40480700001)(2906002)(356005)(186003)(1076003)(7696005)(26005)(336012)(83380400001)(36860700001)(16526019)(36756003)(478600001)(47076005)(70586007)(70206006)(316002)(8936002)(8676002)(5660300002)(110136005)(7416002)(86362001)(54906003)(4326008)(40460700003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 18:26:20.5953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77be53ac-0684-4818-020a-08da9810f40c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6781
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A mistake was made that only AMDI0007 was set to rev of "2", but
it should have been also set for AMDI008. If an ID is missing from
the _HID table, then assume it matches Rembrandt behavior.

This implicitly means that if any other behavior changes happen
in the future missing IDs must be added to that table.

Tested-by: catalin@antebit.com
Reviewed-by: Philipp Zabel <philipp.zabel@gmail.com>
Tested-by: Philipp Zabel <philipp.zabel@gmail.com> # GA402RJ
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Add tags
---
 drivers/acpi/x86/s2idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 28a3ef9a6bc1..2c5931d247a2 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -412,7 +412,7 @@ static int lps0_device_attach(struct acpi_device *adev,
 		if (dev_id)
 			data = (const struct amd_lps0_hid_device_data *) dev_id->driver_data;
 		else
-			return 0;
+			data = &amd_rembrandt;
 		rev_id = data->rev_id;
 		lps0_dsm_func_mask = validate_dsm(adev->handle,
 					ACPI_LPS0_DSM_UUID_AMD, rev_id, &lps0_dsm_guid);
-- 
2.34.1

