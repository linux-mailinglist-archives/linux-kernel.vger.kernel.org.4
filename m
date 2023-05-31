Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD9A71825E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbjEaNmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236419AbjEaNlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:41:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9750A10F4;
        Wed, 31 May 2023 06:41:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42A3263B05;
        Wed, 31 May 2023 13:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2EAC433D2;
        Wed, 31 May 2023 13:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540462;
        bh=8m1du6GOah3NQgk52bCpmZ/0Uo6WzwgfjlrA6FrWeeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ujzuBoCkJPxSrue4PN0Nl1tgqHeys6+GFg9Bsp3yv1qRWg7DMoMXH9vwsNXYypdyl
         oZRC7b90M7UxWFVTr4PG/9B1K5MsvvK39CoFtt03b4tBAgz/tfUAK2Jqg7fFNxslHy
         r5PDDZGLoyj7v5evPjodYCsHMpToC8P4dRqBlhvNrpuKBa//FZ/sTQ2582rpT2L8e7
         46c0bTrSWvR+FjicdbrBPzVqQQiBbVmCq3n20BqZJpft+NLPs//f+DlgkDUf3rXX2z
         +MSvhAypGlKfff4C8oc4Re5KN16zXqNRRvh1krFwBgbRUeEHhuGzC9HpjQOd7SfvD4
         gKnadNtdonsXg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        ahplka19@gmail.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.3 22/37] ASoC: Intel: avs: Account for UID of ACPI device
Date:   Wed, 31 May 2023 09:40:04 -0400
Message-Id: <20230531134020.3383253-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134020.3383253-1-sashal@kernel.org>
References: <20230531134020.3383253-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit 836855100b87b4dd7a82546131779dc255c18b67 ]

Configurations with multiple codecs attached to the platform are
supported but only if each from the set is different. Add new field
representing the 'Unique ID' so that codecs that share Vendor and Part
IDs can be differentiated and thus enabling support for such
configurations.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20230519201711.4073845-6-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/soc-acpi.h              | 1 +
 sound/soc/intel/avs/board_selection.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index b38fd25c57295..528279056b3ab 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -170,6 +170,7 @@ struct snd_soc_acpi_link_adr {
 /* Descriptor for SST ASoC machine driver */
 struct snd_soc_acpi_mach {
 	u8 id[ACPI_ID_LEN];
+	const char *uid;
 	const struct snd_soc_acpi_codecs *comp_ids;
 	const u32 link_mask;
 	const struct snd_soc_acpi_link_adr *links;
diff --git a/sound/soc/intel/avs/board_selection.c b/sound/soc/intel/avs/board_selection.c
index b2823c2107f77..60f8fb0bff95b 100644
--- a/sound/soc/intel/avs/board_selection.c
+++ b/sound/soc/intel/avs/board_selection.c
@@ -443,7 +443,7 @@ static int avs_register_i2s_boards(struct avs_dev *adev)
 	}
 
 	for (mach = boards->machs; mach->id[0]; mach++) {
-		if (!acpi_dev_present(mach->id, NULL, -1))
+		if (!acpi_dev_present(mach->id, mach->uid, -1))
 			continue;
 
 		if (mach->machine_quirk)
-- 
2.39.2

