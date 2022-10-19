Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1069260377C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 03:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJSBV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 21:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJSBVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 21:21:54 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05751E071F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 18:21:51 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g27so23028694edf.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 18:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=joQnhqtEFh/++Hfsr6F88X2sakCVbgGmjSi4iezXjZk=;
        b=SXTHeBRbQaCse2EQb3Xix3D1HHeVIkNzlYb6qoAsl5+cgl4K2ZSGnKO+Jf6G9efaGT
         TXV5sA9ItCV31Vc3MwjVaaFZ3k5WrVeVDYuYRhx1aXU4OAlU1DgHMw6l/gTg2Na6+Ion
         5oHW8BfbHsO4B84l78qGEKHVPqeGbDlrfOm7yuzzcdT6/bHsgn8DOQ7QhFFaY9TQDwDo
         P/RBwWVPvHraVt9BVFrZRdRdG9MpjKzmZYKMFqaUePDuMoBAFqka7s/ZmQCDhTV3EAnN
         yRt27yzLHaVF06QSwTXlFRUUoJQuGYJZTPQCRDDifa0BtMmI5IiiYYrmJVS8wclxkcl8
         C2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=joQnhqtEFh/++Hfsr6F88X2sakCVbgGmjSi4iezXjZk=;
        b=pdB4rSSqZXMZys15T9gzlMFPMyFbRkj9w7pK2U2wlOIO4C/s0/4yGmTzd8xE4cN19s
         kvwYR1On4ItlpA7XTc1NQs/1fiZVadGyn7aq/AEEcpXoDGKaOwQAoTP9Jmt/xnMXW2Kx
         /uwQje88nfX0g3Qlu5Si7uLZiMvn+0PLAsKMTs03w2AuidKU0nsP4qZFSeQrzoYOQS0E
         3DrFiJDLCgtJR2nwUdYy1S1pQ4OWTcuqj77BFkfLgJDwvdl3gQJ7WeErh2NhaSmLIWp+
         Q1ktTDtwFetW+gyIUTLKH/HD8jlqAPFMwSxFDDGONMSe9RUUTen/4b2Vqyi2GEWVSRvx
         V/5A==
X-Gm-Message-State: ACrzQf3VuwRynpRGqhyH2I/dvuBudv0eQxrpO8N0OXHMek8byuOV+MSz
        x+T7BebQ+UG/gb4u2SJ+FtY=
X-Google-Smtp-Source: AMsMyM4G8UgBarnVBJ2XIHY5sfyMjX0We1JUyLDjtAAuaz3ODeXb8GuuWmgug2WsuUc76JpUCC71cw==
X-Received: by 2002:a05:6402:26d2:b0:45d:280b:5878 with SMTP id x18-20020a05640226d200b0045d280b5878mr5147683edd.385.1666142510303;
        Tue, 18 Oct 2022 18:21:50 -0700 (PDT)
Received: from localhost (188.28.2.210.threembb.co.uk. [188.28.2.210])
        by smtp.gmail.com with ESMTPSA id 12-20020a170906318c00b00770812e2394sm8268145ejy.160.2022.10.18.18.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 18:21:49 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     kuninori.morimoto.gx@renesas.com, spujar@nvidia.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: simple-card: Fix up checks for HW param fixups
Date:   Wed, 19 Oct 2022 02:23:02 +0100
Message-Id: <20221019012302.633830-1-aidanmacdonald.0x0@gmail.com>
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
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
v2: Rename helper function to asoc_simple_is_convert_required() as
    suggested by Kuninori Morimoto.

 include/sound/simple_card_utils.h     |  1 +
 sound/soc/generic/audio-graph-card.c  |  2 +-
 sound/soc/generic/simple-card-utils.c | 15 +++++++++++++++
 sound/soc/generic/simple-card.c       |  3 +--
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index a0b827f0c2f6..25e049f44178 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -177,6 +177,7 @@ void asoc_simple_convert_fixup(struct asoc_simple_data *data,
 				      struct snd_pcm_hw_params *params);
 void asoc_simple_parse_convert(struct device_node *np, char *prefix,
 			       struct asoc_simple_data *data);
+bool asoc_simple_is_convert_required(const struct asoc_simple_data *data);
 
 int asoc_simple_parse_routing(struct snd_soc_card *card,
 				      char *prefix);
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index b327372f2e4a..fe7cf972d44c 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -417,7 +417,7 @@ static inline bool parse_as_dpcm_link(struct asoc_simple_priv *priv,
 	 * or has convert-xxx property
 	 */
 	if ((of_get_child_count(codec_port) > 1) ||
-	    (adata->convert_rate || adata->convert_channels))
+	    asoc_simple_is_convert_required(adata))
 		return true;
 
 	return false;
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index bef16833c487..be69bbc47f81 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -85,6 +85,21 @@ void asoc_simple_parse_convert(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_parse_convert);
 
+/**
+ * asoc_simple_is_convert_required() - Query if HW param conversion was requested
+ * @data: Link data.
+ *
+ * Returns true if any HW param conversion was requested for this DAI link with
+ * any "convert-xxx" properties.
+ */
+bool asoc_simple_is_convert_required(const struct asoc_simple_data *data)
+{
+	return data->convert_rate ||
+	       data->convert_channels ||
+	       data->convert_sample_format;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_is_convert_required);
+
 int asoc_simple_parse_daifmt(struct device *dev,
 			     struct device_node *node,
 			     struct device_node *codec,
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 78419e18717d..feb55b66239b 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -393,8 +393,7 @@ static int __simple_for_each_link(struct asoc_simple_priv *priv,
 			 * or has convert-xxx property
 			 */
 			if (dpcm_selectable &&
-			    (num > 2 ||
-			     adata.convert_rate || adata.convert_channels)) {
+			    (num > 2 || asoc_simple_is_convert_required(&adata))) {
 				/*
 				 * np
 				 *	 |1(CPU)|0(Codec)  li->cpu
-- 
2.38.0

