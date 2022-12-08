Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7755B647184
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiLHOVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiLHOUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:20:52 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4774787CA5;
        Thu,  8 Dec 2022 06:20:43 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4266EC000A;
        Thu,  8 Dec 2022 14:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670509241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qaVD0FADrXBGUP1SDekzCFjadqnGQazSN58ScFrhxkc=;
        b=OEoSIaw7PGuQdliNj0fxWV6fDXA7gLV2OUCqe0xh2F/gYXOVgDKpucj7//9KmHzgf2sH9M
        zJuuN8RuAdUbizT2JwE/iPeYnwOmQszBDKpCxNUGt/8pTiX2ravexp1Jh93QtVDTKzhC08
        Ijsh692oQ1hx/wVABfDm3O42cLpjzmr5XSNfHVzFnLKf6Fa26npDikD1Wpq/OPyUhtKWU5
        fEBVd/eCij3HSuG2gHFspbKcCCmagXDn2+W0g+TyHUniBwi8exJBnP1QAPzbsYbszJlcSE
        VBxKNW0mXsGN8/AUiyvBFvbEilB2BX/6QmK0ZdeIkerICFAnpojmG8CCUx/vcg==
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
Subject: [PATCH v3 07/12] media: sun6i-isp: proc: Fix return code handling in stream off path
Date:   Thu,  8 Dec 2022 15:20:01 +0100
Message-Id: <20221208142006.425809-8-paul.kocialkowski@bootlin.com>
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

Explicitly set ret to zero on disable path to avoid a related smatch
warning. This makes initialization at declaration useless.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Fixes: e3185e1d7c14 ("media: staging: media: Add support for the Allwinner A31 ISP")
---
 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c
index d69d2be0add2..a95709d2c573 100644
--- a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c
+++ b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c
@@ -173,8 +173,7 @@ static int sun6i_isp_proc_s_stream(struct v4l2_subdev *subdev, int on)
 	struct sun6i_isp_proc_source *source;
 	struct v4l2_subdev *source_subdev;
 	struct media_pad *remote_pad;
-	/* Initialize to 0 to use both in disable label (ret != 0) and off. */
-	int ret = 0;
+	int ret;
 
 	/* Source */
 
@@ -195,6 +194,7 @@ static int sun6i_isp_proc_s_stream(struct v4l2_subdev *subdev, int on)
 	if (!on) {
 		sun6i_isp_proc_irq_disable(isp_dev);
 		v4l2_subdev_call(source_subdev, video, s_stream, 0);
+		ret = 0;
 		goto disable;
 	}
 
-- 
2.38.1

