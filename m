Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D081C6DAE12
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbjDGNmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240906AbjDGNmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:42:04 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A098CC65C;
        Fri,  7 Apr 2023 06:40:39 -0700 (PDT)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 3652D1BF206;
        Fri,  7 Apr 2023 13:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680874837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iG8BI+zr/W2AXL7PDXQ6I+9rA0Kv82uppDBlj9/iJJg=;
        b=e7jkhAy0vza2P56aX7IbINv9E8j7N0e7KsJlylfCE7juqR9rsMV20Fhq/71xXG0tjyxJ/Y
        S05ShWVlJTGdsvtPGMPAxPIviZaxFk7nYZ7CqwVFZE8b5h2VXnZTvep4ZwAnANe9Kfu0Ib
        EsC3a2LxrZgzEc2Ihlnx0Rj52DHsjSIF5mWHlLcOLGd2hhUF4Hee0KfqGqpPToLct3zUqy
        lp45xlZ/+IHO9tzzPlKW1TuyNjPZFEu3gHXrvzICYxbFkMUzTjZ/zKmmY6nmtbG3thPfYI
        sxxWrWpdc7NAN2xEL5VbgL54FPndZUaqVlBeeAneYXF8JxVH3WlG8C7JvRmGcw==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     linux-tegra@vger.kernel.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v5 16/20] staging: media: tegra-video: move syncpt init/free to a per-soc op
Date:   Fri,  7 Apr 2023 15:38:48 +0200
Message-Id: <20230407133852.2850145-17-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407133852.2850145-1-luca.ceresoli@bootlin.com>
References: <20230407133852.2850145-1-luca.ceresoli@bootlin.com>
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

tegra_channel_host1x_syncpt_init() gets the host1x syncpts needed for the
Tegra210 implementation, and tegra_channel_host1x_syncpts_free() puts
them.

Tegra20 needs to get and put a different syncpt. In preparation for adding
Tegra20 support, move these functions to new ops in the soc-specific
`struct tegra_vi_ops` .

No functional changes.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

---

No changes in v5

Changed in v4:
 - Added review tags

No changes in v3
No changes in v2
---
 drivers/staging/media/tegra-video/tegra210.c | 52 ++++++++++++++++++++
 drivers/staging/media/tegra-video/vi.c       | 52 ++------------------
 drivers/staging/media/tegra-video/vi.h       |  5 ++
 3 files changed, 60 insertions(+), 49 deletions(-)

diff --git a/drivers/staging/media/tegra-video/tegra210.c b/drivers/staging/media/tegra-video/tegra210.c
index b4fcd4e93b8c..da99f19a39e7 100644
--- a/drivers/staging/media/tegra-video/tegra210.c
+++ b/drivers/staging/media/tegra-video/tegra210.c
@@ -179,6 +179,56 @@ static u32 vi_csi_read(struct tegra_vi_channel *chan, u8 portno,
 /*
  * Tegra210 VI channel capture operations
  */
+
+static int tegra210_channel_host1x_syncpt_init(struct tegra_vi_channel *chan)
+{
+	struct tegra_vi *vi = chan->vi;
+	unsigned long flags = HOST1X_SYNCPT_CLIENT_MANAGED;
+	struct host1x_syncpt *fs_sp;
+	struct host1x_syncpt *mw_sp;
+	int ret, i;
+
+	for (i = 0; i < chan->numgangports; i++) {
+		fs_sp = host1x_syncpt_request(&vi->client, flags);
+		if (!fs_sp) {
+			dev_err(vi->dev, "failed to request frame start syncpoint\n");
+			ret = -ENOMEM;
+			goto free_syncpts;
+		}
+
+		mw_sp = host1x_syncpt_request(&vi->client, flags);
+		if (!mw_sp) {
+			dev_err(vi->dev, "failed to request memory ack syncpoint\n");
+			host1x_syncpt_put(fs_sp);
+			ret = -ENOMEM;
+			goto free_syncpts;
+		}
+
+		chan->frame_start_sp[i] = fs_sp;
+		chan->mw_ack_sp[i] = mw_sp;
+		spin_lock_init(&chan->sp_incr_lock[i]);
+	}
+
+	return 0;
+
+free_syncpts:
+	for (i = 0; i < chan->numgangports; i++) {
+		host1x_syncpt_put(chan->mw_ack_sp[i]);
+		host1x_syncpt_put(chan->frame_start_sp[i]);
+	}
+	return ret;
+}
+
+static void tegra210_channel_host1x_syncpt_free(struct tegra_vi_channel *chan)
+{
+	int i;
+
+	for (i = 0; i < chan->numgangports; i++) {
+		host1x_syncpt_put(chan->mw_ack_sp[i]);
+		host1x_syncpt_put(chan->frame_start_sp[i]);
+	}
+}
+
 static void tegra210_fmt_align(struct v4l2_pix_format *pix, unsigned int bpp)
 {
 	unsigned int min_bpl;
@@ -753,6 +803,8 @@ static const struct tegra_video_format tegra210_video_formats[] = {
 
 /* Tegra210 VI operations */
 static const struct tegra_vi_ops tegra210_vi_ops = {
+	.channel_host1x_syncpt_init = tegra210_channel_host1x_syncpt_init,
+	.channel_host1x_syncpt_free = tegra210_channel_host1x_syncpt_free,
 	.vi_fmt_align = tegra210_fmt_align,
 	.vi_start_streaming = tegra210_vi_start_streaming,
 	.vi_stop_streaming = tegra210_vi_stop_streaming,
diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index 8df233049c81..b74cdd1d1c82 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -1062,21 +1062,11 @@ static int vi_fmts_bitmap_init(struct tegra_vi_channel *chan)
 	return 0;
 }
 
-static void tegra_channel_host1x_syncpts_free(struct tegra_vi_channel *chan)
-{
-	int i;
-
-	for (i = 0; i < chan->numgangports; i++) {
-		host1x_syncpt_put(chan->mw_ack_sp[i]);
-		host1x_syncpt_put(chan->frame_start_sp[i]);
-	}
-}
-
 static void tegra_channel_cleanup(struct tegra_vi_channel *chan)
 {
 	v4l2_ctrl_handler_free(&chan->ctrl_handler);
 	media_entity_cleanup(&chan->video.entity);
-	tegra_channel_host1x_syncpts_free(chan);
+	chan->vi->ops->channel_host1x_syncpt_free(chan);
 	mutex_destroy(&chan->video_lock);
 }
 
@@ -1094,42 +1084,6 @@ void tegra_channels_cleanup(struct tegra_vi *vi)
 	}
 }
 
-static int tegra_channel_host1x_syncpt_init(struct tegra_vi_channel *chan)
-{
-	struct tegra_vi *vi = chan->vi;
-	unsigned long flags = HOST1X_SYNCPT_CLIENT_MANAGED;
-	struct host1x_syncpt *fs_sp;
-	struct host1x_syncpt *mw_sp;
-	int ret, i;
-
-	for (i = 0; i < chan->numgangports; i++) {
-		fs_sp = host1x_syncpt_request(&vi->client, flags);
-		if (!fs_sp) {
-			dev_err(vi->dev, "failed to request frame start syncpoint\n");
-			ret = -ENOMEM;
-			goto free_syncpts;
-		}
-
-		mw_sp = host1x_syncpt_request(&vi->client, flags);
-		if (!mw_sp) {
-			dev_err(vi->dev, "failed to request memory ack syncpoint\n");
-			host1x_syncpt_put(fs_sp);
-			ret = -ENOMEM;
-			goto free_syncpts;
-		}
-
-		chan->frame_start_sp[i] = fs_sp;
-		chan->mw_ack_sp[i] = mw_sp;
-		spin_lock_init(&chan->sp_incr_lock[i]);
-	}
-
-	return 0;
-
-free_syncpts:
-	tegra_channel_host1x_syncpts_free(chan);
-	return ret;
-}
-
 static int tegra_channel_init(struct tegra_vi_channel *chan)
 {
 	struct tegra_vi *vi = chan->vi;
@@ -1155,7 +1109,7 @@ static int tegra_channel_init(struct tegra_vi_channel *chan)
 	chan->format.sizeimage = chan->format.bytesperline * TEGRA_DEF_HEIGHT;
 	vi->ops->vi_fmt_align(&chan->format, chan->fmtinfo->bpp);
 
-	ret = tegra_channel_host1x_syncpt_init(chan);
+	ret = vi->ops->channel_host1x_syncpt_init(chan);
 	if (ret)
 		return ret;
 
@@ -1218,7 +1172,7 @@ static int tegra_channel_init(struct tegra_vi_channel *chan)
 cleanup_media:
 	media_entity_cleanup(&chan->video.entity);
 free_syncpts:
-	tegra_channel_host1x_syncpts_free(chan);
+	vi->ops->channel_host1x_syncpt_free(chan);
 	return ret;
 }
 
diff --git a/drivers/staging/media/tegra-video/vi.h b/drivers/staging/media/tegra-video/vi.h
index 886b10e7d723..dfb5870b1411 100644
--- a/drivers/staging/media/tegra-video/vi.h
+++ b/drivers/staging/media/tegra-video/vi.h
@@ -38,10 +38,13 @@ enum tegra_vi_pg_mode {
 };
 
 struct tegra_vi;
+struct tegra_vi_channel;
 
 /**
  * struct tegra_vi_ops - Tegra VI operations
  * @vi_enable: soc-specific operations needed to enable/disable the VI peripheral
+ * @channel_host1x_syncpt_init: initialize synchronization points
+ * @channel_host1x_syncpt_free: free all synchronization points
  * @vi_fmt_align: modify `pix` to fit the hardware alignment
  *		requirements and fill image geometry
  * @vi_start_streaming: starts media pipeline, subdevice streaming, sets up
@@ -52,6 +55,8 @@ struct tegra_vi;
  */
 struct tegra_vi_ops {
 	int (*vi_enable)(struct tegra_vi *vi, bool on);
+	int (*channel_host1x_syncpt_init)(struct tegra_vi_channel *chan);
+	void (*channel_host1x_syncpt_free)(struct tegra_vi_channel *chan);
 	void (*vi_fmt_align)(struct v4l2_pix_format *pix, unsigned int bpp);
 	int (*vi_start_streaming)(struct vb2_queue *vq, u32 count);
 	void (*vi_stop_streaming)(struct vb2_queue *vq);
-- 
2.34.1

