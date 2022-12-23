Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1E26553F5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 20:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiLWTjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 14:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiLWTiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 14:38:54 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DE421815;
        Fri, 23 Dec 2022 11:38:51 -0800 (PST)
Received: from whitebuilder.lan (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C02906602CDF;
        Fri, 23 Dec 2022 19:38:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671824329;
        bh=TUAr5G3EJwUIxmCfLgOCFNIvuOyhhl3yWtc6GNPry2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lvcIaKKR/tt7H4Ib7/Uo1TNLUWO/jCNSbZeEk3Vxoh2bBTJl8KGOwpmtZAcWzHOkX
         jW3Y+vGfSvNWfEr0kBiqF4W34+dDF5PgjHg6zrECJY+toAXdQXUK8U+vWH59Jh5t4m
         pwNWuQ6GS7XdBo6TLwZYVlzRm5GyIcOpjQ3aYcBL9XgQ1UNq7ejSG9AILoyc3BsU+4
         /JsdhbpP9xTC5b61WCfANZC7pu8T2c8ZRjOHFdpbGu4hGm7Y0RMD4u2bkveZlUpQAj
         7Q41Nw1Lpy9XaG5cLF9G6wJ/5r3xfY2i/fofZkIn94/w3O8yI1JYBDkpfSIVqUfwZ8
         EaVTmMHPYNn/w==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] media: rkvdec: Re-enable H.264 error detection
Date:   Fri, 23 Dec 2022 14:38:05 -0500
Message-Id: <20221223193807.914935-4-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221223193807.914935-1-nicolas.dufresne@collabora.com>
References: <20221223193807.914935-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This re-enable H.264 error detection, but using the other error mode.
In that mode, the decoder will skip over the error macro-block or
slices and complete the decoding. As a side effect, the error status
is not set in the interrupt status register, and instead errors are
detected per format. Using this mode workaround the issue that the
HW get stuck in error state, and allow reporting that some corruption
may be present in the buffer to userland.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/staging/media/rkvdec/rkvdec-h264.c | 23 +++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
index 4fc167b42cf0c..dfe3e235f099a 100644
--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
@@ -1162,14 +1162,15 @@ static int rkvdec_h264_run(struct rkvdec_ctx *ctx)
 
 	schedule_delayed_work(&rkvdec->watchdog_work, msecs_to_jiffies(2000));
 
-	writel(0, rkvdec->regs + RKVDEC_REG_STRMD_ERR_EN);
-	writel(0, rkvdec->regs + RKVDEC_REG_H264_ERR_E);
+	writel(0xffffffff, rkvdec->regs + RKVDEC_REG_STRMD_ERR_EN);
+	writel(0xffffffff, rkvdec->regs + RKVDEC_REG_H264_ERR_E);
 	writel(1, rkvdec->regs + RKVDEC_REG_PREF_LUMA_CACHE_COMMAND);
 	writel(1, rkvdec->regs + RKVDEC_REG_PREF_CHR_CACHE_COMMAND);
 
 	/* Start decoding! */
 	writel(RKVDEC_INTERRUPT_DEC_E | RKVDEC_CONFIG_DEC_CLK_GATE_E |
-	       RKVDEC_TIMEOUT_E | RKVDEC_BUF_EMPTY_E,
+	       RKVDEC_TIMEOUT_E | RKVDEC_BUF_EMPTY_E |
+	       RKVDEC_H264ORVP9_ERR_MODE,
 	       rkvdec->regs + RKVDEC_REG_INTERRUPT);
 
 	return 0;
@@ -1183,10 +1184,26 @@ static int rkvdec_h264_try_ctrl(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl)
 	return 0;
 }
 
+static int rkvdec_h264_check_error_info(struct rkvdec_ctx *ctx)
+{
+	struct rkvdec_dev *rkvdec = ctx->dev;
+	int err;
+
+	err = readl(rkvdec->regs + RKVDEC_REG_H264_ERRINFO_NUM);
+	if (err & RKVDEC_STRMD_DECT_ERR_FLAG) {
+		pr_debug("Decoded picture have %i/%i slices with errors.\n",
+			 RKVDEC_ERR_PKT_NUM(err), RKVDEC_SLICEDEC_NUM(err));
+		return VB2_BUF_STATE_ERROR;
+	}
+
+	return VB2_BUF_STATE_DONE;
+}
+
 const struct rkvdec_coded_fmt_ops rkvdec_h264_fmt_ops = {
 	.adjust_fmt = rkvdec_h264_adjust_fmt,
 	.start = rkvdec_h264_start,
 	.stop = rkvdec_h264_stop,
 	.run = rkvdec_h264_run,
 	.try_ctrl = rkvdec_h264_try_ctrl,
+	.check_error_info = rkvdec_h264_check_error_info,
 };
-- 
2.38.1

