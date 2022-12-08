Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C0E64711E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiLHNzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLHNzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:55:41 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF81B60361;
        Thu,  8 Dec 2022 05:55:40 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0B4602000C;
        Thu,  8 Dec 2022 13:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670507739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g8Fr5IFDx706AN895Lw8QOX+f28RaNPliLSLDFSc9/k=;
        b=DypI5lfuiecIIVcaJEqjMx2cjyjzOxg5nkvZ/I39jQRaEJS+7rCAdgPvs0e9elXqL2srzs
        hRvx2ocG9BH6ufyiJaazBQoUzZdh+eU8mVlGsBV5jLNX8IM8E+EE1Zk74ZjQTHhMYqy4Qu
        6uTrRiep8ArzZkRg1VmjynfDfnTAknYjvT74mzZSobhiAPO2fgEYN4SHW7DdBgn5DJQY1G
        oRZRN0oiGKCN5UmATvz90D2CMBQ5Tms3zCa65OdHzG8480mx89vbQLdTzNTAzjDdXcOkSF
        9+SKW6g+lIe6X+LXCluqkJ+ZH3+qrljx/g1aXVS6f8zLm98ngCKrr0NsDbp4rg==
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
Subject: [PATCH v2 01/11] media: sun6i-csi: bridge: Fix return code handling in stream off path
Date:   Thu,  8 Dec 2022 14:55:02 +0100
Message-Id: <20221208135512.421903-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208135512.421903-1-paul.kocialkowski@bootlin.com>
References: <20221208135512.421903-1-paul.kocialkowski@bootlin.com>
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

Explicitly set ret to zero on disable path to avoid a related smatch
warning. This makes initialization at declaration useless.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
index 86d20c1c35ed..88df3a73ebfa 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
@@ -415,8 +415,7 @@ static int sun6i_csi_bridge_s_stream(struct v4l2_subdev *subdev, int on)
 	struct sun6i_csi_bridge_source *source;
 	struct v4l2_subdev *source_subdev;
 	struct media_pad *remote_pad;
-	/* Initialize to 0 to use both in disable label (ret != 0) and off. */
-	int ret = 0;
+	int ret;
 
 	/* Source */
 
@@ -436,6 +435,7 @@ static int sun6i_csi_bridge_s_stream(struct v4l2_subdev *subdev, int on)
 
 	if (!on) {
 		v4l2_subdev_call(source_subdev, video, s_stream, 0);
+		ret = 0;
 		goto disable;
 	}
 
-- 
2.38.1

