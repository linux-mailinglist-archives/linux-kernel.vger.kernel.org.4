Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545065BA633
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 07:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiIPFAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 01:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiIPFAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 01:00:12 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77822D132
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 21:59:34 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h188so19274569pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 21:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=t0avrKIMP0UQaUH/P/OoHzGEYHXZaMR0kwqmmd/PGrw=;
        b=imkqTNF+Yke7W7jY0bHZs9SmVvA4j6gEmyDu61nARhqn2CSaxIm0KLesuxnlhwKDJy
         ABj3IwuWXuKa/2CL0k1pAalQPIajKITl9yi3yZtajsAppKYGDDrAW9k7gRfejHTSpllc
         f/lQsqjXfPx4mCScgWDs+JRnoG7UUiU1WIF1KFdyh1JID5U48dYAmytoVEV1ZfIQbilL
         fO7ngeyWyuv5k9b0m2nyn4JF+ukwKFCaatNY+31/KwFbxSSTqDFvgCi0R5E00K16DY60
         cq4Mso5mKNaIi3XO+EWRuMZ7f8lqr77a8qWCjKQLhnpU+UKKaGL++kUNfnkOxlDmTWXQ
         SsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=t0avrKIMP0UQaUH/P/OoHzGEYHXZaMR0kwqmmd/PGrw=;
        b=Yesnb3hL7RDaMU6hc2Vsiw2QN1UjMlFDU6Emr4tleaEuAWtakhwl+0CsUtwfBSyDdO
         Cv1tYRR2fCP5ZRMhpEBI0ipPgqI0TiuK6YFZjg0sQYPkvcb2YBMplyUtJy+J1VuJRPcb
         nKDDO0es6M5eDyMbfCQlgWSjAJYfDqN8FbPtfetfo3JZrK3Ui9UjNT2AmpVRdkb9+8rb
         1Jo0WdznrmBHQnA0czRl9GjX7q6CYPB+atXI+4rvxDJD+Ampjn5VW2+UsufIULqh8wDo
         JGIPec8U3j/5x0QzBlLnGcER8umnZSZmbFom7tU6ecVXG6v5EDJsih8s0QD/JdZxoBXl
         Pj0Q==
X-Gm-Message-State: ACrzQf1YhRoFosZotIDSa+DVYqXB4PlNt8ES905IJkQh2NazfarfEZUX
        lcgkXpMLqANIgMtf2pK8XZvyNZJ5pao=
X-Google-Smtp-Source: AMsMyM5u93dSNsfVZsbYAtR/44h2kS4kcpQ1ikDFS3USbfrXomX4+HHjHreQM742zef/tmKDch8bdw==
X-Received: by 2002:a05:6a00:8c8:b0:52c:887d:fa25 with SMTP id s8-20020a056a0008c800b0052c887dfa25mr2965286pfu.86.1663304373635;
        Thu, 15 Sep 2022 21:59:33 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id f16-20020aa79d90000000b005403b8f4bacsm13261160pfq.137.2022.09.15.21.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 21:59:33 -0700 (PDT)
Date:   Thu, 15 Sep 2022 21:59:29 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     laforge@gnumonks.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH] char: pcmcia: cm4000_cs: Fix use-after-free in cm4000_fops
Message-ID: <20220916045929.GA188153@ubuntu>
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
 drivers/char/pcmcia/cm4000_cs.c | 73 ++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 23 deletions(-)

diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index adaec8fd4b16..3cb0342189d3 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -104,6 +104,8 @@ static int major;		/* major number we get from the kernel */
 
 struct cm4000_dev {
 	struct pcmcia_device *p_dev;
+	struct mutex		lock;
+	struct kref		refcnt;
 
 	unsigned char atr[MAX_ATR];
 	unsigned char rbuf[512];
@@ -146,6 +148,9 @@ struct cm4000_dev {
 
 #define	ZERO_DEV(dev)	memset(&((dev)->init), 0, sizeof((dev)->init))
 
+static void stop_monitor(struct cm4000_dev *dev);
+static void cm4000_delete(struct kref *kref);
+
 static struct pcmcia_device *dev_table[CM4000_MAX_DEV];
 static struct class *cmm_class;
 
@@ -416,6 +421,30 @@ static struct card_fixup card_fixups[] = {
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
@@ -1632,16 +1661,18 @@ static int cmm_open(struct inode *inode, struct file *filp)
 	mutex_lock(&cmm_mutex);
 	link = dev_table[minor];
 	if (link == NULL || !pcmcia_dev_present(link)) {
-		ret = -ENODEV;
-		goto out;
+		mutex_unlock(&cmm_mutex);
+		return -ENODEV;
 	}
 
 	if (link->open) {
-		ret = -EBUSY;
-		goto out;
+		mutex_unlock(&cmm_mutex);
+		return -EBUSY;
 	}
 
 	dev = link->priv;
+	mutex_lock(&dev->lock);
+
 	filp->private_data = dev;
 
 	DEBUGP(2, dev, "-> cmm_open(device=%d.%d process=%s,%d)\n",
@@ -1660,8 +1691,9 @@ static int cmm_open(struct inode *inode, struct file *filp)
 	 * inserted)
 	 */
 	if (filp->f_flags & O_NONBLOCK) {
-		ret = -EAGAIN;
-		goto out;
+		mutex_unlock(&cmm_mutex);
+		mutex_unlock(&dev->lock);
+		return -EAGAIN;
 	}
 
 	dev->mdelay = T_50MSEC;
@@ -1673,8 +1705,12 @@ static int cmm_open(struct inode *inode, struct file *filp)
 
 	DEBUGP(2, dev, "<- cmm_open\n");
 	ret = stream_open(inode, filp);
-out:
+
+	kref_get(&dev->refcnt);
+
 	mutex_unlock(&cmm_mutex);
+	mutex_unlock(&dev->lock);
+
 	return ret;
 }
 
@@ -1703,6 +1739,8 @@ static int cmm_close(struct inode *inode, struct file *filp)
 	link->open = 0;		/* only one open per device */
 	wake_up(&dev->devq);	/* socket removed? */
 
+	kref_put(&dev->refcnt, cm4000_delete);
+
 	DEBUGP(2, dev, "cmm_close\n");
 	return 0;
 }
@@ -1808,6 +1846,8 @@ static int cm4000_probe(struct pcmcia_device *link)
 	init_waitqueue_head(&dev->ioq);
 	init_waitqueue_head(&dev->atrq);
 	init_waitqueue_head(&dev->readq);
+	kref_init(&dev->refcnt);
+	mutex_init(&dev->lock);
 
 	ret = cm4000_config(link, i);
 	if (ret) {
@@ -1824,23 +1864,10 @@ static int cm4000_probe(struct pcmcia_device *link)
 static void cm4000_detach(struct pcmcia_device *link)
 {
 	struct cm4000_dev *dev = link->priv;
-	int devno;
-
-	/* find device */
-	for (devno = 0; devno < CM4000_MAX_DEV; devno++)
-		if (dev_table[devno] == link)
-			break;
-	if (devno == CM4000_MAX_DEV)
-		return;
-
-	stop_monitor(dev);
 
-	cm4000_release(link);
-
-	dev_table[devno] = NULL;
-	kfree(dev);
-
-	device_destroy(cmm_class, MKDEV(major, devno));
+	mutex_lock(&dev->lock);
+	kref_put(&dev->refcnt, cm4000_delete);
+	mutex_unlock(&dev->lock);
 
 	return;
 }
-- 
2.25.1

