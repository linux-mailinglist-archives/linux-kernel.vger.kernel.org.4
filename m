Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C146704AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjEPKdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjEPKcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:32:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3224A5FD8
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:32:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsqsGHABM9HjKiCfdROwVAFCbC3UT5sERSfB+o2iRa66yJWxIv7B9HaQYG8AtXFqehS5id5oWOGFmh3+XrY/agevIg9/gQ1zkmtERo8vZvP6XTtROrLdm7VEpzxa8KDKJ7pBJY4zUxD+5F7Eo1ugVXZOUZ59LIf6eZGj8idii2bTyUsNNyQI0AOGPevebGVQrg+rRLDhU+ZALxo03Uj6JU8S8zxwvU+ibPrsJABPgg8JaKc7yM+/xhianfCBAfBAObDDLkVGHY0DGoltWNXNe0lThLYoxG3s0aUUuI9vl1ehO58tOnPO3Grk+yEL/kLJKBmiq+jkExhDjiGDphhDlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uE+liJnzd/pGrs5vgWfnrRRP2R5XD/kiyQ7UsNqsXoM=;
 b=iern/p7yGGCNVCUQ4I3N+nWWCdAk1kkx6/Cw9srkIQb/F4SOyX5fXlZST9VQRFPJkPEjpeKK7IOfWE4ZTUWVBI5vpkTLm9cMJBg5Hpk7lSGaxZI2+TGVzMqrh1Svyt/Mjzldyc7m6rFM8jyEh0MLVO67zj2A67Y8GoagxhSrB9DIAGLBz30iereYcTjr7/ctouQzeY3EA4w/jZt3XIgdesxwQln3mIHk687c78msgza9jozu0xQsplIcBSIFSw+Mb6mdh9l+3g2XNmPXM9toj5PC+IewaGDXjFTWVJQylf0F9GsuSUl890UcncWtxnllzc55nxeoMY3m+IdCImCJeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uE+liJnzd/pGrs5vgWfnrRRP2R5XD/kiyQ7UsNqsXoM=;
 b=srkV76I2OJx2wiaqkeWwcKWTBgM9H9h6AV0RKigbm44gocDc7TKmB3Q3nDULPv4deHWEQcBqbfcMeYUDRf4+qiUMUI0f2RCZfYZnHfsKtqIwHVfOw0keUFZc7Kw39dqxYpnVgCWI6worDnjQ1wxSEurmCQ5ZS2opu1KvvMMFsVM=
Received: from DS7PR05CA0093.namprd05.prod.outlook.com (2603:10b6:8:56::17) by
 SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 10:32:17 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::15) by DS7PR05CA0093.outlook.office365.com
 (2603:10b6:8:56::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.16 via Frontend
 Transport; Tue, 16 May 2023 10:32:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 10:32:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 05:32:10 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 05:31:35 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 16 May 2023 05:31:32 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <--to=broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Mastan.Katragadda@amd.com>,
        <Arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Syed Saba Kareem" <Syed.SabaKareem@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/9] ASoC: amd: update comments in Kconfig file
Date:   Tue, 16 May 2023 16:05:42 +0530
Message-ID: <20230516103543.2515097-9-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516103543.2515097-1-Vijendar.Mukunda@amd.com>
References: <20230516103543.2515097-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT040:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 15e54948-06cc-4de2-a71f-08db55f8d205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HBYkGyEw6kC+fupeyIrHZiDsRr6DUsiAOejXXfhOtGd6iS2l8RYQEGuyZsWB5PBsub/tyibBGLwdJ2TYo1WriNUwLrKQUVeajR3rKWitD3bMkUqULjfVUaMqO7oR7MzwffLQA3ybE4haknPa/U0D54BTzo/x3NtJX2eviL9gV5KNo7K8y535+IWymF+nQAnXxyTqhHRTPK9pm4xuLPmr31puIYAlj/qMUzw5Rx0yeJWduo0570unCtOn7Gm/joHsqahSCo0Z1/XzGxXDVhbHr4o7V+OVSey/Tugzx3wCrUC6QthTZK4KtLrNqmXqC5NmukH9QJQSsCPi8wdBsT8bDfL7KgK4XTVjUK6e0WjBoaez463L5Ekc6h1SzwBVvPqT5/b/NBKHghVLSrP+QrSLH4SAbRJYiPkP+8hQVrpHyZQvqScYONKm7pUG1vKfq4uyAKV29eifhe0zYFzkERMhKeIspvPzP2ZqfzXFcP1d7HLDEsy+KKZ1+5ojClWgC6D3l6QBlUGUmeJapVhKfyRpqOA7fNinwoLUfCveDpaRT0G7MzOH6j5FwSfkR3x/c+WVS4iqu7eFLr9eSF65/8iyY57Fw18i6kISudwhwSPZ12fTE2pGFEkaNkFJXdQG0LiZ8rnjiDGP6hPqDt9k2Pk43hjBqUTT9TruVkPpIJ3zlFiAbgZ883fewpJmrPGm0BsShNJTSNFZ1IE8C9juRhAtFRxmEniEAK/6tQ91XQsLhG5d8B4yVUM/39sTUflmNFYsUYQmGIdWg4cXKXYMoKB5jg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(46966006)(40470700004)(36840700001)(15650500001)(86362001)(40460700003)(4744005)(2906002)(82310400005)(40480700001)(316002)(70586007)(70206006)(4326008)(6666004)(7696005)(36756003)(47076005)(54906003)(478600001)(36860700001)(83380400001)(336012)(1076003)(8936002)(82740400003)(8676002)(186003)(26005)(356005)(81166007)(426003)(2616005)(41300700001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 10:32:16.6112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e54948-06cc-4de2-a71f-08db55f8d205
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update comments in Kconfig file for Pink Sardine platform.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 08e42082f5e9..093a7273d53d 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -136,7 +136,8 @@ config SND_SOC_AMD_PS
         help
           This option enables Audio Coprocessor i.e ACP v6.3 support on
           AMD Pink sardine platform. By enabling this flag build will be
-          triggered for ACP PCI driver, ACP PDM DMA driver.
+          triggered for ACP PCI driver, ACP PDM DMA driver, ACP SDW DMA
+          driver.
           Say m if you have such a device.
           If unsure select "N".
 
-- 
2.34.1

