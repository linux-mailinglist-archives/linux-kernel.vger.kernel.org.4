Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1FB62325B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiKISXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiKISX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:23:27 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2EDE1D;
        Wed,  9 Nov 2022 10:23:23 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id t25so49092587ejb.8;
        Wed, 09 Nov 2022 10:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYJAiQuT0XSlTdhgreKgdulXp6/w2lPhvIYXiq8zxTE=;
        b=aOA3HqzdmUu+a6U8yTCceoTf3BgX2YXntK6kY8v6DcXvOlKWy1zYdVmMAV3ZB0eaKY
         T+aVaZp5yqWQSZIs4ouT3Tatqw+rnt8MpwV9N+rB9IsrY0DYOjTOQY3AFDhAvtg8Zekl
         HupB1ZvN8t67+0gA3p35/e0JQ8KELzcv+8OpV9sHJZUkV6NDkkjKx7CEffuksjwzOTW4
         2/iHfbUvI0+0Ve0BpPSETQpzyCHQG3OsRE0mpnAG1oowjeWeYmmoOp7VBscDlnd0O6N+
         GJFYmITehGUmAi1YNkcXAaPzfSs4aoozU/ROizboqXgtMy3Fluze/L6UEUhq22Ieys7d
         WBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYJAiQuT0XSlTdhgreKgdulXp6/w2lPhvIYXiq8zxTE=;
        b=el2701Ml0FhFjUZ7y857Xk3XW7RkFh+wE2emYHy2znkOIYi09TA0qZZ4DvDFfI0kQk
         TE5A4QVOd2BLuMRpBLL5TuXCkNra4kHLOczBUe1Plqk5LaN3MCujZCm4XMhukWj99pOA
         +BF9n4kLLY8Awb2oZl0NNXm9l3eXDLHYiUmwyYaU25nsG4xDMmAElkc9D4egHYC3bLuK
         ibQyvHwbjiasYZ2D1JknLqzcMAncOyO/7eUZmdFFziBA6VET0FnY67Ng7gi14llz5muF
         brsQo7njz8aFpJ8F1mxv80x2tVw7QHhh4ws+4/FxRgSu+34o4NgJw3jSThdKnQy1FKNr
         qoyQ==
X-Gm-Message-State: ANoB5pmsxPAQ1+RX3I7wwtJ3d88UhTQ2fkzVFC6fuFQQ/PQbaVzfaR0N
        e+2Oa50a8F2+BIVLdpUK4g4=
X-Google-Smtp-Source: AMsMyM7Hk8P3/65sZw0ml9e5JkSq2G6yChfkmgqBVE7B1+Xp9Oae5bh+Uk+ELHm8FeCjsi69FrIqeg==
X-Received: by 2002:a17:907:7b8a:b0:7ae:3957:f4e1 with SMTP id ne10-20020a1709077b8a00b007ae3957f4e1mr26146059ejc.720.1668018202133;
        Wed, 09 Nov 2022 10:23:22 -0800 (PST)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id gj26-20020a170906e11a00b007a0b28c324dsm6029400ejb.126.2022.11.09.10.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 10:23:21 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v3 3/3] media: cedrus: Relax HEVC SPS restrictions
Date:   Wed,  9 Nov 2022 19:23:09 +0100
Message-Id: <20221109182309.2475221-4-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221109182309.2475221-1-jernej.skrabec@gmail.com>
References: <20221109182309.2475221-1-jernej.skrabec@gmail.com>
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

Testing reference video TSUNEQBD_A_MAIN10_Technicolor_2 has show that
Cedrus is capable of decoding frames with different chroma and luma bit
depths.

Relax restrictions so only highest depth is checked.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 24 ++++++++-------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index 2e860cf60136..a43d5ff66716 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -45,30 +45,24 @@ static int cedrus_try_ctrl(struct v4l2_ctrl *ctrl)
 	} else if (ctrl->id == V4L2_CID_STATELESS_HEVC_SPS) {
 		const struct v4l2_ctrl_hevc_sps *sps = ctrl->p_new.p_hevc_sps;
 		struct cedrus_ctx *ctx = container_of(ctrl->handler, struct cedrus_ctx, hdl);
-		unsigned int bit_depth;
+		unsigned int bit_depth, max_depth;
 		struct vb2_queue *vq;
 
 		if (sps->chroma_format_idc != 1)
 			/* Only 4:2:0 is supported */
 			return -EINVAL;
 
-		if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
-			/* Luma and chroma bit depth mismatch */
-			return -EINVAL;
-
-		if (ctx->dev->capabilities & CEDRUS_CAPABILITY_H265_10_DEC) {
-			if (sps->bit_depth_luma_minus8 != 0 && sps->bit_depth_luma_minus8 != 2)
-				/* Only 8-bit and 10-bit are supported */
-				return -EINVAL;
-		} else {
-			if (sps->bit_depth_luma_minus8 != 0)
-				/* Only 8-bit is supported */
-				return -EINVAL;
-		}
-
 		bit_depth = max(sps->bit_depth_luma_minus8,
 				sps->bit_depth_chroma_minus8) + 8;
 
+		if (cedrus_is_capable(ctx, CEDRUS_CAPABILITY_H265_10_DEC))
+			max_depth = 10;
+		else
+			max_depth = 8;
+
+		if (bit_depth > max_depth)
+			return -EINVAL;
+
 		vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
 				     V4L2_BUF_TYPE_VIDEO_CAPTURE);
 
-- 
2.38.1

