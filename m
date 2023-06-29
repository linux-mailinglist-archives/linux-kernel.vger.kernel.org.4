Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A5F741F9E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 07:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjF2FNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 01:13:16 -0400
Received: from mail-mw2nam12on2044.outbound.protection.outlook.com ([40.107.244.44]:45825
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231655AbjF2FMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 01:12:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEXpULa6UxcL32cbgXgqXdEExXRCuej+uRQ9cobaxQ1aPpXsao+VJMzlaXCzhL8gMQnghnnlJzNp05VMiyvnoJStca1vNC7BPQ94OnWBi2e6Y3wCI/UvWdL54ldS7FL7Io9nfPLeYj/A9vzWwvn0QNh/x2NdROOpqQqwDUuEWRub/Nt9QQjteK/OKxrS/Ydo5BRSaSPZJnNNVPyUjKZNaBF0VyAInGnWQiwbVBLVSIGbEMSMYcirwKTSbSwqlxIP5El9E38HXbrrOj/i7Oc101eQQYUZSulKDKk9e/SHLozovwn6yV4k7bXMqKHqtt9pDptPE1TzH6CrkTL+WauoVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECdVB3XMFdKCZs4HiexmMhy89ZPUmz/7lvXEcH0P0Ew=;
 b=RuJIr7Gj4dEu9gWQMgVyOZ7o15t1V4KHJ64pcIGbB1ozuUJr2d3XjuUH1U/eZxHYcaZ0DKa+aF+Mpp0bnJ3RW/t1pRbK8yAj/6vNciCyZHkIXuuphZ+j9gOKGcizYH/VwPJuRL8W1GoAjSA0cMuh0B2mOZyz8PwTtFFLpzUNzxn0qbntj2iwBJ59JGSzhiD+2QUPyFAyj0SBoDZ/gQ5CebBj+3CsMir8hw3p+nvIFvjaSwReIJHmFo2TRq6ak4eooH4LbdrJFVeSoihjBJpWFc/Zih8LYLBmBEbElsrOyJowWHxxd9qd665SVeeZV6XT741VfkP76cDO14CJZ9L/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECdVB3XMFdKCZs4HiexmMhy89ZPUmz/7lvXEcH0P0Ew=;
 b=a6zMNAO7gp7YVcF+rESewWcVBSde3Xi5OjA2qkeQ2vL+PaPYV2cJRWNZA2PNPHxxKdwOhM4BDk6CoCJyGttBDoFZhhBb1Zx310zqi0/ZUZ7YMvnMlXcEFO9XgwhaZkKuKjLDn6Bydb+EhxEaEFx3svpgaVWHRGrvCvRFb2R/bfDx31HVBmCPdZEe+HRgeoOqqTvE5adzzOKdMOR2VaL3EGVq+Gjs4Iiw3hc49GHG007LoheGgKwg5FrnVP5Y42d1ViMoAAbJZRozHYuhMfkSxrfnyujQrbN3EFrfR9IF9K7x54LzUQwlxaWf/H+ZSm75sPhGqyGDd1LQHn/0TeuTlg==
Received: from DM6PR17CA0030.namprd17.prod.outlook.com (2603:10b6:5:1b3::43)
 by BL3PR12MB6401.namprd12.prod.outlook.com (2603:10b6:208:3b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 05:12:50 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::cd) by DM6PR17CA0030.outlook.office365.com
 (2603:10b6:5:1b3::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Thu, 29 Jun 2023 05:12:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.49 via Frontend Transport; Thu, 29 Jun 2023 05:12:50 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 28 Jun 2023
 22:12:40 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 28 Jun 2023 22:12:40 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 28 Jun 2023 22:12:36 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <tiwai@suse.com>
CC:     <jonathanh@nvidia.com>, <mkumard@nvidia.com>, <sheetal@nvidia.com>,
        <spujar@nvidia.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH v2 1/5] ASoC: tegra: Fix AMX byte map
Date:   Thu, 29 Jun 2023 10:42:13 +0530
Message-ID: <1688015537-31682-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688015537-31682-1-git-send-email-spujar@nvidia.com>
References: <1688015537-31682-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT019:EE_|BL3PR12MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: cff92479-bfc6-41b5-d28b-08db785f7c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MzMXUHTe7ulcIia5sRULdACtI4ITWib+pqe6zQtNPN1LPAvcYUk2O1X5/6y3i5flGM7hdhGBgssOQB3UO31JO4/5iazPt+JXJWu+Lthrm4dn1y1BWb0qdI8H0P6ZP6l3sEi8y0grNCHlHI0H7QcFng+6POUeP2viJQMF6mS7SEVt+YdUUSLbf4IZIZdkq1S7W1GquXKN2QiLHBpP5l+OMep/AKz+E4LcwbcgUcdu4MjlpgbY7UVmAStW4mvgprGQ3Cqe2FzGxnvmCmIu+e5pZQ84CKNQh7f7MvrMDye2K/Oq77HfPSy9xJHMHM3T5VDd4u5O6gmtRBudWuoXx1p1dWrUHJi/G3eLymNjx1DPAUA1R3WNIlal4u//ooluXdwl1xaSyhO1QkDPnnyGFe9E3JsbmKGj9jmGItfBwyq78nm5+cA4vwHQWkn6WI39Jql3qj4h23Rmibe/7luSwCMJlYvFPRfKzDxsEjRiQCi8JkHmRvTdKhw0mnYC5J9jrVOYcw1YM5X4NDxiSgpsikRJgyQ/Wl5FJ+09iARdaVIRiF7sDmfuq4DSycdY5I50Soo3F9IUq1uepjmPMv/yJ86tLgCw4IivLLXDludOrFtnS453fN3PysyeQmNrUH+i9GQTvYqVRGu/W7Yb0Vqlmm0bZkK6BfPfKsec23LCT7FcA9E2oUjqWHT7twRd8e9isZEPOTkw1CjmEcOjX4kbIFfbeRQtaQG8aa5wAj6oT9LUmLrPtvd998LRpSu7BYHPjOj6
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(356005)(7636003)(82740400003)(36756003)(47076005)(83380400001)(36860700001)(86362001)(54906003)(8936002)(110136005)(7696005)(40460700003)(6666004)(41300700001)(70206006)(316002)(8676002)(70586007)(336012)(426003)(26005)(186003)(4326008)(82310400005)(40480700001)(2616005)(478600001)(2906002)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 05:12:50.2255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cff92479-bfc6-41b5-d28b-08db785f7c2d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6401
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sheetal <sheetal@nvidia.com>

Byte mask for channel-1 of stream-1 is not getting enabled and this
causes failures during AMX use cases. This happens because the byte
map value 0 matches the byte map array and put() callback returns
without enabling the corresponding bits in the byte mask.

AMX supports 4 input streams and each stream can take a maximum of
16 channels. Each byte in the output frame is uniquely mapped to a
byte in one of these 4 inputs. This mapping is done with the help of
byte map array via user space control setting. The byte map array
size in the driver is 16 and each array element is of size 4 bytes.
This corresponds to 64 byte map values.

Each byte in the byte map array can have any value between 0 to 255
to enable the corresponding bits in the byte mask. The value 256 is
used as a way to disable the byte map. However the byte map array
element cannot store this value. The put() callback disables the byte
mask for 256 value and byte map value is reset to 0 for this case.
This causes problems during subsequent runs since put() callback,
for value of 0, just returns without enabling the byte mask. In short,
the problem is coming because 0 and 256 control values are stored as
0 in the byte map array.

Right now fix the put() callback by actually looking at the byte mask
array state to identify if any change is needed and update the fields
accordingly. The get() callback needs an update as well to return the
correct control value that user has set before. Note that when user
sets 256, the value is stored as 0 and byte mask is disabled. So byte
mask state is used to either return 256 or the value from byte map
array.

Given above, this looks bit complicated and all this happens because
the byte map array is tightly packed and cannot actually store the 256
value. Right now the priority is to fix the existing failure and a TODO
item is put to improve this logic.

Fixes: 8db78ace1ba8 ("ASoC: tegra: Fix kcontrol put callback in AMX")
Cc: stable@vger.kernel.org
Signed-off-by: Sheetal <sheetal@nvidia.com>
Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
Reviewed-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/tegra/tegra210_amx.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/sound/soc/tegra/tegra210_amx.c b/sound/soc/tegra/tegra210_amx.c
index 782a141..1798769 100644
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
@@ -203,10 +203,20 @@ static int tegra210_amx_get_byte_map(struct snd_kcontrol *kcontrol,
 	else
 		enabled = amx->byte_mask[0] & (1 << reg);
 
+	/*
+	 * TODO: Simplify this logic to just return from bytes_map[]
+	 *
+	 * Presently below is required since bytes_map[] is
+	 * tightly packed and cannot store the control value of 256.
+	 * Byte mask state is used to know if 256 needs to be returned.
+	 * Note that for control value of 256, the put() call stores 0
+	 * in the bytes_map[] and disables the corresponding bit in
+	 * byte_mask[].
+	 */
 	if (enabled)
 		ucontrol->value.integer.value[0] = bytes_map[reg];
 	else
-		ucontrol->value.integer.value[0] = 0;
+		ucontrol->value.integer.value[0] = 256;
 
 	return 0;
 }
@@ -221,25 +231,19 @@ static int tegra210_amx_put_byte_map(struct snd_kcontrol *kcontrol,
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

