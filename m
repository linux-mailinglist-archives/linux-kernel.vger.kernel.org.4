Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97356656CC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjAKJDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238257AbjAKJCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:02:02 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E53012ADC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:01:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7fbOjRixELdt0G9zXxEhNbhHeN8q6GmP27A6Sbj79mlzE8gBlQj10QV6c33O3zz2WzszGj7Qmfdt04HewCijybG04eSWqubrYpEic+jzaP7MDA1jPLbmheoC87EGxA+2bdXYZRmFa5nnLQCN4VWus4oDuOr+Cydxgrd249W/e4fp41yZ0PwkdjByigfao9smmPy312PJglTFm4I4PPkbglToDh/j6NsXqarJLUL9afFy0jxZ2PAVpzhFDcA8rcp5QGiHKyI9+a/9k7ugb8bCYW7gg/jYf5aPuYnHMSVf296IwRaalFWbZXpw+SpF5NIhO1uiGwIOEz+F+1S9tuCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8FKM8p6lvQFixka7PVxUHl/w3rLXcJGY/h61/YHaJ0=;
 b=BGjebrrV9wJ+6RM2EH5dUB9MhKkzG5YfuFnJ/+PCgtAIoEfDuxQXqv/Fcgt00zeAM77FcpNj7xZ53/ymnFSTl0Mke+Lrz86vT3oe3BV5LqYwZj/YGi2wyOSwY5C7HhS6T73NAPIXuS/GzGlE4gjdJuiP+8B1I7OIGowtyvbQVbqCXULqM2j0ECE9Nhp1bdfm2fcuIb8/LhmLXjIPg0yPCmv9kcv3iUPlBvlM+7TExP4dwpCCnX5jtBVfknpqjLDO1Oa4SG1/ye1K3pGEADj6YcR40sRTTR+duvgWV2FaBadsmEZ0i0RhvAMMBIyoo6QOSSVuj8+FqeT4Bwgy6bN7Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8FKM8p6lvQFixka7PVxUHl/w3rLXcJGY/h61/YHaJ0=;
 b=OGPesfv/izQQwdqF7RmF4R219n8hcWmFB/uE7torUNcUph9RYTcDewRge+zT+2eJGfINdAUHt2c58ueSGbo12XzQdg+hSaaVqjna25O3hJjdw2EF3g4mAs2A+BhTjym0C11RQWGylPoVBqNEgmr6l+4/ErVXO82j+h3Fr3/Az4o=
Received: from DM6PR11CA0056.namprd11.prod.outlook.com (2603:10b6:5:14c::33)
 by DM8PR12MB5479.namprd12.prod.outlook.com (2603:10b6:8:38::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 09:01:53 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::ee) by DM6PR11CA0056.outlook.office365.com
 (2603:10b6:5:14c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Wed, 11 Jan 2023 09:01:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Wed, 11 Jan 2023 09:01:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 03:01:51 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 11 Jan 2023 03:01:47 -0600
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
        syed saba kareem <syed.sabakareem@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/19] ASoC: amd: update comments in Kconfig file
Date:   Wed, 11 Jan 2023 14:32:14 +0530
Message-ID: <20230111090222.2016499-12-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT024:EE_|DM8PR12MB5479:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce74972-8cbd-4fef-0e7d-08daf3b27b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMBo9/cc5GE1//KQqKt7iU1rkYp+7kFfPBJFGFi4a7YwKHftCHqafJ0UExomwEoQcLcLkl1K69499MQ0PSE2G00DwUdcx0LypqvhRveNR8OMV9RWSHMxoTjJIcATWOZA7lUSjF34EkmiR1N6V4QKS0m+nLlBa8O2y55Bx3bR1OGYbpYMZxQXXrypr8NcWrW0yaUmmlpV6PsVEXGKwlAbIttvBMI9+FXs1MQdSghilueTTfZ6nLdlG0D+chyZtHEJkRbI+M9vpwlCDiErkVFnewP7gN9EEMTPt7b6pYuF08P0NW396G1YRgRbu7uuGo7IECLtyKqycYocopDrtRghvWX4WRVJZOJq7wm7szMQQE34pX1bkg+b7Tc4FkwKDGN/YZm/0JM64eQs3EIvZzkhbwP42A2H1n05b7rm6AM6ZGqunM/zLhvRtkk97zGxINqO03rMy77DSvSO7xwxyRFAuwdZC6cNxATwolwE3xr9/09LcWsksf1rS4oqsBera+RcNNIydEY1itkjmU6haiGn/4uGkOsJ4AnWrTTENYpQ1i/HIupl+aAr2eRIyFEUjOalLkCS3Tyos+5lukTgPLHOBGCcsikAY6Bs/+lhHwid+rn6XSnAl8u72GxLf9vOBdMLg5RNhwY0xE+NupR9ODLU/oLi4A4ysFrOFMWuSg8ebjs2uKGmM16H9ICjugcs6zvj5mK1+UGD8CFp8XbSURvVJwqKLKX4/0605SBO1SdP9ns=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(47076005)(8936002)(2906002)(5660300002)(81166007)(41300700001)(426003)(4744005)(70206006)(7696005)(316002)(4326008)(70586007)(8676002)(356005)(15650500001)(110136005)(54906003)(26005)(82740400003)(1076003)(40480700001)(2616005)(336012)(86362001)(40460700003)(186003)(36860700001)(83380400001)(36756003)(6666004)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 09:01:52.6693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce74972-8cbd-4fef-0e7d-08daf3b27b77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5479
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update comments in Kconfig file for PS platform.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index c88ebd84bdd5..50bcec55a275 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -134,7 +134,8 @@ config SND_SOC_AMD_PS
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

