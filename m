Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2963B6553F4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 20:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiLWTjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 14:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiLWTiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 14:38:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFEB21279;
        Fri, 23 Dec 2022 11:38:53 -0800 (PST)
Received: from whitebuilder.lan (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E6C796602CE5;
        Fri, 23 Dec 2022 19:38:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671824332;
        bh=fXOPvXl0JOMyURiqQQPd1PF09aMzIcFs5inRLfk9f9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GWTCg0alf1806OLDZ4WCJibqI95k1TsKq7o1DNvW6mPCYpqhIlu8RIoxRs9XR9f+C
         OHsHYF+DuO1oNWGBXL2XM3Xmqxai93VGFR63li+19GVTo1S3oLYHKy6duWJ0cmLct0
         bNaI/Mw81qug8iC765jeLYwfd1hMFYt5Kx80l/dZpgpA7Wbg5dDeucKaVKVDKz58CM
         i/olo3EGP90W3KC+j+5UCea8vuF2xy9ubRN0Fq0w/10Tw3gO5d26ktS8DHueVG9AW6
         7cH0K7jZnjyR2Hky7fnnwEWux2WpxFZC/AgakvUunSvjMrYP8tvRoEzjtygLHf9ZGN
         KJFS5wOhCEESw==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] rkvdec: Improve error handling
Date:   Fri, 23 Dec 2022 14:38:06 -0500
Message-Id: <20221223193807.914935-5-nicolas.dufresne@collabora.com>
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

There are two ways decoding errors can occure. In one case, the ready
status is not set and nothing has been written into the destination,
while in the other case, the buffer is written but may contain a
certain amount of errors. In order to differentiate these, we set
the payload for the first case to 0.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/staging/media/rkvdec/rkvdec.c | 31 +++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 7e76f8b728854..11e2bbb20aea1 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -27,6 +27,9 @@
 #include "rkvdec.h"
 #include "rkvdec-regs.h"
 
+static int debug;
+module_param(debug, int, 0644);
+
 static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct rkvdec_ctx *ctx = container_of(ctrl->handler, struct rkvdec_ctx, ctrl_hdl);
@@ -954,14 +957,34 @@ static irqreturn_t rkvdec_irq_handler(int irq, void *priv)
 	enum vb2_buffer_state state;
 	u32 status;
 
+	ctx = v4l2_m2m_get_curr_priv(rkvdec->m2m_dev);
 	status = readl(rkvdec->regs + RKVDEC_REG_INTERRUPT);
-	state = (status & RKVDEC_RDY_STA) ?
-		VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
+
+	if (!(status & RKVDEC_RDY_STA)) {
+		struct vb2_v4l2_buffer *dst_buf = NULL;
+
+		if (status & RKVDEC_TIMEOUT_STA)
+			v4l2_dbg(debug, 1, &rkvdec->v4l2_dev,
+				 "Decoder stopped due to an internal timeout.");
+		else
+			v4l2_dbg(debug, 1, &rkvdec->v4l2_dev,
+				 "Decoder stopped due to an internal error.");
+
+		/*
+		 * When this happens, the buffer is left unmodified. As it
+		 * contains no meaningful data we mark is as empty.
+		 */
+		dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
+		vb2_set_plane_payload(&dst_buf->vb2_buf, 0, 0);
+		state = VB2_BUF_STATE_ERROR;
+	} else {
+		state = VB2_BUF_STATE_DONE;
+	}
 
 	writel(0, rkvdec->regs + RKVDEC_REG_INTERRUPT);
-	ctx = v4l2_m2m_get_curr_priv(rkvdec->m2m_dev);
 
-	if (ctx->coded_fmt_desc->ops->check_error_info)
+	if (ctx->coded_fmt_desc->ops->check_error_info &&
+	    state == VB2_BUF_STATE_DONE)
 		state = ctx->coded_fmt_desc->ops->check_error_info(ctx);
 
 	if (cancel_delayed_work(&rkvdec->watchdog_work))
-- 
2.38.1

