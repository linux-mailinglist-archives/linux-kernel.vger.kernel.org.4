Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26442677795
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjAWJnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjAWJnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:43:08 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10707DBEB;
        Mon, 23 Jan 2023 01:43:07 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id n7so10187271wrx.5;
        Mon, 23 Jan 2023 01:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S6BjjeXL8yTJMC0wJlFe+I8I2MsrGeDOh1B+2LIf6wU=;
        b=agILq6o+GWk4tuFzspZR7fsDXjM2H4OVKJfjyuwFl2UcLwWyZ2gq7A11/LUvn1bsmn
         cX41gI3USsqEo0h0SFKIGzPQ4sC3hNZ/K08K37HYaJzs6Z3ZhJjVH/uQvO1vLX4IDDHl
         /g2DEbESv6pj+qqudSDlv6MAt+AlSpUR1KpXm+3FLQe5PpuJEGO3zY9lpIRDMqjKTeFO
         XotsdfsHHtfNezyDvJY1OHuaoiJRpa0zmozqH+YyBYsujIa4rpPBtflaAaPtoOWR6iFu
         RzXnWGgaFWcpcV1C48Jrgp7rvQNRLhEOgm3rdbgxY9gO9EJKf00fYME0iYTqR4FnwBNJ
         ATXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6BjjeXL8yTJMC0wJlFe+I8I2MsrGeDOh1B+2LIf6wU=;
        b=MGZiz1yxpjI1SD6vv5JxOOXxZ+ghR0+F6vbfF0rZOx2Lyrc0anXfClnKcKP0dMIS3b
         HnrhBBjx1Fo11bcLdkwkNHAsn9t+g5GULHY0ETJVgkB1O8uE83HDONtaq8VlZ9M2A4mB
         epxAD8W3cQHV059DYmLIx1agXtbhJ4KIbC4xoMhpy/9FzvZTNAlzKVayfeieKW4myP+A
         6x9p4IJkQpeIVDxu8Dz0XRdRaLlE9KEtvg1G2bIwlEc8H7uIWXTJOHxLE5JnJwsPEZxs
         SLivoaVdjBelnfHanc7bjtirCP+Gfg8rOBsqjQJTJp9HIxIUV1LSe/IPLu5pOQc5KZWZ
         HJZg==
X-Gm-Message-State: AFqh2kqNZIk6acdlm8aMqI6m43OwQyWJNq+IIbiQFCGyLshEbnmClsAt
        zlyVk06wqB1aNye7dvEGF4I=
X-Google-Smtp-Source: AMrXdXt5fyhf1LiEcRZCoHd5aZVrC2fCwIs2S4ezPycbnFeLgplLPKiVW0DzdP6j8gCMA21I42WBZw==
X-Received: by 2002:adf:ce01:0:b0:2bd:e208:1e4c with SMTP id p1-20020adfce01000000b002bde2081e4cmr23690706wrn.11.1674466985537;
        Mon, 23 Jan 2023 01:43:05 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id e12-20020adffd0c000000b002bf95821372sm6178158wrr.42.2023.01.23.01.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 01:43:05 -0800 (PST)
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
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] media: meson: vdec: esparser: check parsing state with hardware write pointer
Date:   Mon, 23 Jan 2023 09:43:00 +0000
Message-Id: <20230123094300.2816812-1-christianshewitt@gmail.com>
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

From: Neil Armstrong <narmstrong@baylibre.com>

Also check the hardware write pointer to check if ES Parser has stalled.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/staging/media/meson/vdec/esparser.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/staging/media/meson/vdec/esparser.c
index df5956c6141d..41b705f999b2 100644
--- a/drivers/staging/media/meson/vdec/esparser.c
+++ b/drivers/staging/media/meson/vdec/esparser.c
@@ -300,6 +300,7 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
 	u32 num_dst_bufs = 0;
 	u32 offset;
 	u32 pad_size;
+	u32 wp, wp2;
 
 	/*
 	 * When max ref frame is held by VP9, this should be -= 3 to prevent a
@@ -354,15 +355,21 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
 	}
 
 	pad_size = esparser_pad_start_code(core, vb, payload_size);
+	wp = amvdec_read_parser(core, PARSER_VIDEO_WP);
 	ret = esparser_write_data(core, phy, payload_size + pad_size);
+	wp2 = amvdec_read_parser(core, PARSER_VIDEO_WP);
 
 	if (ret <= 0) {
-		dev_warn(core->dev, "esparser: input parsing error\n");
-		amvdec_remove_ts(sess, vb->timestamp);
-		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
 		amvdec_write_parser(core, PARSER_FETCH_CMD, 0);
 
-		return 0;
+		if (ret < 0 || wp2 == wp) {
+			dev_err(core->dev, "esparser: input parsing error ret %d (%x <=> %x)\n",
+				ret, wp, wp2);
+			amvdec_remove_ts(sess, vb->timestamp);
+			v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
+
+			return 0;
+		}
 	}
 
 	atomic_inc(&sess->esparser_queued_bufs);
-- 
2.34.1

