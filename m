Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4986C80E8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjCXPNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjCXPNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:13:00 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A91E1ABD6;
        Fri, 24 Mar 2023 08:12:45 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9488EE0004;
        Fri, 24 Mar 2023 15:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679670763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AKMjsmVuGQnB8YMrE/mZMGkPMHIYStzAUAeMUrSpOig=;
        b=jzaazBv+z6bdh0gBL92QPHmZc0eELjmoGevdGLM7N6FfRiB2GYonK0XKPF/vtEi6PgHWBu
        UZUITF62qUdyB0fwVDZXvGA+h4HzZGy0j4DngD5CPwXNeBeG29t7vsiHDQ6HvuKc8+1At0
        AO/AkbWLYf5xiHuGBw8QBgIvYGLILygVZDoRJn0MWMeBUrtpXceaGA+VzrueZYE+VSiKSS
        WLB68dEMLfBkefeOQ2IHHBNtgcsOExgTSICYKdq5rsBu27z/CdyCejOlcEusQUK9HVO9p2
        eiDmvmUlU0xCm/DfuukMydXjoMxLMSjwWOe8VXDm0PqSrlbbvkHOZVjxvKx3Ng==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Adam Pigg <adam@piggz.co.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 2/9] media: v4l2: Add NV12_16L16 pixel format to v4l2 format info
Date:   Fri, 24 Mar 2023 16:12:21 +0100
Message-Id: <20230324151228.2778112-3-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
References: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Represent the NV12_16L16 pixel format in the v4l2 format info table.
This is a 16x16 tiled version of NV12.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/v4l2-core/v4l2-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 3d044b31caad..5101989716aa 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -280,6 +280,8 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		/* Tiled YUV formats */
 		{ .format = V4L2_PIX_FMT_NV12_4L4, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
 		{ .format = V4L2_PIX_FMT_P010_4L4, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, .hdiv = 2, .vdiv = 2 },
+		{ .format = V4L2_PIX_FMT_NV12_16L16,	.pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2,
+		  .block_w = { 16, 16, 0, 0 }, .block_h = { 16, 16, 0, 0 } },
 
 		/* YUV planar formats, non contiguous variant */
 		{ .format = V4L2_PIX_FMT_YUV420M, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 3, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 2, .vdiv = 2 },
-- 
2.39.2

