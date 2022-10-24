Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1204660BD37
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiJXWP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiJXWPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:15:01 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED36309D67;
        Mon, 24 Oct 2022 13:31:08 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id bs14so14252832ljb.9;
        Mon, 24 Oct 2022 13:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fz8kU4WpE9TC4fsj366svqLLQU9rq3YiiGANcwE6/pc=;
        b=GD1VrjxnsI5PdS5Ql5clVdZZo3LcKOQlsk6Vyf7xKb8cFzGMJBN37iLlAIx/IxjfWG
         HHCEZ+i07Ndortqa/MXILhU7jraNG5CK57RmJVEKicdQxow7TqU3tQvrI6Z6wwqoXGeh
         oulyQoHw56xVdN8hDLx+9DhBr9TIHnsEMwzIeSrvKQqzb0QFYjFL+h+fjCWXs7ja4syg
         x5XTNBoV7oAM1htM7qDnRQnu1LrFFVEjwCQz6/ol6f0FH+oIc4byVyF3R+BgxjThRz/t
         AQtrTo4XIJVnvwpOpK1vzYKVRPVi48caLA5B6hZTrJxB+rhI9D3Sn2sq5V4x90idMyOD
         ptNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fz8kU4WpE9TC4fsj366svqLLQU9rq3YiiGANcwE6/pc=;
        b=HigQVxhAbL15GuPlCjyPuAkVBn3IEgrCX7RzVNZ5OAAenhy468qi/4vehK8fMoSbAl
         ta56D7D5xKUgiHw+HFbz3qg2YzlTl8tQE6iQPpnXyU2gSNQlFVqcm+vZ9HsxEHCDJ3tD
         3xRirdhhepJmHMuzGiHbT0R+yHatxH8Ei4wg0bFfgoqUyZbVEqGVOnpkhTho2MBDZ0WL
         SdbWi+ndhnNPXIn4ll90jf6kbRArbOXmXd1xHjEEKDdTObDa1xnxsy4IQLuY+OlQmo11
         siZinaS8lT2rAobtIFrZ0qiyYksxbrpaSzJ9EKGUpHjjjOLHR/O4arXy7BcuTrN63YDf
         Wa9A==
X-Gm-Message-State: ACrzQf3s3UAWUTQGmRTLM+IN2mQE1doh9Fn5n2al6C8+DGsQSwDX6/3e
        ybaGZyq1AAYKsqsmof8U8/OT8lDNfmjQBg==
X-Google-Smtp-Source: AMsMyM5N6rY36kWtuD+4fCLoz4ya1DelpBdN2ddXXk7isg8bqu/m5BZOIv42mzcm7xNI4Z2j31FPHA==
X-Received: by 2002:a17:907:b17:b0:78b:b909:e91a with SMTP id h23-20020a1709070b1700b0078bb909e91amr28116924ejl.687.1666642532756;
        Mon, 24 Oct 2022 13:15:32 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id op7-20020a170906bce700b0073d638a7a89sm332023ejb.99.2022.10.24.13.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:15:32 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 03/11] media: cedrus: use helper to set default formats
Date:   Mon, 24 Oct 2022 22:15:07 +0200
Message-Id: <20221024201515.34129-4-jernej.skrabec@gmail.com>
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

