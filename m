Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81346C2329
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjCTUxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCTUxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:53:43 -0400
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3C134F76
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:53:36 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id 2350C16C004F;
        Mon, 20 Mar 2023 22:35:27 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EtRulhLEt9cx; Mon, 20 Mar 2023 22:35:25 +0200 (EET)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1679344525; bh=InYQgdpge/dbR4Re0sZSGzLb+2FQvnDHCp4OaMBC+ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QOc1/SZGenka+FTPOx96+ywGP8ItKBLxq0rLHiGeCxo/MNXZYrO5XoIfrb4TM7Nqm
         gw0HRsZ19InUSBTsyn/ayHnq1oFewCpU5z2UjjIHonx69+4UFp5Ca5OXgwH6MvwJCv
         /YlbivPQe5CdrpzGteWoHkgEWtRhz4uJyl3ySmNo=
To:     Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Marian Postevca <posteuca@mutex.one>
Subject: [PATCH 2/4] ASoC: amd: acp: Add support for splitting the codec specific code from the ACP driver
Date:   Mon, 20 Mar 2023 22:35:17 +0200
Message-Id: <20230320203519.20137-3-posteuca@mutex.one>
In-Reply-To: <20230320203519.20137-1-posteuca@mutex.one>
References: <20230320203519.20137-1-posteuca@mutex.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for splitting more complicated machine drivers,
that need special handling, from the generic ACP code.

By adding support for callbacks to configure and handle codec specific
implementation details, we can split them in separate files that don't
clutter the ACP code.

Signed-off-by: Marian Postevca <posteuca@mutex.one>
---
 sound/soc/amd/acp/acp-mach.h | 65 ++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/sound/soc/amd/acp/acp-mach.h b/sound/soc/amd/acp/acp-mach.h
index 165f407697c0..2cade68e6cc3 100644
--- a/sound/soc/amd/acp/acp-mach.h
+++ b/sound/soc/amd/acp/acp-mach.h
@@ -20,6 +20,10 @@
 
 #define TDM_CHANNELS	8
 
+#define ACP_OPS(priv, cb)	((priv)->ops.cb)
+
+#define acp_get_drvdata(card) ((struct acp_card_drvdata *)(card)->drvdata)
+
 enum be_id {
 	HEADSET_BE_ID = 0,
 	AMP_BE_ID,
@@ -48,6 +52,14 @@ enum platform_end_point {
 	REMBRANDT,
 };
 
+struct acp_mach_ops {
+	int (*probe)(struct snd_soc_card *card);
+	int (*configure_link)(struct snd_soc_card *card, struct snd_soc_dai_link *dai_link);
+	int (*configure_widgets)(struct snd_soc_card *card);
+	int (*suspend_pre)(struct snd_soc_card *card);
+	int (*resume_post)(struct snd_soc_card *card);
+};
+
 struct acp_card_drvdata {
 	unsigned int hs_cpu_id;
 	unsigned int amp_cpu_id;
@@ -59,6 +71,8 @@ struct acp_card_drvdata {
 	unsigned int platform;
 	struct clk *wclk;
 	struct clk *bclk;
+	struct acp_mach_ops ops;
+	void *mach_priv;
 	bool soc_mclk;
 	bool tdm_mode;
 };
@@ -67,4 +81,55 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card);
 int acp_legacy_dai_links_create(struct snd_soc_card *card);
 extern const struct dmi_system_id acp_quirk_table[];
 
+static inline int acp_ops_probe(struct snd_soc_card *card)
+{
+	int ret = 1;
+	struct acp_card_drvdata *priv = acp_get_drvdata(card);
+
+	if (ACP_OPS(priv, probe))
+		ret = ACP_OPS(priv, probe)(card);
+	return ret;
+}
+
+static inline int acp_ops_configure_link(struct snd_soc_card *card,
+					 struct snd_soc_dai_link *dai_link)
+{
+	int ret = 1;
+	struct acp_card_drvdata *priv = acp_get_drvdata(card);
+
+	if (ACP_OPS(priv, configure_link))
+		ret = ACP_OPS(priv, configure_link)(card, dai_link);
+	return ret;
+}
+
+static inline int acp_ops_configure_widgets(struct snd_soc_card *card)
+{
+	int ret = 1;
+	struct acp_card_drvdata *priv = acp_get_drvdata(card);
+
+	if (ACP_OPS(priv, configure_widgets))
+		ret = ACP_OPS(priv, configure_widgets)(card);
+	return ret;
+}
+
+static inline int acp_ops_suspend_pre(struct snd_soc_card *card)
+{
+	int ret = 1;
+	struct acp_card_drvdata *priv = acp_get_drvdata(card);
+
+	if (ACP_OPS(priv, suspend_pre))
+		ret = ACP_OPS(priv, suspend_pre)(card);
+	return ret;
+}
+
+static inline int acp_ops_resume_post(struct snd_soc_card *card)
+{
+	int ret = 1;
+	struct acp_card_drvdata *priv = acp_get_drvdata(card);
+
+	if (ACP_OPS(priv, resume_post))
+		ret = ACP_OPS(priv, resume_post)(card);
+	return ret;
+}
+
 #endif
-- 
2.39.1

