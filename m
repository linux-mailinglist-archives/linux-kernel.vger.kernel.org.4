Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B474A5BAE85
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiIPNtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiIPNtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:49:12 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCC0AE224
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:49:10 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id e68so21322840pfe.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=2n8m9Yg3eXJzST89nwSJkSXaUJbY6Is/T+eVGx/bEtE=;
        b=InbrCZw7ADBRyLcE0w/hYkSGWrPQCgBuKuS6Ui1TVueMsiBUOcInyrNZ+OkGJDFP0q
         890sZa0ZP5QxB3rf+okJYjtedKY0jlvTBElLvfJhReTdieMe5XOMIcFf7jUFUDZNWHeV
         9rD8CH/Fz2q1bkbshTcYZKJUB/YYQ98i/Q3oXExZnZsGRwIr+7gQbRjWGvNWg+p4E1UW
         adCvKs3UDHSV8q379cstNllRXQbO6oOyWWrM3dmyDJJ1JUO31TW1Z+GZCW2hkEsigfxH
         9KHVDIIbhLIk3qz4dIBBWKFAwU3GZdgmv1g03oBqU14oj5cmiiZPWkarAMNecwJrrZmn
         Jn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2n8m9Yg3eXJzST89nwSJkSXaUJbY6Is/T+eVGx/bEtE=;
        b=OmOjTgCgAw/zfHJ/1ObVTr+n1EfmDWQL4jiZgSQTqq4xTJyZE/DTxAQr5/WFWjd1U2
         r+QiXuYpRKDyaf6fQOiLn+OekbKYMUgvyhBjLexgCb8gfwO1hoOpDKtgdMhRqUGQhaJr
         pXGH1Ppw7Eb+k0KiqTCrKBombd6YNL+xgdbQTvXTn7oCmelVrUDCPF6GUY8rkXwAnQuQ
         z6wnfvJh41aoqZIjkBOTdeBE5jdNM31fs0oVlbQ1Z4m0QwjtB+ElbsMRbWVCdqx8dZuh
         KPbgiAWhr3TwIOtVar8DYeeTds4K9LVyYC5/QhhOI77zSBv7DtTuhORfADF4pPxkPK4Y
         25Lg==
X-Gm-Message-State: ACrzQf3kqki78SCH7LqvlGBaOyYnL+LAsQha8PfF3I4MKounrxe0b8fw
        l8S1K7rDVXz7Xm9SQPLGeE0=
X-Google-Smtp-Source: AMsMyM4kQOow4P5R/R3e9OK5fwgiCEOH5qP1igo/T+sQUKNkyPxtdxAEfAegYwpnXc5loIxAX9KbEQ==
X-Received: by 2002:a05:6a00:f04:b0:547:50b1:4f4e with SMTP id cr4-20020a056a000f0400b0054750b14f4emr5540041pfb.69.1663336149593;
        Fri, 16 Sep 2022 06:49:09 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id x20-20020aa78f14000000b0052d2b55be32sm14926810pfr.171.2022.09.16.06.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 06:49:09 -0700 (PDT)
Date:   Fri, 16 Sep 2022 06:49:05 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     laforge@gnumonks.org
Cc:     linux-kernel@vger.kernel.org, imv4bel@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Subject: [PATCH v2] char: pcmcia: cm4040_cs: Fix use-after-free in reader_fops
Message-ID: <20220916134905.GA234760@ubuntu>
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
 drivers/char/pcmcia/cm4040_cs.c | 87 ++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 39 deletions(-)

diff --git a/drivers/char/pcmcia/cm4040_cs.c b/drivers/char/pcmcia/cm4040_cs.c
index 827711911da4..50df1e63580a 100644
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
+	int			removed;
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
+		mutex_unlock(&cm4040_mutex);
+		return -ENODEV;
 	}
 
 	if (link->open) {
-		ret = -EBUSY;
-		goto out;
+		mutex_unlock(&cm4040_mutex);
+		return -EBUSY;
 	}
 
 	dev = link->priv;
 	filp->private_data = dev;
 
+	if (dev->removed == 1) {
+		mutex_unlock(&cm4040_mutex);
+		return -ENODEV;
+	}
+
 	if (filp->f_flags & O_NONBLOCK) {
 		DEBUGP(4, dev, "filep->f_flags O_NONBLOCK set\n");
-		ret = -EAGAIN;
-		goto out;
+		mutex_unlock(&cm4040_mutex);
+		return -EAGAIN;
 	}
 
 	link->open = 1;
@@ -468,8 +498,11 @@ static int cm4040_open(struct inode *inode, struct file *filp)
 
 	DEBUGP(2, dev, "<- cm4040_open (successfully)\n");
 	ret = nonseekable_open(inode, filp);
-out:
+
+	kref_get(&dev->refcnt);
+
 	mutex_unlock(&cm4040_mutex);
+
 	return ret;
 }
 
@@ -492,24 +525,12 @@ static int cm4040_close(struct inode *inode, struct file *filp)
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
@@ -550,7 +571,6 @@ static int reader_config(struct pcmcia_device *link, int devno)
 
 static void reader_release(struct pcmcia_device *link)
 {
-	cm4040_reader_release(link);
 	pcmcia_disable_device(link);
 }
 
@@ -579,11 +599,11 @@ static int reader_probe(struct pcmcia_device *link)
 
 	dev_table[i] = link;
 
-	init_waitqueue_head(&dev->devq);
 	init_waitqueue_head(&dev->poll_wait);
 	init_waitqueue_head(&dev->read_wait);
 	init_waitqueue_head(&dev->write_wait);
 	timer_setup(&dev->poll_timer, cm4040_do_poll, 0);
+	kref_init(&dev->refcnt);
 
 	ret = reader_config(link, i);
 	if (ret) {
@@ -600,22 +620,11 @@ static int reader_probe(struct pcmcia_device *link)
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
-
-	reader_release(link);
 
-	dev_table[devno] = NULL;
-	kfree(dev);
-
-	device_destroy(cmx_class, MKDEV(major, devno));
+	mutex_lock(&cm4040_mutex);
+	kref_put(&dev->refcnt, cm4040_delete);
+	dev->removed = 1;
+	mutex_unlock(&cm4040_mutex);
 
 	return;
 }
-- 
2.25.1

