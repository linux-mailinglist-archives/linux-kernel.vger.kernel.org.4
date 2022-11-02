Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA11E616BC0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiKBSJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiKBSI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:08:29 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0898D10A5;
        Wed,  2 Nov 2022 11:08:28 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id b2so47505317eja.6;
        Wed, 02 Nov 2022 11:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdOwqqxxYEZRd9acvNPnTYoR6lmdOOAyvQmf0ex2vO8=;
        b=HCjeFIP8UyzZhiT1DfZSmx9y0DaO9+xtJgKkH2ojsI4ewcVjk9DRYxTLcrOZeDekjq
         A43BnfqCo1CclbOe4QwMVAKshpXEaatIwlFqjhgabD4haNE/C0CBWd8g0A7DpXG6P/cF
         UZT1mEUmWiz6OmECxCcTOXMCEkjUENtYt5l4bEUMDjwImhhUDz98GLoTmJfDw68/v1Qb
         vqSXiP8YzopVl/1a21kUMvX19dpsoexISLnBjyvAVAmxn7KAARKrsbDHP77G+ax14U4W
         3qbeIvDWgaa7o2UWu6OIMk4H4i2iG1bdZw0m2Vmc7HK0RPrVYDktYw9UTo72OGVM17Zn
         tIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdOwqqxxYEZRd9acvNPnTYoR6lmdOOAyvQmf0ex2vO8=;
        b=LlEhxmcPjAdNyGNWNk2SUYs+lrLCqBvXxSiQdaptNY7JKw1NevQQ74+DvqXUSDDm/D
         ccnTzVgzQkiIS1J0E/kihXy78KIW50+3mHBpaZU7FKYorSgLF+73VfY/gj3bPdOG7MmD
         xnt7kCmFHjTo9Qn00rgOzSHw3jX6jbA1muNQZAGbQVK+I4eDGH9x85X6kRWrajywvmYq
         P2SSl6tABLagE07s5/ogFhHNUS/gUV4r14TmILK6mKzlLuKjMXeoft0hqDhXP7dgUMAf
         pZAqVbta+b+pVoh1ExflcWS0AokoOTk4Cbps69shMVjdNi5cdHkopkVnrcdPK833OKyd
         niOg==
X-Gm-Message-State: ACrzQf20ql7ZlF+99yExmXEBMNKqlzzAvv7wxHL+ZNkSe9N2OMIc4HGb
        SzFWxAVVriua+U/gZGS2DK6Ql4u39kE=
X-Google-Smtp-Source: AMsMyM5ESq06l/CLF/S76CA9K2WIH6qaugl08P/TEhcqmBK3ysB98KByBVKRNooXPHlpgNsVAjagNw==
X-Received: by 2002:a17:906:5dae:b0:78e:302f:4218 with SMTP id n14-20020a1709065dae00b0078e302f4218mr26430520ejv.22.1667412506572;
        Wed, 02 Nov 2022 11:08:26 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id gy8-20020a170906f24800b007317f017e64sm5677460ejb.134.2022.11.02.11.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:08:26 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 08/11] media: cedrus: prefer untiled capture format
Date:   Wed,  2 Nov 2022 19:08:07 +0100
Message-Id: <20221102180810.267252-9-jernej.skrabec@gmail.com>
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

While all generations of display engine on Allwinner SoCs support
untiled format, only first generation supports tiled format.  Let's
move untiled format up, so it can be picked before tiled one. If
Cedrus variant doesn't support untiled format, tiled will still be
picked as default format.

Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus_video.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.c b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
index f6305ffe2c4f..dec5d3ae4871 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_video.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
@@ -55,15 +55,15 @@ static struct cedrus_format cedrus_formats[] = {
 		.directions	= CEDRUS_DECODE_SRC,
 		.capabilities	= CEDRUS_CAPABILITY_VP8_DEC,
 	},
-	{
-		.pixelformat	= V4L2_PIX_FMT_NV12_32L32,
-		.directions	= CEDRUS_DECODE_DST,
-	},
 	{
 		.pixelformat	= V4L2_PIX_FMT_NV12,
 		.directions	= CEDRUS_DECODE_DST,
 		.capabilities	= CEDRUS_CAPABILITY_UNTILED,
 	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_NV12_32L32,
+		.directions	= CEDRUS_DECODE_DST,
+	},
 };
 
 #define CEDRUS_FORMATS_COUNT	ARRAY_SIZE(cedrus_formats)
-- 
2.38.1

