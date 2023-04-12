Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F37D6DF036
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjDLJXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjDLJW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:22:59 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E57D91
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:22:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNFO7idDx4vnZQFKefBntmORqh6BohHtI8F6/ouBggrHqskhduk67Zb6DP5d7hE67666IjHpAuGy3ediYhIv1ErZ+PVCTnA2S+f9TMumCNK7uI9QYCtXgGxPh3gpGZUUbBsDsQi02Wz787zmWzwQpDtdLnRy/uls2DnLDjeN/XMNtPmXlEUyVctrRM/s8QYfu4q/gOve2OJilJLHHPyfTsagNtMiU5y0+Kc8H4d/mYg3Rzfby5uVT6gp8zKTSj+/EoTyZXJo7s/t4kbWtuBWlqLI9zCbG+RTVGSO8vc5GY7uAlAS5d4iDwaZc2w2BZYteobqrPDZEpGKhx/ELlN9Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSZ7pKzc3Wk3mYFuiWlcvqqtZrrTvSCCfaWQ/MIpp18=;
 b=OGAGZg+h2YknMYoM3XiAId/WnwbUoDwJY0wZdAJrHxzWeFkE7Xw+9URWixe9jQiFOB5/ZGMdhVnXBvPeMm0rN8BYRKXyr6oOIulj9dfIdDq6/BOmjJ5i9+pOS9kkogthnbXGVbbNCzJSi0MQekJ0ie9H+vIf0sub7yCHYVz96y0otxTHKcf6rmA+clJB1JQDi+JyBs/1CKUyGxdI/h/J7Y9Sf5YOqCCY4LVBJUAPBCq4VT47hxlYbCGwTzCZ9n5eFLlcwzcIE46Lh0zlDyHGGJgMJB4WpTcbAGqxJ6JFpD6GYkhSrquh5SwH2rTIPNuOxmb4X/zapRdFQJmlVW3aEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSZ7pKzc3Wk3mYFuiWlcvqqtZrrTvSCCfaWQ/MIpp18=;
 b=bcE5tzUtfASnSfE8wZ1N3CjPXQYJD62InoI8PggksVVdlKyQgjTVKyAvwhpDrbd40A/MQIt06whhpZ31E1J1tEnBekqcbkodLkoZIaL5tG8QPxs5v6cKUgY0Bf7eexHrAJDHMNmHENBOawauMOgbfqM12yFq+98FczhZ6A3zwCk=
Received: from MW4PR03CA0092.namprd03.prod.outlook.com (2603:10b6:303:b7::7)
 by DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 09:22:54 +0000
Received: from CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::fc) by MW4PR03CA0092.outlook.office365.com
 (2603:10b6:303:b7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38 via Frontend
 Transport; Wed, 12 Apr 2023 09:22:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT103.mail.protection.outlook.com (10.13.174.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.28 via Frontend Transport; Wed, 12 Apr 2023 09:22:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 12 Apr
 2023 04:22:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 12 Apr
 2023 04:22:53 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 12 Apr 2023 04:22:48 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
        <vsujithkumar.reddy@amd.com>, <ssabakar@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: Add check for acp config flags
Date:   Wed, 12 Apr 2023 14:46:16 +0530
Message-ID: <20230412091638.1158901-1-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT103:EE_|DM4PR12MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c5d2a7-4942-4ced-329b-08db3b377f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: blJyLA/524ERpqygHMoTKE9eAoQrvgrVuvh5xYtjWGKUr8PvjJiS+e9/oZKDDnem0BAzXLiR7pin0kspi9MGNUOGkFrEGGjjQi1lmmTkk9s7eN39a6oEcCvpbJb6Tw4IIWsuek3jX1HMJfqfvOeystZmDcp9EWTExpKK3s3Kq+Mfh3hpU2XpcuSZDWWeb1WTGFpOdXMp/GpVLdi44a9KNTC1cX/Xh5Jn7xDrpdn1o8a1ItgUtIwccu00/PPBMaf91HGX6XUe0OINmCh+cD6lIMIS6U/vnN6fnaLf9XYYy7I6I47qL/uZMa4jQSUgTEDp0sxT7E4OHlYonUuajMrcRCinw/FwrNjGm9anGGYD3J8AXtG/N5VrO9J6orYdMeD8xhYnmOjcH9Y73QM/eY2cUJMZ7QvifDhwLkZWa6LFYXVu8S1+7Gslg/33AjUAtZQEHope2hJKK7rN/w3U6Dhkj9Vqkad9cRhS8/6ASJNtvt3nZusUUBe8wCAdIHsp6Grpuy/Cj75qM1ELdU5Yht1nFjZD5YNnZdntr1kimH3jcJ3u8WgUWrwTa779tsIueNJISoC/zPWCqoyYlLNbIUiQsHhG7yxkTEcYMQDjJZQ/yIAbzgmU3lxtYLVhtX6Ysn8SlLJ53JljRs/u8ahTFDHGb2aoCjafXuduFaWDaJxJbdzt5y5bYPzme4cNZuvj4WgCtNITvhScztbUB2Ccts6dusdBkjqH+QQpafF5LPe+PGQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(40460700003)(336012)(83380400001)(2616005)(47076005)(426003)(478600001)(186003)(7696005)(6666004)(110136005)(1076003)(26005)(54906003)(316002)(2906002)(36756003)(5660300002)(82740400003)(356005)(81166007)(4326008)(70586007)(41300700001)(82310400005)(70206006)(8676002)(8936002)(40480700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 09:22:54.3264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c5d2a7-4942-4ced-329b-08db3b377f1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have SOF and generic ACP support enabled for Rembrandt and
pheonix platforms on some machines. Since we have same PCI id
used for probing, add check for machine configuration flag to
avoid conflict with newer pci drivers. Such machine flag has
been initialized via dmi match on few Chrome machines. If no
flag is specified probe and register older platform device.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/Kconfig        | 2 ++
 sound/soc/amd/ps/acp63.h     | 2 ++
 sound/soc/amd/ps/pci-ps.c    | 8 +++++++-
 sound/soc/amd/yc/acp6x.h     | 3 +++
 sound/soc/amd/yc/pci-acp6x.c | 8 +++++++-
 5 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index c88ebd84bdd5..08e42082f5e9 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -90,6 +90,7 @@ config SND_SOC_AMD_VANGOGH_MACH
 
 config SND_SOC_AMD_ACP6x
 	tristate "AMD Audio Coprocessor-v6.x Yellow Carp support"
+	select SND_AMD_ACP_CONFIG
 	depends on X86 && PCI
 	help
 	  This option enables Audio Coprocessor i.e ACP v6.x support on
@@ -130,6 +131,7 @@ config SND_SOC_AMD_RPL_ACP6x
 
 config SND_SOC_AMD_PS
         tristate "AMD Audio Coprocessor-v6.3 Pink Sardine support"
+	select SND_AMD_ACP_CONFIG
         depends on X86 && PCI && ACPI
         help
           This option enables Audio Coprocessor i.e ACP v6.3 support on
diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 6bf29b520511..dd36790b25ae 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -111,3 +111,5 @@ struct acp63_dev_data {
 	u16 pdev_count;
 	u16 pdm_dev_index;
 };
+
+int snd_amd_acp_find_config(struct pci_dev *pci);
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 688a1d4643d9..afddb9a77ba4 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -247,11 +247,17 @@ static int snd_acp63_probe(struct pci_dev *pci,
 {
 	struct acp63_dev_data *adata;
 	u32 addr;
-	u32 irqflags;
+	u32 irqflags, flag;
 	int val;
 	int ret;
 
 	irqflags = IRQF_SHARED;
+
+	/* Return if acp config flag is defined */
+	flag = snd_amd_acp_find_config(pci);
+	if (flag)
+		return -ENODEV;
+
 	/* Pink Sardine device check */
 	switch (pci->revision) {
 	case 0x63:
diff --git a/sound/soc/amd/yc/acp6x.h b/sound/soc/amd/yc/acp6x.h
index 036207568c04..2de7d1edf00b 100644
--- a/sound/soc/amd/yc/acp6x.h
+++ b/sound/soc/amd/yc/acp6x.h
@@ -105,3 +105,6 @@ static inline void acp6x_writel(u32 val, void __iomem *base_addr)
 {
 	writel(val, base_addr - ACP6x_PHY_BASE_ADDRESS);
 }
+
+int snd_amd_acp_find_config(struct pci_dev *pci);
+
diff --git a/sound/soc/amd/yc/pci-acp6x.c b/sound/soc/amd/yc/pci-acp6x.c
index 77c5fa1f7af1..7af6a349b1d4 100644
--- a/sound/soc/amd/yc/pci-acp6x.c
+++ b/sound/soc/amd/yc/pci-acp6x.c
@@ -149,10 +149,16 @@ static int snd_acp6x_probe(struct pci_dev *pci,
 	int index = 0;
 	int val = 0x00;
 	u32 addr;
-	unsigned int irqflags;
+	unsigned int irqflags, flag;
 	int ret;
 
 	irqflags = IRQF_SHARED;
+
+	/* Return if acp config flag is defined */
+	flag = snd_amd_acp_find_config(pci);
+	if (flag)
+		return -ENODEV;
+
 	/* Yellow Carp device check */
 	switch (pci->revision) {
 	case 0x60:
-- 
2.25.1

