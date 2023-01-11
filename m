Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3C96656D3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbjAKJDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238219AbjAKJDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:03:03 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E80DA5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:02:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7+jsm+dettjA0n9OQD+ERtbuhKYD4ynQYAILJIZxoX3JJ27AdlZ3ON7xr8mPjrBoM9O1BKOC3JW6oY3esiAye9ce5CSaN2uPemifscVHmE1VeqgFwIfCMR4L8kVoGaiEfYtoBIujBc6sMSZNazaQXuB0qmGIDEc8WrC1owvYZ+VVd1GLp54livKOitr0Ir/sYQYElnqtPxQf6ghfCGbGWcYTHPbLFL9oPG8gmO13r1Xw6TlEEnpsfiPw3VHur0GQ1ndFdHfLcjMcKmBZr7ZDJc+LQPE+D3iYw39NqG3nPgSELWd2mhSd3fOoQ5uWT6SFdIcH8dabwqIT+PODXE9jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEscQLXyUmWUlrmGu2eNyzpYg5ma3d7Fyq0ZRxPKogc=;
 b=GX6M6iXSEON1U+FY1B4QgE5bMUrqd/VeqO3y1yc1yIKzQHtQHEAzbXwzn1wFxugjLWFOiiCRRsVICcP+C7swTq34VsJzQT5TS0/7aksGCnpbCX6pDUIi4+Wb4SI9eKRAe3qs7HsVI4kkFDVAjQ5+oZO7ASwW6HwbhWxG56piuyYKLkStKXWJ/dZuS6YGlTu5sxu7E1PvIrOZNUBXlpjDqvnkdBV9fEYkJPGDRO9r/DO0ZIZJU+KzY9AwJWXtSyNGb3NGB46iD0Dp2uP7eh85LuZCsAYx4fxhCyfNwf27gH3zHtreyAtA/pevMI6G5hoe/GjlpH+KJitjQRR1IeRaXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEscQLXyUmWUlrmGu2eNyzpYg5ma3d7Fyq0ZRxPKogc=;
 b=xXZ/eBGBdj3Dy5UQIL1Rtgb8XrSARppHfLfna+KIVsdynVz2sN2OwAJJJP3lrgtGksVOFp7Oidn8FdZdQK7wgfWZqncg4i7gdY9GgKSURrFQ4+m4suAWtTRykIBOLRUt+sBKkZLYGODzd068EDnOSrDmepIpjHctyJUL3+kQig8=
Received: from DM6PR11CA0054.namprd11.prod.outlook.com (2603:10b6:5:14c::31)
 by MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 09:02:01 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::68) by DM6PR11CA0054.outlook.office365.com
 (2603:10b6:5:14c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Wed, 11 Jan 2023 09:02:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Wed, 11 Jan 2023 09:02:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 03:01:58 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 11 Jan 2023 03:01:54 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <vkoul@kernel.org>,
        <alsa-devel@alsa-project.org>
CC:     <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>, <Mastan.Katragadda@amd.com>,
        <arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 12/19] ASoC: amd: ps: Add soundwire specific checks in pci driver in pm ops.
Date:   Wed, 11 Jan 2023 14:32:15 +0530
Message-ID: <20230111090222.2016499-13-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT024:EE_|MN2PR12MB4392:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c36e90a-ca22-4762-976c-08daf3b28047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rMY/HwGPUBEYupof5vNt2jGgvxv5tPvGiqmaqNOjEndCHlJZ5IK0Owr6PjitSheGXLS21+UscgzWAg5lsVrGf9pGY/+PDWst1EHmR/UVKyvsCebwTzkCd8vkfOTOGJqYeSIH6X1loMUpvAykw8IYYW4hflTLz1pNXTE38ViEAehl2NDNdiaID8tIjwbxEqQWpsi0VwJA297yFzOOo2e21Pae+SSzrZwJ6DTbK0RrpolTw33nBKUsO2/2rnJQyIsvCcOluNuaESY1s+9m8AVgvh1JDKMr8hd4HtZAutgQdQuE99rCuIXcp3RckouD8eYJaQvsgmyc/YmV/AqiUbvcO63vvzuRCchxGSDWHKjDvjj2xhOw9nMChyQ1yx3JtQ8iT/O+I1x3M9E3QQLuSF92to6QmN/CmSt3oUfn8iCCWC4+aFi/BjQOfwxWgFu5x3GHqv9rrny4TqRk35FS4D+mT4m7bpgBCAQ24fz+Qztkr0NvYRRS1tj94r0lHp4XMzJt241kFKH32ef4+55IO2+jKode9di2Xxekv4wJxjOa1Wxwfff8gy1YBFibhSJWeIbEQawOFWGkEYsrtW/ffgvg8lPAtMnIJZ/qfU2X6kZdPyc252OYfAwwxv6m5ew2D3i7tOpvSVqBMGCY8NzXa54LYexs2+AxNA+nKDRz8gQV5lE0PZldFoy8a42Cn/xzt1ZoySyKnPRmRCGG+Uru0xLW9joIjqMRrVA/Mls7wAIdsiw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(2906002)(54906003)(36860700001)(41300700001)(356005)(7696005)(36756003)(8936002)(8676002)(70206006)(4326008)(70586007)(83380400001)(1076003)(82310400005)(86362001)(2616005)(47076005)(426003)(336012)(40460700003)(5660300002)(40480700001)(186003)(81166007)(478600001)(110136005)(26005)(316002)(82740400003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 09:02:00.7469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c36e90a-ca22-4762-976c-08daf3b28047
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Soundwire controller supports different power modes.
In case of Soundwire Power off Mode, ACP pci parent driver
should invoke acp de-init and init sequence during suspend/resume
callbacks.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/pci-ps.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 5b82ee8e3ad8..7e152241c155 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -655,10 +655,15 @@ static int snd_acp63_probe(struct pci_dev *pci,
 static int __maybe_unused snd_acp63_suspend(struct device *dev)
 {
 	struct acp63_dev_data *adata;
-	int ret;
+	int ret = 0;
 
 	adata = dev_get_drvdata(dev);
-	ret = acp63_deinit(adata->acp63_base, dev);
+	if (adata->pdev_mask & ACP63_SDW_DEV_MASK) {
+		if (adata->acp_sdw_power_off)
+			ret = acp63_deinit(adata->acp63_base, dev);
+	} else {
+		ret = acp63_deinit(adata->acp63_base, dev);
+	}
 	if (ret)
 		dev_err(dev, "ACP de-init failed\n");
 	return ret;
@@ -667,10 +672,15 @@ static int __maybe_unused snd_acp63_suspend(struct device *dev)
 static int __maybe_unused snd_acp63_resume(struct device *dev)
 {
 	struct acp63_dev_data *adata;
-	int ret;
+	int ret = 0;
 
 	adata = dev_get_drvdata(dev);
-	ret = acp63_init(adata->acp63_base, dev);
+	if (adata->pdev_mask & ACP63_SDW_DEV_MASK) {
+		if (adata->acp_sdw_power_off)
+			ret = acp63_init(adata->acp63_base, dev);
+	} else {
+		ret = acp63_init(adata->acp63_base, dev);
+	}
 	if (ret)
 		dev_err(dev, "ACP init failed\n");
 	return ret;
-- 
2.34.1

