Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D63E735033
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjFSJag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjFSJ2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:28:54 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F0B1998
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:28:13 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f907f31247so13910775e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687166892; x=1689758892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MA34cT4O/DXGv9/GJqnDQidBqlMmaRaNZTidmNryGbQ=;
        b=w1lMpVnzGPEeaVoIe3PsoD5fTjDDyaHreFR7Forr8A4oYjlT1wyEkhpK++erSgJmsD
         YwutxvLhitQEhSImbwzmKqIsux+0pLklHXfw3XNftBpEd+rbwb9MR26+tyEi9fFprn6v
         Bwl0YL/nZIsYHPK5TzjhhoE98dYebqQ/s2pGujy5EjS1yFntMKKjonm/L8TOcdsdvNub
         C77gCrjY4W9Gz/J/hVOK7JafXsgCaXImpSlW5SHGh8EmWsKEgnPR6gZd1ZKjGjU585e8
         9udrPVPdIpwzslq8TPpDRh9c97VMMghUBVlezwYricz7zfG2u0sKoC9q5bQT3I5FCC2A
         ggLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687166892; x=1689758892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MA34cT4O/DXGv9/GJqnDQidBqlMmaRaNZTidmNryGbQ=;
        b=JeFz950JoDg7XMEaDK2YVZu46B76eEfw4dCyLDl1IbHW7Yqj5spl64N6xfhycNDR3t
         19ZFaiL9efc0GGcE/oC4J9dh/Pp+80BD/CTZfVV/dJ2RBO9j5pXKVjFJGzvBJ5jQY2bB
         4n4ptzbcI5Ajpjl6bBXyoSLRoa8ivCovfpnxXPAmD7+h4UqgwVVc4qejX36BKcDiJZ2q
         QJyE0RMSFJQJr9w060SS38oQYFXTVoZpT0wWz7IQzsoReiyuunahVVyFom+seaOo9dcm
         hndb8fxp0sdZZLt5WDy/H7JRrmR7wzJHyZSfUbvp59dVcl7PCHyToAgRvFNqKTLaA6he
         j1iw==
X-Gm-Message-State: AC+VfDw08+g4qpCSiHlQRK+G++5kJ0gCebtzjbBkfzU1tJN6mefQGDGx
        wYEvm6Pg3ANYsynA8TE4uuFZFPgvf/X40fazxnE=
X-Google-Smtp-Source: ACHHUZ5PIbm8h7cKrZMFoFsbGK9F8BONiHNOCufZZkdH5bY/DzzunLcti36p+dvVlrUIB6I+pn8RAw==
X-Received: by 2002:a7b:c449:0:b0:3f4:a09f:1877 with SMTP id l9-20020a7bc449000000b003f4a09f1877mr5725214wmi.23.1687166892067;
        Mon, 19 Jun 2023 02:28:12 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bcbd6000000b003f908ee3091sm5453846wmi.3.2023.06.19.02.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 02:28:11 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, broonie@kernel.org, tiwai@suse.com
Cc:     corbet@lwn.net, alsa-devel@alsa-project.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_plai@quicinc.com, quic_mohs@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3] ALSA: compress: allow setting codec params after next track
Date:   Mon, 19 Jun 2023 10:28:05 +0100
Message-Id: <20230619092805.21649-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For gapless playback it is possible that each track can have different
codec profile with same decoder, for example we have WMA album,
we may have different tracks as WMA v9, WMA v10 and so on

Or if DSP's like QDSP have abililty to switch decoders on single stream
for each track, then this call could be used to set new codec parameters.

Existing code does not allow to change this profile while doing gapless
playback.

Reuse existing SNDRV_COMPRESS_SET_PARAMS to set this new track params along
some additional checks to enforce proper state machine.

With this new changes now the user can call SNDRV_COMPRESS_SET_PARAMS
anytime after setting next track and additional check in write should
also ensure that params are set before writing new data.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes since v2:
 simplified the logic to allow set_params and udated the documentation accordingly

 Documentation/sound/designs/compress-offload.rst | 11 ++++++-----
 sound/core/compress_offload.c                    |  5 ++++-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/sound/designs/compress-offload.rst b/Documentation/sound/designs/compress-offload.rst
index 935f325dbc77..655624f77092 100644
--- a/Documentation/sound/designs/compress-offload.rst
+++ b/Documentation/sound/designs/compress-offload.rst
@@ -268,11 +268,12 @@ with setting of meta_data and signalling for next track ::
               |                              |
               |                              V
               |                         +----------+
-              |                         |          |
-              |                         |NEXT_TRACK|
-              |                         |          |
-              |                         +----------+
-              |                              |
+              |    compr_set_params()   |          |
+              |             +-----------|NEXT_TRACK|
+              |             |           |          |
+              |             |           +--+-------+
+              |             |              | |
+              |             +--------------+ |
               |                              |
               |                              | compr_partial_drain()
               |                              |
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 243acad89fd3..30f73097447b 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -589,7 +589,7 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
 	struct snd_compr_params *params;
 	int retval;
 
-	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN) {
+	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN || stream->next_track) {
 		/*
 		 * we should allow parameter change only when stream has been
 		 * opened not in other cases
@@ -612,6 +612,9 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
 		if (retval)
 			goto out;
 
+		if (stream->next_track)
+			goto out;
+
 		stream->metadata_set = false;
 		stream->next_track = false;
 
-- 
2.21.0

