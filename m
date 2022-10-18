Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CE5603646
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 01:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJRXDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 19:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJRXDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 19:03:04 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A94BCBAF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 16:03:02 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id m16so22752025edc.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 16:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5PU7hPEIqMrr7mHQR+by2rxkaknzANGyzbduzUJ57MQ=;
        b=C/U2QxOqKuFQw6hfJdYnYcqQvR/y2e6tiQAND7kPLzGadV4LgukBu6YEvAOMpIl9s7
         8Xq8tWyKVz2nFeU2nlamoBkmq/bWbvl2taaogoiHTB7fq25IZ1F8xVDUA+hcYmlO4T9I
         eouOChWSDcNbMfKJo8N/SJLX6DOzycmRofhkKM26QpqZPgMGHEUcv/cyL40AXYh87Bhi
         F/PJpG1jP4dCVQaq0p6Dp2eqGxoFLINcIKDFmkGSONYGZauiyE/zabK9nUViZ8/mamTs
         NirhB6899kjetW3Pz2k1S51/c+qDIh3j0EryVbrMt46zNxJ8OYZjfzgSCpiLPOL7uIAk
         0YYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5PU7hPEIqMrr7mHQR+by2rxkaknzANGyzbduzUJ57MQ=;
        b=gpQMIhBjTo/TaTpiOJgeDiH6FZEDkjafaege/DWz/P2WAefL/UJlaKqTZEamzipiDn
         cyDNEEYulzglrRS5GojLKqG0gd93N18d4/FU4CUv+HiWoHCfQfRq43GolGip2w/xqV+o
         ll2SobTX8RfU7xaI5fCYrxQUn6YuYHDZ7TfiV9ORSxUkP2SDytHaSjCKEtH1GfVxTEns
         24eT3KLEXWXws0OZYgfuN8wUyB8+gA9RczspjSy6CItS6upk0XKRtxcPjd2iFk51fL41
         2ad6NpiuLlLM+44dwei4qrDG7gpIH4rFIlfZYbsNduMZFKwTOlKoxqUEK4Q2lCYKbHY1
         C1Gg==
X-Gm-Message-State: ACrzQf120e9yC8N2AvhKUxD7UrKgkRatZuvj4RyUfFwlrKsUJk7pMAPH
        lQeBsmG5IFSpOyadLC9CIlw=
X-Google-Smtp-Source: AMsMyM5tKkRA+5+GaUxKMmnE5vtiiKScjjT/cObwVa/r9Sq8PoVpcyibBB4YUY9g3ZK6TCfLzMv4Iw==
X-Received: by 2002:a05:6402:400d:b0:45c:9a5c:444a with SMTP id d13-20020a056402400d00b0045c9a5c444amr4609636eda.283.1666134181473;
        Tue, 18 Oct 2022 16:03:01 -0700 (PDT)
Received: from localhost (188.28.2.110.threembb.co.uk. [188.28.2.110])
        by smtp.gmail.com with ESMTPSA id gc37-20020a1709072b2500b0077d6f628e14sm8119188ejc.83.2022.10.18.16.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 16:03:00 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     kuninori.morimoto.gx@renesas.com, spujar@nvidia.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] ASoC: simple-card: Fix up checks for HW param fixups
Date:   Wed, 19 Oct 2022 00:04:09 +0100
Message-Id: <20221018230409.610538-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "convert-xxx" properties only have an effect for DPCM DAI links.
A DAI link is only created as DPCM if the device tree requires it;
part of this involves checking for the use of "convert-xxx" properties.

When the convert-sample-format property was added, the checks got out
of sync. A DAI link that specified only convert-sample-format but did
not pass any of the other DPCM checks would not go into DPCM mode and
the convert-sample-format property would be silently ignored.

Fix this by adding a function to do the "convert-xxx" property checks,
instead of open-coding it in simple-card and audio-graph-card. And add
"convert-sample-format" to the check function so that DAI links using
it will be initialized correctly.

Fixes: 047a05366f4b ("ASoC: simple-card-utils: Fixup DAI sample format")
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 include/sound/simple_card_utils.h     |  1 +
 sound/soc/generic/audio-graph-card.c  |  2 +-
 sound/soc/generic/simple-card-utils.c | 15 +++++++++++++++
 sound/soc/generic/simple-card.c       |  3 +--
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index a0b827f0c2f6..cfed741e0181 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -177,6 +177,7 @@ void asoc_simple_convert_fixup(struct asoc_simple_data *data,
 				      struct snd_pcm_hw_params *params);
 void asoc_simple_parse_convert(struct device_node *np, char *prefix,
 			       struct asoc_simple_data *data);
+bool asoc_simple_convert_is_required(const struct asoc_simple_data *data);
 
 int asoc_simple_parse_routing(struct snd_soc_card *card,
 				      char *prefix);
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index b327372f2e4a..7804625b131e 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -417,7 +417,7 @@ static inline bool parse_as_dpcm_link(struct asoc_simple_priv *priv,
 	 * or has convert-xxx property
 	 */
 	if ((of_get_child_count(codec_port) > 1) ||
-	    (adata->convert_rate || adata->convert_channels))
+	    asoc_simple_convert_is_required(adata))
 		return true;
 
 	return false;
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index bef16833c487..7a708be24656 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -85,6 +85,21 @@ void asoc_simple_parse_convert(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_parse_convert);
 
+/**
+ * asoc_simple_convert_is_required() - Query if HW param conversion was requested
+ * @data: Link data.
+ *
+ * Returns true if any HW param conversion was requested for this DAI link with
+ * any "convert-xxx" properties.
+ */
+bool asoc_simple_convert_is_required(const struct asoc_simple_data *data)
+{
+	return data->convert_rate ||
+	       data->convert_channels ||
+	       data->convert_sample_format;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_convert_is_required);
+
 int asoc_simple_parse_daifmt(struct device *dev,
 			     struct device_node *node,
 			     struct device_node *codec,
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 78419e18717d..675991cdee87 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -393,8 +393,7 @@ static int __simple_for_each_link(struct asoc_simple_priv *priv,
 			 * or has convert-xxx property
 			 */
 			if (dpcm_selectable &&
-			    (num > 2 ||
-			     adata.convert_rate || adata.convert_channels)) {
+			    (num > 2 || asoc_simple_convert_is_required(&adata))) {
 				/*
 				 * np
 				 *	 |1(CPU)|0(Codec)  li->cpu
-- 
2.38.0

