Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223856F9561
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjEGAd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjEGAdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:33:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527A919909;
        Sat,  6 May 2023 17:33:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 666A661472;
        Sun,  7 May 2023 00:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A4FC4339B;
        Sun,  7 May 2023 00:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683419525;
        bh=BCsu68HBTiZwi9UXk5QWW73YdlLJq589OWQjyH5JbTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gPGbd7dNZ7SmtXVbD0iW1iVtPUT5KrdNxgi9h1Uw8TxcEvON3yfQlFPeTZxNs+QGT
         jupnga/wF4LiEXMYojw1lMzaSMr9ecCGbapqrWpKFUSgZ6vLIaXZJSLSLwY/5dS3Qa
         OsVfjLdGDQDWt4eyvHHI16DuMmPQIv3WUD03w7jC/zrpcu8bA3djOsJd2lEeKl86ZZ
         /7Sp1mX8a/8+BiAyChNt0xqDZDSJwgH2hRfBAXE8049okKmI1+W+idza6SBgSMJ6fu
         n3az0dpobH5vMQqwL4pE3b/fXCn3Z/58L3D0M/AzcmKLVEew0t/Up2Qs1KNMA2UNRO
         Vih0MFl1GYl2g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, rdunlap@infradead.org,
        mario.limonciello@amd.com, pierre-louis.bossart@linux.intel.com,
        nathan@kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.3 18/24] ASoC: amd: Add check for acp config flags
Date:   Sat,  6 May 2023 20:30:14 -0400
Message-Id: <20230507003022.4070535-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507003022.4070535-1-sashal@kernel.org>
References: <20230507003022.4070535-1-sashal@kernel.org>
MIME-Version: 1.0
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

From: Syed Saba Kareem <Syed.SabaKareem@amd.com>

[ Upstream commit bddcfb0802eb69b0f51293eab5db33d344c0262f ]

We have SOF and generic ACP support enabled for Rembrandt and
pheonix platforms on some machines. Since we have same PCI id
used for probing, add check for machine configuration flag to
avoid conflict with newer pci drivers. Such machine flag has
been initialized via dmi match on few Chrome machines. If no
flag is specified probe and register older platform device.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://lore.kernel.org/r/20230412091638.1158901-1-Syed.SabaKareem@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/Kconfig        | 2 ++
 sound/soc/amd/ps/acp63.h     | 2 ++
 sound/soc/amd/ps/pci-ps.c    | 8 +++++++-
 sound/soc/amd/yc/acp6x.h     | 3 +++
 sound/soc/amd/yc/pci-acp6x.c | 8 +++++++-
 5 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index c88ebd84bdd50..08e42082f5e96 100644
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
index 6bf29b520511d..dd36790b25aef 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -111,3 +111,5 @@ struct acp63_dev_data {
 	u16 pdev_count;
 	u16 pdm_dev_index;
 };
+
+int snd_amd_acp_find_config(struct pci_dev *pci);
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index e86f23d97584f..558a67fe306ae 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -249,11 +249,17 @@ static int snd_acp63_probe(struct pci_dev *pci,
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
index 036207568c048..2de7d1edf00b7 100644
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
index 77c5fa1f7af14..7af6a349b1d41 100644
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
2.39.2

