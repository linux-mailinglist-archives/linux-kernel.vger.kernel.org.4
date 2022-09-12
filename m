Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD505B5F42
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiILRY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiILRYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:24:08 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3913FA36;
        Mon, 12 Sep 2022 10:24:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoP2CRXDZ86wqXBusYe2uj1LOzST3nqA+hixZL3Rg2uQ5dOCzGZuJpXMriKY/p/lmKzpCWWy1RB0IfEZk9NBXwRwrYZEfzIcQSOhCT8MKeXsWSNo7n+wRXLdq4LptO84pMbpnfUNm2qj9K7eLtqPJl+xUshhvw+141Jcup9vPVhx0iSyOmTDMg0coLrHgOll+Yf4nTwl4nr3IHYUajxtEgAMT1xNRwiiPRT0t5P2S9oH8dZVsq7pAulCkt2hfT/cqhRlvL6a7ND5GTQdQkO8wvPEE27PBSlLs68EfbrzCEQhivCTRyyqHx8uki9TF2kzkiwERF2/FrhaNK9fiJiIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nQHF6cihPA7KZzNPRqdBCkFrOZ7QaWnoOMuPXT3MDw=;
 b=TEzHu4OrKt2f6WQdukfxDt/ViqxsC8BsPzEFM0zu25QAjejp7YtEpxmku+wS34YzBU9lCKyLfPIrIaeswU/bCzQdZc1LF4QBzjbVU33kpYJomtgjuXhDxk6Wv1STkAIZvADug/gFDJjRfhpVszlpnatIoqZLwB9eF7jYIKD33/7fl1ZQcuTUddhcNmA8FeAbMgtdnJ7GQr7h/LFdKD9iVGinKSDCE+FJFVDcyWAUBis1sEa5ve4TW8Mg8X7N4zkglpG4MkFx6Zeoa1KqvLE2+GZdSbtMdrHYNPPbRC5jL+giEbTdsuF1UmWfR2e9Ovj6MwNeU6vbuXF5jU4swStWvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nQHF6cihPA7KZzNPRqdBCkFrOZ7QaWnoOMuPXT3MDw=;
 b=Rww4ANCU8sjDjPOENiBXTlI4wMSLID9D2DcZgMx5HQ4C5NMuSDBcV8uYe8ZO+t4iElkLZ3kQ3z/B31Mkp7N/RD8tH3T5Lx9hTjxI0ZVIT5a624HXmHRxIPrHNSc9f8Ah5qYwLiffglR4Jj1IhFE4AjapkxDEFOQCmvYFntfGEro=
Received: from BN8PR04CA0029.namprd04.prod.outlook.com (2603:10b6:408:70::42)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 17:24:01 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::10) by BN8PR04CA0029.outlook.office365.com
 (2603:10b6:408:70::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Mon, 12 Sep 2022 17:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Mon, 12 Sep 2022 17:24:00 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 12:23:59 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <catalin@antebit.com>, <philipp.zabel@gmail.com>,
        <travisghansen@yahoo.com>, <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v2 2/6] acpi/x86: s2idle: If a new AMD _HID is missing assume Rembrandt
Date:   Mon, 12 Sep 2022 12:23:56 -0500
Message-ID: <20220912172401.22301-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f75fb82-f83c-47d1-a825-08da94e39508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UthoNvh7hViiXVRacmDaoOY4Q8QjBhOPqkEguA6FVXZwYnDXnZcByyjHLcT60EKSPGMgaJ22T34pFgsdV5Q+0rZM5qTtTr+pxwyqU8EaXMLO3doDd0pNKjtgcGQYWfJkaPwwDUvvVglmINOU4qzK1QVOnxDYmxRaE78gD1vp+B2yRBcncAvgTRxaBivE5zYMifxE/acZvU05FZJht9MLrMxOSmk0Y5imVW0dsR0W+OJa1dHvZrFDMtLf4HI15aak/Z1YYxHOWAVGzYzRAUOPcPs1GMs1w590P+g1pAIZwRR1IwOdO+OZokDPg2gQDmWNKGuPjCPK7ripDDW/dJPiIJRA4jDhF0oq1HOrrJWl3uPAwwYQYZv/HZUUjDk7jlbfMtsQ3R5hH+0lBaX/SaDkT0K7aykZKgtWblKx8O1ty4dtz91WLegyElTTisSFPoYmXU0liJ2R9zf3m/Szb211OuLK+QDiK4GLAtdExvtgqJNsWaiShEsqdnmGLtAhRahz5jPx+LPve8/0x2c2u2hB7XWMVAyC2kPu+zQW0hUu+CxNP8Tn1TpsUDxMIl+p/0ed3+mF0X9E3UbNcotwtYVVXTfl31K6xmThVUQuPacBvXWEM8nWz5ZJLjIVUV3ulnIlXhm5H7wUt3WQjCa80aON06aknsHwp4NE/gT9NR+eWwsK/KtWMdadaQiAHsbZtE6/nPguGtIW1VxxOg9ikDe+GDWU0rPKDg/Er8rV7nJw1HV+3iPSSwH5VnP+QwGOczJcMsW36Sb1tf2xCnvNeY+4pMyNnG2O8fGLF42YzLqgwxJV2Oyz4AgRJoHTPd9tOwzp
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(478600001)(6666004)(2906002)(47076005)(426003)(81166007)(356005)(5660300002)(8936002)(8676002)(4326008)(36860700001)(82310400005)(2616005)(82740400003)(16526019)(1076003)(7696005)(40460700003)(86362001)(26005)(4744005)(70586007)(70206006)(41300700001)(54906003)(40480700001)(83380400001)(316002)(336012)(110136005)(44832011)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 17:24:00.4424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f75fb82-f83c-47d1-a825-08da94e39508
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index a7757551f750..a8256e5a0e8a 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -412,7 +412,7 @@ static int lps0_device_attach(struct acpi_device *adev,
 		if (dev_id != NULL)
 			data = (const struct amd_lps0_hid_device_data *) dev_id->driver_data;
 		else
-			return 0;
+			data = &amd_rembrandt;
 		rev_id = data->rev_id;
 		lps0_dsm_func_mask = validate_dsm(adev->handle,
 					ACPI_LPS0_DSM_UUID_AMD, rev_id, &lps0_dsm_guid);
-- 
2.34.1

