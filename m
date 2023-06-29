Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521DB741F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 07:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjF2FNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 01:13:21 -0400
Received: from mail-bn7nam10on2041.outbound.protection.outlook.com ([40.107.92.41]:4960
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231561AbjF2FM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 01:12:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JR7d6lYm1vdEccg7DNUbiQY1/zg8RY8XvY7zeEWAkoDojGiwlNwJKR6McSaNnkfEzBFbY/HaPliwNXeO1/8ULRSNWyhottfBL0qWPtR0bXAPMtHpUkvWcUi9ZJS5I4F9Dztj2MR1qYdVvvMwOikrRjBWoJuWPU+fYwOD9cPwnbp7sdon/BEZQqTVDQ5x6fZhLgCqNF1pk+TcLVXyJamuMJDKK0Wby7RYm+K6RU5xnLfL81UlAWQk3TM7yXrMCBzEwF5TnVbAeS3KmVJRjvzIHOGAjpTRzHV6HTKdbczIOD4X1A7t3MIlOGMvEwoVvbp0gN8g1jfbh23hUZgnTVbdiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCaGBkWc/W+y3OkGgYQ8Rth/qfDlr0RWBpPiGNARBL8=;
 b=Yq1V82c7X/XKMPsu869N/9EWSWmWbTqsNpzIrT0aWHsWQM2ioWBMEOdJcePpF6LofGBAFh7sKItPD2r7qz+PV7pCDrKdAN7RCOfavIUS1boaaBMIP8y3xWSxHVaW6oFZo8YFfOpViuW2vqI4ey39G+PdPZDt9Vj3lumq6rlR5uLXsiH1VNxGZOTtCzYU1TI5wVzrlc0ZoUEJEBMT5RqAQRri1TcKSVmc7N2FGDEMJglMr+CqR/pANwDomd7vwU+feNhfROSNGeyHucFWL+tfPYUzjF56Ix1Gb+rI+RgUhHo9eOu2muZDKab42HbtJT22BJvYnoGnXTRgq1+y+Nr7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCaGBkWc/W+y3OkGgYQ8Rth/qfDlr0RWBpPiGNARBL8=;
 b=e7krhYOl7WckGg7N4ek8gSCtGOiNegg5nb4xP/Xp9zHXLi7qP5BbG3xBebeQ7dnP84mM9iIb6TSzZJc2YXnUTlZAac2YtWgzRCPXyMDVwGqz/dOBo6WQ58zW0V+npWjN91ZKm2jkDm4HflHuz15DMek214wXjqyyCaHb3JSTPOH5eGAwNL0t2DeYpiwMHyu8rqIICU3ad5xFcy7xJ4D2bhyuAgp3KYYnEX/oYnpUsvVe089ndcF40te+PG4hKx4Ih55PZS1pc4bPWWyn8ZzilsWLNHqwsL2EqTO8XF+M7p8mcdK5UnQeKiWm1QlIbN1uBnh4tDcbvdieBFEUVbxFeQ==
Received: from DM6PR17CA0022.namprd17.prod.outlook.com (2603:10b6:5:1b3::35)
 by MW3PR12MB4587.namprd12.prod.outlook.com (2603:10b6:303:5d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 05:12:56 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::e0) by DM6PR17CA0022.outlook.office365.com
 (2603:10b6:5:1b3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Thu, 29 Jun 2023 05:12:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.49 via Frontend Transport; Thu, 29 Jun 2023 05:12:55 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 28 Jun 2023
 22:12:44 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 28 Jun 2023 22:12:44 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 28 Jun 2023 22:12:40 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <tiwai@suse.com>
CC:     <jonathanh@nvidia.com>, <mkumard@nvidia.com>, <sheetal@nvidia.com>,
        <spujar@nvidia.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH v2 2/5] ASoC: tegra: Fix ADX byte map
Date:   Thu, 29 Jun 2023 10:42:14 +0530
Message-ID: <1688015537-31682-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688015537-31682-1-git-send-email-spujar@nvidia.com>
References: <1688015537-31682-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT019:EE_|MW3PR12MB4587:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e3a5b56-4d55-4f99-eb33-08db785f7f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: axkIap8FzCObjSS/oYf833Um3T4ETBPSCgLBYopNL+DauFTX09hI0PqSbFbRiEObIjDxSdNa6zcx4jeA2co9QHy0rEoBLedeb9GcUrUTmYMPy8y2nHfwU22jRCZq92ZPFS+6qW+7obb3U12jxYqez7c0en6dMOWBlAGWyuAPKjTmqFICN/Jg/sBYrlWPgLqH75klIcCQNOBdagABdf04ExpcbTAdshmRx1C+PG7g24bJtx87i0twHtRKBbxYgk5l5w0PV7kOos3wOVxA8rAAXrM/0fsvmpC2sRYOr7JVRf50WejmUQa/fkwrZ6Y4IOPTjKZe88r+4FRWVccZ0SfZEA4glf3DCail84+aSz+uCREqPHvnj0+++JKNhYlje0udwOJe/f+4j96fpSNi5lq5YMKzZZ2iYdjklx27+lIUMlShPbSoH84zhOSPOjMuBJZ2vd1B1B/4LYC1LhT44Jb/yf88DvvYQYvnk0jCYEL/r8OfEHWvhPbJIWSF0jbw7uIoSJqsnS91H3lnucIaGQ7IMcdIjLkSz6UFAf5lDSpkCKDFBZBqOo2hqQKRMfpBTL88XE0wsOc8nBQHdIZg5cd7P72ocgZ6EBBzpizdXu4RGzRQOi0ckreaC5Y7ee6ZiBCXZGD6jATNFTtpPQ4/nZ6FeDB+vjp8DWYPVs9zABnBpRTxenuxyJ6XUDmZiWCO5orEhmQsTcznRktGYx6xNC7dqizPSTZpWOxwTPvYQpF2l5rEY0cN7eHfucBA91S8wK3g
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(36756003)(82310400005)(36860700001)(82740400003)(70206006)(40460700003)(356005)(86362001)(5660300002)(316002)(7416002)(4326008)(41300700001)(8936002)(40480700001)(7636003)(8676002)(70586007)(47076005)(2906002)(7696005)(478600001)(186003)(426003)(26005)(336012)(83380400001)(110136005)(54906003)(6666004)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 05:12:55.7876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3a5b56-4d55-4f99-eb33-08db785f7f80
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4587
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sheetal <sheetal@nvidia.com>

Byte mask for channel-1 of stream-1 is not getting enabled and this
causes failures during ADX use cases. This happens because the byte
map value 0 matches the byte map array and put() callback returns
without enabling the corresponding bits in the byte mask.

ADX supports 4 output streams and each stream can have a maximum of
16 channels. Each byte in the input frame is uniquely mapped to a
byte in one of these 4 outputs. This mapping is done with the help of
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
set 256, the value is stored as 0 and byte mask is disabled. So byte
mask state is used to either return 256 or the value from byte map
array.

Given above, this looks bit complicated and all this happens because
the byte map array is tightly packed and cannot actually store the 256
value. Right now the priority is to fix the existing failure and a TODO
item is put to improve this logic.

Fixes: 3c97881b8c8a ("ASoC: tegra: Fix kcontrol put callback in ADX")
Cc: stable@vger.kernel.org
Signed-off-by: Sheetal <sheetal@nvidia.com>
Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
Reviewed-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/tegra/tegra210_adx.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/sound/soc/tegra/tegra210_adx.c b/sound/soc/tegra/tegra210_adx.c
index bd0b10c..7d003f0 100644
--- a/sound/soc/tegra/tegra210_adx.c
+++ b/sound/soc/tegra/tegra210_adx.c
@@ -2,7 +2,7 @@
 //
 // tegra210_adx.c - Tegra210 ADX driver
 //
-// Copyright (c) 2021 NVIDIA CORPORATION.  All rights reserved.
+// Copyright (c) 2021-2023 NVIDIA CORPORATION.  All rights reserved.
 
 #include <linux/clk.h>
 #include <linux/device.h>
@@ -175,10 +175,20 @@ static int tegra210_adx_get_byte_map(struct snd_kcontrol *kcontrol,
 	mc = (struct soc_mixer_control *)kcontrol->private_value;
 	enabled = adx->byte_mask[mc->reg / 32] & (1 << (mc->reg % 32));
 
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
 		ucontrol->value.integer.value[0] = bytes_map[mc->reg];
 	else
-		ucontrol->value.integer.value[0] = 0;
+		ucontrol->value.integer.value[0] = 256;
 
 	return 0;
 }
@@ -192,19 +202,19 @@ static int tegra210_adx_put_byte_map(struct snd_kcontrol *kcontrol,
 	int value = ucontrol->value.integer.value[0];
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int mask_val = adx->byte_mask[mc->reg / 32];
 
-	if (value == bytes_map[mc->reg])
+	if (value >= 0 && value <= 255)
+		mask_val |= (1 << (mc->reg % 32));
+	else
+		mask_val &= ~(1 << (mc->reg % 32));
+
+	if (mask_val == adx->byte_mask[mc->reg / 32])
 		return 0;
 
-	if (value >= 0 && value <= 255) {
-		/* update byte map and enable slot */
-		bytes_map[mc->reg] = value;
-		adx->byte_mask[mc->reg / 32] |= (1 << (mc->reg % 32));
-	} else {
-		/* reset byte map and disable slot */
-		bytes_map[mc->reg] = 0;
-		adx->byte_mask[mc->reg / 32] &= ~(1 << (mc->reg % 32));
-	}
+	/* Update byte map and slot */
+	bytes_map[mc->reg] = value % 256;
+	adx->byte_mask[mc->reg / 32] = mask_val;
 
 	return 1;
 }
-- 
2.7.4

