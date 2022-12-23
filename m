Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883C06553EE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 20:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbiLWTin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 14:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiLWTil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 14:38:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD311FFA8;
        Fri, 23 Dec 2022 11:38:40 -0800 (PST)
Received: from whitebuilder.lan (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8DACE6602CDF;
        Fri, 23 Dec 2022 19:38:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671824318;
        bh=6GcOabw66VsX84Z/gphQUubf54+X891g3yoPH/UbEEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IS+eubJThqDCFvet2vxtMhCIIxaTBSisgP3jlJXdfRMboqhzqtAohn3eTY/kHiCGv
         bhOJc4Q9Mri0cG+gD/pNOY4Ux/uPOz1igJVblO7qQaTrE13MgZsKHWpivf72sL9JxL
         xXPB9WMSKho3xdK1mYz80zTPVEy1VQFrCt8cn5Vy8/a0MPZ6kgd7M1aqoEAmLlHwjW
         4w3r5YbiGgUg65S5lFT7bLJ9XYo9L7F4f+QYPiQ084zj3vbazndqxWfsiWmXQs+sfA
         ZDzp7FvKvvR0tKNEv5y1m6DEt24Hxrv5VLTq9injYmS+qg6+orM/d//pwNy8lZsU3G
         rqawE9lwSJHKA==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] media: rkvdec: Add an ops to check for decode errors
Date:   Fri, 23 Dec 2022 14:38:03 -0500
Message-Id: <20221223193807.914935-2-nicolas.dufresne@collabora.com>
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

This optional internal ops allow each codec to do their own
error status checking. The presence of an error is reported
using the ERROR buffer state. This patch have no functional
changes.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/staging/media/rkvdec/rkvdec.c | 10 ++++++----
 drivers/staging/media/rkvdec/rkvdec.h |  2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 7bab7586918c1..7e76f8b728854 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -950,6 +950,7 @@ static void rkvdec_v4l2_cleanup(struct rkvdec_dev *rkvdec)
 static irqreturn_t rkvdec_irq_handler(int irq, void *priv)
 {
 	struct rkvdec_dev *rkvdec = priv;
+	struct rkvdec_ctx *ctx;
 	enum vb2_buffer_state state;
 	u32 status;
 
@@ -958,12 +959,13 @@ static irqreturn_t rkvdec_irq_handler(int irq, void *priv)
 		VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
 
 	writel(0, rkvdec->regs + RKVDEC_REG_INTERRUPT);
-	if (cancel_delayed_work(&rkvdec->watchdog_work)) {
-		struct rkvdec_ctx *ctx;
+	ctx = v4l2_m2m_get_curr_priv(rkvdec->m2m_dev);
 
-		ctx = v4l2_m2m_get_curr_priv(rkvdec->m2m_dev);
+	if (ctx->coded_fmt_desc->ops->check_error_info)
+		state = ctx->coded_fmt_desc->ops->check_error_info(ctx);
+
+	if (cancel_delayed_work(&rkvdec->watchdog_work))
 		rkvdec_job_finish(ctx, state);
-	}
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
index 633335ebb9c49..4ae8e6c6b03c9 100644
--- a/drivers/staging/media/rkvdec/rkvdec.h
+++ b/drivers/staging/media/rkvdec/rkvdec.h
@@ -73,6 +73,8 @@ struct rkvdec_coded_fmt_ops {
 		     struct vb2_v4l2_buffer *dst_buf,
 		     enum vb2_buffer_state result);
 	int (*try_ctrl)(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl);
+	/* called from IRQ handler */
+	int (*check_error_info)(struct rkvdec_ctx *ctx);
 };
 
 struct rkvdec_coded_fmt_desc {
-- 
2.38.1

