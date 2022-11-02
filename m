Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F6D616BBA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiKBSIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiKBSIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:08:23 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59431657F;
        Wed,  2 Nov 2022 11:08:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kt23so47409555ejc.7;
        Wed, 02 Nov 2022 11:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fz8kU4WpE9TC4fsj366svqLLQU9rq3YiiGANcwE6/pc=;
        b=Lu9iDaPkeibob9D2zukTHvmKRrirbpzfH6LT1C6M0zP/qXy54iExH7mDioyv4Ul7Sx
         6QRjy8MQZ+j2abjXnhQcIEmsc23UDoysXuAY+MJJJJmoiscmNOBXQnCnCTXXSDYhJpFq
         KVnNSlVUijf+ZlFCsEdQM7lLeAvW65pZxBILlTiJEdAjG8mD0eRAPjZ/58nR5X4cNBdD
         us1xsek5nl1pl3IyD31KHZjNAnw5Wv0LMiwobX/uFy7PomCQFtN5B2oShrzht1oLfiJ+
         dJ3F3lwCKO4xoYlQ+3DWdfona/UynPlWzKQ/mrii70uT9qIIvujTdVdA+xd2twOp5Duh
         FDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fz8kU4WpE9TC4fsj366svqLLQU9rq3YiiGANcwE6/pc=;
        b=smKbkR4hw0y5ylxl9aCsKs+FxKKM1doU6ZRJchZVkVLAKmQiNa+F5WV9NtWQ2PkTr1
         jecR2WXHkZRyBc33L0O0Asx8kGH4cK8sNZ8S5PP6d7INuATl2qjG3C3xS7Pi203rlESg
         RVjPsopAps/rge8wEBAuKZ8Nmku0nfHA+cicBiqMy06AEbuztW+W034OqesfEeqQ13t2
         P5QkGBwHCOM5cWtFHIgMirZg9rEs1kxs/lrCvH79wCVdYkbI6qExQDvgkpdhoB4E6Sy/
         W46B5xVSZrtT6GUMi9NZhe5izAbhomKGerMP5iXny5TTVwpfB8gvRWTEA6OCl7IJfEHN
         BZ+A==
X-Gm-Message-State: ACrzQf080r/eSF9P+OQ3zM0KNd1u2l+wADiRKYLqPxKzTQcb5EsGRDog
        fOcYZdtIiDwbc3K9bVfSn8U=
X-Google-Smtp-Source: AMsMyM4iFCLAEnI0uHlhwGw0+az0UFMMmCWDTBTRtbk0uQWbXxdgPdZEkcZEWF+GLLv8aO6NBF5ChQ==
X-Received: by 2002:a17:906:401:b0:73d:af73:b78 with SMTP id d1-20020a170906040100b0073daf730b78mr25917180eja.122.1667412500919;
        Wed, 02 Nov 2022 11:08:20 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id gy8-20020a170906f24800b007317f017e64sm5677460ejb.134.2022.11.02.11.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:08:20 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 03/11] media: cedrus: use helper to set default formats
Date:   Wed,  2 Nov 2022 19:08:02 +0100
Message-Id: <20221102180810.267252-4-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102180810.267252-1-jernej.skrabec@gmail.com>
References: <20221102180810.267252-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that set output format helper is available, let's use that for
setting default values. Advantage of this is that values will be always
valid. Current code produced invalid default values for V3s SoC, which
doesn't support MPEG2 decoding.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index 55c54dfdc585..2f284a58d787 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -361,16 +361,8 @@ static int cedrus_open(struct file *file)
 		ret = PTR_ERR(ctx->fh.m2m_ctx);
 		goto err_ctrls;
 	}
-	ctx->dst_fmt.pixelformat = V4L2_PIX_FMT_NV12_32L32;
-	cedrus_prepare_format(&ctx->dst_fmt);
-	ctx->src_fmt.pixelformat = V4L2_PIX_FMT_MPEG2_SLICE;
-	/*
-	 * TILED_NV12 has more strict requirements, so copy the width and
-	 * height to src_fmt to ensure that is matches the dst_fmt resolution.
-	 */
-	ctx->src_fmt.width = ctx->dst_fmt.width;
-	ctx->src_fmt.height = ctx->dst_fmt.height;
-	cedrus_prepare_format(&ctx->src_fmt);
+
+	cedrus_reset_out_format(ctx);
 
 	v4l2_fh_add(&ctx->fh);
 
-- 
2.38.1

