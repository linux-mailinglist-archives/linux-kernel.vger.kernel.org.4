Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F825BAE87
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiIPNuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiIPNuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:50:14 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7159A558C5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:50:08 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id l65so21293321pfl.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=mg2W9f9guObOQ3nCr3SRnmWfaXFbUbY8UMTcwJAN+3o=;
        b=e9oEDoBeKMaq5Xg9ri6m/f8YEXTD8oGbUcX3BbARWV9fdfK8nSDspeUsHvmMTyzSBx
         3miEyDBqdk8z1Ub4HvK484Bc3H3FSqoRXQhOSJ+fdcePlBi8UDWuO68AVTEkkp/hHitO
         ygiG+acNQ9mnqtwFnITS7ajc3LF6AWlWHf/e1lFh3jLVaUTs75XCiQrA7xo58J444M9I
         FwJTN6ny6onDgLtdlEcaNKMoJv2hR2JbOdTzRpmoIQEfzYfIwNTMzuM2KlKZSNcv7yQ/
         EMEFhlGfK0XPFMZI/fOdRTkuk6bZhCfGG2HV1iGgyq8vRy6Eirdj2x4SGYE7Sryxv/Nc
         8RRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mg2W9f9guObOQ3nCr3SRnmWfaXFbUbY8UMTcwJAN+3o=;
        b=IehfVIvqDEWV2fMWsJnsJoLOsM6GgF8dkr7FJadoH0TFtgxC4B82aYA7NxqgWU1vZg
         EmThgUsFcI+pz5bdV5A4YeY2omDEf6/q4Xppq5q0HaTuIB409BidhggBeCZkCH85jBO8
         WsI1PwAjMLL3IY59in7D7lPPJMCmw7ICtepc4W1gtCp+NakFSkoOwagwWZPJcxjORf/6
         0xeDdX6dd9QcHuy5pOdqYPJ17Tk5gwlVjNU+r3UTmBlmCqesUmsdPa1U+vVWzb3iW8HB
         yly6GsaZoh6+0oORlnbFRp3ZHfIZurMsrtr/YqdqhumEAcb4EFzqeic/8NExMrrjGpLu
         EpyQ==
X-Gm-Message-State: ACrzQf2IorYgjUSsDETYxpC0LaEck6cVPyCaoFtKI0SYZRQq2xCaZ4+7
        hbYiNBvDYA8pCO3UhhEXmjE=
X-Google-Smtp-Source: AMsMyM4Nv77D56j8XB41KqJxvapYrQJM3bAvOrOMDEeHwMOle9M/kxZkgCwGhU+XBThOosGz1eElkA==
X-Received: by 2002:a62:a50e:0:b0:54b:7915:8ff2 with SMTP id v14-20020a62a50e000000b0054b79158ff2mr1617677pfm.30.1663336207845;
        Fri, 16 Sep 2022 06:50:07 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id i24-20020a17090acf9800b0020071acaecasm1524226pju.42.2022.09.16.06.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 06:50:07 -0700 (PDT)
Date:   Fri, 16 Sep 2022 06:50:03 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     laforge@gnumonks.org
Cc:     linux-kernel@vger.kernel.org, imv4bel@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.or
Subject: [PATCH v2] char: pcmcia: cm4000_cs: Fix use-after-free in cm4000_fops
Message-ID: <20220916135003.GA234913@ubuntu>
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

This is a race condition between the cmm_open() function and the
cm4000_detach() function, which may eventually result in UAF.

So, add a refcount check to cm4000_detach() to free the "dev" structure
after the char device node is close()d.

Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 drivers/char/pcmcia/cm4000_cs.c | 81 +++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 23 deletions(-)

diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index adaec8fd4b16..9e54ad892056 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -55,6 +55,7 @@
 	} while (0)
 
 static DEFINE_MUTEX(cmm_mutex);
+static DEFINE_MUTEX(remove_mutex);
 
 #define	T_1SEC		(HZ)
 #define	T_10MSEC	msecs_to_jiffies(10)
@@ -104,6 +105,8 @@ static int major;		/* major number we get from the kernel */
 
 struct cm4000_dev {
 	struct pcmcia_device *p_dev;
+	struct kref		refcnt;
+	int			removed;
 
 	unsigned char atr[MAX_ATR];
 	unsigned char rbuf[512];
@@ -146,6 +149,9 @@ struct cm4000_dev {
 
 #define	ZERO_DEV(dev)	memset(&((dev)->init), 0, sizeof((dev)->init))
 
+static void stop_monitor(struct cm4000_dev *dev);
+static void cm4000_delete(struct kref *kref);
+
 static struct pcmcia_device *dev_table[CM4000_MAX_DEV];
 static struct class *cmm_class;
 
@@ -416,6 +422,30 @@ static struct card_fixup card_fixups[] = {
 	},
 };
 
+
+static void cm4000_delete(struct kref *kref)
+{
+	struct cm4000_dev *dev = container_of(kref, struct cm4000_dev, refcnt);
+	struct pcmcia_device *link = dev->p_dev;
+	int devno;
+
+	/* find device */
+	for (devno = 0; devno < CM4000_MAX_DEV; devno++)
+		if (dev_table[devno] == link)
+			break;
+	if (devno == CM4000_MAX_DEV)
+		return;
+
+	stop_monitor(dev);
+
+	cm4000_release(link);
+
+	dev_table[devno] = NULL;
+	kfree(dev);
+
+	device_destroy(cmm_class, MKDEV(major, devno));
+}
+
 static void set_cardparameter(struct cm4000_dev *dev)
 {
 	int i;
@@ -1629,21 +1659,30 @@ static int cmm_open(struct inode *inode, struct file *filp)
 	if (minor >= CM4000_MAX_DEV)
 		return -ENODEV;
 
+	mutex_lock(&remove_mutex);
 	mutex_lock(&cmm_mutex);
 	link = dev_table[minor];
 	if (link == NULL || !pcmcia_dev_present(link)) {
-		ret = -ENODEV;
-		goto out;
+		mutex_unlock(&cmm_mutex);
+		mutex_unlock(&remove_mutex);
+		return -ENODEV;
 	}
 
 	if (link->open) {
-		ret = -EBUSY;
-		goto out;
+		mutex_unlock(&cmm_mutex);
+		mutex_unlock(&remove_mutex);
+		return -EBUSY;
 	}
 
 	dev = link->priv;
 	filp->private_data = dev;
 
+	if (dev->removed == 1) {
+		mutex_unlock(&cmm_mutex);
+		mutex_unlock(&remove_mutex);
+		return -ENODEV;
+	}
+
 	DEBUGP(2, dev, "-> cmm_open(device=%d.%d process=%s,%d)\n",
 	      imajor(inode), minor, current->comm, current->pid);
 
@@ -1660,8 +1699,9 @@ static int cmm_open(struct inode *inode, struct file *filp)
 	 * inserted)
 	 */
 	if (filp->f_flags & O_NONBLOCK) {
-		ret = -EAGAIN;
-		goto out;
+		mutex_unlock(&cmm_mutex);
+		mutex_unlock(&remove_mutex);
+		return -EAGAIN;
 	}
 
 	dev->mdelay = T_50MSEC;
@@ -1673,8 +1713,12 @@ static int cmm_open(struct inode *inode, struct file *filp)
 
 	DEBUGP(2, dev, "<- cmm_open\n");
 	ret = stream_open(inode, filp);
-out:
+
+	kref_get(&dev->refcnt);
+
 	mutex_unlock(&cmm_mutex);
+	mutex_unlock(&remove_mutex);
+
 	return ret;
 }
 
@@ -1703,6 +1747,8 @@ static int cmm_close(struct inode *inode, struct file *filp)
 	link->open = 0;		/* only one open per device */
 	wake_up(&dev->devq);	/* socket removed? */
 
+	kref_put(&dev->refcnt, cm4000_delete);
+
 	DEBUGP(2, dev, "cmm_close\n");
 	return 0;
 }
@@ -1808,6 +1854,7 @@ static int cm4000_probe(struct pcmcia_device *link)
 	init_waitqueue_head(&dev->ioq);
 	init_waitqueue_head(&dev->atrq);
 	init_waitqueue_head(&dev->readq);
+	kref_init(&dev->refcnt);
 
 	ret = cm4000_config(link, i);
 	if (ret) {
@@ -1824,23 +1871,11 @@ static int cm4000_probe(struct pcmcia_device *link)
 static void cm4000_detach(struct pcmcia_device *link)
 {
 	struct cm4000_dev *dev = link->priv;
-	int devno;
 
-	/* find device */
-	for (devno = 0; devno < CM4000_MAX_DEV; devno++)
-		if (dev_table[devno] == link)
-			break;
-	if (devno == CM4000_MAX_DEV)
-		return;
-
-	stop_monitor(dev);
-
-	cm4000_release(link);
-
-	dev_table[devno] = NULL;
-	kfree(dev);
-
-	device_destroy(cmm_class, MKDEV(major, devno));
+	mutex_lock(&remove_mutex);
+	kref_put(&dev->refcnt, cm4000_delete);
+	dev->removed = 1;
+	mutex_unlock(&remove_mutex);
 
 	return;
 }
-- 
2.25.1

