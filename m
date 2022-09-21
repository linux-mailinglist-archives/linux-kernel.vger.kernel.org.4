Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C13A5E549E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiIUUl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiIUUlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:41:03 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2855A9AFF2;
        Wed, 21 Sep 2022 13:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHivs/eellJJzBlQmnyIACrjz7S9GWV8tn4l4q+ret0jR7kUfLhIkHDd3YejW1FDfaCIC7cA3UwAGIheWOzdra2KbczBsh2bHtu6Kj32vmBNV0HkDnl+HfkuzzpJAc8K0SlPvpmBCI5S9dvhicZhEKUYYMf6tvQWK9kmWBG+CQq4Jh4KMekfg1ihXrnhKhlpy55PsizmCv9nT40jVz068ezCFaJ27CpeEhMXaw8XL+ce+1y6h4TDQ8C7k0IHI1V1uUCI3VOWQsyVagguFe2XJsol09IOnNSOcuHsR4gpUi+OsUBrdSEtHpvl3CzYqEAySYcl56OC/FrkyX2/XTL4QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmAk/8L+coGzY4tBa8Q4np3URFhbQsc8/wCA/KWjjOc=;
 b=FFcScU1vrWMR2SFR/FB0aIdARgq2gVL/zaLtwY1Q5QRB73bCokhYGG2Ze6RCTAlRX+TMWJ2VLulIFGnFS2jfhbU353g6hrfx26RXVIjwNYlPpXqcQeCp92EPr/lYEyx8rP9tSWy/Mdq8S4pTHb3evVC5uWtgwyhpoABu18Jl20d2/UNXqVj1kOhZp07FKZ78sKU8MyboVObboJF8sZYcWa7yZHt3er1vWVw/RZYqziLUJlYa2wSigWJbc2NZmA4Ks/Y1aEFpajPtt77K1jWGp15nbmdJetlEuK31410eoFZE40rnyBPefgNhtEXQyWDv/tok+Xe8WPrfVlaMJOvZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmAk/8L+coGzY4tBa8Q4np3URFhbQsc8/wCA/KWjjOc=;
 b=ev6j2hJFlvmD/KDcHn30BlIQChbx9UqkVApT9Nh10tOgiC8BNstEZc85LcPya18cXR0RMkT5UVJ+p3Jf5ZORW+vLKsr6LOZakE/lsylUi60H2lkbNiubJjT9JvyWKCTvRZkGEPbiTwiPWwC+1r5VMR2usRU73c6U9HBjZT/fnhg=
Received: from DM6PR07CA0095.namprd07.prod.outlook.com (2603:10b6:5:337::28)
 by PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Wed, 21 Sep
 2022 20:40:58 +0000
Received: from DS1PEPF0000B077.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::9e) by DM6PR07CA0095.outlook.office365.com
 (2603:10b6:5:337::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Wed, 21 Sep 2022 20:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B077.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.11 via Frontend Transport; Wed, 21 Sep 2022 20:40:58 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 21 Sep
 2022 15:40:56 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <travisghansen@yahoo.com>, <catalin@antebit.com>,
        <Shyam-sundar.S-k@amd.com>, <ruinairas1992@gmail.com>,
        <philipp.zabel@gmail.com>, <iam@decentr.al>, <hdegoede@redhat.com>,
        <davidedp91@gmail.com>, <marko.cekrlic.26@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v4 5/7] acpi/x86: s2idle: Add a quirk for ASUS ROG Zephyrus G14
Date:   Wed, 21 Sep 2022 15:40:52 -0500
Message-ID: <20220921204055.22889-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B077:EE_|PH7PR12MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 07370bd9-2f66-4088-133e-08da9c1196cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/iIKjEsRhy0Dz3bh3cr/lkBZvwM7iOTZfMi6Gx0PSu96IPG1KmiJ0g+WfvxLSSZ8ZYjgWRoQUiBUUok+W5+vD5Pxt6fPoef0r0+8aBqAB5ZEW/dRLTuqcrjvLSn9KMxkG9/oiA0kuNvGh8bthHhkYf8A9B+glAXBWcNuuPpCiQJWOco3i/cuNAgjEvm/Zw3+1UQ01FgG3lCw2R3RQ84I83418yPxkTbfWl+vnZBY8cD9KVxWIUncvmGCpkm32lzrxtmMBgCKoXr1D3Vk4vhZm+wzsXLWjjllYjBbkUbTaTRJJH0KZWvvHdm3dnSQ91/bX/glrhrmeuVtWB8tDQlO6mfcFe4iZpVoFGcFQBSB6XrmwaGbmnwhn5b67Jx2uS7fICoU1Ntb2gvlwD6QiYBTVwFQyDL6uXgUPwUNgU3e/D/MhGA2gTpNADL7BTrM2VzYzalnAJEVrplFwWAsG+hpB1QoVohDuYB1f2UeiP2H/ebn3e02MLl1Bm4UYaSZB3MvJ8GXCoY+wEkDrFzbsmTcYlIB8Sn5hHg4kMgtgJUv8tGVF6W665fBXhp8DCTDWiQJ/RF/pfSz2nPG+QDXAzzZd/B6iR0icvmpsiPTyEVSGGGDSQwPVhBq2O3EQDPYGO9ic/qwdA1CjjE1YDdaNdi9MwULcHCKJ5BFqLda0q3yfDqayUb5rO0E9MPFdLpVyyTAWyYIpvowp4Z1oFDFF+bDVeLXaKsKSv9mK0jflzDo/c/QDEFglT4+Qj/arW010Ea/CBFystXe9hlcEc2s0c9u3M4S1OegIEdB5HI1lB8+GArvQxs5iEq3uxbRlTTfHG6
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(8676002)(36860700001)(44832011)(478600001)(186003)(70206006)(54906003)(36756003)(70586007)(45080400002)(86362001)(41300700001)(356005)(8936002)(4326008)(7696005)(81166007)(82310400005)(26005)(336012)(82740400003)(40480700001)(16526019)(110136005)(40460700003)(7416002)(5660300002)(1076003)(6666004)(316002)(2906002)(426003)(2616005)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 20:40:58.3808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07370bd9-2f66-4088-133e-08da9c1196cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B077.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925
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
Tested-by: Marko Cekrlic <marko.cekrlic.26@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3-v4:
 * Absorb tags
v2->v3:
 * Absorb tags
v1->v2:
 * New patch
---
 drivers/acpi/x86/s2idle.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 99eae362de6d..2cd381f6c002 100644
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

