Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85ECB677578
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 08:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjAWHRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 02:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjAWHRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 02:17:16 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239AD1A480;
        Sun, 22 Jan 2023 23:17:14 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id n7so9853438wrx.5;
        Sun, 22 Jan 2023 23:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=orgUUcijT9HAApybCZNzBbAQbGQJs54lfazjlNmvor4=;
        b=WRCsLiXIOEL4Z1N86sUMV6M5XLpBKylpzBAmHT2JzYCDncyvy3j/2S4bjMMfg7qFKA
         0t/8RMvcLyZ7Hm9n96j07NCQiO0W+kmPVRWXVr+h89ghY/sTHrxYPc+OS8d29zTk5YkL
         R2V99J6yTedGvuffOXjjSPdOzMpw3ulfv1FGRRhKw+rs9DPPR/2HHXTGbaAE8VEord0k
         L1jrrYxn0HpQiAaH7N57dxlP7Mota1QnShp2jTLcf6hdindbQiKhv+eA9iTK69PNKT6+
         1Tc1h4oL75lIoqP1tBYZeVCtVO81vEHJyaCuYYKfsOCbx7toPCmVdZmurYF1CZhOdZGC
         XtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orgUUcijT9HAApybCZNzBbAQbGQJs54lfazjlNmvor4=;
        b=3x8q3qxrFr8WJIDbdvfIV3E4pv2MvNIcghNoddNLjDL8mHiPRjGLnRfLvF8Lwh5y1H
         MRwnpds4zPfuZX8t58mi3cniLAtgMTtrTTaBJEeJNr26/memcN6va8NP5aKRtiqSvQDS
         dZKWyfWHntx/+QPu/4WFVuEFw1G7x3vYsEmY84pHIjpGHWmBry4hA1So4TP+GRgxdU3U
         i4MlZivFeU5pmBTLc6Irnmw0R7KluI/onQnfOIEXvRjR9030gEItOaX3Bwc/aaxDwkx8
         MKp5Tiox021kbB0zQlvqVVt2A5ovTP+Qb/1C7GOntbwx1i0X2hAvpVdTYeoWktXEA0zE
         u4Ow==
X-Gm-Message-State: AFqh2kogrDYTEqCyXElrKFAOiHzWWIm+bAADexP6i8joGuFYdp2lRw4h
        9++gizEGWvrxkW9US6dqWoI=
X-Google-Smtp-Source: AMrXdXvWh4N79aN3+Zbpk2+4tvBaV8mZGbORgIeWR2mMNB6qANbMFGt0GeFzVFZKjCoaUSqoZ0vkbg==
X-Received: by 2002:adf:f790:0:b0:2bd:ebc0:6f79 with SMTP id q16-20020adff790000000b002bdebc06f79mr20538950wrp.46.1674458232520;
        Sun, 22 Jan 2023 23:17:12 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id f2-20020adff982000000b002bde537721dsm23713801wrr.20.2023.01.22.23.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 23:17:12 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Benjamin Roszak <benjamin545@gmail.com>
Subject: [PATCH] media: meson: vdec: remove redundant if statement
Date:   Mon, 23 Jan 2023 07:17:08 +0000
Message-Id: <20230123071708.2670751-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Benjamin Roszak <benjamin545@gmail.com>

Checking if sess->fmt_out->pixfmt is V4L2_PIX_FMT_VP9 was already done as a
condition to enter the if statement where this additional check is made.

Signed-off-by: Benjamin Roszak <benjamin545@gmail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/staging/media/meson/vdec/esparser.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/staging/media/meson/vdec/esparser.c
index 86ccc8937afc..7b15fc54efe4 100644
--- a/drivers/staging/media/meson/vdec/esparser.c
+++ b/drivers/staging/media/meson/vdec/esparser.c
@@ -314,8 +314,7 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
 			num_dst_bufs = codec_ops->num_pending_bufs(sess);
 
 		num_dst_bufs += v4l2_m2m_num_dst_bufs_ready(sess->m2m_ctx);
-		if (sess->fmt_out->pixfmt == V4L2_PIX_FMT_VP9)
-			num_dst_bufs -= 3;
+		num_dst_bufs -= 3;
 
 		if (esparser_vififo_get_free_space(sess) < payload_size ||
 		    atomic_read(&sess->esparser_queued_bufs) >= num_dst_bufs)
-- 
2.34.1

