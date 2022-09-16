Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07975BA624
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 06:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiIPE6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 00:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiIPE6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 00:58:40 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28AB77550
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 21:58:39 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id x1so20376538plv.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 21:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=BDyqMgJ7ryK97NTKBZ4tJVeJrvGWSAevltczgh4BpZ0=;
        b=YSXyu0kLOmCtfxDz+pZkeUBTmY4o5iMik8FMxGy45JFCGRDGag0s/ccAtQ8O1GyKL3
         stFiy4R6XnqdfAckVzF98kiEeFdWEEs8kWiUDE1XyVb9MOoG8x00g4Ws06kW2BzGmQ9U
         OFo0w/sw+49DaspV0BV+Jz93DhEJkLvUygJYGYBTLymlWwAjQpjvilei862ftzwwqbFR
         ntBWQ4vQbe8T4ddObFV+AZi5VUYiWq8jAVb0/3HlT7HyiWYizTfaVtX0OXj180dGBBvx
         Copwv93TXEsg8FWKpYnuExBwhoaBlwrvausN6+9CZu3kvwR8uWY56q43UMHnsGZJvPMm
         Xmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=BDyqMgJ7ryK97NTKBZ4tJVeJrvGWSAevltczgh4BpZ0=;
        b=AwBAZb1tdssQXuHI79g8qewbPC2tSjcqzDCypaaYgZXaZ7lFd75RpvTAhq+il+p/2c
         M5PfgkAeuM+TEUMEJGfFWLOWu6jWpgu86G7l+MHUAOAk0frFbGBsGv7p0Dun2pVtQp3H
         5RlVdjPF8fM/nJTeDtauMNB0HuxGYMicm6X4EFj3K2IeNgT5oNweIfqR67TmiRCsLIAL
         JufFL0YPdzZtPkf4plElfWjoQMGnkpd5o1AELrE6PPfOeqEBrp/h9dMuLRZYncLEYiKG
         xu9/I9PeUC2e6jTkgF34LT7bpiC+l6TvW6BFtkx0Y5VG14o54jhVYlKnQeJi+0TNR3u6
         G+TQ==
X-Gm-Message-State: ACrzQf3z2CCVLQkXtL2DsLH/wiCECZgmbn0DMoAVovQpLuEp24NAHozX
        /A95J26jLEtQARZ/ZYYqSmo=
X-Google-Smtp-Source: AMsMyM5ocM0Vg9i08TKBQuuks0cH0roAbPYfqBIamTG3Fbpii7s/k+hOPe/zzglhxjbqP4Orek3BiA==
X-Received: by 2002:a17:902:d548:b0:178:41dd:899 with SMTP id z8-20020a170902d54800b0017841dd0899mr3030055plf.149.1663304319384;
        Thu, 15 Sep 2022 21:58:39 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902f68600b001635b86a790sm14072375plg.44.2022.09.15.21.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 21:58:39 -0700 (PDT)
Date:   Thu, 15 Sep 2022 21:58:34 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     laforge@gnumonks.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH] char: pcmcia: cm4040_cs: Fix use-after-free in reader_fops
Message-ID: <20220916045834.GA188033@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A race condition may occur if the user physically removes the pcmcia
device while calling open() for this char device node.

This is a race condition between the cm4040_open() function and the
reader_detach() function, which may eventually result in UAF.

So, add a refcount check to reader_detach() to free the "dev" structure
after the char device node is close()d.

Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 drivers/char/pcmcia/cm4040_cs.c | 88 ++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 39 deletions(-)

diff --git a/drivers/char/pcmcia/cm4040_cs.c b/drivers/char/pcmcia/cm4040_cs.c
index 827711911da4..4cc6df93be2c 100644
--- a/drivers/char/pcmcia/cm4040_cs.c
+++ b/drivers/char/pcmcia/cm4040_cs.c
@@ -59,6 +59,7 @@ static DEFINE_MUTEX(cm4040_mutex);
 /* how often to poll for fifo status change */
 #define POLL_PERIOD 				msecs_to_jiffies(10)
 
+static void cm4040_delete(struct kref *kref);
 static void reader_release(struct pcmcia_device *link);
 
 static int major;
@@ -69,15 +70,16 @@ static struct class *cmx_class;
 
 struct reader_dev {
 	struct pcmcia_device	*p_dev;
-	wait_queue_head_t	devq;
 	wait_queue_head_t	poll_wait;
 	wait_queue_head_t	read_wait;
 	wait_queue_head_t	write_wait;
+	struct kref		refcnt;
 	unsigned long 	  	buffer_status;
 	unsigned long     	timeout;
 	unsigned char     	s_buf[READ_WRITE_BUFFER_SIZE];
 	unsigned char     	r_buf[READ_WRITE_BUFFER_SIZE];
 	struct timer_list 	poll_timer;
+	struct mutex		lock;
 };
 
 static struct pcmcia_device *dev_table[CM_MAX_DEV];
@@ -102,6 +104,28 @@ static inline unsigned char xinb(unsigned short port)
 }
 #endif
 
+static void cm4040_delete(struct kref *kref)
+{
+	struct reader_dev *dev = container_of(kref, struct reader_dev, refcnt);
+	struct pcmcia_device *link = dev->p_dev;
+	int devno;
+
+	/* find device */
+	for (devno = 0; devno < CM_MAX_DEV; devno++) {
+		if (dev_table[devno] == link)
+			break;
+	}
+	if (devno == CM_MAX_DEV)
+		return;
+
+	reader_release(link);
+
+	dev_table[devno] = NULL;
+	kfree(dev);
+
+	device_destroy(cmx_class, MKDEV(major, devno));
+}
+
 /* poll the device fifo status register.  not to be confused with
  * the poll syscall. */
 static void cm4040_do_poll(struct timer_list *t)
@@ -442,24 +466,30 @@ static int cm4040_open(struct inode *inode, struct file *filp)
 		return -ENODEV;
 
 	mutex_lock(&cm4040_mutex);
+
 	link = dev_table[minor];
 	if (link == NULL || !pcmcia_dev_present(link)) {
-		ret = -ENODEV;
-		goto out;
+		mutex_unlock(&dev->lock);
+		mutex_unlock(&cm4040_mutex);
+		return -ENODEV;
 	}
 
 	if (link->open) {
-		ret = -EBUSY;
-		goto out;
+		mutex_unlock(&dev->lock);
+		mutex_unlock(&cm4040_mutex);
+		return -EBUSY;
 	}
 
 	dev = link->priv;
+	mutex_lock(&dev->lock);
+
 	filp->private_data = dev;
 
 	if (filp->f_flags & O_NONBLOCK) {
 		DEBUGP(4, dev, "filep->f_flags O_NONBLOCK set\n");
-		ret = -EAGAIN;
-		goto out;
+		mutex_unlock(&dev->lock);
+		mutex_unlock(&cm4040_mutex);
+		return -EAGAIN;
 	}
 
 	link->open = 1;
@@ -468,8 +498,12 @@ static int cm4040_open(struct inode *inode, struct file *filp)
 
 	DEBUGP(2, dev, "<- cm4040_open (successfully)\n");
 	ret = nonseekable_open(inode, filp);
-out:
+
+	kref_get(&dev->refcnt);
+
+	mutex_unlock(&dev->lock);
 	mutex_unlock(&cm4040_mutex);
+
 	return ret;
 }
 
@@ -492,24 +526,12 @@ static int cm4040_close(struct inode *inode, struct file *filp)
 	cm4040_stop_poll(dev);
 
 	link->open = 0;
-	wake_up(&dev->devq);
 
 	DEBUGP(2, dev, "<- cm4040_close\n");
-	return 0;
-}
 
-static void cm4040_reader_release(struct pcmcia_device *link)
-{
-	struct reader_dev *dev = link->priv;
+	kref_put(&dev->refcnt, cm4040_delete);
 
-	DEBUGP(3, dev, "-> cm4040_reader_release\n");
-	while (link->open) {
-		DEBUGP(3, dev, MODULE_NAME ": delaying release "
-		       "until process has terminated\n");
- 		wait_event(dev->devq, (link->open == 0));
-	}
-	DEBUGP(3, dev, "<- cm4040_reader_release\n");
-	return;
+	return 0;
 }
 
 static int cm4040_config_check(struct pcmcia_device *p_dev, void *priv_data)
@@ -550,7 +572,6 @@ static int reader_config(struct pcmcia_device *link, int devno)
 
 static void reader_release(struct pcmcia_device *link)
 {
-	cm4040_reader_release(link);
 	pcmcia_disable_device(link);
 }
 
@@ -579,11 +600,12 @@ static int reader_probe(struct pcmcia_device *link)
 
 	dev_table[i] = link;
 
-	init_waitqueue_head(&dev->devq);
 	init_waitqueue_head(&dev->poll_wait);
 	init_waitqueue_head(&dev->read_wait);
 	init_waitqueue_head(&dev->write_wait);
 	timer_setup(&dev->poll_timer, cm4040_do_poll, 0);
+	kref_init(&dev->refcnt);
+	mutex_init(&dev->lock);
 
 	ret = reader_config(link, i);
 	if (ret) {
@@ -600,22 +622,10 @@ static int reader_probe(struct pcmcia_device *link)
 static void reader_detach(struct pcmcia_device *link)
 {
 	struct reader_dev *dev = link->priv;
-	int devno;
-
-	/* find device */
-	for (devno = 0; devno < CM_MAX_DEV; devno++) {
-		if (dev_table[devno] == link)
-			break;
-	}
-	if (devno == CM_MAX_DEV)
-		return;
 
-	reader_release(link);
-
-	dev_table[devno] = NULL;
-	kfree(dev);
-
-	device_destroy(cmx_class, MKDEV(major, devno));
+	mutex_lock(&dev->lock);
+	kref_put(&dev->refcnt, cm4040_delete);
+	mutex_unlock(&dev->lock);
 
 	return;
 }
-- 
2.25.1

