Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BAF60BD1F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbiJXWJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiJXWIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:08:35 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17D8256D28;
        Mon, 24 Oct 2022 13:22:10 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id m15so33305494edb.13;
        Mon, 24 Oct 2022 13:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JN/xnHSP6Pihw6a6lZykPULIKG9MjkS5qFCv+jz3gxE=;
        b=N+mfby8BkFCNhHQz7lyhNuAhDS+hrHknVOORsYO4JvozUCR/K0WBM3Gkg+waQhOIJU
         ScQUzjqOj3QzhJsGYier6ZIGKS1frZcxct4YTR2WB2IR76EZtDACbTGZF8/6t0sLZgcE
         zsCQlFhC1wwE/b8wxRBf+NGjmvb9ujEBStU9ZVNtEhULQhK4bCSIZqOpHKRNGNv+Klk7
         c5Z5UwpUK9WvQnvtbgKFnH48IachlfG3LEgdh7U7zLAUF51XEU0Eo7HNa8KuuiEehQrT
         VshVg1k6XWtl6UuAxRFdarT4wCFj3F2pjHuoR4ecbQs9vnZ5+kMd1RKj7kGVlNP9aPZ7
         xf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JN/xnHSP6Pihw6a6lZykPULIKG9MjkS5qFCv+jz3gxE=;
        b=sPUI7lVbrGni/LDCs07jFdh6J5WEC/EVTy/QWqv0rHI9Xpsm8/P57bPSuq5MQPxHCw
         dlSRRU3pj2DqQ0KVxvRrVIHyI9UNQ3VUOgPu3GNE+mrex4e4tHMU1Fy9/C/sIXe8wDPM
         86D+CAC1hoIHHoIcsh+vTEozwmJJTOtnG2klDwuyZgpSV57d1VjtN+dqROB6BrEF1yl2
         yQswl4rC/wBChpT8uCci/bEwtSnI6Er8vg0rjzs+DyPHV17M0sOnqEyZgbp3FPbp9cUh
         UeOg82jKOkhnsQw01Vm7fPuQRictPxo8gxc/hmSfhjjP2GOVOG2gB/FXqA/840H/2w0l
         kOlg==
X-Gm-Message-State: ACrzQf0Yqr9PUEZyNNfF0Y55gMaRDg9jwfX5CO/yco4OBHMER9bu5yFo
        9mTW2UEW0dV6yZp04CGqIqg=
X-Google-Smtp-Source: AMsMyM5NCp8Ra8AQSeVxpj+GvLgPxRsEc1A1IvATEsJOerZ0+NbOQamGtZVb7tuTMUFX77oXzqaiww==
X-Received: by 2002:a05:6402:1d4f:b0:461:d2ed:788c with SMTP id dz15-20020a0564021d4f00b00461d2ed788cmr5199794edb.418.1666642539269;
        Mon, 24 Oct 2022 13:15:39 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id op7-20020a170906bce700b0073d638a7a89sm332023ejb.99.2022.10.24.13.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:15:38 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 09/11] media: cedrus: initialize controls a bit later
Date:   Mon, 24 Oct 2022 22:15:13 +0200
Message-Id: <20221024201515.34129-10-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221024201515.34129-1-jernej.skrabec@gmail.com>
References: <20221024201515.34129-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While it doesn't matter if controls are initialized before or after
queues and formats from open handler standpoint, initializing them last
helps keeping s_ctrl handler simpler, since everything has already valid
values.

This is just preparation for follow up changes. No functional change is
intended.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index 8cfe47574c39..70b07d8bad2b 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -354,27 +354,27 @@ static int cedrus_open(struct file *file)
 	file->private_data = &ctx->fh;
 	ctx->dev = dev;
 
-	ret = cedrus_init_ctrls(dev, ctx);
-	if (ret)
-		goto err_free;
-
 	ctx->fh.m2m_ctx = v4l2_m2m_ctx_init(dev->m2m_dev, ctx,
 					    &cedrus_queue_init);
 	if (IS_ERR(ctx->fh.m2m_ctx)) {
 		ret = PTR_ERR(ctx->fh.m2m_ctx);
-		goto err_ctrls;
+		goto err_free;
 	}
 
 	cedrus_reset_out_format(ctx);
 
+	ret = cedrus_init_ctrls(dev, ctx);
+	if (ret)
+		goto err_m2m_release;
+
 	v4l2_fh_add(&ctx->fh);
 
 	mutex_unlock(&dev->dev_mutex);
 
 	return 0;
 
-err_ctrls:
-	v4l2_ctrl_handler_free(&ctx->hdl);
+err_m2m_release:
+	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
 err_free:
 	kfree(ctx);
 	mutex_unlock(&dev->dev_mutex);
-- 
2.38.1

