Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8588B60BD35
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiJXWPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiJXWOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:14:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443D12D1D2D;
        Mon, 24 Oct 2022 13:30:50 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y69so14383736ede.5;
        Mon, 24 Oct 2022 13:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPbmxwiilRECyAIkSs4T2Anmm0TE3NuNMWpiALbuPqI=;
        b=GIk36OGrdtY37JF3S3GWILVLqs/z6Tx/vMuvomKPwWWFbc8epqiGhafuZSUiTXeDi4
         VfM+L4ZQ3R/dsL85E8/1Csd5n+kC90guEPjPO4pooOftswdkn2vsLkK2uLg/R8p5YgRM
         W98Ej67KaWeHMEuW3dXygcLk7CLlcKG7RsA9nPaPS60ZXdmIlFF988HbITAJEb9/pf6c
         OOP+uRyeb9CxtcY8j39yKzLKfVGtFKmQOGzpcl8dK6N462ykSgYRn5eyDzhTtXbtAjyw
         q8zxm4ScQpQj/A2MimnI08GgnAxiooJRXtzch64T5O2v1B1MP3BlO/C0rcGaLR9135qK
         JdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPbmxwiilRECyAIkSs4T2Anmm0TE3NuNMWpiALbuPqI=;
        b=iuPfn2uiBBhlHVApy9RYo+DezwOoEbdLEWgYqD701WfsI+V8qfp4/t8Jrcd2zehzk/
         gCsmkRxtHzb6NyHJLRlmtO8m8hKAPpQZL6gu7OSRd6DwOgjAUgzvScwnbx/9NN/a3Wd+
         sBuwxLqdqzGxQymwLM7jK/lwCAciZ6dKAC4RwRfqf1GgzPu5XXSoPDAz0k0EebYc2/77
         FWr9SBN+Oksaxg5tZ0rpGZqnVYcZ3TqcM7u9jICJo+LHclxnA5m5HzpvaUfcwMvpGHYe
         oEZuY0U2rxPPolepW3h/ofJ6lnHkjCE6R3qoMh0ZSGUJWtkM68h+lB3zWyYxQXZostKv
         uMRQ==
X-Gm-Message-State: ACrzQf0IDS55hYdgilRgfGU68QgwODm81qQSrkuo/sKoNVWurol3Kojm
        FOxO8mZzRg1AvadLhLwX5nk69ciXeKXodw==
X-Google-Smtp-Source: AMsMyM6PUAl4L7z6RwxqnRwFEFc9HLFtuy77IQrlINTsMGCNFqjNlZjrA6yVeDWrQfowUtkWMMkf4g==
X-Received: by 2002:a17:907:7611:b0:78d:9d69:adf9 with SMTP id jx17-20020a170907761100b0078d9d69adf9mr29603251ejc.283.1666642538198;
        Mon, 24 Oct 2022 13:15:38 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id op7-20020a170906bce700b0073d638a7a89sm332023ejb.99.2022.10.24.13.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:15:37 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 08/11] media: cedrus: prefer untiled capture format
Date:   Mon, 24 Oct 2022 22:15:12 +0200
Message-Id: <20221024201515.34129-9-jernej.skrabec@gmail.com>
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

While all generations of display engine on Allwinner SoCs support
untiled format, only first generation supports tiled format.  Let's
move untiled format up, so it can be picked before tiled one. If
Cedrus variant doesn't support untiled format, tiled will still be
picked as default format.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus_video.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.c b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
index 3591bf9d7d9c..f9f723ea3f79 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_video.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
@@ -56,13 +56,13 @@ static struct cedrus_format cedrus_formats[] = {
 		.capabilities	= CEDRUS_CAPABILITY_VP8_DEC,
 	},
 	{
-		.pixelformat	= V4L2_PIX_FMT_NV12_32L32,
+		.pixelformat	= V4L2_PIX_FMT_NV12,
 		.directions	= CEDRUS_DECODE_DST,
+		.capabilities	= CEDRUS_CAPABILITY_UNTILED,
 	},
 	{
-		.pixelformat	= V4L2_PIX_FMT_NV12,
+		.pixelformat	= V4L2_PIX_FMT_NV12_32L32,
 		.directions	= CEDRUS_DECODE_DST,
-		.capabilities	= CEDRUS_CAPABILITY_UNTILED,
 	},
 };
 
-- 
2.38.1

