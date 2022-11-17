Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C50C62D54A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbiKQInJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239637AbiKQImv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:42:51 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2FF742D4;
        Thu, 17 Nov 2022 00:42:44 -0800 (PST)
Received: from pyrite.tail37cf.ts.net (h175-177-042-159.catv02.itscom.jp [175.177.42.159])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 92E3A105A;
        Thu, 17 Nov 2022 09:42:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668674563;
        bh=i2asfCX+IMDeAysoWEUZxtuevcn/m7RupGOVGq+pXtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jlv+ep3R1ziV8qxaw1h/r1QAhnBwVi+NfM8FGGSVchGYr9WJmR7yJYtwomropQ5eg
         +49QNybsChYss3y1Ul4tcElyM/JxogoMJ+EDToDQxxZQm7Pg0J1kHtSETdkFI1Im5L
         rYnN3Z2cW5g4gtYnAeXyAcyz+5YrVtyz0ULCpRpQ=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] media: rkisp1: Implement ENUM_FRAMESIZES
Date:   Thu, 17 Nov 2022 17:42:17 +0900
Message-Id: <20221117084217.3892680-4-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221117084217.3892680-1-paul.elder@ideasonboard.com>
References: <20221117084217.3892680-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement VIDIOC_ENUM_FRAMESIZES for the rkisp1 capture devices.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 .../platform/rockchip/rkisp1/rkisp1-capture.c | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
index 91e685fdbbe9..03c2922bfbed 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
@@ -1236,6 +1236,35 @@ static int rkisp1_enum_fmt_vid_cap_mplane(struct file *file, void *priv,
 	return -EINVAL;
 }
 
+static int rkisp1_enum_framesizes(struct file *file, void *fh,
+				  struct v4l2_frmsizeenum *fsize)
+{
+	static const unsigned int max_widths[] = {
+		RKISP1_RSZ_MP_SRC_MAX_WIDTH,
+		RKISP1_RSZ_SP_SRC_MAX_WIDTH,
+	};
+	static const unsigned int max_heights[] = {
+		RKISP1_RSZ_MP_SRC_MAX_HEIGHT,
+		RKISP1_RSZ_SP_SRC_MAX_HEIGHT,
+	};
+	struct rkisp1_capture *cap = video_drvdata(file);
+
+	if (fsize->index != 0)
+		return -EINVAL;
+
+	fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
+
+	fsize->stepwise.min_width = RKISP1_RSZ_SRC_MIN_WIDTH;
+	fsize->stepwise.max_width = max_widths[cap->id];
+	fsize->stepwise.step_width = 2;
+
+	fsize->stepwise.min_height = RKISP1_RSZ_SRC_MIN_HEIGHT;
+	fsize->stepwise.max_height = max_heights[cap->id];
+	fsize->stepwise.step_height = 2;
+
+	return 0;
+}
+
 static int rkisp1_s_fmt_vid_cap_mplane(struct file *file,
 				       void *priv, struct v4l2_format *f)
 {
@@ -1285,6 +1314,7 @@ static const struct v4l2_ioctl_ops rkisp1_v4l2_ioctl_ops = {
 	.vidioc_s_fmt_vid_cap_mplane = rkisp1_s_fmt_vid_cap_mplane,
 	.vidioc_g_fmt_vid_cap_mplane = rkisp1_g_fmt_vid_cap_mplane,
 	.vidioc_enum_fmt_vid_cap = rkisp1_enum_fmt_vid_cap_mplane,
+	.vidioc_enum_framesizes = rkisp1_enum_framesizes,
 	.vidioc_querycap = rkisp1_querycap,
 	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
 	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
-- 
2.35.1

