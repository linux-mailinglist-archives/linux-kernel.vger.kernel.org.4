Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7E15E5499
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiIUUlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiIUUk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:40:57 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8CB9AFBE;
        Wed, 21 Sep 2022 13:40:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjU/KTxZfCFuWPXeD76kOUNtBoXeCP9SLAvLGNkGWwma7T1hvlLCzRX4X48Us1hhyk00mUiixsoX0wW73kfZHtgH/LG1tfVGvaPR/e+qhK0GjJlL9SndN6z4ePyG6KhW6UBsmIxGYJC4N6xvPmNH7agdiAqZczhvTyTjRJFIu4NuXLepLrCyHD2xuThkeCFnNdozskAXvzWMYCyFaG0Ac5ezMenS0hHrY0NgryB5mImvUwD7ZE2UkTuINJerT8bbSEQF923cn3ezJi+RxqHePPnX6dQaXU0VfPMOeNwn2DTIJ8DsB6idDB+yAYHIO9Fe4nX9xn6d8a0wgsTReaexkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WX01IQsh1BxsH+c5+jv84ywbcDBl7HEozausjPBN5W4=;
 b=FC2gk974CwE7ASLQv6i7a/jdURkrGDv7bhuxZoENSdgznFZGJA0+UDykDijamblJynoVHCbMuRU2cT5NZHWMIIP9uwmqn0okpxkplktbE3XKVpv6nqRglsrjV7f+wjVH6I0YVOyoIh280ZqwCOspXlrcfZ9ptHTAfqQdT8ylJ6Fdm3DSZJSGWDX/AXS8AeX8iAy7IB+fm4E8dwxVk7UwGUAQaKAxLrzU0HjAyYiLOOY+WKKOMqKzWEWfB1aeJzKjYFOBxXRHGmNWBKk+Cmd4KnKyECopvQxNBSx2DBDbiTAsu5G4Wmw7YFaKDC/5xvaHPlsgu6acbAuKFrfi/laydA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WX01IQsh1BxsH+c5+jv84ywbcDBl7HEozausjPBN5W4=;
 b=z5T5YsXNubOAlt8TfdKBAqRUOJiRE/lnQKWj7FMafZVVweDYmVgrOtQYW8CBAjdXsCSfjefiIobsfFbGvWng+NOe/Y1i8Gtn2ici2+iX0MDESK/X8qv4GxxQwVEvVoHQ8vPtlpq8/xLRNyIaQqMMclEZH4nqHH/ImJWYEmRh4+E=
Received: from DM6PR07CA0102.namprd07.prod.outlook.com (2603:10b6:5:337::35)
 by PH7PR12MB7354.namprd12.prod.outlook.com (2603:10b6:510:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 20:40:53 +0000
Received: from DS1PEPF0000B077.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::e2) by DM6PR07CA0102.outlook.office365.com
 (2603:10b6:5:337::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Wed, 21 Sep 2022 20:40:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B077.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.11 via Frontend Transport; Wed, 21 Sep 2022 20:40:52 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 21 Sep
 2022 15:40:51 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <travisghansen@yahoo.com>, <catalin@antebit.com>,
        <Shyam-sundar.S-k@amd.com>, <ruinairas1992@gmail.com>,
        <philipp.zabel@gmail.com>, <iam@decentr.al>, <hdegoede@redhat.com>,
        <davidedp91@gmail.com>, <marko.cekrlic.26@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v4 2/7] acpi/x86: s2idle: If a new AMD _HID is missing assume Rembrandt
Date:   Wed, 21 Sep 2022 15:40:49 -0500
Message-ID: <20220921204055.22889-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921204055.22889-1-mario.limonciello@amd.com>
References: <20220921204055.22889-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B077:EE_|PH7PR12MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: 81dc4fb3-7a33-4610-109f-08da9c1193bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hs2kxDjjPu8Ow57L5qmltYOii6CnB6wCD1e6wOsaR+yFMeQBoO0AhzYqVnj7saTPtEfNaEjv+WCeyBdAorA1D4Arads80Yefp3/qMXNbb52h8e7Pl1hcLQlkG6UJJzVIl4Ku3EN4mZPxmOHEoyOS16Lvv8h7//Nr1AOPD5MAtQM4/koyUosVXkjarwUVhcoYI1JX6Zhvm9Kbq61EWeO4tXDqgUqzpV5yYUyYr1hRFT0ICHW36yAt6V9QLBIRFrY6R3FrN7yQBg/eD8g8q45DAamoRA9YazUxaIJn2XyBpMoYM+YV1PU+OMNyo5R41lB02jDvJ6trU1tOXeZwjZv6cBrmbiPIWEwf1ZedOOZu8qIG0w7x7V+BKCg3Hw6EAVmKs9uOFLHPqnjFh6ugEdbQri6p4YL9rT01aNhSy/nDBoseL/Q7ldtP8O/Tff6dRrR+wqlqbKLVE0QGxaDtZEU+EVMrELnlNNtEmHwKW3Kp2it7L3SwyOSr2D4rOfK0FAnXW+ozGrLwz87/+izz1MLSRTRD6moxgaXIsYIHzUJY2EkY/qUay2Q74wCbwyvI0oefituj9I+adbteb7/WoQV9X1np6yCNgo48dhY3NecRz22BcxRuoXL5Lmlo8NMljZ2qVcDU/cRVaxRhiabwSewp+GrhqGUXIJK3sNrQow3XAe4y3hhPzSfDqArYHF10k7xRs0MQpnEh/kdMvOCtBs90ujLcE6/sdPL+h0kJq+o01Ca8B+bz38tnnhjlfH/ecnjPSUZolJ6+5mflwYHM22eI81pWQ0yK5WCo+iI4f8ciKZHTgjwAD9EhAF7KznxFeppT
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(44832011)(40480700001)(2906002)(82310400005)(36860700001)(426003)(47076005)(7416002)(5660300002)(8936002)(36756003)(8676002)(86362001)(70206006)(316002)(110136005)(4326008)(70586007)(82740400003)(186003)(1076003)(478600001)(356005)(336012)(16526019)(26005)(2616005)(40460700003)(83380400001)(54906003)(81166007)(41300700001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 20:40:52.9902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81dc4fb3-7a33-4610-109f-08da9c1193bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B077.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7354
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

