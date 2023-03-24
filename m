Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51F46C80E7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjCXPNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjCXPNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:13:05 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83013231D3;
        Fri, 24 Mar 2023 08:12:48 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5C5DFE000C;
        Fri, 24 Mar 2023 15:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679670767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P0SoD3SIFdJN2ETvwmYpRhGM53wgfEmd1zIDvKZ41MI=;
        b=RXXqYT16dg0xiL/C6DkElG3MssGV6/wUL7QteAqOstGSrdTfoXiSqXhpSy3J5xlGrwqsyv
        5P3Mh4QCrbjsxtam0Q0ezKDykqM8xxBthXPpY0qLCwwRgcLFoefZWK1F+rPnKwGlAuJcq7
        na924dK4iN0em6zSOTKBVPkOFJ7Cw88te/omkn4AKmtfyQa9i2UlV1oTnVbACQNLZxSYCu
        F2kcn+gLQlzXEwyJe4idHgxZslC06IbDW8o6VCl7EwJofgnJ5dmfr0cMLz53Jw0iFiXa/9
        Q8YUMkA914R4QYD4nOlXu204Wwe6a/nZQtnNaPlUls0H9NO6rDKzay5nTKphBQ==
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
Subject: [PATCH 4/9] media: v4l2: Add JPEG pixel format to v4l2 format info
Date:   Fri, 24 Mar 2023 16:12:23 +0100
Message-Id: <20230324151228.2778112-5-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
References: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Represent the JPEG pixel format in the v4l2 format info table.

Note that the bpp is set to 1 which is not a proper way to estimate
the needed buffer size for a given JPEG image. However the compression
ratios of JPEG typically allow fitting the image in a smaller size,
even though extra metadata could increase the total size by an
arbitrary amount. Thus it is not a perfectly safe way to calculate the
size of a JPEG buffer for given dimensions but it still provides a
reasonable approach.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/v4l2-core/v4l2-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 5101989716aa..8b2f201a8918 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -317,6 +317,9 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_SGBRG12,	.pixel_enc = V4L2_PIXEL_ENC_BAYER, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_SGRBG12,	.pixel_enc = V4L2_PIXEL_ENC_BAYER, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_SRGGB12,	.pixel_enc = V4L2_PIXEL_ENC_BAYER, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
+
+		/* Compressed formats */
+		{ .format = V4L2_PIX_FMT_JPEG,	.pixel_enc = V4L2_PIXEL_ENC_COMPRESSED, .mem_planes = 1, .comp_planes = 1, .bpp = { 1, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 	};
 	unsigned int i;
 
-- 
2.39.2

