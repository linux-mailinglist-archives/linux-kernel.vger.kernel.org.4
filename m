Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897106670FC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjALLeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjALLdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:33:24 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED0A51330
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673522622; x=1705058622;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9KAbnHL0UiVDA9+ZptE4cD++4OwAL8HyjhzOIXTCDOc=;
  b=Qxul0kUHvPm8IpYfjTNBGQ6ENKXWkrc7rPOPpu0N3KXYSBCqpjrDOcBR
   Vb83IG1U2K8Uw4eY17VB86DQxFL+kJaQqq3HGoqugEd+TE3N2SrnBO1bP
   Ij5r6WRtP72AILOtB7Znpc36o1y7xVTTxgOij1vuVAlm6qhvGPGFp3tnr
   vbMvpHekIrlrqBB7wi/gC/YLuRy9T4bIQKgjud8rOBwI/33pq0wIJO0MW
   Yh5p/5fitcpg2f3mgJNmZTrKuzES/nbZ5vGiiD7wqkWkX29Y1yV4h1p7m
   2lhogMLstDgDM9KF5ZVzIenveV3GoKx6O+bva1fiGHkTz5Li/ZyyF9Uhz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="325704371"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="325704371"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 03:23:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607750221"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="607750221"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 12 Jan 2023 03:23:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 59258130; Thu, 12 Jan 2023 13:24:04 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] ASoC: amd: acp-es8336: Drop reference count of ACPI device after use
Date:   Thu, 12 Jan 2023 13:23:56 +0200
Message-Id: <20230112112356.67643-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Theoretically the device might gone if its reference count drops to 0.
This might be the case when we try to find the first physical node of
the ACPI device. We need to keep reference to it until we get a result
of the above mentioned call. Refactor the code to drop the reference
count at the correct place.

While at it, move to acpi_dev_put() as symmetrical call to the
acpi_dev_get_first_match_dev().

Fixes: 02527c3f2300 ("ASoC: amd: add Machine driver for Jadeite platform")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
v2: split from big series (Pierre), added tag (Vijendar)
 sound/soc/amd/acp-es8336.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp-es8336.c b/sound/soc/amd/acp-es8336.c
index 2fe8df86053a..89499542c803 100644
--- a/sound/soc/amd/acp-es8336.c
+++ b/sound/soc/amd/acp-es8336.c
@@ -198,9 +198,11 @@ static int st_es8336_late_probe(struct snd_soc_card *card)
 	int ret;
 
 	adev = acpi_dev_get_first_match_dev("ESSX8336", NULL, -1);
-	if (adev)
-		put_device(&adev->dev);
+	if (!adev)
+		return -ENODEV;
+
 	codec_dev = acpi_get_first_physical_node(adev);
+	acpi_dev_put(adev);
 	if (!codec_dev)
 		dev_err(card->dev, "can not find codec dev\n");
 
-- 
2.39.0

