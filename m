Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759BD619095
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 06:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiKDF5c convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Nov 2022 01:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiKDF5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 01:57:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B007229340;
        Thu,  3 Nov 2022 22:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E326B82C0C;
        Fri,  4 Nov 2022 05:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5E4C433C1;
        Fri,  4 Nov 2022 05:57:11 +0000 (UTC)
Date:   Fri, 4 Nov 2022 01:57:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Walls <awalls@md.metrocast.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mike Isely <isely@pobox.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Corey Minyard <cminyard@mvista.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [RFC][PATCH v3 18/33] timers: media: Use timer_shutdown_sync()
 before freeing timer
Message-ID: <20221104015709.35d73bc6@rorschach.local.home>
In-Reply-To: <20221104054915.190085802@goodmis.org>
References: <20221104054053.431922658@goodmis.org>
        <20221104054915.190085802@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Once again, quilt fails the MIME coding ]

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Before a timer is freed, timer_shutdown_sync() must be called.

Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/

Cc: Andy Walls <awalls@md.metrocast.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mike Isely <isely@pobox.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Benjamin Mugnier <benjamin.mugnier@foss.st.com>
Cc: Vladimir Oltean <olteanv@gmail.com>
Cc: Corey Minyard <cminyard@mvista.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: linux-media@vger.kernel.org
Cc: linux-staging@lists.linux.dev
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/media/pci/ivtv/ivtv-driver.c           |  2 +-
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c        | 18 +++++++++---------
 drivers/media/usb/s2255/s2255drv.c             |  4 ++--
 .../staging/media/atomisp/i2c/atomisp-lm3554.c |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/media/pci/ivtv/ivtv-driver.c b/drivers/media/pci/ivtv/ivtv-driver.c
index f5846c22c799..ba503d820e48 100644
--- a/drivers/media/pci/ivtv/ivtv-driver.c
+++ b/drivers/media/pci/ivtv/ivtv-driver.c
@@ -1425,7 +1425,7 @@ static void ivtv_remove(struct pci_dev *pdev)
 
 	/* Interrupts */
 	ivtv_set_irq_mask(itv, 0xffffffff);
-	del_timer_sync(&itv->dma_timer);
+	timer_shutdown_sync(&itv->dma_timer);
 
 	/* Kill irq worker */
 	kthread_flush_worker(&itv->irq_worker);
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
index 62ff1fa1c753..db000c9145d7 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
@@ -2605,10 +2605,10 @@ struct pvr2_hdw *pvr2_hdw_create(struct usb_interface *intf,
 	return hdw;
  fail:
 	if (hdw) {
-		del_timer_sync(&hdw->quiescent_timer);
-		del_timer_sync(&hdw->decoder_stabilization_timer);
-		del_timer_sync(&hdw->encoder_run_timer);
-		del_timer_sync(&hdw->encoder_wait_timer);
+		timer_shutdown_sync(&hdw->quiescent_timer);
+		timer_shutdown_sync(&hdw->decoder_stabilization_timer);
+		timer_shutdown_sync(&hdw->encoder_run_timer);
+		timer_shutdown_sync(&hdw->encoder_wait_timer);
 		flush_work(&hdw->workpoll);
 		v4l2_device_unregister(&hdw->v4l2_dev);
 		usb_free_urb(hdw->ctl_read_urb);
@@ -2668,10 +2668,10 @@ void pvr2_hdw_destroy(struct pvr2_hdw *hdw)
 	if (!hdw) return;
 	pvr2_trace(PVR2_TRACE_INIT,"pvr2_hdw_destroy: hdw=%p",hdw);
 	flush_work(&hdw->workpoll);
-	del_timer_sync(&hdw->quiescent_timer);
-	del_timer_sync(&hdw->decoder_stabilization_timer);
-	del_timer_sync(&hdw->encoder_run_timer);
-	del_timer_sync(&hdw->encoder_wait_timer);
+	timer_shutdown_sync(&hdw->quiescent_timer);
+	timer_shutdown_sync(&hdw->decoder_stabilization_timer);
+	timer_shutdown_sync(&hdw->encoder_run_timer);
+	timer_shutdown_sync(&hdw->encoder_wait_timer);
 	if (hdw->fw_buffer) {
 		kfree(hdw->fw_buffer);
 		hdw->fw_buffer = NULL;
@@ -3722,7 +3722,7 @@ status);
 	hdw->cmd_debug_state = 5;
 
 	/* Stop timer */
-	del_timer_sync(&timer.timer);
+	timer_shutdown_sync(&timer.timer);
 
 	hdw->cmd_debug_state = 6;
 	status = 0;
diff --git a/drivers/media/usb/s2255/s2255drv.c b/drivers/media/usb/s2255/s2255drv.c
index acf18e2251a5..3c2627712fe9 100644
--- a/drivers/media/usb/s2255/s2255drv.c
+++ b/drivers/media/usb/s2255/s2255drv.c
@@ -1487,7 +1487,7 @@ static void s2255_destroy(struct s2255_dev *dev)
 	/* board shutdown stops the read pipe if it is running */
 	s2255_board_shutdown(dev);
 	/* make sure firmware still not trying to load */
-	del_timer_sync(&dev->timer);  /* only started in .probe and .open */
+	timer_shutdown_sync(&dev->timer);  /* only started in .probe and .open */
 	if (dev->fw_data->fw_urb) {
 		usb_kill_urb(dev->fw_data->fw_urb);
 		usb_free_urb(dev->fw_data->fw_urb);
@@ -2322,7 +2322,7 @@ static int s2255_probe(struct usb_interface *interface,
 errorFWDATA2:
 	usb_free_urb(dev->fw_data->fw_urb);
 errorFWURB:
-	del_timer_sync(&dev->timer);
+	timer_shutdown_sync(&dev->timer);
 errorEP:
 	usb_put_dev(dev->udev);
 errorUDEV:
diff --git a/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c b/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
index 75d16b525294..c4ce4cd445d7 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
@@ -921,7 +921,7 @@ static void lm3554_remove(struct i2c_client *client)
 
 	atomisp_gmin_remove_subdev(sd);
 
-	del_timer_sync(&flash->flash_off_delay);
+	timer_shutdown_sync(&flash->flash_off_delay);
 
 	lm3554_gpio_uninit(client);
 
-- 
2.35.1
