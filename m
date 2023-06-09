Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B7F729DBF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241711AbjFIPFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241764AbjFIPEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:04:52 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5061C35A7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:04:26 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f7fc9014fdso14224185e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 08:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686323065; x=1688915065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2WGZ/ed2vrJ5KRXftei7L+b/a8JlbJSLWIRO6uJ+BPA=;
        b=mgm79aK5ZEyzsjL4fshBGIDqime5sfPSyhoXjr89GPPJML5PZXLCSy2RCsJHtbQVoc
         joZsRl99ZwtTpryeLpdTql1KIdb+cwSF7FLYE8E1ut+OeiHO0XFgsLoco3dSKa/guzRq
         +wSB5yi8UNqipIlEeUxnBtX2vpoUqwzYukPP9U2CA/OJFz8PoJ83g6D6hAk48fdjjn7W
         uPw8t8MMAsNb0OInvMc3lssBS93yN+0IwT06zsZALOCy3cbFC9l4zDMIQnKSb65UvTtN
         wq1TCSzd09ftW4qrg7rGlqfc37FNB0gWeTIsCq3Oz+t1ke8Uat1SrJevfsMmUA1fnAPh
         6NXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686323065; x=1688915065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2WGZ/ed2vrJ5KRXftei7L+b/a8JlbJSLWIRO6uJ+BPA=;
        b=VhtlW++qeqNYrPSH8/NZD1v/bHVmQD1nMi6mvWpNadDQVedh6P6KzL1EXeG1zDhXbE
         TzOWaSPR97Jnu8iuziVE1WJ8XH3XhWZy7+3IArjRByfyITGaXUFrEJKIkIobsclihDCx
         UzXk5Dz+gEb7hrr15AQYLevS2mHQuw88Wnfo/46Xkw+sMKradaIYnYqY88m8ixx6DrQb
         Yv12dN7zuPIQBWAZs5rh3ABeeISlRuTbBiXzFa7RDLPH2FcyoajXBG7JS8mFc9ueMbdi
         fqPeWV0SBqqwf5n1K/b8aFPudCCT1GmsoqO+lTMQcVDYspm968ngFAY14D/uoesqurqZ
         AzFQ==
X-Gm-Message-State: AC+VfDyAfjFljzZQ9Ms5deMKRNSftc8dpCBfLQZE32Yd2rBYiK1x6Uf0
        wChPrnIF2m9guB65DnYRxxb10U3A3MrUQSDIO+E=
X-Google-Smtp-Source: ACHHUZ7eaW16qzdTf8udY5wHHza5lq/L2Y9Nr39LRq/YBL3Qd2LXZ9BnBUzkteeXGvdPFEbRzMo11A==
X-Received: by 2002:a05:600c:2212:b0:3f4:23b9:eed2 with SMTP id z18-20020a05600c221200b003f423b9eed2mr1198999wml.38.1686323064766;
        Fri, 09 Jun 2023 08:04:24 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id m14-20020a7bce0e000000b003f602e2b653sm2905098wmc.28.2023.06.09.08.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:04:23 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, broonie@kernel.org, tiwai@suse.com
Cc:     corbet@lwn.net, alsa-devel@alsa-project.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_plai@quicinc.com, quic_mohs@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2] ALSA: compress: allow setting codec params after next track
Date:   Fri,  9 Jun 2023 16:04:16 +0100
Message-Id: <20230609150416.24525-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Changes since v1/RFC:
	- removed introduction of new IOCTL, as suggested.
	- update the state-machine doc.

 .../sound/designs/compress-offload.rst        | 52 +++++++++----------
 sound/core/compress_offload.c                 | 10 ++--
 2 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/Documentation/sound/designs/compress-offload.rst b/Documentation/sound/designs/compress-offload.rst
index 935f325dbc77..205cadcabe70 100644
--- a/Documentation/sound/designs/compress-offload.rst
+++ b/Documentation/sound/designs/compress-offload.rst
@@ -256,32 +256,32 @@ Gapless Playback SM
 For Gapless, we move from running state to partial drain and back, along
 with setting of meta_data and signalling for next track ::
 
-
-                                        +----------+
-                compr_drain_notify()    |          |
-              +------------------------>|  RUNNING |
-              |                         |          |
-              |                         +----------+
-              |                              |
-              |                              |
-              |                              | compr_next_track()
-              |                              |
-              |                              V
-              |                         +----------+
-              |                         |          |
-              |                         |NEXT_TRACK|
-              |                         |          |
-              |                         +----------+
-              |                              |
-              |                              |
-              |                              | compr_partial_drain()
-              |                              |
-              |                              V
-              |                         +----------+
-              |                         |          |
-              +------------------------ | PARTIAL_ |
-                                        |  DRAIN   |
-                                        +----------+
+                            +----------+
+     compr_drain_notify()   |          | compr_set_params() iff next-track set.
+  +------------------------>|  RUNNING |----------------------+
+  |                         |          |                      |
+  |                         +----------+                      |
+  |                              |                            |
+  |                              |                            |
+  |                              | compr_next_track()         |
+  |                              |                            V
+  |                              V                            |
+  |                         +----------+                      |
+  |                         |          |                      |
+  |                         |NEXT_TRACK|                      |
+  |                         |          |                      |
+  |                         +----------+                      |
+  |                              |                            |
+  |                              +----------------------------+
+  |                              |
+  |                              | compr_partial_drain()
+  |                              |
+  |                              V
+  |                         +----------+
+  |                         |          |
+  +------------------------ | PARTIAL_ |
+                            |  DRAIN   |
+                            +----------+
 
 Not supported
 =============
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 243acad89fd3..fe67228e74b3 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -294,6 +294,9 @@ static ssize_t snd_compr_write(struct file *f, const char __user *buf,
 	case SNDRV_PCM_STATE_SETUP:
 	case SNDRV_PCM_STATE_PREPARED:
 	case SNDRV_PCM_STATE_RUNNING:
+		/* Make sure next track params are set before writing new data */
+		if (stream->next_track)
+			return -EPERM;
 		break;
 	default:
 		mutex_unlock(&stream->device->lock);
@@ -589,7 +592,8 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
 	struct snd_compr_params *params;
 	int retval;
 
-	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN) {
+	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN ||
+	    (stream->runtime->state == SNDRV_PCM_STATE_RUNNING && stream->next_track)) {
 		/*
 		 * we should allow parameter change only when stream has been
 		 * opened not in other cases
@@ -615,7 +619,8 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
 		stream->metadata_set = false;
 		stream->next_track = false;
 
-		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
+		if (stream->runtime->state == SNDRV_PCM_STATE_OPEN)
+			stream->runtime->state = SNDRV_PCM_STATE_SETUP;
 	} else {
 		return -EPERM;
 	}
@@ -956,7 +961,6 @@ static int snd_compr_partial_drain(struct snd_compr_stream *stream)
 		return retval;
 	}
 
-	stream->next_track = false;
 	return snd_compress_wait_for_drain(stream);
 }
 
-- 
2.21.0

