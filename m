Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4EC6DA6BE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 02:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbjDGA7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 20:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjDGA7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 20:59:35 -0400
X-Greylist: delayed 207 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Apr 2023 17:59:33 PDT
Received: from mail.nfschina.com (unknown [42.101.60.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08062727;
        Thu,  6 Apr 2023 17:59:33 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 2B1261A00B0D;
        Fri,  7 Apr 2023 08:56:50 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cpzkFWlJUWFV; Fri,  7 Apr 2023 08:56:49 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 00F9E1A00886;
        Fri,  7 Apr 2023 08:56:48 +0800 (CST)
From:   Li Qiong <liqiong@nfschina.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Walls <awalls@md.metrocast.net>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li Qiong <liqiong@nfschina.com>
Subject: [PATCH] media: pci: remove unnecessary (void*) conversions
Date:   Fri,  7 Apr 2023 08:55:16 +0800
Message-Id: <20230407005516.13517-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=1.3 required=5.0 tests=RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to cast (void*) pointer to other type.

Signed-off-by: Li Qiong <liqiong@nfschina.com>
---
 drivers/media/pci/bt8xx/dst_ca.c        | 2 +-
 drivers/media/pci/cx18/cx18-dvb.c       | 4 ++--
 drivers/media/pci/saa7164/saa7164-dvb.c | 4 ++--
 drivers/media/pci/ttpci/budget-core.c   | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/pci/bt8xx/dst_ca.c b/drivers/media/pci/bt8xx/dst_ca.c
index 85fcdc59f0d1..d234a0f404d6 100644
--- a/drivers/media/pci/bt8xx/dst_ca.c
+++ b/drivers/media/pci/bt8xx/dst_ca.c
@@ -534,7 +534,7 @@ static long dst_ca_ioctl(struct file *file, unsigned int cmd, unsigned long ioct
 
 	mutex_lock(&dst_ca_mutex);
 	dvbdev = file->private_data;
-	state = (struct dst_state *)dvbdev->priv;
+	state = dvbdev->priv;
 	p_ca_message = kmalloc(sizeof (struct ca_msg), GFP_KERNEL);
 	p_ca_slot_info = kmalloc(sizeof (struct ca_slot_info), GFP_KERNEL);
 	p_ca_caps = kmalloc(sizeof (struct ca_caps), GFP_KERNEL);
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
 
diff --git a/drivers/media/pci/saa7164/saa7164-dvb.c b/drivers/media/pci/saa7164/saa7164-dvb.c
index 24421c116b0b..3eb749db1ca7 100644
--- a/drivers/media/pci/saa7164/saa7164-dvb.c
+++ b/drivers/media/pci/saa7164/saa7164-dvb.c
@@ -280,7 +280,7 @@ static int saa7164_dvb_start_port(struct saa7164_port *port)
 static int saa7164_dvb_start_feed(struct dvb_demux_feed *feed)
 {
 	struct dvb_demux *demux = feed->demux;
-	struct saa7164_port *port = (struct saa7164_port *) demux->priv;
+	struct saa7164_port *port = demux->priv;
 	struct saa7164_dvb *dvb = &port->dvb;
 	struct saa7164_dev *dev = port->dev;
 	int ret = 0;
@@ -307,7 +307,7 @@ static int saa7164_dvb_start_feed(struct dvb_demux_feed *feed)
 static int saa7164_dvb_stop_feed(struct dvb_demux_feed *feed)
 {
 	struct dvb_demux *demux = feed->demux;
-	struct saa7164_port *port = (struct saa7164_port *) demux->priv;
+	struct saa7164_port *port = demux->priv;
 	struct saa7164_dvb *dvb = &port->dvb;
 	struct saa7164_dev *dev = port->dev;
 	int ret = 0;
diff --git a/drivers/media/pci/ttpci/budget-core.c b/drivers/media/pci/ttpci/budget-core.c
index 5d5796f24469..710595987522 100644
--- a/drivers/media/pci/ttpci/budget-core.c
+++ b/drivers/media/pci/ttpci/budget-core.c
@@ -308,7 +308,7 @@ int ttpci_budget_debiwrite(struct budget *budget, u32 config, int addr,
 static int budget_start_feed(struct dvb_demux_feed *feed)
 {
 	struct dvb_demux *demux = feed->demux;
-	struct budget *budget = (struct budget *) demux->priv;
+	struct budget *budget = demux->priv;
 	int status = 0;
 
 	dprintk(2, "budget: %p\n", budget);
@@ -327,7 +327,7 @@ static int budget_start_feed(struct dvb_demux_feed *feed)
 static int budget_stop_feed(struct dvb_demux_feed *feed)
 {
 	struct dvb_demux *demux = feed->demux;
-	struct budget *budget = (struct budget *) demux->priv;
+	struct budget *budget = demux->priv;
 	int status = 0;
 
 	dprintk(2, "budget: %p\n", budget);
-- 
2.11.0

