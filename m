Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EAA646EF5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiLHLtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiLHLsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:48:18 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F417984DD2;
        Thu,  8 Dec 2022 03:48:13 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DC0A324000B;
        Thu,  8 Dec 2022 11:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670500092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NirQ4Z0H8CCFNO8YF35iEuHBJ67K2AC07Y4K8xGkunI=;
        b=dlGNyauohT4CoLW3XYw+fCDaDPtU8a3v2UOKSI0wqcvevc6rxyFnt2g3zIQ+DYQa4e37tM
        srYnxcABuEk1VtpY9Kq5FSUBb5B36aUJ4XVrPLth6APh8HbO5TQBkXBUTLSer+UkrSk2of
        0dAMaayNJi3YQuE8eT6rNq7m8xZtg7okPfB+HvTcllTwn6SK3v8SpOdLLTDs5bFw3Oja6c
        P5urxxIIt/IgIZAuWRaIKyOrFa/rBYW5WqKJFx7kMmkwCwc+eiBcfs0Omg+qD8LhwWqScI
        xBrRc4RVSykMkkBuzcfZU+2qvtzdU7k/qIfKGBS9aD6vfMoPou/clp4Cz+WVnA==
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
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH 6/9] media: sun6i-isp: bridge: Fix return code handling in stream off path
Date:   Thu,  8 Dec 2022 12:47:39 +0100
Message-Id: <20221208114742.399461-7-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208114742.399461-1-paul.kocialkowski@bootlin.com>
References: <20221208114742.399461-1-paul.kocialkowski@bootlin.com>
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

