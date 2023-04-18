Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52606E5B79
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjDRIDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjDRICu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:02:50 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC727DB6;
        Tue, 18 Apr 2023 01:02:25 -0700 (PDT)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id C321824001E;
        Tue, 18 Apr 2023 08:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681804934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zI1HE7xYpFUXXPJOpa1EDaS4Y2c6dkA50VEWah254Wo=;
        b=irXErdd8xPwyarlKe1jRze6lT993QTpw4Tx2xanfkQ65ACxGv9ta18N42bZHomyBfMPf4K
        c/eRLUiMBKNtEAZ1rYECxImo+AF0peAN8nMYGzQLvhCyGoi5nf/f0DkUXUngG1at2wTRv3
        LKwZfl27owGIUj2BvakXFUvODQ0R0b1jhBTcOifJ0gGnZ4m7W+ryqheuPc9VqIPX6whbhh
        MOTDb2/9PwJQa3BE+BXuLLxd2p291CztSoSFqPc7OPNc2Ny5EYYOxU7hdfCPm7IxvsNOu0
        GJi4dOIzrxN1lBrGA8py5nQn6YWWDau/5zwQDumASGd/Cmw5Gv6DF2xGPkMmiA==
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
Subject: [PATCH v6 19/20] staging: media: tegra-video: add H/V flip controls
Date:   Tue, 18 Apr 2023 10:00:53 +0200
Message-Id: <20230418080054.452955-20-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418080054.452955-1-luca.ceresoli@bootlin.com>
References: <20230418080054.452955-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra20 can do horizontal and vertical image flip, but Tegra210 cannot
(either the hardware, or this driver).

In preparation to adding Tegra20 support, add a flag in struct tegra_vi_soc
so the generic vi.c code knows whether the flip controls should be added or
not.

Also provide a generic implementation that simply sets two flags in the
channel struct. The Tegra20 implementation will enable flipping at stream
start based on those flags.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

---

No changes in v6

Changed in v5:
 - Fixed typo in comment

Changed in v4:
 - Added review tags

No changes in v3
No changes in v2
---
 drivers/staging/media/tegra-video/vi.c | 14 +++++++++++++-
 drivers/staging/media/tegra-video/vi.h |  8 ++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index 5ab24977ec46..39e9df895ede 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -30,7 +30,7 @@
 #include "vi.h"
 #include "video.h"
 
-#define MAX_CID_CONTROLS		1
+#define MAX_CID_CONTROLS		3
 
 /**
  * struct tegra_vi_graph_entity - Entity in the video graph
@@ -910,6 +910,12 @@ static int vi_s_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_TEGRA_SYNCPT_TIMEOUT_RETRY:
 		chan->syncpt_timeout_retry = ctrl->val;
 		break;
+	case V4L2_CID_HFLIP:
+		chan->hflip = ctrl->val;
+		break;
+	case V4L2_CID_VFLIP:
+		chan->vflip = ctrl->val;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -981,6 +987,12 @@ static int tegra_channel_setup_ctrl_handler(struct tegra_vi_channel *chan)
 		v4l2_ctrl_handler_free(&chan->ctrl_handler);
 		return ret;
 	}
+
+	if (chan->vi->soc->has_h_v_flip) {
+		v4l2_ctrl_new_std(&chan->ctrl_handler, &vi_ctrl_ops, V4L2_CID_HFLIP, 0, 1, 1, 0);
+		v4l2_ctrl_new_std(&chan->ctrl_handler, &vi_ctrl_ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
+	}
+
 #endif
 
 	/* setup the controls */
diff --git a/drivers/staging/media/tegra-video/vi.h b/drivers/staging/media/tegra-video/vi.h
index cadf80b742a8..778c0ec475ab 100644
--- a/drivers/staging/media/tegra-video/vi.h
+++ b/drivers/staging/media/tegra-video/vi.h
@@ -74,6 +74,7 @@ struct tegra_vi_ops {
  * @hw_revision: VI hw_revision
  * @vi_max_channels: supported max streaming channels
  * @vi_max_clk_hz: VI clock max frequency
+ * @has_h_v_flip: the chip can do H and V flip, and the driver implements it
  */
 struct tegra_vi_soc {
 	const struct tegra_video_format *video_formats;
@@ -83,6 +84,7 @@ struct tegra_vi_soc {
 	u32 hw_revision;
 	unsigned int vi_max_channels;
 	unsigned int vi_max_clk_hz;
+	bool has_h_v_flip:1;
 };
 
 /**
@@ -172,6 +174,9 @@ struct tegra_vi {
  * @tpg_fmts_bitmap: a bitmap for supported TPG formats
  * @pg_mode: test pattern generator mode (disabled/direct/patch)
  * @notifier: V4L2 asynchronous subdevs notifier
+ *
+ * @hflip: Horizontal flip is enabled
+ * @vflip: Vertical flip is enabled
  */
 struct tegra_vi_channel {
 	struct list_head list;
@@ -222,6 +227,9 @@ struct tegra_vi_channel {
 	enum tegra_vi_pg_mode pg_mode;
 
 	struct v4l2_async_notifier notifier;
+
+	bool hflip:1;
+	bool vflip:1;
 };
 
 /**
-- 
2.34.1

