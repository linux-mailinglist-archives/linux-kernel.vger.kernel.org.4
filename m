Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC87647183
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiLHOU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiLHOUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:20:45 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D3087CAC;
        Thu,  8 Dec 2022 06:20:41 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0F7EFC0002;
        Thu,  8 Dec 2022 14:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670509240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0FPh8ptOOh3/7vfnCNdEW59LErgazMVmLGY6D+7mMsQ=;
        b=oIOdxsy2sgVs+9RbVNqY+Rl2s6zae0B00hC5Ux+LJdFzsGj040wWoFU/QVDqIACDa6jCz9
        NszmD9pVELijGjHGHdqeNz0dmsWWKogbXJgJjMaNrsnQ0y7IDbeUgNnYBAFgVEGOPgPB9p
        K22Ax1+1ClYHNLKWCM/MEfYbmyVUkmwfyJ9QoA2+Taqb9uOJ4wtNyXoNg9JIuXnoqrS4/y
        m5rI47KuU1jl1CoPpAmgbPCkuinq39obTSs4fh8vdAKH0H+UHGua21GHrP/3fDkPJxaFqJ
        HphBcl2+ZZoGC70u7YuodQSMvvCSrhFpYTTOEfne5Y31wXdUgbJPAdF4Bx5V4w==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Conor Dooley <conor@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v3 06/12] media: sun8i-a83t-mipi-csi2: Clarify return code handling in stream off path
Date:   Thu,  8 Dec 2022 15:20:00 +0100
Message-Id: <20221208142006.425809-7-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208142006.425809-1-paul.kocialkowski@bootlin.com>
References: <20221208142006.425809-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly set ret to zero instead of assigning it and overwriting it later,
which is a bit confusing to understand.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c        | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c
index d993c09a4820..cd2e92ae2293 100644
--- a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c
+++ b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c
@@ -220,7 +220,8 @@ static int sun8i_a83t_mipi_csi2_s_stream(struct v4l2_subdev *subdev, int on)
 		return -ENODEV;
 
 	if (!on) {
-		ret = v4l2_subdev_call(source_subdev, video, s_stream, 0);
+		v4l2_subdev_call(source_subdev, video, s_stream, 0);
+		ret = 0;
 		goto disable;
 	}
 
@@ -312,8 +313,6 @@ static int sun8i_a83t_mipi_csi2_s_stream(struct v4l2_subdev *subdev, int on)
 	return 0;
 
 disable:
-	if (!on)
-		ret = 0;
 	phy_power_off(dphy);
 	sun8i_a83t_mipi_csi2_disable(csi2_dev);
 
-- 
2.38.1

