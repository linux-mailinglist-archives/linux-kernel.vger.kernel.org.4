Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955F2646EF8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiLHLtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiLHLsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:48:22 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09BC813B9;
        Thu,  8 Dec 2022 03:48:18 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EE608240007;
        Thu,  8 Dec 2022 11:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670500097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nq7On3/y97eL5Yt3PQUNo7Mzs47XouX8Q1gOqpBPXDc=;
        b=ESnn3CLB9UXs+pb/6kjzhtYQHR/ob4VE/Q9MpLKgbAZNd5T8pMnicF/JIpWQAJQo7ISVAi
        lnhkngQ5QoD5Q8UtiNvrCjdWpy+tphZECKD6yEjaMPWLiGuMUoEQrph8DKwl3QjtM69fv6
        SBrg/MNDBL8RUXJzSRJSmiX9Y/PnBzkZVg1KwklD0xit34uoHgRarI89qcgV4DkM/ikWuV
        YskLD6Hhz1yqKaVWuf5pcVZk9M7fQTXv0cRn/v2nMEuSSlLWySxa1OesxhC2xb6pmzUhtJ
        DbhQ4mYv3ctamd4WN9vqmn83yqiIcMGeEgdeAcM45zxK1MOnFXj5I8Xjt1vx0A==
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
Subject: [PATCH 8/9] media: sun6i-isp: capture: Fix uninitialized variable use
Date:   Thu,  8 Dec 2022 12:47:41 +0100
Message-Id: <20221208114742.399461-9-paul.kocialkowski@bootlin.com>
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

While the stride_chroma variable was previously initialized to zero,
it's actually stride_chroma_div4 that is set to hardware registers.

Initialize it to zero instead to avoid an uninitialized variable use
and get rid of the associated smatch warning.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c
index 4b592820845a..1595a9607775 100644
--- a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c
+++ b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c
@@ -108,8 +108,8 @@ sun6i_isp_capture_buffer_configure(struct sun6i_isp_device *isp_dev,
 void sun6i_isp_capture_configure(struct sun6i_isp_device *isp_dev)
 {
 	unsigned int width, height;
-	unsigned int stride_luma, stride_chroma = 0;
-	unsigned int stride_luma_div4, stride_chroma_div4;
+	unsigned int stride_luma, stride_chroma;
+	unsigned int stride_luma_div4, stride_chroma_div4 = 0;
 	const struct sun6i_isp_capture_format *format;
 	const struct v4l2_format_info *info;
 	u32 pixelformat;
-- 
2.38.1

