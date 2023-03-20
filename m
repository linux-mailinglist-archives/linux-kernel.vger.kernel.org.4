Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8066C0C71
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjCTIqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjCTIqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:46:08 -0400
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19E720D1E;
        Mon, 20 Mar 2023 01:45:52 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 7769E1A00A34;
        Mon, 20 Mar 2023 16:45:54 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6jm06hZJpQeJ; Mon, 20 Mar 2023 16:45:53 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 517EC1A0091B;
        Mon, 20 Mar 2023 16:45:53 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     awalls@md.metrocast.net, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] media: cx18: remove unnecessary (void*) conversions
Date:   Mon, 20 Mar 2023 16:45:02 +0800
Message-Id: <20230320084502.29478-1-yuzhe@nfschina.com>
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
 drivers/media/pci/cx18/cx18-dvb.c  | 4 ++--
 drivers/media/pci/cx18/cx18-gpio.c | 2 +-
 drivers/media/pci/cx18/cx18-irq.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/pci/cx18/cx18-dvb.c b/drivers/media/pci/cx18/cx18-dvb.c
index 33e5a5b5fab4..cf82360a503d 100644
--- a/drivers/media/pci/cx18/cx18-dvb.c
+++ b/drivers/media/pci/cx18/cx18-dvb.c
@@ -234,7 +234,7 @@ static int dvb_register(struct cx18_stream *stream);
 static int cx18_dvb_start_feed(struct dvb_demux_feed *feed)
 {
 	struct dvb_demux *demux = feed->demux;
-	struct cx18_stream *stream = (struct cx18_stream *) demux->priv;
+	struct cx18_stream *stream = demux->priv;
 	struct cx18 *cx;
 	int ret;
 	u32 v;
@@ -305,7 +305,7 @@ static int cx18_dvb_start_feed(struct dvb_demux_feed *feed)
 static int cx18_dvb_stop_feed(struct dvb_demux_feed *feed)
 {
 	struct dvb_demux *demux = feed->demux;
-	struct cx18_stream *stream = (struct cx18_stream *)demux->priv;
+	struct cx18_stream *stream = demux->priv;
 	struct cx18 *cx;
 	int ret = -EINVAL;
 
diff --git a/drivers/media/pci/cx18/cx18-gpio.c b/drivers/media/pci/cx18/cx18-gpio.c
index 160c8377e352..c85eb8d25837 100644
--- a/drivers/media/pci/cx18/cx18-gpio.c
+++ b/drivers/media/pci/cx18/cx18-gpio.c
@@ -307,7 +307,7 @@ int cx18_gpio_register(struct cx18 *cx, u32 hw)
 
 void cx18_reset_ir_gpio(void *data)
 {
-	struct cx18 *cx = to_cx18((struct v4l2_device *)data);
+	struct cx18 *cx = to_cx18(data);
 
 	if (cx->card->gpio_i2c_slave_reset.ir_reset_mask == 0)
 		return;
diff --git a/drivers/media/pci/cx18/cx18-irq.c b/drivers/media/pci/cx18/cx18-irq.c
index fb10e9c2c5b8..db63077821b1 100644
--- a/drivers/media/pci/cx18/cx18-irq.c
+++ b/drivers/media/pci/cx18/cx18-irq.c
@@ -30,7 +30,7 @@ static void epu_cmd(struct cx18 *cx, u32 sw1)
 
 irqreturn_t cx18_irq_handler(int irq, void *dev_id)
 {
-	struct cx18 *cx = (struct cx18 *)dev_id;
+	struct cx18 *cx = dev_id;
 	u32 sw1, sw2, hw2;
 
 	sw1 = cx18_read_reg(cx, SW1_INT_STATUS) & cx->sw1_irq_mask;
-- 
2.11.0

