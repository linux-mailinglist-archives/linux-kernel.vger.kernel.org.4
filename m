Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85523622DB4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiKIOWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiKIOVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:21:13 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB11423BD6;
        Wed,  9 Nov 2022 06:20:15 -0800 (PST)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 37FB6FF814;
        Wed,  9 Nov 2022 14:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668003611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ip9bY6YtCyentpwiI3F4YXAllQWzlsRpRMRpuGovH+Q=;
        b=Lr4nREZOfO+LFPK3DCjfLBoqjPwcJMm0VPhDXTEdDRxLmH+lBToivka/UFWywVGmbD5SUa
        +6DuJxmUMe/q4dNgwBg1mRPc8f+lGDJYhwdFV1mZi0f1P1V7dLymPgM1+uFDddAOjzIFO/
        5wNFy1+Iesd50jZ8Hdyy3EXny1sapeVpGDRQDItYeGTEEswF2IlxsoQt/pNZmAM4nEWIB1
        kBL/eGrRml71m5H8yWHsZKDYHsCguA7qsAxL1gRpYWL8Wgo/5YNmFeCt4//iIA24EjeKy/
        R05LZwXvYa8Vgg0VCU/XW9YQeeILJzWotjDUIUq4+Lph4RH9xLzvR5N/zyAkFA==
From:   luca.ceresoli@bootlin.com
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH 20/23] staging: media: tegra-video: add hooks for planar YUV and H/V flip
Date:   Wed,  9 Nov 2022 15:18:49 +0100
Message-Id: <20221109141852.729246-21-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109141852.729246-1-luca.ceresoli@bootlin.com>
References: <20221109141852.729246-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

Tegra20 supports planar YUV422 capture, which can be implemented by writing
U and V base address registers in addition to the "main" base buffer
address register.

It also supports H and V flip, which among others requires to write the
start address (i.e. the 1st offset to write, at the end of the buffer or
line) in more registers for Y and, for planar formats, U and V.

Add minimal hooks in VI to allow per-SoC optional support to those
features:

 - variables in struct tegra_vi for the U and V buffer base offsets
 - variables in struct tegra_vi for the Y, U and V buffer start offsets
 - an optional per-soc VI operation to compute those values on queue setup

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/staging/media/tegra-video/vi.c |  4 ++++
 drivers/staging/media/tegra-video/vi.h | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index 854ffb4b5617..ebb502a45e96 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -92,6 +92,7 @@ tegra_get_format_by_fourcc(struct tegra_vi *vi, u32 fourcc)
 /*
  * videobuf2 queue operations
  */
+
 static int tegra_channel_queue_setup(struct vb2_queue *vq,
 				     unsigned int *nbuffers,
 				     unsigned int *nplanes,
@@ -107,6 +108,9 @@ static int tegra_channel_queue_setup(struct vb2_queue *vq,
 	sizes[0] = chan->format.sizeimage;
 	alloc_devs[0] = chan->vi->dev;
 
+	if (chan->vi->ops->channel_queue_setup)
+		chan->vi->ops->channel_queue_setup(chan);
+
 	return 0;
 }
 
diff --git a/drivers/staging/media/tegra-video/vi.h b/drivers/staging/media/tegra-video/vi.h
index ba563cd17296..a23ee8800d33 100644
--- a/drivers/staging/media/tegra-video/vi.h
+++ b/drivers/staging/media/tegra-video/vi.h
@@ -47,6 +47,7 @@ struct tegra_vi_channel;
  * @channel_host1x_syncpt_free: free all synchronization points
  * @vi_fmt_align: modify `pix` to fit the hardware alignment
  *		requirements and fill image geometry
+ * @channel_queue_setup: additional operations at the end of vb2_ops::queue_setup
  * @vi_start_streaming: starts media pipeline, subdevice streaming, sets up
  *		VI for capture and runs capture start and capture finish
  *		kthreads for capturing frames to buffer and returns them back.
@@ -58,6 +59,7 @@ struct tegra_vi_ops {
 	int (*channel_host1x_syncpt_init)(struct tegra_vi_channel *chan);
 	void (*channel_host1x_syncpt_free)(struct tegra_vi_channel *chan);
 	void (*vi_fmt_align)(struct v4l2_pix_format *pix, unsigned int bpp);
+	void (*channel_queue_setup)(struct tegra_vi_channel *chan);
 	int (*vi_start_streaming)(struct vb2_queue *vq, u32 count);
 	void (*vi_stop_streaming)(struct vb2_queue *vq);
 };
@@ -148,6 +150,12 @@ struct tegra_vi {
  * @queue: vb2 buffers queue
  * @sequence: V4L2 buffers sequence number
  *
+ * @addr_offset_u: U plane base address, relative to buffer base address (only for planar)
+ * @addr_offset_v: V plane base address, relative to buffer base address (only for planar)
+ * @start_offset:   1st Y byte to write, relative to buffer base address (for H/V flip)
+ * @start_offset_u: 1st U byte to write, relative to buffer base address (for H/V flip)
+ * @start_offset_v: 1st V byte to write, relative to buffer base address (for H/V flip)
+ *
  * @capture: list of queued buffers for capture
  * @start_lock: protects the capture queued list
  * @done: list of capture done queued buffers
@@ -188,6 +196,12 @@ struct tegra_vi_channel {
 	struct vb2_queue queue;
 	u32 sequence;
 
+	unsigned int addr_offset_u;
+	unsigned int addr_offset_v;
+	unsigned int start_offset;
+	unsigned int start_offset_u;
+	unsigned int start_offset_v;
+
 	struct list_head capture;
 	/* protects the capture queued list */
 	spinlock_t start_lock;
-- 
2.34.1

