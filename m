Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AE35BC1EB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 06:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiISEFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 00:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiISEFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 00:05:04 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD39EA47A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 21:05:02 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id l65so26864793pfl.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 21:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=wS7FY05WnSmgncPj+QheiVtL/lUxhXoEZ+jgSf6VB18=;
        b=Q4U8QDybtwrY/eL0H3DT17Vn1J9pL+s2KRxrPz3wdNERIWWw0F/Pyqr1aEQJkufQAg
         2Ao+olIwmZtzN/Z3YCZFY6VBwYolhSKSk2t1fKw2YkeLYCCbdc2p69brFFIUpn68L4zp
         iysCZmydU4u4/RACBmOLUM2Hxi95Jh3PKiMbfsNquorBw6X6AdAuhFezVx3C+PW26/T8
         xwv4WuFgjilSR3aHkcSujUemFZPo3NKtCA1Rf+ApT4hFjB2WfiZojfsHrdOHvGj/FTPP
         tmjla4su0BN2oWHLbJ1HI5FHG+eHLPlXPioqKIoUXT2iPB93certnxK2EZlK8xFa/9VP
         ovnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wS7FY05WnSmgncPj+QheiVtL/lUxhXoEZ+jgSf6VB18=;
        b=AHF5REASuzCX5QT48L/uBopkPoSxgTJIr2xN+kk2nnDI0YE2C5Yhh7OvQIQTblrkff
         ADjN0bx1FCG4lTy7Uul3s5Gg2DCyreIC7CWjiKaEB03eNHDxr6FSWjnWN9XsaIy2Ktmn
         Vo3M7MPJV6zMIo7Wrjw5jz/knPH6ke86Oxp5ax23Jpukrx0mHAgLI4pDy/H2TRNkgUm2
         4IfbYC6Tm1hXKIu8W6MIemMoHVfd4khpBvmOjRnS0ZZh8BSqT0EodOlY86btOeVZOGno
         0nWQqUxvqMDECGjgs2UpmvyXO0luZcRXFEjWvquRphyiGq4yibHtYMwHZmrRLjG5YCa9
         HP+A==
X-Gm-Message-State: ACrzQf2bh8OzY2Srk/mc1jIap1dyriH4r8TFuBGC6HvkqV26IgdoF0t9
        kosrc/AP0xP4LVcARLVEH0Z1PA/3cKI=
X-Google-Smtp-Source: AMsMyM5fLlhe9ab5Xve4sM4KnmaJwsSV4qFZSlwXbvu8/hOoWVM4ZWwqEqUXDQStK0pcqRfIx52lMw==
X-Received: by 2002:a63:8942:0:b0:434:b525:a46d with SMTP id v63-20020a638942000000b00434b525a46dmr13903027pgd.167.1663560302329;
        Sun, 18 Sep 2022 21:05:02 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902e84300b001782a0d3eeasm16710357plg.115.2022.09.18.21.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 21:05:01 -0700 (PDT)
Date:   Sun, 18 Sep 2022 21:04:57 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     laforge@gnumonks.org
Cc:     linux-kernel@vger.kernel.org, imv4bel@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux@dominikbrodowski.net
Subject: [PATCH v3] char: pcmcia: cm4040_cs: Fix use-after-free in reader_fops
Message-ID: <20220919040457.GA302681@ubuntu>
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
 drivers/char/pcmcia/cm4040_cs.c | 50 +++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/char/pcmcia/cm4040_cs.c b/drivers/char/pcmcia/cm4040_cs.c
index 827711911da4..bb9116d81890 100644
--- a/drivers/char/pcmcia/cm4040_cs.c
+++ b/drivers/char/pcmcia/cm4040_cs.c
@@ -59,6 +59,7 @@ static DEFINE_MUTEX(cm4040_mutex);
 /* how often to poll for fifo status change */
 #define POLL_PERIOD 				msecs_to_jiffies(10)
 
+static void cm4040_delete(struct kref *kref);
 static void reader_release(struct pcmcia_device *link);
 
 static int major;
@@ -73,6 +74,7 @@ struct reader_dev {
 	wait_queue_head_t	poll_wait;
 	wait_queue_head_t	read_wait;
 	wait_queue_head_t	write_wait;
+	struct kref		refcnt;
 	unsigned long 	  	buffer_status;
 	unsigned long     	timeout;
 	unsigned char     	s_buf[READ_WRITE_BUFFER_SIZE];
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
@@ -442,6 +466,7 @@ static int cm4040_open(struct inode *inode, struct file *filp)
 		return -ENODEV;
 
 	mutex_lock(&cm4040_mutex);
+
 	link = dev_table[minor];
 	if (link == NULL || !pcmcia_dev_present(link)) {
 		ret = -ENODEV;
@@ -468,8 +493,11 @@ static int cm4040_open(struct inode *inode, struct file *filp)
 
 	DEBUGP(2, dev, "<- cm4040_open (successfully)\n");
 	ret = nonseekable_open(inode, filp);
+
+	kref_get(&dev->refcnt);
 out:
 	mutex_unlock(&cm4040_mutex);
+
 	return ret;
 }
 
@@ -495,6 +523,9 @@ static int cm4040_close(struct inode *inode, struct file *filp)
 	wake_up(&dev->devq);
 
 	DEBUGP(2, dev, "<- cm4040_close\n");
+
+	kref_put(&dev->refcnt, cm4040_delete);
+
 	return 0;
 }
 
@@ -584,6 +615,7 @@ static int reader_probe(struct pcmcia_device *link)
 	init_waitqueue_head(&dev->read_wait);
 	init_waitqueue_head(&dev->write_wait);
 	timer_setup(&dev->poll_timer, cm4040_do_poll, 0);
+	kref_init(&dev->refcnt);
 
 	ret = reader_config(link, i);
 	if (ret) {
@@ -600,22 +632,10 @@ static int reader_probe(struct pcmcia_device *link)
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
-
-	dev_table[devno] = NULL;
-	kfree(dev);
 
-	device_destroy(cmx_class, MKDEV(major, devno));
+	mutex_lock(&cm4040_mutex);
+	kref_put(&dev->refcnt, cm4040_delete);
+	mutex_unlock(&cm4040_mutex);
 
 	return;
 }
-- 
2.25.1

Dear,


I fixed the wrong patch referencing "dev" after kref_put() in the previous version of the patch.


Regards,
Hyunwoo Kim.
