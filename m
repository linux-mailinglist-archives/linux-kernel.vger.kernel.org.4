Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86FF6C0AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjCTG6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCTG6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:58:06 -0400
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9086117CC2;
        Sun, 19 Mar 2023 23:58:04 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 978F11A00A28;
        Mon, 20 Mar 2023 14:58:06 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FBlHBdSlUVbI; Mon, 20 Mar 2023 14:58:05 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 62FD51A00931;
        Mon, 20 Mar 2023 14:58:05 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] media: au0828: remove unnecessary (void*) conversions
Date:   Mon, 20 Mar 2023 14:57:14 +0800
Message-Id: <20230320065714.15965-1-yuzhe@nfschina.com>
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
 drivers/media/usb/au0828/au0828-core.c | 2 +-
 drivers/media/usb/au0828/au0828-dvb.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/au0828/au0828-core.c b/drivers/media/usb/au0828/au0828-core.c
index 877e85a451cb..400cf9bd26b9 100644
--- a/drivers/media/usb/au0828/au0828-core.c
+++ b/drivers/media/usb/au0828/au0828-core.c
@@ -211,7 +211,7 @@ static int au0828_media_device_init(struct au0828_dev *dev,
 static void au0828_media_graph_notify(struct media_entity *new,
 				      void *notify_data)
 {
-	struct au0828_dev *dev = (struct au0828_dev *) notify_data;
+	struct au0828_dev *dev = notify_data;
 	int ret;
 	struct media_entity *entity, *mixer = NULL, *decoder = NULL;
 
diff --git a/drivers/media/usb/au0828/au0828-dvb.c b/drivers/media/usb/au0828/au0828-dvb.c
index 2a8691a0d7fa..09f9948c6f8e 100644
--- a/drivers/media/usb/au0828/au0828-dvb.c
+++ b/drivers/media/usb/au0828/au0828-dvb.c
@@ -273,7 +273,7 @@ static void au0828_stop_transport(struct au0828_dev *dev, int full_stop)
 static int au0828_dvb_start_feed(struct dvb_demux_feed *feed)
 {
 	struct dvb_demux *demux = feed->demux;
-	struct au0828_dev *dev = (struct au0828_dev *) demux->priv;
+	struct au0828_dev *dev = demux->priv;
 	struct au0828_dvb *dvb = &dev->dvb;
 	int ret = 0;
 
@@ -305,7 +305,7 @@ static int au0828_dvb_start_feed(struct dvb_demux_feed *feed)
 static int au0828_dvb_stop_feed(struct dvb_demux_feed *feed)
 {
 	struct dvb_demux *demux = feed->demux;
-	struct au0828_dev *dev = (struct au0828_dev *) demux->priv;
+	struct au0828_dev *dev = demux->priv;
 	struct au0828_dvb *dvb = &dev->dvb;
 	int ret = 0;
 
-- 
2.11.0

