Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B33860BD05
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiJXWEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiJXWDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:03:38 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844DCC896D;
        Mon, 24 Oct 2022 13:17:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b2so7640920eja.6;
        Mon, 24 Oct 2022 13:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCm+nwpQdSOn7t4hRCuqY5Xxb/T0BgOg5M1eXRCRU+o=;
        b=f6naWv65smWskYD3+RwsOxR3AHdViC2myv5+IfMnG6D1Dt6XYeg7HfeaMkL93poPQL
         2ViDSLas/oBsXUAw0uFGZ/Su7lZIBmuTfBE5fmWe7mM/pYunMmPjccClYW7bGFk8Nmop
         1bHYNxrYiAszg11ugtyHUZekAkgk2Yxu3Eccvhx4PRu7mxehc7pgh1V/csXNHCYmcoH5
         h80cKx+EDq+QL1Td35T1BpWEdg7F1TEFQgvlYpDd4xN04l7baH0gUF86ubDAVR1Sbpmt
         vsIyRMg/9cLx5yj/9S8pmxCORjdbfkKB72dQBiHapZwNkFu0B3+C0Re7UDImZjX6X2Z8
         oLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCm+nwpQdSOn7t4hRCuqY5Xxb/T0BgOg5M1eXRCRU+o=;
        b=2J2OaeDU82SMN743Gf9Sir+QGJujRivt68uI0hdVpbJSMBhCeJT22oxhznRfKQkcgE
         C7b2phz3MokVQGa4bbawSDmEXY9kEQjEkr+BNJNmp3R+2wJ5dAuvvruuZ71ntK/0LrQm
         m3JT7GFEdIvJi2uUaVTMcSrPXrZj26gc3IPKMcPkcN+YQOiboVqRfuDh1Kn+1sZYOXPv
         SBmpn9z9Mvis3lJDW2y2MjWagXHs96h/4aEI09KwnSeuIupQoinG29kllmOb/VvwdzWX
         ijOCEgulF0y/Zc1ViQZIl64UnFhKIDYXnKVIbwrW+HAcIEADL1cMVFMjmWsmLyiOFMNC
         G5fg==
X-Gm-Message-State: ACrzQf29QZoee3hZ9S1q6nBQdWDQgoK9IZoafdTx9sEq6ZYajJaLRyjD
        Fe+zQFL89bPzkVLHpH4Hti4=
X-Google-Smtp-Source: AMsMyM7cAnM2XbaZa1dqUDehRJoXysBUQ/UwZZ7cJs4j+x+QBC+B/Wn0ZTll2s9q63LOja8/xUp1tA==
X-Received: by 2002:a17:906:5dce:b0:78d:ec48:6a58 with SMTP id p14-20020a1709065dce00b0078dec486a58mr29115013ejv.209.1666642533828;
        Mon, 24 Oct 2022 13:15:33 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id op7-20020a170906bce700b0073d638a7a89sm332023ejb.99.2022.10.24.13.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:15:33 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 04/11] media: cedrus: Add helper for checking capabilities
Date:   Mon, 24 Oct 2022 22:15:08 +0200
Message-Id: <20221024201515.34129-5-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221024201515.34129-1-jernej.skrabec@gmail.com>
References: <20221024201515.34129-1-jernej.skrabec@gmail.com>
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

There is several different Cedrus cores with varying capabilities, so
some operations like listing formats depends on checks if feature is
supported or not.

Currently check for capabilities is only in format enumeration helper,
but it will be used also elsewhere later. Let's convert this check to
helper and while at it, also simplify it. There is no need to check if
capability mask is zero, condition will still work properly.

No functional changes intended.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.h       | 6 ++++++
 drivers/staging/media/sunxi/cedrus/cedrus_video.c | 8 +-------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
index 9cffaf228422..1a98790a99af 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
@@ -268,6 +268,12 @@ vb2_to_cedrus_buffer(const struct vb2_buffer *p)
 	return vb2_v4l2_to_cedrus_buffer(to_vb2_v4l2_buffer(p));
 }
 
+static inline bool
+cedrus_is_capable(struct cedrus_ctx *ctx, unsigned int capabilities)
+{
+	return (ctx->dev->capabilities & capabilities) == capabilities;
+}
+
 void *cedrus_find_control_data(struct cedrus_ctx *ctx, u32 id);
 u32 cedrus_get_num_of_controls(struct cedrus_ctx *ctx, u32 id);
 
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.c b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
index 27a7120fa6fb..04b7b87ef0b7 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_video.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
@@ -177,19 +177,13 @@ static int cedrus_enum_fmt(struct file *file, struct v4l2_fmtdesc *f,
 			   u32 direction)
 {
 	struct cedrus_ctx *ctx = cedrus_file2ctx(file);
-	struct cedrus_dev *dev = ctx->dev;
-	unsigned int capabilities = dev->capabilities;
-	struct cedrus_format *fmt;
 	unsigned int i, index;
 
 	/* Index among formats that match the requested direction. */
 	index = 0;
 
 	for (i = 0; i < CEDRUS_FORMATS_COUNT; i++) {
-		fmt = &cedrus_formats[i];
-
-		if (fmt->capabilities && (fmt->capabilities & capabilities) !=
-		    fmt->capabilities)
+		if (!cedrus_is_capable(ctx, cedrus_formats[i].capabilities))
 			continue;
 
 		if (!(cedrus_formats[i].directions & direction))
-- 
2.38.1

