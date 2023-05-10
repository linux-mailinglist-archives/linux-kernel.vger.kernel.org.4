Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF9F6FD38D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 03:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbjEJB37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 21:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjEJB35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 21:29:57 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 04ED03AAF;
        Tue,  9 May 2023 18:29:52 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 7BE33180081FD7;
        Wed, 10 May 2023 09:29:49 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Su Hui <suhui@nfschina.com>
Subject: [PATCH] media: platform: Remove unnecessary (void*) conversions
Date:   Wed, 10 May 2023 09:29:44 +0800
Message-Id: <20230510012944.42240-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need cast (void*) to (struct stdemux *),(struct hva_h264_ctx *)
or (struct hva_h264_task *).

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c | 4 ++--
 drivers/media/platform/st/sti/hva/hva-h264.c             | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
index 45ade7210d26..120830973d22 100644
--- a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
@@ -135,7 +135,7 @@ static void channel_swdemux_tsklet(struct tasklet_struct *t)
 static int c8sectpfe_start_feed(struct dvb_demux_feed *dvbdmxfeed)
 {
 	struct dvb_demux *demux = dvbdmxfeed->demux;
-	struct stdemux *stdemux = (struct stdemux *)demux->priv;
+	struct stdemux *stdemux = demux->priv;
 	struct c8sectpfei *fei = stdemux->c8sectpfei;
 	struct channel_info *channel;
 	u32 tmp;
@@ -256,7 +256,7 @@ static int c8sectpfe_stop_feed(struct dvb_demux_feed *dvbdmxfeed)
 {
 
 	struct dvb_demux *demux = dvbdmxfeed->demux;
-	struct stdemux *stdemux = (struct stdemux *)demux->priv;
+	struct stdemux *stdemux = demux->priv;
 	struct c8sectpfei *fei = stdemux->c8sectpfei;
 	struct channel_info *channel;
 	int idlereq;
diff --git a/drivers/media/platform/st/sti/hva/hva-h264.c b/drivers/media/platform/st/sti/hva/hva-h264.c
index 98cb00d2d868..196e631fa4b8 100644
--- a/drivers/media/platform/st/sti/hva/hva-h264.c
+++ b/drivers/media/platform/st/sti/hva/hva-h264.c
@@ -591,7 +591,7 @@ static int hva_h264_prepare_task(struct hva_ctx *pctx,
 {
 	struct hva_dev *hva = ctx_to_hdev(pctx);
 	struct device *dev = ctx_to_dev(pctx);
-	struct hva_h264_ctx *ctx = (struct hva_h264_ctx *)pctx->priv;
+	struct hva_h264_ctx *ctx = pctx->priv;
 	struct hva_buffer *seq_info = ctx->seq_info;
 	struct hva_buffer *fwd_ref_frame = ctx->ref_frame;
 	struct hva_buffer *loc_rec_frame = ctx->rec_frame;
@@ -984,7 +984,7 @@ static int hva_h264_open(struct hva_ctx *pctx)
 
 static int hva_h264_close(struct hva_ctx *pctx)
 {
-	struct hva_h264_ctx *ctx = (struct hva_h264_ctx *)pctx->priv;
+	struct hva_h264_ctx *ctx = pctx->priv;
 	struct device *dev = ctx_to_dev(pctx);
 
 	if (ctx->seq_info)
@@ -1007,8 +1007,8 @@ static int hva_h264_close(struct hva_ctx *pctx)
 static int hva_h264_encode(struct hva_ctx *pctx, struct hva_frame *frame,
 			   struct hva_stream *stream)
 {
-	struct hva_h264_ctx *ctx = (struct hva_h264_ctx *)pctx->priv;
-	struct hva_h264_task *task = (struct hva_h264_task *)ctx->task->vaddr;
+	struct hva_h264_ctx *ctx = pctx->priv;
+	struct hva_h264_task *task = ctx->task->vaddr;
 	u32 stuffing_bytes = 0;
 	int ret = 0;
 
-- 
2.30.2

