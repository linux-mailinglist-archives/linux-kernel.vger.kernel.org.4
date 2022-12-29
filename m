Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24811658D75
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 14:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbiL2NeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 08:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbiL2Ndq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 08:33:46 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAA311A27;
        Thu, 29 Dec 2022 05:33:09 -0800 (PST)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 5C276FF812;
        Thu, 29 Dec 2022 13:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672320787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lDh7ovUv1NsjYYG9vHMcYl6Rlz2zcTrLvyA2JBDuVnw=;
        b=fGSubC0oFfhQt6asu+w9xt+fwAuoCz2m40sDh4ZoSorud2DDeMoiObP4ktbgfaZfXJIxIJ
        umHOYKYtrgjWuTmg7PzyU0d8cyRRxszd8idImAWPpFG1UxQa6Y5ty5/Q4YjUSfnFd/jJ6Q
        d7EcocMwN9qOSsvyXOwt7AEg8mAG4A1fI4exxU0qXxTyhKwe+aVS8K74nONhs3/C67j294
        6HuU6WxrceuuoPVWkYBNMm9kQrjuCoIFiNOxUBnQYxzgxSRD3BhNs7vvbfN4CnVhJLiNbl
        FEFk93AvRJ8JL/1hqhn/SIvz5T03VNKvaKr7y+8q6kct5zUPHEh28goCDVjFnw==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH v3 20/21] staging: media: tegra-video: add H/V flip controls
Date:   Thu, 29 Dec 2022 14:32:04 +0100
Message-Id: <20221229133205.981397-21-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229133205.981397-1-luca.ceresoli@bootlin.com>
References: <20221229133205.981397-1-luca.ceresoli@bootlin.com>
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

Tegra20 can do horizontal and vertical image flip, but Tegra210 cannot
(either the hardware, or this driver).

In preparation to adding Tegra20 support, add a flag in struct tegra_vi_soc
so the generic vi.c code knows whether the flip controls should be added or
not.

Also provide a generic implementation that simply sets two flags in the
channel struct. The Tegra20 implementation will enable flipping at stream
start based on those flags.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

No changes in v3
No changes in v2
---
 drivers/staging/media/tegra-video/vi.c | 14 +++++++++++++-
 drivers/staging/media/tegra-video/vi.h |  8 ++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index 4a066b61ab8e..d1c6877163c2 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -29,7 +29,7 @@
 #include "vi.h"
 #include "video.h"
 
-#define MAX_CID_CONTROLS		1
+#define MAX_CID_CONTROLS		3
 
 /**
  * struct tegra_vi_graph_entity - Entity in the video graph
@@ -893,6 +893,12 @@ static int vi_s_ctrl(struct v4l2_ctrl *ctrl)
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
@@ -964,6 +970,12 @@ static int tegra_channel_setup_ctrl_handler(struct tegra_vi_channel *chan)
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
index 0503eb678556..8fa817757059 100644
--- a/drivers/staging/media/tegra-video/vi.h
+++ b/drivers/staging/media/tegra-video/vi.h
@@ -74,6 +74,7 @@ struct tegra_vi_ops {
  * @hw_revision: VI hw_revision
  * @vi_max_channels: supported max streaming channels
  * @vi_max_clk_hz: VI clock max frequency
+ * @has_h_v_flip: the chip can do H adn V flip, and the driver implements it
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
@@ -170,6 +172,9 @@ struct tegra_vi {
  * @syncpt_timeout_retry: syncpt timeout retry count for the capture
  * @pg_mode: test pattern generator mode (disabled/direct/patch)
  * @notifier: V4L2 asynchronous subdevs notifier
+ *
+ * @hflip: Horizontal flip is enabled
+ * @vflip: Vertical flip is enabled
  */
 struct tegra_vi_channel {
 	struct list_head list;
@@ -218,6 +223,9 @@ struct tegra_vi_channel {
 	enum tegra_vi_pg_mode pg_mode;
 
 	struct v4l2_async_notifier notifier;
+
+	bool hflip:1;
+	bool vflip:1;
 };
 
 /**
-- 
2.34.1

