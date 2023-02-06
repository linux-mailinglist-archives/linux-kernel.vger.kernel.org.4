Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEE368B4EA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 05:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjBFEf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 23:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjBFEfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 23:35:17 -0500
Received: from kozue.soulik.info (kozue.soulik.info [IPv6:2001:19f0:7000:8404:5054:ff:fe75:428f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA40519F29;
        Sun,  5 Feb 2023 20:34:52 -0800 (PST)
Received: from misaki.sumomo.pri (unknown [192.168.0.134])
        by kozue.soulik.info (Postfix) with ESMTPA id 49149100DAB;
        Mon,  6 Feb 2023 13:34:31 +0900 (JST)
From:   ayaka <ayaka@soulik.info>
To:     linux-media@vger.kernel.org
Cc:     randy.li@synaptics.com, Brian.Starkey@arm.com,
        boris.brezillon@collabora.com, frkoenig@chromium.org,
        hans.verkuil@cisco.com, hiroh@chromium.org, hverkuil@xs4all.nl,
        kernel@collabora.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        narmstrong@baylibre.com, nicolas@ndufresne.ca, sakari.ailus@iki.fi,
        stanimir.varbanov@linaro.org, tfiga@chromium.org,
        Helen Koike <helen.koike@collabora.com>
Subject: [PATCH v7 6/9] media: vivid: use vb2_ioctls_ext_{d}qbuf hooks
Date:   Mon,  6 Feb 2023 12:33:05 +0800
Message-Id: <20230206043308.28365-7-ayaka@soulik.info>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206043308.28365-1-ayaka@soulik.info>
References: <20230206043308.28365-1-ayaka@soulik.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helen Koike <helen.koike@collabora.com>

Add vb2 ext hooks and call vb2_set_pixelformat().
This allows more flexibility with buffer handling.

Signed-off-by: Helen Koike <helen.koike@collabora.com>
---
Changes in v6:
- New patch to exemplify how drivers would easily support features from Ext Buf
---
 drivers/media/test-drivers/vivid/vivid-core.c    | 2 ++
 drivers/media/test-drivers/vivid/vivid-vid-cap.c | 1 +
 drivers/media/test-drivers/vivid/vivid-vid-out.c | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/media/test-drivers/vivid/vivid-core.c b/drivers/media/test-drivers/vivid/vivid-core.c
index d4ed55aef1bb..f033c9c4e9aa 100644
--- a/drivers/media/test-drivers/vivid/vivid-core.c
+++ b/drivers/media/test-drivers/vivid/vivid-core.c
@@ -728,6 +728,8 @@ static const struct v4l2_ioctl_ops vivid_ioctl_ops = {
 	.vidioc_querybuf		= vb2_ioctl_querybuf,
 	.vidioc_qbuf			= vb2_ioctl_qbuf,
 	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
+	.vidioc_ext_qbuf		= vb2_ioctl_ext_qbuf,
+	.vidioc_ext_dqbuf		= vb2_ioctl_ext_dqbuf,
 	.vidioc_expbuf			= vb2_ioctl_expbuf,
 	.vidioc_streamon		= vb2_ioctl_streamon,
 	.vidioc_streamoff		= vb2_ioctl_streamoff,
diff --git a/drivers/media/test-drivers/vivid/vivid-vid-cap.c b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
index 3e3a94a2e3d6..bbe0fc2a3627 100644
--- a/drivers/media/test-drivers/vivid/vivid-vid-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
@@ -170,6 +170,7 @@ static int vid_cap_buf_prepare(struct vb2_buffer *vb)
 		}
 
 		vb2_set_plane_payload(vb, p, size);
+		vb2_set_pixelformat(vb, dev->fmt_cap->fourcc);
 		vb->planes[p].data_offset = dev->fmt_cap->data_offset[p];
 	}
 
diff --git a/drivers/media/test-drivers/vivid/vivid-vid-out.c b/drivers/media/test-drivers/vivid/vivid-vid-out.c
index 936ba93c00cc..5f224f13aa99 100644
--- a/drivers/media/test-drivers/vivid/vivid-vid-out.c
+++ b/drivers/media/test-drivers/vivid/vivid-vid-out.c
@@ -137,6 +137,7 @@ static int vid_out_buf_prepare(struct vb2_buffer *vb)
 			return -EINVAL;
 		}
 	}
+	vb2_set_pixelformat(vb, dev->fmt_out->fourcc);
 
 	return 0;
 }
-- 
2.17.1

