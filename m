Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6C06C0B1C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 08:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCTHJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 03:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCTHJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 03:09:20 -0400
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5916F903A;
        Mon, 20 Mar 2023 00:09:18 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 057DF1A009F5;
        Mon, 20 Mar 2023 15:09:20 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5rRpAstuwPnR; Mon, 20 Mar 2023 15:09:19 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id B303B1A0091A;
        Mon, 20 Mar 2023 15:09:18 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     patrice.chotard@foss.st.com, mchehab@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com, Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] media: c8sectpfe: dvb: remove unnecessary (void*) conversions
Date:   Mon, 20 Mar 2023 15:08:28 +0800
Message-Id: <20230320070828.13322-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_VALIDITY_RPBL,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer variables of void * type do not require type cast.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
index c38b62d4f1ae..d238f6478fc9 100644
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
-- 
2.11.0

