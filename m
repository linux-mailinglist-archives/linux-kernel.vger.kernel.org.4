Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589E3739F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjFVLf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjFVLfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:35:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8651FF6;
        Thu, 22 Jun 2023 04:35:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFjhgLoMvpDC7rx64XJfVzBwV4Flwek7cbmwU83p/wbHvKpXiQNiR3QIMxCA0BSlcvhuyusRPUnUhefzvG7SToAioncwnF06rhVgq2RMs6hyhoJ3emcJazuJy3hdgVhYRPMa32djaPYwesFu3w0kF1av90aI3mkpw7MmUasWl2lqBqBYKje81I2XmFB84vr5IMTMQsBX+apnKkHC6J39bpj5OMIqpKJaiXNGEvxxNQdlXDwpl81H01EIqoyT+sAtPGn80V1TARqPh31fzhp4ar54qdeCqaJ8hlQpqGwZN5zJZfPHXKFd6pCxyCuyLE9ZNR8gJgMPy8WMzxEqWr9+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7ppIOpxkReXH53/Uf+9c4/6ZtALXoxCJd6bx/S32KE=;
 b=h9i8z8N6cDxWYRonR/JVPeVxe5uw/AGPae92qNlz5e7DPD//K1tRJ/pg7K4cjtXE5CrqoNRopPYvJR+zEW4PEMKq5PDy8+BY3DjhdcGAQgfivkY4VECVIYwQQCTZQgOXr9bnoPRuwi8VfQzi8yccp+gqSgmQuFahc1h34qDCCTQHYtRtyeTtWKY3gCRznMtuaEET6THH19s5oIiP4ED+Jj8NKiMaZHZ39ealLJqDvKG/86v61uehvpaLZGLvZFE89193s1DmtBjRusbl5w1qIKwYgSlebxNyIeuD9VVvYbYlLIiHpSgCNgIkZ6hAPND5QECDC6V1mpM3vvGHteIIxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7ppIOpxkReXH53/Uf+9c4/6ZtALXoxCJd6bx/S32KE=;
 b=DFqLjsSJ/1aJeMcYKgmdWOcV4G99RoDd6jg8L9gxxNV8JrzDnA4AdGzuHRRYMwIedSN29mdxrufxRVw0Audik3IfkSLMpzXFvPm45v8/l1UsoBcliWwJBD7w/46cwo9YIAzHA+VR6wuX7Fm2EfXe+ifDui7s5iIKQJR4vIfwMBmM6RuXQlLHpdkeTb1+qhgb65njNSFP4mFe3WYSy0WMk6solzIlBnByxgh3fNY90aDO69qDDOl1Zx5ExIveqwjAQBtGJ04vbfvbtWBYvWKJq64FNlRKjOyvexFl/uhXtYZkx954duhltyH0wAysce70yPsqp1IEmoUi2o7613BkNQ==
Received: from CY5PR14CA0029.namprd14.prod.outlook.com (2603:10b6:930:2::10)
 by BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 11:34:43 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:2:cafe::9d) by CY5PR14CA0029.outlook.office365.com
 (2603:10b6:930:2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 11:34:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.20 via Frontend Transport; Thu, 22 Jun 2023 11:34:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 22 Jun 2023
 04:34:33 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 22 Jun
 2023 04:34:33 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 22 Jun
 2023 04:34:29 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <tiwai@suse.com>
CC:     <jonathanh@nvidia.com>, <mkumard@nvidia.com>, <sheetal@nvidia.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: [PATCH 2/8] ASoC: tegra: Fix AMX byte map
Date:   Thu, 22 Jun 2023 17:04:10 +0530
Message-ID: <1687433656-7892-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1687433656-7892-1-git-send-email-spujar@nvidia.com>
References: <1687433656-7892-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|BL1PR12MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: cb777f37-3da4-4661-04d4-08db7314ac50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2qvgThMGhmD0lTzSeLNUEcLghPSMtDNCBou+5EGbX05a7PyKqBNumAmHhO9KBLOpiJYVDuRSzjIO+4omBR6pAvcqfCx7ZjuXt3uX90kCtSWJCW292ToIXKwTwyAbCrhzp8vis2bcl9PYTC5DXo8jiAIDhtMvP4II6+hjZMV9v1sKNZQ+ywWXJjC6gozhugLyNWtnbixS1NF1fbvpcEiTgg4Eu8ho8PnVG6JbTkih41yJncVzH5FG7E2SlMA1zwN1uy+RTHOGcZxDATAk1XquyIIcI6ECIqJHwSDF0VkxUaKJyOOdboCGEaAjMdWuZvuSlFFjdQw4sxvH7xGbLILRicAwyhHZZXw2JSiHh1h0NaTvG7MIyB60CSM1kBdbSseuIlc/Vi049EBb9mMISSaUxSyqLcE9dbkyTPx4PbgIehq0VQrtBxxcr12N9Spogm8bv9YcBkNPG8kwtGZ0lBopLK6DigDi5Qdu3051vl1avUqpRCC8mHrrvbM8PO7Nfg6mrsGEjjtyn+LL+zwJVbQ37F8owCcm7dvCGpqIvPKyBX+oJ99I54E2i7FnTHf9xM2E2xs+KT3V1PaVNBXhW5AlIuXts64HnFSU+loaH3x6O2uLplzbj8RxKPAwQ0DjpC4OMx5ccw2o53L+I1wEKaRGqOj9PEPNo+9TqU7hiEc4oSKr6n2S28tzJT4tr0fhxUoo5z42JgoluOGXvu5xogV06dw8rx+kB2GI259vb/wtIwQxqgvMAwmG3uDynyG//anZ
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(36840700001)(40470700004)(46966006)(40480700001)(8936002)(41300700001)(8676002)(186003)(40460700003)(26005)(2906002)(86362001)(54906003)(36756003)(110136005)(4326008)(70586007)(70206006)(6666004)(316002)(356005)(478600001)(82310400005)(7636003)(82740400003)(7696005)(336012)(426003)(2616005)(36860700001)(83380400001)(47076005)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 11:34:42.9428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb777f37-3da4-4661-04d4-08db7314ac50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sheetal <sheetal@nvidia.com>

Byte mask for channel-1 of stream-1 is not getting enabled and this
causes failures during AMX use cases. The enable bit is not set during
put() callback of byte map mixer control.

This happens because the byte map value 0 matches the initial state
of byte map array and put() callback returns without doing anything.

Fix the put() callback by actually looking at the byte mask array
to identify if any change is needed and update the fields accordingly.
Also update get() callback to return 256 if the byte map is disabled.

Fixes: 8db78ace1ba8 ("ASoC: tegra: Fix kcontrol put callback in AMX")
Cc: stable@vger.kernel.org
Signed-off-by: Sheetal <sheetal@nvidia.com>
Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
Reviewed-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/tegra/tegra210_amx.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/sound/soc/tegra/tegra210_amx.c b/sound/soc/tegra/tegra210_amx.c
index 782a141..1410e8b 100644
--- a/sound/soc/tegra/tegra210_amx.c
+++ b/sound/soc/tegra/tegra210_amx.c
@@ -2,7 +2,7 @@
 //
 // tegra210_amx.c - Tegra210 AMX driver
 //
-// Copyright (c) 2021 NVIDIA CORPORATION.  All rights reserved.
+// Copyright (c) 2021-2023 NVIDIA CORPORATION.  All rights reserved.
 
 #include <linux/clk.h>
 #include <linux/device.h>
@@ -206,7 +206,7 @@ static int tegra210_amx_get_byte_map(struct snd_kcontrol *kcontrol,
 	if (enabled)
 		ucontrol->value.integer.value[0] = bytes_map[reg];
 	else
-		ucontrol->value.integer.value[0] = 0;
+		ucontrol->value.integer.value[0] = 256;
 
 	return 0;
 }
@@ -221,25 +221,19 @@ static int tegra210_amx_put_byte_map(struct snd_kcontrol *kcontrol,
 	unsigned char *bytes_map = (unsigned char *)&amx->map;
 	int reg = mc->reg;
 	int value = ucontrol->value.integer.value[0];
+	unsigned int mask_val = amx->byte_mask[reg / 32];
 
-	if (value == bytes_map[reg])
+	if (value >= 0 && value <= 255)
+		mask_val |= (1 << (reg % 32));
+	else
+		mask_val &= ~(1 << (reg % 32));
+
+	if (mask_val == amx->byte_mask[reg / 32])
 		return 0;
 
-	if (value >= 0 && value <= 255) {
-		/* Update byte map and enable slot */
-		bytes_map[reg] = value;
-		if (reg > 31)
-			amx->byte_mask[1] |= (1 << (reg - 32));
-		else
-			amx->byte_mask[0] |= (1 << reg);
-	} else {
-		/* Reset byte map and disable slot */
-		bytes_map[reg] = 0;
-		if (reg > 31)
-			amx->byte_mask[1] &= ~(1 << (reg - 32));
-		else
-			amx->byte_mask[0] &= ~(1 << reg);
-	}
+	/* Update byte map and slot */
+	bytes_map[reg] = value % 256;
+	amx->byte_mask[reg / 32] = mask_val;
 
 	return 1;
 }
-- 
2.7.4

