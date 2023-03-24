Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA20D6C80E1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjCXPNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjCXPNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:13:14 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0488D1B0;
        Fri, 24 Mar 2023 08:12:56 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A116DE001E;
        Fri, 24 Mar 2023 15:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679670775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r+i8mUIhWtFV9XGBR7tTV1Ij/OB6oMkb1et6Czsk7zo=;
        b=OMh9PlANLksoDm/e9yK92YUnsJXBS/POfKawy8xHW9nxfgiKoQbPauHSCwWiE3IocUCGZS
        vUzyfYwKPKwg0wLAnJLHUclfwpd4Pu4AXDG9PgEyEGzorETZxE+pAQPhzRByVk9mMujomw
        hexpUhnbpgaNJKJWXc2tOeZ8Nq4X25oQ5PK2sznsE8hT+CB4luzkdCZwSLyMp2RLdZOd0F
        yECcBPXygUkQLkwC/Qm+T7OtCu9NZu/03hz2C6+2F0hoZnmECKIDTOC9G/dmMTwKdENNlH
        BFBNkVH1D5yybztsVVufy8SurlRs3ChUkW2UNuzgXJXkodSPBW8vqKbt9zqgGA==
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
Subject: [PATCH 9/9] media: sun6i-isp: capture: Implement enum_framesizes
Date:   Fri, 24 Mar 2023 16:12:28 +0100
Message-Id: <20230324151228.2778112-10-paul.kocialkowski@bootlin.com>
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

Report available frame sizes as a continuous range between the
hardware min/max limits.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Co-authored-by: Adam Pigg <adam@piggz.co.uk>
Signed-off-by: Adam Pigg <adam@piggz.co.uk>
---
 .../media/sunxi/sun6i-isp/sun6i_isp_capture.c | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c
index 5160b93b69ff..a368f90a9beb 100644
--- a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c
+++ b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c
@@ -487,6 +487,30 @@ static int sun6i_isp_capture_try_fmt(struct file *file, void *private,
 	return 0;
 }
 
+static int
+sun6i_isp_capture_enum_framesizes(struct file *file, void *fh,
+				  struct v4l2_frmsizeenum *frmsizeenum)
+{
+	const struct sun6i_isp_capture_format *format;
+
+	if (frmsizeenum->index > 0)
+		return -EINVAL;
+
+	format = sun6i_isp_capture_format_find(frmsizeenum->pixel_format);
+	if (!format)
+		return -EINVAL;
+
+	frmsizeenum->type = V4L2_FRMSIZE_TYPE_CONTINUOUS;
+	frmsizeenum->stepwise.min_width = SUN6I_ISP_CAPTURE_WIDTH_MIN;
+	frmsizeenum->stepwise.max_width = SUN6I_ISP_CAPTURE_WIDTH_MAX;
+	frmsizeenum->stepwise.min_height = SUN6I_ISP_CAPTURE_HEIGHT_MIN;
+	frmsizeenum->stepwise.max_height = SUN6I_ISP_CAPTURE_HEIGHT_MAX;
+	frmsizeenum->stepwise.step_width = 1;
+	frmsizeenum->stepwise.step_height = 1;
+
+	return 0;
+}
+
 static int sun6i_isp_capture_enum_input(struct file *file, void *private,
 					struct v4l2_input *input)
 {
@@ -524,6 +548,8 @@ static const struct v4l2_ioctl_ops sun6i_isp_capture_ioctl_ops = {
 	.vidioc_s_fmt_vid_cap		= sun6i_isp_capture_s_fmt,
 	.vidioc_try_fmt_vid_cap		= sun6i_isp_capture_try_fmt,
 
+	.vidioc_enum_framesizes		= sun6i_isp_capture_enum_framesizes,
+
 	.vidioc_enum_input		= sun6i_isp_capture_enum_input,
 	.vidioc_g_input			= sun6i_isp_capture_g_input,
 	.vidioc_s_input			= sun6i_isp_capture_s_input,
-- 
2.39.2

