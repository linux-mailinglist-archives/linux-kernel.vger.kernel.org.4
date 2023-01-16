Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFA666CFDB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 21:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjAPUFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 15:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjAPUFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 15:05:04 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97B2222DB;
        Mon, 16 Jan 2023 12:05:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6hoLyh6LBrbHmusPW8s+pdfxleOQHnC5IlmxT1ajdzsBhGyFh+kfGsXr1Ti4GzM1PUAXR4zIKZ61yJcI7WJ3ppVzIy58Fj6HS83p5YJRByb/oqxpR7vnxnEQxNL1eEF21M1exjNN6WmG3Ufjvfo3Np5zHCU8GlvYChoON7F2T3jGY0v1Mlf0Hmy/54zhNgMPsXtucsbPZHTIASlDO8CtbPRpip6KST3CSx0pAG6rJy7v3XZQVjCxecE7PqUM7ML8TYtQw4xZcgr3nuDH9LTykZtQZRCnsdCPJpTrJRMnTB2NyRoNDswnAoeQTyIkbys/C81REzUQWZPjSxOD3j3EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROsL851k8UJdKgDdZxwRUSRIaD9mT8q5Pd9aMtNi2qQ=;
 b=hIXr6PJnJkLFY9r0rLmA7drlDsaaEif/lp5szRKGGqvwOCuFqsnr7q3DqSOtXpGqj1VsoooCwZdhJc3uA8X7GpIhbqH1QSvO26LHAXWw7/c3zqZTs8ME6SsPYY/7XgbpZtdr6hHtyEQwZIbSaIl55W3iKK7QJ0/adnRF00c3WWz7ZLabA3vLcHdgstuLoQcTn+UZdv1ykkEzRSo2OgwR+aKUvXi/y3JA2jHljw4fYs2ik+g5MQush2OJpw+iC/nV8HFQgZASQNHqsGcyYhWEzc9HmvXCRnuJ5guQK4jgSZ/H3pIOIc5A30B4igGFBjaXV1P0JDW4WwsVnEBTUws7xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROsL851k8UJdKgDdZxwRUSRIaD9mT8q5Pd9aMtNi2qQ=;
 b=zZETZyFoiqYVtrJafc7Jn/gzPzCsZNK5EuVzmhEaUcemQrwOd1AYWd4lASFdC29pO9CqgxTkzxZ1jkdTiWSUlMs9qP8sI3mRhl+S9n5iPCj7w/C5RfxwlT+QlAT0My0HI8WWgYDFJzfCw7IHxc+mK8o0UKWt+rA/2koovixWxiE=
Received: from MW4PR03CA0085.namprd03.prod.outlook.com (2603:10b6:303:b6::30)
 by MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 20:05:02 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::bd) by MW4PR03CA0085.outlook.office365.com
 (2603:10b6:303:b6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Mon, 16 Jan 2023 20:05:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Mon, 16 Jan 2023 20:05:01 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 16 Jan
 2023 14:04:57 -0600
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        John Allen <john.allen@amd.com>
Subject: [PATCH] crypto: ccp - Add a firmware definition for EPYC gen 4 processors
Date:   Mon, 16 Jan 2023 14:04:40 -0600
Message-ID: <9a5c5b0e9611428b15d6039643730489d543bfad.1673899480.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT003:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: acdd4e29-8523-4375-2e95-08daf7fcf3ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eCnK1K7jrozjDlNTMg1pxrkUl/5D2Zdv0DhFdS1SUs/4bzz8gXgIv7Y0BFyzwCZ/ao4bQzX4Mkagu9ota5z4r4XfRm87g/fInOUvjf9SMSisZA95Gq3jivlasI9E7neFdrUA7FShibNao/Bq2Kx9uXM/aWwZ8koSF50qExdQXRnxxMn8rtzFIZkIbaIXkSJMCz5eITY9kcv66rAujV9dSx9IZOPmiemk58yBfMkQalVsYRVl89WpDm80B/N0ttDVe9n0So+/PoSkkmmeGXs0A4MNNPSDCTJpUuFT8oOjdZ9eG/5UqX+7BBw4XKTztm4Zj/LWDXVvGUYL8NGPsxKRVvC8oz2AoyYKX1REgxjDitLl4x6EvVbAiykRDy2SOysEzHZalVR+Tp8e5WYOfLna3NuPaIDrnLyA3TijNt0jA1RXx+l5UU4L8nfRbJwbKWQePmANg+Adgyo8a4pDz6eXgu39hMrd6XkIRlhkGLFprSI1TnE0/QOuKU8zLsYpPdMkhPdCOiNcGIsurvMpayWr3R9U8lp966HuNhMuDfRp3NWj0XLQLShfaN7iRbfhviMi45261h8DxwQyB83WQ7ud7FZoiuauTgP+YH//keZFGVWWbtHwWGmTKqzjTWDGiEeQqbgCC9Wnjh3TSi21vWibz8hKGvtXV+EkwSvfD18lXynjtlmBJW82NJrDqxqQWWr84vTmA5BHyqDYU5FwtsUcwQkhmFlf3781xO1+lsT6TOo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(7696005)(2616005)(26005)(186003)(4326008)(8676002)(336012)(16526019)(70586007)(110136005)(70206006)(478600001)(426003)(47076005)(41300700001)(8936002)(5660300002)(4744005)(2906002)(6666004)(36860700001)(316002)(54906003)(81166007)(82740400003)(356005)(86362001)(40480700001)(40460700003)(36756003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 20:05:01.6841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acdd4e29-8523-4375-2e95-08daf7fcf3ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new MODULE_FIRMWARE() entry for 4th generation EPYC processors.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 drivers/crypto/ccp/sev-dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 56998bc579d6..13f1c88810d8 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -56,6 +56,7 @@ MODULE_PARM_DESC(psp_init_on_probe, "  if true, the PSP will be initialized on m
 MODULE_FIRMWARE("amd/amd_sev_fam17h_model0xh.sbin"); /* 1st gen EPYC */
 MODULE_FIRMWARE("amd/amd_sev_fam17h_model3xh.sbin"); /* 2nd gen EPYC */
 MODULE_FIRMWARE("amd/amd_sev_fam19h_model0xh.sbin"); /* 3rd gen EPYC */
+MODULE_FIRMWARE("amd/amd_sev_fam19h_model1xh.sbin"); /* 4th gen EPYC */
 
 static bool psp_dead;
 static int psp_timeout;
-- 
2.38.1

