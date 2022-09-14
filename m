Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BEF5B8B32
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiINPDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiINPDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:03:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D22274361;
        Wed, 14 Sep 2022 08:03:14 -0700 (PDT)
Received: from dimapc.. (109-252-122-187.nat.spd-mgts.ru [109.252.122.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 087C56601BDF;
        Wed, 14 Sep 2022 16:03:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663167792;
        bh=MKe6/s3tvLmdyJXZjKooDqWZzASfXtNe2FVvnbAhZLM=;
        h=From:To:Cc:Subject:Date:From;
        b=RKoQTFo8BXGuXtV1ZJtrlPH1iX7chZWETLyGqWYcAfSu+PT2P3sRjrQrbdeOok/tg
         di91k1Bjtixc6gaBuvHWc72tPj4IVVdM3D/blyyTynKXBIZ57KjRJJINHL3JFQigOo
         0ykVUxISaO6Ty3jVxSez7Ct6HYQSroGAGsLsvZdi8vgg7nxfqwadw764uzmfvWPEAj
         JiVPqJ0BCWhQgyXgYByRaYocmJrubd33yH0rKD/jqRKQ598XLaRhUTkMPHpUV+xnwc
         q0FODgTcS4USQB/2UrGMCd00pMKW8OyGShTcQR6DPYwWs55tl7HcDNhvoZylJNQoXP
         43ONzAShPnKlw==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v1] media: cedrus: Propagate error code from cedrus_h265_skip_bits()
Date:   Wed, 14 Sep 2022 18:01:05 +0300
Message-Id: <20220914150105.209484-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cedrus_h265_skip_bits() may get into infinite loop if decoding
parameters are incorrect. In this case we detect the loop and print
a error message, continuing the decoding that is fated to fail.

Will be cleaner to abort the decoding early. Propagate the error code
to cedrus_device_run() and reset hardware on the cedrus_h265_skip_bits()
failure.

Suggested-by: Jernej Škrabec <jernej.skrabec@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus_dec.c  |  2 ++
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c | 15 ++++++++++++---
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c   |  7 ++++++-
 drivers/staging/media/sunxi/cedrus/cedrus_hw.h   |  2 ++
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
index e7f7602a5ab4..ae5df3dc01c0 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
@@ -112,6 +112,8 @@ void cedrus_device_run(void *priv)
 
 		dev->dec_ops[ctx->current_codec]->trigger(ctx);
 	} else {
+		cedrus_hw_reset(dev);
+
 		v4l2_m2m_buf_done_and_job_finish(ctx->dev->m2m_dev,
 						 ctx->fh.m2m_ctx,
 						 VB2_BUF_STATE_ERROR);
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index 4952fc17f3e6..f409f59452d8 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -224,9 +224,10 @@ static void cedrus_h265_pred_weight_write(struct cedrus_dev *dev,
 	}
 }
 
-static void cedrus_h265_skip_bits(struct cedrus_dev *dev, int num)
+static int cedrus_h265_skip_bits(struct cedrus_dev *dev, int num)
 {
 	int count = 0;
+	int err;
 
 	while (count < num) {
 		int tmp = min(num - count, 32);
@@ -235,11 +236,16 @@ static void cedrus_h265_skip_bits(struct cedrus_dev *dev, int num)
 			     VE_DEC_H265_TRIGGER_FLUSH_BITS |
 			     VE_DEC_H265_TRIGGER_TYPE_N_BITS(tmp));
 
-		if (cedrus_wait_for(dev, VE_DEC_H265_STATUS, VE_DEC_H265_STATUS_VLD_BUSY))
+		err = cedrus_wait_for(dev, VE_DEC_H265_STATUS, VE_DEC_H265_STATUS_VLD_BUSY);
+		if (err) {
 			dev_err_ratelimited(dev->dev, "timed out waiting to skip bits\n");
+			return err;
+		}
 
 		count += tmp;
 	}
+
+	return 0;
 }
 
 static void cedrus_h265_write_scaling_list(struct cedrus_ctx *ctx,
@@ -408,6 +414,7 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	u32 pic_order_cnt[2];
 	u8 *padding;
 	int count;
+	int err;
 	u32 reg;
 
 	sps = run->h265.sps;
@@ -534,7 +541,9 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	/* Include the one bit. */
 	count++;
 
-	cedrus_h265_skip_bits(dev, slice_params->data_byte_offset * 8 - count);
+	err = cedrus_h265_skip_bits(dev, slice_params->data_byte_offset * 8 - count);
+	if (err)
+		return err;
 
 	/* Bitstream parameters. */
 
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
index a6470a89851e..e9ceca332062 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
@@ -168,11 +168,16 @@ void cedrus_watchdog(struct work_struct *work)
 					 VB2_BUF_STATE_ERROR);
 }
 
+void cedrus_hw_reset(struct cedrus_dev *dev)
+{
+	reset_control_reset(dev->rstc);
+}
+
 int cedrus_hw_suspend(struct device *device)
 {
 	struct cedrus_dev *dev = dev_get_drvdata(device);
 
-	reset_control_assert(dev->rstc);
+	cedrus_hw_reset(dev);
 
 	clk_disable_unprepare(dev->ram_clk);
 	clk_disable_unprepare(dev->mod_clk);
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.h b/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
index 7c92f00e36da..919c4475f0d7 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
@@ -30,4 +30,6 @@ void cedrus_hw_remove(struct cedrus_dev *dev);
 
 void cedrus_watchdog(struct work_struct *work);
 
+void cedrus_hw_reset(struct cedrus_dev *dev);
+
 #endif
-- 
2.37.3

