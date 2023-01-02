Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8460965B728
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 21:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbjABUbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 15:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbjABUaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 15:30:09 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26DCBF40
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 12:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672691408; x=1704227408;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Tuh2SSmJnpDPTtlBWbyywMESzagl6YRuFPwYuCTfJEU=;
  b=B57ISLuwBgq8TxjmNaXZKxuZVh4xOrbu0uxZP68impz879GUwnBkeMg4
   QWxopAPKtGYddL/HLTFCF8HYUJBBLjf9etZ4aTtVg/T2VubO8NCgSx9y/
   f4/cz4V+LSKpYiqWRXI8o7jhYth7yteYva8Y+HI1DdXQzSm2sfJJaRbvS
   PNYQJAek2ZfrjVs9s+l9et1EeWGvqCCxro3soZ4juCxStLdWS8ttHxMPi
   +9h1NEjW/bGLLMQL6lEPDwvKtsZeX1STXakFkjBS9O6Olgg065s/WlDDS
   fZ1B3tDSa7v6sljbdi/zasfeLQKkbDCWG6WhybS/C+QAthSqRSUHFIiHn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="320252179"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="320252179"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 12:29:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="685170309"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="685170309"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 02 Jan 2023 12:29:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A66E3F4; Mon,  2 Jan 2023 22:30:16 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/6] ASoC: amd: acp-es8336: Drop reference count of ACPI device after use
Date:   Mon,  2 Jan 2023 22:30:09 +0200
Message-Id: <20230102203014.16041-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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
---
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
2.35.1

